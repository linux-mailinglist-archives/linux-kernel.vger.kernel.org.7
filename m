Return-Path: <linux-kernel+bounces-816251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0739B5718C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7660B189CFCF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 07:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA422D595F;
	Mon, 15 Sep 2025 07:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R9rv6Hlx"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A902D1F64;
	Mon, 15 Sep 2025 07:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757921588; cv=none; b=NGetuyOz+Q9eew4L0/uO0FNcNQr7g192RsEfr9EyhN+ZtbG5IlZkpgebNJNmAZoKhYSAV4s1X3wlxFz6kKo1OOo5b13gTd0ZiVjexkRPpuuQMe2s9KynlHbNCEJ7M5+mbBKbWy1VYBiyINzq3r8n/ZaU0PCYg92XiWsZMfggldY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757921588; c=relaxed/simple;
	bh=fHroif/Rcf1+bxF8DLTMGe6qH//8Xo3PD6EdUUTEhbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDxYZp6gtTmdtCOxxQj0Jk+xMEsiTd/QKpgxXyIT2FdQex5nrpTH5WfgyzI8rE9rIhzP8HZEFI5ndn5hptt56O5dazwG7gINA4zwZPXTcJUUMLK8w0DIwRuOaWZ3TzuA9gud0lgpAfemYQSUChMsoRB4iD1+B4B6h7QwqA0ghCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R9rv6Hlx; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=d9UgDtrFC9XqmTnghjjGbksrbW8rjDSGwURli0Q8mjg=; b=R9rv6HlxMpX0YxymnCN6gZHtCo
	j8mYQmR73hQVsyXSoeUYffJhLonSwDhnymDLtPuFsaOnF3I6BKpkbZNLVXQlEeY23SmDTfdKB574M
	3N25hXlcUOeq9vmaXjbeqRVBm8Yw5d6n1riqJC0sSaAFW+SpFVganv4yHnKofIP4Hpf3RSeFnK3M4
	8M2J/ZRqu3XiSCiI9Txa+ASjK/z7TfOeBG2XrjlrMRcti4CdA9cQl9gxapyru9W3zIIridMD/RsDa
	tFlif3e/FdiS29deyR+W35HGjz9AQ3DHP07qn8eWbtjL/r+XzK0DMy8zKAHt1hxmm2OEy9bug0b6+
	ClfwcHJA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy3hf-00000006tgF-06u9;
	Mon, 15 Sep 2025 07:32:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B69D6300212; Mon, 15 Sep 2025 09:32:45 +0200 (CEST)
Date: Mon, 15 Sep 2025 09:32:45 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: kernel test robot <lkp@intel.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org, Alice Ryhl <aliceryhl@google.com>,
	Benno Lossin <lossin@kernel.org>,
	Elle Rhumsaa <elle@weathered-steel.dev>
Subject: Re: [tip:locking/core 1/13] error[E0425]: cannot find function
 `atomic_add` in crate `bindings`
Message-ID: <20250915073245.GQ3419281@noisy.programming.kicks-ass.net>
References: <202509141437.5iiM1sOF-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202509141437.5iiM1sOF-lkp@intel.com>

On Sun, Sep 14, 2025 at 02:10:26PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
> head:   502ae97746ab6d7b7b48d54b6a85a11815f390d0
> commit: eb57133305f61b612252382d0c1478bba7f57b67 [1/13] rust: sync: Add basic atomic operation mapping framework
> config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20250914/202509141437.5iiM1sOF-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250914/202509141437.5iiM1sOF-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202509141437.5iiM1sOF-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> error[E0425]: cannot find function `atomic_read_acquire` in crate `bindings`
>    --> rust/kernel/sync/atomic/internal.rs:124:37
>    |
>    124 |                   $unsafe { bindings::[< $ctype _ $func >]($($c_arg,)*) }
>    |                                       ^^^^^^^^^^^^^^^^^^^^ not found in `bindings`
>    ...
>    201 | / declare_and_impl_atomic_methods!(
>    202 | |     /// Basic atomic operations
>    203 | |     pub trait AtomicBasicOps {
>    204 | |         /// Atomic read (load).
>    ...   |
>    216 | | );
>    | |_- in this macro invocation
>    |
>    = note: this error originates in the macro `impl_atomic_method` which comes from the expansion of the macro `declare_and_impl_atomic_methods` (in Nightly builds, run with -Z macro-backtrace for more info)


Boqun, did I mess things up? I can rebase this tree, but I've no real
clue with this rust stuff.


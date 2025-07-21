Return-Path: <linux-kernel+bounces-739704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E491B0C9E1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 19:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DDFD5418EF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 17:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A622E093F;
	Mon, 21 Jul 2025 17:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="USneVtSK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8797D1F8690
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 17:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753119677; cv=none; b=K3WMP6HrqWgM6I7fcqE5v6bLvw18HBD9K4rArRxXxud/8T6oBtLCjukj2gTaJfMoDlB1RZYGRyQW9hf+vIr/ghg0dj7HYFj/MC0OuHG7iP2JZntg7iz4NGjVofYYIFm0ZpoMp1Qcn2/k1P91spUPtJZNg0KRtwVc0FV0cxPjBPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753119677; c=relaxed/simple;
	bh=NCu7VylJ2AyC5tSKtJPZgRma6ptCGNJiw6Or78NnnoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SNhI/ctKToeHk66ANPXCwSLBkg2ouIsEv0lF/F85Xi2/oNi5R2Lw/CJ00UjXYXPR9HeuNU5oCzKrzo7EknWIXDw2V/PawLYW4C/aymPLiUR9DF+0A/KtlvuPQdXuPVgEkhhuExs1US/dYv6+1aRe6LeupTxEhWyLidqb9ff5CXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=USneVtSK; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753119677; x=1784655677;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NCu7VylJ2AyC5tSKtJPZgRma6ptCGNJiw6Or78NnnoQ=;
  b=USneVtSKV6iEUyruGEb4CN8pkZGIvACdAdGrLu2HLezkkVSLIb00ZbHY
   88snja212qyNYfQfhwfgAoxxvPC1IXXnUel8aeR15xAST1vIVAZ4n43Aw
   JHO8Ptt8q5jKXu7iDNF1hLlpdyRn6X05aL40k6WOFOSkZyNZdWNBEOPA0
   ifW4IS4A5K7E57UGzS9mbYi7Kcs3lpd1gwtUGOyB6Wyt7wEBVZyqqyDj7
   l6VnxfSQSwXVfH+cuEVMnOpcFd9b+hiPNsYqsWovO+46O0CefSrTP0yp6
   Hjv82Ta+NZiduzml1exZWHsKuIImTWFMBv1OwEU2kte0ftCTWEtRlEiN3
   w==;
X-CSE-ConnectionGUID: w5M2V8kTThKWHvUIZOu99w==
X-CSE-MsgGUID: hr5GVOO5S4ylBy9FMlcnxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="77885325"
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; 
   d="scan'208";a="77885325"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 10:41:17 -0700
X-CSE-ConnectionGUID: biASPzIOQRKUBTPtUyCXfg==
X-CSE-MsgGUID: B12N+XKLRI6tsu74SjQRtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; 
   d="scan'208";a="189852797"
Received: from jdoman-mobl3.amr.corp.intel.com (HELO [10.125.108.89]) ([10.125.108.89])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 10:41:15 -0700
Message-ID: <885a517e-fe3b-436a-accf-9d8c6b991aee@intel.com>
Date: Mon, 21 Jul 2025 10:41:14 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/4] rseq: Make rseq work with protection keys
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Dmitry Vyukov <dvyukov@google.com>, dave.hansen@linux.intel.com
Cc: "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
 =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>,
 peterz@infradead.org, boqun.feng@gmail.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, hpa@zytor.com, aruna.ramakrishna@oracle.com,
 elver@google.com
References: <cover.1747817128.git.dvyukov@google.com>
 <138c29bd5f5a0a22270c9384ecc721c40b7d8fbd.1747817128.git.dvyukov@google.com>
 <CACT4Y+ZcQV3JWEaeh7BXNwXUsoH6RcVRyG2iNUA+_mrOBOHfNA@mail.gmail.com>
 <CACT4Y+anDdNU9rh1xsDRs7vZRfXbbvjFS3RRBu1zVejrp11Scw@mail.gmail.com>
 <CACT4Y+b0cdGZwqmZSikxam+ASp9LXMuT9f8iifnmNed+PjamVg@mail.gmail.com>
 <6e737bd5-1167-4cc8-96c3-abc3d3598d2d@efficios.com>
Content-Language: en-US
From: Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <6e737bd5-1167-4cc8-96c3-abc3d3598d2d@efficios.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/21/25 06:25, Mathieu Desnoyers wrote:
> This series looks OK from my perspective. I think the last piece that
> was missing was to get a review from Dave Hansen.
> 
> Dave ?

It looks fine to me. I think the best thing is if you folks send it in
as an rseq fix. I'm OK with the x86 bits. For the series:

Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>


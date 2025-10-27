Return-Path: <linux-kernel+bounces-871783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E32C0E5B8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CF9A4237D1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E153090F1;
	Mon, 27 Oct 2025 14:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ja2rSZEp"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59E021FF55;
	Mon, 27 Oct 2025 14:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761574047; cv=none; b=aYbKFv6l1PfyvKFyU2X4jZly+BmVmve/a1HT7lYCN5HmWb59iBp90Ej7rr/E+0UM8qVIDR5Yr9ER3ih4SGor4BB2bbAkiuroHhLAuXls3iEvlwRdAYC8xVYjIFW+exyZPWMAhKq4PuWzYQF3mf9xan93531SGgnxBzl0P9mvWdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761574047; c=relaxed/simple;
	bh=oSL7dgBDstWnLNkeZRZkPTSyw4nXjPTPkhtJJUa2eCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c7v+kwOdcMoAObt36sQmO4QeJyBcJ/y8L7GN0TWaWWVHeVjUyt8cmjvirbtVlu1MgVNlKLSOBmOnf3+FXDyxdaBiFuURP0knqTL4EXmmqySdt/sp+DWUxTk4/j5BwJHPsTI6mbppRgbTPr1HOQxojzKu4j1/RLgid8aAWEX2lVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ja2rSZEp; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=N4Og9mov2FDjtYybh3IV8xEfzkTxzBYo7UxLIjDPA/k=; b=Ja2rSZEpg6bcDVN3DHz5pYADu0
	YB3JlHYIvSXlVHvf+CBk7/GR8OjvP+Dg1TSReLE8p4sYO/jWLu5x6GCok+YnQ+BkASi8Ex1QhEOZV
	w+lmSqkD0QJK/DYE0Ry5Y3bSFJpHExFBvNa1mA9b08AATJYzgLxYhSJng/b/ejdMbNGIlgeMg6yoc
	GUt3Osnl0dIoquhI4y7FrZGfOD79OBz2vGQ17JvyB+NfnSRyqutB6ycCLFpjsb95tKSfu2I3BMKPv
	D55PU8E+3Ql1vVXwjGH/+C97KO5CM7Xp/j7BMp3Csyo6396eIwrxo4t3ywD89jy91VGF1hR4kM5C8
	ajvcm4HQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDNsU-00000003E4M-1Uhh;
	Mon, 27 Oct 2025 14:07:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 708C530049D; Mon, 27 Oct 2025 15:07:18 +0100 (CET)
Date: Mon, 27 Oct 2025 15:07:18 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: kernel test robot <oliver.sang@intel.com>,
	Fernand Sieber <sieberf@amazon.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org,
	aubrey.li@linux.intel.com
Subject: Re: [tip:sched/core] [sched/fair] 79104becf4:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <20251027140718.GT1386988@noisy.programming.kicks-ass.net>
References: <202510211205.1e0f5223-lkp@intel.com>
 <20251021110449.GO3245006@noisy.programming.kicks-ass.net>
 <20251027125453.GY4067720@noisy.programming.kicks-ass.net>
 <3b30e40b-f1fb-4145-b4d9-a9279b9602d8@intel.com>
 <20251027135516.GA3419281@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027135516.GA3419281@noisy.programming.kicks-ass.net>

On Mon, Oct 27, 2025 at 02:55:16PM +0100, Peter Zijlstra wrote:

> > May I know if you are using the kernel config 0day attached?
> > I found that the config 0day attached
> > (https://download.01.org/0day-ci/archive/20251021/202510211205.1e0f5223-lkp@intel.com/config-6.18.0-rc1-00001-g79104becf42b)
> > has
> > CONFIG_IA32_EMULATION=y
> > CONFIG_IA32_EMULATION_DEFAULT_DISABLED=y

Yep, deleting that entry makes it all work. You might want to fix the
robot :-)

> > CONFIG_COMPAT_32=y
> > CONFIG_COMPAT=y
> > 
> > It is suspected that the filesystem provided by lkp is 32bits, might
> > need Oliver's confirm.
> 
> It was certainly meant to be that config -- let be double check that.


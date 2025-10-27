Return-Path: <linux-kernel+bounces-871788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 522ADC0E5EB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D2B8B506648
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E4030C609;
	Mon, 27 Oct 2025 14:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wPj5K8YY"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7BC30C344;
	Mon, 27 Oct 2025 14:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761574205; cv=none; b=pjU11+sRVItpVKRBrehRHeNWej9d2LqOM799CG42cuQO5NXnaiRfHr0Yzptg3TuhTG4GblmAPb9MU7ZB65bR3bpSkG63ILVgyHkFBt3TICDOPunn6siKuDB9X5FrNrIWbOamIMrPY3H7qgV1R40/Nar5ydEgupaMN3aEaLSkWdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761574205; c=relaxed/simple;
	bh=8M7Xa1NhS2SDFCUirEqng7n+UPA6es2GGJdTWa6yVyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLMK6YRmFW1H5dhl+wxGzq78KNJDykCuSiZ9HaGO0GMHgbUlMOk8R0wIYKQxhmfyYWNG2d5fJpPFY4kaaA6h/BqwWaHbRg/+L4gSuNxe+aMqxHPyp05dgDN30e1wSrO5ITDNbp60jOe7QAReKReMP98/xyN0TcKAcGh62kSUhys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wPj5K8YY; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Sl4UP8ZDPXc8plTYm8fO9gCR5Ul7rtGOByjrpyxTfKY=; b=wPj5K8YY0HRrcZ5YNHIXlL5br5
	Tk7M8OXB/JHURLpfq2EHLYcsudWXn1/i8zHOIBtNQAPHxnC86JmajtKq6A5w4KCktvrJRc0qNOxpn
	TL/kl9kt3GDsyX8EbwCmqQ25gd6VJW1+JLDCP+M+zRpWUdwrqdfyUZgcOA89xFCha65wwET0j7Ur3
	0XQrBRvQ1hBUnjuFB6mhcFBL4OhxvckZYgw6v1F2CIwop1CMh2+4hlcVVMSXyRmSdyCj8yuaPQyJR
	OYbQB05Jh75Gg9uBGm3eihVuZM5ve3K2ogJReTBxF00zg2pMgm5mDVRTlRCtZJFs7omxoY5EnnMQD
	HHYb5+ew==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDNv4-00000003GNM-2DZ2;
	Mon, 27 Oct 2025 14:09:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 43357300323; Mon, 27 Oct 2025 15:09:59 +0100 (CET)
Date: Mon, 27 Oct 2025 15:09:59 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: kernel test robot <oliver.sang@intel.com>,
	Fernand Sieber <sieberf@amazon.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org,
	aubrey.li@linux.intel.com
Subject: Re: [tip:sched/core] [sched/fair] 79104becf4:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <20251027140959.GU1386988@noisy.programming.kicks-ass.net>
References: <202510211205.1e0f5223-lkp@intel.com>
 <20251021110449.GO3245006@noisy.programming.kicks-ass.net>
 <20251027125453.GY4067720@noisy.programming.kicks-ass.net>
 <3b30e40b-f1fb-4145-b4d9-a9279b9602d8@intel.com>
 <20251027135516.GA3419281@noisy.programming.kicks-ass.net>
 <20251027140718.GT1386988@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027140718.GT1386988@noisy.programming.kicks-ass.net>

On Mon, Oct 27, 2025 at 03:07:18PM +0100, Peter Zijlstra wrote:
> On Mon, Oct 27, 2025 at 02:55:16PM +0100, Peter Zijlstra wrote:
> 
> > > May I know if you are using the kernel config 0day attached?
> > > I found that the config 0day attached
> > > (https://download.01.org/0day-ci/archive/20251021/202510211205.1e0f5223-lkp@intel.com/config-6.18.0-rc1-00001-g79104becf42b)
> > > has
> > > CONFIG_IA32_EMULATION=y
> > > CONFIG_IA32_EMULATION_DEFAULT_DISABLED=y
> 
> Yep, deleting that entry makes it all work. 

'work' might be over stating, it boots and starts trinity, which then
promptly (as in a handful of seconds) triggers OOM and dies. Not
actually reproducing the NULL deref I was looking for.


Return-Path: <linux-kernel+bounces-796699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F20B40615
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C51416F371
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06BC2DAFD2;
	Tue,  2 Sep 2025 14:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKwlF3Pp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3462D29C7
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 14:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756821618; cv=none; b=EHKWCdiCjAGwWmi4NevdeUmIGK8CscEy8vrkUd/u5/3zwXKnruS+KwZ/u8FJAzraZNJ11P40MoL/FVTRkcqz1u3en4JP2Zb/ktVRnrLkeBzpmZuCc7mk1nkiyfPQg/Q9tLNNYa8j1AUpudipJ3LhkHmQ2BTPBaZjkKcpMeHqgSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756821618; c=relaxed/simple;
	bh=enNTkmTLcW2nA+tjW0nKhNqSLsSXDZF9qug2+WPotN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWNFQO+IBYrGgDRp4d0b8g0CcAHrNxAjRLQXw7gy/HRUc4x0cGElkYMkcT/R9ii2p8Pc1pP0OPFF3iuYyg7Vf8GxDuwWushOPUy2xJyWHOOFi3KIjcKOJzQEBrTlhUJ9WQySwPL/WlSVg9BLJ8gO6mAr+67J2YaQqiWsLxNNnhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKwlF3Pp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ECF3C4CEED;
	Tue,  2 Sep 2025 14:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756821614;
	bh=enNTkmTLcW2nA+tjW0nKhNqSLsSXDZF9qug2+WPotN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oKwlF3PpkcRWLRj1CQUZyRect/J7m9RiOjsXnRkEMBfHN7zh8QC1M70aAKTT7yLXS
	 fVPtZsbIzH9N/4BW/Q2VUpbb3T/OOdpfQzUdPk5qTNDHYs8hxX2AE5JpOqWZMlgbfg
	 P+jiD+nOKNINm9C582ZYE5JOURf8Rb+WoJODl+p42q/DoJi8Axt/BtmFxRsU4+ygUU
	 G2pH+GiITH7kzXLuN4b1AzP3Dc1l+hT6w/UFFmrZhYS1jfFs+ayvG/5U1ZQZUqXHRK
	 hHsr+KAJv/muKRlMza8X76QnMzuNIyoTvW6PMWw1j8bFtAPdAiFQDfGaat1uTgsKNY
	 ZHRfG3j8F2B2w==
Date: Tue, 2 Sep 2025 16:00:12 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tick: Remove unreasonable detached state set in
 tick_shutdown()
Message-ID: <aLb4bBqWscIt7Wi2@localhost.localdomain>
References: <20250807035954.2412399-1-maobibo@loongson.cn>
 <e08270ec-1151-9119-ba06-bf56352d2029@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e08270ec-1151-9119-ba06-bf56352d2029@loongson.cn>

Le Mon, Aug 11, 2025 at 11:57:20AM +0800, Bibo Mao a écrit :
> Hi,
> 
> Previously tick_shutdown() is called in BP, percpu timer cannot be shutdown
> in BP. Now it is called in AP, percpu timer can be shutdown in AP itself.

Ok, one more reason for not backporting it to stable then.

> 
> And there is another method, like other architectures add hotplug event
> callbak to shutdown percpu timer such as CPUHP_AP_LOONGARCH_TIMER_STARTING.
> 
> Which one do you prefer?

I prefer your fix that works for every clockevents. We want the active clockevent
to be stopped by the time we reach CPUHP_AP_OFFLINE.

If you add a loongarch hotplug callback, it must be for architecture
specifics.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs


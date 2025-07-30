Return-Path: <linux-kernel+bounces-750835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A122B16199
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 15:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E0074E7089
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 13:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEC52D3EE0;
	Wed, 30 Jul 2025 13:34:06 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB887272811;
	Wed, 30 Jul 2025 13:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753882446; cv=none; b=JsZDtTzqwM6vOb9fD4Q23/MiMJMtWxUGz07dSpS1p14e0xHKOlGAY8FkwlHju5RVo9NRYtfE3sHUdcM2PEamvQY2vWb9yfK0yzIYGgd5GysJoG1bAIGBk04CFqxoQeGpmlH2tzxQDQMG67dWngdyEg7BhyD4NmVvr8sLHFGS++Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753882446; c=relaxed/simple;
	bh=fKsJGUj4pmVfcNebem+xXw/HqvSoZrzrbhDvEp44KoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cnj2OExXII8pq2fW+PT8kNoleDJ3meFpBwya9ljfNHkfj6PfxUTO+tr/3JuZOQ1RvvmQ941JcbRkCHeq6OI6MSstMt0WmvRR/9FkvDgP86lIuaw4tkakqoViRzm+kweT/MTVAlWXpM/5KhjABry7scckmQHOleL8C+/kavpZJ1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 56UDXhIe027054;
	Wed, 30 Jul 2025 15:33:43 +0200
Date: Wed, 30 Jul 2025 15:33:43 +0200
From: Willy Tarreau <w@1wt.eu>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: alchark@gmail.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
        heiko@sntech.de, jonas@kwiboo.se, krzk+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, ziyao@disroot.org
Subject: Re: [PATCH v2 1/1] arm64: dts: rockchip: rk3528: Add CPU frequency
 scaling support
Message-ID: <20250730133343.GC26787@1wt.eu>
References: <20250730071145.GA26734@1wt.eu>
 <20250730132026.214754-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730132026.214754-1-amadeus@jmu.edu.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi,

On Wed, Jul 30, 2025 at 09:20:26PM +0800, Chukun Pan wrote:
> Hi,
> 
> > My point is that if you disable cpufreq, the CPU is running at 1.2V, which
> > is even higher. I don't know why it's running at this voltage, maybe as
> > the result of initializing some regulators, but that's what we're getting.
> > So the question about safety of running between 1.13-1.15 resolves to
> > "it's at least safer than running without cpufreq" in the current state.
> >
> > And as I mentioned it's clearly linux and not u-boot that is setting 1.2V,
> > because under u-boot and during kernel selection and image loading, my
> > board is at 0.95V. It's only once the kernel starts to boot that it bumps
> > to 1.2V.
> 
> If opp-table is not configured, kernel will initialize the pwm-regulator
> to maximum microvolts. This can be solved by configuring the pwm-regulator
> in U-Boot (waiting for U-Boot to synchronize the DT of kernel 6.16):
> 
> ```
> &vdd_arm {
> 	regulator-init-microvolt = <953000>;
> };

OK thanks for the explanation, but will be stable at highest frequency, or
do we expect the TF-A or PVTM mechanism to automatically reduce the
frequency enough to keep everything stable ? I'm asking because right now
I'm booting at 2 GHz, and I don't imagine 2 GHz to work fine at 953mV.

Also, if we'd set this to a low enough voltage that it results in throttling
the CPU, it could significantly slow down the boot for no reason. If we
consider that the configured max-microvolt is valid, then better continue
to use it. And if it's not valid, then maybe just fix it without going
full throttle to a lower value either. Just my two cents.

Willy


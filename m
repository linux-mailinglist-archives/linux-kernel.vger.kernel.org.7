Return-Path: <linux-kernel+bounces-733453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C762B074DA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 13:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 235284E6EDA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 11:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD5C2F3C2A;
	Wed, 16 Jul 2025 11:34:01 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C334A1DDC0F;
	Wed, 16 Jul 2025 11:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752665641; cv=none; b=Sui3WuIfjS6nn+/bLgHrpL1SB93ZkAGObVH0AqJT2oSfZfu5ZaHEM/CeD6PIdMsQORxiTP5BrO7YVc5vFglx+EcD8ftTQ+3gxmgXO97u0JM2g+bpE/OwEG+4FkYW6m7bjBXS7Fo7mvap6ne1uYssuyVswfkfuyuVBz3wJYL0Acc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752665641; c=relaxed/simple;
	bh=awABBVIKOIuNLKn63mQp2b5BWohQLkfGP/tBEjJgA7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJn1njdRbGlfogm9mKIs3FEWztJh/Qf7STevSFgRmzWQOrX5znBwYBDHGqAOdmDE7Pk9LfIK1lHPmt/kS+CZIOVWTjgXydZH8p1zBD2RCwroPUD3nNeuqgFllMXy+IQ6b+mW44uPbzLpnRAcgsgQZ0aus8+ZeR5US3HLPAllVso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.48.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id B619C340EC9;
	Wed, 16 Jul 2025 11:33:58 +0000 (UTC)
Date: Wed, 16 Jul 2025 19:33:54 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Hendrik Hammernet <hendrik.hamerlinck@hammernet.be>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	paul.walmsley@sifive.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	palmer@dabbelt.com, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] riscv: dts: spacemit: Add OrangePi RV2 board device
 tree
Message-ID: <20250716113354-GYB546922@gentoo>
References: <20250711183245.256683-1-hendrik.hamerlinck@hammernet.be>
 <20250711183245.256683-3-hendrik.hamerlinck@hammernet.be>
 <20250715102534-GYA542593@gentoo>
 <95125019-8eaa-4242-8e68-78771ce85947@hammernet.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <95125019-8eaa-4242-8e68-78771ce85947@hammernet.be>

Hi Hendrik,

On 11:37 Wed 16 Jul     , Hendrik Hammernet wrote:
> Hello,
> 
> Thank you for the review.
> 
> On 7/15/25 12:25, Yixun Lan wrote:
> > On 20:32 Fri 11 Jul     , Hendrik Hamerlinck wrote:
> >
> >> +/* Copyright (c) 2023 Ky, Inc */
> > Copyright should cover current year, which is 2025..
> > what's "Ky" stand for? Can you give a full description here
> Regarding the original copyright:
> This file was based on a version from the Ky, Inc downstream kernel, which
> itself appears to be adapted from earlier SpacemiT sources (dated 2023).
> The Orange Pi RV2 board, however, was only released in 2025, suggesting
> that the Ky version was likely copied and renamed from earlier generic
> SpacemiT files.
> 
> In reviewing the Ky downstream tree, I also noticed that several files had
> their copyright statements overwritten with "Ky, Inc", while the original
> years (e.g., 2023) remained unchanged. This makes the provenance a bit
> unclear.
> 
> Since I've significantly reworked the file for the actual Orange Pi RV2
> hardware, I’d prefer to attribute it under my own name, unless retaining
> the original "Ky, Inc" is required.
> 
Personally, your approach looks good to me

> Please let me know what would be appropriate here.
> 
I'm no expert on this, unless people want the more strict way..

Personally, the dts file already has correct Copyright info with
the "SPDX-License-Identifier" line, additional info gives credits
for people who really contributed on this..

> >> +	memory@0 {
> >> +		device_type = "memory";
> >> +		reg = <0x0 0x00000000 0x0 0x80000000>;
> >> +	};
> >> +
> >> +	memory@100000000 {
> >> +		device_type = "memory";
> >> +		reg = <0x1 0x00000000 0x0 0x80000000>;
> >> +	};
> >> +
> > for the memory nodes, there are 2/4/8GB variants from the Link [1], and
> > you couldn't cover all of them in one dt
> >
> > besides, I thought bootloader (u-boot) will populate these info, right?
> > so the above nodes isn't really necessary
> >
> You're absolutely right, U-Boot does populate this information correctly
> at runtime. I will remove the memory nodes in the next version.
> 
> I also noticed that the aliases section is missing in this version, which
> means the chosen.stdout-path = "serial0" reference won’t resolve unless
> serial0 = &uart0; is defined. I didn't encounter issues during testing
> because I'm overriding the boot command in my Buildroot setup, but I’ll
> add the proper aliases node in the next version to ensure upstream
> compatibility.
> 
right, please!

-- 
Yixun Lan (dlan)


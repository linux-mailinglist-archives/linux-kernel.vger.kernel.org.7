Return-Path: <linux-kernel+bounces-835340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D435BA6CBC
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 11:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DC097A2F01
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 09:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278B52D193B;
	Sun, 28 Sep 2025 09:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="ImulV0iQ"
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B2B2D12EA;
	Sun, 28 Sep 2025 09:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759050305; cv=none; b=Hyn+J2nh2qjkHp/O2AHlpSvDNPrjt+GfPYhO45hVeSkGG93oAtNMDHrE+UCNYQV5weRaFI4at0n2fNO07x4+CZ6uKlSO13rX2iVLEFJJtBBjxppkDvVXXDGebZxD23RifTtptg5WgYfDozfaMltdBw3v2a8zaY5ZwfXnY0j1hZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759050305; c=relaxed/simple;
	bh=17D7Os5sRAj4H/OLbJKtd+O3Kai5YbvhYWbdpkz1ibw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZqEWIMxcCGHSoADK+kzy+yKTsXeAT8RLuKKDOwYUWz9DGyt7j1n2jQo1vfiPU+KMt90PYi72aa5DKBXJ+aVgZXTCelhEwUhT40allelDlyo+q0puApWziOtQvS3heczsqnVcn0ROYQvH9WFeVzXlw+y42vSUgKEdymHMP2aLgjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=ImulV0iQ; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1759050286;
	bh=A5XNR7o7T9bmHUiLwBsgkJ4yBPqbpMEyQqeUzOe4SXs=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=ImulV0iQU+H0ZIQBDEeFdIqPecf0DTpSX/8p8uH6Wv5bzl1Y8YCsptoNE3xbkyQwU
	 kq5YO47vkrLWjY4SXCs/kbZBb0X68J+9wi7Gc+ekBt5kc6cwH+KggMHmZfOqOx09mk
	 QyH98HvdcSaWB0Y5FXvdYRIqyzvnRi7d5PVH+YEg=
X-QQ-mid: zesmtpgz7t1759050284t3bf2e7e3
X-QQ-Originating-IP: 5XgI999sx5jfiBgGyK3YT6uH/AVd7s0Bwsp5x2yvagA=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 28 Sep 2025 17:04:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5680258146245078500
EX-QQ-RecipientCnt: 15
Date: Sun, 28 Sep 2025 17:04:43 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Yixun Lan <dlan@gentoo.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Troy Mitchell <troy.mitchell@linux.dev>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yangyu Chen <cyy@cyyself.name>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] riscv: dts: spacemit: Add MusePi Pro board device
 tree
Message-ID: <35C0EFBB84167959+aNj6K33fl7utuqcf@kernel.org>
References: <20250928-k1-musepi-pro-dts-v1-0-64d0659dfdbc@linux.spacemit.com>
 <20250928-k1-musepi-pro-dts-v1-2-5efcca0ce3ae@linux.spacemit.com>
 <20250928080003-GYB1344940@gentoo.org>
 <3074FC8521909735+aNjsSWwkd1aH-moh@kernel.org>
 <20250928085010-GYC1344940@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250928085010-GYC1344940@gentoo.org>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: N7s5zE0cAGDvGRdz4NeBScoZVRVwfVtlu6KOeiJd9AK0YvtBEQXblkbL
	dil0UgwnZrEqPwuPAGLaOcbx6sRjDW0MLYf1VE5Xaa7530rqIziv3qwIO69fd3cYrAxFxwK
	K8NDj6zk8T9gOq4d99sy7QUwu+/yEam56IDKA9KI2mXTQ0A9MlM64xRMriIXjfwnEBuo4Ui
	KTpo20HpawdJzN5Vw/25GxiCMiTQAxnoR2GUXllnVX1skkF10E4NGPkbZ0Ga5/c/f7iTjX2
	kx04QslhAsLcurO6EtA+zR/lw8rR+1K8uakV0W++JW6MMv5e8cQgJ/+dUg5SCXH/7Cxs0DC
	Si/gHKrFzZnv8xv5mAjlsGEclpts99n3JXLfPCzEebxsRKIMdjEcvrAs7tmcYiWdjKwncrC
	jEGpQxbCCay9cvyhGVK3vIyf/1V48hButwU/O+V8hvccxPbLhTYg4UNjv6U4ADF16FHLlWq
	q11yRlvbrKMJYvBPe2+c0VOCYnBK++cZZ+PZcfRYRQJfCZ4S1dKbxdTQsPiktkf5qQAdS7p
	DCFTwmD8VfD4JAIyeigU+5raYrympu578O5UJs0Pcb1we1STW/Wv3DW1En8dqABPBnsCAPh
	FRMF9tApxyOO1ncdw6VIz6tz0uGfaWxhiSdEMSL979qii2evdLYNy31EOXSWqgrZiyhVZAu
	T85HBO6OlY1LN1lb2v1hvZ8qMsLNKQs3jrlz5c+0cQxBIU5PgD0CiUO0al9/4T5Awl9qTZW
	SSQQUHya84CXurDiedVrm0xH+y5JHZp22nhnoobN+AkJY4tEmh3YxZkVEKI1cBR20Gb4Kic
	S93DKv7qPKc2KJabvJB81I0eB/Uo3870LE26HBrHJz7q1A73j2PKAloIMuISnoV4HzxdCzP
	GtjJz/XnSbLwtDIqKScOVUs3tIPQBNrHDRtwWmpTAp38iY5oz5i/aGmAziv5YBFLW/fM3nq
	L/dssbR4S2t4067mfzLsmqrSATAiXC/o3nhyhm5aUqTPGTg7nT8lLlG5gzrJNY9/BXO2PVz
	1Q3rwhoScT+LMxbM5o2TdXnauNN+7mIFEuBH4xfrLyo1m8Die4d21kd+i1uhoiF6zFqKwMr
	Fxu3pGGSePTkSDh1UELTISfH2NfxmoGEQ==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

On Sun, Sep 28, 2025 at 04:50:10PM +0800, Yixun Lan wrote:
> Hi Troy,
> 
> On 16:05 Sun 28 Sep     , Troy Mitchell wrote:
> > On Sun, Sep 28, 2025 at 04:00:03PM +0800, Yixun Lan wrote:
> > > Hi Troy,
> > > 
> > > On 12:16 Sun 28 Sep     , Troy Mitchell wrote:
> > > > From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> > > > 
> > > > Add initial device tree support for the MusePi Pro board [1].
> > > > The board is using the SpacemiT K1/M1 SoC.
> > > > 
> > > > The device tree is adapted from the SpacemiT vendor tree [2].
> > > > 
> > > > This minimal device tree enables booting into a serial console with UART
> > > > output and a blinking LED.
> > > > 
> > > > Link:
> > > > https://developer.spacemit.com/documentation?token=YJtdwnvvViPVcmkoPDpcvwfVnrh&type=pdf [1]
> > > > https://gitee.com/bianbu-linux/linux-6.6/blob/k1-bl-v2.2.y/arch/riscv/boot/dts/spacemit/k1-x_MUSE-Pi-Pro.dts [2]
> > > > 
> > > same as patch 1
> > > > Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> > > > ---
> ..[snip]
> > > 
> > > while you are here, I'd suggest to push as many features as possible
> > > instead of this minimal DT, which say - PMU, emmc, ethernet should be ready..
> > > (ethernet is in next, should show up at v6.18-rc1)
> > Good idea.
> > I think I should split these into multiple commits, right?
> > Like, PDMA and EMAC should definitely be two separate commits.
> > 
> IMO, not really necessary, but I wouldn't mind either..
Thanks.
Then I will split them to keep clear.

                        - Troy
> 
> -- 
> Yixun Lan (dlan)
> 


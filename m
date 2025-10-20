Return-Path: <linux-kernel+bounces-859956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D22BEF09C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 03:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9A081898D8A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 01:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47661DF97F;
	Mon, 20 Oct 2025 01:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="SZYbAUZR"
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F9A1ACED7;
	Mon, 20 Oct 2025 01:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760925292; cv=none; b=picrn7C9j25XaYkHRORmpgERbzzFQ7a8EYnc7r5J5Tr09M1qc4ILpQLNa6if/YdFMhT12FXszjReIXJDoF+cDqNHQ+lCbk16V7TtXRvt67I6GaEK5VhxMaLwbbal/u6DexXljU7kMyF9scdSrNdUV5DhKxlrOYE+0Mb4S6egoG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760925292; c=relaxed/simple;
	bh=E5CFjS+FLJA9VAM8OWnJP7UELXzDJdDIiwbZOT3J7Wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DNi33aSBUWtKovw7JPBrjt0ApYJlL/+tQQMzEFnONqXqsw3KXNhArYscT211aYcuoOv514Kz9gu6Kyk/6dwyTXhYhle3OPnzYbbDplui0C7CXItwygi57FhVTIdTmSk1kS+YBK+1BZzwHlGXkXNtZPH0EHOYqQcNs6mQ7S0Bd8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=SZYbAUZR; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1760925264;
	bh=PHQXMd97MnTG8yBwsciGWWANd35WJk6gSCdTScCji0w=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=SZYbAUZRtq9uVOviAY+7VAksF9YNpI0dI83cJ2Z7iElrK9Qk6VPmfzcVO11IKKFAi
	 hJqbtoLRdvb0XDnQ8AdWDYJWHT6E2M9zmVQyEf6ttIjvo7WDRkjBOrBQzcKjfOD0or
	 7HPAUW1wrJUGzp38uNzb2Pd5BMhl90b5Ru1f9NPM=
X-QQ-mid: esmtpgz15t1760925263t112ed490
X-QQ-Originating-IP: ZuqEQVrvPyjcqO5ccy9yBkk58y5T6FF/58EnwbXksTs=
Received: from = ( [14.123.254.135])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 20 Oct 2025 09:54:21 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8184163125021412626
EX-QQ-RecipientCnt: 15
Date: Mon, 20 Oct 2025 09:54:21 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Yixun Lan <dlan@gentoo.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yangyu Chen <cyy@cyyself.name>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: riscv: spacemit: add MusePi Pro board
Message-ID: <D20EEBFFFF06649D+aPWWTSN4LByos8Qb@kernel.org>
References: <20251017-k1-musepi-pro-dts-v3-0-40b05491699f@linux.spacemit.com>
 <20251017-k1-musepi-pro-dts-v3-1-40b05491699f@linux.spacemit.com>
 <20251020014132-GYE1506524@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020014132-GYE1506524@gentoo.org>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NO1BRaLNHOi7r4KHy/fSB6wYSb7WbPkPrr2VFuY2cTbDoQiJW5I9DcUJ
	sKyBsGJb/1KRtzPRKpCK9QZ6HBhXaIJfJJi4tZD+F7W6sT6aQFTDR5sXr56PepB0gp+HlIZ
	bgNFUMKj+p25g4iUntANuKUr3cQQC7jGFne7AyoDEWvY/MkG73a9k/5y4vqjx81dKodHCws
	TT3+of4620rMnyFrYm9aNgnWKUp+HjI22/S4qmdZxs01QBBGUPgCZFQPkcv88g2UGp2bf7X
	RscymWxWfzNzcK6XfzicN1/GBqzId7YGsIPYjxgaqzlVC8JEDUkRczV6IWWacN1Bp65PyND
	spp8iNq68Z4rTDSHdkvXLXGDd9/va/qjR06Z9CFfjcBf1EkOFs3ah0n58fJxNr5z5jYC3PB
	fq3zBJiEnLKHa93zh61rp9R9aiNRosewtimvSSt3zRn6jVrXSMJe6V5XWAc0s/WhSYHHqHp
	84bOo9tDp3upQ68MkLSyQ936XBjDkI0KvPV8guGBzlq9mnAjr0aYfHCngoWpfqtcydsT1f6
	knwLx12Gn8ZAmXdSskMJO7ZTxlXaT0BWgAOotIEyXj18fDrg4FYzGa/8KNkJrICkw+rywiR
	K6fWMesYePedOP+ltJz6nMBLeAupBYSPmrRX/E2/JvE1hLrUD59P6tlsuSM63Z6I3EYXFPZ
	xfHUjUE6ITWLFRa/93o/D7rwD4hFuXmxMtDGr5cuCUPcqeomHtVE7R55ZUGxO7iVBEmFFwV
	A64h9pceHKYdp+kXpQ78fWcf8feGi4EP1nzGviuXL2XgAZ+f0WYy4Ijl2vSEXjH8yxuEne7
	Fcq4p1tn5cepVUQRx7cLUHAMtOowLzdV1U02L9yldZAWZqHjOPw6dLxyxGzEQvgvtHfGLek
	yhfYbEWxxiJR/Qc7Ufjb/qzwO4Eg0/jjRYs2hmsPPOygnW79nHl2IUoOqGihldSTaoyaNZS
	oWrIg93PeJIYLvVE9vLsQXA8YruagO28Y0VERoL5t2HBqxa3EpYZnkcP7o5vEU6Kh2RKhpp
	dJUf2dXVZbvSX1r4oPA3z60gYyru4mJFHHcOPIX3AV4d7my5BX
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

On Mon, Oct 20, 2025 at 09:41:32AM +0800, Yixun Lan wrote:
> Hi Troy,
> 
> On 13:52 Fri 17 Oct     , Troy Mitchell wrote:
> > Document the compatible string for the MusePi Pro [1]. It is a 1.8-inch
> > single board computer based on the SpacemiT K1/M1 RISC-V SoC [2].
> > 
> > Here's a refined list of its core features for consideration:
> >   - SoC: SpacemiT M1/K1, 8-core 64-bit RISC-V with 2.0 TOPS AI power.
> ..
> >          This suggests potential for light AI/ML workloads on-device.
> drop these additional marketing info, just give neutral technical description
> >   - Memory: LPDDR4X @ 2400MT/s, available in 8GB & 16GB options.
> 
> ..
> >             Sufficient for various workloads.
> ditto
> >   - Storage: Onboard eMMC 5.1 (64GB/128GB options). M.2 M-Key for NVMe
> >              SSD (2230 size), and a microSD slot (UHS-II) for expansion.
> ..
> >              Good variety for boot and data.
> ditto
> >   - Display: HDMI 1.4 (1080P@60Hz) and 2-lane MIPI DSI FPC (1080P@60Hz).
> ..
> >              Standard display options.
> ditto, please check more bellow yourself..
> 
> >   - Connectivity: Onboard Wi-Fi 6 & Bluetooth 5.2. A single Gigabit
> >                   Ethernet port (RJ45). Given the stated markets,
> >                   this should cover basic networking.
> >   - USB: 4x USB 3.0 Type-A (host) and 1x USB 2.0 Type-C (device/OTG).
> >          Decent host capabilities.
> >   - Expansion: Full-size miniPCIe slot for assorted modules
> >                (4G/5G, wireless etc.). A second M.2 M-Key (2230) for more
> >                general PCIe devices (SSD, PCIe-to-SATA, comm boards).
> >   - GPIO: Standard 40-pin GPIO interface, as expected for an SBC.
> >   - MIPI: Includes 1x 4-lane MIPI CSI FPC and 2x MIPI DSI FPC interfaces
> >           for cameras and displays.
> >   - Clock: Onboard RTC with battery support.
> > 
> > Link: https://developer.spacemit.com/documentation?token=YJtdwnvvViPVcmkoPDpcvwfVnrh&type=pdf [1]
> > Link: https://www.spacemit.com/en/key-stone-k1 [2]
> > 
> no blank line here

Thanks, I'll fix them in the next version.

                        - Troy


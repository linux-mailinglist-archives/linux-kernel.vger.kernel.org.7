Return-Path: <linux-kernel+bounces-851646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CA0BD6F61
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 03:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B86BA19A21B5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 01:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B66E27144E;
	Tue, 14 Oct 2025 01:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="Kg8YFhBR"
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A05199949;
	Tue, 14 Oct 2025 01:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760404530; cv=none; b=s2fx4FI7nBgkMc0227BmA22SMz5/BXrWFMiGVyTkr+sTYptn2acWGGewtbQrb1UHFQ3SFYRVXFcq6DrQQdKiVwB/8Du4gu25dESXRKBe/JaDRBLDcpLggZM9tysHiYiKy3UZ8tXnvOslGZLSlWk3FnZZm2yfE+eDNOdhPdxRLOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760404530; c=relaxed/simple;
	bh=ly90muq8Cu7cNAfo5LyDFAKK8zB6SZmBgl/e3Gqtgzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWX22ou+psjyb6ukbjJCOZGPlBQVsw0W5pCVr0GRN/HJw+TQxvVBT18NJx8pbhtjWScobI3j0ewZJh/UeFIiF5jDCXVbmEKn1OED/UIT2JwTFJMT153MEJPACE1PAe5DAwmoTeYpK0uFdzmf+W1v5PBf8mvaXmGnQ0c4K/WJKcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=Kg8YFhBR; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1760404505;
	bh=yPaqLTFJBou/8d1hMyxh74PBxgkDsYMEzO+87OROHB0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=Kg8YFhBRHXfSRquwf8U7lvE+E3jI/rUn5HmCczL6YSsSF/RJcsFe0sDlQpT75v9qe
	 CMa96qD7xKuFqQpgbURy1N9i5J2p+rrb4nKvFjd4sDqkFKsOA4kPci4jQJ2bm7xT4B
	 H7fHC/t3+ZAAN1CxgsbBhCZXQCxEONve2QZwxEfc=
X-QQ-mid: esmtpgz13t1760404499t2e911499
X-QQ-Originating-IP: o0PzaMQ5hTsLiEQfnYn0/i0z9Av6u2RRMSRj69aXyEU=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 14 Oct 2025 09:14:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1259685802699772283
EX-QQ-RecipientCnt: 16
Date: Tue, 14 Oct 2025 09:14:57 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Mark Brown <broonie@kernel.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jinmei Wei <weijinmei@linux.spacemit.com>
Subject: Re: [PATCH v4 2/2] ASoC: spacemit: add i2s support for K1 SoC
Message-ID: <775044E19528DA5A+aO2kEerOWeY8ad0h@kernel.org>
References: <20250921-k1-i2s-v4-0-4f819f50e468@linux.spacemit.com>
 <20250921-k1-i2s-v4-2-4f819f50e468@linux.spacemit.com>
 <d1d965c4-f0f4-4b09-b5c3-5925d5f7ce1b@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d1d965c4-f0f4-4b09-b5c3-5925d5f7ce1b@sirena.org.uk>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: NpfbsqbTlzxUWFfAYilv0/7Nw/jpI0bAV31+tuTsErHIOqfmS92dpfpz
	O4WxUbsJjW0VPP4/OyIDFBG2ZdP3B909pfP2/fcf6IjN84SHJaKxhYqLlXyghDI4UfLmQBn
	BzBca3Bve4vEbQgpLSinkE08hXhNfFcapFEfJ2xZuDeHB6iVE+hVjYh0KFhXhEu1n+YL+Jn
	eM2udmHU4VHydZJe43CHZzy/MLTrvpPSpcIEf+if3WXOCCnzKmuQ6xp7EfUIOI9XZe2ibPm
	9Q6AMnfhMuzvRmyX44a9txFzwAHdb1YvQEb2L1Hl3/QRpF8fJ/ePjkIJpY3Gaw+JMWQlXkb
	zTGkrseJpSm+rO+LTAp1oRSALqvexzOY1j36O8TpLupo8upCMNizgmi/pPoCnChLI8ppscb
	S09Sgfvj7MDYsW0PZFsSNOuz5n40C8Sx9y8yz0lMFVLa33k08n0WeF7GQKjrA7eZfTThvDD
	EYC3uGRPnMTGL+aVNb5LLi/cbDMg4oyKumwHiJ8b06lY41Zj60clqsT4qvTynhcCbdEhq6F
	9vc+pZETJeW5z+bQOoO3O+kqhyDvPPOUVWhSwEH3XrS/MGBUSpCONjHXfBOW9zJj4cdCE+P
	dODqf56wooL48K0WchrRIUdDYNGMiDpaf/GukVasbl7pcfCetuwEiXe0O/kZpHWnx7pYnTC
	zQryxsjqP44Tc7PQ7Beq/MU+wfas81nXe1M8dJgOOx3AdlTr0izDTZ1D/tDebtpJRryIwe6
	6boQNOPoGvPUiug//vIAcrQQgard3hk6uL0s/84L9YPfVV81s9mAm9mTmQJA6UNERAGEq+b
	T+w/yKviZZYfrJdIe7DAiSoTcU/UmQ01DdF7pfsxo1hsElTbExRqI3rth5Ucrhx82mI6HzI
	8CxRrn7KThfE/04J8R8Mh8TmKbqc7nytqTU4KSB9xJe07roBj3O8EzKXGcC+LqFIMVPgwj7
	o8p4BrpMCkGp6dNOf9+FdSQLdSHji2kMJy0aoFati5W0ok2Q8qu75iFju86Zvu7MJoo3n7Z
	LCbUVCGNcYISEFJpzeyk92LYtQzGVSRdTjAgDnmUgtMFpQZelB1aDOj31K9Tk1xxbQOeqCW
	w==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

On Mon, Oct 13, 2025 at 01:05:58PM +0100, Mark Brown wrote:
> On Sun, Sep 21, 2025 at 04:52:17PM +0800, Troy Mitchell wrote:
> 
> > +	case SND_SOC_DAIFMT_DSP_A:
> > +	case SND_SOC_DAIFMT_DSP_B:
> > +		snd_pcm_hw_constraint_minmax(substream->runtime,
> > +					     SNDRV_PCM_HW_PARAM_CHANNELS,
> > +					     1, 1);
> > +		snd_pcm_hw_constraint_mask64(substream->runtime,
> > +					     SNDRV_PCM_HW_PARAM_FORMAT,
> > +					     SNDRV_PCM_FMTBIT_S32_LE);
> > +		break;
> 
> The handling for one of these is buggy, DSP A and B are distinct modes
> but throughout the driver they're handled identically AFAICT.
Thanks! Indeed, this bug was introduced in this version.
I’ll fix it and send v5 ASAP.

                            - Troy




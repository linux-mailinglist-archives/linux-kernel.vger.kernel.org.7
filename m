Return-Path: <linux-kernel+bounces-800551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0E7B43922
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 12:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AA8117754F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C882F658E;
	Thu,  4 Sep 2025 10:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tYNoP2qn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="c7U2KoOE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xCFEZysu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ReEa+1d1"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B524C2ECEA6
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 10:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756982814; cv=none; b=ixnrDF48rg9tMIS2yuB6QD53GZKMf4is5ei5HsgHlKq6CNcVCAKkQPwGSDitlLdqnV11v7Ki79bigXeBHnLFvZBVNGWIFhTA7mUaaexnucsq/TvjkOMks1wdW4P5PRW0IAQ8xX4F+SompHXdFl8MOpVLDnJC0/w2RMNmp7/ZCNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756982814; c=relaxed/simple;
	bh=X/b5ldQKTc7ACyM58uW4SbsI5A0s6ciJwclAFiR/EiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GP+G/da1pFCmc/XomOD6GoH8HpSFSC7Zt3AsZslv0pvQNEN6DOYskUZp85hzG3lTay8dDIR61o4NCJ9A6LcztN59LZLuwRjSNFiZ2PwG70azmPpw//1zZs6tjjhIFPWZvgj5T4FTYnlrswUGwOvDLjztoDBEYciwys5i6lM4598=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tYNoP2qn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=c7U2KoOE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xCFEZysu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ReEa+1d1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DB0F834686;
	Thu,  4 Sep 2025 10:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756982810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6b/BmwCHo3DYuUf45IMBYRttwgcEiOlqLTxtBwVnepE=;
	b=tYNoP2qnZiSBl30cMkXM7/dfO96kCHMPVpDcyEmy9w4dWuPVGv0Q+UwppVH3Qoc5NqujDE
	JkUievBTc5YuI8z+GBNZ0LIRvQ9hdAbQgBqrPhGZ6C5I+p8yc9N2AVHokS3CfaONNuMK2W
	1iBuxPvbYUr/Xugowj6rluLFDHBgsW4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756982810;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6b/BmwCHo3DYuUf45IMBYRttwgcEiOlqLTxtBwVnepE=;
	b=c7U2KoOErjsy3w0mCFjHQwE4NKy7dyAxbHmy7a/T75FGQ2bUDRgsZsfpbFEkvcBAdJ4+6M
	HMUiGPrkzkHaO1BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756982809; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6b/BmwCHo3DYuUf45IMBYRttwgcEiOlqLTxtBwVnepE=;
	b=xCFEZysu+ba84tPub0epTpg0jqBQ2T/QV0U4EKlnW5zRHPExlqysts7CEKV9jhJhGOdpbv
	+aP0kcaoZAC5sKZ9FS2jXm2pEXC0U4biVAsjvioZzsTguczPedYFO24SJZKhMQHbjq5N8v
	jHpC80mPAmnAjFix2fm3rwMpUJtRMEU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756982809;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6b/BmwCHo3DYuUf45IMBYRttwgcEiOlqLTxtBwVnepE=;
	b=ReEa+1d15fQxlC+zjJ8/sNG+3py6SgBN3tzxpmAow/ICwl5xhnc5mwKL6VeBfDHvruuDzp
	Q6N+g+mexFEL68Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B542213675;
	Thu,  4 Sep 2025 10:46:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kD0FKRhuuWhBNAAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Thu, 04 Sep 2025 10:46:48 +0000
Message-ID: <50b59b27-cdf9-4af8-b31d-d5ccc68c73fd@suse.de>
Date: Thu, 4 Sep 2025 13:46:48 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: broadcom: rp1: Add USB nodes
To: Andrea della Porta <andrea.porta@suse.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, devicetree@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, iivanov@suse.de, svarbanov@suse.de,
 mbrugger@suse.com, Jonathan Bell <jonathan@raspberrypi.com>,
 Phil Elwell <phil@raspberrypi.com>
References: <4e026a66001da7b4924d75bd7bee158cbb978eed.1756387905.git.andrea.porta@suse.com>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <4e026a66001da7b4924d75bd7bee158cbb978eed.1756387905.git.andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[dt];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -2.80

Hi Andrea,

Thank you for the patch!

On 8/28/25 4:50 PM, Andrea della Porta wrote:
> The RaspberryPi 5 has RP1 chipset containing two USB host controller,
> while presenting two USB 2.0 and two USB 3.0 ports to the outside.
> 
> Add the relevant USB nodes to the devicetree.
> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>  arch/arm64/boot/dts/broadcom/rp1-common.dtsi | 28 ++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/broadcom/rp1-common.dtsi b/arch/arm64/boot/dts/broadcom/rp1-common.dtsi
> index 5002a375eb0b..116617fcb1eb 100644
> --- a/arch/arm64/boot/dts/broadcom/rp1-common.dtsi
> +++ b/arch/arm64/boot/dts/broadcom/rp1-common.dtsi
> @@ -39,4 +39,32 @@ rp1_gpio: pinctrl@400d0000 {
>  			     <1 IRQ_TYPE_LEVEL_HIGH>,
>  			     <2 IRQ_TYPE_LEVEL_HIGH>;
>  	};
> +
> +	rp1_usb0: usb@40200000 {
> +		reg = <0x00 0x40200000  0x0 0x100000>;
> +		compatible = "snps,dwc3";
> +		dr_mode = "host";
> +		interrupts = <31 IRQ_TYPE_EDGE_RISING>;
> +		usb3-lpm-capable;
> +		snps,dis_rxdet_inp3_quirk;
> +		snps,parkmode-disable-ss-quirk;
> +		snps,parkmode-disable-hs-quirk;
> +		snps,tx-max-burst = /bits/ 8 <8>;
> +		snps,tx-thr-num-pkt = /bits/ 8 <2>;
> +		status = "disabled";
> +	};
> +

I'd order the generic properties first and then vendor specific.
Something like this:

rp1_usb0: usb@40200000 {
	compatible = "snps,dwc3";
	reg = <0x00 0x40200000 0x0 0x100000>;
	interrupts = <31 IRQ_TYPE_EDGE_RISING>;
	dr_mode = "host";
        ....
}

> +	rp1_usb1: usb@40300000 {
> +		reg = <0x00 0x40300000  0x0 0x100000>;
> +		compatible = "snps,dwc3";
> +		dr_mode = "host";
> +		interrupts = <36 IRQ_TYPE_EDGE_RISING>;
> +		usb3-lpm-capable;
> +		snps,dis_rxdet_inp3_quirk;
> +		snps,parkmode-disable-ss-quirk;
> +		snps,parkmode-disable-hs-quirk;
> +		snps,tx-max-burst = /bits/ 8 <8>;
> +		snps,tx-thr-num-pkt = /bits/ 8 <2>;
> +		status = "disabled";
> +	};
>  };



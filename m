Return-Path: <linux-kernel+bounces-780293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C2BB2FFF4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C46427B9F54
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0CD26FA77;
	Thu, 21 Aug 2025 16:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hZVY7K6o"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23992DA77A
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 16:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755793443; cv=none; b=Ni3jbeNBIhFoYygz9XYv62SIGdkuirCL0Ks7o7Nm61ZOQcC/GQgwg5ZqVy/1FyXIoUux+bv1S5hJfWe0K6WG7vLHrPzEJHZidXQbRBvHZhko1kIg6ipn9BQp8+Fya7ryxQ4vFd7jlHxsggZq5fbhG+SSuxzu4wDGRuXB4aKRKgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755793443; c=relaxed/simple;
	bh=P1Ng3M/Z/XR+3ggDtcGIpQK3dCBBrzJ4AjNiAjFAASc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hMzlbNMeL+chyWAMJ+j7PlCip2gYYatXa4f/rS/MBYKuJCiqVVWEHTTjUyzZdpuznwFyLdj9pY84Fwi7bHkFQZ9ye63XC6lhubsS7Ldeu0W+IMhBUIpUJ/OTYlib6rcrYRD/WbCeJc+4Jo5pV9W2zzegY3Zw1+VVsV6YST/SSIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hZVY7K6o; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 14D8A4E40B5C;
	Thu, 21 Aug 2025 16:24:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E1B22606AF;
	Thu, 21 Aug 2025 16:23:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 753641C22D0B6;
	Thu, 21 Aug 2025 18:23:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1755793438; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=M9hPN9pLek8IF0I+6c6051btbaPlaupVt0kSjMksl9E=;
	b=hZVY7K6ojOU/EEB23DXOQ9t7qzlwW6bkLJqTMKi2mVtd1GtUUl1BUejOK+xIB4Z91hgtIn
	SgPH80PZaW9YtJZQMnECdXUijVG1jBDCy9MAV9GXrOaEnOA+DDJtuPgvbS25FNuHTS9XdF
	t4Z0eMKcJACXWAF7/y5ZOJqJg7yyzw7Y5+arlecpTfuyn70oue82w06Y8OIryYl3IGD93g
	IbCCney2Usa7F7E3Hyb4NjBgEniK6rhr7dQiQOTU1O6RVpGyAU1OgSkCdux0/HzkfD2ZWl
	dRWHJ88JC+1znMkmuSlFA7gbVLml05m/vKvPcMvLYB1OSjnA7wk105HDE+t6Sg==
Date: Thu, 21 Aug 2025 18:23:54 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Qiang Zhao <qiang.zhao@nxp.com>, Shengjiu Wang
 <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam
 <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v3 2/4] ASoc: fsl: fsl_qmc_audio: Ensure audio channels
 are ordered in TDM bus
Message-ID: <20250821182354.5c3b0344@bootlin.com>
In-Reply-To: <fad43df132900d7001fea34a2ee563d819c74015.1755504428.git.christophe.leroy@csgroup.eu>
References: <cover.1755504428.git.christophe.leroy@csgroup.eu>
 <fad43df132900d7001fea34a2ee563d819c74015.1755504428.git.christophe.leroy@csgroup.eu>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Christophe,

On Mon, 18 Aug 2025 10:20:01 +0200
Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> To reduce complexity of interrupt handling in following patch, ensure
> audio channels are configured in the same order as timeslots on the
> TDM bus. If we need a given ordering of audio sources in the audio
> frame, it is possible to re-order codecs on the TDM bus, no need to
> mix up timeslots in channels.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  sound/soc/fsl/fsl_qmc_audio.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 

Acked-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé


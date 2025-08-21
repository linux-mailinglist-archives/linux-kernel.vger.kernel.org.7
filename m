Return-Path: <linux-kernel+bounces-780292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF1AB2FFF1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E50FAB64EAF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7A52DCF52;
	Thu, 21 Aug 2025 16:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KVCPARWL"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A4C2DC34A
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 16:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755793423; cv=none; b=ZgxOlxFdxoPxXEQgqclMnx76Uvoh76cQehqN5g5FH5Agf+OJ4SMoXw2ZyiYcGD/Uz6XTMBao5bMVEUoNuqr4N6zyY9ZGpXC7JSSECyotVI2WurJtWuCxDeB7LjTaXkWBKUnHIGK83r1X7fEwrNJ3M5YfXBVjZ/GLWntuwMYdsA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755793423; c=relaxed/simple;
	bh=/2U7CKDLiVIW67bDOr9u9BbBflR6LXcwrKNSlKb5RUg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gywti3hQzZsNCxOf+s+GAjVe2PagYmmkvVYJMCkilXvabUdPB/BncfHcFz2Z+IitWon+gAZDXzauLTv59FDKyfJ7Wj/PYl7QTSaF/9+tEkiaNicSGVRfaSskAFym535WZrCGqGHo4VpzEuNIfl+Xl92O0t/+ZmKWOkofSMa8s6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KVCPARWL; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id ECDE2C6B3BD;
	Thu, 21 Aug 2025 16:23:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 83F24606AF;
	Thu, 21 Aug 2025 16:23:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AAA331C22CDE0;
	Thu, 21 Aug 2025 18:23:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1755793415; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=1M5Nb/GMJtc+X2GXJNcDemzZBR8bSjA86XYehPLVfcM=;
	b=KVCPARWLBBak7ha8ttTM+7mSUp1YOMn44fkE8/H8tGUXMy0+0lnJUZKwja2mTiFQWgTOf/
	h5JQRzU7uU0UKzlfsawb+1jIJunssTSjuvp/WuRJI5SGaIR4c+20C+McMOq9F2hwTWA6w4
	1H6K/QEvyZd3/J8WyJqmnQ17TZTioEQXlKTqdVEUH+hrEjAhh6+j/Xrq0idi/N90oJwrLf
	0FsZf1PAbShVXrLvavCglq5Kta5HoiGUZUrVBOZ+WKoLTKrlq3jcXAvC39cZRfF179V4/O
	ZAOVylEgw9reB1RLQo6ww7MB5XnnP+Pf9eDMwEo3HrKQpWESylbdHy9RM9fAYg==
Date: Thu, 21 Aug 2025 18:23:07 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Qiang Zhao <qiang.zhao@nxp.com>, Shengjiu Wang
 <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam
 <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v3 1/4] soc: fsl: qmc: Only set completion interrupt
 when needed
Message-ID: <20250821182307.2f7c8aeb@bootlin.com>
In-Reply-To: <f0c5260651822e8003daf11c7a76921796517152.1755504428.git.christophe.leroy@csgroup.eu>
References: <cover.1755504428.git.christophe.leroy@csgroup.eu>
 <f0c5260651822e8003daf11c7a76921796517152.1755504428.git.christophe.leroy@csgroup.eu>
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

On Mon, 18 Aug 2025 10:20:00 +0200
Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> When no post-completion processing is expected, don't waste time
> handling useless interrupts.
> 
> Only set QMC_BD_[R/T]X_I when a completion function is passed in,
> and perform seamless completion on submit for interruptless buffers.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  drivers/soc/fsl/qe/qmc.c | 44 ++++++++++++++++++++++++++++++----------
>  1 file changed, 33 insertions(+), 11 deletions(-)
> 

Acked-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé


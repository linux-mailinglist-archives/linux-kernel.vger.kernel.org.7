Return-Path: <linux-kernel+bounces-781701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0C2B315A8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05CFAA00AA7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55AF2F546D;
	Fri, 22 Aug 2025 10:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Fj70XLl/"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093C72EB86B
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755859256; cv=none; b=X4+VQVRX1HTkPw365FVWqwjevyhxPCz65+JVlsPJYGhN8i7yOlrWqlu0oS4zq2DY1PRREqGZX1GYL8Zu6/VqCplUodinPcc/oyL0zAuy2rISMIOCa23fxcv7eKKZavSRTonHksCaFDVfL1cPqauGVi4vXuy88VnClhoPy60zJEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755859256; c=relaxed/simple;
	bh=G0UruinHndufRA+yER4xnW9qrYl8zlVXkJmIqfKhlmY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ddK/AZhSXMXaZ19rlKognfGB9vamRhWkGdJYZ8P3O2Z4dLStbNAF1nfRBwaKPAS4DHdcADbqGQ4i65dJH3ct2fniiYQitrFckJm9rS5Wif7RIxTNCWUmBDeIPCgYyptIEsGPz91RyMYgIAybLJPcM/OEw85SfNy6anme4vTG8ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Fj70XLl/; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 44F0D1A0BD3;
	Fri, 22 Aug 2025 10:40:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 15123604AD;
	Fri, 22 Aug 2025 10:40:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 51E271C22D52D;
	Fri, 22 Aug 2025 12:40:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1755859251; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=OW0FggShZPPjAF0w/QGH/DlMClKT+k1ffmqTYWGuus0=;
	b=Fj70XLl/Oa5u4HpofEugIrqq1CWZo0337r2Egj4GHXaFl4Nfp1hIIIXV3PoiWtSVk25/e6
	DqUzwWpmhN4hsl98r0MvzOBLwwx63GgouIdOe9g5pv82zsNwpAJsR46JOJjoAOqk9KtUkl
	mcko2IenY7YG2SmS7l1bv8ar3Kl1Fl4x0U5+pNiMCtQzQKRFfCbj5ZZ4V6o6tAoNdCow4J
	KJZw79GsbrodKX5IuYdqpXAO3adrOMgC3t6GstlFoOx0IGAIeYOy3sxTrqul1IgWrUF5c7
	avF3ElEaVRllKK3I3nruaR24kOdjBO1DJxN3W59GgJY36VVFa+e6vNdb8e7T8w==
Date: Fri, 22 Aug 2025 12:40:36 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Cryolitia PukNgae via B4 Relay
 <devnull+cryolitia.uniontech.com@kernel.org>
Cc: cryolitia@uniontech.com, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, guanwentao@uniontech.com,
 niecheng1@uniontech.com, zhanjun@uniontech.com
Subject: Re: [PATCH] ASoC: codecs: idt821034: fix wrong log in
 idt821034_chip_direction_output()
Message-ID: <20250822124036.2855a5f0@bootlin.com>
In-Reply-To: <20250822-idt821034-v1-1-e2bfffbde56f@uniontech.com>
References: <20250822-idt821034-v1-1-e2bfffbde56f@uniontech.com>
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

Hi Cryolitia,

On Fri, 22 Aug 2025 18:28:33 +0800
Cryolitia PukNgae via B4 Relay <devnull+cryolitia.uniontech.com@kernel.org> wrote:

> From: Cryolitia PukNgae <cryolitia@uniontech.com>
> 
> Change `dir in` to `dir out`
> 
> Suggested-by: Jun Zhan <zhanjun@uniontech.com>
> Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
> ---
>  sound/soc/codecs/idt821034.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/idt821034.c b/sound/soc/codecs/idt821034.c
> index 6738cf21983b0dc58e162cbfaacaedb5edaaa245..a03d4e5e7d144195622ea0cbf6b6c6ba95642aa7 100644
> --- a/sound/soc/codecs/idt821034.c
> +++ b/sound/soc/codecs/idt821034.c
> @@ -1067,7 +1067,7 @@ static int idt821034_chip_direction_output(struct gpio_chip *c, unsigned int off
>  
>  	ret = idt821034_set_slic_conf(idt821034, ch, slic_conf);
>  	if (ret) {
> -		dev_err(&idt821034->spi->dev, "dir in gpio %d (%u, 0x%x) failed (%d)\n",
> +		dev_err(&idt821034->spi->dev, "dir out gpio %d (%u, 0x%x) failed (%d)\n",
>  			offset, ch, mask, ret);
>  	}
>  
> 
> ---
> base-commit: 3957a5720157264dcc41415fbec7c51c4000fc2d
> change-id: 20250822-idt821034-0b5cb86b0c96
> 

Thanks for the patch.

Acked-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé


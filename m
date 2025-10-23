Return-Path: <linux-kernel+bounces-866254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D7421BFF4F1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 697374F44BD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 06:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717CB27A448;
	Thu, 23 Oct 2025 06:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="rTenhLUe"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2882B279324
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761199971; cv=none; b=FvAfrq8q4eItsDLQ4VXTRn0YyKBkXl6tQbgYL+TzHWs7QEMUZMSsFT6M//NXtgjpaq7AY/VdTPZlapV18IIlCsVUtBBlJb1l95TewSQ8Xfa+ftUd9g21q4a0F2s8Gr26z+1ybxithryMFSeCtPrMEjM0o1vHHo+2My5WEoukCUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761199971; c=relaxed/simple;
	bh=0qtpy478yofG/xxh3MDnfPaQpXyLssV/fJeryEkVQ8M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oDelYmfBD1KRpkVzEz7pepd9CKxBxYJYhTl+4MRUVaR5FieKf+uYKT4q5M5AnP2pK/ZJV0DZBmKLX3SEtFSiXYFdfHUTq+Rjtn3kbUxnS4+ibMKURIftBy/uri/+sDg04QtXc5ANQuXCZ7HRrfuXX98EI3nwV70mHcu9e5HYNec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=rTenhLUe; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0D0CA4E41296;
	Thu, 23 Oct 2025 06:12:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BEF65606DE;
	Thu, 23 Oct 2025 06:12:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4F63C102F2448;
	Thu, 23 Oct 2025 08:12:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761199963; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=IDoZQPfJ2uvBwkI3w7inoYDmy42TemZU+nfSiuOSXQI=;
	b=rTenhLUezi4UIBEX6O20SQhq/q3x7G7YgGjWRrWFnckKwcHm3nWV82Xv0xtAqNlunQld68
	brPMSVZna6oe9+wjqXNufdkw9Zn6gdvL/MctlGXJrQdRL0tkFuXooVwaakSY0cDSmXlZyF
	4i/B8v43fANHdgjSxmgKPTYvkFQaCvLPw0KGT6EHPXUI3pJ9VvgwuWJ4rKfyiTXhvfHsvo
	RoRyv9ZiZVmvTm55RS0WBlWOj+Twc4vQCV3vYpi6DxHmqia0SSvDg9I6LiTxJQzdHvY2c1
	RdhSYkUVROwBN3lz9tBnoiBRZHl041VjZGTZ/UjD9wtSem8e2dYhHparKDjOHA==
Date: Thu, 23 Oct 2025 08:12:32 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Bruno Sobreira =?UTF-8?B?RnJhbsOnYQ==?= <brunofrancadevsec@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter
 <jonathanh@nvidia.com>, Gabriel Somlo <gsomlo@gmail.com>, Bjorn Andersson
 <andersson@kernel.org>, Andrew Jeffery <andrew@codeconstruct.com.au>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] soc/tegra: Resolve a spelling error in the
 tegra194-cbb.c
Message-ID: <20251023081232.272d7752@bootlin.com>
In-Reply-To: <20251022174531.1751-1-brunofrancadevsec@gmail.com>
References: <20251022174531.1751-1-brunofrancadevsec@gmail.com>
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

Hi Bruno,

On Wed, 22 Oct 2025 17:45:24 +0000
Bruno Sobreira França <brunofrancadevsec@gmail.com> wrote:

> Hi, this commit resolves a spelling error in the tegra194-cbb.c.
> 
> Signed-off-by: Bruno Sobreira França <brunofrancadevsec@gmail.com>
> ---
> Changes in v2
>   - Really fix the spelling error
> ---
>  drivers/soc/tegra/cbb/tegra194-cbb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/tegra/cbb/tegra194-cbb.c b/drivers/soc/tegra/cbb/tegra194-cbb.c
> index 846b17ffc2f9..e1deda188fdb 100644
> --- a/drivers/soc/tegra/cbb/tegra194-cbb.c
> +++ b/drivers/soc/tegra/cbb/tegra194-cbb.c
> @@ -1836,7 +1836,7 @@ print_errlog1_2(struct seq_file *file, struct tegra194_cbb *cbb,
>  }
>  
>  /*
> - * Print transcation type, error code and description from ErrLog0 for all
> + * Print transaction type, error code and description from ErrLog0 for all
>   * errors. For NOC slave errors, all relevant error info is printed using
>   * ErrLog0 only. But additional information is printed for errors from
>   * APB slaves because for them:

Reviewed-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé


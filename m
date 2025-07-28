Return-Path: <linux-kernel+bounces-748593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68738B14375
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 22:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AA5C17D8E8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 20:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079D5224240;
	Mon, 28 Jul 2025 20:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="ksaXY9nY"
Received: from smtp.smtpout.orange.fr (smtp-79.smtpout.orange.fr [80.12.242.79])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11D6273FE
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 20:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753735436; cv=none; b=UhDdaMVOHYmx3Lu3UzYTihsZjF5rExumAN2AflMKDl1ST/N1iSrCicMwtUiusoWJ/US5ojVyH9CaL54lO2u/nrwPh7ovfNPz2pX+Mc5omf8tGAwPRb8bXmVfdv7wpDC6OCQtxxjN9V7N4wtebJXosZDDbq8Z/KWLH2qLBrAwWeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753735436; c=relaxed/simple;
	bh=3BbfrhRL023bCnoufghKyCfJnh6KCVngknRQkjbRcK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JB76ySGH2/u3VhAEQ5TgKUcB9dwtQeFWNJ58YE2ngsnIYJZ9WoJsammOEPsaEtiIMMhD9BESTruq94dnA70WPHvUqEDvd1N1fd6iHEzXT8wWqcROVkwCX4NEANKsItoZxe6ybnd8TGovVhxwST3Lm9thJ11T9311KAHXtYyF7UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=ksaXY9nY; arc=none smtp.client-ip=80.12.242.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id gUgEuffUwftchgUgEut7YT; Mon, 28 Jul 2025 22:42:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1753735362;
	bh=00a6wxssv4AqtrMurR4jTA4auwI7e+gZE+j7rFmkrX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=ksaXY9nY1sMAnQzsAnflPplvIu2p+VE/zfsQGw6+mm5E46JJ/o/6LGH0cAQrxsUsa
	 V7mJzdIokAXaqEx+aCUnogX1S+NsJRxDIGXb1BsOLTn6K5hNw1hXWyzp6hUKdi+IXX
	 ffiZ0/PecFtIoL3PfcNe6TE78Xvjd5o7Dst+QEwPQcovs8IMb1gtAk4s95uoLpoE1X
	 1REvBB12Sz3Aq/P2x16SGcX/CPpIOZHjS4ZYljx8he5kKL/q1eR8rLvsMSpn7M4dRC
	 hukA8gHW15GQsTzZdKiDp0wRPRsaDf6YQY8zgRAktGrK9bqjmBhNn160CMcTyG/EfV
	 cebo7nplC6z/A==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Mon, 28 Jul 2025 22:42:42 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <a07b9468-67aa-4e22-86af-817bb3295d1b@wanadoo.fr>
Date: Mon, 28 Jul 2025 22:42:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zorro: fix checkpatch error by avoiding assignment in
 if-statement.
To: Dishank Jogi <jogidishank503@gmail.com>, geert@linux-m68k.org
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 darshanrathod475@gmail.com
References: <20250728093412.48065-1-jogidishank503@gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20250728093412.48065-1-jogidishank503@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 28/07/2025 à 11:34, Dishank Jogi a écrit :
> These changes improve code readability and bring the file
> in line with the Linux kernel coding style.
> 
> No functional changes.
> 
> Signed-off-by: Dishank Jogi <jogidishank503@gmail.com>
> ---
>   drivers/zorro/gen-devlist.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/zorro/gen-devlist.c b/drivers/zorro/gen-devlist.c
> index e325c5ce995b..ff4515e02409 100644
> --- a/drivers/zorro/gen-devlist.c
> +++ b/drivers/zorro/gen-devlist.c
> @@ -44,7 +44,8 @@ main(void)
>   
>   	while (fgets(line, sizeof(line)-1, stdin)) {
>   		lino++;
> -		if ((c = strchr(line, '\n')))
> +		c = strchr(line, '\n')

Looks like a trailing ; is missing.

Was this patch compile-tested?

No change is trivial, even if they look so.
Please always compile test your changes.

CJ

> +		if (c)
>   			*c = 0;
>   		if (!line[0] || line[0] == '#')
>   			continue;
> @@ -68,7 +69,8 @@ main(void)
>   					fprintf(devf, "\tPRODUCT(%s,%s,\"", manuf, line+1);
>   					pq(devf, c);
>   					fputs("\")\n", devf);
> -				} else goto err;
> +				} else
> +					goto err;
>   				break;
>   			default:
>   				goto err;



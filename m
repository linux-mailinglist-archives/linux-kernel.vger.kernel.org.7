Return-Path: <linux-kernel+bounces-804572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9541B479EB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 11:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1F81188EC5E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 09:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E7D21D3F0;
	Sun,  7 Sep 2025 09:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SK44rT77"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659AF21D3EA
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 09:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757235604; cv=none; b=YaGBtAPh4Jm9KG/G4d+Hw29iaB1oN00om27myj0KbN1ud+NgWooxu84HjmtNn5ZZuiknoY7Mff8C/irO492VxjLbrmSUFmwBZSH9f7e7TCov/iqBxyYL5cr1cJGPGabcYkbF2WyvIPl+phwiPrzMLsLmAJfqneTR/QspHtXj1s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757235604; c=relaxed/simple;
	bh=UKs/NjLyuYWs45dSLdhshEKoZiao/y6vum0k11HFAzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R7VHYav8hFkHBJ00N1E+3ekPp5enZ0ujFfKkGiHuGq/Qa04kN+idfyRnHcLFV7lAvM0f/7mSN2oGMDEQJ7+mlyyjt90Kq5z9EQUszhouwxfUqtVxDYTAFZcbsit83btl862BnBdqJiFgrbjHr6/3hG0wFeHD0Hq9hM4mgyql5JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SK44rT77; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6228de28242so2456257a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 02:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757235601; x=1757840401; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CmjYA9QRCYykhEbiFXXh+CsSDhFjiffK1T2jpLtF/34=;
        b=SK44rT772mI+5IzDAQjUzC493xw+SnDgI4Ih9RWs3KNaGMCOrXdq5QMCxA9h2i28+0
         cBgz9+PwtV/4+jIDnWd4i3MwQG8VBGRbmKCKGog5ckbJjNKNtyMM2zclfAtjL7O8ReL2
         1QEL4jTqA7Jl0PJtKEj598EOqO2j+JaAK0l3uNofxoK4ngvlLEmpRLQcJJGuNDh/r7hJ
         6dKC4p4GJaLlxhKsSiQvPBB7/H18xRqMHmOMlzfKDHfzFPhoQ06qtcbWMFqCEnnkI/w2
         BpnlHBFC1X6e8hyjVPJ0FHfoNOgRiNX5nJZTE53PyYYZXjwwUgYBGSzQlkpWpisit7Y4
         kJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757235601; x=1757840401;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CmjYA9QRCYykhEbiFXXh+CsSDhFjiffK1T2jpLtF/34=;
        b=sxzSocePiIU9/0mr26vzm2UIWL7hgvTat8Xks/jBGUaHds1cnyFl6xgYHGltGIPYrM
         Yel3vjILospc4nIbhTfJV5T/PZ8YG1dyJYBcwWQNVnJkdo86ZzQ5qLWf6apGK13TYN3a
         vjTh/Tew/pbWeP8Isz5nGbNy5iYEtt/kJZNhsHfNLD23CU7fdUCgCZWaP8A+C+pZkK2F
         xjrgy8NYhUx4eHyFxmlmhcy54uaUkgpX5ME7V12B8l0EGczEf9JTPibGgEB3tTXzQyZG
         GAttJuFbzTNnIsNFUf9mmWUOpVBkJ/GeP8GuLGBj1liC4LLx3wTBLWbXyymrOy3yxOaw
         ULDw==
X-Gm-Message-State: AOJu0YzmajL7tm7sm2rf7QB9B42q1ZTT3ypvFl/mTaPt6QcyOX5RqQWT
	8qiHzZPorKXnZzsvEXcAYQeWICCHGD6mQZQiMzfVDE+YcjZtVlzjjyTziqPu6LKF
X-Gm-Gg: ASbGnctpCRfsLcB80r7PHNHhVAY5Dma3YGzgaivwBg0l1dmufDlJIktXy3N6gEGbyHn
	ZPTns/nwTXqRlIQ2UhGEL1j7M+h+xYV4Xs4WJFHlQu5aDgpgnMA08iPwEpZRuUapZQHy38wLgAb
	7hWajXFv2Ol3nfSevoWVM4hOLCYIVwauNBH+Jla9fNS3vaf7yEED4GrdBVr8WrLTXFsqlHpJ8wt
	nDWlYUIzwJWDIG+pJC+6SGDJrH6QpxDiD8Yw4VYvn+MGTZKA3loVEJWHthIlM1hns+PgyCVEP07
	3ED3BiYD1UmZiRU/TEY0NrKxDK68n+2qwembneFW6EmJiv4ptxAq5AM4YYNpn6FTcaD1+/apL8Z
	8Fh8XoRDcRzYCcUOTV1JAVguJo/6YpbbPv4IWxZSiZvc/UzErDREVVHmjboBJKreTJt2BWZ5wox
	hCOJOIP1RHSBusjA==
X-Google-Smtp-Source: AGHT+IHDv00MqIxXpHOTXNqbJazEtSbdKJsUnEz6PuuGOX3MyfvnmRFOvQN5V/JdLxq3tRSDwUhr7A==
X-Received: by 2002:a05:6402:238c:b0:61c:e287:7ad3 with SMTP id 4fb4d7f45d1cf-620f3e58fd0mr5862656a12.6.1757235600489;
        Sun, 07 Sep 2025 02:00:00 -0700 (PDT)
Received: from ?IPV6:2a02:810d:8408:2300:5120:e228:7c89:5bb8? ([2a02:810d:8408:2300:5120:e228:7c89:5bb8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-623901ab6d2sm3009282a12.16.2025.09.07.01.59.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Sep 2025 01:59:59 -0700 (PDT)
Message-ID: <e1c2721f-fb38-435f-8351-3d28f13ad4ec@gmail.com>
Date: Sun, 7 Sep 2025 10:59:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: mediatek: use bool as the function return type
To: Xichao Zhao <zhao.xichao@vivo.com>,
 angelogioacchino.delregno@collabora.com
Cc: linux-kernel@vger.kernel.org
References: <20250811034539.175237-1-zhao.xichao@vivo.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; keydata=
 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
In-Reply-To: <20250811034539.175237-1-zhao.xichao@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/08/2025 05:45, Xichao Zhao wrote:
> The function only returns true and false, and the places using the
> function also expect a bool return type. Therefore, the function's
> return type is changed from int to bool.
> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/soc/mediatek/mtk-devapc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-devapc.c b/drivers/soc/mediatek/mtk-devapc.c
> index f54c966138b5..33254a979156 100644
> --- a/drivers/soc/mediatek/mtk-devapc.c
> +++ b/drivers/soc/mediatek/mtk-devapc.c
> @@ -109,7 +109,7 @@ static void mask_module_irq(struct mtk_devapc_context *ctx, bool mask)
>    *                       info to VIO_DBGs registers.
>    *
>    */
> -static int devapc_sync_vio_dbg(struct mtk_devapc_context *ctx)
> +static bool devapc_sync_vio_dbg(struct mtk_devapc_context *ctx)
>   {
>   	void __iomem *pd_vio_shift_sta_reg;
>   	void __iomem *pd_vio_shift_sel_reg;



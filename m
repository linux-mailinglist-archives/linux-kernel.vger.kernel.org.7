Return-Path: <linux-kernel+bounces-872276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF31AC0FC8B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 18:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B5D619C423C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305EE31812E;
	Mon, 27 Oct 2025 17:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nk/yeswB"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F53306B3B
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 17:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761587516; cv=none; b=s+9kDz2u8QKe/iHQenJ23guAy8tY1TCXB4sonHiQqtUSscknNX1Sf5WvrcAdSvIwgGWH56G+7k+ZgxQVdD60+bCvUxA6QZLF8pnoD0LLRcMZaWy6A4uhLqnuTHhuwKEXqLCgQxcc3RJgY4/884TOBVNQZX/IwgILlLYT5eLhEf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761587516; c=relaxed/simple;
	bh=Pg2jiCsm7MjJMHV2SEC6hKWPL2RUsUBkTbRD1RGwq2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qCUtVf6w3/AwsM2MRwrhD4fYTjrtlqVffg1MmGtce+Boh36/VbBtRRx91KWK8raR8owm1lr5jTpAkD+8skTtqWpngVYc30Rm84F7qPZBf4EceGRjtQkjumL/H/9DIcC85XFBTWZ4WcjmBn97OBtz6dYX4qSTsLk1yL6dTTb0Gg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nk/yeswB; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2698d47e776so39772215ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 10:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761587514; x=1762192314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dVq9+t2z/NnSc3zlKxkYc+qBrK62MLq4an44lN9h9dA=;
        b=nk/yeswBmTnxXounw3aPhlzYPwWh7NEIoJkopv4vycNcJ/xmOt2LFGfqLawqJHx2pA
         nFk3T80AS6XP0eqfEqzVk57olfM4/D0y4nWT8Tp3WweiKQ6MfigATYY+MaAzZSllnPbV
         iBoTOtYEChULfv21ZaKMzovhjvOUkDdk0l4wIbBiSgjfg+6mQSUBBSva1uUJnb1Fwbzk
         OqbK11U4H8zNZS5NVbenUxZq/8EPKVe943J7qwOu6Byr4zSF1PQeYKcZfpSxZVm/JrlI
         F9f0lWK/nXWxZzNUNKTWEGT5sSgkY0sa1K/jVgSthilLBxYE16yhbcFuFwi0XCNG8gWJ
         zk8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761587514; x=1762192314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dVq9+t2z/NnSc3zlKxkYc+qBrK62MLq4an44lN9h9dA=;
        b=vrOIUgw4MAiVck9uWCtZNUQa99KPTQF5jDmY/ah7o3iOMXD0XjeI2ad4ToxJrhIrZ4
         byoHAjM0/v7IxdvNQnQ00Gy0LmHt9yD9BIzWgCqQJUy62f3ldmU+Dz5H8kM25qIJdfJ2
         4WLlEFIfamxNjvCc8+KylrU9FoiDVMuN8Yq73wFW+4nY2C+tTS+CPSy4TQOso50xBKph
         /w0myVhz93hvUMcnFLGtrOzQJII7KAVIXXzZ7K2s8C9qBBsYTNcU0fbjNCVdlsWzhKrk
         0v73HiST2VrFT1AjkWIqA89ZU5lqpX1O5F+t6/NTF1B/WBTJ0NvAFtnGY+CLod8HwdNH
         tmKg==
X-Forwarded-Encrypted: i=1; AJvYcCVz2oUiDNI3MVsIglwDiMBmu1ou4ardxsdX9GlnIcsLS694o+xeXtxY5zMjC1dBbgcsjFbYYdMEKBROh+0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpey22FPyNp/Yyfqt0UvwhbFOThRbzxSgLCh3fjpSDDT+5YsMH
	adaC2074ty7iilpByclOb+I84UShHeT+NA/E7oNxNutjcmgUcILxDdyAsMBwWQj/OEsjgmx7LZS
	qhzp5GsIl3aG4GSvee228UYVJuVDR/PWq17EUJQsq
X-Gm-Gg: ASbGncvySgY1Xtyd4Rn+gjE88q5T4qcs1M2XAYCDmuQWXTTyVpQaDVVTVyC8vpd/Ndc
	nuo4b5aeX9aTujD6qjvg6qMM52zzoShaxRNn+CimkjhPa1C5/4BepNRoEG1Yg6g+2CCcPx/OKOz
	olfImpOHLNjFbtYpVxr3WsAPWTn8OGQHYnwPsAwIceM+dfciW4vf1m9u9ou5uDq2WPrKmilou5s
	5lHJOVUmYaXtZZYrNp89vOJRmlzQyQshLc5drotqmQupgY3qU7357Ls/cEBDuUxHYdjry82N9T1
	hDbjRT8hSXYB2UY=
X-Google-Smtp-Source: AGHT+IEgeUScsspPK8q8p9oorihY8OHMO9eGLp+b80KlldnZRcxNn7o3fr7kcpHMvGThxV1x5hS5JU0hjK137hWgArI=
X-Received: by 2002:a17:902:f681:b0:290:7803:9e8 with SMTP id
 d9443c01a7336-294cb5002d3mr8474465ad.48.1761587513938; Mon, 27 Oct 2025
 10:51:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027101328.2312025-2-stefan.wiehler@nokia.com>
In-Reply-To: <20251027101328.2312025-2-stefan.wiehler@nokia.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 27 Oct 2025 10:51:42 -0700
X-Gm-Features: AWmQ_bn9wyih5qWJDlxLaH23hKlmKl93Y9fku_GJoCm-usUlu6PJrInmbaQTXSk
Message-ID: <CAAVpQUAHHVUBQZ=fgCUe8Mg9CD6d=CutyEsE4m82TGdt+VqpNQ@mail.gmail.com>
Subject: Re: [PATCH net v2] sctp: Prevent TOCTOU out-of-bounds write
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: Xin Long <lucien.xin@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the patch.

On Mon, Oct 27, 2025 at 3:16=E2=80=AFAM Stefan Wiehler <stefan.wiehler@noki=
a.com> wrote:
>
> Make sure not to exceed bounds in case the address list has grown
> between buffer allocation (time-of-check) and write (time-of-use).

Could you elaborate a bit more context here like which path
we don't hold lock_sock() as Xin confirmed in this thread ?

https://lore.kernel.org/netdev/CADvbK_ddE0oUPXijkFJbWF6tFTq5TntpFMzDWH+uV_k=
c+KB7VA@mail.gmail.com/

Also, it would be better to post the two patches as a series

git send-email --annotate --cover-letter --thread --no-chain-reply-to \
--subject-prefix "PATCH v3 net" \
--to ...


>
> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
> Fixes: 8f840e47f190 ("sctp: add the sctp_diag.c file")
> Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
> ---
> V1 -> V2: Add changelog and credit
> ---
>  net/sctp/diag.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/sctp/diag.c b/net/sctp/diag.c
> index 996c2018f0e6..4ee44e0111ae 100644
> --- a/net/sctp/diag.c
> +++ b/net/sctp/diag.c
> @@ -85,6 +85,9 @@ static int inet_diag_msg_sctpladdrs_fill(struct sk_buff=
 *skb,
>                 memcpy(info, &laddr->a, sizeof(laddr->a));
>                 memset(info + sizeof(laddr->a), 0, addrlen - sizeof(laddr=
->a));
>                 info +=3D addrlen;
> +
> +               if (!--addrcnt)
> +                       break;
>         }
>
>         return 0;
> --
> 2.51.0
>


Return-Path: <linux-kernel+bounces-871199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06904C0C9CF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E2AC1881737
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF822E8DF3;
	Mon, 27 Oct 2025 09:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RqHJYXQa"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA372741DA
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761556569; cv=none; b=Mr6gdfe+ejoq/mWSQRjewpCF3oV4GJda0jNjSOoJYyBStEoG2KlO+rujLVFQc3iwnvvBM9LfOh877hSkSHQbyPHFFi6LhWwlYB78w4cYi8VeAgwydoilaBcS1U7Kod57ix3qB/+Tpm3M2Yv8E6lHO6j2N5pUAdnWwNL8OqrK2rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761556569; c=relaxed/simple;
	bh=oN9S/ByE6z4oE1dK1xupBGPnFsMKYjqe/Wd1H2/tmxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P3cZt+GxIHhgJV+7TolFsfNEpShNMjmsHq1Ou9uaG+X3mwWt2MGD4UIQmKeRR3TvvNsdXScxrNHuIDeJFEMqiHgZ8bKm1Tggj8qPu88zMUIpDcwTf6vKVCZX9Zb51uo2ghmOWx7CskZiAKspacYMYuuwimQs/nHf9z2GHCKW4fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RqHJYXQa; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-89f07fee490so335791185a.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 02:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761556566; x=1762161366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9M7flweXiGej+Q06p6wHFNjm3oIgkIVuhJ5x8DaGW0s=;
        b=RqHJYXQa8BI0kdiRX5hfZ6cTTGLHHJnd8QRkhPsf1baR6dvrQqjYGn+LGLLouyE3R6
         a8cIYdCU1UVugipVqjn1cy6WfDBwxckNvOxCxGfirYr90y4YLWJWKZVSvYt0oLh9O6ep
         PyQJK7sBiJhyxDAZfq6r2V1XVvf6Qm8PMmj21WFpZaH1VQBJUWOAQJ8sxwWoF2PaVsPa
         DpU/nIoj035V1nlRYoXur9iwx/2IVsAXEfDgaOxEA+2/suiu8Sh+Mqbrufumb660jXT6
         4IPHASMImGwckrHpeKzfchWrBDiHCvlr1ZdlVwUrNVDiH9VVnfp/M+UiqZBBe91KsAi0
         DEqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761556566; x=1762161366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9M7flweXiGej+Q06p6wHFNjm3oIgkIVuhJ5x8DaGW0s=;
        b=ZUy7B64De4/cRHArUbzv9g+rCejtGj3cO93RtKkrtYWav7+X/fO7iipxscC/CTvlSS
         3NICUvSp5yqNQZeIJ3tBfMytUi6dWWVM7uN6IIF6GM2OUmGwAWFHEPie536DCNZF/DLe
         nMzyKdaWQzZ5a5zW5Hho+7WwII5asNbBRdYwb0tB1yoWHu3QozoLPSDXJUqIrYNQ8cPJ
         xLiry//AareFgplmu3S9/2eEgYz81UJRxbBaqOzLCNXHeMQnmcJ5P7f81pOrheNus9Ff
         wb6bXzofhEn7zkbMAJApEAKzOEiKbSztVKkH5JhmhH6tM+YtTTrR4EsewbY7ZRZqnxPV
         v/dw==
X-Forwarded-Encrypted: i=1; AJvYcCWH62h1/kOVb/R3yezcdcTc1cyOEUF1fXmHWvIgz2EDhKibdH6rKmPzRi/H1WFVyxPBBfYI3KJDGPAvAZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx15CL+l2HmvNUt/a8nMMv8NOH+LvNv2PuFkKnHdLZYRoSMjg1D
	99PH3Wvty+fUqmMR9HvSbz3Zn24EzOnQoHPBFxF2qwhFVtu+kCFGLMUfOFSiEzCakGzQqQzmhQA
	E8bXcHz5l/FVvvYimTt3LoZ8muz+sW7cRCAlB0CZU
X-Gm-Gg: ASbGncvEUC4sb9r/dTUzKgYni4CvCr137oNrs3nzQ7ZSul0cdZBnc9cDal4Q2JSV/gm
	jwuGZiYtyOlqKjDiZ/BAW5KNbqzaF1op8lR2+rqiJ/vHl2QC/dS4eoUVoYeijvTTd+QUYp/7/G2
	B0Elg6lq2YLtjz6p63qW6u31f06Mufns9Rq/xeVAup8Eh9SYc3XrhfyVzgQh3/oITbfZQgbXofL
	TwvAf9YJOKPy8Nsupgu6C7GqXNEWrOfKQzG1fmB6xs5xfu05uJlri7K4UgGmo2++RKtBZM=
X-Google-Smtp-Source: AGHT+IG0vxrk8P548hMiYXEr5yuQrLVzL4lCysrZOaHo4+AlkvkNAKs2QduZs+9ZwIJ4FPzozx2n/rIWJmZ0OVid1xI=
X-Received: by 2002:a05:620a:4005:b0:89e:6902:3e11 with SMTP id
 af79cd13be357-89e69024424mr914542685a.35.1761556565812; Mon, 27 Oct 2025
 02:16:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027084835.2257860-1-stefan.wiehler@nokia.com>
In-Reply-To: <20251027084835.2257860-1-stefan.wiehler@nokia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 27 Oct 2025 02:15:54 -0700
X-Gm-Features: AWmQ_bmDUmU_tcEMhsKWxImXqueUJYr--H9ftZLY576HiZQiOI1zh4Y5ZwoSHbo
Message-ID: <CANn89iKSP6pCtn2vu8D=5-Y7LSxCtQA4s=qXjvHsMeOTstfbOQ@mail.gmail.com>
Subject: Re: [PATCH net] sctp: Prevent TOCTOU out-of-bounds write
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: Xin Long <lucien.xin@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

No changelog ?

Also no mention/credits of who diagnosed this issue ?

Please do not forget to give credits.


On Mon, Oct 27, 2025 at 1:49=E2=80=AFAM Stefan Wiehler <stefan.wiehler@noki=
a.com> wrote:
>
> Fixes: 8f840e47f190 ("sctp: add the sctp_diag.c file")
> Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
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


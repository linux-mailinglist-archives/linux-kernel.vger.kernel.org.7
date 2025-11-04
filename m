Return-Path: <linux-kernel+bounces-884145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D57DC2F736
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 07:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BFD0189C28F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 06:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A7927FB1E;
	Tue,  4 Nov 2025 06:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="UJ/02os6"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A002A1C7
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 06:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762238104; cv=none; b=EDKAY1lGy3CS/n3zevpm+rs4m6pV/cgpKm9tRNEwnJbQ4IQ965sw9gCq9tLEOmJZvXXYlnaKnjdGpSXiIwg/H4OaNouGFpXKwi1h5NPQdNzz3d6x8HPxsjftNMvvGYu2LYsFGDVKUpdX3Wyka2MtiPEAWj5w1rLrZPxGUnv0A7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762238104; c=relaxed/simple;
	bh=s7tSXwvHJ4PEs4y4Dec7uGqloATEs+Wo8gpI0FbMsVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b69zw3AW827XaKdhe6OZ8IiUiBYLsXcTuY5Zy8zLOFTwXw2eKj2kV7foENt27We6Ng296lJIFEFdEHigL7r1ZLuBzNqfXXerV1wWD+fY78NKiBCejYWSK7RRJiTa/3pqTy1W6eonMLA+E7gtUl15InrG5/e79Tr2fO99g+NDG6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=UJ/02os6; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6409cb34fe0so593019a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 22:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1762238100; x=1762842900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQmAzRgv0Utq69TMSo5XIPtDul3xsXRYMQU9Qcm5TFs=;
        b=UJ/02os6zo6tb9bDRTkqMwIS61zY1zWPRNHYWyZ4XtROs4qz91MoYxWQbv1F5e/2Ok
         gcpesx6W+xbR109qRf2mcHQMBpsCfDiL7EQygq7QMT5LtgrvDBrlvYApNOs7jOEI45WI
         TncHRFiMX42iv4wAWs2YCLslQXwyDMJXDK+88PPiVmpmiyjGu0tSd8YNVvwVZ9/GbEqp
         SZ2c1TcRVA64P+5gj6M0dKRk/iEXVkQQsqpaNgCSeGtyqWbKbnYj/z/3VsBptc3UK7jN
         rrHxyqUJzDNhK16dWbby2NtTZQ3H1QoB3glxxyobzlAxDsm2xFi53X3dIitP3gN3v96u
         2LtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762238100; x=1762842900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VQmAzRgv0Utq69TMSo5XIPtDul3xsXRYMQU9Qcm5TFs=;
        b=OXeediAmrxltscaswDImLwYXiFfRuV4Z/eGBLn2otPGREd//PVv6qkmxcAFvQyNfqg
         mbrIpSsP3KkUwIx+hPFj4ZLg355hkPfSba1Kv4LtPr/xicaOea7EShH9JYhlmZGUENXt
         DOLl8J6gVlIjFvTt7hsd5bZChOGVP6N/5TyhbPsUdFx9Q0FuPP/OF5HauhTma8W8WBtt
         ehVuX1gt5urU77IGKJr5mVNTz+jkVb/NbiD5xoqY16LD8E17cp710eq804EoIvpNSgsk
         CFMon1Z+xfzh9hP3mCtFKexm6FXpD9w+kh0DAZ+xRdJdE0XogYQn5/1mL7CsE2GQ0ZXb
         +fpw==
X-Forwarded-Encrypted: i=1; AJvYcCXVJI5fN6jr+mdttq2JMJbsKsHh5woOwh432KIzi4mQ9dZ7IWR1302hnYPn9gKN5Ruvi643gqDA5laqyyY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys6ZkOVxiGKMUj+SS3kRtB8Yj7kUJVbqwt5ZeaxRJi6Exj7BDR
	rFeuQAyc7DwllSb6ZsJAzt1+ZDruuWJnWmaGfuP3wZjwzfwe7MyLaTnbtreaFd9Wu8VRHakuEAf
	/HMObsHzlKqsA0DhJCAmaSrq3rh7hklgKfedxmMZ4/w==
X-Gm-Gg: ASbGncuykWqnDph84ZoCRifv1QEDwVY56U4f380P7kpcoIF4Ffepi84dhLJZlKJXV5C
	dThJhQ4wkVK5RuEsmNpZ0yiVmxvbE9P4NqGxjOYDml310Eo1/g1lDNXc+taKdNcVK/qxxT8tzl1
	QcBdaPTB8IePbrDTCYXf7QSQ55sHxAQ9V6aFfTaQ+TIGpt7jihz2qSJ6wfpKRjRqOReZBkaMJj3
	hO9rYrN3GUpusUUHnGnIGf00zNTWBZC92a6AFVQ6HmbOwQQCth2Pw5qp/1gNyUiMns67Yvi6EST
	igzp7AnDTEW2QmPBcw==
X-Google-Smtp-Source: AGHT+IFhN63cUrkNgr3auzZxHZID+sIcCpWhSj3aZ/0+3dxL73E0sC1Ila0n0+af/sQcBRu6sYvHwe1uf0SeulBLdKk=
X-Received: by 2002:a05:6402:26c2:b0:640:acc8:eff6 with SMTP id
 4fb4d7f45d1cf-640acc8f300mr4453850a12.0.1762238099728; Mon, 03 Nov 2025
 22:34:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104021900.11896-1-make24@iscas.ac.cn>
In-Reply-To: <20251104021900.11896-1-make24@iscas.ac.cn>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Tue, 4 Nov 2025 07:34:49 +0100
X-Gm-Features: AWmQ_bn1fsvxkVFYJEeS6HPOZ4jil9W2MtbfRXCQLvctJqd1ASYUjnERunBcB1Q
Message-ID: <CAMGffE=0LXyzcg7tew15tV1zgVAaHA2XMHcf5=14k3k0KuzNXQ@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rtrs: server: Fix error handling in get_or_create_srv
To: Ma Ke <make24@iscas.ac.cn>
Cc: haris.iqbal@ionos.com, jgg@ziepe.ca, leon@kernel.org, 
	danil.kipnis@cloud.ionos.com, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 3:19=E2=80=AFAM Ma Ke <make24@iscas.ac.cn> wrote:
>
> get_or_create_srv() fails to call put_device() after
> device_initialize() when memory allocation fails. This could cause
> reference count leaks during error handling, preventing proper device
> cleanup and resulting in memory leaks.
>
> Found by code review.
>
> Cc: stable@vger.kernel.org
> Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
lgtm, thx!
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/=
ulp/rtrs/rtrs-srv.c
> index ef4abdea3c2d..9ecc6343455d 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> @@ -1450,7 +1450,7 @@ static struct rtrs_srv_sess *get_or_create_srv(stru=
ct rtrs_srv_ctx *ctx,
>         kfree(srv->chunks);
>
>  err_free_srv:
> -       kfree(srv);
> +       put_device(&srv->dev);
>         return ERR_PTR(-ENOMEM);
>  }
>
> --
> 2.17.1
>


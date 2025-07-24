Return-Path: <linux-kernel+bounces-743548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E8EB0FFFC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 07:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3E5C1CC4263
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 05:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4F11F4174;
	Thu, 24 Jul 2025 05:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y71mO4zp"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5B82E401
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 05:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753335277; cv=none; b=cH7y3o5OdaF1AJHfTUqp9vrcSwiUUhCO+urKjpMLSWmHQcwJWoH2NOnriWv9ixhoZHuBh80M7c8FeRCuJUR1LVnDKlKjJdcY/QmNSeZgJSV3ziQYwX1AlDiWnoE1bezdfkUxNPgSEAdQe3C80pO9XqTTm7AngvrqVwvb2rapfXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753335277; c=relaxed/simple;
	bh=zyZSsLZCiKoKwUfymW9iOoz5Z5BkfDelBIadlUPshag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m5iBj3okKQPf7J9xpR3BdSEZjGvCP2lJTK9wGlGEo/QH0xTyAxuD5bOSQYZx5CamiAtuiXkUlBJv9JH5x9kl7C3bFSDEvZCONojJ89EL91ep2YRX/HrvXXgTZBPVXGCmWYKI06GgJgsWYZBuJnYz0Vl5bAuQx4S5khRJ67ZYMgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y71mO4zp; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-70f94fe1e40so18371817b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753335273; x=1753940073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hL0D0moASx5ZFuGGUsAWzElsnIeflP/cooUOhWKetlI=;
        b=Y71mO4zpo9ULb/Br7QXqNTXtyLTBc6oY6WcrjKws5xkB1TVN2EMN58JcpTkOhkkHu9
         H1SrGKrNsYbEuQclscGwL6PCox2AcVKUC2egCU9LPQgmY79odozSo+GuEnBUD/M0QpId
         UVv5dUGHi3RJUwIahFcHG1blSIv6MAjHpBn92dHFthoz+EtMm33goNfj0cs1M0g/qh6n
         9QsVA/QPEDJSxlKCt3Em0H0yCwvSAP3kduxdmFhZq3DO5Z1wbE3oqOUkOEozxSID6CXo
         hlTdMVAToWymJTpLn9TaRA9yLEmp+N9DIkOYlPQOPFTXmS0u0b6aWouRDbL3ZXsFV4cF
         7Cpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753335273; x=1753940073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hL0D0moASx5ZFuGGUsAWzElsnIeflP/cooUOhWKetlI=;
        b=g2td+dLdfQEiXrXs4ftCTCwFL/eB82XECD/ZeGmxODQSFh8qw0TwxKTdTb2KL1W5ig
         Yi+NJRGz6tF6QA6gzN0F0pL+Am3bA8T4StnXC7Fg0/1iQj/ndIL2CBqfIHwu92mF59TX
         grjjCcQHeVNV5noKBrnd8sOV/i5OBzGFHs9xW2MKkUS53HIGd18d0nUK2//wjTGFaYid
         ISV5Qznaqyu8iUX+G1lwG9273nCbxaoJ1gD/pdcfDhyqM9Sq/HYyqBTTWZeioMYqCdUs
         lILbeXKDLMV0hY1vUgSqoe7BjCQpEvdrG6xgWM6Bd7WH9JxcOsC7XgcIzRY9utuZMasY
         YsIg==
X-Forwarded-Encrypted: i=1; AJvYcCVNqL67/Zi3lLp/wspL9m0D+6RXvb5AvVh+B0MNqWpRDsOjQirFlazSlBGtKULXYGbtg7W9zHVL62Zy4cI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgXoI/fH+Hyd3EEPRm9MWfXCH55jedQ/4QvHTOju1/RzehOYlv
	QtY06CvFgtzjqeLdR0h+XySNx0llrqg1ijcZzaMBQWPkKmUgA8Jwfq7tP5bUrmmeFe83E0cdomv
	pNmBjf9U3m48P/mdYzxACERe8a4uuvcU=
X-Gm-Gg: ASbGnctqys9bmwLmn+Mq2+EPPDryvaw/FxEmhpmKznSrgyFNzXc+gB0uhuTwoNnPA8K
	l4Q4po34i3KY/8cNgF4TpMTsUBV4+efq6yHqnS3bUPNDkP5KNjrbU9PhtuDntEEVeV9Fg855RXX
	p+ao5TOSSrC4ONKCNExO4kI/Bph+4OsgRY+7RahkpfSSjd+89T49foUqbaIuZEQHqyi1LvcLSX6
	7N+Hc1UJ4ttzywkQgTr
X-Google-Smtp-Source: AGHT+IHFlMOVbmAQqYa1/RYSd/P28yfe6C53YQ9WlUPiknvUYt9eF+/Y5+zF40+qm+Y0UjKvBf8HuvSqkq5/0p3U+4Y=
X-Received: by 2002:a05:690c:360d:b0:718:4f42:dcb9 with SMTP id
 00721157ae682-719ce9bf913mr7072277b3.21.1753335273261; Wed, 23 Jul 2025
 22:34:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721111344.1610250-1-karunika.choo@arm.com> <20250721111344.1610250-4-karunika.choo@arm.com>
In-Reply-To: <20250721111344.1610250-4-karunika.choo@arm.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Wed, 23 Jul 2025 22:34:22 -0700
X-Gm-Features: Ac12FXzSg9yyW9P2O4FOO8DlanlHuGPcKNOWKJyLq_PTy8fKKwIOkn3T36e9daY
Message-ID: <CAPaKu7S3uYRJSR654dcjP-kVScQTJPX-UqHjF+Zsr6uVgGY=mQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] drm/panthor: Add support for Mali-G710, Mali-G510
 and Mali-G310
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com, 
	Boris Brezillon <boris.brezillon@collabora.com>, Steven Price <steven.price@arm.com>, 
	Liviu Dudau <liviu.dudau@arm.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 4:33=E2=80=AFAM Karunika Choo <karunika.choo@arm.co=
m> wrote:
>
> This patch adds GPU model name and FW binary support for Mali-G710,
> Mali-G510, and Mali-G310.
>
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>
> ---
>  drivers/gpu/drm/panthor/panthor_fw.c | 2 ++
>  drivers/gpu/drm/panthor/panthor_hw.c | 6 ++++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panth=
or/panthor_fw.c
> index 36f1034839c2..b7b454d16f12 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -1402,3 +1402,5 @@ int panthor_fw_init(struct panthor_device *ptdev)
>  }
>
>  MODULE_FIRMWARE("arm/mali/arch10.8/mali_csffw.bin");
> +MODULE_FIRMWARE("arm/mali/arch10.10/mali_csffw.bin");
> +MODULE_FIRMWARE("arm/mali/arch10.12/mali_csffw.bin");
> diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panth=
or/panthor_hw.c
> index f39010c0ca86..7f138974d43b 100644
> --- a/drivers/gpu/drm/panthor/panthor_hw.c
> +++ b/drivers/gpu/drm/panthor/panthor_hw.c
> @@ -15,8 +15,14 @@ static char *get_gpu_model_name(struct panthor_device =
*ptdev)
>                                                 GPU_PROD_MAJOR(gpu_id));
>
>         switch (product_id) {
> +       case GPU_PROD_ID_MAKE(10, 2):
> +               return "Mali-G710";
>         case GPU_PROD_ID_MAKE(10, 7):
>                 return "Mali-G610";
> +       case GPU_PROD_ID_MAKE(10, 3):
> +               return "Mali-G510";
> +       case GPU_PROD_ID_MAKE(10, 4):
> +               return "Mali-G310";
We should keep the switch cases numerically sorted, unless the current
ordering has any significance (which deserves a comment).


>         }
>
>         return "(Unknown Mali GPU)";
> --
> 2.49.0
>


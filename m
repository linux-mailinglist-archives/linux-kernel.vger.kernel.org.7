Return-Path: <linux-kernel+bounces-874615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BE7C16B21
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C5C71B286BA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A680F34F49C;
	Tue, 28 Oct 2025 19:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klhNUQeX"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CD0332EB5
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761681493; cv=none; b=Cq8MXqczP4DKFc5fMFGU6aRJc8aV0lt8GSu4+HwbjqAi6r7Sat0W+IvHf5UTUBeUJuA5ZpPl3V4B4e3PdtqLJcJIdZ9hX+B5y6plLckSNl3AGCA+AiruwxU1vCKb5xBi0BEa6T3ZOLYMj8b285YNN4zLwN4X5oT0+gUDkLOush4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761681493; c=relaxed/simple;
	bh=81YyA1R5iz4fTfXKoVxn0FrqZs3ZkgPsIoR8QbKYtlE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=coSLFzFdf4bM41ux5osjhilbFr7GCfb7O1j+UOp5h/PGeTK/P96hrlrI3taeDVn8a45MUF87xENPNxGUfxayYU9Cif0mVDZNJRb7qVOHANVio/i22X81hPuFUE9HONmSg7RgNvd/ZyYqesKbU/PjBPljRfUg8uYO2PJr8cEt2Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=klhNUQeX; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4eba313770dso40434621cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761681490; x=1762286290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81YyA1R5iz4fTfXKoVxn0FrqZs3ZkgPsIoR8QbKYtlE=;
        b=klhNUQeXcc9P3Rds0AJN+5uFxN3wTx84ylKIs9V9/UJPDqyy0bzwnIHef4aITX1ZC3
         czDNWpRDSQ3j5jma2KsD/xoPC6+uXu7lgqhPF1ByfIyMBADOvht2kHUqpAjRG7uCNWvl
         LdoqHRTu119vRpbkmNy/0H1DhxcEevg2FU78WjCeV8z1fSGZy1VFV6w9RoimB0OQLCLv
         8HM5KN3tHUuGc+FPDX7jLHVoSphuYslb/nF6i6/dMmigERrwkCoaqtILfOAsImTDPIHb
         9Nu/xThmav3SbtN2GX7d2Lt2RdF/YaUGahTeblpr7TJIgcW2Xpza78yIxbye9VSgPY3E
         vcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761681490; x=1762286290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=81YyA1R5iz4fTfXKoVxn0FrqZs3ZkgPsIoR8QbKYtlE=;
        b=mVQSxMJcmNYPLhwXuUhqgxxGyYGcSX6syO9FGkJPe1y2ATHvK3gqvHinLmDjV2ZpsM
         SSpFU7Z12QcALskaZLoSb47B7XumoLfDP/i0zMHayLkTl++sWvomJXUILQuLBi1K+VyY
         AV1e9TzsDffnpnPEi7NrJNQcLzmitaoPZm53MlARU1jqZJbwg7UfFksSBCM6q36b+BL5
         YLgX8jhi2IslLZL5FcjnkJcj+6C1BFpYGHkVfWf7CyaVFyiLDV2C35FnS569dn94USh3
         Xqm2TWMCQn/j1Ov2cbdazofsrF4wzzTUqUe2Cmjwd1e0Q46snAPUAqM99QK7OkA/TBv4
         IhsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXg2/CyeMgnTOh6JKxnfdVIvine3J8uUMhto/JWkiTuubs5g6cSdWv99p/qDquDbbGFFHefWzHy0nWoQ5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAVPuEm+giQi/rdQKvU306wulYcR0JEg25ukHT4S1Q8uEhgNjF
	HuynHeUaanJiAGTuXCkMus1F2mh1K/vPrzxw4hGxykr9UIz+LoCBNmMra3VY5LRa8ULwngo7EEp
	igl6qkNAmmiagGBO6729gc6ez3txlNvE=
X-Gm-Gg: ASbGncvmlsQ4/19yd8HvXr5Kxhv8KxHMLpXdh//0fjKECvPJHHr+TYAqTJEygx18nLX
	NFkosCEm5rTwCwD99qENZkB3jfaXPc/IklGoyBz2Rj093ZPRY5A9HdiZyCmUm/XeTl2QA0WuPrU
	Cj2rKtpXvh1Q8NDlNMYsGX/EIktk1FaqLNNv6bagDLz+GcfzYNJdgfMHDpo8RAx90P7H2CA3KPS
	Pv+CeUTdwb/QikuMX6SU/U9/IY5L0yWf6F7x2ahBnFNQoplvfx6F1wAjpCCztvSEFJFXdNNrmca
	KQ/U1WRCh+N+79p0
X-Google-Smtp-Source: AGHT+IHcPz7GLTlfScG+sYUJ1uTqk6yOB/+ttx87jCRzATu8J8QMSJqa0UraxFmcF3Kh1FSYEqsvJBW0hVJ7aPr7Kyk=
X-Received: by 2002:a05:622a:5a09:b0:4e8:846e:2d8b with SMTP id
 d75a77b69052e-4ed15b757eamr8256071cf.28.1761681490164; Tue, 28 Oct 2025
 12:58:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028120900.2265511-1-xiaqinxin@huawei.com> <20251028120900.2265511-2-xiaqinxin@huawei.com>
In-Reply-To: <20251028120900.2265511-2-xiaqinxin@huawei.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 29 Oct 2025 03:57:59 +0800
X-Gm-Features: AWmQ_bkDIOr0dScQdWXK4F4cmyPRafg2Akhiis5ZNZevLrtuXc0fPXf9BJv5y_4
Message-ID: <CAGsJ_4wy2B7=KwLfODySky+FADkLZYowWCNm28FBmri_Opv7ZQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dma-mapping: benchmark: Restore padding to ensure
 uABI remained consistent
To: Qinxin Xia <xiaqinxin@huawei.com>
Cc: m.szyprowski@samsung.com, robin.murphy@arm.com, prime.zeng@huawei.com, 
	fanghao11@huawei.com, linux-kernel@vger.kernel.org, linuxarm@huawei.com, 
	wangzhou1@hisilicon.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 8:09=E2=80=AFPM Qinxin Xia <xiaqinxin@huawei.com> w=
rote:
>
> The padding field in the structure was previously reserved to
> maintain a stable interface for potential new fields, ensuring
> compatibility with user-space shared data structures.
> However,it was accidentally removed by tiantao in a prior commit,
> which may lead to incompatibility between user space and the kernel.
>
> This patch reinstates the padding to restore the original structure
> layout and preserve compatibility.
>
> Fixes: 8ddde07a3d28 ("dma-mapping: benchmark: extract a common header fil=
e for map_benchmark definition")

It would be preferable to include the following as well:

Reported-by: Barry Song <baohua@kernel.org>
Closes: https://lore.kernel.org/lkml/CAGsJ_4waiZ2+NBJG+SCnbNk+nQ_ZF13_Q5FHJ=
qZyxyJTcEop2A@mail.gmail.com/

> Cc: stable@vger.kernel.org
> Acked-by: Barry Song <baohua@kernel.org>
> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>

Thank you. We also need to include Jonathan=E2=80=99s tag[1]:

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

[1] https://lore.kernel.org/lkml/20250616105318.00001132@huawei.com/

I assume Marek can assist with adding those tags when you apply the patch?

Thanks
Barry


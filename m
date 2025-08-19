Return-Path: <linux-kernel+bounces-776575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA501B2CF08
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 00:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A9CB1C41D90
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 22:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729F23277A8;
	Tue, 19 Aug 2025 21:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n/KduMwC"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEB4327792
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 21:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755640677; cv=none; b=uzzhxjroFlgZ/RUMK4OFT5gUcAyub3adiDmNr6POj/zyZCvnxpBqvsUIOBWIar2KHYxr+I0PQHwpkgdfb0c4D8H3gfDrVGXKQdsTRQPxHFpYd9thz9rkUmHYDtVB5rxRUY6Yw6BGiMmn3u9N1odUzeJmSoWOJ6VB0f3RTPw8bes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755640677; c=relaxed/simple;
	bh=CvJtxLbc27on48vID65kXKtMHxJ5HMnLMk4STwfZJ9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ho2taeCmpzeIE+5DN1WcnRWloq/1NqPv+joia5psmounSYvTIeMZiHM4uxsKdHgSPMA5cSWfuBBo0WWgcSlXUaPhFuG2YtHDKWJXMWkUK7gDipA8P+S7dCRYWdB+UzD/vL6aaeT6TD1M52dpd23ZuczyPjaThumm3QNAI45cI5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n/KduMwC; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-55df3796649so2939e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755640674; x=1756245474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CvJtxLbc27on48vID65kXKtMHxJ5HMnLMk4STwfZJ9A=;
        b=n/KduMwCc9rjzThjM4rt7oiPlGe25BI86/yktxRQuzW19y5MEbUQsBwjTAckCACiGP
         UbrMx1DPZsDwWWmbMoJUwWLnjlGp2Td5gU3gTiCncXOx0ddTZ1Eb54BmhuPCmCIZkcDA
         QIUP3WgNJY9y2taXuQmQyd3wcQp9UDI/2dRu3h1qdCqgPqWvZmp+pqh+0IfXKL9XU6at
         pBBv3KEqEtflpsB5CzHbRnLF6vcF7M0oJJ9Qm8wWXcQ2TIAm/LPq1EMCbZZ6Q6nVCM2g
         58eCD3PSxSluZFV8EEEMoSk3zfNtckJiTFlO0fj9xRW5fHs6eIlNOhfzBz5bq8RyEn3D
         NTHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755640674; x=1756245474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CvJtxLbc27on48vID65kXKtMHxJ5HMnLMk4STwfZJ9A=;
        b=dKbT9nqJOLnjBktx5aGBXG2VGwalaKSySXOktpUswfgLOFlZHYUYbv9HNRYSLaFWR4
         jyalenph+5KDQ3Cc5E/1xVGOh34/pUF0U52ruFk+4XF7qgbkDCDVWGM+f/uAb7XPgODV
         uH14TiyfFpu+ih4QxgAr5+RV5gUzT6ErSdVX+HaTkwnvdloFN9I7TKDV81eGgcChr/bV
         BShQzCaUGaQSXR/U7KOxFAyFyTlmB1cPVjFIrq727TIfpKtnGTMYCvX/dr+HR1aTbEiZ
         8+7kh0DSd9WnucB0RZ+juDHVZpZWsAJujRYKX9Nzs5sdHMZpUkG6RwG8Sw2hsW3Wxg4G
         DqpA==
X-Forwarded-Encrypted: i=1; AJvYcCXORZ6G8hb83JZLkbXOX+ZB/WQDXHNgC1HkM2qzVy/iNj9LN1ZQZMoEL7mMlhxeOK7SWYfox922XswLVng=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ/cKC0izTcAHhwWNTZsfhxLIHQMyTvmlBnSN+kcmQSUd+nl5K
	ymCsYUwLz+S3Mkt7IjJMGm3azaCwbg+YIe1nZsk0SLjD5i8uu7d5ZqijwudCwC+2WBHVdGvUMBa
	n8faXmIUcOFR+9mPNBPjQOeaKSmAy4B4nIMiB7qqj
X-Gm-Gg: ASbGnctLUGTQricj44MYLoFE0SnoncJPYBDhUK9qr2uXljxSdJNfOO9yhXBJxT1kFUh
	pD9x9IZ7HGb2wrlWhWHKz3H80hQ4mOTCJjGYNBkdkNTkBQLf2c+rnVcW+E9KlkhI4NtFu2a8Tmz
	hOXRbn/v7p2qshnu1zwI64d4UkJLm/dJaDpTrWYKCe5TPq0kOc8EKYoUUGr5N3xw4MhIHCB7jAc
	RJzgUFJ4aLRuZm/Tmagubv1Qur5xoQ/YpGxkM4LSrwotj2EHeL+Gg8=
X-Google-Smtp-Source: AGHT+IFjnm783G9/tzKiECTrCe8fFRAJeZ3G/drDLRd9Ku7K+BYBH4Eh6bxrOn+3eJeQcD9yP73r6e7X+DEQbcuDRLk=
X-Received: by 2002:ac2:5e36:0:b0:55b:7c73:c5f0 with SMTP id
 2adb3069b0e04-55e06752de0mr73920e87.2.1755640674063; Tue, 19 Aug 2025
 14:57:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755499375.git.asml.silence@gmail.com> <63cfaa6b723410ec24c1f7b865ca66fc94fe9cce.1755499376.git.asml.silence@gmail.com>
In-Reply-To: <63cfaa6b723410ec24c1f7b865ca66fc94fe9cce.1755499376.git.asml.silence@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 19 Aug 2025 14:57:42 -0700
X-Gm-Features: Ac12FXwUdfa4vW85A0T9LBksUrTPzJOsMtQHo15Ay6MIOEBEQOu6vZwDcE8HLDY
Message-ID: <CAHS8izPM4QdvdQurnO1RYaHcW8Xq5yK21c0g4uuqbLJPdjTpNg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 15/23] eth: bnxt: always set the queue mgmt ops
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Willem de Bruijn <willemb@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, andrew+netdev@lunn.ch, horms@kernel.org, 
	davem@davemloft.net, sdf@fomichev.me, dw@davidwei.uk, 
	michael.chan@broadcom.com, dtatulea@nvidia.com, ap420073@gmail.com, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 6:56=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> From: Jakub Kicinski <kuba@kernel.org>
>
> Core provides a centralized callback for validating per-queue settings
> but the callback is part of the queue management ops. Having the ops
> conditionally set complicates the parts of the driver which could
> otherwise lean on the core to feed it the correct settings.
>

On first look, tbh doing this feels like adding boiler plate code
where core could treat !dev->queue_mgmt_ops as the same thing as
(dev->queue_mgmt_ops &&
!dev->queue_mgmt_ops->ndo_queue_config_validate).

But if this is direction you want to go, patch itself looks fine to me:

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina


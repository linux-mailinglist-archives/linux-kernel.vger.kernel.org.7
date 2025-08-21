Return-Path: <linux-kernel+bounces-780095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF532B2FD96
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE8A65E04F0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27992EDD41;
	Thu, 21 Aug 2025 14:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="THjQbHDj"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3308284B2E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 14:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755787838; cv=none; b=AJtzJCXwwM62iJk6B5hletcrpeOXzUNqJLYqGNq7Yo98p1fjolSqv3hQ7krmtuJ3Fu42zLvAr8hrDKk6dcJ+uYfJpEEVadAyeFrd/4HbvpzmucLmMsn8Pot1CcFErmvkcaeKsXnYvF8Ez8NKdv2Sb6GW9A31hXe5oElm+avII+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755787838; c=relaxed/simple;
	bh=GH8+AwypDZSc5Wk9KNNPh/6qRQD5BUNBbwVozKXNp8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KsE0cVmKc83SGbHIDO1ZYspqpuYlfihpxBiM27kFuFPphUypKhrOkW81luaDYu0WVLVu/ZCV9YaotYzgUrVJDd05esMfhu8RzGgI8cWQJzFyuiY73NmdaK0ueOlJKpNuudqiK48aLylgJUszFahcs50Fa4jnMMSo7xFPkYLWJ8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=THjQbHDj; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76e39ec6f30so1056205b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 07:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755787831; x=1756392631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjqHieTqBHy+cNT3ZdROla3bmT3OzWvs9RzgpXfbZLc=;
        b=THjQbHDjv11//lACWeHb8qIey8DijCVUsh6cVXDb++r5Z88f6nXUjSAsUnlAg5SNGY
         3RjNdhbKl/0YuZPh1iEtK4IZAe9u2gLAgO67b2ewiaAsiYfyp6sLlyGoGPYaiQERUlHA
         RONiA4VOkc6eCZM+/KRYP/pDG8ScwaAqfdCxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755787831; x=1756392631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yjqHieTqBHy+cNT3ZdROla3bmT3OzWvs9RzgpXfbZLc=;
        b=rvXflbxGXy3z/Bw9zPmQxDOKYaGlssrvbKC67bbThNr+b3s8oEQ6Hoi1XBZgmmAtWH
         +eabsvtz67ZZFQSTf/VGvXrAcU5S3lXIR4VYym3AT7qqv9A6k3VUVG9n6KFkHOkrFUsw
         3DMRUAcknjZOT75pdvEttlOE9Hy5jwQWcGpEtop0fEaxNULNlojoL2sua8UTo+kS0oZh
         lvFktjAYfcM6BhW3/Wv0TyxkVfsRSiL8UmWcdDAhW4U3CUPFLS/YeeBgq4HTHv/eBD7i
         isGwVKh4jyXicgPnwWkim05XBaC1JRnj39+lV0HmpEBKvnxVOiajylQDhTQ9se7l+zDU
         t2ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlK6Hz5PWPfE9zXBlLPV/lvm95S9Tcu46ajTnUoVpheQbO8FB7QYh98SKUYZFFkqjwMonS2wV+Fta2noM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbWps25jCHVluDRb5nd/8fxGDHoBjk974lMo43c67zGpgnQAg4
	2yRcE8zwr1ernv96FkXuaU08xuOhvtsHRK+6xZ2ZfVkNYyWmpDkETs4hPiYnAthYh4/Zl+av6+0
	w6Y4=
X-Gm-Gg: ASbGncvT0zGHQuBX0Lph/6OyR6vq/qF/Hj8WU5hxnIuxnq2cNsjT/6XQylMJ5h+EeLw
	flvA+L/WFoxjDXbBJt2v9uep0dLRKtQYJuXAv7+kv0jJdMmMKuC9voKbnBV8XaQqSI8xAK3TxMF
	ueiio278QE2uN8UTkCInHFABXdeXbyk0wZhsjduGtgAnecHaBiDtSszvwPUNj1wdJ1pOhjnzGnU
	PA1oMml6/8aeHCvVtdiiDB+A30TRqQs1exSFGmvChNvUqgpk4Rqzyx9DqxQqscf/mt9Mh+dyDsu
	LdUFFPWjzm5W7fj9EJfsj0mV+uke6xZH/KqwStGOrUpdNh9ijoVxHqC+luWEG5xk7dVZKLirKSk
	k5kG4hDYkVGzU7xjL96epVagKb4nXnSIGl+rJaz6Wg5atpuBuXl9nDlzSsKN+ZjtS3bLergnbJh
	Wa
X-Google-Smtp-Source: AGHT+IFq/4YdOrX2lDT9d1+Oblj0jUKS0C24Wpw4jDJMLQlzh9OeVJtAFlhtUVN+e2QxQaRdjXL5LA==
X-Received: by 2002:a17:902:d4ca:b0:240:7753:3bec with SMTP id d9443c01a7336-245ff871294mr34154755ad.51.1755787830931;
        Thu, 21 Aug 2025 07:50:30 -0700 (PDT)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com. [209.85.215.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed375db3sm58089235ad.59.2025.08.21.07.50.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 07:50:29 -0700 (PDT)
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b472da8ff0eso696719a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 07:50:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW6PDtj1EVRhPt+X1O48sZk9TpFF0FcaJvl2k0EvMv6p4RkiiA/jBqREcvRTrLaDHXz8EUsKSqlHEeMH0M=@vger.kernel.org
X-Received: by 2002:a17:902:f550:b0:244:214f:13a0 with SMTP id
 d9443c01a7336-245ff871cf5mr35274985ad.52.1755787828128; Thu, 21 Aug 2025
 07:50:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aKcRfq8xBrFmhqmO@stanley.mountain>
In-Reply-To: <aKcRfq8xBrFmhqmO@stanley.mountain>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 21 Aug 2025 07:50:16 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WMu9YJgkkqTEpKEzPdMUka8tYzPZVKEeh501-mSsh4uQ@mail.gmail.com>
X-Gm-Features: Ac12FXwRHXd6Q5sCwpiasX5YznwxVtKCHmDt34fauOc1r6Twa8Tf38YLNCLnydw
Message-ID: <CAD=FV=WMu9YJgkkqTEpKEzPdMUka8tYzPZVKEeh501-mSsh4uQ@mail.gmail.com>
Subject: Re: [PATCH next] drm/panel: jdi-lpm102a188a: Fix error code in jdi_panel_prepare()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Brigham Campbell <me@brighamcampbell.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 21, 2025 at 5:31=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> If the mipi_dsi_dual() macro fails, the error code is stored in
> dsi_ctx.accum_err.  Propagate that error back to the caller instead
> of returning success as the current code does.
>
> Fixes: a6adf47d30cc ("drm/panel: jdi-lpm102a188a: Fix bug and clean up dr=
iver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Thanks for the fix.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Since it's straightforward and a fix, I'm not waiting and I'm pushing
to drm-misc-next.

[1/1] drm/panel: jdi-lpm102a188a: Fix error code in jdi_panel_prepare()
      commit: 61ce50fd8196c8782b9620bb60d33649ec429f64


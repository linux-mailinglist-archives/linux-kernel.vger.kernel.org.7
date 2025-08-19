Return-Path: <linux-kernel+bounces-775401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F07B2BEBD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B6DF3A7FE6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F9226CE1E;
	Tue, 19 Aug 2025 10:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KnFwa1SY"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5816927933E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755598669; cv=none; b=VqBFCwtFXZ7yr+wyMWPUtwTmGWGaGZbPEkj1Gsmx6AeVLVsbEb5Lu80hIedH4PeS8zm1iueI9s2eHkVPk18gvgsjs52b8YVntawIZEiU8hu0jgBqs4IxbA0VP+vB170A3eXt1XdQnlIdzfddhzfDLtwds1Q60vC+sfOsP/UrNUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755598669; c=relaxed/simple;
	bh=mI+27DCsZb1xNev2FOWjFwDPtlqZqOZA1lWdJsmrtJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eHxwz2GnaybaPt+ICMZwOzZYQeHekJbyOKobdY/suSCQqEPVpZnJCuEUrgLa8BnV7SlIgT3PGf6cR5r6BS8v7HccaRhltiqo5ZjsFMxE31sdfSULrsRqev/gREW8IKKfXm1IvtOik7mK3HxC/gCcpNmk60zySHVxCltSCAWQ+jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KnFwa1SY; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-55ce52ab898so6152682e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755598665; x=1756203465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mI+27DCsZb1xNev2FOWjFwDPtlqZqOZA1lWdJsmrtJA=;
        b=KnFwa1SYqz/iacHm0j6MWxIlCSeP2ZxkHjYQ1KjS/v0zsLeTb5Dd9jHzUVarrlV5Vo
         30b7IcActYWz09MGEPQsmTAdSUzfxJ9jc4TXSRrbcjgI8He2AK1cJCYeVcFdoFEfV+SO
         yZdiPMRWjpBuK1OHSyv2SbanvQJw1BtdBR5kJ9SgKqmYCmPMm4jv8sIgbGK98z7cv24z
         bZVb9YzwqSw/u5zfumwaZ14HSQYESHXwU8+uI0FgDS7m7lSRIjt46iKzZyKfS0rkSNQy
         l/Yk+GculYFInTLMqIyvMxEG/PcieER5Viq9nBBmP8CC2g9nTy5of7nMS3lQpw/XgApB
         f1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755598665; x=1756203465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mI+27DCsZb1xNev2FOWjFwDPtlqZqOZA1lWdJsmrtJA=;
        b=oTEuQq1z+Q7ZHe1p0Y4GN1OjmPzhTCaLdeOMjPjr6qt7HN2J3j3v5B+RCgg/uEMhv0
         Sfd8tPzxw/6OeKe5+POot19rqA+BddXuYu5v+Xnbt7ZEcdGuMOR2AU4fFiDBx5n2Dat+
         EMZ3/SHGYV/AHIaOMHy/NbaJ7wAz/XPH3rlsNluyleoJ/w428op+JpRxErMMVE2ao01g
         l11/TMjC8Tp0EGQUzHr6R+BvhPeLOztFFF4tXi7PZ5cE+zB9hXY578bFuh4+q+Sg5e78
         REwKHRoqPZJcFGqEnGSdjyYVP5vICh2Wzye1Iz128z8jSWaeqoJeSkYk/4Mg2JkHpWk4
         EGEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXl7eaNHsHaLdJCkkiVlTJvaH4ZeVTQbOlzkkO7wrLjRznO3uNZDNPjg4KVe42e2acxw51p6KbkzrdI53c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl4cWqQOisYb/9krJHibx6AZQp+dSXVP6gjDCk0suTrEIKTBvV
	qaHnmjorM0M15ENsUUrMtdbp3LUVWTrciUkKzF4dvutca406sd5I9Yw27wDHWjnW+L/cQQvag4c
	VkN97XpdgJwhq3+zB2446b3RYRvG6q9HAKRvKbVRasw==
X-Gm-Gg: ASbGncsGDx2p/wzkn1vrrsbvSQ4TdvKYqweWZJPDALJ7gAnfC3hzyPY6qcw5hT0WuVa
	YhCuHmUpppkus0NBOhkuHXGsdr70AUipmNrX/4KtszlposVps8xD7mIbJ5XSaNl54YDoCKwOl47
	zfJZ0hd44Ru089Kx9a/QhhM9X9q2vPgmO7e++X/t5y9j3kTY+8T09MI8/OuT9NPLSBY807KZgMT
	XIx7v2Ore6f
X-Google-Smtp-Source: AGHT+IHiB13v6ofDRBfj238q6m/OnZ2UwycLVlIeVJlojO24mSwpVb7ABxP+Y2+pth6WAptkaxKZGGCv9O4q9eeKwRE=
X-Received: by 2002:a05:6512:6286:b0:55b:8a28:3cbc with SMTP id
 2adb3069b0e04-55e00869ba0mr639574e87.51.1755598665286; Tue, 19 Aug 2025
 03:17:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812-gpio-mmio-gpio-conv-v1-0-9f43e95dea98@linaro.org> <20250812-gpio-mmio-gpio-conv-v1-1-9f43e95dea98@linaro.org>
In-Reply-To: <20250812-gpio-mmio-gpio-conv-v1-1-9f43e95dea98@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 19 Aug 2025 12:17:33 +0200
X-Gm-Features: Ac12FXzXb3piolgH_vHThrJa6suApvy9Xnpd7N8-_ULnt_2vbNUV0h72uiLUeAM
Message-ID: <CACRpkdat+HR6DC0xC-XzQ1V08QA6zqcp-PGPFfMoCWo5Y+efug@mail.gmail.com>
Subject: Re: [PATCH 01/14] gpio: generic: provide to_gpio_generic_chip()
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Yinbo Zhu <zhuyinbo@loongson.cn>, Hoan Tran <hoan@os.amperecomputing.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Yang Shen <shenyang39@huawei.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-unisoc@lists.infradead.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 11:52=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Provide a helper allowing to convert a struct gpio_chip address to the
> struct gpio_generic_chip that wraps it.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij


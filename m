Return-Path: <linux-kernel+bounces-872728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E86C11E4B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 23:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 56B0C4F9FE4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 22:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7FB32E73D;
	Mon, 27 Oct 2025 22:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lg2piTrF"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE51032D43D
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 22:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761605209; cv=none; b=V6bjbT3V7wateHI8ecq7kjbMwyNDBi0fnU11ZTLSQKPvSjqFP6g/Fk6GOjKAwjH+19Zz3jL4w7Tk/skOrqRvVrW3aF8LkqXTrVw1e3h090Tst/1u30GuX9tw+HlLMhnPDFo7i50+iKLfUtWQnRz/WS1Wv2dmRC4eZKdH7+iBjAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761605209; c=relaxed/simple;
	bh=ZzWPnnOZXKXFtrtRoq6w5dfem/sBKT4+3f4vAqBe2dA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cCoEJY1bvDx1Ha/Yzwd6NRPE0b7QQiCFa4nlifrori1hPSP96A5MBEthwiDzCeW5DamRQUW95mJFVMqSLWghEORuhj4KWFNerLcoRU9kNvMFQs3Jr51xdEl1nZhPOPUHDfjYyf2k8eHVEWgn+YB9z1d+vilDzEmyUSoCiaPBaCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Lg2piTrF; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-78356c816fdso54605297b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761605205; x=1762210005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZzWPnnOZXKXFtrtRoq6w5dfem/sBKT4+3f4vAqBe2dA=;
        b=Lg2piTrFtmJAqKxJ6VeXW4HVBFDh6ExN9b6wbHYawq9Ue/Oemy5aUWRGDAeBaUVSWL
         0qc56s8Fd9rOg2Wcyp5zDxjTU5qi/USEd/TsIGiW++zb6APOXbEZMIzQ09M2jUmSA47k
         uewJ4Baq83ac06n4Fgku8Vsi92c4YOeGAluUbghouvhpMotXvaXBot/syCKPB6w9d7dJ
         h8AUaS8h3Bvr1J0b8wRTTSYi5z8cD56NAt1xvf3jUDTNf6vNx/5AHDQPsE1qLhlgBNY8
         RNmtA2l6lI/gY/zEVglbFtpBFitoAQp/i6exFH9oY3XoHPguWYIkWFuFLFCJxrhZ47mb
         J/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761605205; x=1762210005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZzWPnnOZXKXFtrtRoq6w5dfem/sBKT4+3f4vAqBe2dA=;
        b=sUsd2JckV6C1gWrJDCywD9TwOyitfyWh9Bm+412EeWPJrgahO12GyD3iCxVGnZYtjs
         m2N0BDnlNyOyQw+0454JP7Ns9GxLJSRLA9qUb01fBSMHm8iC3d9NLoL1diEO5aQs0C5X
         GtglmSRE+78P7n6DaqSHNXj1mF1tglhQEIZ42sQPW3hCX37D8g/2zayYw1DDCUb/BBN8
         vVD3/ylsjoAIVsk+4MuvVv3epz/mbO40p30mTQ4R4GY/6cVDUGdf+6BRfjSH0GB1M1uw
         yQtbpRD+5yXCPsjzRRmOXIqj2euP2iXLay9lbT9V2eJJ+12p26yz5V8XAz17B4lsapIv
         OnEA==
X-Forwarded-Encrypted: i=1; AJvYcCV/RR/XhL0/NOcQzl9wdVMwyOz6oIRPcOVe524IyDMCqkTuTfmJUxBiCza5uXhIrdp239u+elWMO39lp24=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcRUHjZNpzR6EJn73HJpyK74HrtBUi6vlqoXxZ+G2X9ABZe6Eq
	GQv5h5IlbaGVU4WzlEw/HIsZhCmG8Zn/V8h8Y+OP5Zsu20HThz0a+q79fJcNdNMVKlYtJTqyb4B
	OrqGAFiWAx5Yvdc+VANRqoP9rK+cmmHcu0tc9MdButg==
X-Gm-Gg: ASbGncsTBVJFQAhetmL/J9t89mcbRqmSkOVfohjnWhWGbNIahqA5oevqBFtX0xpmo92
	+g0SNftJ1v7tz1RInIxQsNBIwQyz4UrEKopAuiE9cejjhPgMP4Iq1YDq6tjOyUwMCFr1kSV4M6A
	awXvSjr0Gx/YtJn8hIqTXodXkru54EcXqkpKL5LKTuPQvQR+je55kLXrs5LrSXaKqed0irPoTAe
	LymufbY6Hs03HqtNsBv4SROTGJC4v6b/2Duhj+jFNbKln0RKUiBxw1yMwDYyTHp9Bi57F6Dt4eb
	9KM4KA==
X-Google-Smtp-Source: AGHT+IF58gu9w/k3l8GdP1g5RlDJqG0NNSjKKeSe9p6ePIJR4FON1eLAwoxl+nhLHyhOGuGLmO/nO8EfMXRInSW0EWM=
X-Received: by 2002:a05:690e:15d5:b0:639:2794:3416 with SMTP id
 956f58d0204a3-63f6b9d159dmr1313309d50.19.1761605204155; Mon, 27 Oct 2025
 15:46:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027-gpio-mmio-refactor-v1-0-b0de7cd5a4b9@linaro.org> <20251027-gpio-mmio-refactor-v1-2-b0de7cd5a4b9@linaro.org>
In-Reply-To: <20251027-gpio-mmio-refactor-v1-2-b0de7cd5a4b9@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 27 Oct 2025 23:46:30 +0100
X-Gm-Features: AWmQ_bmpt0BdgJRwL5QER5dmVrqtyW3pITM-90osLs6GzKPhyaRFTjOuGCubgCQ
Message-ID: <CACRpkdaYUbMbVGK-qfUMuBij=+fNfzuED=E3NTGRP8jzR-QYFg@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: mmio: drop the "bgpio" prefix
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 2:48=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> The "bgpio" prefix is a historical left-over. We no longer use it in any
> user-facing symbol. Let's drop it from the module's internals as well
> and replace it with "gpio_mmio_".
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

I don't even know why it was named like that. "Binary gpio"?

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij


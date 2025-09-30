Return-Path: <linux-kernel+bounces-837165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 986F8BAB981
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE1597A6E0A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 05:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A8427AC3D;
	Tue, 30 Sep 2025 05:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZB0fMYa9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9414927A468
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 05:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759211707; cv=none; b=WSnQVHceKztVHv7JjdG9OXbNzZh1GWK4CS1kgsqyAcjlcpt4EGGzqAUR5uDp5qkRP6Y5VGbqgAjGWAsGEP4x9lJy6uh4IVY7gjfL1wGOTVaTfLgq2qZ3dBCDnoSfpY5X4tdmICKHHd9Pr0UdvaO4kcN7qnykM+x9zVIKX4kOToE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759211707; c=relaxed/simple;
	bh=xjANxMJTM9LPC3RWuEeyXQhzfMnAjgHK8NXmc9aojnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SQQO0opA4bf7waYXOJUM2KFtVWXXwzjv1zBfF9w+FLsJp3xq6reZ6MS1MknG/vmODozfqu3sKVNGk7ou4t7gmGzA93HtOqJXfwiz1pIfuXTfXvVbpfaxo9pt+mIceEbu8Wqmc6R2L5i29uZruff/QANj/AuQZQeR/YUWkQXvwuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZB0fMYa9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE49C116C6
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 05:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759211707;
	bh=xjANxMJTM9LPC3RWuEeyXQhzfMnAjgHK8NXmc9aojnI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZB0fMYa9XLkbh6rVUDgMHx3eQeX6PR4zSoPKI8u9xbuliqw9mfG4vwkZ3vND3le/Q
	 JPQrWYdQUO6pxbODiHiLSkfo/nJLphrgwsstttU/by2x23vwH3kT6S396YvdyOhsVB
	 AGVq2hZIajauw2YLR/W5NS9h5SfuUFqEkDUte8AakA9H1YkVpK7KD+/Qhqj+CSMPDX
	 botGEtmtgW2kJrZLIhdPE9QJ/8oR6wIQp70d8BfB/FqU0tLY4nu96ob6hl/nkxp3Iv
	 ZYPixFUDAaHATPyDWhq9Wx00NSCGQVkAwxGKvoJsiWHUYRlJhojrlM3Iyc+znkCn9W
	 mL7tGx1KTXr5w==
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2897522a1dfso19033415ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 22:55:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVN19OzgjHvY9eIrv13a4xn8xqs87xcwEIN8OAcoUHBemabTuRSWeCQUpPg4cOtXifcOgRmFWPa4hfsgSA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt0qUcPREzcxzf/aevtQpf9pJUiPpFXAvgnjAbxtPsKQdPPmpY
	M1CrvZewQCGfd0qS8cdU1N+XbZXJH2LSTAEP6FnJOyKSK7f0VrX71GKBM080dQiBt7SwArghB6S
	YynRZDbHkr1Ktqmp3jFwM1CrFtfO5YUw=
X-Google-Smtp-Source: AGHT+IGmdGRI0LMi5UqhtfOWw2y8t3L5Y8DIOORexgZS1OILavNgX8DdiClZ3me4wlwwJibUM+KIj1389jiCcZaA8L4=
X-Received: by 2002:a17:902:d2c1:b0:261:cb35:5a0e with SMTP id
 d9443c01a7336-27ed4a74481mr236897635ad.57.1759211706568; Mon, 29 Sep 2025
 22:55:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250930035551epcas5p4ee7cb5af08eadb2f5ed6e5eaa06a60a9@epcas5p4.samsung.com>
 <20250930040348.3702923-1-h.dewangan@samsung.com> <20250930040348.3702923-9-h.dewangan@samsung.com>
In-Reply-To: <20250930040348.3702923-9-h.dewangan@samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 30 Sep 2025 14:54:54 +0900
X-Gmail-Original-Message-ID: <CAJKOXPecLREbEDM4yfM=WD-EFfuBqPDXNZceATLeWQRj0X_w7w@mail.gmail.com>
X-Gm-Features: AS18NWA-eQpZ7RgNI6Y84_mjkYb4V1iHJZQyw43DMe2SjRnOaTW2ugj0GBT0nqU
Message-ID: <CAJKOXPecLREbEDM4yfM=WD-EFfuBqPDXNZceATLeWQRj0X_w7w@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_08=2F29=5D_media=3A_mfc=3A_Add_Exynos=E2=80=91MFC_drive?=
	=?UTF-8?Q?r_probe_support?=
To: Himanshu Dewangan <h.dewangan@samsung.com>
Cc: mchehab@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, sumit.semwal@linaro.org, christian.koenig@amd.com, 
	alim.akhtar@samsung.com, manjun@samsung.com, nagaraju.s@samsung.com, 
	ih0206.lee@samsung.com, jehyung.lee@samsung.com, 
	linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Sept 2025 at 12:56, Himanshu Dewangan <h.dewangan@samsung.com> w=
rote:
>
> From: Nagaraju Siddineni <nagaraju.s@samsung.com>
>
> Introduce a new Kconfig entry VIDEO_EXYNOS_MFC for the Samsung
> Exynos MFC driver that supports firmware version=E2=80=AF13 and later.
> Extend the top=E2=80=91level Samsung platform Kconfig to disable the lega=
cy
> S5P=E2=80=91MFC driver when its firmware version is >=E2=80=AFv12 and to =
select the
> new Exynos=E2=80=91MFC driver only when VIDEO_SAMSUNG_S5P_MFC is not enab=
led.
>
> Add exynos-mfc Kconfig and Makefile for probe functionality and creation
> of decoder and encoder device files by registering the driver object
> exynos_mfc.o and other relevant source files.
>
> Provide header files mfc_core_ops.h and mfc_rm.h containing core
>   operation prototypes, resource=E2=80=91manager helpers,
>   and core=E2=80=91selection utilities.
>
> Add a configurable option MFC_USE_COREDUMP to enable core=E2=80=91dump
> support for debugging MFC errors.
>
> These changes bring support for newer Exynos=E2=80=91based MFC hardware,
> cleanly separate it from the legacy S5P=E2=80=91MFC driver, and lay the
> groundwork for future feature development and debugging.
>


No, NAK. Existing driver is well tested and already used on newest
Exynos SoC, so all this new driver is exactly how you should not work
in upstream. You need to integrate into existing driver.

Samsung received this review multiple times already.
Best regards,
Krzysztof


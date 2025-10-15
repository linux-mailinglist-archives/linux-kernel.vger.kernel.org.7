Return-Path: <linux-kernel+bounces-854751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34710BDF4D4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ECCE404B1A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E0C2FB985;
	Wed, 15 Oct 2025 15:17:12 +0000 (UTC)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121402FB97B
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760541431; cv=none; b=PjsoP7paX9pn8TO5fT3WAW3+bTiSZrtO0i6gTqQXhrJDMAvY548AkB91SP4UbB8sejf+L76AOFIgMFGKJ8FAoF1hcDKBLiTNvuKqm1ipMajfiZGDjzsB/MdPG/y4RVGkji5K2BI9NZSuelJGAclGRKMjYIBaVwCsqvGCVg5Viaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760541431; c=relaxed/simple;
	bh=IV+GRifs/CZH3mBOt11ulcvrcGNrA2ckYSmyBrRV8vA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z863EFjJfCk/O5NriqOXnCV1/ief98mOYZ918QWcM6+N5IrVsK7QEkThvTbo2Ryvj7xGtOvQ9gGOXyBDUTKHbSwZdOD9Ge+p1UXXeiSSrc35iS6NXeSQsSow9tWaHlCJ8t0/FXhaDEgk1n9WyjrUf2a56m09eb8jtDpEGxMW33c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5a0d17db499so5874642137.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 08:17:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760541427; x=1761146227;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gYlOVCW4Ai0uf6Aunon5QhuALTLV1R3/6FPdAypUrZU=;
        b=DNS2nXszahJUls/MwXHzg8KlkgFc+Tutu2Cwg9VR5dQ4Kf6HZC+ZGbpddZ9RHMxtnb
         N4DqhQC43IpZiE//kPvYHhg+eWx4C1fud17TCY1h1aqU+SrJOY9tDN6N5Tthc4vX9Zqx
         5mfXCX65ZMVQAbzHt2VMu6NXku1DuK3GO2a8uxsCmYiSuf0YPM9kUK999zSC2R4RDu1C
         n7Bl96JBC2HnD/GJLLsN/gc+3jlepBqb2ObLFAF2xc/J98HS9CJ2ruSaEuc789T5cr1U
         pt1+suxlVmv1FN7n5AuFY5x8yAPiGiquwQc2nSTaFqI0CCwTnc3UGRmjxw6ioE3qEijV
         wVVA==
X-Forwarded-Encrypted: i=1; AJvYcCUyE7gdKUu/mPgKUHeYCMSwhtzzg0RCmGuf51GHyC2EgcPlmNO16G9b4NiJsRrPoqd1bkAHD4FVhRsIMyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YySRgbUfQ6vb3WCcEjWIrCVAu95OwE6wz9YwqZkFnIll30k/R6x
	azbbUKTw8Cf0knnWpB+Pt+K6pVM4OgIjwlg2ouNvTJw/wFr7I6S8s6oYAD2BFhrg
X-Gm-Gg: ASbGncsO24QpGvTFoWsMEqlshIoUK31zqvlcXuR71fOZlVrJigmksqBWes0k3vtmdnC
	jGfLGAYHXOVBBEodvU9DAxbdXEtrwMaHxajbzK8vhtcKrahCDKWr4g0z5R8FWX+PaCUvzm9fizX
	ZUhhKQYcvXM8HbIWfDD3HEixxe5euSFt+QHvqbrj0e2hFH9js+E+spdHRByz6rcaH7pSdETaUUu
	adBW6YOK3lElMfQ5LXhA8zohxQsrEZ9lUJlL1uzmvjIdC9Blmmq8dAyA/xu1PxF1xe6xfL9SHOt
	UA8npAVs9D2oj1dSj3twBUmf2Fq8RdErOAYgf5SoX1WHyIgEwrW9wXnWQr9bUSXQXYcHBltTz30
	anr5qvVTfH2yEl5H6CpSAvZqEDZ0f52DhoROwl+qQ/zcm60jdtBAqbWN+vfMBTnK8rSk23wuIP4
	zWu0cw/9r6SCfDNg==
X-Google-Smtp-Source: AGHT+IFl7UlAen0Cf/1vMbZ3nmIowT51D4BjC8E11ZEYx5wj/tBgAwxEFiGecGih9rjaUK3mULjKQw==
X-Received: by 2002:a05:6102:3eca:b0:523:d0d7:b960 with SMTP id ada2fe7eead31-5d5e236156cmr11806216137.29.1760541427401;
        Wed, 15 Oct 2025 08:17:07 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-930bf6cec14sm4531782241.8.2025.10.15.08.17.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 08:17:06 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-580144a31b0so3275411137.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 08:17:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWCaABY5eArjCkOZ091/E5YCaV8TcIPpGRpicNPzhZDENT+Bg1PK8BwZbMZ4WZb3fZoph2Hg7sNb+FgcUA=@vger.kernel.org
X-Received: by 2002:a05:6102:80a9:b0:56c:eed1:276d with SMTP id
 ada2fe7eead31-5d5e2323cfbmr10980364137.18.1760541426765; Wed, 15 Oct 2025
 08:17:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015150728.118296-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20251015150728.118296-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 15 Oct 2025 17:16:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVUos1===uyOVwVTsmqpf321sX-hYJ36L6LKdR62sC23w@mail.gmail.com>
X-Gm-Features: AS18NWCzpNv-DwB-GZVXUz-0WdBwxHutFcnJYtynPXM4j5XD-FsH8-0maASB2us
Message-ID: <CAMuHMdVUos1===uyOVwVTsmqpf321sX-hYJ36L6LKdR62sC23w@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: defconfig: Drop duplicate CONFIG_OMAP_USB2 entry
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Eric Biggers <ebiggers@kernel.org>, Michal Simek <michal.simek@amd.com>, 
	=?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Nishanth Menon <nm@ti.com>, Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Oct 2025 at 17:07, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> CONFIG_OMAP_USB2 is already enabled as a module in the default defconfig
> since commit 8a703a728a745 ("arm64: defconfig: Enable USB2 PHY Driver").
> Remove the duplicate entry to fix the following warning:
>
>     arch/arm64/configs/defconfig:1705:warning: override: reassigning to symbol OMAP_USB2
>
> Fixes: 91fe3315cdf9f ("arm64: defconfig: Enable missing AMD/Xilinx drivers")
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2:
> - Added "Fixes" tag.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

As this is not yet part of the soc tree, I guess it can still be fixed
in the original commit?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds


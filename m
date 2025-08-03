Return-Path: <linux-kernel+bounces-754447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 451BEB19463
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 17:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 672F8171FCD
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 15:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FE319CC27;
	Sun,  3 Aug 2025 15:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b="DkkXbZTb"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAA32AD0B
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 15:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754235238; cv=none; b=NmiGi3nFp9faP7uiCC/AacJze2m+nR7FWl0+6z6rD/ipcRqQm9GCzjyJARuJOFvyQ5kPob7xSS8Glw6Y+b/bthgpmLfNT7k+IXh/CX4F1gTIeSo6HSzfnpyeVXc3DAFgp4mOlTEesULrG7Mc498/szsewaRI++5uuEtSpaEECe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754235238; c=relaxed/simple;
	bh=6plFrRxfu+8N14R28roKX/MHWOfxITkJEscV+Weov4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Icpl4DT6usILIdhddlpZfh+ZEDhQnEIeis1sg5i1WxakFwAqYvau8JmYODawtId2dnRSq0grQ9KhhHjFbzXC0bi3b479AZ1up4G0F8iqW+cj9rjmvF4dLd3wSBIRYc6QSPayPE54PqxUjVRIniVPKHHgqHZxhU1ZNQ+Wdr0Lz4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net; spf=pass smtp.mailfrom=tomeuvizoso.net; dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b=DkkXbZTb; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tomeuvizoso.net
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e8fd59484f7so2539002276.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 08:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tomeuvizoso-net.20230601.gappssmtp.com; s=20230601; t=1754235234; x=1754840034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSwmiYk+M5RmmFXBcZY5LfJlQfD47hJoEsHcQyHy/YU=;
        b=DkkXbZTb0kkMPuEeQ4Irl34FBI68Q+yuL5MfZlJmOyvs2XnwOUcFJW6uVVSnOQGagY
         ScNV42Y+8jDOxo77cgvxMlKT8LpRF2t41MD+/x70GYwP+yS5QH9Ebv15ZTKE40Iq762h
         ehZi2Apmwbqgy4tsjBL6gERvGEzGq8NeIkW5m6eyR0CGy2KoIb5hLfcCoz5AUn7pwtz5
         wXuVwekkOhkOSUz8bY0EEJwtSQkrv+RihOZgXVQ5ESi7BDI3q66LKhyUiaKwbHt4I1jb
         r3YjVKmsrB71K5IkAhkrGbVS676HEViYB6/57MhPYw+yvLYoKbQq6Z0W6iEM2v0NSID6
         AUhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754235234; x=1754840034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSwmiYk+M5RmmFXBcZY5LfJlQfD47hJoEsHcQyHy/YU=;
        b=e2bLusu/FjBPsLQxTWnLreGcQqDTCFBdchjN3cf2NFQWqpGbMcKegiZL4WsbA7obii
         WGrtZesHhDg1DbphO4SOdS9APyWi9dOTxEcNwHL3KP7z43AT9AJ54njkLr8TScsTPA5D
         BFz5ddh9H7qEpfo9cDviCXE0BHEAXbKu012vm07lrseUP01KQEVna87VpQhb41/lGDtM
         kuCZzaHjJ4muVdyMXmlwNboVIa6WZ2A+ORPsFYLGOL4HOKCqddfA2sFqgQA8BVuJQPZi
         oVnCO1xKBCUi1vCbrAGkQTi8tVH9pgFlV6LQ1j2JDdA4EuvHA3jpZPxCpreUEQx3sSa2
         uVgA==
X-Forwarded-Encrypted: i=1; AJvYcCUXKEod0wJAuMaN2XKg14H+Gy8FaiwFKxcFbIqZQEZusobmhj+TXLIr+a96lhqINdwwceW4OIo0ubHYXqI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy04zsRStMnwQk7TSrtzFnmJjBRs4oqCZT/eo9+sMsPDlc3x3NK
	U+9OMBMtVY+LNjT+S6e+GNp41ImKewsvlSQ+K0YafaYjiMUchRUFRXwUORIW3HB+r8xhzUlT6RI
	muefn0h4=
X-Gm-Gg: ASbGncuHf3l2TM0rXfW6hxpb1pshxZMXWbKtqgfnXJWxGnn65UREzbzeghAD8F3Cukp
	X0F7x9XPpN/za34uvXAlX0uMIUvEBo/1GxoQVUd0WgTABsBUcMk3d7S0pSwhP57eORAmqkocsTx
	Gb5lCPDg0LhlYvGfVqzGCMQ87cC9T0KTeJA8oLpP0ThoxaWxE7oxXh2GXJQl4LU6xdXymN16ugv
	BbsesnIQB2sf4NfJFzY1JZ0sAJF3bgGXjU1Jqag7VbZ611t7j+JvVrhqbr8hm7LMH/nff7nhY3t
	fdG7tfHFwlCDXXggCRECFmD6+rda8czg2pPR5Ladk+j7xX0VbA6xy3z2L1cAyp6bUH3ahjqC/Lu
	ve/pXUsowRAdkQaw/aRfML1Hte/3HX7O4XfAyN9nLBBDykghiCzGuRefvA/8H2nTdlA==
X-Google-Smtp-Source: AGHT+IGBhlPZPYOd9JLLyLI70H8wRqmFpLL2sgS0LeLqvIXnNqUSZV/l0eR4V1gXZ+kb9DpDC+5YMw==
X-Received: by 2002:a05:6902:2b88:b0:e8e:2888:322d with SMTP id 3f1490d57ef6-e8fedd8fb94mr7462777276.2.1754235234571;
        Sun, 03 Aug 2025 08:33:54 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8fd3750306sm3133555276.13.2025.08.03.08.33.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Aug 2025 08:33:53 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e8e1f488b37so3391226276.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 08:33:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVyRPgBc6aHEGhZxaHLkMU4UpjgFBFgITpkTOrcpMGPUxqlazx3nrwfVEywb+O/53VYN3GNKUNVSSy8jpE=@vger.kernel.org
X-Received: by 2002:a05:690c:7108:b0:71b:8cc6:6d41 with SMTP id
 00721157ae682-71b8cc66fecmr55025047b3.17.1754235232707; Sun, 03 Aug 2025
 08:33:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250802-fix-rockchip-npu-build-v1-0-fb0f0dacb3fe@brighamcampbell.com>
In-Reply-To: <20250802-fix-rockchip-npu-build-v1-0-fb0f0dacb3fe@brighamcampbell.com>
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Sun, 3 Aug 2025 17:33:41 +0200
X-Gmail-Original-Message-ID: <CAAObsKCUs0yn=S1PzGDKu8nNnTOkxqMMYzep-QhG00X1CY3DjA@mail.gmail.com>
X-Gm-Features: Ac12FXxPVQwjDAIVgxnyFNwyCiKtQqDmuUpUnwaIigvKfVmO2D9Sk5m8K7Mojy8
Message-ID: <CAAObsKCUs0yn=S1PzGDKu8nNnTOkxqMMYzep-QhG00X1CY3DjA@mail.gmail.com>
Subject: Re: [PATCH 0/2] accel/rocket: Fix build errors and sparse warning
To: Brigham Campbell <me@brighamcampbell.com>
Cc: Oded Gabbay <ogabbay@kernel.org>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev, 
	skhan@linuxfoundation.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Brigham,

thanks for the fixes. Will pick them up. Hope you don't mind if I
change the subject of the first patch to something a bit more
specific, such as:

accel/rocket: Adapt to changes in drm/sched API

Regards,

Tomeu

On Sat, Aug 2, 2025 at 9:25=E2=80=AFPM Brigham Campbell <me@brighamcampbell=
.com> wrote:
>
> Fix two build errors in rockchip NPU support code which were caused by
> the integration of recent changes in the drm subsystem.
>
> Fix a sparse warning regarding an undeclared const, rocket_pm_ops.
>
> I tested these changes by enabling DRM_ACCEL_ROCKET and recompiling with
> `make C=3D2`.
>
> Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
> ---
> Brigham Campbell (2):
>       accel/rocket: Fix Rockchip NPU compilation
>       accel/rocket: Fix undeclared const rocket_pm_ops
>
>  drivers/accel/rocket/rocket_drv.h | 2 ++
>  drivers/accel/rocket/rocket_job.c | 4 ++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
> ---
> base-commit: 01ac6e4e53b6351df42c97d217b0d2dbeef5c917
> change-id: 20250802-fix-rockchip-npu-build-ca759ba8da06
>
> Best regards,
> --
> Brigham Campbell <me@brighamcampbell.com>
>


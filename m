Return-Path: <linux-kernel+bounces-768501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AB0B261B4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56F1D188C39F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406172F6595;
	Thu, 14 Aug 2025 09:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b="f75fpVW1"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E591D5CD4
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755165400; cv=none; b=MAmU6RG6hjCKWwX1tlE1NxAlII6CYawXAPCTzJt3qCVtmp1ZdOzT/iZEIE9W5m5ouq83Eu4Gy3XdZapNB4DAa5G3AgruWvaDpjI4zdct12esnGdpzkId7GGju3OyS12PwF6GpcGhFKZwD2pTAzcVR/smWgZurSFDaI7T+NkOGYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755165400; c=relaxed/simple;
	bh=XI+YZTYunV2FqLAO3skSJTb4W7Qs6U1jwE5Hi8RZbYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eZGtaFRsf3CdmRxCKHM9X92fq/23BQF3rq/GiI18QYeNqcrPzdbI/40VKU13kNXAw3A8yWdKZ+aBdjXdJWKzXOb4tiuPrxRSEoAntVYQm3WZO2HuEe6Bk31Ux8VJadf3gFmWOfMmrU+iaLL7l1R1chX/geO5j/P4K9mY2hdEQjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=pass smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b=f75fpVW1; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fooishbar.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-323267bc2eeso599737a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 02:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar.org; s=google; t=1755165397; x=1755770197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XI+YZTYunV2FqLAO3skSJTb4W7Qs6U1jwE5Hi8RZbYI=;
        b=f75fpVW1ZWfbVKH9zHMahO30uFcrDe2R5mXgUFNvOap6xFJm8dpoNZSNdz7gWBL5Ko
         bA0+LbnjPE0jgB3/Ap8BHVNsDhObZfdEom+l6Y0SD0ZQZyUiJeif5pGYfzGMB6pAQ3zA
         s2Bl1rhuhwEtUCg1BZSCOSA+v2vggqz8HPpy/uSgdq3eCrvariLsAuCP8YqJ1AZdRrbW
         zrnS4aen/JyePT9vpYyu0nqcP9zF0+/Fxh/3Ruh4uPM8JO75vahHW1bzgc2fniSRLSZP
         fP5nkESvFWXPNQHvPmWSRilEsnCOuJ0uPuY08Cm3EVLvHcQ5nu8KWeGzgyx/L+4fb9x0
         Ry8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755165397; x=1755770197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XI+YZTYunV2FqLAO3skSJTb4W7Qs6U1jwE5Hi8RZbYI=;
        b=q7JTf0hS39aI1/ED8QQGPdQUDmwOXnv1GVcLkcSC+KeNuEOBNkKZDIfIEH4UMD6Khf
         r7WKmhOqpSAHD7sGrYpX2XrKxvyf0gLhwFFzUpJbLnmMCQ9qY/+DsnmwSIqaJf0n0iYH
         MIdvGFab1v53cpADnFtZt1fx0GXPh5qcgE7pX8AauGnMg5gaqBpQ707SyLffUO8PlWgC
         wYANTjDm8p8wImKowCRJzJEzB/mkvMg1NHods7BLGCCJPPPOwjZ7NUC+7JKyk774FAfn
         mQRt6EB5wnm84ojTKPUrpvQiBxIy8obI3Adp4K94mxKyGURVGnnWWpLzeCLp98JTiXTm
         7IIw==
X-Forwarded-Encrypted: i=1; AJvYcCUIPZemp81yqnKKKXSyxGJByj928z/1ccFtZIRryA+SxsABsbY0CxDx0rsAMvUXtwMbdM91+fbxtU59m74=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8UhGkk2ba3ypXNpg+qX8xmcmwmYHwC7mmu0ptRvhdJAioEHsq
	GP/ocMP5MSMUtLSdqOONN65vy658ZR/3pgpEZ+Rc7bopSlm539UePQLNl+2ZzpwD0zaXXiJ0/S3
	KsFMOrU/1fvT5x88iicsY9RmsrecyibuQAN9az0rrGw==
X-Gm-Gg: ASbGncuCptMWR0NHcheyVi5ila+xxPF7PHEF2uvmIaz54RrriJOM6xivczMbt/60M86
	kONmN7uTK6xqWBmPgawb4lGt/5exMg5QwWhd3WBEpEf+xDeL7/IA6pJWKIRx0MR/wJltGQHTbqb
	zLiYlz4Y/kwFJ0zaPT1u5YA+TFJMGhmnhnyyno04l1oEZZAETCnG7jEAQ9gYpnjGhlsjkmP/xgE
	bjcq0iQrk5eX1bbLAA4Y9eoTgwG0XjSNH4z8AaRvA==
X-Google-Smtp-Source: AGHT+IGaR4zZTmwDXSgdhaPo1egDiTcMG6nM2t2wCL37J6YMrH29xvG0jOt6tRf9GiV1p2rkjpGso17ibnqCGKeq/Fw=
X-Received: by 2002:a17:90b:5387:b0:31f:28c4:e1a1 with SMTP id
 98e67ed59e1d1-32327a63a4emr4480080a91.18.1755165397484; Thu, 14 Aug 2025
 02:56:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703-b4-new-color-formats-v7-0-15fd8fd2e15c@bootlin.com>
In-Reply-To: <20250703-b4-new-color-formats-v7-0-15fd8fd2e15c@bootlin.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Thu, 14 Aug 2025 10:56:24 +0100
X-Gm-Features: Ac12FXzUVXHq06uXn5xPUOGU0dlc09ccWHz8Yhyp2iyegiiKJqVAUdQEfClT-RU
Message-ID: <CAPj87rPos9HbByo9Dm0sQHDepYVp7O=PdMFaNMZzTZMdp9-JvA@mail.gmail.com>
Subject: Re: [PATCH v7 0/8] drm/vkms: Add support for multiple plane formats
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Louis, Maira,

On Thu, 3 Jul 2025 at 08:57, Louis Chauvet <louis.chauvet@bootlin.com> wrot=
e:
> @ma=C3=ADra: For the patch 6/8 I just removed the comment about yuv input
> size, is it good for you?
>
> This series introduce a macro to generate a function to read simple
> formats. It avoid duplication of the same logic for similar formats.
>
> In addition, it also introduce multiple "easy" formats (rgb888 variants)
> and also 16 bits yuv support (P01* formats).
>
> PATCH 1 is the introduction of the macro and adaptation of the existing
> code to avoid duplication
> PATCH 2-5 introduce new formats with the help of this macro.
> PATCH 6 adds support for 16-bit yuv formats
> PATCH 7 introduces a macro to reduce code duplication between yuv formats
> PATCH 8 adds support for P01* formats
>
> I tested the implementation using kms_plane.

This series has R-b on everything from Maira, and you can add my:
Acked-by: Daniel Stone <daniels@collabora.com>

How should we get this landed? Let me know if you need someone to help
land in to drm-misc.

Cheers,
Daniel


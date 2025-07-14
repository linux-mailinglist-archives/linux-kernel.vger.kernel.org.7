Return-Path: <linux-kernel+bounces-730778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67533B049B1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 23:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3B081A61307
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 21:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A750F23BD0B;
	Mon, 14 Jul 2025 21:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i529M+Vu"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D3A190676
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 21:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752529642; cv=none; b=SXAxJskjOxPyv2zlurCcURjeB6vCU7tup8UAMkGMdsorMMjGjgV7IE5NFnoouZVJnU8ZaunCuQobOHV1F+ix5LsKcYFUv8kO7/ni/4++squcFv4TpLNQwUjHgz3EgmgsEXwnU6LwjG9uMcDLI5i9Wze3SQgfS12cw9ENPiYACR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752529642; c=relaxed/simple;
	bh=mX8/sV1fn5Q7F0h2Lt5vjP3RB9JOKY5pvZwp8mxYjcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZZhWFFhtaBLi2EqY4RUrXXho5jdAOjRYneW7FhtQGpaxamO7B0GMsuDq2vr/vKDX13eQC9dvPnJY+f9edJvyo2/r1NDWwqA4ajz8rR7hyHGPl6WbioUB/F0pibviWEEcL3yny+VpFSnpeg8m1sVioEGz7tPJJuGIROZTZiH93gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=i529M+Vu; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-236470b2dceso42354725ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 14:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752529636; x=1753134436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KAFEjbZF04jSsLnT35V9ZUTLej5gO86eh46Ao3TCLs=;
        b=i529M+VuEo9Hun+4Re29ujz8MwfcVOSGo66unhdYqcMZITIsaX7wZH3DfzQb11ke2t
         sDvpU5/An4atAd737x9FFGEbNQtCbly4OsupJ9kDC6HpO6Gk8G3eXdyOqGSdpYAO6QW6
         iIm+M2pTOc6ivt4YRrDWw3eOYW4oqvLNhFpAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752529636; x=1753134436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1KAFEjbZF04jSsLnT35V9ZUTLej5gO86eh46Ao3TCLs=;
        b=QDmvX4LVJmvvEHL2UZEwX2c9A+xlHk70Hy5p30Ca+MSYHwjuPEuuiaKYqhqi2HnWOt
         yPoz4CojnE94CUbY/7dgGQ06CWGDDu/MEcd1KHSvMLlNDdISxODXaVKXnArm4+t3UNrL
         /8cGqIYBvsRQgJDYEMQ6VoDGbOb0PjEpOSYWbirpznRddBh3REYwaeu4FAUY21oYqsKl
         DqcVtvnxxRDHrrLl7fcjGIwMITRiDOJpwmLIHKhU4mN/mQ4/Xj1nH/kxBSnnL7mJDFSA
         OFkDxVu7zG4TdKrIT+2Pr9i4HUJJdODJJDXkX1Sdw6oMEOZ68rSi9LoHnnb7ZMaI8LC9
         zDGg==
X-Forwarded-Encrypted: i=1; AJvYcCVNfCUaYQIJr+kdpnKq2R1r4fN8xVSgoj6BWHRiKHmXj7BNezlogLpbffCHVxgwI7Fp0jIZYChXQI76gdY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+rYCNZDsX+df3xOtVoDNfkwISIiFkVKx9ybtpQQy/Hpjy24HH
	pl6XoZ+bxLS/dBVKcYJXH9FiEoxZjRGjVGStGhW8bZt2PgzjglGsEhB2Hnn1cfPAIC7ujmsJWJw
	Pyz8=
X-Gm-Gg: ASbGncsrNHIurbRV42v1y4OSmxaLvD8aR2GATG5b0O+HlOu+RNZVEbmucDWiZmSlv35
	0d/g2L6hAE2Q+9Hv72e5Hj4iHIZ2H5sNC4YNkbvFNz79K9ShkFFgPVz8pzcHS4p0KCS0P/JSJ/b
	ohbY67bJp4xuKlpt7+lFajl+O1Yw/ODGbwd/gQV+tHqcG/Mad+7ho1WdptvE1zLqfnHsETl+Flx
	x8aYfeYjvBNeRrZfJU7OFfOyb1FiCC7mpX+pyQxMUGu0he1A48gDAojJtEOYu7p0dLNJMD5XzSs
	CLZOB1T7pNsJF+cj5QhhNVp7oqy8Pb5xuRh5MEbNMC7JKv0aa1rymezwqBQyyZ5LLP4m+8lvYn1
	PL7iBwSHRQhlqLX4xwxo3XfWenjGd5k4R6bVJMu8zZd+f0ho6mp45q3pniCzMNGCF7w==
X-Google-Smtp-Source: AGHT+IH/B0CxfsikvFe5leyaCIexqOuXY+jPRWxhH04dfNV7dR/cih8rMtTU+dLcEkQxEE189N9k+A==
X-Received: by 2002:a17:903:244e:b0:234:dd3f:80fd with SMTP id d9443c01a7336-23dee188859mr240306325ad.2.1752529636546;
        Mon, 14 Jul 2025 14:47:16 -0700 (PDT)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com. [209.85.214.181])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4285ecbsm100245835ad.48.2025.07.14.14.47.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 14:47:14 -0700 (PDT)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-23636167afeso43262315ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 14:47:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVMY0i7a2rma0zPjP0qiSmvgoUfXxbvvzZQnXncEE3jcVL/zqi6hiYOay+AMiH1M1wokBDXjekedWA5rDE=@vger.kernel.org
X-Received: by 2002:a17:90b:2f0b:b0:312:959:dc42 with SMTP id
 98e67ed59e1d1-31c4f4b7cadmr23322054a91.11.1752529629493; Mon, 14 Jul 2025
 14:47:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708073901.90027-1-me@brighamcampbell.com> <20250708073901.90027-3-me@brighamcampbell.com>
In-Reply-To: <20250708073901.90027-3-me@brighamcampbell.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 14 Jul 2025 14:46:57 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XgOi-ySD=cog_qcV0UUU4Ni1VAAnkFS+kQjdjOe9MMsg@mail.gmail.com>
X-Gm-Features: Ac12FXxH2F0TYcijyhrCQmsQ50QRyPnFNI-fpx9VJR_jePJEeAOSnJSau6lHn7k
Message-ID: <CAD=FV=XgOi-ySD=cog_qcV0UUU4Ni1VAAnkFS+kQjdjOe9MMsg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] drm: Remove unused MIPI write seq and chatty functions
To: Brigham Campbell <me@brighamcampbell.com>
Cc: tejasvipin76@gmail.com, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 8, 2025 at 12:39=E2=80=AFAM Brigham Campbell <me@brighamcampbel=
l.com> wrote:
>
> Remove the deprecated mipi_dsi_generic_write_seq() and
> mipi_dsi_generic_write_chatty() functions now that they are no longer
> used.
>
> Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
> ---
>  drivers/gpu/drm/drm_mipi_dsi.c | 34 +++-------------------------------
>  include/drm/drm_mipi_dsi.h     | 23 -----------------------
>  2 files changed, 3 insertions(+), 54 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>


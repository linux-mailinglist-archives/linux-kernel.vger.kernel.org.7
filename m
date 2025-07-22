Return-Path: <linux-kernel+bounces-741218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F93B0E199
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 18:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0B10565FCA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD2027A90A;
	Tue, 22 Jul 2025 16:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XSOsjRh3"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FED4685
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 16:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753201255; cv=none; b=ZYOq8pvfT/rU3EreKwfYghbviSHWUsoFC8LcmFhzzYn4w0CZNagOq8SqcQZ2+SwIA9dq7MCvfe4Wfh8MwjxTlxBXBXVmg8CCS/qxAIaWD5V68h43yn+6BT27Pe08mzHzqng+M5JIJZnDNek5viDnmuATZ6GOOxKQWLy2XCRCeJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753201255; c=relaxed/simple;
	bh=9NhsPub8Dwc9EnXZIJv3NRiBAhBjEG9mmwT11504ntE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BmQqZmdCVsTM5CBLsuAdkC36s5BwSAQrvWdC+AES4PeHSzdDetIhQmdUX0Q2RyUQwhn4Iz6tRNPPMD9lZyV2KKaZwf6JjniQWWkoigI+trlu03wb0tvG99yH3Nfv3dmC+v57dKr3uIYBxcOwTqQLVII35yMpn6bu0Ucof+ABLr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XSOsjRh3; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7490702fc7cso3632631b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 09:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753201253; x=1753806053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZwHRFu4FSql/d/NwVvAy0lekcQX4lLK0gqetRRULkuc=;
        b=XSOsjRh3+SQUa7NE2KLrw2fV7LnvJFVNKp83cUcUPHc9UIkJOJVnpJSLTbsIbTO4HC
         NiK38T4zV4/HOMFPi2lNz6YjPd6Xv1eacfZZzGLjfIN5Dd7qFxOr2soA+4zBEz4Yeyp+
         wQiAuqbeGXAi+V2KTgpTbWzIJ/Vgl7/8RoK1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753201253; x=1753806053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZwHRFu4FSql/d/NwVvAy0lekcQX4lLK0gqetRRULkuc=;
        b=YWYlKlykuPmK3X0XdmPZfKfYaKxAyd6lNUGb9NM1P2o6cUFvRalkM/H8VcoYW6hMDR
         JFEtj1MVL7CjSi8vYt80YN6ygPbyKfQA+NpMPSOuH30vDXbraMc4oj4s4wgF6FrmYtoQ
         TIXUr870h7ARkbZZ+LpSo38qW4kUm2UxIXy/E9NZfAubORdRp7ruYj1rzHcjOso08I05
         mMBhcy7ntgNFI8v79PJVcuW0X6wP+bhRpUL9wZDVH+cE6aD3e9wlOdQrz55DNeM8M7lf
         fwohTydQSfV+ChK425bNtxnkpKEAUnUe8BZlhxfRMipg5qFpXxaoKECQDFln+9mhcFvO
         +Uow==
X-Forwarded-Encrypted: i=1; AJvYcCVwYIZqYyVth3q3+uCpJo/pHWIcWD1IGpL+kEbJKDHtuhBIR7STR8gTCAPIXWfnZ17p26HlF7V5aem9LxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YztaGMxEvmng56xJKQSeZRQU9h553aHPUK6ztqDrTFE137LGwi4
	p1VihvtB1pPXoo5bu6C8XXSZ6CHZSDu7xPFE1VpW5UOLWe2GlNb+x8dcOFFaUC2fa9rzh8jAAVo
	uEk4=
X-Gm-Gg: ASbGncuV6wjuHcw3MbFXAwhHKAE0m+xsm+70qw+mCqzqbpYgEvWfOnJC44xL2nqRVY+
	fu2tUWYRcKWIErj9G6UIUMyuxw9jelNZtnqV+FSzOXkucfzV8GLuOmLSK41IfqVR57adCBt7q9q
	vUqnU9Gpf5LfVQbaX/qo25TMbxunLCOAqDTy3cLDn1fa5joh1xL3yDO4yiFzrR5kXywXGXJ5QgH
	7GaBZrAzq/CMFgI0Hnw7+gidFu/PJmo/xqDoMbruM0RoUSnWRf9/uHUgEWjy6X4W3je2PlYffYc
	4Nd/k5M2dinELEXmt/j+nA0d5p1jlJubVBfDKLoM2wkVux5MH/3ZHaDuge/cBcdMsW34FXdSwe1
	iGxwbHcAwB5uc740oDPh1ZAPkcVCw8gd7bINnmKi94soMbTuz+QB00CwxJ7T5bYOXtQ==
X-Google-Smtp-Source: AGHT+IEQD5Y5oGNF6Rl9taw1DLnnvqRocguYtLtgUa5EkyQHVYPxyenmnCxMFlLUICvpCU9BW0b2wA==
X-Received: by 2002:a05:6300:6e17:b0:238:3f54:78f2 with SMTP id adf61e73a8af0-2383f548db8mr22114439637.44.1753201252669;
        Tue, 22 Jul 2025 09:20:52 -0700 (PDT)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com. [209.85.215.181])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cbc6bf14sm7807505b3a.158.2025.07.22.09.20.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 09:20:52 -0700 (PDT)
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b3bdab4bf19so4383778a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 09:20:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXGM9uJSPGQ8pBF4oLxz7TqC+hUxYTKZTu7Pj3xZd8MuYlzXShNusHUyQrWLM27Pu56TBUnQTNiYXfvov8=@vger.kernel.org
X-Received: by 2002:a17:90b:3f8d:b0:316:d69d:49fb with SMTP id
 98e67ed59e1d1-31c9e70915amr41164532a91.14.1753201251543; Tue, 22 Jul 2025
 09:20:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722015313.561966-1-me@brighamcampbell.com> <20250722015313.561966-2-me@brighamcampbell.com>
In-Reply-To: <20250722015313.561966-2-me@brighamcampbell.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 22 Jul 2025 09:20:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XGO5y0F40oaOANW-r-q5qZPFYRwO7aQHi3R6Ag-aeMag@mail.gmail.com>
X-Gm-Features: Ac12FXwtfJseOxsGp7nVtSJKfbTvysXVQqEuN_xMYIUstfIqb9Hrqert7fbtJBI
Message-ID: <CAD=FV=XGO5y0F40oaOANW-r-q5qZPFYRwO7aQHi3R6Ag-aeMag@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] drm: Create mipi_dsi_dual* macros
To: Brigham Campbell <me@brighamcampbell.com>
Cc: tejasvipin76@gmail.com, diogo.ivo@tecnico.ulisboa.pt, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Jianhua Lu <lujianhua000@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 21, 2025 at 6:53=E2=80=AFPM Brigham Campbell <me@brighamcampbel=
l.com> wrote:
>
> Create mipi_dsi_dual, mipi_dsi_dual_dcs_write_seq_multi, and
> mipi_dsi_dual_generic_write_seq_multi macros for panels which are driven
> by two parallel serial interfaces. This allows for the reduction of code
> duplication in drivers for these panels.
>
> Remove mipi_dsi_dual_dcs_write_seq_multi definition from
> panel-novatek-nt36523.c to avoid the duplicate definition. Make novatek
> driver pass mipi_dsi_context struct as a pointer.
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
> ---
>  drivers/gpu/drm/drm_mipi_dsi.c                |  48 ++
>  drivers/gpu/drm/panel/panel-novatek-nt36523.c | 804 +++++++++---------
>  include/drm/drm_mipi_dsi.h                    |  95 +++
>  3 files changed, 541 insertions(+), 406 deletions(-)

Just because I was curious and wanted to confirm my claim that this
would result in a nice space savings for novatek, I ran bloat-o-meter
on the novatek module comparing before and after your patch:

add/remove: 0/0 grow/shrink: 0/4 up/down: 0/-8754 (-8754)
Function                                     old     new   delta
elish_csot_init_sequence.d                   758     379    -379
elish_boe_init_sequence.d                    846     423    -423
elish_csot_init_sequence                    9136    5380   -3756
elish_boe_init_sequence                    10192    5996   -4196
Total: Before=3D33880, After=3D25126, chg -25.84%

So the new way of defining mipi_dsi_dual_dcs_write_seq_multi() did
indeed give a pretty sweet space savings! :-)

This patch looks good to me now. Thanks for putting up with all my
requests. I know this is a lot bigger than you thought it would be
when you posted your first patch, but I appreciate you sticking with
it!

Reviewed-by: Douglas Anderson <dianders@chromium.org>

My plan would be to give this series another week on the list. If
there is no additional feedback then I'll plan to land it.


-Doug


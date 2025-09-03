Return-Path: <linux-kernel+bounces-798840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA68B423B0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D03734E4F24
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305D23112C5;
	Wed,  3 Sep 2025 14:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RN6UJGkp"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE1830AAB1;
	Wed,  3 Sep 2025 14:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756909725; cv=none; b=a7bjpFblfGgGY91L1kfw06Bc51fnalbeallBll/+ZCFACZI1XLvf3s5A27ErgJz7rHe/RPyB+syDbNHsPmPA3weHjbIGldv3fGaX9HJbNXyT90uKwL785pM4aWY8OAs7jCgtKkN9EuVMTKpc6YZjLovfZGV4dHF0aJ9Fgdat6So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756909725; c=relaxed/simple;
	bh=R8Z/vTHYGiiLDO3hc+BgMAtvCLuPBsOEFxV9eeUb2RQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ocf/+QM+fhpV3bk9x2/VpONRqynflakChuTSFiTmRuj+5tVUPfQ6or/L3cr8zHfTPEcuSGF+y0xDWnyRYrxS7AL56lBZAE28qKNqRBcJaqw28v6Zg4J/ImRoDpOAqoNbx2f32oJoVItZcJWidBkE4TcZcVIgCqet+2lXavtJ2oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RN6UJGkp; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24b14d062acso2395ad.1;
        Wed, 03 Sep 2025 07:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756909723; x=1757514523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cOhxeIFjpjrMf7aOEWMhCzpTvgFLShuhckx1Q3/cIMk=;
        b=RN6UJGkpYMMQEyDGEB2Dt+1J4QGief/seDn/StRlTxeEInL94P2VlkJzyMuOh5vWOw
         TnCl6aPM5ygbLsHycJjkxhXpWJlCcGFGpsq26FJ+EEoYHK7LJrH377xiTBdYC1xj+IBJ
         f3GKTuT4U6iPw8VYMV/J26jKakb+HOTRlkWcoqiICPvoIknN4fmKvERP0FQ6cwQvX6KL
         9EVf66dPM3VpJqEwM2ejYc69msgdqFiMqYAOeG9ms6iKjsrmEDV2oH1VkslEC7MqUT4H
         JNJI2dLBMCl6ImZjSdfagVV8I2flnq1p8oYa6WHsJxpCBZ4/43DIv6rekb59CByEgUer
         hXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756909723; x=1757514523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cOhxeIFjpjrMf7aOEWMhCzpTvgFLShuhckx1Q3/cIMk=;
        b=sacVApq+uSADRApZltQpqaNrJw1xCqMVDMWY7XikErGCgAGov4hGlnd7GlRYVFaJwe
         t/+14tX99+16PB4yk/6/8KhWqnWSZnWvLxkyJd4Y28bE+1vaQZ5sMCvkv+O92L97it3/
         RSueuF7Pt91msG/6edzcmDk30Gk0wr7flSnyoc14lcGT5FpsEZYCsggANc6hf/B5Z4kR
         VM4JMOaExUPHTsANPb8il0/8kMFpOgQfNKo7r8q2gFNRKIabdPEkO0cLJUwODzA9XDq2
         EuJRjGTqM7MfK0s70DwVpJ4yESx4LHRSG4vfhnRaS2Y0lqJtzNIhHEKyYcNBRLawi12f
         XNbw==
X-Forwarded-Encrypted: i=1; AJvYcCVStarEY3blMNy8F2LCrznU1lQHe9Ue8EJDYTBSSlwGv1bSC7MlRGQo2x+CxV5lm++trGU6BEX2q4aVcwU5@vger.kernel.org, AJvYcCXO6KlMYnIYqE/pOMOEiaBjEdFcig7fT7qnQizv/odVjdIN5A4m9ByPSebWKXk+8xVUHIdK3mCf8G5iVpjRebo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVSGDlY/0j7SN8H1QBrQn+6UcYLzifIIXENpp7u/TOU9gCFCdu
	V8ZdE2PpwyQ+34X0OfT6d8v2AgE3uv0Rw3U57s1Sxm/wRO0ycZUEq12Av9SoW0Pj2GbnPBU72Ap
	yHKKMX+izgNOnBnyNxzTlxBfxpbEsjS4=
X-Gm-Gg: ASbGnctrkgRfXYYLY9fxgLRj82rgP8O9qLz7GoHVEt2WMq9X1rFduuv8brVo0HTNU8X
	gR7Bgy7ihP4TsMlRPZ6s/8KgUBCvLe5ch0KTiZWubfFJ7DtnVqq7YJrf9dAXVkWW7bMqhPDvc/5
	raCCD5/FkHAMc0myR4QNybpjG178VoE+ccponlCvv1RDJlQhQHQV8S/rLC+sOIJYZs/kiVQ62wX
	3vG0QekdTW4Jnb+Vw==
X-Google-Smtp-Source: AGHT+IFOnePYb4ywz6jf96HTmrHkdNDdlN7uSd1l6wzq/vofzodwjrS28jTK2c5zjv4zLJIFlbc42+Ai0y70GGbGTP4=
X-Received: by 2002:a17:902:db03:b0:246:e1ff:b223 with SMTP id
 d9443c01a7336-2491f1393cemr133123155ad.6.1756909723377; Wed, 03 Sep 2025
 07:28:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903082018.2702769-1-colin.i.king@gmail.com> <aLgCkRO8jkzwuxW5@stanley.mountain>
In-Reply-To: <aLgCkRO8jkzwuxW5@stanley.mountain>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 3 Sep 2025 10:28:30 -0400
X-Gm-Features: Ac12FXwZEbcPUl-6-Rnd5XZji0oaUsIwWztfkSuPcJ4GcwF8j6e-YBXz3n9gNeg
Message-ID: <CADnq5_Pkbpezj9p1b335Civb90fGxojyciExZgfAndRF1rUTmQ@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/amdgpu: Fix a less than zero check on a
 uint32_t struct field
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Colin Ian King <colin.i.king@gmail.com>, Shaoyun Liu <shaoyun.liu@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

Alex

On Wed, Sep 3, 2025 at 7:24=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro.=
org> wrote:
>
> Are you editing your CC list?  The get_maintainer.pl script gives me a
> longer list.  The most important thing is that you've left off Shaoyun Li=
u
> from the Fixes tag.  Added.
>
> The kbuild-bot did report this bug on Friday so the AMD folks likely have
> a patch kicking around on their end, but just haven't sent it out
> publicly yet?
> https://lore.kernel.org/all/202508290749.ti6u3cLL-lkp@intel.com/
>
> Anyway, the patch is fine.
>
> Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
>
> regards,
> dan carpenter


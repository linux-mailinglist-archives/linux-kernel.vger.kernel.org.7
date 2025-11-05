Return-Path: <linux-kernel+bounces-887426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6E3C3834D
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 23:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 83D444E5F6A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 22:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B862EAD10;
	Wed,  5 Nov 2025 22:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkrefraction-com.20230601.gappssmtp.com header.i=@darkrefraction-com.20230601.gappssmtp.com header.b="rRTdkRN2"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835722DF6EA
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 22:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762381991; cv=none; b=fDH43Yqmvxg/z4erb39sMIFg1fdFej+ZpzDjOsA/ueW4Zmff28VNZAAI9btGKwTK/vwUBLOtIWvGbaORODFP/6LPZT/qpwIrBKRb2ecUGkSom07RuuyBhm92PXOVTrbBZPYPnYu72ebX5CymJyyKnre7iZlTQ6T6sTk/w0s4xSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762381991; c=relaxed/simple;
	bh=Szr/I/23aXpFKXBJi1aHTQqCJ/stBoKYNXps0uuzFjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RsEOXLlIvH+XyjXdo4BskMPXCp6LdnXXY98/sHXYZoRutVENXGu0kdBC7esu98JRSmyj2Uuw1Aso4elFt21Skgic/d7yhj4ZMJwOtOgJyHkXSpg/YjU8Frn0eFPThEOW/GuRHsja5XMykWpQWx7gaqMeBq/ctElEQ7WVCwLDae4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkrefraction.com; spf=none smtp.mailfrom=darkrefraction.com; dkim=pass (2048-bit key) header.d=darkrefraction-com.20230601.gappssmtp.com header.i=@darkrefraction-com.20230601.gappssmtp.com header.b=rRTdkRN2; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkrefraction.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=darkrefraction.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b725ead5800so45940666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 14:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkrefraction-com.20230601.gappssmtp.com; s=20230601; t=1762381988; x=1762986788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Szr/I/23aXpFKXBJi1aHTQqCJ/stBoKYNXps0uuzFjg=;
        b=rRTdkRN2GroMXqIAj1vlgmGL0KAvgSsOgHlHctPnwyYGrWiv5RWKwhWLZz9mPu651p
         Vg7mkyGtHXYWQub2/Ew1PFcjTa7HYs81nSXXqq0ldoUXy9fYRap0mvL8UEe7DgsC6DwR
         jnoNPJgMqjoPTCCSI4E56i/oL0Dcosd396l30N0H2fr1jkHuCMhSylMQMsfjurFej7nc
         79QnSupP0CjSWym0hFfAGJPqXBDq2spJZjlbyIbVpoCtTk9zE6rzRRuByKt0JkUS8Kol
         91i83QZ19X/1u99nA9zwRJ/V93eSFjC5h5rBKlE03TNsdKEyRypeAL54FgrjoyFDYjNW
         /V2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762381988; x=1762986788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Szr/I/23aXpFKXBJi1aHTQqCJ/stBoKYNXps0uuzFjg=;
        b=KU43vEUNr1h3q4DMEsaMfFYg8G19zJCOuq7Oh8ykPgIogBF2R6ciX+UwJfbbT14tH6
         5y0kaLCpIXrIggRASne5CQeG39I4NvmCnzIK84agyhC3PaVjok11JlXvKEDm2iugUeYx
         CThJ19obC5RcC7v60PV1mHitlcDXbQBATUo936lDnABV/8JCVcvO4pbPRWciq8sWw4Lx
         roFILCOvtt8bYlWGQpuRLt3arUoT/ZKo+RrDJjzq+shpBhPkuawfS+V6Fa/FUlq5o+5O
         V06nYbmt9st183b14J7cLR0hSAJnYqdY2tFuXoQMbJTWK15JnjIRlRhbQogJpe/DIcdf
         gbUA==
X-Forwarded-Encrypted: i=1; AJvYcCWUGXJ7HUufcqJNYs0ZbY6eB0p1A1RWE5lueIF8M4/dqpPnD3sYEJJY7peYF8ubxNXL7TCXErWhcbXE8f4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRVwF1nw/6wacvlxS1Y2vYmd1b9hH1sD/+1mFsVOQosQLBgyU9
	B8ThCn4NLiZS++xOjZkzYO2YlWAE2+Vy9mb5EiOFs08jl4ST9UJvpJiB4FhAqppviV2zMGdDJD7
	lqHxw53nVQZywU1177i2QAbOaME5urUGnk3IsBcCUYQ==
X-Gm-Gg: ASbGncsXNDuL5qJB0rIjvF1lzdxsvTYOn00hfSt2afZdjHS10T0htC5j8MWB1UnL1Ep
	P+j9XQHmN4JCdywRxscxz3mXZJ0x4ewNlKj+QyapfJjqZk+8qiSMrRjUObErMsCOKpPBIebHdg1
	YgqAodJxqkJU+9WzhgxhDIOg2LD01fH5xvWOVoreKAQ/kGTaJZr/PrJMglc2THkKYdrTY/dR8No
	EqU8hkad4gx6VBb5G8lK7+SQh6HY1RmLJT2aHhbUjaxBW8gQkO7O/xaYaRj
X-Google-Smtp-Source: AGHT+IECc9Tb6PQXUfyG8UVINPUv+8WuWF7S35bpfNhdSjAQ8wS3WKzirND4FdWE3HzVjloMGajR3KJsnvuwrExox2k=
X-Received: by 2002:a17:906:4fd1:b0:b6d:7859:61eb with SMTP id
 a640c23a62f3a-b72653ec85cmr441833366b.29.1762381987591; Wed, 05 Nov 2025
 14:33:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030230357.45070-1-mohamedahmedegypt2001@gmail.com>
 <20251030230357.45070-3-mohamedahmedegypt2001@gmail.com> <209ea5680e5ca28b6d068ef8e0b58613c93bf525.camel@redhat.com>
In-Reply-To: <209ea5680e5ca28b6d068ef8e0b58613c93bf525.camel@redhat.com>
From: M Henning <mhenning@darkrefraction.com>
Date: Wed, 5 Nov 2025 17:32:40 -0500
X-Gm-Features: AWmQ_blkOGBCCpLWGWm7AJHNww7fhuXYw2d5ogzt_C2ETFcndeIo2dccLJU1Ags
Message-ID: <CAAgWFh2Zy=9vt6x4e3P6G+_RV0Hu66jyJjpKWWx4WVg8EAV+Ng@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] drm/nouveau/uvmm: Allow larger pages
To: Lyude Paul <lyude@redhat.com>
Cc: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Mary Guillemard <mary@mary.zone>, 
	Faith Ekstrand <faith.ekstrand@collabora.com>, Danilo Krummrich <dakr@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 4:01=E2=80=AFPM Lyude Paul <lyude@redhat.com> wrote:
>
> As long as you fix the parenthesis issue in the next respin of this serie=
s:
>
> Reviewed-by: Lyude Paul <lyude@redhat.com>

There's already a v4 on the list that fixes the parenthesis.

Anyway, if I'm keeping track of things correctly this series is now
fully reviewed (v4 on the kernel side by Lyude and James, and on the
userspace side by me) which means I think we're ready to start
landing.


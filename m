Return-Path: <linux-kernel+bounces-810355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 174FAB51933
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBD304872A7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AC9322DD4;
	Wed, 10 Sep 2025 14:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="bMLUYJPy"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDA0202C5D
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 14:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757514139; cv=none; b=m7wSq4qm0KUfLhfXGRghLpX7m7k2GVsZvRkNzpznWxvchWKxoHjCLcSkHa5YWKmCiSceWwTQUT4ru1ZUyIVi5agsS+/h3oPqh5pSYO3oQvfTMw3KMGC4ElhgDcgrqSMy9lSA/hVHkdv1Y/q89ePrB5uVvxK6+uMioJMixYHt32g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757514139; c=relaxed/simple;
	bh=t4qRm5Hkoa5fyasUXgNBG8wEVnlbfmMKfatsLC5qGzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QTJ50D5lGktnL7iYRW4Kpi7530hJK8Xjmz2cL4VOH74XShfbQ/6ZpRXhrR+U+PXwTvovrtyntMyAyf76wzOhNhCubZggCONt2No6Vz1XA14RuYAGA//Ds6YiUa8t0lestfjEgiHlP7OGxd14Me2yFdSfaAPWT9xfXD1ZQBDLRhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=bMLUYJPy; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-723960ded6bso52871817b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 07:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1757514136; x=1758118936; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NbI3XtrWeiAfL17IN4rrKH+Ltn8PAz/n7TKulLhLSW4=;
        b=bMLUYJPyZ4hgSaJ0UNfzTFQLWHnKfR66D+2Q35g3aJV6zxa5XIwfUGX9XHkfQcSgcS
         ftLQvZvjnpEROP9FtxpGd+SskKcOzFVp8nq3p1yExZauVZjlkQVB0aftGPwYpUELuajZ
         Zc+nhi5BVZi1TmgWP5HA5lg+AfhtulvrIuINUk4eOapwx8GX/TCdkbxVNSdsSMO6wNIO
         aKU6nt2N5wrruTgcTexy2UXcK+e5Ym7J6EQEGLPfFnx2GWa0RUB3+6Ey9J3PqSTp0Mju
         7eoWSjNgSESfkxW8lf7rRC3+TrZDoHGRyriW5QRoX18DEZs3p02QQuak24+RqRBHWAe5
         Ny6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757514136; x=1758118936;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NbI3XtrWeiAfL17IN4rrKH+Ltn8PAz/n7TKulLhLSW4=;
        b=FZjlf2jdlbly5jUMBbwN+BGm+/fXOsPa/KEEepSU+mTvYU0rq2PpiVZAAVsZ2OIhtX
         5P8ja2YuKx7y53rIUVV9uLrbbl0jZ9jhqsXf423Y7r9QVkOOp+54Qgj7oSrgCCdKwq9S
         IzUk42snmUOBJzQsqOxO2ZGDO2r6n4CBgRmfQqPjLCTwO/iDdElSPZnYawCoD9ex/emk
         Nk1Jjr6HlxjmICl+GADCB2IPBpqDHCmzcJF8LShHprCSVfm4u4GWvP86bdYNsfM1Ces3
         turE+LflcXZz9SRj0IKRbcuCcUM1TRPiZnhq1c7Jg3pCyKpzKJy9cJWcjXy1UQd6DeXm
         +bcg==
X-Forwarded-Encrypted: i=1; AJvYcCXLFv06wtgFTgCUZ3MV23B3S2xJKQS+4WUnUG4jLra1obB4wjgi8BRYEeN4ojAGeT1kqdDr6njFiI1Nh3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaVbCtUjpxhWKPU1a1+vGyl43QHzEo7u8H60yzxPrDGmi4NjLB
	lE/a6sM9+I97KPes0+JD66QThKN8+6Fv6bSETFjp3lyyDlQxpmxDIwEsyWq/+BuW6n8bYYYgobp
	D5qn1yRc/QsXdA6R2UGrH5whEulJ40XYLxGT30qjollBNjkZZHvs+
X-Gm-Gg: ASbGncvJD7LX9bq4HD/TNDAeUHjwXH9gmL2aHIY19b8hRFRWIMsSKCSOz+3DXle7c93
	SaCTbQvgaivhL8ypxiw0Xld8jm9tsc3ARNHuHxGnXKztiedMONXi9dHSw0GJ+Hy5WTAb55HLW5j
	yQVaEIAFDyjcIUeFiQgsg9uo+5VlM3HMRAlWiDePyY6KdXxbNENNm3QoqwBXxKQY5eLRrWOCCun
	aKlHD4fMchNoSEzQMz7cjHNOZYRP12ob0YT9VuR1sk9Meg9QA==
X-Google-Smtp-Source: AGHT+IFUo1uVtNHSnP8Nhf+uhc15fO8avExAUC3caetFrA1lApFmwbcGCtGZuZpabR6cjtqgKxftAOablvHlNfYyr/I=
X-Received: by 2002:a05:690c:7088:b0:727:637f:8729 with SMTP id
 00721157ae682-727f5b2f46emr139954427b3.44.1757514136106; Wed, 10 Sep 2025
 07:22:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250705-drm-hdmi-connector-cec-v7-1-d14fa0c31b74@oss.qualcomm.com>
 <pz5luqbagulactqp7h237apoostl64rcrnvmu53eauvtb6cqly@nsmzsvbfixrr> <bmbu6dfhr4i37fxlqo7ltalkzz6bocb5whuv34x437k3crie5j@ndtqjrv64n5j>
In-Reply-To: <bmbu6dfhr4i37fxlqo7ltalkzz6bocb5whuv34x437k3crie5j@ndtqjrv64n5j>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Wed, 10 Sep 2025 15:21:58 +0100
X-Gm-Features: Ac12FXzGi6FvExML235VpMWJC7OtX3X_HUqq2rGTITMHO2b6QfyU1Z_oqgDmcto
Message-ID: <CAPY8ntD-q6nZcVJmo5OG_6U5cxdOVdwKLJChsQZd_ZFjCRuGZQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v7] drm/vc4: hdmi: switch to generic CEC helpers
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Maxime Ripard <mripard@kernel.org>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Dmitry Baryshkov <lumag@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Dmitry

On Fri, 5 Sept 2025 at 17:51, Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Fri, Aug 15, 2025 at 06:11:57PM +0300, Dmitry Baryshkov wrote:
> > On Sat, Jul 05, 2025 at 01:05:13PM +0300, Dmitry Baryshkov wrote:
> > > Switch VC4 driver to using CEC helpers code, simplifying hotplug and
> > > registration / cleanup. The existing vc4_hdmi_cec_release() is kept for
> > > now.
> > >
> > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > Reviewed-by: Maxime Ripard <mripard@kernel.org>
> > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > > ---
> > > This is a part of the HDMI CEC rework, posting separately to let it be
> > > tested by the maintainers.
> > > ---
> > > Changes in v7:
> > > - Dropped all applied patches, keeping just VC4
> > > - Link to v6: https://lore.kernel.org/r/20250517-drm-hdmi-connector-cec-v6-0-35651db6f19b@oss.qualcomm.com
> > >
> >
> > Can I please get Tested-by for this patch? It has been R-B'ed, but I
> > totally don't think it should be applied without testing on the actual
> > hardware...
>
> And another ping to get it tested by...

Apologies - I'll find a display or AVR that supports CEC tomorrow to test.

  Dave

> --
> With best wishes
> Dmitry


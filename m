Return-Path: <linux-kernel+bounces-795367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF89B3F0D1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 00:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC50C1A81CFC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 22:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EDF27C864;
	Mon,  1 Sep 2025 22:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r9dbKAXi"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F116023D7DF
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 22:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756764359; cv=none; b=oEXyYx1xH0Mi0qpMVPwXwX77ckWc5ZUuQ19/aSL6qs5zuTl+24q39ryt0PpzdIoAAuerqx0k8COozktGVdk11g0I9x1d+tFECRUNmt9kdYhq1JiNnRGADm7O0BvJ5E+B3WBPwet7WPg2+DWNjVTnoJVOWAApdhDSTCCPnwbRuWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756764359; c=relaxed/simple;
	bh=IRucAxRkdYj3+XFl/z4CHJNMo/npxJqZtRe84oNwZdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E1FxkXVjG+gmpG4XRpysdWF5B8xW0QfTKL+3+eaFpAOD0pi3jShX2EvcgE5eF3JZ0t5WTjVGuboK5eaPO1MVfZRTHEBIdWgUqdKOycbwQaYI8zEehvqNhOhTf0eHS54PeFydtW3TePrCwJbLvOGfRX4skp1z94qI3e5nGSiAqLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r9dbKAXi; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24936b6f29bso334275ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 15:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756764357; x=1757369157; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iNGclCR4OfhQm1LG6IdweoAsF6Re2IBZ+iy2oOfb3/Y=;
        b=r9dbKAXiJwiD8ZPUrsbz567F3YSmViOL/dTZobUi1bEqxatHbJ3atYWkuh5oA8L9uA
         XoZhu+IXb3JWL5dU5iH5FN/ZcqJI4IFIV3rIXrNRCqtZpS4G2HIOSj4gxNayqX/Il3rZ
         zdok228uSCN1TwhzEAfcyLWFa9uWleh26W9uzKk+goOU+8HY2Dm8224Ag2idqHi8DlgR
         CWZIulap2BT/8c0yDZ1NdffYONjs5Y3rcKqN+3mHnv+95ZqkFd2NGGeq/9b3Rev0riOP
         6oe2fzH+uc1Y7OkLqXEDZDl75Fx3So1pMhlK1xRw92miLIpJDtxrPI2O6R/g7hLGbfNG
         HSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756764357; x=1757369157;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNGclCR4OfhQm1LG6IdweoAsF6Re2IBZ+iy2oOfb3/Y=;
        b=utC1A49ea8Hm5+ZsCroUnlv4DxPgepIeNJ4hSdBmj3AJ6Y1X/2IAVETllujt6JOa9c
         iiLX4OB33jUewnMKGuRSlHqTbHsQtNyZploR/Xor5AIQO1uzBx4yl/AGS4qEDAr4f/Yd
         3DPLElXwIDgmb5R9H6Lk2alzYZ3g3uEtVXOX1vCZSAGGZ5jFwob7Pm1ssBxBsDratnFH
         +yXtdE/bB51xuKUBLskeWiv4BInN2Gy4eCYEUBTp6VG+U5WXZZjKh2BJ62MkgQz02Zke
         POMmW1EkB+uN99/L7WMNiKADH02ka6OlpfD9FX2ViAi/JhID7kj2EIt4VH4d7P3IgCNo
         f5Ww==
X-Forwarded-Encrypted: i=1; AJvYcCVLnvWGeAHfNVcosY1e2aOYJh7Wh6/hfOjTRVZYlMGRYWFjY2n2TQtj7n03w/SGhUiBQ+e0yEH4f0xVTLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdQUoiCCPJQjU5quYG5u+wTG3HdB5YLt7hyf3/3rYFO0HqPoIS
	4CHEEyMUVRyvuiO3EQ4aKYfX6VdTBC8CTsfXtMIDjPOFqIoGtaI8OLQTO+mAl9U8xQ==
X-Gm-Gg: ASbGncuJBSGSvCzFyQPgVyEaLRcQoZAbyU/MtP7cPLDRo3WLLo07LFEsSjLRmO6QYpO
	zIqxwUVwJvqE/hSGhfY095K0UEf3NCJ1rISo+6fVY6XT+2FhiBKvDHFvhzrsFa2e9MPXMPH+1ru
	15VJ1Fu9ptL6SSF4ZMPF/mHBASyZZ4KSY6qSa4XsQ8M4Axut5odrasN0YTiQrDXJ2s1G/BaeZZt
	ZCpULJ+rFzw2YLjXKi7v+XA+oYzgqMY9FGLZybXB/hC2naFTy8N2jN7If8y+5B9HIftkGbfFWEO
	sirBf90hqq6QNZC66Yfi7qYJt7zZQNeewrKjPyTFKD+bzzRNR2+RuqD3X1KnOTWW1Lko0H54xNe
	PGKnIgK/n+enTv9XjyihZXWGUnnr+1jKup6NhGX8bj5W5zf7SQDgPF4EfagUVyAQ=
X-Google-Smtp-Source: AGHT+IGTjJJ+lUPIOI6BFtIHzkUqQ53h8k+cOaGDC+1aTzya9kiOTmJe43O4r98yS5cHzoKAUIUnwA==
X-Received: by 2002:a17:903:32c7:b0:248:bac6:4fd8 with SMTP id d9443c01a7336-2493e9db864mr7485925ad.15.1756764356920;
        Mon, 01 Sep 2025 15:05:56 -0700 (PDT)
Received: from google.com (23.178.142.34.bc.googleusercontent.com. [34.142.178.23])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a5f7a9csm11592840b3a.91.2025.09.01.15.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 15:05:56 -0700 (PDT)
Date: Mon, 1 Sep 2025 22:05:49 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	eric.auger@redhat.com, smostafa@google.com
Subject: Re: [PATCH 0/2] vfio/platform: Deprecate vfio-amba and reset drivers
Message-ID: <aLYYvURhjGmJ__Fx@google.com>
References: <20250825175807.3264083-1-alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825175807.3264083-1-alex.williamson@redhat.com>

On Mon, Aug 25, 2025 at 11:57:59AM -0600, Alex Williamson wrote:
> Based on discussion[1] there's still interest in keeping vfio-platform
> itself, but the use case doesn't involve any of the current reset
> drivers and doesn't include vfio-amba.  To give any users a chance to
> speak up, let's mark these as deprecated and generate logs if they're
> used.
> 
> I intend to pull the vfio/fsl-mc removal from the previous series given
> there were no objections.  Thanks,
> 
> Alex
> 
> [1] https://lore.kernel.org/all/20250806170314.3768750-1-alex.williamson@redhat.com/
> 
> Alex Williamson (2):
>   vfio/amba: Mark for removal
>   vfio/platform: Mark reset drivers for removal
> 
>  drivers/vfio/platform/Kconfig                            | 5 ++++-
>  drivers/vfio/platform/reset/Kconfig                      | 6 +++---
>  drivers/vfio/platform/reset/vfio_platform_amdxgbe.c      | 2 ++
>  drivers/vfio/platform/reset/vfio_platform_bcmflexrm.c    | 2 ++
>  drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c | 2 ++
>  drivers/vfio/platform/vfio_amba.c                        | 2 ++
>  6 files changed, 15 insertions(+), 4 deletions(-)
> 

The series feels like a sensible compromise. The rationale for
deprecating vfio-amba and the obsolete reset drivers is sound, as it
cleans up code that can no longer be tested by the maintainers [1].

The changes to Kconfig and the addition of dev_err_once() handle this
deprecation cleanly.

For the series:
Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan

[1] https://kvm-forum.qemu.org/2024/vfio-platform-kvm-forum24-landscape_TtZ3SnC.pdf

> -- 
> 2.50.1
> 


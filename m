Return-Path: <linux-kernel+bounces-769717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 976B3B272CB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 01:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C141C5E898F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 23:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFD4288CB4;
	Thu, 14 Aug 2025 23:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nJ3HeTQk"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18080288C9A
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 23:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212955; cv=none; b=Eql9FEiaJSqAXR0mLjU9ZhAj1iVY0e24BbKMsyGZEYEEqZxscNptlrz8zZAR99If8XjvTlhJr57OuVsuMeDyhbTFW+x6/fTzXYgyFcY7k1lVmKWvzj6dvvC3cpYTWXDD899CfGIewfoUHWmrBtVVfzlTgfU0ZQFrOl6c+4y570s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212955; c=relaxed/simple;
	bh=kolEcxZppRJPvtj9Y7bjq9AsyYhR7A0nQaGAV7R8LoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=onRO2ba3hMXpgiAjl8RAUCfbkSgjWhSai2tTiDlk5k0oSAwS/lUfa2/KWdrl3OoginCkKf88XhyZJx7BCn0vJwRsDx7vmzrKVb1DgA/NyDqwlgBPvjmZ5bSa3e5SJlE7+U7fHrrfsEfSLIm0mwd8AdXqimQvqpkHXp/i0GDn6aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nJ3HeTQk; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76e2eb2bf30so1649929b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 16:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755212950; x=1755817750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wS3pe34+blEX5syRHqDIoKBEMxv5qKslIftcYANOZlI=;
        b=nJ3HeTQkZdW1HxEFzpavC1ErYAeVPVRna2U3REEfs+poylZA6KYj2/aBuxCrj3tBWm
         pDN/IAH+16qkt+4r/ZzpXdhDkt9RvWRty26XgbCPfcpFcNXI8V+zeHChudlrBT2QLWIS
         x4AiyYdS4pz2F5aTWO59G0oFOYwJ3U094gfNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755212950; x=1755817750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wS3pe34+blEX5syRHqDIoKBEMxv5qKslIftcYANOZlI=;
        b=OJ39OoF/cw/kit4ipiJMuRkpYtd4iGptkss3sHydascG1+PbSnXzgTWgNhbP/adilx
         et6K1CgZV4eNCZzBMq/ujJYDzwxUy0XqbDNeTbytlsLH/W17eTh4Vvsl5uH3YP4lE9Ql
         +Sa5jZzSlkXR2ABnBjsr8FtYblpbabbzft2MIimE2WR9vUJxaz1mpnAOlHCwwlcaQm4w
         ft+X8WVk75HQYE/j7Ve6uZpzhK49xAdPfm2afsjnnIqBBoT8joKDSldGC+T1G0p+Z4Ir
         jgMZO5MXMWt4Iq+5hUpYlaIYsjNYMmT9oY/f84fnu44F/3ZQq4RcG8GH2g03+bM7Fx30
         cluw==
X-Forwarded-Encrypted: i=1; AJvYcCVwA0jm1QAIsw/QN4lXAOkCyz0yjoSDN5Mv3EnJLZ0KdBq06EsFWaSXbSgu2vFrNt2cbct/1vY6gr26ugI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3xJdiA3PFe6AGesqOsqr5cE5LDLZU8JQIHfWkXSqoQW58vBMP
	6eQN1OFZGaRCF94E3KafQOnQ4IoO2E5Psb5+AG+iA9kDXG3W9wTIIpjWVjaOnqenuzcV/NdaAXE
	5xmQ=
X-Gm-Gg: ASbGncvmVAX6oBPSl0UjbQ9aCzULRWBt2EPB4DGHCsvykmiIz3tcXu6/B7nmuNpnC3l
	eqG0TK1XB8NO+eYr8gK+k3emBscRlAaj2ltZrdus/+A5l7tiVUEbLDuWGXOjEpnwE+m3nZ2mBwb
	Q6uIbrg7qJZMj2iLhbaWI7bryhuPgl8JWHgSbNB6R0I3RTB07lFf6x1seC0yn8/XbOW2kCp+bAe
	D5P23EYtj5+CN49MxE02x4PWZVqPomZ4mqQE5uOqH0vFbcndz/Ld/5hIFkTqfYYnmgebl3Yr0gq
	/Yq5HpsW4f6/b3UYoIhpyyX/08HO649iW51gboyn9xVlqcnr9H5OzMk8hKvxMO25UtX5mwm7SYw
	CM93pMh3tWuEwIpe2UJcEbUWL+XlzjsWn4nQ1iRuTc+toyiPf3itVGWmhy6BcET7iNQ==
X-Google-Smtp-Source: AGHT+IHjsBq6DAKF5g+AmKZKBM91NtShECTRMVlUyiK8kAJG3TVDEMEH8Wfr1ETn2ikp0fDcdKVJNA==
X-Received: by 2002:a05:6a20:734f:b0:240:1de:8bdb with SMTP id adf61e73a8af0-240d2fed245mr19065637.30.1755212949854;
        Thu, 14 Aug 2025 16:09:09 -0700 (PDT)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com. [209.85.215.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbce4bsm35077910b3a.77.2025.08.14.16.09.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 16:09:08 -0700 (PDT)
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b47174c8e45so1221113a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 16:09:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVi44MQo4zOUPLW4WKTSK+L5zi1EuFspJ1JCRGjemWBaa/KX/CoT9lKvMqI6k0KaisQgvyTBYzHU2DsMCo=@vger.kernel.org
X-Received: by 2002:a17:902:d2c1:b0:240:a430:91d with SMTP id
 d9443c01a7336-244584ed485mr70762725ad.10.1755212947590; Thu, 14 Aug 2025
 16:09:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731032343.1258366-1-me@brighamcampbell.com> <20250731032343.1258366-3-me@brighamcampbell.com>
In-Reply-To: <20250731032343.1258366-3-me@brighamcampbell.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 14 Aug 2025 16:08:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V7wxe81Oi+SZdT0ym1FTz94+=_2r25x3Ju3aS4YsW7JQ@mail.gmail.com>
X-Gm-Features: Ac12FXxHx_giTOx_CEoA9_jVJzsA_CjD1xiP9IJHbCl-KW_M3haonEOgwpAIZVU
Message-ID: <CAD=FV=V7wxe81Oi+SZdT0ym1FTz94+=_2r25x3Ju3aS4YsW7JQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] drm: Add MIPI read_multi func and two write macros
To: Brigham Campbell <me@brighamcampbell.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, linus.walleij@linaro.org, 
	neil.armstrong@linaro.org, jessica.zhang@oss.qualcomm.com, sam@ravnborg.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 30, 2025 at 8:23=E2=80=AFPM Brigham Campbell <me@brighamcampbel=
l.com> wrote:
>
> Create mipi_dsi_dcs_read_multi(), which accepts a mipi_dsi_multi_context
> struct for improved error handling and cleaner panel driver code.
>
> Create mipi_dsi_dcs_write_var_seq_multi() and
> mipi_dsi_generic_write_var_seq_multi() macros which allow MIPI panel
> drivers to write non-constant data to display controllers.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
> ---
>  drivers/gpu/drm/drm_mipi_dsi.c | 37 ++++++++++++++++++++++++++++++++++
>  include/drm/drm_mipi_dsi.h     | 35 ++++++++++++++++++++++++++++++++
>  2 files changed, 72 insertions(+)

I resolved a context conflict with the other recent patch we landed
from you and then landed. Pushed to drm-misc-next:

[2/3] drm: Add MIPI read_multi func and two write macros
      commit: ffc23a204a5f2e763a8cc8a8cfefe0027a6f0ec3


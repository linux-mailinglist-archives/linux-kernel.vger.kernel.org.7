Return-Path: <linux-kernel+bounces-627347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F76AA4F76
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 17:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B219983792
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 15:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CD926658B;
	Wed, 30 Apr 2025 15:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OtFp+EoT"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571702609FD
	for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 15:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746025202; cv=none; b=rdkcONO1Tv5rQJu0XXwoiStOGZzDTvXIMwEczO2Ljuhr+pYT7o8GpemQGeJJZIgpZl1XnxNdHkZl/PR9b5wmrcuRRjIw4smkKvvpnaK9IUN47GO7MVkoDh+heTLZ10Xum8pM/RLO9m5ANwQxYSnU4ottjyPnk0QAyuZdJupADq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746025202; c=relaxed/simple;
	bh=rcWl+QmYf007ChLfgmF/lkXGahRIqtD3l2zvf4hd2JU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QDPo9Vk0kot1DiPgB15Lcp0TGd8smrV7vXeop801cLhDsvQAmeD9wL9kOw3IrU5I6zBi6CIveHP7ROxDl36Q/SIA4mpbh2RLt7vt6xGVL6jF3aNUAyaS1EFo7LpdCR5RKn6Ntzc26LYOtWAMrAQIAVF0X91EqRMW7tjCG+q8Viw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OtFp+EoT; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e5deb6482cso1949894a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 08:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746025199; x=1746629999; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s/GOiooi2lf2dyrYlf9XubY7rFtvSk864Rz3PS2UrNA=;
        b=OtFp+EoTW0CCcauVbYQV/EHRhph2Z7RWjC6gbB8hjYTphL6xy3Mg2tonCGUj9Anj1W
         pt4HGju1ntUichM7CWD08IbPAw/K0VkW5nC3pKNB5sRo9mQwMTJ0eGj/icIpG86TQq1e
         P+g0DAgM3qakkfHyJjbOeNuXQWjIlu+QVH/N0MTDzsmh2ojhgRdylbk/Mk2NKVOGO3Eb
         y4RMQilc4kppSuaMrYYGADu65XIlwVRkFp89h92eTN9uMMcJt2UvF55mJIEyfV+HyhbH
         gmlF+3raqr7bm0kTfn334kj+f8D7d05wOI7Pd5768Uf2Gpu852tymQCne9GdUYpRKi6+
         Yvfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746025199; x=1746629999;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s/GOiooi2lf2dyrYlf9XubY7rFtvSk864Rz3PS2UrNA=;
        b=VBiPXp+oVb7fAEUt5xg2FKGLdmzNw0fgqVZ8+kV0F/WOKqAUarvOvFmHcz9nTx3TuG
         4Qet/2KiDOKs6Kk1SlXqlrdLliliWVPwFheog6BVdYS3GLWCGb/8Bvn5WRXDzlwOrOOE
         VQwmNzI6WnPfi5GbkHvrPiuJyPHjOLBq3TMJSeRdllhYDji5lIuIm/TPdrmp7yXcxt7p
         d22YibtNLzTqgV3gI6rw/zCcC9hF8D9bgPxJOl1vSfYN68uw3cnmcRmCYXfUVU9tMlsq
         SBTFOCRv6CX+wkYJbDzBvSAvj7XmasT4Xyf8MqwyyxrzriATf5OtqCV5WMV2N/Fo5fPA
         5RRw==
X-Forwarded-Encrypted: i=1; AJvYcCUxtVwYSPdSVyDuNOp9nOAERb+0YDE6cZjno/lP92WMvPlICVG7buyjW1kwD5aY+M8KX93/lmPhfMnn+7M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv22FhlmBwgAkfiF5kIQH4KhFLmqDi1Pa7x6dFFMKsrkzaVKjO
	M3B4pF++TMVcsnJu5gUI9vFOxguyvwD30HUZV5r0O/Iq+Wm5ou2r1Yxma+/eWU52FAiGsImXy/K
	R2bCKuxEnqd/vml/4TBtuuFHq1JKGl++nf6uaH5YipwL5yf1Y
X-Gm-Gg: ASbGnctOmLLSW3LLyxd2pFWdbB2QJU4vYfzGqAWi6DABb/JFC0w3szLIiSnVSAVfKuW
	zQ9uMcC5kOVt7H7tiktcnhtnLqLpOFezQYX3maBRZZWVaoH0H0l50LGOv5riYslnVeF50RKlOSn
	lxfqevAjhkpABtnTgjNP6Isy+0cWILe5z2JsLfWYI2L3vrL4KRg5kCjw2g
X-Google-Smtp-Source: AGHT+IEuPe3FvOa41k60hnkwtbcvwue35KXfaVRFILnxHi2Xr6Nw0g2Wl1TPRvOhPCaTVHuhJu3g6QUGmtnCWiSixUk=
X-Received: by 2002:a17:906:6a07:b0:ace:bee8:ae0f with SMTP id
 a640c23a62f3a-acedf65b2f8mr255011966b.1.1746025198691; Wed, 30 Apr 2025
 07:59:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429104543.66927-2-thorsten.blum@linux.dev>
In-Reply-To: <20250429104543.66927-2-thorsten.blum@linux.dev>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Wed, 30 Apr 2025 08:59:46 -0600
X-Gm-Features: ATxdqUHj7Y9iIyVfGpSZ6xZiHXxko6yaKFvQ3VxEGVgKRHWDbymrU0RIpwfEGLI
Message-ID: <CANLsYkxBxt-fE-kV3yS7WDQuF4o7OSL045fMmXrTvfx3P=A+1A@mail.gmail.com>
Subject: Re: [RESEND PATCH] rpmsg: Use strscpy() instead of strscpy_pad()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 29 Apr 2025 at 04:46, Thorsten Blum <thorsten.blum@linux.dev> wrote:
>
> kzalloc() already zero-initializes the destination buffer, making
> strscpy() sufficient for safely copying the name. The additional NUL-
> padding performed by strscpy_pad() is unnecessary.
>
> The size parameter is optional, and strscpy() automatically determines
> the size of the destination buffer using sizeof() when the argument is
> omitted. RPMSG_NAME_SIZE is equal to sizeof(rpdev->id.name) and can be
> removed - remove it.
>
> No functional changes intended.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/rpmsg/qcom_glink_native.c | 2 +-
>  drivers/rpmsg/qcom_smd.c          | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)


I will let Bjorn take care of this one.

Thanks,
Mathieu

>
> diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
> index a2f9d85c7156..820a6ca5b1d7 100644
> --- a/drivers/rpmsg/qcom_glink_native.c
> +++ b/drivers/rpmsg/qcom_glink_native.c
> @@ -1663,7 +1663,7 @@ static int qcom_glink_rx_open(struct qcom_glink *glink, unsigned int rcid,
>                 }
>
>                 rpdev->ept = &channel->ept;
> -               strscpy_pad(rpdev->id.name, name, RPMSG_NAME_SIZE);
> +               strscpy(rpdev->id.name, name);
>                 rpdev->src = RPMSG_ADDR_ANY;
>                 rpdev->dst = RPMSG_ADDR_ANY;
>                 rpdev->ops = &glink_device_ops;
> diff --git a/drivers/rpmsg/qcom_smd.c b/drivers/rpmsg/qcom_smd.c
> index 40d386809d6b..3c86c5553de6 100644
> --- a/drivers/rpmsg/qcom_smd.c
> +++ b/drivers/rpmsg/qcom_smd.c
> @@ -1089,7 +1089,7 @@ static int qcom_smd_create_device(struct qcom_smd_channel *channel)
>
>         /* Assign public information to the rpmsg_device */
>         rpdev = &qsdev->rpdev;
> -       strscpy_pad(rpdev->id.name, channel->name, RPMSG_NAME_SIZE);
> +       strscpy(rpdev->id.name, channel->name);
>         rpdev->src = RPMSG_ADDR_ANY;
>         rpdev->dst = RPMSG_ADDR_ANY;
>
> --
> 2.49.0
>


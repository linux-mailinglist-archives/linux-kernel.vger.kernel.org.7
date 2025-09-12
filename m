Return-Path: <linux-kernel+bounces-814329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A6BB5527E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A29C27AAE9C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB95F30FF3F;
	Fri, 12 Sep 2025 14:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="erhzWHaE"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79C52FD1DA
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 14:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757689123; cv=none; b=f+aiJCu6Eb3kioZIQnQjOQd8JXAcumk7gWhj16g03beeOdnOhBLhgcHxe21MotrhXHg8z+h992f4Wgp0+skNjo2GPW9w6wgiJYAr1tWW31VrRQebh+iIJrTLJ4LNQiy80jkAL+2swrrc+AFU0l1rt+2EBIuVHJa/MxFNKwJhomY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757689123; c=relaxed/simple;
	bh=XPrHkDH6ZI0ZtNaze0i0II8lEvWqKmBCuHaUWLXu0XE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jPCDRTp+3hM+qRu2zT2//EOmVYLzZyNIf2EuQxdXdpok5eceRBz1G+G7dqZFOYYr73dMRSqvZpGHbHXfv1gJn9MBg8vsqdXhY1wloUU6v6zy1JcYx1n9+AK9wh0uDjcf9LA4hn0itOfRwRaNjf68QrU7f5IXK0duRGAPzrWvPM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=erhzWHaE; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7741991159bso2992850b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 07:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757689121; x=1758293921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JsRA2lsMsTyTq/Puo1W1+q3FiI8YEvM95g5Tez17y0c=;
        b=erhzWHaE6a5CMFDaaqv3vmQ20hod1CFVKoFoInWli8yPL/4UxBY6k2dXKo6WZDE7wC
         hA398cranxG3J+18DA3mYgldrY0XehckRkoVRy7PNNocuL3S44+MVjMwgQ1CAJPi5tmp
         g2hfoK/iLEOCoqOHKpuP49dQo3p8L8dOv4sXj+Rkm0IHCD0WyfTuy8mHN6h3JMqBQp0R
         sp6Ex+LFq3Vf0+r5+2upL5j2AhKZuglfPgiHa4Dz24oNRnVzVyEnJ0beaw13SNU9F6B8
         E9Cvj5Qnfq6q9T4HGtaJ9g92V/LshrBCD5gLiSUF07JxBts9e60gEZEnP7D4virg19Jq
         Mkug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757689121; x=1758293921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JsRA2lsMsTyTq/Puo1W1+q3FiI8YEvM95g5Tez17y0c=;
        b=Vf7eLGNIoDbCiIBrdmfYv3ARDfdqwuD3v7WVeZIWdjGKCwSMLDfHGeGpAiAgDn8enb
         RQuAGcOmlpKBQIFUfFymupV2ejc9quNkHZoyShMM6LwKbVPUb5nHEFNnXvXAXmwy1Zz3
         xTyNJF6nd9/MpiA6hbWEqBnT8USZvMCjDJ9FAwTMGtg8b0YkC8DN+0lAj7RQ1kf+Ow+l
         z1vW1LNty/weYrN/YiZiE4rs4KbaS1XT0YfETvdarzsVWDsrgkj49CGrocHTaD+j1H9U
         SV7bsSJOtVVyCNHNlwPTBc/JXntbVlQMZP8UjQ1fe+4COddp6FZeMHSgSFq6EIglwNpB
         gMQw==
X-Forwarded-Encrypted: i=1; AJvYcCVjlmV17T6g6UXLbLuamRBiMk80FMljoVgV3x73Mp09eqUqZPdu/0d0crLSLzluVzTQNv23bzT/Un294H4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqpnsUW63KcOYKKDJ+xsV8psXuBQgLZeC7uZSMHcB13kziRHTm
	CP/xBeY7RCvzM1cJcLk/rGdT1UcVIRmZ2vTsr5P9o+LurHDdaMwLRD8fjebjVfIN5QkixYQoAfd
	KU+Ro1OwfPiSoyHZtp3WACn0Ep0s/++NLegULETC/
X-Gm-Gg: ASbGncsi8dCZLwznmQ1zaGhbMwW1Hhy2GzMH4waoZGoipPXEb3TRGzMcM5tq9a1TCMI
	4EEbp0jvefelJbcvKz60GwI8LgGpHGe57/7oe87J/CgErX6+ApGEHgH/mjIPusIuJLMHlbljQYY
	Ivg4Y0/w4W8l+0reRxEC1Do4VU3Oo80LvvuMlYosAavevjmK9X9DxJMbptwHgY+9gYY7tzIGb9x
	8bQv5BT3lFiJa3Yu/pMSFImJrVjehGYFo5EFthvzm4CpMnz
X-Google-Smtp-Source: AGHT+IG8fHTK0JHRHJykqJ4UGg8mUkj8ySqnJAAwPbZ5I/l4ILqKzu2I8nV3bt5OAzXHc1cMAT83RGVQDVhLDpFSVOs=
X-Received: by 2002:a17:903:3804:b0:24d:f9f:de8f with SMTP id
 d9443c01a7336-25d25a73995mr47545065ad.17.1757689120635; Fri, 12 Sep 2025
 07:58:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912131104.1726775-1-yanzhijian@huaqin.corp-partner.google.com>
In-Reply-To: <20250912131104.1726775-1-yanzhijian@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@google.com>
Date: Fri, 12 Sep 2025 07:58:29 -0700
X-Gm-Features: Ac12FXz1H0aiUVuI2ZceyQFnUNMDlNBWtZs6Dx0LlgWmVPtY7LadNBf506fI8m4
Message-ID: <CAD=FV=XKOj42jkZWr7OF93=tsAsW+=pAk24JagFVFKZRtxEwMg@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: add support for KD116N3730A07
To: Zhijian Yan <yanzhijian@huaqin.corp-partner.google.com>
Cc: sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch, 
	hsinyi@google.com, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 12, 2025 at 6:11=E2=80=AFAM Zhijian Yan
<yanzhijian@huaqin.corp-partner.google.com> wrote:
>
> Signed-off-by: Zhijian Yan <yanzhijian@huaqin.corp-partner.google.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)

Please provide the EDID in the commit message. See nearly all recent
commits to this file. Thanks!

-Doug


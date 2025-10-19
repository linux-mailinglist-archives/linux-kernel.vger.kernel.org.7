Return-Path: <linux-kernel+bounces-859571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02975BEDFC2
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 09:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75EA23E7089
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 07:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4E7228CBC;
	Sun, 19 Oct 2025 07:43:00 +0000 (UTC)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4C921B9E2
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 07:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760859780; cv=none; b=le+iWi8p6Sjx9+n1f1aJ76tYhPSfVvl9e61jBES4daCQ/AMmIeJnobLIuy5aZstrBqYw8Wx8tFVyI2GjQUdis1k5QxEzg+2cToVj52IMiPYfuLJ9fBoH+BNs8ZSrN/RoGhRB5OKCLohJb0DHjysy9jsnAxUtk5LoYmUsCx1q6fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760859780; c=relaxed/simple;
	bh=a6iMxdmrYbuGMj6PYzMkKXgm2YkNHUTOljsMub0V7/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HNlB34Hd0trJJFXwmYIxGf+PvY/u81vUV3DmCMwn8deAgk9tXzuR1W5smlr1zptlz+vI5/L73/T07HL/VvCm0dcGAOmzj/7+lNUFcWcwzPxYM9s3qCdFel0gHNOBU9JrrNbsBCjJekhG4eXXOEtehbr6E+4COewRQ+gfzFL0N4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-57bd482dfd2so3237051e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 00:42:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760859775; x=1761464575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a6iMxdmrYbuGMj6PYzMkKXgm2YkNHUTOljsMub0V7/Q=;
        b=pRyRwM1mVEoJ+cxa4Ey6iHQFAromp1S/8BdrLK0dGhWKYzmItgfhccMO8Y8DPirxsy
         Llf7Jnt4CKkWq7TGdiB/uzmpRfpJO1npQgCVOXhHCQ8uWJY6EQyX+wp1bYVhMBsHsSOX
         nygde1l8s9gWSmVxHZj+zloFDLcT4Qym/CrHrJ1J3+iHTrhFBje8aRCYAW1xtNy1BPtD
         4ZLG8d8UlqSLi55RaTobMSut3LzhewoMXGfPItFVe6+fAbkMlwiq7H/BE5iiLYD3tiH+
         zT3wmBnwOpDUWJs0tJJ7mUOV6qoddRV5jdp9KRjvYuKQrj1P6PZ0PGh4VzHubYz52Pg/
         fSzg==
X-Forwarded-Encrypted: i=1; AJvYcCVGqdiwTgKdO0UiHu0CvhaOQpqB5Hc1z27FXfhvzDTU8wgPeVPLABMwSzaCiyIqLC/TAM8PNuYztYIMuSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHC1wSwGtIpDkzwKaHUS41wzTsiqp9TzRo/gjQMfMDk2H5EH5H
	1StsLgB3WMBrBoIfLqqdgJUbm/ysWxu6WF9h3wUycu9fJ7Fxmy+VSXsccSj/D8CU
X-Gm-Gg: ASbGncvYMmI+PpdIo2rMxYj0Ve7lSJ5PjT+YvrjDcet4loc13B29YOQlerF7VHS7kLs
	OISqxWLnHqebEM5FLeOjc0hZfXQTS0wpnCBi2kA/nAoPFeohJ9u4UXOmtDCHj2AGqfoJ3fuXYsU
	z1iaSM3OlR5XabgrDiWgi/J2DoO41lp/UVoE3/Ohf3eAsr0XsQpV0zyFlv/aXeUAtTrWDQdPI3L
	F1RW4v5PJUOdNSyCKuKmNzQuQtcQ5NQBPGerJGC/VVCnEj0/vigMbCMuqBdVXxcHjS9K+qf83F1
	F0b6lTMX1ZvEMKy1EzDP8hHLaMig1rpk8aMgYDwdXzPMOqvICxCTVf8w6BYYg0+LTmNVQy2VPcO
	tYUcP7WdyeoMg7AM4+pabTf77CeIhZNzFzKF4aCUccvWjtkJ4jWgm9kDFJherHovGDQ5IX6Ua03
	ta3sSzbeOaOSXbzxEqfB0EqgYKfnRCvqfiMovzi6A=
X-Google-Smtp-Source: AGHT+IGQ3JlbdmxRFbh78dczXGU1H2zf68nefrTPfNCIEVIAqk45XEYxN9ZPkb5EqfP8wMdyLnGS+w==
X-Received: by 2002:a05:6512:234e:b0:576:d217:3f84 with SMTP id 2adb3069b0e04-591d84cfc15mr2991930e87.3.1760859774771;
        Sun, 19 Oct 2025 00:42:54 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591def272d0sm1335945e87.108.2025.10.19.00.42.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Oct 2025 00:42:54 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-57bd482dfd2so3237032e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 00:42:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUR9nSSObhVUcRud5GNn9fDQira9miYh7D3KdclwZSOaE7xEWRwOaB46rWYnXq0z2Y8A5+jT5lTqpPUFzY=@vger.kernel.org
X-Received: by 2002:a05:651c:1510:b0:336:ae5b:8a12 with SMTP id
 38308e7fff4ca-37797830eb3mr28747941fa.3.1760859774128; Sun, 19 Oct 2025
 00:42:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251012192330.6903-1-jernej.skrabec@gmail.com> <20251012192330.6903-3-jernej.skrabec@gmail.com>
In-Reply-To: <20251012192330.6903-3-jernej.skrabec@gmail.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Sun, 19 Oct 2025 15:42:41 +0800
X-Gmail-Original-Message-ID: <CAGb2v644YqdwspTda7cy6y6iYQHRrt3e5hD_m_pEfC-x-py1mQ@mail.gmail.com>
X-Gm-Features: AS18NWCc9PhOVShnjr54QcL_MXzi6J-9o-zc3G5gD4DZJXqV9MLEpSrxeXlLZX4
Message-ID: <CAGb2v644YqdwspTda7cy6y6iYQHRrt3e5hD_m_pEfC-x-py1mQ@mail.gmail.com>
Subject: Re: [PATCH 02/30] drm/sun4i: mixer: Remove ccsc cfg for >= DE3
To: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: mripard@kernel.org, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, samuel@sholland.org, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 3:23=E2=80=AFAM Jernej Skrabec <jernej.skrabec@gmai=
l.com> wrote:
>
> Those engine versions don't need ccsc argument, since CSC units are
> located on different position and for each layer.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>


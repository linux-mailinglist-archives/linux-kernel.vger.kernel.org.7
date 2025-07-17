Return-Path: <linux-kernel+bounces-735149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 561DDB08B7E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 13:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C7653A724A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 11:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731B1292B3D;
	Thu, 17 Jul 2025 11:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mt6JiRx8"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5A4299A80
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 11:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752750178; cv=none; b=us1/Uc1HnyPLg8nNI1XiDhgiwlIDPmDE2AeqjHfwoKxla1+/dc8G3cSjQsvIGrCxSoF0YwxmV3zm3s4Ck7SxsDXUHKhCnIIQ+196xcG0Okr3uSTrUviAbg515Iuw/xSz1cBn2HwVxH35qXupuHNZwO8klsSwH7tfMzmaiFD0Lwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752750178; c=relaxed/simple;
	bh=z1PtktcRsZ/1y2GQDdgiGTLHoyuyjdCFmoAI6pe4z3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pu524VDROWoypNHog5zKhsJdJrJI7Cv7kqGgqqGPnVebkkNV+3tH/bifkk5Uq7TMcf8Fc3K45sTwkukRy8g+FiD2QyGNL8cgLCPwtikml0zdQ9HF2pktgSeBZsNk2kV1ilv7mSxGB6M0jl4SiCqqr39qaE9Ytz/YR3XzUimtNw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mt6JiRx8; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ae0dd7ac1f5so138568666b.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 04:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752750175; x=1753354975; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l1EndfwEVXqzSptJa18PcD8xERGQdTClp/Pdy2O1mJs=;
        b=mt6JiRx8orAmTsD9IwCfSUzPZOs1Y8km8b3NH1CHhJAQH+D7Ya3hxlDyla7q8bDnut
         I66ZfE8kBp9Nqyd3/Lq2kdMKjuNS3iLIC+ua2XQHRUSuyr8Y+FMkB21pt5ESOFOBrRh3
         pyBGCRGAnCLtJ7feb6oTfxxdNAuaqj4fPGf6UKK5elTaBLB5dAvJJkHD2qBMVHmbfp77
         OlQNhCa58ghLBpI9m2vULZkbm6dIS0bhT5vpYJWJLGClyhhb2N098w13qAXUHIIepUU0
         wkykluMIyzAhl/yo4D3u3+G03UwHMDPRO0w4N4Xm6yPnyYaWGUM8EluzGyl1NL6xx0Zr
         ElwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752750175; x=1753354975;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1EndfwEVXqzSptJa18PcD8xERGQdTClp/Pdy2O1mJs=;
        b=j4e1h2ox0Q0/N8kdWswrmPy0/fZrzUt8oWwH4yOn9H0j78R3+U/bQhYJuU2B0ofoZd
         F6SpLXyvgKv+RhOOrjPdO88YUqFfO8NCneD1uKmrg7Zua+T4OqbWroUaeKYFwgNq1uF9
         1foMGQ2Z7Rp3ruYUkDkOW8jb/hn+NHtuS8lVGb3llyDmt/3Xml76/GzcSBeFVoHe1mIx
         61tQiYRkesUMxlTRYUWDhxrv/8NbeVH7dCzTG0PSjBjeDyFF+Nj/UnzXzhrp9HaDvBRb
         Oq1gpwM8EFirFZdsCWSx0xjo9DSK9qNP4G04/prqBJJZOfMtwrBbf8QzF7L3utnVgkFb
         Ktdg==
X-Forwarded-Encrypted: i=1; AJvYcCVV058RVvWuIpRVaN/7xVBxoCbJ4pxrkyDttl14avEo7AzIzXQdp019Oveoiy4BKEjRuy6fiUxbVCJE9Tw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2isr3RL4PY3RN0DASJLxwxZMwcRnwXmJtqn5AwxN5uVEyZv6q
	6RItqduIlXQ3v+l4ORrm9Vh6/llZZVPswBo1HEBEXh5ImLvZnNC0EoVIxU8EXVFMdvc=
X-Gm-Gg: ASbGnctzWPp72tsJgXXBQ26lwEIMTDhxAebWZkqewz05e6F/muDVZGLJ/jonJ4K2eFd
	Ym9swQrdddlHx953UzrEOUA3BJRjeaW5Q5skg9XjNgwWmkY5u2C3C6Ue6zFwzHWxBeAxdxglqt6
	v83hLv2v+79/x1GzOxuV71H/bG6gGdavilkJHX+0Y6zPBkqwkodpEu02auziCgb3GOrk1viOfu2
	4m++VkVBQnSc3ZbeZCQI931PeiCgFc6V/7B2i4WE8aleLous7I5s6n/ya9lVHhs7JiF8SViNDR8
	RIe5t8yPkNb7fUrVSVZceO3ilzCR2iDou7s9g3ihb96obReSTRzWw9Fo0zsr0aowHZdgFsZEakH
	Nv6uJLyq/Psm3V5oazMM=
X-Google-Smtp-Source: AGHT+IGeG4Q6tKxZC/ujOckjGsjHYhMxLU2nUMZOOzS48SXrFZHO4l2kj48NJp+pTDUjshnDsQO5FA==
X-Received: by 2002:a17:907:7f8f:b0:adb:2e9f:5d11 with SMTP id a640c23a62f3a-ae9c9af6f85mr650313366b.37.1752750175298;
        Thu, 17 Jul 2025 04:02:55 -0700 (PDT)
Received: from linaro.org ([82.79.186.23])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8294042sm1343873966b.119.2025.07.17.04.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 04:02:54 -0700 (PDT)
Date: Thu, 17 Jul 2025 14:02:52 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: robh@kernel.org, lumag@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ulf.hansson@linaro.org,
	konrad.dybcio@oss.qualcomm.com, quic_tingguoc@quicinc.com,
	quic_rjendra@quicinc.com, kamal.wadhwa@oss.qualcomm.com,
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] pmdomain: qcom: rpmhpd: Add Glymur RPMh Power Domains
Message-ID: <aHjYXFyQ2yTovMA9@linaro.org>
References: <20250716152758.4079467-1-pankaj.patil@oss.qualcomm.com>
 <20250716152758.4079467-3-pankaj.patil@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716152758.4079467-3-pankaj.patil@oss.qualcomm.com>

On 25-07-16 20:57:58, Pankaj Patil wrote:
> From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> 
> Add RPMh Power Domains support for the Glymur platform.
> 
> Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>


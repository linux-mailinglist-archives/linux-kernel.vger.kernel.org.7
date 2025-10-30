Return-Path: <linux-kernel+bounces-878664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD02C21340
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34CE81881C82
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97CB23909F;
	Thu, 30 Oct 2025 16:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="na+WmttR"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1BD1A23A4
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 16:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761841896; cv=none; b=fbOAI1L3LKF+eVljRKwqHMXiGDvS42eLuZhoMpGUwxB2jz7RonoEizQV64l4dFZ217B1grGrU1ArvC7cpa9g8Y8DJrkay3mELTtR/NNBYGmr2v+ftr1DM76tBZRDTTETVybbXkD+QwYNar1zH8cPa8A+4zqahvMuDjjvKvVQIGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761841896; c=relaxed/simple;
	bh=Lcro7aS2LTQSDE5KiwibL0iMqZiuCu8FC+2EGOTSddI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sd11JQpbvQFXMqqdO51uZRQF+yo9RNeCvDjnruUjPctsmO06MuldUGBFp2OpkDfuoBn/zd21WanQgD325Sif/kMp9FaEoOpvftB0VsASWl4eXQP+JzwUTZo36+XzZRkd4p4bOMRPqBAXbNzy+GZDKXuHHn+GVHRgBeOJeCyyp1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.corp-partner.google.com; spf=pass smtp.mailfrom=compal.corp-partner.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=na+WmttR; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=compal.corp-partner.google.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8801f0f46b6so7282976d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761841893; x=1762446693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lcro7aS2LTQSDE5KiwibL0iMqZiuCu8FC+2EGOTSddI=;
        b=na+WmttRNxeEsWH5SXK2p+tYyQgIB8myzXcv2iKEBIm9fFDsggtLTyNtuOlbJRLusg
         LqDNgdAmO5q6JUWOX4SNz4vhst8Al9h1K23XgmE/Esp5Y+n+1Zbn5zrDfEsrDu9J3lWO
         vd/cZEbh9Q0damwn0yzC26ZltBKP5GPLFv2CN5OH0y5lWwFh1NABdyIlDW80hp4/QrQW
         EDIQUJ6Kq3/0yCcIetU3yx9T7Fu09w6ou8mEGesUgc9OsIQqkS6z8cgG3Ld8ATGqSDJ0
         MUM05WILEXPqXNWCJY+iVZDTKYt9aB0XQ/GcJeCLHtzo1zLhnK+zXU9QB1zEyvINc947
         4WcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761841893; x=1762446693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lcro7aS2LTQSDE5KiwibL0iMqZiuCu8FC+2EGOTSddI=;
        b=moQLJ53TvQjC4x1n1xbJDsrurMVcRq/SXJ3MZOqoHKKoa84hvq5pdVCU8IFj465EX6
         66z2nuVg3WM2LAjOuSnqtoAlj33qtmCWH0d9wDq1udM+BHxo/Brc3Fapd2Rq7NVXqdAR
         KUwZdouOCIyIwlkQ8gi1/LY3oWs85ylmPsjGQTJ4dNxY2zUW4PsXQOS2m31QCt2PHsUf
         nU38Ava+OMgU6Oa7hqYKK/QoKIkLq62kGOuHssmPYdQYH5WyaUm74o8NifzatkF3FW9P
         nmcOQTNs9U5xUdAZDorBAZ6HBv9VHWdmioH1TyAFkPweJ15tNlM6CjZDj4j+85GPWQwn
         4Jhw==
X-Gm-Message-State: AOJu0Yz5Grly5ZRk7sEJDEBktHvwLkiG+2kJOZx3qVwEuW2YzUn6SFnN
	1OdTok5TKVGJhLT1xS5KDmDpfCQAvVATPsoKh/TtjFFGW3jLbcPZnq/LpKjo1AMBsgK4e3IW9r6
	oaT1JAQi7M78o2awb50slU2r48bmw4ay2+S1Q9z+gsQ==
X-Gm-Gg: ASbGncua6KIF0vvvXDzEOTJpal9PLOPlBo9I49CQEBU7Zg1piJfXom0Dtiu6sC916tQ
	iyvdFMGLFCQGxrn1AjvWYa3/sB9g9niDE7akIrCEyVvZyZ83UsO+hEWqDYXn4rwJ/2Z4m56lHRz
	8HbYUz37mtSgBgU9jxm3oMl2gmPSQvbZ78J2cDV2c5rqwmdkQS3OMEO3zc2L+nWxzA3aLea/FdF
	uDRu+EeCLlk//Q1Jqs9DrOHTn4y4S+p51rhNpNDifqVpFODtwt7IdbFZX95ltQu9bKi7cZUCNus
	FnQGHHkXsaRcDaDPjA==
X-Google-Smtp-Source: AGHT+IEkj46+/B0K8GIyrlYZyKHcCV6t6mvnj2aOt9aXfuZPt6AReZRXp0RWtwLFCrq6LGljuPZNyWbF+jhr2bn5n/0=
X-Received: by 2002:ad4:5f87:0:b0:87c:2967:fd52 with SMTP id
 6a1803df08f44-8802f2f5681mr2517706d6.17.1761841885454; Thu, 30 Oct 2025
 09:31:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030094434.1390143-1-ajye_huang@compal.corp-partner.google.com>
 <CAD=FV=V6xV0m4pj=7f2dxDP-0A1AaQuYJP5NAnXNz1_bzH7nSw@mail.gmail.com>
In-Reply-To: <CAD=FV=V6xV0m4pj=7f2dxDP-0A1AaQuYJP5NAnXNz1_bzH7nSw@mail.gmail.com>
From: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Date: Fri, 31 Oct 2025 00:31:23 +0800
X-Gm-Features: AWmQ_blljuOVJEoWM8HEfx4HXzb3s-EmtRR_lYI7XqNnS-lC5zNQ1CNEjOYQWaE
Message-ID: <CALprXBYir7u3N3x6pZ_VK73Nrp5dP=qt5LCnUdhrjeQo4s1JsA@mail.gmail.com>
Subject: Re: [PATCH v1] drm/edid: add 6 bpc quirk to the Sharp LQ116M1JW10
To: Doug Anderson <dianders@chromium.org>
Cc: linux-kernel@vger.kernel.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	Jani Nikula <jani.nikula@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Doug,

On Thu, Oct 30, 2025 at 11:08=E2=80=AFPM Doug Anderson <dianders@chromium.o=
rg> wrote:

>
> NOTE: in general if someone is involved in the discussion of a
> previous versoin, it's good to CC them on newer versions. I've added
> Jani back to the CC list here.
>
Yes, you are right, It's my rudeness,
I will pay more attention to this detail in the future. Thank you for
reminding me.


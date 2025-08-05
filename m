Return-Path: <linux-kernel+bounces-756331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C116B1B2D4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 13:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BDE63BB682
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 11:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2213B2561D9;
	Tue,  5 Aug 2025 11:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPwyY1vh"
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174A61D416C
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 11:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754394849; cv=none; b=BIDVCow91GXOTPSU0e+SrlkmSERGWQotW93fuNXZr/mN0jYIqlV738H+DG2okpDx19iYSV6lMJkWoTp/wUqqGWW+w1ZBskgnnDsq8GtuJH0EwaUrpBuK3eMqAlf3cX3eFTWlwHkjNIMc8Lihl6h4hxQiorIOhck19No8ERiKsNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754394849; c=relaxed/simple;
	bh=S8wXRTgxzn96H3CED/rPlblNWhUInnt6tVBHj4Xy7fs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sHy6Zc9XUJxpBOxCo2IwDvkEsN8RhL0RIKKViecK2ZmAph/m69ubVDMBmLhj247PpNnnw2Vnu+fWaiW8qX5jxN1LsDdI77YArSKD13RdTHV9KEk0rDPifW3xP1EwAT1rnSLcRUh97P4Vbb4zv+j+GC2ydM09HWrZqnyCc5wPFBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPwyY1vh; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5393cfc2e77so2346571e0c.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 04:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754394847; x=1754999647; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nMWT2yAkC9poiQmiDG3Eme4KwKIo8NaBao5tQDa3Na0=;
        b=iPwyY1vh19aSvFsCnEZ+y8n0hgzuUYqDOOUWFsteJbTaWxriLMNDZq9grlj1gPeaNa
         u0jYDQLYG02h1ERH0ucp990xdbjqd0lYNY44pYEs8wVzDv51YuED3roQbB1BAYVzvcaw
         eRDTPJ36BKVexRpghgU2sf1xXT8J26yA3J1/nPyI7d+lHwoV9TgTwKr2Ukx+wDKZz9zp
         zuJtmcNTzve/xU3OvdqQRUFrOCdhKFGAOzJjZBsNdx4SAN53BZAfxL8z+9R/kFdUpnIW
         bCns4tk4MmuRrbJWFe0JBfzlv9D4JUfWmnVfzMLUcKrshHfmC4kO003O9hAtutT9jxzZ
         j4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754394847; x=1754999647;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nMWT2yAkC9poiQmiDG3Eme4KwKIo8NaBao5tQDa3Na0=;
        b=KtSFeMc1Ml4lbWulOq+CcDsGpJX+yo+ATrbUMgtSZ7rvcQss6INz+P5FM37/l2i2fA
         J2X7VHK4zsk78BTc1lXKkohr6MY0MHdKzsvYooJu9R4rD3qiXe6Pb5T5sulnqM4O4pYC
         Hh5EGZAcCgmsWfKZ8n1p/gGdyHSzQfwu6XrkS0mbIxgIWxr9knWstZD8oZh5xbCeFOiH
         WcyPB2ujXvt2vj3p9Yd5T6wVp/VVkyJKykFNtEvTvtYDQMh6+jP8GfL1nTDkStgHRKOZ
         QDuOkS4VMcO3GGsE5QDLvQNuIKXEoMPdvYUxEu8J/VcSL+zY9k+VDL0EZ5A2Tot0u7oH
         sb+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVgegF34O4wcuUE/h4lVxX3ZkARo5RARXdi106etyqIMebeWFZE0N7OdVRaPkuRCAYFmEblxJddUci79cw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxruIKNSgRQPMe3TL7T4sMNJFwMBa1/eQ15QJfEEYioA+vNIgxX
	hMET1gxlAhMdhBojWouSuTXLpzC+XNC3M3CdKIH7XGeREk6qSD5dEHX5hvQHQ4q5JzhF4YIlu7n
	jtu94CoiINX6vRW106virC6nnUMej9i0=
X-Gm-Gg: ASbGncsnxAA/c4ExsErsyBXapV9sLgh+m2enmHXDGtCvRW5IzMEMSU1cgCzC+9Ok8kj
	j44l5hbAGsta7sirr47kSudDi9gyXCKp2OepUMbj5T8qfzQDZYRd2P2tdDlFMHRMhPRLHlu8z77
	GoCtezpcxUHjk+bULOtKaZjFOske/tNjs58MJqp2crvegTHDxUSlNNlR0wG+zLDvB415xlbBjDM
	GwWCi02kR8NAt0=
X-Google-Smtp-Source: AGHT+IG2V92W0l0OwpbZeUfC3F/wkgbkb/9IsXo1nWVQk2+FSLJEs2+4PjRH84lDaaw9wrUSA24ZzgN99lkxqM+ysDk=
X-Received: by 2002:a05:6122:3192:b0:539:58c2:1e0a with SMTP id
 71dfb90a1353d-5395f19a9cdmr5983593e0c.4.1754394846516; Tue, 05 Aug 2025
 04:54:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804212902.22554-1-rampxxxx@gmail.com> <qf6xwtxh57jg6ico7n53ft7bepogeal5wfhthodsnf55eabgum@de2ah47jovbg>
In-Reply-To: <qf6xwtxh57jg6ico7n53ft7bepogeal5wfhthodsnf55eabgum@de2ah47jovbg>
From: Giant Sand Fans <rampxxxx@gmail.com>
Date: Tue, 5 Aug 2025 13:53:54 +0200
X-Gm-Features: Ac12FXweqU7nV9K56xaxh8ocEV9BLO_mODDYQxsm2W9z3W52maWYVlrxOG5FvRY
Message-ID: <CABPJ0vgz6gib5LdKY1O6uhPq7Tk5GN2X_dcGBwtx3b=TRQUw-Q@mail.gmail.com>
Subject: Re: [PATCH] drm: Add directive to format code in comment
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Aug 2025 at 12:49, Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Mon, Aug 04, 2025 at 11:29:02PM +0200, Javier Garcia wrote:
> > Fixes the warnings:
> >
> >   Warning: ./drivers/gpu/drm/drm_gpuvm.c:2444: Unexpected indentation.
> >   Warning: ./drivers/gpu/drm/drm_gpuvm.c:2446: Block quote ends without a blank line; unexpected unindent.
> >   Warning: ./drivers/gpu/drm/drm_gpuvm.c:2450: Definition list ends without a blank line; unexpected unindent.
> >   Warning: ./drivers/gpu/drm/drm_gpuvm.c:2451: Definition list ends without a blank line; unexpected unindent.
> >   Warning: ./drivers/gpu/drm/drm_gpuvm.c:2455: Unexpected indentation.
> >   Warning: ./drivers/gpu/drm/drm_gpuvm.c:2456: Definition list ends without a blank line; unexpected unindent.
> >   Warning: ./drivers/gpu/drm/drm_gpuvm.c:2457: Definition list ends without a blank line; unexpected unindent.
> >   Warning: ./drivers/gpu/drm/drm_gpuvm.c:2458: Definition list ends without a blank line; unexpected unindent.
> >
> > Signed-off-by: Javier Garcia <rampxxxx@gmail.com>
> > ---
> >  drivers/gpu/drm/drm_gpuvm.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>
> Fixes tag?
   Sorry, what do you mean?
>
> --
> With best wishes
> Dmitry


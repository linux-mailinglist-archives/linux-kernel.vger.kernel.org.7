Return-Path: <linux-kernel+bounces-798848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48136B423DA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE79A1BC2E47
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E06202F71;
	Wed,  3 Sep 2025 14:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0FU7VfH"
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195471FBEA8
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 14:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756910193; cv=none; b=uZcnbl3VDAnsqcia9oUziTYconsVyXscl5PB1EpaKyPOEu9szYzaQHH9J5kfqEgdwiO2KWD2dqWmoAJfIBIQ72A7TANoSM8KvoutleQaqhzouDnEojAfhfrWnYAF5sgozcjwwZ5tEtw24lvRr+w+bkPRP2grFKqNE62ErofBa/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756910193; c=relaxed/simple;
	bh=FjD2EjbDKw0ygXyzoNyKSjg9in5rSyEuNIQm5wUuGwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mEjbjK63/DKd99flcqkkND9PDtwrbJusSp3BUGEmDR9gTE5mfdtsToVV3j0F3XmOx3uk796QDk1TYeG6RzDwQ2mTFC4s2Po+eEcNA5dktaXtVSiOpxZ4syznzkYCSBBbHsZzlIyWXs2gYSVyJBlkW9qLjUA3bLpuBWaLWLQDbDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M0FU7VfH; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-8924a26b283so187010241.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 07:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756910191; x=1757514991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGhbnwELL3vl/Uf5HYqR42UqYFtH5W8LwSd+Jp8CvRE=;
        b=M0FU7VfHj/q9jgeAq112OIAPfbDg1RG3ve0i1r37IzDtIbZR/t1mTCT04mmNROf5M2
         nk1+8GXc2Ee9ZMlapqev9Mdh0ZSx0PPI8kCtFjg5Q+AY2jiDRxZEmKGJbv5DuZ8mSMKP
         nttbXBJ2TCVLRL4OPTVHhkvWfEFY6NxpDiFGBNjJKU4KkEwq4N0Bd/gvUBXMeRhPuco+
         i+YmdiVzfhykAH1JVRvygyG+UXS9AJHoD/AtFJ9f+fyKSwf7vtGjT6+Wibxsc5v5vgCn
         nZJxTAQMddgVkLbip3aVsgFG3RPXuJWejvyiCOZ8OcY9l8dSw5S7XPOpboIbvNRcjEMi
         Bcrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756910191; x=1757514991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FGhbnwELL3vl/Uf5HYqR42UqYFtH5W8LwSd+Jp8CvRE=;
        b=LWd2wHOXh0Ck1n/eKj45+98YVHv75QeVVq82ZqFyHMQPMN5PKQI5lahXiUne7Lbxzw
         oFUGlZLRM0X1Wrghnnfl0OwNQSo7paHLIJS9MtIEhXokZhd4Hopkd2SBrg0oiBz2Il+h
         uOdfDgoFP12jrV7nFxpfuOkaOYnev6NwDd6nEI02UkLMkPW57x8tu2QwOhkfFzcwCBIr
         yTGe1a6t1gvgh4mu5TWO7uQsgd+P/mcFwwk3IjICY8tS+cwtoh2zIYMQexvZUG74ikJ+
         ihXuSHiCP4iUCqoEjTk809LfyGNBq8HBb4MWErz3GoNXJ+99DkNviMOSI7/bcJKw6qHz
         Zhjw==
X-Forwarded-Encrypted: i=1; AJvYcCU5yO4wG9yI6/WfRJZvY4suGTaJ4egYXzyUoHOp7TrvNyTFirGKD/+CDhib7PfeILof+8pY5hQv646fsV8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy0yDIu99QuEwK1xlGkVVqcZQurePNokWpjdXkYO+QfiezDYtl
	EQOMHL6euQk58ZCH7ScrtLcmTi4SuFOchocEqEY9N2b0WPO8wShV+Ft+1/9WKp/98ByBD2X7VQv
	v/ouAw8Yxc509tl+SLwCrzw8Umun6xOA=
X-Gm-Gg: ASbGncvoTeizE32kU3w6wSCmwWSrJqBOZHQWVIaLDlXS2Vah8pLhaKRkR3+nPZGGVzr
	PU3Cldpx/FLwCmNK6m48UzDcR/wFmyPE9yIIdMiNXv5x3WmxoeH9kCaWZ/8rh1cZ+Bbu1Hi0h8I
	8Tq7qJIK0JYF4+eNZuZNpHnmQ7dTdDLSP7qKpbGsxnPX12+3Ws8IryVVgh0Y6RlVj9krN+GqpUL
	jSk9pPXsQb2REe/8w==
X-Google-Smtp-Source: AGHT+IFm0adrFc4rU/J1ttwYt8qUw0pznrd9QgrBFZcQxvvYFdDsElBGg8DoJjvV4xeSkpgmazSYtnBSFjfUCig0xYs=
X-Received: by 2002:a05:6102:4194:b0:4df:8f09:7d7e with SMTP id
 ada2fe7eead31-52a2e48a219mr2420311137.0.1756910190941; Wed, 03 Sep 2025
 07:36:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903120449.380087-1-liaoyuanhong@vivo.com> <3dd20bc8-f258-40f8-9b91-ba3d77ce6bc8@amd.com>
In-Reply-To: <3dd20bc8-f258-40f8-9b91-ba3d77ce6bc8@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 3 Sep 2025 10:36:18 -0400
X-Gm-Features: Ac12FXz-v0z9Z6me-xY47XILS7Anzn-kObWdZ29MSDWAJozyzgsM0dTrU2x0ST0
Message-ID: <CADnq5_OipdyBfAufzEghZ2xTxuBTB35Ag47sih95qs=vD5EJ3g@mail.gmail.com>
Subject: Re: [PATCH 0/6] drm/amdgpu: Remove redundant ternary operators
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>, Alex Deucher <alexander.deucher@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Tao Zhou <tao.zhou1@amd.com>, 
	Xiang Liu <xiang.liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
	Yang Wang <kevinyang.wang@amd.com>, Victor Skvortsov <victor.skvortsov@amd.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Sunil Khatri <sunil.khatri@amd.com>, 
	Lijo Lazar <lijo.lazar@amd.com>, Shashank Sharma <shashank.sharma@amd.com>, 
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>, Prike Liang <Prike.Liang@amd.com>, 
	Rodrigo Siqueira <siqueira@igalia.com>, "Jesse.Zhang" <Jesse.Zhang@amd.com>, 
	Felix Kuehling <felix.kuehling@amd.com>, Boyuan Zhang <boyuan.zhang@amd.com>, 
	Kent Russell <kent.russell@amd.com>, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Tim Huang <tim.huang@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>, 
	Natalie Vock <natalie.vock@gmx.de>, Candice Li <candice.li@amd.com>, 
	Shaoyun Liu <shaoyun.liu@amd.com>, David Belanger <david.belanger@amd.com>, 
	Emily Deng <Emily.Deng@amd.com>, Sathishkumar S <sathishkumar.sundararaju@amd.com>, 
	"David (Ming Qiang) Wu" <David.Wu3@amd.com>, Leo Liu <leo.liu@amd.com>, 
	"Stanley.Yang" <Stanley.Yang@amd.com>, Mangesh Gadre <Mangesh.Gadre@amd.com>, 
	fanhuang <FangSheng.Huang@amd.com>, Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>, 
	"open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>, 
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

Alex

On Wed, Sep 3, 2025 at 8:49=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com> for the enti=
re series.
>
> On 03.09.25 14:03, Liao Yuanhong wrote:
> > For ternary operators in the form of "a ? true : false" or
> > "a ? false : true", if 'a' itself returns a boolean result, the ternary
> > operator can be omitted. Remove redundant ternary operators to clean up=
 the
> > code.
> >
> > Liao Yuanhong (6):
> >   drm/amdgpu/amdgpu_cper: Remove redundant ternary operators
> >   drm/amdgpu/gfx: Remove redundant ternary operators
> >   drm/amdgpu/gmc: Remove redundant ternary operators
> >   drm/amdgpu/ih: Remove redundant ternary operators
> >   drm/amdgpu/jpeg: Remove redundant ternary operators
> >   drm/amdgpu/vcn: Remove redundant ternary operators
> >
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c | 2 +-
> >  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   | 3 +--
> >  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   | 3 +--
> >  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   | 3 +--
> >  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c   | 3 +--
> >  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c   | 3 +--
> >  drivers/gpu/drm/amd/amdgpu/ih_v6_0.c     | 3 +--
> >  drivers/gpu/drm/amd/amdgpu/ih_v6_1.c     | 3 +--
> >  drivers/gpu/drm/amd/amdgpu/ih_v7_0.c     | 3 +--
> >  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c | 2 +-
> >  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c | 2 +-
> >  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 2 +-
> >  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  | 2 +-
> >  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  | 2 +-
> >  14 files changed, 14 insertions(+), 22 deletions(-)
> >
>


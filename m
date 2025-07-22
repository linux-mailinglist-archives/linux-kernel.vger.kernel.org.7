Return-Path: <linux-kernel+bounces-741058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EBBB0DF8F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82AD5AC304F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072FC2EB5A1;
	Tue, 22 Jul 2025 14:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QuKq1ZEN"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068C31DA23
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 14:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753195748; cv=none; b=rwKghmomnGXmLy6bSgOutojba6sEhIgCtaBW/l5Sjuq+mUaQ1vxsvEiJflSFC/SsJezyDbkCpxr+cI1ZLGVjO9dY3nGEmskMq6jwCO9R29brpkxKUQIJ7O9BPYAhfYQC3r3dVUrFiJ6PZipHVHqzSPDP5QvZMSaRiekDMi3Q7XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753195748; c=relaxed/simple;
	bh=1ungdcdqCOtd3PdeuZ9hsjsid5xhVUCaEm+a/HWovpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RncrBLRjhsQqZL4A4sWzlAIR9QW9NHU/KpWSODA3myesNaApM/zvkWG1HYjG++mKwh87nIdmQUzsW96Cd5mLhq8onxDOzR395vMsDA6LFzjl27uMPKBMa2/nJOTU+TOoPphM7XP4vrG+UX+Jw96pYO+ukOFFiJULDbBrYpRCXWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QuKq1ZEN; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7426c44e014so5148470b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753195743; x=1753800543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=llvPSqwtXAU3BSB30Xc7oEbXQ8gj4nyoF+omK4Sqcbo=;
        b=QuKq1ZEN54+ErGQUfgE/PhE7657LoTrTAXWCUOdAmWrFKWzfQdyGd6BA6vL4QUEAkP
         mYd//KVetGbbHujhBOjxcyEGc+Kawzwz4OxzW35z7GcinLOfWRMXtPaKOPtH3SGg2Txk
         3za1cfHbIdmQS3X4t7q5hp4SjGG8yV9WoiYJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753195743; x=1753800543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=llvPSqwtXAU3BSB30Xc7oEbXQ8gj4nyoF+omK4Sqcbo=;
        b=PZIPWuWzHPKDdfK4kWU1ONXOwSAJXbmmruJuaO3Z6w8p3VVmQ38XUFf2P3o9eA17Ou
         sf4/jg98o2/yJEArLk0F3BmfmKseQ9CIwPOO0Q8sSS/knUHwAinyM2R/MCcLOCniGsx2
         I/HFoH55LnGlkP7Az4rJ6JRwpcarOgwq4K73e/+J50pFYGPDhqlCT9/d40M/qeFfviT9
         sIJ3pmM082NqXmnCtsqCNpIB87NSNOIGMYXAUFyFYRUHCzF3x3+kLV/3yDokKWPo/yKv
         Vk9z/yDun2r0zbGB4ZSpwprd3Igb6lqskQwsRzPR6wQiqFzs3q6CyWmbR2WWMm9u8pyu
         dRqg==
X-Forwarded-Encrypted: i=1; AJvYcCUeuKOGjL3xMQLavewv4Pp9q1PWwMIKNLktyu3zXs1PimwY1FS2jClDy45iVaMHsBW50c2oD+LvitCzd5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtnD3febgyR8xBqE3wgo8dGJFXMpymzAcpKdFIThRJbtNVwZyy
	vCixypEnEcv6AUnHRlHC1+xc4kKbs7KAYmnquNEVsmJMmhRtucAKgmCe9lf9IXIRWEbOcMSO/mt
	2jME=
X-Gm-Gg: ASbGnctnx8uxKHQNuz5UBZJ5PsNko/8qX5DgmUAMpzgZakfCVkT7j6aDx5kMadli6Pe
	RfmHrFapKpRiicV9uY8UBT4tM0vX6BvM5CAPzMyyYzX3psor/Cam627y+HUY1D2rtRkFoy6eYyN
	NBEtbR6V7lILFFYvTlIDAPfD9G+UUXvR8witJMY80dsZuFDFaEgpKwVbJnZ0xFDkfoqvOdlf98R
	eC18clx7soBOWut4PpADW6Zico+OwWFmPK4PeU0T7YEsOuft7gL43mvYH59Tzxs0Wy/gorCb7R/
	xbHQ66d0svKqQmLehzIpbiwlJqtdCmAHqkmKvo3uK7wEknRYB04q/yWhsLZHCFhkLWBaXKfkt1r
	DIVwjnT4IH59ZtfdNI9fRLIdUVP69c+HHE0D80UBjxq3wYDp6bG9w9hJPSodYHx2LdQ==
X-Google-Smtp-Source: AGHT+IFu+DVf8/W/K5nxDVUcr3v59Qen5smSnvA3WwyHMak8ctD+xoHm+qBsCWehZT0BkQHtepSexg==
X-Received: by 2002:a05:6a20:3d84:b0:232:36e3:9a4e with SMTP id adf61e73a8af0-237d7b6cdadmr40426331637.40.1753195742872;
        Tue, 22 Jul 2025 07:49:02 -0700 (PDT)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com. [209.85.215.182])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2fe69c80sm7147077a12.12.2025.07.22.07.49.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 07:49:01 -0700 (PDT)
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b3bdab4bf19so4271940a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:49:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWJVqzGV6E+Ixe5n2IjxSJi2XVmsk0qOC1BCH2lZzV4gF5W7h16H8WcbUuPzzk17mnvGwWFxrBIYxC7BhQ=@vger.kernel.org
X-Received: by 2002:a17:903:2290:b0:234:a139:1210 with SMTP id
 d9443c01a7336-23e250012ccmr396616705ad.53.1753195740688; Tue, 22 Jul 2025
 07:49:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714130631.1.I1cfae3222e344a3b3c770d079ee6b6f7f3b5d636@changeid>
 <d1906219-f588-47f0-a43e-c2db4f9c3cae@ti.com>
In-Reply-To: <d1906219-f588-47f0-a43e-c2db4f9c3cae@ti.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 22 Jul 2025 07:48:48 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X-Y-8gP=0Pop8-idak7b_0ojuqbt5DmGmJM+j4_efFfQ@mail.gmail.com>
X-Gm-Features: Ac12FXxw3_BE6vtlQk9bYKnmlQBa0VzZeJXtxIUp_MKAHZ5KbrSQc3YwQeKZzjk
Message-ID: <CAD=FV=X-Y-8gP=0Pop8-idak7b_0ojuqbt5DmGmJM+j4_efFfQ@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi86: Remove extra semicolon in ti_sn_bridge_probe()
To: Devarsh Thakkar <devarsht@ti.com>
Cc: dri-devel@lists.freedesktop.org, kernel test robot <lkp@intel.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, David Airlie <airlied@gmail.com>, 
	Jayesh Choudhary <j-choudhary@ti.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 22, 2025 at 6:53=E2=80=AFAM Devarsh Thakkar <devarsht@ti.com> w=
rote:
>
> On 15/07/25 01:36, Douglas Anderson wrote:
> > As report by the kernel test robot, a recent patch introduced an
> > unnecessary semicolon. Remove it.
> >
> > Fixes: 55e8ff842051 ("drm/bridge: ti-sn65dsi86: Add HPD for DisplayPort=
 connector type")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202506301704.0SBj6ply-lkp=
@intel.com/
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> Reviewed-by: Devarsh Thakkar <devarsht@ti.com>
>
> Regards
> Devarsh

Thanks! Pushed to drm-misc-fixes:

[1/1] drm/bridge: ti-sn65dsi86: Remove extra semicolon in ti_sn_bridge_prob=
e()
      commit: 15a7ca747d9538c2ad8b0c81dd4c1261e0736c82


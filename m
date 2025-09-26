Return-Path: <linux-kernel+bounces-834242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A430BBA43E9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 357EB740CED
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FF31E7C23;
	Fri, 26 Sep 2025 14:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OlOF7mj9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A21A374EA
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 14:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758897348; cv=none; b=hWPImFrorJ9agXD70R0WRTmvJupWH9nY4ZKWaBSPj19fqJNGNIw6pnM4crGtxSXR96DJjJWQceVdEvgBv1jpuv0rSknXFJSM0mQsHwgp2a2aEFyb/0lqHA9z/3uE5YERv6cMPVPIoAdSb4qgMZQR1owT8gPAJse6cKx/VLWj0gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758897348; c=relaxed/simple;
	bh=lJwDIPedNt2Z2UuEAHlq/adYCAGq6z1uz2X0ECUEVoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u4dNMyPmwPEok0WwRS0fVeYi1wqBqri79rZ/zd94e0vOF8HDCseSNA2azKRAc74mEh79uO2UBaKO+vOGrodAwpK2xaSUPxH95l5PDyMV0pJjtlX3w6dlJdUlb2d7NiOCYeY4leBEOKSHTVBezeHMVvQez5ex9d3MoKQIxA5k0uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OlOF7mj9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758897346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GLc193AFL/MGGHYspsBSJzTzaApnYYVdoylqhmtfcXQ=;
	b=OlOF7mj9ay5haQjfKvWU3ctUTzZaVmHEx5xI7e41w1DWGn3vPFlarbALNFChsNZ1t+ao4b
	ZZH7WZPNl1+Vbt/tEVrq2vaGwtOGSrf1784gpNedc0e6Y7s3lDP+6B3WVSBdfXRRAAXfl2
	lAzhmal5/jKR5RhRH+nZcymDMmh4x1k=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-fiNQhtnuOnW0_PDsBsL7XA-1; Fri, 26 Sep 2025 10:35:45 -0400
X-MC-Unique: fiNQhtnuOnW0_PDsBsL7XA-1
X-Mimecast-MFC-AGG-ID: fiNQhtnuOnW0_PDsBsL7XA_1758897344
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b311b7aa78fso279416966b.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:35:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758897344; x=1759502144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GLc193AFL/MGGHYspsBSJzTzaApnYYVdoylqhmtfcXQ=;
        b=udE3IGtkXgZLkolIirwwlclnZxegpq0wBpU4t3ok3SUQpFi+rARAOahngGeDtYVxDD
         RZfVVwBsiFX7CRoJb3zHqb4b0LB1EqcujYCwbIDOySihZ56jPzG0E82KDpMMNy2FX1HG
         BqPzyVbI733GJLeI1PNe0TD+0LZUZ7OuMb8PAyK82556H4l3aGeInoXJiEdJ1x/7Kawz
         57n9zrfb+wkRPaTtr1y6OrwSujeEEyP/2q2WKqoBcmZoQJqRb7T6CplclmbX2Bsv5149
         dWOig6qdh5umw3O2XEunBh/euvXBhfNybE4dUI3RmNbYoOePNVBgWar0zZNVYg2/2Mf2
         G5eQ==
X-Forwarded-Encrypted: i=1; AJvYcCXc6KFsoFy5JvBM4h5qDyaogYTo+qn1hkOCr405p37DgERCJz2wI0Q9GNWRAnGmfRh5e6msoP30yVRTHQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx25l4nn5M4kslZgy5Mp5ULTpW5PGnYDBRv/2c7dMRNsA4JSkoQ
	Y/53RHRApeAoi3XQOMVFQ8R+H78SuHCci+exv6BZKUCPdq/aOzkO5BRnLYLk6lQTKgIvqBEV+4O
	rNPRbNoKCvDuD8N2GjotZICY5Dn0hkPGaZFrZ5mhdshI5nKO58K9LlX2B0Gi9auwuy8leppfa8t
	NHCFUG8rkCUL9rIXBCaw0lMPlxh+IfY6RPtYO7SnIy
X-Gm-Gg: ASbGncsC/wsbuZit34ChaJGvuTfdVbdq8fOvPd5csGHruHY/oD0Bw2Wy8nVW9FsRIe9
	u4UyO7sHipLgZ+Uj1llMExqXis4DNHeVGQ4XSZCdPx+y+TbMTO85V096RFEPZ8aQ4sZkAs1s1gc
	weOnBm8hu4RISE6l9zwUWh
X-Received: by 2002:a17:907:c26:b0:b04:83af:b4ba with SMTP id a640c23a62f3a-b34be1065cdmr771298666b.52.1758897343775;
        Fri, 26 Sep 2025 07:35:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHY/LqSurKjD4+Cltq9ZQJvKAnaky4bgALTiesjZyT2D53LoboMYhtdlyD8b25uhjT6K30D/Mn0/Fsum4Z49gw=
X-Received: by 2002:a17:907:c26:b0:b04:83af:b4ba with SMTP id
 a640c23a62f3a-b34be1065cdmr771295766b.52.1758897343356; Fri, 26 Sep 2025
 07:35:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915181101.52513-1-wander@redhat.com>
In-Reply-To: <20250915181101.52513-1-wander@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Fri, 26 Sep 2025 16:35:30 +0200
X-Gm-Features: AS18NWAh78RyB8X-IxL_YWJcf8fkp9YQu65AKBmgUXIOMx5d7V4hfI5CJPXQJ7U
Message-ID: <CAP4=nvRbfiMyRJYxMk_4emWw_JuZVAkAjfX+j7S0Cxi_OGoS0g@mail.gmail.com>
Subject: Re: [PATCH v2] rtla/actions: Fix condition for buffer reallocation
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Wander Lairson Costa <wander@redhat.com>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, John Kacur <jkacur@redhat.com>, 
	Luis Goncalves <lgoncalv@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Chang Yin <cyin@redhat.com>, 
	Costa Shulyupin <costa.shul@redhat.com>, Crystal Wood <crwood@redhat.com>, 
	Gabriele Monaco <gmonaco@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Steven,

po 15. 9. 2025 v 20:11 odes=C3=ADlatel Wander Lairson Costa
<wander@redhat.com> napsal:
>
> The condition to check if the actions buffer needs to be resized was
> incorrect. The check `self->size >=3D self->len` would evaluate to
> true on almost every call to `actions_new()`, causing the buffer to
> be reallocated unnecessarily each time an action was added.
>
> Fix the condition to `self->len >=3D self.size`, ensuring
> that the buffer is only resized when it is actually full.
>
> Fixes: 6ea082b171e00 ("rtla/timerlat: Add action on threshold feature")
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
>
> ---
> v1 -> v2
> * Put the commit message in imperative language
>
> ---
>  tools/tracing/rtla/src/actions.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Can you take this fix as well?

Thank you.

Tomas

PS: This should be all for RTLA now.



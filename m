Return-Path: <linux-kernel+bounces-820344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32658B7C3EB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 284D646468E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 09:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E530430BB95;
	Wed, 17 Sep 2025 09:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h5rD3ZKc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CB82EB5CF
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 09:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758101343; cv=none; b=f9Vb++CjXw8xQ8pkAUlr48fSzwO8m8Ke5Zq17ZDEcvHwMP05sEAluryg/KsSnvEJ6AUu2qpnvaZkpcbyj8BvUeuBzmhj6rw4JVTOaXwZXBh6EmBTUly/r3vvyrtJuCYgtrZ9476hRZ7YH0n6AcY4RDGSPkyIuoY3Oj/GPNrdTrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758101343; c=relaxed/simple;
	bh=dCGksgkR3Zz/qgZIuESYx5eaPIpcqeOz0pkSL+rqD40=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p81GUt2ICZaa1FCm4sV+qmz4DbUu8+PScYdCUa/FrKTB1+i2y4FThtE9ydBFNKy/nO6/t4A5aPfaZ5EWwP1yZGpodg4HkB6DS2ojhtIF55CE0OWAvVdYfzOTzm8gYY51m18h14HAgBOG452jrs9bG08rkuHNpBcj7KW2ENE4zF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h5rD3ZKc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758101338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZfNBT1YL7G1FS+Kqx8GTAsO2yANcfaWLONHMG4XFa5U=;
	b=h5rD3ZKcyaGiwfpUhR+HYcDUr6DlInq6bjrkRzEtLerQ+3jXGwqY0Gg+FY+wnmsz/qPiPB
	AdW+3j3gzqWwrqm3KojqngK9Nva1Lln7Lhl/BAKhT7UKH90mxC12odnrY4NmrctOT2yFCC
	/2MDiOLjjPYCi+LfrVPnO6tWsS4w5SQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-b80rJMoENRKF1p0gxSM4Ug-1; Wed, 17 Sep 2025 05:28:55 -0400
X-MC-Unique: b80rJMoENRKF1p0gxSM4Ug-1
X-Mimecast-MFC-AGG-ID: b80rJMoENRKF1p0gxSM4Ug_1758101334
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45f2c1556aeso12794735e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 02:28:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758101334; x=1758706134;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZfNBT1YL7G1FS+Kqx8GTAsO2yANcfaWLONHMG4XFa5U=;
        b=YuCZgzOQahZLg0asoa08DBtslWdwzSgZiQ1+uwYql/QAc3NoLcJ4YQ0YaKesd8RNMi
         6hXnu+CqAhCVOrqnWHAkQYjMKQYvug/Mzfu1RgUogl3Wvr4pU3I7CEzoxcTTO7zj5qph
         Y7i9t61IV6WlugKyi3FLBtPSf0i4V9Wn1tfp24nLGBEbur6KGdHm61eJpvCDE6HBZTZ4
         eaqPynZmqNI/0FFuFvRP/cj3kj1/sSl4jjyc60+g7H2zaH2bQW4+YdoQAgjBKlJb/VlP
         mbq78wJwRBMuUGftAZRck8F8lNzCuYEz0u2pR3kfDrZ9n2ggALTlRjTdDgNbDiL9xmfg
         fWnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJ92543Mpu9MIfYIl05oiQvnmUekwI5bWBeomDQ5IllNWYt7O2onFu7b5UdavneONOYKyiHbqtgR4eHNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZUY22UPQxhIeQm02az2WTA1mCptdga9APMiVFKfJXP7FEEFp2
	4z+1vfEAcZLj57kbPKCLpzYn3AfBMid2PT7cXdDFhaSEL5B5MDP9ltHqMCwC2pB3hWYGSArEYPJ
	soiUnavtpJlHS1txdgkE8AmpOCKctzsBpLiDgm33YV2iYS7fc8oTEYUMkPNP4Qj3CQA==
X-Gm-Gg: ASbGncsBUiDSWnMT64covzv3CXUY27AsyS/5NUtGdKeSKztd2UWY0B7kz2k9Uvk2+m6
	ROTAzuneDqF9Oetz9yMz9eMuzY+dGeRRN7Gakrn1c5Fo7uatGwRKqPLuKWbVE9bNcHMO5UXqBnF
	pBRc8hWqLKIR4AzbieLtCYrpnH+uG657NrJXoeLZW2pXiwLeYkcxGWyQSvMYJqRqXvHQDSURhiP
	7wVjHTGbvSbbnBMG3e7/wNhtgJrw6Xiq5pR0nciDc1++twzTvLDO8j9stMwdxk9157exNsbwewd
	WR8Hp+q5McCFYZaYXUWBXPCZFYK5IS8/NFmYQA/TLw1KiGfVZtH+WLkP3X4A8hH6RRXs1yZErTY
	7G4JTYozdTQYnyPJWKC5m3w==
X-Received: by 2002:a05:600c:198f:b0:45b:9961:9c09 with SMTP id 5b1f17b1804b1-46205adf769mr16887175e9.17.1758101333920;
        Wed, 17 Sep 2025 02:28:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0eaULepLCUdlOVeRpbHOEaxvQhL1o8Xsg4Ar5MV+xqCbGANNxhCkzWolo8lT4zCuGLfFnhg==
X-Received: by 2002:a05:600c:198f:b0:45b:9961:9c09 with SMTP id 5b1f17b1804b1-46205adf769mr16886915e9.17.1758101333504;
        Wed, 17 Sep 2025 02:28:53 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f32674bf8sm33799315e9.11.2025.09.17.02.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 02:28:52 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Iker Pedrosa <ikerpedrosam@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Iker
 Pedrosa <ikerpedrosam@gmail.com>
Subject: Re: [PATCH 4/5] drm/solomon: Simplify get_modes() using DRM helper
In-Reply-To: <20250912-improve-ssd130x-v1-4-bc9389ed299e@gmail.com>
References: <20250912-improve-ssd130x-v1-0-bc9389ed299e@gmail.com>
 <20250912-improve-ssd130x-v1-4-bc9389ed299e@gmail.com>
Date: Wed, 17 Sep 2025 11:28:51 +0200
Message-ID: <87tt11o2b0.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Iker Pedrosa <ikerpedrosam@gmail.com> writes:

> The ssd130x_connector_get_modes function contains a manual implementation
> to manage modes.
>
> This pattern is common for simple displays, and the DRM core already
> provides the drm_connector_helper_get_modes_fixed() helper for this exact
> use case.
>
> Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat



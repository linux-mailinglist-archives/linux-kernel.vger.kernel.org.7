Return-Path: <linux-kernel+bounces-820333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2744B7C4AD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99AA5461A7C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 09:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FF8309EFE;
	Wed, 17 Sep 2025 09:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SCaklSd2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3952C181
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 09:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758101258; cv=none; b=ogaRSHL5qOrQrb4WY2j7lkDgMf4Wu2oMPZ1HFCvnAa5UZYovBTA98FA6ohTClzWjkAsiO5gq1QvkIBsJQJdjRt39paOpmlobjv4vriCsfFjiV+hbFLyEF/nLGOOGBCvBxa9pQzrU/J0+aOqWV6r1dch6dz0CFuqCBwgAFOfiK/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758101258; c=relaxed/simple;
	bh=4bFt7RvE0meXHmC1f+ZoRU6uHj9+oiw4gTVmpGm82Ck=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ddyRo3aSFUe9UtYdme78oNoYCvLEnaZBKQ7VJtRAgHB+qJIycfUSsP72zXpUZC6oNrToNxinMMS837CqlxS+fKmf3ERbmdh9Nc5qQbI8Xsfloak2wX/FU1A/RZJLerWqWzT0QgMpp8FNwvjJbaGkIdlg971lgu2rCTl2DcXBpu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SCaklSd2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758101255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FYsWl90aa2IFCJSMLifqsmjQanJGgpfYBqQYufjAHKw=;
	b=SCaklSd2xnoiE8PKLJ4rbcmZasOzjIoTr4l+eh8qpsYClKDmB2zglcN8SxWMoKzKesy131
	Gigsbu5Sifx35u1e7GWYGzYdRuGnBIeiWeZSxMOJuDJntmymSXbGJslQSSSEvMe9gRaind
	FBGe9VnywuN7kuDc/bitK9P5g/baLbY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-Wor4heHyNEasLosQZNTc1Q-1; Wed, 17 Sep 2025 05:27:34 -0400
X-MC-Unique: Wor4heHyNEasLosQZNTc1Q-1
X-Mimecast-MFC-AGG-ID: Wor4heHyNEasLosQZNTc1Q_1758101253
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45e037fd142so53419135e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 02:27:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758101253; x=1758706053;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FYsWl90aa2IFCJSMLifqsmjQanJGgpfYBqQYufjAHKw=;
        b=lR27dmIRhNdswbhgoSd7QPef0vsGknxYMPEik54Y1JxHt5JNgIdCHNNwsdc7FmeJqv
         V0zBZ17Tm83B0MGbnFEMKVtDBD842Ej1/raZvbaW44M0mxJ34FHYA58MO2M/b3TUjEeO
         elrDOKe2D9Rs1PW3NlTDS/m5xt+gVztESSC6hO78QAUxEvscDzYQ+BF2LvtLRvL/NbRt
         SHYbgpg/MSBqKP+YZkSC9sYheWhoLNoFajOlISfmNpBXC5pfX8X2eJwmALljwA2/HS5r
         /km1jxrkqNnBUckQQr5F4D7A0Ag00gdKY8larVgVpsmWhvqcnsrbXdENOf0aRpt+VgSF
         tJXA==
X-Forwarded-Encrypted: i=1; AJvYcCVwXIfRNZ2eiJyTtRhrjWf4FEn63e2qCJw2VpYwrxmahj/PoWYAxdF7xZxvHwgsAmdM6BZJRwFxGN4BA8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPVyKecEcCmAgu51jJWJeoif5NqL9L1K8VxxZ7EYJEUV1bgqcF
	vDjxIWtFSl8C5W9pngRKBhSEE5teZ6G3NWn4JXgONWAy6c+r+A8BKfcRnaZlrcvg0hD0pOfz32W
	ZIuTMMzotLDtd5fj1Q5flM0osF560O6+EWY7AqdgZa1+Ut5BEgx4NJDNGnWuFR/Rctan8Y9HTOA
	==
X-Gm-Gg: ASbGncvg4b0Jqgh5FcG7WnqNZ83FzWCwNGFZXnWgrr2R8IEQzkwGYcV/xu0zJ7oe453
	dNj9Jwg9u3kW9aw4gfbeKCnWmRAAP8CltyfKumN6968oEUc0jaf1JCa6+MvtBqCBzXIeiYs3FVO
	qG9BWtfwvTjwF4Rt9xzNm9SQZQ93j3o//Xd+uMAfZEcSGlxk17P07nKjsWXDO2wxSPB+StL+NtU
	v9fsOlOCMZ5O4AvTsJH7eHpq0D4k3QlZD2Z0Djh7ja0QKsprYW5X7PV8DUBwOHrgCu8Ni4BF2lF
	dSPQMXcSWqGVsUeouxUItGuXlQL7VCmeM2ubtafPrh/vzls/E+TGH56BqLmDTIKBOqD28X6J5LB
	Wnh5uYEoLhqRHsDfb5p6LqQ==
X-Received: by 2002:a05:600c:354b:b0:45b:9906:e1cd with SMTP id 5b1f17b1804b1-46202de09fbmr13144195e9.13.1758101252691;
        Wed, 17 Sep 2025 02:27:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG02+Djk7I2WYZdxGpqffFjigQcwROtQsx5Gti/Wx1hmpHUcyHWzmZ3z2sX1v+uNmbXW/h9fw==
X-Received: by 2002:a05:600c:354b:b0:45b:9906:e1cd with SMTP id 5b1f17b1804b1-46202de09fbmr13143915e9.13.1758101252208;
        Wed, 17 Sep 2025 02:27:32 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46137a252fasm28873285e9.7.2025.09.17.02.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 02:27:31 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Iker Pedrosa <ikerpedrosam@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Iker
 Pedrosa <ikerpedrosam@gmail.com>
Subject: Re: [PATCH 3/5] drm/solomon: Simplify mode_valid() using DRM helper
In-Reply-To: <20250912-improve-ssd130x-v1-3-bc9389ed299e@gmail.com>
References: <20250912-improve-ssd130x-v1-0-bc9389ed299e@gmail.com>
 <20250912-improve-ssd130x-v1-3-bc9389ed299e@gmail.com>
Date: Wed, 17 Sep 2025 11:27:30 +0200
Message-ID: <87wm5xo2d9.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Iker Pedrosa <ikerpedrosam@gmail.com> writes:

> The ssd130x_crtc_mode_valid() function contains a manual implementation
> to validate the display mode against the panel's single fixed resolution.
>
> This pattern is common for simple displays, and the DRM core already
> provides the drm_crtc_helper_mode_valid_fixed() helper for this exact
> use case.
>
> Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
> ---

Indeed.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat



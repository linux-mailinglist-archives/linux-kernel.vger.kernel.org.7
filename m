Return-Path: <linux-kernel+bounces-725595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 931E3B00131
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 14:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68DE36403DF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDD023D29B;
	Thu, 10 Jul 2025 12:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XOCRcF0U"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D95185E7F
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 12:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752149381; cv=none; b=CrxVzh10bY8u9m0+olDfgIVMQHa8u+bTAae14pRQAe2xFKbY+ronuC9xROSTLEx0J5goCWiUbWiJP0jNH8HFRNGDJsg9LdzLAW7OdmiF2sfqAsx76JOzdtCAlTJjcaX0QGVzEP8GxuESa3YqFVx6j3Pc4SEAJwcJ23wi86iFTGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752149381; c=relaxed/simple;
	bh=GiMMLqaVjlnyC8E/ubOwbmdjmwXu72WP+NMACMj/MF4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E2OpmKauTQH273O6BytNxsnvJRonOBGbe4OPNvbQpHJ60WFiaoOSECKneloRkM33tZCQzv7/w8yemHZgHDnbEHsHMFMU8CvGczzAcnR+lfBZAS+pJJ4+rJzPo8rsH1rKAxkipreYOvBSEkpgbuOs1t00nPlqQMxLCiX+t4O7OwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XOCRcF0U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752149379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=776OH7AlRSbS9pGEFhLPmFroGGCK4asEjWH5Zyyyebo=;
	b=XOCRcF0UXfnQGXTrMKaTHuLi1d3U/Nz5KNNYjCRIpVLH2W9aYrkRvjh4Iwf27CzjFL1oKf
	EV5kcUCDSd1gn8cpVE6cMTrK9OwEra2YevFBgyb6wYkPRLMIydpNqsFoOxGfJzIc2hOWL1
	XfexlQVajOFoynh3CmhQqp+04d+i9T8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-Loede6hAOSWCC_mPrlcnKw-1; Thu, 10 Jul 2025 08:09:38 -0400
X-MC-Unique: Loede6hAOSWCC_mPrlcnKw-1
X-Mimecast-MFC-AGG-ID: Loede6hAOSWCC_mPrlcnKw_1752149377
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3af3c860ed7so481063f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 05:09:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752149376; x=1752754176;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=776OH7AlRSbS9pGEFhLPmFroGGCK4asEjWH5Zyyyebo=;
        b=Qa5CQxyTuG1efxF46WWMokjKKIlxvijKy5BM2F/mz0SlbTm9P0qXSn/Ejtap9z/ZYI
         JSvDhsdf3tA/zTLWhi5XXvS4ccpwtMBW3hffiO/XwnN2flbqeQLRRVeDvT2ixBVCYDXf
         gXqgiMu3OhYEbK+gzlLx2boHkvy9RRF7JjlFxMekKtwiHv2v6n2gJTmu+FmXrcDC31Wa
         cnEwohHS8zLTUE7y30kx8jWMw5L5bUjMMEznxCnB/50zf5fKZALE8s0Yd2AY0JA155ol
         VCEn3Hx2g4SouIHzhbRGkMX224pN12RX+1l35Lhb/lQ4gHe8Jis2oiFGVLjewJoi2uGa
         e63w==
X-Forwarded-Encrypted: i=1; AJvYcCUKwHuPUjFvClzLH1qNV11jbNE7k0uBlHr/JM3FnDmx16E+15owBMle7blwlk5Etqph9SZyUjRw6lPGO54=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBjhCScSMs8+wLhoc4Faq268/yRDoRlJI61mt9iOyIm7uLs7Zk
	++z669yKL1Ihv7V9quQ2rP40UGZbdQ87V1FJib8fRYHZ7Nn73maT6qqLt7c/NKMtwT1JYnQK2bt
	T1i+9brze78OZVCrAmKS4/WFhLO7hmNvQ05hEGqMBv1cY4G7+IdHqe5KbX7ixxkC8dEIW4OflOQ
	==
X-Gm-Gg: ASbGncvY1V4NMP9yI2ao2DjL2B2eE0onsrxki6MkrIi9C99CDAKQvty+jxWDlXSOZHG
	D4XiPvDHsUDfaip8jc/DhMNIROp6ZLbQC6z/o3/tbv5Oda3x5xxT1vOqfCtNnU5pLtWpK1lROwF
	D6j8lp7JtZKECnwdLabCKwAaCGP8a3iYc+nsho6VfUYvASQM+PjeUdzyLvPGCTFIx7+XAxr0XVH
	OrEOPlaxRHsvg0eTHiywLs9m7R7ybCNikjJKk+U9NTgeOzW+RvaO7UuoIt2uzMgbyJDyjRbcz3f
	kSDPHxOnU8kUXxUdoTW4Xkj7eXzzeSSxusVLLS5W6cNiFTJKUBrEvzEX8h4G/9WnZWXmJWE+SoT
	/4/VT
X-Received: by 2002:a05:6000:18ad:b0:3a4:d02e:84af with SMTP id ffacd0b85a97d-3b5e86f9bc7mr2341562f8f.58.1752149376513;
        Thu, 10 Jul 2025 05:09:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF76z7BNeJ29v7X6gjW0ekrWaz+jcptpXrPzJhYJ74eyADqdGhZuiflBfDPZ0UnxHxgWV76cw==
X-Received: by 2002:a05:6000:18ad:b0:3a4:d02e:84af with SMTP id ffacd0b85a97d-3b5e86f9bc7mr2341521f8f.58.1752149376022;
        Thu, 10 Jul 2025 05:09:36 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e2703csm1704479f8f.97.2025.07.10.05.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 05:09:35 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Maxime Ripard <mripard@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>
Cc: Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH 1/3] drm/tests: edid: Fix monitor range limits
In-Reply-To: <20250625-drm-update-edid-v1-1-2d963743ab9e@kernel.org>
References: <20250625-drm-update-edid-v1-0-2d963743ab9e@kernel.org>
 <20250625-drm-update-edid-v1-1-2d963743ab9e@kernel.org>
Date: Thu, 10 Jul 2025 14:09:34 +0200
Message-ID: <87ecuofds1.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Maxime Ripard <mripard@kernel.org> writes:

> For some reason, some EDIDs used by kunit had Monitor Range Limits
> making no sense, and not matching the edid-decode output in the comment.
>
> While they were in the comments as:
>     Display Range Limits:
>       Monitor ranges (GTF): 50-70 Hz V, 30-70 kHz H, max dotclock 150 MHz
>
> They were actually:
>     Display Range Limits:
>       Monitor ranges (GTF): 50-70 Hz V, 0-0 kHz H, max dotclock 1960 MHz
>
> Fix that section of the EDIDs to match the expected edid-decode output.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat



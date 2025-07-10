Return-Path: <linux-kernel+bounces-725608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED45B00159
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 14:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12A491C86FAE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1F1251792;
	Thu, 10 Jul 2025 12:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PACHBUQp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F936248F5E
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 12:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752149624; cv=none; b=JQjOhL7Vqn/EFEAVTjis/o+jEiZ6bC/r7v8DNUbjhQnCZS7MGRmFoSpknkIXkavy0n8xKBDYICX6L2FIToPkOEJfGPqtNW4u1d+QdUZy8ivtjcLbSBCjcBeS4k6uOHdZNNDtZtXQBnX/FUOIxVTqT58oPwJe9KihX4mawbaafXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752149624; c=relaxed/simple;
	bh=9ZIBxh27q1fv0N3F1hVWP+kZxTqoA0uIH86G/WfESFU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oR3u1i0EIMDkNAoEOjhl0uqIFhOVyHPTGgy/jCmIb0h+yR69g8mQHUV9UAc5RWdQNhGNujFzjmRQJFIc2matK+0yJdz9scQEdI9mG5CSZoItXwHjnUQUstlTj8OfDYeMuh+kDjI+sGXtgSRjPObGIWO5G3NFV6sjdJxzuOsrHMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PACHBUQp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752149622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V4lgpdxo1FVLUcK9VrQ20Ig1tFoA8+jWoGG13oO7pPY=;
	b=PACHBUQpnKsL2PoHLzqkiLcVsvXBaK75U2OBaBIw/g1d6pP+G10lJpoX1jD2Y2A/9Gh5FW
	b2W0Pcvf+5e9CphojYl4bf1XTfH2pmPq7us4G8+9xX86imm6YHKi/Ewoqmjc4wXw7ifa14
	kpLpapeVItuUEIJF9S5OIHu/XcSLKAs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-JHBMzdH0OPWHUgpIU4BbKw-1; Thu, 10 Jul 2025 08:13:41 -0400
X-MC-Unique: JHBMzdH0OPWHUgpIU4BbKw-1
X-Mimecast-MFC-AGG-ID: JHBMzdH0OPWHUgpIU4BbKw_1752149620
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-450db029f2aso4978665e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 05:13:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752149620; x=1752754420;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V4lgpdxo1FVLUcK9VrQ20Ig1tFoA8+jWoGG13oO7pPY=;
        b=qw72hBnAZD0LDP+nBEKI/82K29/W8cDBs8fCw03lOoTv1pTYqqJLBf4SFFB7p+PRqS
         N4/brOBB+is1sUiFyiDjGXsdcWXDRw7QwFBkeZ41ZE+LGFl8wC+86U4steofL6JsWLD4
         9PBh/YCz0nJabiWNA97bJLwvlvMBPbmSywrlYXjU5Ue59JryOirBNijjVKHplgZMLTaH
         IQvd5m7Db6n7PdJdedom7TDrcP7OuXN429IleVMNhUHLfXjI8aiU9VJTmnkEY4vIT7Ne
         q3iwMpVHpLT7xyr6eIv/0qmHjRREToikgYzmCsnXLy4MMOH1sOjV0jeCycBWJOTJDpdQ
         MWiA==
X-Forwarded-Encrypted: i=1; AJvYcCVNf5NQx5tJf6SsqigKwTvk4um4yS+HQhd3ha32PrMDH1kLpbGiDTn3bGwquRRMDfW2MTocL9vwx6AubfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM02b/jgMbKuvpRKiVgVETJ/0THhijaIyYynoI+On3Jc86Tk/4
	Yvs+NMFkQkOCLBh8247VMEIJtKscJJEJLd+0fZg9BNplPFQuzHF6Ri6H+XGWcdkIpz+DqkFZVhw
	X8GwEUyjH5DRsAPZSwmLIl2dfIkmPyp8L2uqQ8AaxqLmHKwCNH2RNR2ZP3277Zblw0A==
X-Gm-Gg: ASbGncsE2EZbaw9Ikiz73lrM3CTjq9lUHP79gJn96X96cXmNhCmvlamT0Pn308yMl8X
	LQGQGymEJmWoMq658p2LIPLzmVtnJvvQDzYEOVKG4wqfqj0TrJxL2ZDIlmv8bbmpDfQqiRobhVL
	xaXgg2y0Te+5jOP6Zi+iGFoE2s0k6xl9RHWwd38Tw2KAuM2lH7M40XdB/JhRzrEpvtwWcUAbotw
	+z7hTkKFFbMMEcYUypEhewuRC5fh/EUZfQzasnhVKSbu+rSKYHGuBN842uOQmZHvpBlvYVOmrBE
	pxhS4YMnAlKSEcOLeoxnAYBKlTru30w9gqqm0kmhifg8NDHt2CHZEZGfGdYi1EQ36aDnm6N1AUs
	TriOB
X-Received: by 2002:a05:600c:8717:b0:442:dc6f:7a21 with SMTP id 5b1f17b1804b1-454db7e87c2mr38423775e9.3.1752149619712;
        Thu, 10 Jul 2025 05:13:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFp+CE4OHvWqIhCgoGjMUd0oVm2/xeAAOIhuzXqN72Z/OQpis058DRemX4zgz1jKZQSrDiQmg==
X-Received: by 2002:a05:600c:8717:b0:442:dc6f:7a21 with SMTP id 5b1f17b1804b1-454db7e87c2mr38423525e9.3.1752149619307;
        Thu, 10 Jul 2025 05:13:39 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd439051sm18518215e9.8.2025.07.10.05.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 05:13:38 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Maxime Ripard <mripard@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>
Cc: Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH 2/3] drm/tests: edid: Update CTA-861 HDMI Vendor
 Specific Data Block
In-Reply-To: <20250625-drm-update-edid-v1-2-2d963743ab9e@kernel.org>
References: <20250625-drm-update-edid-v1-0-2d963743ab9e@kernel.org>
 <20250625-drm-update-edid-v1-2-2d963743ab9e@kernel.org>
Date: Thu, 10 Jul 2025 14:13:37 +0200
Message-ID: <87bjpsfdla.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Maxime Ripard <mripard@kernel.org> writes:

> For some reason, the HDMI VSDBs in our kunit EDIDs had a length longer
> than expected.
>
> While this was harmless, we should get rid of it to make it somewhat
> predictable.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat



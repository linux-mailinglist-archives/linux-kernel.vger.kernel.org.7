Return-Path: <linux-kernel+bounces-729864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FD1B03C99
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 12:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D81F117F4B7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 10:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD1E246BC5;
	Mon, 14 Jul 2025 10:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KZdRXfGb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C65246780
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 10:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752490321; cv=none; b=ctVnwDGDOYnr2wl2ylIyLuwoXdyAfUkOsqmfMbqP+G4IBzHhQDbipk4hUdKnjf1gW2VmfCX6Xb3HDz7NPqb/TS94duohKliO2IKSwwe0tlfnhXnj3lzZVRUmmCCZ7qActkUCSLYhUtm8M7QNCiz3lWV82Jrar39PVFM6g29Jnbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752490321; c=relaxed/simple;
	bh=mz3ErO3oymxl2qWBydkHla6KItcpssjehPmduEtYIpY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iYaCWOtCrp0wV27fpuZ9FqeG1OX6+VfxueV2TqVjtLSDsvtrJRZF+2LtqnmvdU11WTeygXInZcfkBTyrHBBnSlotKyU4pIUDWfMM9eTV21WsgbF0lbC/tZ/bGjXI1e++TjGkKffcLRlc27870qpPPaivx8HRy36EqmWsfhw5/G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KZdRXfGb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752490318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S0FqwW/V0t1PIB0be3QVSXkCzzn3WFingY02zmyj4Qk=;
	b=KZdRXfGbZCGXrO4Qu7netANATZsMwxP7xWgN/sbD/jeWBYKml4EJ+efjB+3xNsi+WPLmrf
	3aEFqXAIas/lGF+kUj9sIy0N+mOXOya4yJMvNIuBJm89049zGwkvjKY+RaFyfDbaQslTK7
	0TJHQ7GTl6ZKq2wnnzVsGs0Vv4MVAXk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-sPPRDS7pP5iBc3ChNa4Gfg-1; Mon, 14 Jul 2025 06:51:57 -0400
X-MC-Unique: sPPRDS7pP5iBc3ChNa4Gfg-1
X-Mimecast-MFC-AGG-ID: sPPRDS7pP5iBc3ChNa4Gfg_1752490316
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-456106b7c4aso4813665e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 03:51:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752490316; x=1753095116;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S0FqwW/V0t1PIB0be3QVSXkCzzn3WFingY02zmyj4Qk=;
        b=gtNTJEnCice5TxWYJfa0z2offjJUkzTstf2vrO5sQckdw2s51x5SaQrdzyD4Mp2VKS
         k+pATd9QmjTMfEZ/8zbre/sB5xa5gTc5a+8c5kX7GI0o2SWBcLjt8JREr6MdH5hdtBKR
         zV8jXplFmZhtS/0MzoYloysA+IJzRBRwHy/f1xT0TF2kkFYh9tPBrZrxo1MT0rba1E+2
         7qTAROKy0EFGbzmXYCuWehD1tfYg+J2nBXMRdJFg2lv5igTYopJsaOBmEVxexDBkTPQf
         pA0c+gTgF4OAO11dR/gFo3n++87NlL9GDM3+qmkw+ndWjRGWFTNMNgz+sN+vCZTMIzux
         yLcA==
X-Forwarded-Encrypted: i=1; AJvYcCWuxOWytyVROsFBswzQBo3T6XShHseYN3aCmMuA+QyNS6EurI/9MS1Z5Lc1S5h9hpLtkwEQCtYo64h/t2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCmCxKvvWUGi74DbbJ3zVRTg+Mbjg+af6elFy+dAwFVdTC/sQ9
	19Or5N2yCo4RFfb9nB81m0kTnXD3SS6o8PNVRjOwQNNMz6AyEHzx8xjigYKvv1t0Db3yaXQfuyy
	w2MCjdKD2mgqKSpbDN6uTvh4NefkAXsxayO3vcgTtsAOeTKBL8g3dodWSg01zbCLe7w==
X-Gm-Gg: ASbGncuh0x172HHT3AdXyHtflLROfbzeJRMdQ03orus3SMXpTR2909+Uc3K+gwnVvqc
	o/rWPrk+HREpo0P5b8mrH2KwCqkwOO6BUVraleCIc43QwBSd7X8Iu5U9rWeMuOd3ivo9tzNLlwE
	C4S+PwyDTiyhxLGwlFjhPLhiQw5vAVVHgy5pJ5tL3Ps81BzsdBFcsw8zPDco21DV9jJCUfUmGUk
	SAX8EPxusl33f8WqXzCQNCl/nF5qDcIXWScLdHpgeAJFwiCSYk4Tn+yiaKg4pSl4nhdur2CtZhv
	gL/eKfY+TWQaW0ikaGhQGhmHn8BDHNgSX0KepsiUncB4QcuMNPsj76aKm+gzp8G3UA==
X-Received: by 2002:a5d:5c12:0:b0:3a3:7117:1bba with SMTP id ffacd0b85a97d-3b5f1e9384bmr10844641f8f.24.1752490315707;
        Mon, 14 Jul 2025 03:51:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/u7/5Utoz6pumORdMpPlrDsf0nGvHyJlvTOvktdoCGdjx8k8xCix9akpVNBj3dStS5miLIg==
X-Received: by 2002:a5d:5c12:0:b0:3a3:7117:1bba with SMTP id ffacd0b85a97d-3b5f1e9384bmr10844621f8f.24.1752490315317;
        Mon, 14 Jul 2025 03:51:55 -0700 (PDT)
Received: from localhost ([89.128.88.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8bd1932sm12300479f8f.17.2025.07.14.03.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 03:51:54 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: Re: [PATCH 3/5] drm/st7571-i2c: add support inverted pixel format
In-Reply-To: <20250714-st7571-format-v1-3-a27e5112baff@gmail.com>
References: <20250714-st7571-format-v1-0-a27e5112baff@gmail.com>
 <20250714-st7571-format-v1-3-a27e5112baff@gmail.com>
Date: Mon, 14 Jul 2025 12:51:53 +0200
Message-ID: <87ldorkpti.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Marcus Folkesson <marcus.folkesson@gmail.com> writes:

> Depending on which display that is connected to the controller, an
> "1" means either a black or a white pixel.
>
> The supported formats (R1/R2/XRGB8888) expects the pixels
> to map against (4bit):
>     00 => Black
>     01 => Dark Gray
>     10 => Light Gray
>     11 => White
>
> If this is not what the display map against, make it possible to invert
> the pixels.
>
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat



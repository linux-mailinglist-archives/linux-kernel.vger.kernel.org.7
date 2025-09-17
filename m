Return-Path: <linux-kernel+bounces-820348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B44BB7C639
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72CDA188F12F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 09:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B827F2DBF5B;
	Wed, 17 Sep 2025 09:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hXGP0Ehn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578D121CA0E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 09:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758101534; cv=none; b=db6xL5BzLWfG1m3AH7HKzrscKzBCNsqyE8amyx8x64pF66oXsAyVw5Ot0X1oc/D3P6drQ4gZp617IHx/NNqA+6ITDHUVVzU2Bg1p9Z52WGcNf1N6Df92aW7crsscXYcSPL0WwpAftRX71kG9wfWpK7dRzNIqsb6nWQ8ZDgmXXmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758101534; c=relaxed/simple;
	bh=K1mJ9ZHlEFrl/D/MMEsoSQ5VudhAMyqb/lT08E4QUqI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q6VL42zVCepnXpYy7q4szmNNLjoaI58DDg0dbO+3EWhzqfXrLttojr463400DldIgKsTP+hyBPHTvAGyE2Dx2/jD6QgV2WYnDYNHXf0y/K/+eIoRE4i2oDLSco3eRNLUXxiNkWuR5oDz9eVTiRLvDooY1uSC8NzBm+/JHdYcKdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hXGP0Ehn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758101531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qMU7f5iBz5K45j+BD1XBiW5zCA3C9jGtl56Dq/WVh4Q=;
	b=hXGP0EhnkTuYiR+EOSAozNn34QQJZQPn6w9PsWR+BzZk+bPpCzKvWbGJY2qz5tIJ8nZmR9
	spZNksp7cW3uy6bmD+b4q0r6/Z5KBxcHp6MXlRCG44LF2nF3x1FodF9ywfSIvTJvPrj2jI
	cKYEBje6P7Trt+yl10S/UyJ4ONfcHeE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-RuMbO_z_OBagBK-6ew5E2A-1; Wed, 17 Sep 2025 05:32:10 -0400
X-MC-Unique: RuMbO_z_OBagBK-6ew5E2A-1
X-Mimecast-MFC-AGG-ID: RuMbO_z_OBagBK-6ew5E2A_1758101529
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ecdf7b5c46so198165f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 02:32:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758101529; x=1758706329;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qMU7f5iBz5K45j+BD1XBiW5zCA3C9jGtl56Dq/WVh4Q=;
        b=aDXyOTHSsyRG7pM3AKrwe9KG1kVFLXMkDyt43A/tJ4SdXhBNiVlDtJ70qaIgNx0/ir
         wXSY2mFex9onzTPKn94fF1d4tM7Pw6bbkm495kTLt5gZ3NtI1KHJHZMI4NAY8F3/qoit
         hgt4mKHxTbZjIulO9LhIoSWu0XVhOQkZTbVfbdpciS8QyyXAiQO7ZZGdhZMOzok8B3tK
         Bba5xdEne2mdptS1L4C/wCKR0hwV6WwQYjXCHVYfEpmAxPQSXV94buNaKcBLE1YjI4Bn
         lh7ttLXPvPLUU0qsKIGB0ljWvA/l5RGLfXOxNjncvGC1D9Ed7ObkbC4+6Q4wgsJMcJMI
         VIFg==
X-Forwarded-Encrypted: i=1; AJvYcCVz++ITxiI0cSFNhsqvQetI89yog7TNaQnpC2c4PmND0aSiehZKa4pj1QIPbdu5iipZB7RFBruc1kNrBVE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywehlno/cwfgiokRQ0TN+fx52JWGzMKrfLzUpJMFRbqrwvlQq5S
	TkrS/yb1JJibB0rQPHlU0xgY41rI5WhNPaDJo28I2jozMHd5JoEddn9coOwBdT3Wb5owbh/QSzW
	HIVttt3LrXKrAYGQs0vsWQogEuWH2wYtRJhMRSmYjpnbkgMcMTHNui+HM88xAksiNZw==
X-Gm-Gg: ASbGncsVDGG4gBDUnJKC2hhrn3T5eExrRZCxd1QTwB0MyZ4zmCUEvM7IO17lQftOEnA
	MzcsVOKsboL9iAAlPYdGCsFo+9xTzj7mco7fiREwH5zXBLkW0C6PT92XW8b2E7N+/TUyQLJtQkv
	zm5Yses8wd0UGr76VST1laJusiAycDTK9hmgK3PNDQ0+/LAcF+IIwKqbFFiMnIlAXnRV/EcIPD9
	+gvQ1rbEUQ6PC1Qplas1EAHLJQmDzqBFOzIFU+lUVKSg+0YU24dCn7nzAIaWWT5pox2pvCyPerf
	PSLXf2PDuVPOHTUvAUdSGJ1EXGBUXRalwF0lPs08sw5Zx+sISEbUX8CPWU3Oazke/MdcorwB2aa
	I0a7de5iMW41YWbm3e5VBfA==
X-Received: by 2002:a05:6000:2586:b0:3e5:50:e070 with SMTP id ffacd0b85a97d-3ecdfa1e728mr1358866f8f.50.1758101528831;
        Wed, 17 Sep 2025 02:32:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEj8eN4uCa/vX/w5u/vFN0kesAWhlaiYJrlSPVnSoQWxMdPV0K93YZt9GqXMbVeVga460fdBw==
X-Received: by 2002:a05:6000:2586:b0:3e5:50:e070 with SMTP id ffacd0b85a97d-3ecdfa1e728mr1358725f8f.50.1758101526684;
        Wed, 17 Sep 2025 02:32:06 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e911188fb9sm15728642f8f.28.2025.09.17.02.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 02:32:06 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Marcus
 Folkesson <marcus.folkesson@gmail.com>
Subject: Re: [PATCH] drm/sitronix/st7571-i2c: reset position before clearing
 display
In-Reply-To: <20250913-st7571-reset-v1-1-ae5f58acdf8d@gmail.com>
References: <20250913-st7571-reset-v1-1-ae5f58acdf8d@gmail.com>
Date: Wed, 17 Sep 2025 11:32:05 +0200
Message-ID: <87o6r9o25m.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Marcus Folkesson <marcus.folkesson@gmail.com> writes:

> We cannot know where the write pointer is, always reset position to
> (0,0) before clearing display.
>
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Marcus, do you already have commit rights in drm-misc or do you want me to
apply this patch ?

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat



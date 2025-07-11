Return-Path: <linux-kernel+bounces-728287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67509B025F1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 22:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FBC71CA72B7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8266F221FAA;
	Fri, 11 Jul 2025 20:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CjuY+HYU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349D819995E
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 20:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752267117; cv=none; b=eYNpNp1hxTwwebDTdmqsndDs+cEfeVWjLE7Bb0wQyD4b/aLt29uAl7YZjG81wn15GFQmQv09zymEOU2wCF6mrFck5z8Fwy1vMiCV3drzdXcjp4sPk02plBRCqDIohq2ZS4Vr0BiboWnL22LykT333h6X3TprtTr0GRcni62+h18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752267117; c=relaxed/simple;
	bh=Saf4xIcJFxD5zIN9jwcZezHkii6vdPgZpKxM/QeLbqo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tZcSVND3+2P6ZLF+O6+oRdjCDb6a7TvGP5hV5A/FXA5bcGJCOyx2doYKsBy1yoG5/JrHnk0F9qxjRIaXPjhGpHPhVDeKOiCozWoVBVfhZO8r+mnf2njPHbw5I5ZVzVb3MTAmQ7B/Ix0Wu99ZfjQSyclst/v3KxJsLnZ9v8jrQbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CjuY+HYU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752267115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=09BgZ/tf0+4Ztcqaiae5+oHbGx51XEb23f9LmBSVfi0=;
	b=CjuY+HYU3ValAcrCgbOnwAOnzYh0cGx4BhNAb9VfbO4FkVWDPwDb2iU0toerecmA47MW+8
	qlEerAIqwHylaeq9VIoVyVlFajOFLR+xk6jN3Lhuw6lSvymtsNXbfW21ptWWvPyUh/MsOU
	+93MKgt/m4cGN6B2rY8pbmqt+RVJZZM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-FxCFvsmzOQOVoXMtVtZX7w-1; Fri, 11 Jul 2025 16:51:53 -0400
X-MC-Unique: FxCFvsmzOQOVoXMtVtZX7w-1
X-Mimecast-MFC-AGG-ID: FxCFvsmzOQOVoXMtVtZX7w_1752267112
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-455eda09c57so4984515e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 13:51:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752267112; x=1752871912;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=09BgZ/tf0+4Ztcqaiae5+oHbGx51XEb23f9LmBSVfi0=;
        b=TATw30jTRadiQePMVUaRgw6AjqytBbAvtnXKjolvL/Syiy7GHaCuEvWTbIKfbGsuQx
         BOmWLmdW7duX6OfwalyTZy7bM+fOdlQcyA2SzGxvTI2uvtmV4+gKJ+HMNJ7QbvzlpkhB
         B4cXF0cIVMNnjvoL4nsL2lsKYHbzC0oDksGVzKrB2Zu4J5Gft62CJWeoXXhYqp9pciy7
         cqQnCGyVAC18+XpIAOSyHbpMbr/Akg71WYCcO43/4FUf2Roa/spfoA/6aTqJCb6cY+8e
         lBsaaanVD7mphxXop1GYwdszxMxjNqkL6dfN7f2DmrnXsPfinCvJsD9aFXS90G96T48b
         lPPw==
X-Gm-Message-State: AOJu0YwrG0duhpEyvneO65Ok6BIqiLXw8XTjGKabwMxTziZ7xP4GPyhg
	35whpEEaSPNf8WU73xVcT6A7xgm8gz8ZlX0oU3bRRU9lWS/r4q7Nmp8sTon7nCmKee2HSVaTf2v
	V9t6h6RDm4kR45NThrwh3Z2fPzZzbr6xt+NlE+hBQ4qJQ0My/5Kz3s9uZaO+bg8YtVw==
X-Gm-Gg: ASbGnct++4SPoWgOiYBodn60WPWNODH03+BxYYhhOF/Z9bmODp1bTgVLyatmg9mqbcc
	WbUng5vdQeJL53zms1xbOKiAF1wUcLq+uaFeBZDwljWItjS9Qism3IhWf9ThyiqnB87c6ZAgMNR
	TcmFeWKyczY5ElKYX41ZlSJQA2wxY3UZPyArvCBVZH3zYWyuJSlXWC9GFqSdVd+2i8rDzTDblC4
	rTS9gN8ffPoo8pH37rJkGktyJIRwjBBZLtMCTJaf4dGRTuypC2oBVF16uiwurUNC5xaGLQ3YWL1
	/eAm9aXxHr0VjYaKy2e/UAW5rVZvvvPykYUSQK20bTF5QU2KjFt7ZiVYJcRnoL6MfX6uvTv97y1
	GXG3LYuUSzqxsGwInL4qSnA==
X-Received: by 2002:a05:6000:490e:b0:3b4:9dfa:b7 with SMTP id ffacd0b85a97d-3b5f2dd49c9mr4147970f8f.25.1752267112381;
        Fri, 11 Jul 2025 13:51:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPWyt3Nc6AJsCPo4LiVZwfUh7ukOGdb7Dt8vCOTLbMdccbz3kKuzcOoIAqeml5IcfiYWjKQg==
X-Received: by 2002:a05:6000:490e:b0:3b4:9dfa:b7 with SMTP id ffacd0b85a97d-3b5f2dd49c9mr4147942f8f.25.1752267111943;
        Fri, 11 Jul 2025 13:51:51 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d4b5sm5519712f8f.53.2025.07.11.13.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 13:51:51 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: linux-kernel@vger.kernel.org, ipedrosa@redhat.com, Conor Dooley
 <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Rob Herring <robh@kernel.org>, Simona Vetter <simona@ffwll.ch>, Thomas
 Zimmermann <tzimmermann@suse.de>, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 0/3] drm/sitronix/st7571-i2c: Add support for the ST7567
 Controller
In-Reply-To: <aHFy125scr-g6zn6@gmail.com>
References: <20250710102453.101078-1-javierm@redhat.com>
 <aHFy125scr-g6zn6@gmail.com>
Date: Fri, 11 Jul 2025 22:51:49 +0200
Message-ID: <8734b2e9i2.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Marcus Folkesson <marcus.folkesson@gmail.com> writes:

Hello Marcus,

> Hello Javier,
>
>
> On Thu, Jul 10, 2025 at 12:24:32PM +0200, Javier Martinez Canillas wrote:
>> This patch-series adds support for the Sitronix ST7567 Controller, which is is a
>> monochrome Dot Matrix LCD Controller that has SPI, I2C and parallel interfaces.
>> 
>> The st7571-i2c driver only has support for I2C so displays using other transport
>> interfaces are currently not supported.
>> 
>> The DRM_FORMAT_R1 pixel format and data commands are the same than what is used
>> by the ST7571 controller, so only is needed a different callback that implements
>> the expected initialization sequence for the ST7567 chip.
>> 
>> Patch #1 adds a Device Tree binding schema for the ST7567 Controller.
>> 
>> Patch #2 makes the "reset-gpios" property in the driver to be optional since that
>> isn't needed for the ST7567.
>> 
>> Patch #3 finally extends the st7571-i2c driver to also support the ST7567 device.
>> 
>> 
>> Javier Martinez Canillas (3):
>>   dt-bindings: display: Add Sitronix ST7567 LCD Controller
>>   drm/sitronix/st7571-i2c: Make the reset GPIO to be optional
>>   drm/sitronix/st7571-i2c: Add support for the ST7567 Controller
>
> For all patches in this series:
>
> Reviewed-by: Marcus Folkesson <marcus.folkesson@gmail.com>

Thanks! I'll merge this patch series next week then, since I also got an
ack from a DT maintainer.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat



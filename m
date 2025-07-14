Return-Path: <linux-kernel+bounces-729862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94001B03CA0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 12:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76FDF1A63292
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 10:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0391C245031;
	Mon, 14 Jul 2025 10:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HAlaw2CD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D699622836C
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 10:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752490281; cv=none; b=uSzBetvbgpU59BuzduuvUV4BQ9ImMuASrVSuiqMCBssDBerXRwYN1w/tO1NCzejys62kQsBD89Hb90eY9qXNDvvUnpnk53fI/+RBjBS8Tso68hB3H3eIapYGk7Fot1ZXRkB4ugnvrEsOEXdSEzQURHcto0dX1C907Z7MG99m7No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752490281; c=relaxed/simple;
	bh=UD/v6bmTOQxgZqVOMI1DljGLG+rKhwNPk+nRCKGoRGw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pxRl1D3qEhOEjOBe6YEbMm2AhD+Es8d2DQ4wlb4hJfOzsDXmlbsPt8zcCyfk++/G28HJZS+/RdmQJVV3bWlz5snet97AE1nopi1w67qZxmtR1/dEq93/EqEp6uXUiM+CdqDyRndV6MceymUlPrTvNpYSYGoVr3UovNC0h7DIYGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HAlaw2CD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752490277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KMqUL6cwfYJFRkeghLWqOuGBrAb7IcRck5tD36Dsorc=;
	b=HAlaw2CDR1xtaAn+naWDeKX06BJ9lW+xR1LwxZq+ta3hpUvHBzYzAVPzV200eW7QXShykA
	+AywavafqgzMH6YmwT9pdtC6SwJpSuH9yuAnECi67hahOt//MjVEyxhx4RFeLsX6hHOYzl
	+ZES7L9+p/ENNoV0KDbMQ3LpCl55U00=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-lS2FkJjFOuSenyfpxaUMPQ-1; Mon, 14 Jul 2025 06:51:16 -0400
X-MC-Unique: lS2FkJjFOuSenyfpxaUMPQ-1
X-Mimecast-MFC-AGG-ID: lS2FkJjFOuSenyfpxaUMPQ_1752490275
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a579058758so1661838f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 03:51:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752490275; x=1753095075;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KMqUL6cwfYJFRkeghLWqOuGBrAb7IcRck5tD36Dsorc=;
        b=fZaTX+FlXcI0Y5DyLCU5S8/JTpFGlJFMc4wWPCkAihmv1/xpgFyxy4ViiDjHfOB9vd
         ffm0cQLrxv5mMp8fhz/vY0IAtvKuBinOhkFZKzYOgK9OqX8lFj7kn7ZEUYa+0pxjLiep
         3eGgud8aRwUrjsp1OozcCefr5C9R1vhc13e1PisxQgg7691TzjWrZdF4oyFuxujLhLwm
         7QlsXaaAyOm370J1w5CHM8pU/U7scZmWRHAB/5S+Q8Av417mmBi3QCD/O87bjJDieW1U
         UPgEKKctup3zSvZsMko88UhbKd+e55L4eAZVtUZPBkkiZsCxAgMBisu5ynhgA3iaNfPZ
         fpzg==
X-Forwarded-Encrypted: i=1; AJvYcCUfl2lm8ocnm4fk0OS2b+EZcvkP4jkETA27XHkTEMcpgYben1t7gElEzgQFwyPLNAwHTnPj5xkuvEATHdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyodyqNqNQCV9QSjnnBJ5uFxHiTJ7NBOuArEO9Vb7+esmcPXUbF
	eauQpOGdaaLZ6IQtKFmncwIVs9GkddMM5gg7MnqHBe7X+u36O9W5Z/Ezw3Cp0e8y1E9Tx8q2wJT
	6PCnYTQUWxsqe7iWLQfmYvm8pnCWbTqpLV0jItd5ltJUTPHpBrfWS8lS9InOtTdpVx7MQEkOziA
	==
X-Gm-Gg: ASbGncuMDEe69c7ReL33f8IhwlkrdGKalNmM3qgDwmY4j7zkdQHVOPE0SG9UgaRvZZQ
	l3Uf6eCdheCzUe1WN2hRwhPhO94b4B4UjvC7qap/MtGNqq3OBrBwbmeTJHnHyplmdeR0Xs+aCfz
	HLXACxWE8fgH00nHfWsLEUs9BX1I1yiKQsSjKB/5zblJ0BVUCvsjR1UmBdiKQu26MeOqV4dK3R4
	E8eBA/AtOSpPt9KO5uMGrA7Zkt0gWxs0891328QPZ0SgGD6L/Rd/RXhwlvEYvCpteRHoYVHFqgj
	nguv9nFFTWsFrBdkhdyFFaMehwo5xn0nALL47j6muQcvTx5BINVMvN4H0Vcd9IW4+g==
X-Received: by 2002:a5d:5c02:0:b0:3a5:2182:bce2 with SMTP id ffacd0b85a97d-3b5f188e909mr12274013f8f.17.1752490274631;
        Mon, 14 Jul 2025 03:51:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFr2MLp2GtBbRb7dAnQ3PHoYy+krsW1/SDOnEpDEWml/U0H6r4RESt/RNwqNrkILiCRq/Q6Q==
X-Received: by 2002:a5d:5c02:0:b0:3a5:2182:bce2 with SMTP id ffacd0b85a97d-3b5f188e909mr12273989f8f.17.1752490274183;
        Mon, 14 Jul 2025 03:51:14 -0700 (PDT)
Received: from localhost ([89.128.88.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd537c6fsm130546685e9.21.2025.07.14.03.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 03:51:13 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: Re: [PATCH 2/5] dt-bindings: display: sitronix,st7571: add optional
 inverted property
In-Reply-To: <20250714-st7571-format-v1-2-a27e5112baff@gmail.com>
References: <20250714-st7571-format-v1-0-a27e5112baff@gmail.com>
 <20250714-st7571-format-v1-2-a27e5112baff@gmail.com>
Date: Mon, 14 Jul 2025 12:51:12 +0200
Message-ID: <87o6tnkpun.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Marcus Folkesson <marcus.folkesson@gmail.com> writes:

> Depending on which display that is connected to the controller, an "1"
> means either a black or a white pixel.
>
> The supported formats (R1/R2/XRGB8888) expects the pixels
> to map against (4bit):
> 00 => Black
> 01 => Dark Gray
> 10 => Light Gray
> 11 => White
>
> If this is not what the display map against, the controller has support
> to invert these values.
>
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---

Could you please rebase on top of my series that adds the ST7567? Because
I see that this controller also have a "Inverse Display" command, so this
property will also apply.

Or do you prefer for this to land before and then I could post a v3 on top?

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat



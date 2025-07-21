Return-Path: <linux-kernel+bounces-739165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB46B0C2AB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 119883A90DC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 11:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8997294A0A;
	Mon, 21 Jul 2025 11:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fdHzzUM8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9876D28D8CD
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 11:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753096767; cv=none; b=XW9UH6+ylx8HCZxQiIUGl8j5WywEjvJDZ+8vsG+fH53ESAIoF8wTGWMUTdEJQo/YFXTVv7jFK7ay3oKGviP60gOf6rPcZeNqgVUZ+Ztc0fsjhAYfj0pBug9U9DvPtAJSqSHaw5ZFM9RpJHIcGhv0L2VgtkSwU0sMrJmkmzUftPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753096767; c=relaxed/simple;
	bh=/V0Z20poRIML5E1psiie1w9FO1viJObhv0FElnARQiI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GnaZNFiB7ByFiFdC7ZY/qVUeqbacM4Zz4LcUsIeLlJgqO4b7MuqKBQX/eTZ3DTjrLzD6Hol2VPu7KR2HcIMisSa/U1ByoHGD5yhSI0dmbicdntj9LwFvri7pKRYf59w1rppAIAbXsAXZG6CMb39K2SfsI9SraW+n6n+9lnjzoIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fdHzzUM8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753096764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TFoz2WZRMZK4qulVAmwYVCtTJ8qaORO4AKebBTnJutI=;
	b=fdHzzUM8Ew3QfvZfnR7qpjMTKwWvC3V01YIbZIOsBFuAILBsFrSymAjhIIpzpivzy3O1V7
	ZGo0ESIommhMq0u6pfMgMFKUyVl4WldsnSnx0YQJjyQcVFsDe1KVW9CkKB8ENQBlnoOXXP
	X7EX+XxPfKCtnlJ7kJaK8N6lyQWm/UA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-4q_e72U4NlavZOF6dR-VMQ-1; Mon, 21 Jul 2025 07:19:23 -0400
X-MC-Unique: 4q_e72U4NlavZOF6dR-VMQ-1
X-Mimecast-MFC-AGG-ID: 4q_e72U4NlavZOF6dR-VMQ_1753096762
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4f7f1b932so2880721f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 04:19:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753096762; x=1753701562;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TFoz2WZRMZK4qulVAmwYVCtTJ8qaORO4AKebBTnJutI=;
        b=WZWvSO+iZJR0kM7Qw6JudyKxStDFMz4lrFwz5y0KQsosGEQHD6ewXfivCdRJv6wMN9
         Pwm8k4gbOAJLLLWE1E8c3ibsy6Pgi7uMc+BNCia8Ep8d6PlUgitzMhdqkNdB8fPt3YWz
         2PK3eHVhwLepSkvW7Vvdab9cLjVzlGBRZgKv5hH0xI3mxWQPPCu0bf0/KzREse/j5TQV
         JNlkJlbG7Djf7e7N3MHnqjj+EokU3KE1P/Ch2ZTzyu6yMgzw5X4kiq4XAjnNYwuTN7Br
         14idhMqaxUtbTlpPso9zIMRVTN5XXFBFLA3FfHSBAgB/0CHgZ9M50fmxTVaX1Kb2DDxO
         hPZg==
X-Forwarded-Encrypted: i=1; AJvYcCXYNs1Ripo+AMnrssCD0dX7MYT2Lz+TwgW1gm6OwxgkaRMRTQXhdqj22u/0jggspGi16wvY6023KVpo+90=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKIxbiNPH9YqahYtvpUAMe5l7ITdyfUPglhVHx6nf0g1n+YxP9
	guHJEsZtHEnRRg2+5ILW1HgfadboGqLbbYJWZIIj8QY9hkSCQjXjv3H5ydzQWNIWHJ/Ezm4FSmp
	Zt5X8Op7eb4UMBWNjhrcoFxL9lqmzjL14R0osXpBi4R9TcMDWvkapRRNlChQusdMt3A==
X-Gm-Gg: ASbGncus4d3v6QFeKK2x1NRlRYkzrykor1uq0uXJjPmRWtra+ff3KVpasZ67tWdHAZ4
	JAP0IMSglzkeoF5El5uW6uXmN88naoFy9wH222SY+ykcd4MsFbalwHAS8B32zlH3t1uTVm6mcve
	uljk6XNr4uQKQ9rJHuBgLi2Tcty2dDOvnVUnbKgsVZPtlJFEbDM7VTzITBPnuQ3hoX8WiF4XswB
	gQfl6emiu+7F3r+vm41T1+Y/8zKgYgASnJ2gVbLSAgbEpt82Ei2tuFarbjLYbUv2FvnEDLNMQ1k
	GTF7rNYvymGVrZWfKgrTGqNNy11wW54HzoLgQFkoi/H+O8ZvViTfbNe4+F6P7wf3wQ==
X-Received: by 2002:a05:6000:2902:b0:3a4:f038:af74 with SMTP id ffacd0b85a97d-3b60e518418mr15912921f8f.51.1753096761753;
        Mon, 21 Jul 2025 04:19:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBgZ8j7cvCchuIks11flM8QmUtWUgbRezl2Kmbq73XrYO5/Elgn5PE0sAseXfZtCEO2HQMwQ==
X-Received: by 2002:a05:6000:2902:b0:3a4:f038:af74 with SMTP id ffacd0b85a97d-3b60e518418mr15912898f8f.51.1753096761314;
        Mon, 21 Jul 2025 04:19:21 -0700 (PDT)
Received: from localhost ([89.128.88.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca2bf4bsm10047278f8f.31.2025.07.21.04.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 04:19:20 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: Re: [PATCH v2 3/6] dt-bindings: display: sitronix,st7567: add
 optional inverted property
In-Reply-To: <20250721-st7571-format-v2-3-159f4134098c@gmail.com>
References: <20250721-st7571-format-v2-0-159f4134098c@gmail.com>
 <20250721-st7571-format-v2-3-159f4134098c@gmail.com>
Date: Mon, 21 Jul 2025 13:19:19 +0200
Message-ID: <871pq9aj0o.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Marcus Folkesson <marcus.folkesson@gmail.com> writes:

Hello Marcus,

> Depending on which display that is connected to the controller, an "1"
> means either a black or a white pixel.
>
> The supported format (R1) expects the pixels to map against:
>     0 => Black
>     1 => White
>
> If this is not what the display map against, the controller has support
> to invert these values.
>
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat



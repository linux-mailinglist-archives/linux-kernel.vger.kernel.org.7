Return-Path: <linux-kernel+bounces-734097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A8BB07D08
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 20:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C67BF1C284AE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 18:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE47729ACD3;
	Wed, 16 Jul 2025 18:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e58dYHo7"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934C3188A3A;
	Wed, 16 Jul 2025 18:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752691222; cv=none; b=HMDgcLGxxgRj6sd4ou1fHI4pEwlfquiWO43t01Ap0oTCaIBM9sP3g7V1EO5g8x7y95LIzlqP1d7ibHAtXW/GY0CLT5ByX9M+qbMPyFhqrJslZ0IZcL9T8CWDrrd9bYIPe+l5DihIJm4t9oROMNKCag9ZUFMb/7OLsYv3sJGFc0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752691222; c=relaxed/simple;
	bh=J7+UlN+KHQiDz/fIRY+lD/Q8RAf0wMAeP7wOtMKnlVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J4RqvHbR5z7FDXi2HwbZn2AAPH9yLDH/MrtyLGkElG9bhP6EmpIOIsCvT2ve9kS9GtbhsHvrqHLJuqHnPtHSybUD9abX52f1H/gX5Bd82zoVkkspT6mP4xSpTbA1m02DjjWN5FYv/J3nQYO2Z3akDcZt01gjz6uwD3cGyjKD35s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e58dYHo7; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45610582d07so1196515e9.0;
        Wed, 16 Jul 2025 11:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752691218; x=1753296018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K86TDMdZ2XqOtIz4v5tuWFWQLBw7H1poOoP8hrJjhno=;
        b=e58dYHo7MI5TBuk9TuhI/Xdxb3DMZX7NM7cDOJdnogQaCnLnm/4lMF4DGVbzP6oHpV
         gC5r8sVoR57fc5OsG9wUxS/X61BhkGMus/g7Q1hnOg3S2aunVJBQ4LtW+M5zws1VrfDe
         L587x0OdqpoACTWLpqvcs+T2kF9vtGMGX9FSF93U8Py1J0GTkmyNJlJiz8N8xb/Q5UYF
         LYt0fvcBAHDWnoW3f/tVCPc6TyxGQhGM9LYugQQNEKxO+uYw+KjUaRK1h0iMWrg8HZ3G
         sIMuK6vZVjotK7vZgec9BdHNBtxJpwZFQFyinJ40QcOxFeTnVJwP2RUNiFa5+l3gzdzy
         yIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752691218; x=1753296018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K86TDMdZ2XqOtIz4v5tuWFWQLBw7H1poOoP8hrJjhno=;
        b=lF39tmEIU7OJyO5hlSQqOHKE3TLPaOp8Xe38DiVK4dLbHzL5tO87MpT9rGD4neIwMT
         XS71LCL32Lt3a8ycukXufIsJHkhuSryAy+mX5Q/rPVzWB6gWFbnP7dGLgywhgH3ljC68
         O1H2l7z8KepqKYtGvh4i0GJy+m9h/UOhmpsX6qjSikJB4SVIApz6om4Isk8JMxzjvw4R
         3Q7o3wiNVf1Y6tKJBsWV9Alg2fhpg1t1p7aoZJhlyZeY6WnKiJmt/XSCNTw381oq/fGT
         enyo3pECqRYgbrMXM+3OgkxLC27miAnV758kaFk6kcOcYYRrXaB9dMAkqa4KbSeMWPNi
         qLPA==
X-Forwarded-Encrypted: i=1; AJvYcCU8FkhBdFdeFhhSq34/ssoZC0DE32GvmB1SXbzZEvygzRUFAv99P9Db6PyKg7W/IN4T4jgzYWFITfZi@vger.kernel.org, AJvYcCX1/U6RH4oZl4XQeOBSLRNnAs2iEcraAh2D5pC8rl9J65/UB6EElj3otI2jA4n78fT54PEpYT+5gwRmkcJB@vger.kernel.org
X-Gm-Message-State: AOJu0YzGA4gqjP8ThGdJ/LwmiNyCVWyN2pwKiB4NMHPai/Ix1PhOqg0u
	2F5DGxRqUtEJHNceVWLCaaVxzhCdBaSQ87nun4wCBTYy1pmocGzCEaiG
X-Gm-Gg: ASbGncsrg8FZjAJZrOMM2T8RXszDv4Xhnc8ZgrLw61SbjoVR8IxeEMZJMl3o6+UBPTl
	yzFcCVDlU1FRZmALOX01m3/nFPKUxsabcW2a8EWwrV4AtGkyI9dXy+O5PcyYC+w9BUOLvrSzNyt
	PcldDydTralwXvmUuVI+c05uffe5Xe5BogGtBqv9g69CidYYjPzkTUb563Dx0L6LHvwb/hg9qS4
	KyOxL5ksKcgjKeVObxqyxzqTw2iEip3P9LidmSeFVAIVcD/gp7CoPMOrwaUp1JgVJssQkPq5lBZ
	qUFb/hbEJpGZgfaLkFSeX/nyKov0VIlVKdu2schKb4kbHWejzUPM/DiIMQhvFXoi6rN16hnhS6d
	hlzBeN9LQPu0E1/94jZBw
X-Google-Smtp-Source: AGHT+IHNsjoQGm3d1JzJv5/OXynZmI25GvOeUFJa5XcXwQ4NdHl8g0F2hw+YCKkoD7Bk/svjmFV2qA==
X-Received: by 2002:a05:6000:25f6:b0:3a3:63d3:369a with SMTP id ffacd0b85a97d-3b613e77736mr151213f8f.25.1752691217603;
        Wed, 16 Jul 2025 11:40:17 -0700 (PDT)
Received: from masalkhi.. ([61.8.129.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e8ab642sm28079795e9.36.2025.07.16.11.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 11:40:17 -0700 (PDT)
From: Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
To: gregkh@linuxfoundation.org
Cc: abd.masalkhi@gmail.com,
	arnd@arndb.de,
	christophe.jaillet@wanadoo.fr,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	luoyifan@cmss.chinamobile.com,
	robh@kernel.org
Subject: Re: [PATCH v6 2/3] eeprom: add driver for ST M24LR series RFID/NFC EEPROM chips
Date: Wed, 16 Jul 2025 14:21:27 +0000
Message-ID: <20250716142127.1664-1-abd.masalkhi@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025071651-pushcart-scapegoat-6155@gregkh>
References: <2025071651-pushcart-scapegoat-6155@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Jul 16, 2025 at 13:53 +0200, Greg KH wrote:
> On Sun, Jul 06, 2025 at 10:53:10AM +0000, Abd-Alrhman Masalkhi wrote:
>> +/**
>> + * m24lr_parse_le_value - Parse hex string and convert to little-endian binary
>> + * @buf:	Input string buffer (hex format)
>> + * @reg_size:	Size of the register in bytes (must be 1, 2, 4, or 8)
>> + * @output:	Output buffer to store the value in little-endian format
>> + *
>> + * Converts a hexadecimal string to a numeric value of the given register size
>> + * and writes it in little-endian byte order into the provided buffer.
>> + *
>> + * Return: 0 on success, or negative error code on failure
>> + */
>> +static __maybe_unused int m24lr_parse_le_value(const char *buf, u32 reg_size,
>> +					       u8 *output)
>
> Your __maybe_unused marker here hid the fact that it is NOT used
> anywhere in this driver :(
>
> Please remove this function as it's not needed.
>
> thanks,
>
> greg k-h

Hello Greg,

Thank you for the review!

It is done.

-- 
Best Regards,
Abd-Alrhman


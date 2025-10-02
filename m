Return-Path: <linux-kernel+bounces-840118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC4EBB3944
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 12:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D35BC166A69
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 10:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295BB3093BD;
	Thu,  2 Oct 2025 10:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="UJQxz+/Y"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3084306486
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 10:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759400148; cv=none; b=S2RYgTkCuWHpiiQO8/F0xco0mlef/+POfxo1VgMNQblqvLKADbhyiHJ9oFUZNlv2IupPBhz4mGHUhSVbPqNdNXDWJQJRnyS86f/cpd4yDFsRUUYVqYDANUfVSi3Llisg71yTD8oMrFyaGs+oY5afSNErFyJjrIZ9ALN8T/xtzqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759400148; c=relaxed/simple;
	bh=Czqxeo15fjZo1C4s++w8GwAplorv0FEgEEDoqJ3EFac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MLR3caPDNfNS9/mrlt4WqNjQwss8gFZ3tt1bGjYBiECxmbZr9QMsGOdhmJR9+NVvDXTCTOyhiktJ8EUuy7b0WuTjELTUnUJ7GahMmgLXZwIHiEKXB06+flg9HDHUSO79MBFoZoHnylpCGaaUkLMLuoxnGwzZaolBce8agXNMpIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=UJQxz+/Y; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-afcb78ead12so172587366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 03:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1759400145; x=1760004945; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MpOCePemL6vEYpCvPcTB5T61Ggf93+sTv7+KCD/4Us0=;
        b=UJQxz+/YsmpwUudE4NGVXFNmVMb+WRqECfLJRi1MEXdsTteqHFONywaj1DpRlSrOf3
         n6K+YAjbTY2HZPYfrYVaILm6M9uvB7KD8fG2XALl2peuYASRrgf9SZrNDAik+tkSZ7Nz
         aUDvqkr5jXO5x3Ub06XPAlnCGpKALMpq0pDJqVFNZ0tlcoGArHHbAhI0unuAwz4KI8js
         7DcVm2jT+pi/oakuWrN4FpSgyta0fUx96YAYHXkCgVyzCHxQDAl+mTCE7DCGHDWIhx28
         68LTtM1GqZ0ctYw7/c8ORx9Sq2Qe13f/bUYenYtUANz14+uy42MaVoaslSa15G/EKi17
         4ICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759400145; x=1760004945;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MpOCePemL6vEYpCvPcTB5T61Ggf93+sTv7+KCD/4Us0=;
        b=lY8gkwqtD1yN4IkUtIjOaWYR/Hyg9qhpCDyMzqR6vifdkYzPtE7we6DrIDLKUrXpR+
         mxKgMH7vjy9Z/LBxXHR/sQOKMVqppZ5IhHA53O9/Vh7aO4OznbrK5A0sPXE1F48+RcdQ
         NUlt42Uyt/6a5CDTJCUOXwslucKiBVpI0IvEuYzmEwkRJ/SbN4HVZtik6z4JvjC39gEx
         nQhYHWk69Cca7OZUHZrWpyCMBqyvGr3TpCRJjeSa0n+/9tTWSIStZhT4wlTBNqnXSR0u
         M2e+XSJmryLD/Kblh2afEQkykUGBUsJHelRwNMBVbDO30eX+cbna8FO33GBD+DB5fbH/
         mzcw==
X-Forwarded-Encrypted: i=1; AJvYcCV+R23Vez1xlzB0larER1lycRnELj3JB0FEb25dDEzRU9HiB4+KL1dLauWbWhbT1B8A2vyjtdShYuid0gw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwODXCKi06bmo6Y8rQ75q8ZL9vjE4TB3gZBFZfVg4gdlOmRQeed
	l5v3LT4jQevicDSQNfcbLUm4T/7GPryidkVpZLsqKvSCpKmRjYBo1RcUV3fuOivxdcA=
X-Gm-Gg: ASbGncsB+3qN1JNol+SJWtucTt+VrHysQybl4Zr0b+I3CKVo9/9+hVWQvlHxnN9YNL1
	W5KHLv4mQfZve/hL7PWdK3H7TmBlmYwb1yxFsHijeP+a0JmEjHJmqKQGSSJy+KQtZ0R38RdvTds
	k8zdCtIVPRs6rRpWed2J8GnA9Iek9KBEzgBG2vVp+U5BPuZTqm2Os4idFcUUoPsWAmnqLDpcQCG
	d7Lz5e2faLUWFpYOILAboo4dRDp+wjteh2b3tH/Sof6LKpAmUQ1a/IZ6Z1IJraf3gm3hvOAyHfW
	L8OQU2yFgkug1ERc+i3jLpsdgaXnxwbPo24QtMO2enLrKXstaFSpN9fSCCMH03iwdgPbop/4xMT
	2kGLGFHipaSaN88Jqf6WN+nepU3K+Furve15RqYdHJ01q3ZIcfyPzNZePaRiG6UiTsX2ZS42B5Y
	Q/lYUkgNzp9eZXDaPcgbPIsM2VKJFGKDH/zli23so=
X-Google-Smtp-Source: AGHT+IHKPsH/a02esz5LFnruQITPPJCRHmW0KtrQ8DbN5B/ZLJUobNZd3CSpWIcrjaZ7zFTzB4mmOg==
X-Received: by 2002:a17:907:2683:b0:b3c:a161:684c with SMTP id a640c23a62f3a-b46e4b8f4d0mr793928266b.2.1759400145146;
        Thu, 02 Oct 2025 03:15:45 -0700 (PDT)
Received: from [172.16.220.227] (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4865e77427sm174862366b.36.2025.10.02.03.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 03:15:44 -0700 (PDT)
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Date: Thu, 02 Oct 2025 12:15:33 +0200
Subject: [PATCH 1/4] dt-bindings: media: i2c: dw9719: Document DW9800K
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251002-dw9800-driver-v1-1-c305328e44f0@fairphone.com>
References: <20251002-dw9800-driver-v1-0-c305328e44f0@fairphone.com>
In-Reply-To: <20251002-dw9800-driver-v1-0-c305328e44f0@fairphone.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 Daniel Scally <djrscally@gmail.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759400143; l=792;
 i=griffin.kroah@fairphone.com; s=20250804; h=from:subject:message-id;
 bh=Czqxeo15fjZo1C4s++w8GwAplorv0FEgEEDoqJ3EFac=;
 b=Hi0LkYUTZVrvOTQFoVlNKM7KXL/UaLULs3trcSM4BexT71jmcaLwOrvt96+R1RR88o8Sk2fzF
 H6ol8Mgw8xwCfvrKeHqCMt9buYB1LcZxGoskfW41ktXPr9Lu4j6yy3u
X-Developer-Key: i=griffin.kroah@fairphone.com; a=ed25519;
 pk=drSBvqKFiR+xucmLWONHSq/wGrW+YvcVtBXFYnYzn8U=

Document the Dongwoon Anatech DW9800K.

Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
---
 Documentation/devicetree/bindings/media/i2c/dongwoon,dw9719.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/i2c/dongwoon,dw9719.yaml b/Documentation/devicetree/bindings/media/i2c/dongwoon,dw9719.yaml
index 38db0764c0f70ad49295dcddc182b7e100a68b29..8e8d62436e0d0c4f9af9e52262b23881abd37cec 100644
--- a/Documentation/devicetree/bindings/media/i2c/dongwoon,dw9719.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/dongwoon,dw9719.yaml
@@ -21,6 +21,7 @@ properties:
       - dongwoon,dw9718s
       - dongwoon,dw9719
       - dongwoon,dw9761
+      - dongwoon,dw9800k
 
   reg:
     maxItems: 1

-- 
2.43.0



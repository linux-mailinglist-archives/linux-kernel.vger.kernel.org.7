Return-Path: <linux-kernel+bounces-846962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A23EBBC989C
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 16:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 768F83A6DB9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 14:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAAA2EBB90;
	Thu,  9 Oct 2025 14:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="iUOJFunX"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E2F2EA46F
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 14:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760020530; cv=none; b=p7e6pqy+xBhF3UDQKiattw6DB7Fm624rTTgzaZIJ30SzbeGbXrDKF8eXv9zpCSXjh0jOHWJwZ9GtX0p9XjPiBY0hcyxtprTZY8Zspc6DVpFTbvUcOd2J6ZuhPkp+2pKFx4qmLWvg/urI5DqoPlbr49I2oRUSTF3rEmp19+sKHh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760020530; c=relaxed/simple;
	bh=DC16tUoCJGqdCaZCKlPxmdAri6UTD51Yi97Na91Z5Ew=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GuqM8gz1OuWpXWknPX2G/UqC+ncxFZZqUJ+i+tU95DuQvCLuVWf8zqAqPHjx+0RTfIpwq0JRX2Lspy8NRI9vYPD6cj0RAJE3NcM0dhb+ImGY+jKZENxikdM//kt6JTpFTDTV4soGfNuPPbxAVt0OwNrL7Ddc77jJTka1YM8jQto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=iUOJFunX; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so157041666b.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 07:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1760020525; x=1760625325; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dlfDjHrcdfKrGBvOyIQt5Lw/+fx5LVzeszJPP8D8ljg=;
        b=iUOJFunXX6SpHyVuun4dkJclFtfb1WyfNUpQ5owGJ6CZcnzRnViYgOfk5RanHIleDq
         q62E7zUIr0c4aL2dTS7YmBOEL+2F64uqojTFXrXxrzExreY/JMJXDw3raieN1HagAXug
         GtbC8Y/6xdiVkcU6wqIMGJ/+kDTEgjj6nk8u1yGY+PR03Wsz0WDwNAYCWNNeYpSnAwP3
         YImnI30IWQpOQv7V8b2stA/3r6HhNoL6hdDC0ZoayJxRGwz1bDX0mfqUvB62+t2WspgW
         WCUVmX1VVgJ7hMFyJAgxMAxy/dvs/vxLixPdk8HvDo+3PxHVX0Rkm1/23U4o421o2z/L
         OsgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760020525; x=1760625325;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dlfDjHrcdfKrGBvOyIQt5Lw/+fx5LVzeszJPP8D8ljg=;
        b=Qzu623z2sZuhgsyLBcuI6FezZayJWQueFiAHFQUFCFgtHZHsuDl5gt7LtUbgOJJWT1
         YsLH+kO7zNcrEHm1ew5uaPz8D/+Gg6GxqrA3b9hTo39TxpxSoyROcs5NGb0At3uJ92eJ
         0i7Y+aoVQLMrhAffNBOFQ6sDuYqDnkzzpf0evZ+uOL+UKrejxRZREocV8qR3OBm5IL3F
         LaQmMktHNYs9YDNDuGc3/LOfJBq/G11DnInwutpw1L+kKKpMAelBM7wvz3UBtca6VHD3
         Q4QCXL2h4SybKce4Lc+BMJSmRNHWtmkPgO8LGJAGDV9/PWlveZpNlHGqbjF2Y9ZNAqW2
         Dhsg==
X-Forwarded-Encrypted: i=1; AJvYcCWD2O0bAv6YuttfAxLyGgv3lQlwN2YLNvgCigLd+zzEKXjSOOvVn651x2YZ2JD9tVRHpz8IOLyK5GZkwXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOQ19pPRHusOOikIeCnKsR9RTDjVqMa/u0cupOWglg4UyfXi/8
	IffUCYClH7cX6LOg6KcrWRs0/SEd2yX9YnIs0CJ2SdOYHS6BsUVPMVzqDBdXcHS3Qp4LfTf26IV
	0iwE3
X-Gm-Gg: ASbGncu1CpkqWk4n+Sm7ksdFf+c+MPXMvl3dsbA+tWih1s0gkHa0v9eTfdxNUhokVh5
	XlUDHgblbK3bBHxiXTMzwX42TP36KzPvRki8P2ZsYSgFbaSYnlIWZw0qNNdNIrfp6l18tJhUZ03
	hERtt04cJBVxc9UrgA/qNPYjQriuwBCw3FvMRULaJwRNbG67c0fjsKItlZhiaW0ElMoBX5MzoZt
	3VLQKmFdOu71IQ5Ww5xVJ0hJSsSZmHcimzKgO55AEnTNRKyuYdl1Lruc75+mf/ESnu01jjL0dmA
	zyWTBTNRIVKSO/3oz18sOGQzUW/7at7FKoz/Y4KJXsDNP79cVPgTpo7Q3wm5vuMWBzypOCfdqWM
	fWCQpulIQL73cmxAfIonx7oNwnpp2oJfBr7y1z/rjx/JZzFulCy9B7r+bDs7kQcSTpuGn3HTxCz
	3o4CwyRYyr20Ksx+YaxesEKrNJs1PE
X-Google-Smtp-Source: AGHT+IFr+JayJiI/I7GtD5Am8LsYRvZTBEDWCg7gaW9yIcgYbX0jYmBj1aCqR/Li886um8C6i2SVAQ==
X-Received: by 2002:a17:907:3fa2:b0:b45:a6e6:97b4 with SMTP id a640c23a62f3a-b50ac7eab77mr881171466b.50.1760020525167;
        Thu, 09 Oct 2025 07:35:25 -0700 (PDT)
Received: from [172.16.220.227] (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486606dc84sm1885797166b.45.2025.10.09.07.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 07:35:24 -0700 (PDT)
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Date: Thu, 09 Oct 2025 16:35:07 +0200
Subject: [PATCH v2 1/4] dt-bindings: media: i2c: dw9719: Document DW9800K
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251009-dw9800-driver-v2-1-3c33ccd1d741@fairphone.com>
References: <20251009-dw9800-driver-v2-0-3c33ccd1d741@fairphone.com>
In-Reply-To: <20251009-dw9800-driver-v2-0-3c33ccd1d741@fairphone.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 Daniel Scally <djrscally@gmail.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>, 
 Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760020524; l=839;
 i=griffin.kroah@fairphone.com; s=20250804; h=from:subject:message-id;
 bh=DC16tUoCJGqdCaZCKlPxmdAri6UTD51Yi97Na91Z5Ew=;
 b=81CtBnB7VTEGormq+HKUETLhCoxzffogHTSiVoP2MaW1g4FKdg9qmwnA68EPe1FVZMWa+413s
 odfYumDV0MPCcgnPpB7UaEjgGXjtymenX160dy74x1jX2K9F/LfIf6m
X-Developer-Key: i=griffin.kroah@fairphone.com; a=ed25519;
 pk=drSBvqKFiR+xucmLWONHSq/wGrW+YvcVtBXFYnYzn8U=

Document the Dongwoon Anatech DW9800K.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
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



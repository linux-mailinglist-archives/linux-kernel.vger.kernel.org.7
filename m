Return-Path: <linux-kernel+bounces-846770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D70FABC8FE8
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 14:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D70EC1887192
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 12:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20532E2F14;
	Thu,  9 Oct 2025 12:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="1WLpsiIi"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E7A2D879B
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 12:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760012633; cv=none; b=PoQ+dxvvyxtmezm6RAntOHRkR3bW1kjZoWS6FR0oM2tddjQyDgBadmBA6OZic8jpvjGjsZ3rmJ3Y99rSiNBESqw7wuPHKfvMAMSD4rFLFGZf5Ko3mJzO4hUhQwYRoxFY5Gg1jIocnDjjMtMV1IQlkPZIPSyV2YucCT8mkM0eqIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760012633; c=relaxed/simple;
	bh=92BmjzTkktMcwmDuuR0/4Hya7qrc/cicAQZ7fp0iZ4g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wn8rqMkX7JNGsyWBjNoPbWa1K6YXcT5gJlSdla2rGZkL4KmLcjAsEJy9RX4mOsYUQHhlgEEF93vf9LJgrJZo//E6aHqSzUtGlcAwFZ3vxYRL6t2+fLqDPhqdlrneBg7+J/3WL2gTTlXp5m6TqUsSXwgykwJOwlFmFM9HFq2OSPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=1WLpsiIi; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-631df7b2dffso2288185a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 05:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1760012630; x=1760617430; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f4ESIGC5JXj+5rNkHKRGo3WIWZoFPUgTFIJuXOSXg74=;
        b=1WLpsiIiwaTkeV/x2Xvw1i/VL+SwLjoFfMYGqRGBbHmjkaPDerszS1VTgJsTNvzRIZ
         cwdJAr6WC7r2i5sJLWHBzLXlCnP8Za8qu/jX5g/xzT4NavEUqryiqorpHiOuVECcU2e2
         mLmbCE+E3YlgeKm5K97DcbnoIczFxWLBw19Y8+hrhAGfVScDuxvO0ExCNnOOPwOQ/m1L
         TKKU+2Jtv5IbKJGRMlcnGo0IJUkz+t7tfvb9HUU8nBpJPlUwmd6QkA/hU7IveoIC0bZi
         348RnUtnQZ3GnAR1cVAWBGnvmNegs11ymczUAlfqP6PqUIbkLh0CR4lCxNwTt2pX+FbP
         7bQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760012630; x=1760617430;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f4ESIGC5JXj+5rNkHKRGo3WIWZoFPUgTFIJuXOSXg74=;
        b=Wl/ZY4xgdrT9xgN7g3frZ/qhkU+8Q5sZtDoaP2M1UZxxMGqSewDxd0lpLrVdiQUSKy
         bRTjy8VYxMQ4mxOWuuXv6wr7P4Cm8kmUtCuyi6AqfLxDGahpDb30b1/zKbRblV/0kjrL
         ZJSkyK0vGpiN1iPiG+R98+arQl+7RHuIqLAbthUWfTnrtDT1vd7TCnsatyEnWGow6TDB
         lCO8OBbu5ql4QX6eDgJSAl6ZUVC+IdZCEzpZXQnYbEVXrlFsN9fshWlg48FDkcsVRiUl
         eOHlD4re3gy6syJdzA4dkd+kMstIb+AIkZ7FpSlDFCPr1o9b+RUvVKnD7IntD9PbG8GW
         mL5A==
X-Forwarded-Encrypted: i=1; AJvYcCWhUfEDTNTCUI9zOY5OdKeMPZ7QXKMJibWfGrzSfFxzzJg+bbbnWSQprCaBGQqyxG/y318xdwliW9LLnHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPTL5PoGBMnouzkxmZAqarxrrhCSykbhJVpeYMfrs/7P8uXzE8
	lruUgDPPAA87lINgqo7ci5aY4ftfPk4296SbdQGCRiVTemQYgA1ZzbLQcM2rm2SYVvQ=
X-Gm-Gg: ASbGncurEPimk8lpJTEW0pdimclak+kRGcpio5VQHDAA/TfqzWS1WW5JKYKE5h1QCpO
	8Um0nAg+qBDWTyf+QaQ8FN0+qYzRcOFV5UCGiUW+tVF9FMSRI54PucCL3VPq/oETHAbmE8OSgi0
	d+LUwiJjh437La9UV7bmShgP66/tjTo5GQIdtQxmydUrZjfPXACRJ5aeJq92gdCInvaqmUE9bLU
	cVMrparRWqtUM8fYAMKa1bmnGsps8OkRKUnaOOiAq4/isOvV/adcGzANsHCUDQPsXhHMQGYBMab
	h19G5wubCs91r9eufXxNnlpv+XZcpIjYbAfYIehgaFAmctv8IEWZ9nkZSWtGdFOstdCArfroXeK
	UzwUDdm32IzL8UIvlsHicp423XIU8nokUN7vQQlZMCtCv0ootrA3jveVQ/hEnO/6BsZ1iD1EQgt
	A3UWvWNA+FxvGs5udaS64ZHh/e06QR
X-Google-Smtp-Source: AGHT+IENniTshcqe3jJJStJvdAgI0KTDHDHdfB7CmkzhSPQH5g1ZIrk13h0XfNpFk5i36R7taLsTHQ==
X-Received: by 2002:a05:6402:696:b0:639:dcef:9127 with SMTP id 4fb4d7f45d1cf-639dcef91c3mr4667803a12.18.1760012629669;
        Thu, 09 Oct 2025 05:23:49 -0700 (PDT)
Received: from [172.16.220.227] (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-639f3d09b92sm2231273a12.30.2025.10.09.05.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 05:23:49 -0700 (PDT)
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Date: Thu, 09 Oct 2025 14:23:38 +0200
Subject: [PATCH RFC 1/3] dt-bindings: media: i2c: ak7375: Document AK7377
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251009-ak7377-driver-v1-1-29e4f6e16ed3@fairphone.com>
References: <20251009-ak7377-driver-v1-0-29e4f6e16ed3@fairphone.com>
In-Reply-To: <20251009-ak7377-driver-v1-0-29e4f6e16ed3@fairphone.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Tianshu Qiu <tian.shu.qiu@intel.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760012628; l=794;
 i=griffin.kroah@fairphone.com; s=20250804; h=from:subject:message-id;
 bh=92BmjzTkktMcwmDuuR0/4Hya7qrc/cicAQZ7fp0iZ4g=;
 b=wiGazj0RSHWQal7YYs6Fd+dwKjXU8rDWGrrC87eLCCcRfpVpJoY6/C2rXaEGb/AUC/KB3LqlY
 zpnPZQvXJn1CqWZz3DOpW+MIToM2/MChrklbu31SHSJE7yaRxkjoBm1
X-Developer-Key: i=griffin.kroah@fairphone.com; a=ed25519;
 pk=drSBvqKFiR+xucmLWONHSq/wGrW+YvcVtBXFYnYzn8U=

Document the Asahi Kasei AK7377.

Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
---
 Documentation/devicetree/bindings/media/i2c/asahi-kasei,ak7375.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/i2c/asahi-kasei,ak7375.yaml b/Documentation/devicetree/bindings/media/i2c/asahi-kasei,ak7375.yaml
index fe312cc6a87310fc77216d945e7b301dd98acc0c..c040757eb80c925d796919316c64ae31fb4df49c 100644
--- a/Documentation/devicetree/bindings/media/i2c/asahi-kasei,ak7375.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/asahi-kasei,ak7375.yaml
@@ -18,6 +18,7 @@ properties:
     enum:
       - asahi-kasei,ak7345
       - asahi-kasei,ak7375
+      - asahi-kasei,ak7377
 
   reg:
     maxItems: 1

-- 
2.43.0



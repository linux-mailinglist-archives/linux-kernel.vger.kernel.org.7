Return-Path: <linux-kernel+bounces-846769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 753F1BC8FDF
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 14:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8999C4E2191
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 12:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F942E228D;
	Thu,  9 Oct 2025 12:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="Gp+ctcNA"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C65625A659
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 12:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760012632; cv=none; b=JR1Z7zHXfIi8l7d/nAvXLyWfAElh9TNW3e37Avl1ihVWYFkrqPiY5QIhC5rccns5XJL16ulpbi71BGl4Aobvf+K43DyNNmjJyiS75HptDOLvpdT4iuwGt6ARMZikDtdLz8J4Zp8m5m4oS9FWqP0i4MvHEY1zs6MCiGPuOf+n6rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760012632; c=relaxed/simple;
	bh=NKYwbSuoZ7KUdj7otYEtY2P0sntuXVy4h1xZozLcbWQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QXa6UGPZ7239TaTlCgPGu4K7qQBJi2WmVDxB6K9EUAeViqHBfdAOTPkKBB7sCA8uILJ3bieQh52oTWlAibAmFdXIFFJ59/D32MMYJhIuYPmYxMflew/NrkEPZQZxdRaM9OEYawES9JsWcCUGa2c3Ct8hdwXpFheS2XtHTwwb/w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=Gp+ctcNA; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-636de696e18so1812564a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 05:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1760012629; x=1760617429; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tHySYeGJ1ieMTpnCcwu2cfiHKzDSjdVN2CuFIzAgi+Y=;
        b=Gp+ctcNAXQVtTo4EyNVw0Jje0zFymioIy6QAJcQelXjUpxtCi8o0wH7ihgAoJt7yon
         DtJn2lDZCkruacpp8k8ndaZYbRER0IAOnEc/DGyihN3Ma7UEZDsZpW7LNOSiG3aeiDJq
         eFVbXzft8WovxXH3ozl8G1CYPJA7Juji5ugWgCWpkndhnzHecN4cWmoji0suWhT1kPs5
         shVxasnAredQmiXH60Uatdjg+uzky/NWEW91zcvCJ4oXevdV7Hcg7g4pLet24/lAIEJ2
         NRpZva5d6MU7YDgSb30BYkz/Xt22uultBF0RjqhaiXu5a0PWdju1m/WMI52CM8GNxbc3
         bKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760012629; x=1760617429;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tHySYeGJ1ieMTpnCcwu2cfiHKzDSjdVN2CuFIzAgi+Y=;
        b=YCpWzK3SQdgN9TTszaNT4PxasZkiVjpKK+kb71FPrJ3aiMLjZ7LaAuK7nngiM0tPzu
         4v/7dsbzYkWctPWqqBe/pV+uymaqOKsNqOQgPaPrXnm6BV5KtGXUiAox1iYyUvh89n3i
         fW3/JO3WcrULo1WIf4BK4suLnv+IXAbcWHMDxrxK/+XTFAPt0NyxR2kNdAcUyJebUQSX
         qlv6H2Os0/ZBHZw8d+XYeHu0HhEVn7Cmvoti71+DtytUpM4U7nNpSM4kzxKs3FGdIC8A
         A6YnMXO4FcmnGrpFR6gwx4ualqAHSoWHa3qHEERKmDIws89zZkk6RkFrTERefETOLPho
         eZeA==
X-Forwarded-Encrypted: i=1; AJvYcCUog4hnzn+dWMvMmdNHvKjCRIbJQPrIkDKVrUr1ZmXiSu6veTlcpwQj2wit9tA1RMzmV9hJCR1GS1SSrNM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzu7Ba8le19+nd7m8tpfz9UD4OFr+/JHyLzWPX7vamRgzkQzlB
	UJkj+Hu7Z6qHj9t1HrZ0D7tXaTe/IJS1YyDfdesCCNsC06xy0YDvOgN1ydFNe6oUjD0=
X-Gm-Gg: ASbGnctHA0soWSEWidpm/8SL9v3MYG2HMxT4U0tG6XdR8qUax01WiryWre02pVIdyGS
	M0wwWPExudOrqmfHetnMxaPjcBBtrw7nG8QC6+Ec3ww5/mAzxB6rnDxK1Ql5YGdjFgUGYCK135/
	ZKpgaKw/ZyMbZwesK7ompBWDm1qUNDwla7FXGkHiDzRa1WBCuUV+7L298ZbG+og8N756Bv1N7cG
	FA3wGdxFurO8EUEF6PGvADEwZ6o6PaSphQk+TqaABDtCF+w0JQ5wyDkCJZLMH9citdZ0QebwmIe
	ZuzCrneXrf+yeO3Tc1a11uQdYSGld6kuJ1u/MzfRE7Fxk9tf+tnyZ5SL1CsmMFxtVYTnJ3tap3O
	rTnmkvYpWiPfFuCUrUOgiY8RKVVi43/wjJsoXLOZo4ulav1j8AiqwSzrq5diV5j2kdEef1vZDWF
	j8DDDF4itWr5jzlKzptCDc5HwYiS6MPEXq0pfBbnk=
X-Google-Smtp-Source: AGHT+IHHln953x+ocb683fbtunM4jGpgYY7ccluW48jSBvEHmWWg41yNKdtcVem28NTFOpr1Aiy6yA==
X-Received: by 2002:a05:6402:520b:b0:61c:9852:bb9f with SMTP id 4fb4d7f45d1cf-639d5b57922mr6410311a12.1.1760012628801;
        Thu, 09 Oct 2025 05:23:48 -0700 (PDT)
Received: from [172.16.220.227] (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-639f3d09b92sm2231273a12.30.2025.10.09.05.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 05:23:48 -0700 (PDT)
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Subject: [PATCH RFC 0/3] Add support for Asahi Kasei AK7377 driver
Date: Thu, 09 Oct 2025 14:23:37 +0200
Message-Id: <20251009-ak7377-driver-v1-0-29e4f6e16ed3@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEmp52gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAwNL3cRsc2Nzc92Uosyy1CJdCzNjC8M0I0tzM9MkJaCegqLUtMwKsHn
 RSkFuzkqxtbUA4DpR2GQAAAA=
X-Change-ID: 20251009-ak7377-driver-86381f29765b
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760012628; l=1154;
 i=griffin.kroah@fairphone.com; s=20250804; h=from:subject:message-id;
 bh=NKYwbSuoZ7KUdj7otYEtY2P0sntuXVy4h1xZozLcbWQ=;
 b=+mBeh2zVh4IEuQ1wv5ncOtyoapeQ/seSYFdezBTttdLSr5A5HdBUQ5/+Rl23YaFQySt8PmHTk
 ZaZY62dL0V0BQ0C8GwuNMvZWkYHpWkU5koSyUD3jX1Pno5WCl/AhfBZ
X-Developer-Key: i=griffin.kroah@fairphone.com; a=ed25519;
 pk=drSBvqKFiR+xucmLWONHSq/wGrW+YvcVtBXFYnYzn8U=

Add devicetree bindings and driver support for the AK7377 VCM driver.

The driver code is added to the preexistent ak7375 driver, which appears
to have similar function order. 

Some values of this driver were reverse-engineered from the existing
drivers due to the lack of a datasheet for the AK7377, The driver moves
the lens but could not be fully tested due to lack of camera sensor support,
that's why this is marked RFC.

Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
---
Griffin Kroah-Hartman (3):
      dt-bindings: media: i2c: ak7375: Document AK7377
      media: i2c: ak7375: Add support for ak7377
      arm64: dts: qcom: qcm6490-fairphone-fp5: Add cam actuator

 .../devicetree/bindings/media/i2c/asahi-kasei,ak7375.yaml  |  1 +
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts         |  7 +++++++
 drivers/media/i2c/ak7375.c                                 | 14 ++++++++++++++
 3 files changed, 22 insertions(+)
---
base-commit: e5f0a698b34ed76002dc5cff3804a61c80233a7a
change-id: 20251009-ak7377-driver-86381f29765b

Best regards,
-- 
Griffin Kroah-Hartman <griffin.kroah@fairphone.com>



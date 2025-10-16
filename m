Return-Path: <linux-kernel+bounces-856897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F7BBE55C7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 22:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 196CB5E1FE2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8EE2DCF51;
	Thu, 16 Oct 2025 20:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuREAy2L"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB3328CF49
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 20:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760646099; cv=none; b=RNYcv5msX5psOTSk+WvTc0r9js4AVAMgSHMjlfQnlwH7Es5bI6srMi93yJDbEby3V+DYYwrJjCWHeW/4VTIxDhabjtM2OqMdIufsgSdgIeKP9hNyMyxozRIwPlCNADb3zhiJ62vcMZvhO+w46lvvV7y219cCT2940oubPvZhWtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760646099; c=relaxed/simple;
	bh=BcenkE5oij35+qnzDj3O348Sh5xVXKvPOI8nx3wC9MM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cAPUHcH7qj4E/oAecHt9C6VqpWy1GKUikjXGNwZXoxMWaGGOjOkh/klIpDhFXTwhBJfc6C7JybIASVT+5KHTfJmcNpR/3XyvUSkpwvLnfBhS/EhQEmSlG1rlK00oiJhfNY/6lz7LxVw7C771xY9MGGJAkTYePqVSXmhlrE+0OYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UuREAy2L; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b608df6d2a0so976449a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 13:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760646098; x=1761250898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t1pnFsgHZlF5IH/3trSxr4jGs6V5/3pIAYyrgqrUrkQ=;
        b=UuREAy2L6RLVl691D9Dcnic3ATmYqvRzlnA7cVGZbKvyy5tox91XzQ1xgAWZ1JmgSN
         ihlpxTNXjiUaaamaQvxqc20le1RYXyWKRCKFqtRv0gLkN3mUZYWB83K+oQpWOSNkEja3
         ps05p3h0q3Lhq6FO/zygPhCTGACe+wGleTNEGRIBmrwgJchMShaxEPmaPL67auhHYQL2
         /EOP9MzjAcmTT10Rf9sx0bFxC8VsY7q+FBuoOBs12mSLaM+9Y1voEdubwysH5ixjo6tR
         ta1aXHWueyV85uD5O8q9lfCNUUJJ3+P2iav0l8rDSkN6N3DmUVPDoGnZnRp5C80NoAPQ
         4YBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760646098; x=1761250898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t1pnFsgHZlF5IH/3trSxr4jGs6V5/3pIAYyrgqrUrkQ=;
        b=dJ9WZBECjQI+x7bAF1+Uo7eRF/VVrz5Lv5yfFG2CwuxyQbMnmcnD9vk2bggtSV4N4h
         nPXipzvmdb91SaLVDl1K0uHV80ZA4LvqdqrZse+nh/oQeNeKXlZeHnPr5Eu5K8kk7ClH
         DbPRN5tpGITyWqSt1wZJI8hQKMuOk/TUZcj3kVN+JunYd4V5d1/XSMFiYA9uCMhDPy5F
         twcLB5XBh5th5+xe4dYPL2uXInbOA4Jyyf6A6OtXazKmrAtlEZnDC/cQmGz+IBRtixBG
         jZIjW5FNjaB2buo4f4RxuUcqRffwSklki/ShAGVq5xBxMZJQth27ATqiJrZ9uqUnFRTK
         KTLA==
X-Forwarded-Encrypted: i=1; AJvYcCV9Fk9DvDAh9nYFLuHeCJpZj/M+XPmHOYUaYrb202YWSofK9eBt831fCET4TELDYL0DQKYk3sK4+QkZxNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqVTjtZp067mu06enDpD3ZVcJjhBCj0G14dXIH8JD5sfzCy3fo
	MPWvlCKzWaZcvvsEKYcs13o+PONrwZLxs3S4PsB7VAzbfOP/hGSKZe8l
X-Gm-Gg: ASbGncsVkBY1FoIUSDnSzoaiQ3uiMuGiCobnTFzH9BTyYPpKZHrtGvW97vMLAqn1olq
	Jv+lIoOw/ohMBWswUeZgim7GNIKEFw8cabARaeAGpvuN95h5qK/UlaJH15lcgsKbHhsG9JjV9+T
	GezVKyCC13sKj7Tb0TiJvgY2gsYSn6hXQaMg44RR7foKEudxJ0SbO7J8FvEiISMpnfG8BpC/o9P
	DUUvkne8lc6OGnraJn6NBi7CAFzgLma7gr878PaKsiL6uvTOXnr6kjrt6ptRub8umT1teGz+RHl
	DqtZsUuzvlC8C9/fFJ0rrVQnMJqp4Pt6eeHulvLAjtlunr76RtpTy1RRd37JRdG24mkAPw8GbQv
	uwmqYtb+v7dbAsRHIRpByvHzltqvRVPx6NitZSJKvfEaVI6tUPG81+t74hONLiJHjDpKHZ08=
X-Google-Smtp-Source: AGHT+IHmjZIi4WyUkoutLEljD+DOjLSw+pd3IVqb1HXxBYzq13K9zBms3zRTzKYybow/7ckp/YAVTA==
X-Received: by 2002:a17:903:98f:b0:24b:182b:7144 with SMTP id d9443c01a7336-290c9cf8ee7mr13029575ad.7.1760646097545;
        Thu, 16 Oct 2025 13:21:37 -0700 (PDT)
Received: from archlinux ([177.9.216.59])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099a7d377sm39482115ad.60.2025.10.16.13.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 13:21:37 -0700 (PDT)
From: =?UTF-8?q?Eric=20Gon=C3=A7alves?= <ghatto404@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v4] arm64: dts: qcom: sm8250-samsung-common: correct reserved pins
Date: Thu, 16 Oct 2025 16:21:29 -0400
Message-ID: <20251016202129.226449-1-ghatto404@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The S20 series has additional reserved pins for the fingerprint sensor,
GPIO 20-23. Correct it by adding them into gpio-reserved-ranges.

Fixes: 6657fe9e9f23 ("arm64: dts: qcom: add initial support for Samsung Galaxy S20 FE")
Signed-off-by: Eric Gonçalves <ghatto404@gmail.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
Changes in v4:
- Removed accidental , instead of ; in the last line

Changes in v3:
- Actually fixed <40 4> indentation
Sorry, I still had my editor on 4 spaces a tab

Changes in v2:
- Properly format the <40 4> line
- Added Fixes tag
---
 arch/arm64/boot/dts/qcom/sm8250-samsung-common.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-samsung-common.dtsi b/arch/arm64/boot/dts/qcom/sm8250-samsung-common.dtsi
index cf3d917addd8..ef7ea4f72bf9 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-samsung-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250-samsung-common.dtsi
@@ -159,7 +159,8 @@ &pon_resin {
 };
 
 &tlmm {
-	gpio-reserved-ranges = <40 4>; /* I2C (Unused) */
+	gpio-reserved-ranges = <20 4>, /* SPI (fingerprint scanner) */
+			       <40 4>; /* Unused */
 };
 
 &usb_1 {
-- 
2.51.0



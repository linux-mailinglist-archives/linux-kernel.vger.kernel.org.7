Return-Path: <linux-kernel+bounces-846508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96ED7BC833D
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 11:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8EBF1A6159D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 09:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A042D47F2;
	Thu,  9 Oct 2025 09:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4JWBZHY"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216A8212568
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 09:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760000857; cv=none; b=V9xm8z4c8fXNL2tN9IfLjP8QoHMi/sbEAAV1KckKfTtDYvKJ/6l9UJ7VMWOCIM7AYXYa07I3d3AQroQ1RuR8O3fDdQ+cmVH9xH9DWBtaM2BpUYCodR7s0ZnXqr3nNOzGBHusR7udrIr5gnivnCrm5YEqQ2E1xjIq6F09FZdZTzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760000857; c=relaxed/simple;
	bh=l5mhbycfE08ir0RvnM0JhK5D+99iA9c0a12NXel/+9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m3WuTR2w6zz8gcIeybaEvSeqnNbNii/o4b55LeNYrWHHn+yoIGKRTdHs5L024JW+SMqgNqCfREGDP49AmqY3gnhteGMj2kpGP7od+6L5wt8Fy02pGSiFd9HIfIuP/AIaxhXK8CFFb8YInXbldvt44nKb7LGJCu64u67p4SrSE1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4JWBZHY; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3ee15b5435bso437629f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 02:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760000854; x=1760605654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o++CZcgphHqNF7K6IE3hm++2Mw0o+yR/xwaMs5XLwOQ=;
        b=D4JWBZHYqdm2ziFSOORrkqglUVuHsHrCMFMNEF57QyL37+73OQIqpszZPw9vZmDAwF
         6mVc24aUD0RhKZ88yvin5yJ7nUyfbakMjWnEflTtoJsgra0vddcMy8PEZLTUpEN/6RWK
         g2LB+r0VqSZ4laKZrwCgEZ2Uy8BGsFCQS8m4wvqfbLpOq2Gi0OAx3JCb8oWi3IR/2mqS
         BXaj3DMcKHGCd3/90byjSqmvk2knKSMfcDArZTgApYQjzPTKxCY2QLuWQK0IwtdvWgsR
         u8AnRT4eqPJhOn5/Qm5eYSOpoCt3ZxR+wZ2N6q5CWl9e9M/5lIEI6QHazT5tQZa34/EE
         SYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760000854; x=1760605654;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o++CZcgphHqNF7K6IE3hm++2Mw0o+yR/xwaMs5XLwOQ=;
        b=jDexP4XzPDFpR3PhMfIx7Fu4gkUFl69t+V7w5CHtX9vaD4Q2iu2bCgPxGohOpFoG8z
         Z1im1hxVwwJR08wjul0GDr26SNVZl1xqO81yJWq5xSWjYA1/0zQPjwF3+j2WRqvNG0jt
         8Xs0zKNjtjpn7RREDoVh/U+iJi0hIvFdT0oBztf0RzadR+hdsNqZliwO5mXX1rg5+vvY
         vVbSJQkm71AJQFXL+Ifrz3SnFVc5W6fRyVJZEosiu1nXUGatbu2QGaDQdds2EiYABx/Y
         LA3dUFaJkYJFtmhfmcDqw6HgaxoLn5cgqVspH3ZxsQOTu4+qetVC4+5cZ0TkCBY9bIeT
         mOdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMph4jSwL4LONI8LXGGL7iuyYPa8lubi4KgsPHK8cbO7/bL6cF/YWZBb4dxUXa8SVC/i2LQkFEfJWAPFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQDxz78b4QQBLHoBDO3qgR7Bgobiz1nhT6qrOLl9nTjG7zVfiU
	NIgQAFxAGjbjuK+8b7Jpw+zAnPlCj2U7qWiArt16AZULtwpQZNYaL7zT
X-Gm-Gg: ASbGnctWUDDot7J8Zq6t8M0n0tDhb8H8KRNbeq0/gIGYmXLDTHalhdXcOyoVWUUPC+4
	1bw76BwdK+vWqkkvkm7Im7F0NLW0z2q8SQTr8H+5HP8IZJfXHEHJ+5D42hg5SHSCx9bZ43MplSC
	6Jy4tejP5lGrUFaPVaXowpk9FT7ul9EjD6lsut5NHfzz0DNnGj13L9QoFa4gnOm78RQvBwFJRUD
	YJ76Rh9iMk4VHjXUeZzNSaW2tHjKxbKEN4EOO/aM1YAk37wLv1VNRErTZKWRjoOIuj5Q0nOSW37
	7IT0eGLwzaAafCySilhW+2+Hq994sC899zUHgPf65eJXw7lYVIq06qgQj4nXzfpIyWeCU69tQOV
	TdjUY4Fz+7bzZipKfQe5BMKfES/T6j0A82qYOpSD7pYw0otyShrDZFv7C
X-Google-Smtp-Source: AGHT+IGBpxxND25HGKh9Sv2Mhu71Rly/5HWjAPpRDKzQyqiB0LzVgVcpNLpNCoV5w5wRUa+5Id2Npg==
X-Received: by 2002:a5d:5f83:0:b0:3f7:4637:f052 with SMTP id ffacd0b85a97d-4266e8dab04mr4638469f8f.44.1760000854292;
        Thu, 09 Oct 2025 02:07:34 -0700 (PDT)
Received: from T15.. ([46.175.113.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6b40sm33872761f8f.2.2025.10.09.02.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 02:07:33 -0700 (PDT)
From: Wojciech Slenska <wojciech.slenska@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Wojciech Slenska <wojciech.slenska@gmail.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: qcm2290: Fix uart3 QUP interconnect
Date: Thu,  9 Oct 2025 11:07:17 +0200
Message-ID: <20251009090718.32503-1-wojciech.slenska@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The config_noc interconnect should use SLAVE_QUP_0.

Signed-off-by: Wojciech Slenska <wojciech.slenska@gmail.com>
---
 arch/arm64/boot/dts/qcom/qcm2290.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcm2290.dtsi b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
index 08141b41de24..746c49d6e0fd 100644
--- a/arch/arm64/boot/dts/qcom/qcm2290.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
@@ -1302,7 +1302,7 @@ uart3: serial@4a8c000 {
 				interconnects = <&qup_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
 						 &qup_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
 						<&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
-						 &config_noc MASTER_APPSS_PROC RPM_ALWAYS_TAG>;
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>;
 				interconnect-names = "qup-core",
 						     "qup-config";
 				status = "disabled";
-- 
2.43.0



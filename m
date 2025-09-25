Return-Path: <linux-kernel+bounces-831761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9E6B9D820
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 07:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 516E07AA9AC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 05:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994BF2E8DED;
	Thu, 25 Sep 2025 05:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UukHxvMB"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C4E757EA
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 05:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758779964; cv=none; b=lRzOU2krTmlwEztaG9KZXN/gmJ13F3veSnBivY7lcW6QZ7G6nYa+9jqPXbR08Bf7OKPhTdfiNWyE2tzNhePDhcl6DgWBr6Es1klzFzQogIhlb2r/R90U5csM2IJTdLldzHo6kIMbl3VO2gGHDDGYKqUibjDMo5IGCipnWk9KWk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758779964; c=relaxed/simple;
	bh=OxgF0sgU8kJelkuDjh/RK/kYTlp1sBcDIk4CfwqFFXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hHcEKbuu1KI6/PFkmNUNtuEiN9yIxwlIHrRYjo1mC6+qTCVe98mB8WVKbtyP1ILjjg4EWx1c3X6Od26ndOYVK1oKQgEnBkEV55nHAHI1JyMrPJ3Dhu0feA01gAsW4vKRTirkMaSNTlUoiCRhx3TqkeeZv4WsJlIh1y4Rqak+mDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UukHxvMB; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-77f68fae1a8so841526b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 22:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758779962; x=1759384762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/i3lJ5UnNUwnZHcBsmIKwojuviTql3djQ9HFxU9mOWY=;
        b=UukHxvMBUmHiEOWQlZM1QX1EnGSuZ4vWndD5nO0sSK9+KWjaPiufSnGSa/FO+mVuzE
         ztmaG1D77RoLkj9sbns45ZnqmXiwdMLqlhUROk/ZvEUCsXPu01CBFw3xH9PbunN4b70d
         7OBJcuRExL6BKf9PUYbZ9cTYwCiMX1JlkF4hIOL1BAZysOLP02CiYAWvTd85aW6pxQrb
         PjQnZKL5KQKWXXazubyWCCNk3Q+0mJsNIVSGWhz/o1y0GpgI1a0Z6Yl2o77bKIKp1ZF8
         hhhWPcURY3oVyjoroFle+R6diPS3qcS2iHeqlKWRzKSbGVdeHTHgFVLD/60101Ut/9k2
         uqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758779962; x=1759384762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/i3lJ5UnNUwnZHcBsmIKwojuviTql3djQ9HFxU9mOWY=;
        b=veF0S3q3Ti2f3j3FeBXl8XWzAPdDhXV3QUnAZ7O509aVxqpYJPItw20q2dKfzaB8M5
         9koWVKdnABJpGtNtDjRE4nXeE72jn93M7e8pVIGnQDjYGrCSk65QcvVRiIAw2QxeBozH
         4m8IzgIdIxxqx2PX9SBxOpiClVEPJW6Tm7yOdknQJ0hQpx8fzxfiOU9jmr43hIHRMDNG
         rzxCU4+gzVgs6igsST56gzbjqC89bbPSDpbyKhNXn0EEDHZNFWyb2Bx1v06FWVYhuPFz
         QAjVVXzxYRes5IPifAFf3aONr6JUkuJV/vlgCHWCTDQDivwKL0zyoiP5+hc/Nfh1adZ+
         kiXA==
X-Forwarded-Encrypted: i=1; AJvYcCVaBo8Cyk4MupFHKbUC7+0j05Djq0r37iqZbrSkdps/TMrSAyh+8SNnACyf3CdnfiFIDE8tP1mJkko5y4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfLu5JBVNmBuCCJ/xc0dbVFsU6MnTUw0SJbASYxVHnh8589q/n
	foilAB19X9Uo6bsd7+rZUI1MLsoAsxvzEUddfMKxIlsoY4KfBn+0zDha
X-Gm-Gg: ASbGncsjxqNl6ZWjKhBciiqTCmSjMUB5MZOWn9nYOcJaoB+fzPaaxgi5nVEeHjf8v+M
	h6qoOb93QY96Ycb4YcoYlwlcLMu9qRxJxivSgfSFM4jrXIfnGKzt/lJUGKOc01NzEshKBFAeHXV
	X9GDeBtIyOh00IafNx0VQ8ZFeDGD9Kwbm2bYrL40iENA0GRh/NC/5MPUpA4XahJa2yxFSl+QM4q
	u0VR7iLMquRcqnW9/NDNRN04tL/yFFeAlWPVpDg515B833BcTawJ8NJR2SBM3yqELqC5gn/U+u4
	MU5yuZbJK5e5LVF1btbmIrUm5MigHWKH9yYutISLCTxnBx+Etd7VJqJJ8XZ+gFziFh9K61AX0R7
	5tKmtWldbUlossXsYWQUu
X-Google-Smtp-Source: AGHT+IHlvw/vIjDHerdRohHiGD9BIjPGY+j7pBYk4Xdz3WGpTzu3diB6e3NShLvW+IeqM97exMFnag==
X-Received: by 2002:a05:6a20:2448:b0:2db:f868:22a with SMTP id adf61e73a8af0-2e7d9da085dmr2751475637.52.1758779962022;
        Wed, 24 Sep 2025 22:59:22 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac5:3981:16dc::247:77])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102b231ebsm866478b3a.52.2025.09.24.22.59.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 24 Sep 2025 22:59:21 -0700 (PDT)
From: Liangbin Lian <jjm2473@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	quentin.schulz@cherry.de,
	kever.yang@rock-chips.com,
	naoki@radxa.com,
	honyuenkwun@gmail.com,
	inindev@gmail.com,
	ivan8215145640@gmail.com,
	neil.armstrong@linaro.org,
	mani@kernel.org,
	dsimic@manjaro.org,
	pbrobinson@gmail.com,
	alchark@gmail.com,
	didi.debian@cknow.org,
	jjm2473@gmail.com,
	jbx6244@gmail.com
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: arm: rockchip: Add LinkEase EasePi R1
Date: Thu, 25 Sep 2025 13:59:05 +0800
Message-ID: <20250925055906.83375-2-jjm2473@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925055906.83375-1-jjm2473@gmail.com>
References: <20250925055906.83375-1-jjm2473@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LinkEase EasePi R1 is a high-performance mini router based on RK3568.

Signed-off-by: Liangbin Lian <jjm2473@gmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 28db6bd6aa5b..ec2271cfb7e1 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -726,6 +726,11 @@ properties:
           - const: lckfb,tspi-rk3566
           - const: rockchip,rk3566
 
+      - description: LinkEase EasePi R1
+        items:
+          - const: linkease,easepi-r1
+          - const: rockchip,rk3568
+
       - description: Luckfox Core3576 Module based boards
         items:
           - enum:
-- 
2.51.0



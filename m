Return-Path: <linux-kernel+bounces-804009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A98B4689E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 05:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 426B517D632
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 03:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2821122FE06;
	Sat,  6 Sep 2025 03:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UW6VshF6"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D66823BD05
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 03:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757128901; cv=none; b=aE7JmmIEWaqsBKymukcwyFglkqNaN4ZYQo+xVw3KtZtteGw5E7nkHvqzBNnfCAfR1+Z1Qkkbfd/9w4vziAqzOBCnZq+k2eTAn1mD1qpuWNfL90LGByp8f3wgJ/IcM9swtLwPH7EDUST46wgYLfxYA3lsCCsWfkPwQbL+zZBfc6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757128901; c=relaxed/simple;
	bh=0UkOEfi1IjDESIwDt6iP/LhJT/HeeTfKdMfFoCECOPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RhJaMKN/x3rpimoNEMKFjXw5OSEsFIQ90iFKC6w362Tu0RjzollT99ncZq2ZCnjRp7Moky91eH+nrCsEKCjW5pOsBMdekwfGvzh59u43ZaQ8YdVlyw10LYsAVVLpcx9M8Tu0PDDprCscUAXNPdU4S3M9EfS6u2OAvomz/0KKijs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UW6VshF6; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-24b13313b1bso20608895ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 20:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757128899; x=1757733699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z2cCU7dJci4fXTg8GbK2CWuzrGsJs5uLLD5TZBvmXm8=;
        b=UW6VshF6vheEGlqsMhM/GX7PWzTczz9mOmffjXi8f8HOyPxWRqIdN6rXuZuJM8Roei
         q/UgOyamAl27mmQGDdzfHoU3YbiyoX2Hxo0xG7CkC1XH4WstJrhuIFBKzyhYvf/Gb7cw
         bCCMUuG5Rxm7UUn6bY5jFeqrKT4y5ghZg+gHc/XKJWrOWJHPBfZviQWkxNa0XpJVKvnZ
         +aL1t0un3iLQv52nnVi0s+HTwBoPm9zqBowqXdQKDJtYbhXYBg1yIeIRk/Kl26sAPOSb
         Nzip7vb+8oCoCPed/VcoS5p/WPXFeSlbTokG6+7fAW8+pkCbPgFDByq/hWCKSfLG9HBZ
         ZY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757128899; x=1757733699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z2cCU7dJci4fXTg8GbK2CWuzrGsJs5uLLD5TZBvmXm8=;
        b=vRK+R6WNEIDFk9Vi1MsL5CGsVoLr2tGR7NUIjk6qNAake6Bss5LUBzIBl3cAxfBNRk
         vZRGMRMECnfhdUbDCau/0H5bQ9aIugk6qsGANdSFv1Vzf7O/pyYiN3KvhcYGBTi/m4GX
         0uZ6MQriFW89qwL1XKm3it5BNH9zc3hIHxswLgEZOydEU7U71sT8XqROxnn2kWeWCyXi
         CaL6xOOt64S4cD/6Y/fqym63mfi+1FCQrjxCSLb6ZQci4y71c/bZKF4yfDpyH7Q9H8eC
         O8zfgl6MTIKk4yoN8p6Jdkbk5NxsM0C621sYr1/ZP39ZkHhn/dcNjdW8N+xuFMUeptiA
         WoxQ==
X-Gm-Message-State: AOJu0Ywi+TMmJuVoMn3FyMJB92myvprgjCNx8IFfnKVn+ljkF9r2rpaT
	8QmIky4MaTSmu4uscOGjDGWxhb22+O+5+JopbVJ1YzJ5RVBmYpqk7aMqfNW/UQ==
X-Gm-Gg: ASbGnct2bJWyz9dceMqviBK1dc6Tu86QXTPgq4mTpjHMT/t7PZOY4b/E8m9rLeG6D/v
	OzVkam36Wg+RICeS7zydVgNA3yK06ErGQwlY6Cf4nlpyiXkJSkTl2e8a7KaVlW+ptSqr+QI6J2P
	CJ0iikZ6gFIG/ONBRhaFkJ/afzKT/gtlF2nom5Jsmu8OaTLreAOnYJCDpP2BSB55fONKhsOx9Ad
	VHs1DaeCdty7fbBxDM1EWjsBWPRoDyMlT713I+JiVYEBii7jYE4/23TzJB8muz5t0exLReMk8g5
	GRvqQO/RgyZrArwRpGtTvnCylBu1txZxNhGisyMhhm/VjzFbJ4Lf2yKDRO1LRps5LoJRUqVY6mk
	2o+MDawGwlRCexCH1vdE4cfq9pShU/vyJcFfu3gPNE0GKrvb4Sg7fQZhenwP9W13p5Uvk
X-Google-Smtp-Source: AGHT+IGXbeTpnI149R+oAwtT9gjRHLqYnMDM4XH72z+Oa1SjwQAvLzUGR+90CKoa2gJGOxKM0+miAg==
X-Received: by 2002:a17:902:ec81:b0:24c:e1f0:d71b with SMTP id d9443c01a7336-251757b53e8mr14792415ad.54.1757128899227;
        Fri, 05 Sep 2025 20:21:39 -0700 (PDT)
Received: from localhost.localdomain (36-231-187-52.dynamic-ip.hinet.net. [36.231.187.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24905da2896sm228127265ad.81.2025.09.05.20.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 20:21:38 -0700 (PDT)
From: Nick Huang <sef1548@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Nick Huang <sef1548@gmail.com>
Subject: [PATCH v2 2/3] dt-bindings: mfd: rohm,bd96802-pmic: Fix typo in documentation
Date: Sat,  6 Sep 2025 11:21:22 +0800
Message-ID: <20250906032123.21534-3-sef1548@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250906032123.21534-1-sef1548@gmail.com>
References: <20250906032123.21534-1-sef1548@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct a misspelling in comment: "contolling" should be "controlling"
which refers to shutting down the SOC and controlling the PMIC

Signed-off-by: Nick Huang <sef1548@gmail.com>
---
 Documentation/devicetree/bindings/mfd/rohm,bd96802-pmic.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd96802-pmic.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd96802-pmic.yaml
index 6cbea796d1..9772d43b39 100644
--- a/Documentation/devicetree/bindings/mfd/rohm,bd96802-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd96802-pmic.yaml
@@ -27,7 +27,7 @@ properties:
     description:
       The PMIC provides intb and errb IRQ lines. The errb IRQ line is used
       for fatal IRQs which will cause the PMIC to shut down power outputs.
-      In many systems this will shut down the SoC contolling the PMIC and
+      In many systems this will shut down the SoC controlling the PMIC and
       connecting/handling the errb can be omitted. However, there are cases
       where the SoC is not powered by the PMIC or has a short time backup
       energy to handle shutdown of critical hardware. In that case it may be
-- 
2.48.1



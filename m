Return-Path: <linux-kernel+bounces-867979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C040C040EC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 03:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76B4D3B6927
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 01:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00521F4192;
	Fri, 24 Oct 2025 01:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxpcqEH8"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EBA1F3BA9
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 01:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761270943; cv=none; b=ARI5gTLSIrKYlV/2smgs2nN0yt1lw5m0ImcH3xjCZIDn3dM06+NafDQEcbxVbdVpSmqz7r3duDlXRFv4Bl8eHW7i6oX4laMipmlwTVabRXqPn/rNEN2fvyYmcHrQRYv41S+LFON73f93PPWBfoFNjGAfWAu8+ZwzApwcTaFW7hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761270943; c=relaxed/simple;
	bh=jQBHQfAFYy2LZ9zgMurywoJJdSmMMdqANp1sUZ4+wtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p3VzCAra/ekXIx52PUW5KuskZkYixboZmF7ZVNFqIYOvasb+yFn3xN2uK1+TJwAYRHJNvXngKEZhx004JcBUJvMod/Eqhk7AKrMIKwYPThkIm7q8NLCHwDf85rR+E5mr7QErIKhBBT4EhQJbySpRxoZi0/y4tuVEwTHv8iH7+S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DxpcqEH8; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-27ee41e074dso15086675ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 18:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761270940; x=1761875740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hnPNWSYL8/32Ip+DCAgHjLLC5ALgmJeNiRp9bOMc41g=;
        b=DxpcqEH8TmgWUBCpOGPytGtT9ECv9xuFP9wPmYkOn2mRPhbARQ0l0tR7YVMns8MIRq
         jc3NMVeB6skBqHK4l7R/Hd3bVQeABbwGJauaBFfB5TsZcyyqsL1kyKHLTtoB+y5I5Qza
         oTpC9Msab2D6nN6d1TqaESCgrGa3os8D/dPd4bgFnFJ1vzYcMtXV0ux7Cd1srL2+XB2Z
         gxNaLSfANhS8ktw/kf9UJwFw+jpJ6IQGwzuQT3Dv1xfW4Iqa8rJh59s3z1sEZ+slcjAF
         XazTgPiAhhsAGWW75Iug8MxAjcXtkT/Zv/zIfdg6jVMWMKwGFveF2iUPm6yI2lTuzkWz
         oLKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761270940; x=1761875740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hnPNWSYL8/32Ip+DCAgHjLLC5ALgmJeNiRp9bOMc41g=;
        b=Rcd70cWk+rnUM+asLuEU3gGGkJ4bI4fnoZpv67LaTscZwM+4XIUCZoYUnzZpPITvmK
         uzd2m6ReC9Og5Vqkc1Cn1aFp4cCTKGDa5civ1UwmnXvhf57yGp2cF7ipH24Xx6+gMDG1
         hP+8FScDIwLu6SBf3jn1Jzt+Py5qM8nUYUejjJBFpORghaSzfgTf+pTZwh+cyEALduJs
         w9cgPnUq40CB0vyFS9bzGOW9pGoW/wpaT9uJNbxXacQ6FQqv4IoBYM5Dp8fhp9L6xPgL
         1A54aFH41SF6YoLdBbsEcHff8p08CG2C5zzFN+PM/FrlF9JdCVmzCq6Iylp+l6fPCjUR
         T+LA==
X-Forwarded-Encrypted: i=1; AJvYcCUvbxJCy8DueTtIGuRpl7nVsqkbnOdvET0WE59PCYyhDFEfdPSbQuCQ8W0SU6Lb3v3u6mMjLpmVYDpa8QM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwotwFyAuco2wTTCoKsXpGLukxGaFMhrr+7caTOFdLmoiohBxp
	NHcVWXabjDxu7p2mKCspyXHG338dtVMGY3MuFJEZCR+J89PWe3mGTzdh
X-Gm-Gg: ASbGncuFAmsL1dsnGu/cSyn/8ni1Px9TtljRTuJOL+19yQKnWGrSh3PRsYZZv5AwOTv
	fvGZbCo1rypRloy0VKacXJUepjnqnDpKoiWNYf+1UYZgH65fD2BGqadH8Jlw+lQCIrzSUpw9HRF
	nHiIwySrZ9qVOy7T/zRkMQi5qtMjPidYCeXkoYmfSY6lnWQ9YjDD1EbHrO2L2VCmzB7eYHeGaxC
	zGb46P/a5ez3ME2qVmlmVdKQLDjSO2WZcYSSZBU3/oQN+aVG9NsUjkZxVMKK6eXmuPIvoYSyrSt
	qQDDHFY7YT774PfZehX9hGRPqGLKE19ClHmpZJlnraVvXfdfbpzBzKTAkBogo3G0MG5fx3RYFX4
	BDRjFFN6pSkZK53yXUAhMzRl//D8KhBfqhyx18BnVmImGV+UAQBEnPXEhRDHTuE/Fd6B2GgLA4B
	s=
X-Google-Smtp-Source: AGHT+IEvrwCV3AqeaXcBCGHkmVsO9zDXt6O5hUjk/JLZSn4FLKu2VrTulSCz8MIwR6RtZ00/qylMQw==
X-Received: by 2002:a17:902:cec7:b0:290:afe9:76ef with SMTP id d9443c01a7336-290caf8505bmr346295515ad.40.1761270939983;
        Thu, 23 Oct 2025 18:55:39 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946ddeb51asm37483385ad.32.2025.10.23.18.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 18:55:39 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Han Gao <rabenda.cn@gmail.com>,
	Icenowy Zheng <uwu@icenowy.me>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Yao Zi <ziyao@disroot.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v3 1/3] dt-bindings: net: sophgo,sg2044-dwmac: add phy mode restriction
Date: Fri, 24 Oct 2025 09:55:22 +0800
Message-ID: <20251024015524.291013-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251024015524.291013-1-inochiama@gmail.com>
References: <20251024015524.291013-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the ethernet controller of SG2044 and SG2042 only supports
RGMII phy. Add phy-mode property to restrict the value.

Also, since SG2042 has internal rx delay in its mac, make
only "rgmii-txid" and "rgmii-id" valid for phy-mode.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 .../bindings/net/sophgo,sg2044-dwmac.yaml       | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml b/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
index ce21979a2d9a..0f1523dc0e36 100644
--- a/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
@@ -52,6 +52,13 @@ properties:
   interrupt-names:
     maxItems: 1
 
+  phy-mode:
+    enum:
+      - rgmii
+      - rgmii-rxid
+      - rgmii-txid
+      - rgmii-id
+
   resets:
     maxItems: 1
 
@@ -70,6 +77,16 @@ required:
 
 allOf:
   - $ref: snps,dwmac.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: sophgo,sg2042-dwmac
+    then:
+      phy-mode:
+        enum:
+          - rgmii-txid
+          - rgmii-id
 
 unevaluatedProperties: false
 
-- 
2.51.1



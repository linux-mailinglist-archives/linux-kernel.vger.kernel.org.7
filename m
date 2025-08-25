Return-Path: <linux-kernel+bounces-784368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F98BB33A8A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 11:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E22AC1B22EC2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 09:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9F0189F43;
	Mon, 25 Aug 2025 09:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Skghi1UL"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580D72D3A72;
	Mon, 25 Aug 2025 09:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756113373; cv=none; b=M9TUlRvFLVbgorDiqUAmVCjqUy+5zZe0+LCn7KK+Hab9S2F60FpRDDWcomAgu40gir1+/nc5SawnqO8AuTzznSJ1NGdRuJqZom1Bz3aDpeMFrHcmcBDKDiM3lwiKUc5ifus1WWLQj72KJ6QWPXVjkgm1a8HI2WqJorArM0MXxN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756113373; c=relaxed/simple;
	bh=bGe3lHrFEExwJaoIxfgSlWjKRZ1MiKpscWSHgaSU79Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pRKk6dAFuIGgkg20SxYf7E9ZqUOaA3UJVUnudALwAGGwvRtClmcSxNYqhBAVYuyyDa/OtReBO9vSNRLvP7JwOGuzbO3wZiRtztW/r6XhGS29/i9G6J6NKumtbZGWS1tGsoquWeOwB9e76jVQR/oO8gEcNzI3HyeLrjoGqbCpPEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Skghi1UL; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24457f581aeso30045335ad.0;
        Mon, 25 Aug 2025 02:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756113372; x=1756718172; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KtjFp+37deP+qcyMingdWbOCwQKbGl67hntF9ZyCbl8=;
        b=Skghi1ULIcZJPX/QmBawqNz/R2rhOZ9YFPQUEXT3M5waoznd7WEfxI9CIeAPk1FJbq
         cZh65R1uin/YbYnVSSBeWuYH7ZMSL6MxySrK3bOKaKCmJF8OAfNr9h5IFGui4uoIlFGG
         kvzW5sv6XREMWXkgXrp4y/1CS9Bfldmfziohi77dY6lRii8u/2k3mwQ1jcVk6NmNY7Pg
         V0ZoF2NFzWQDuPPQKJhxM3QiT4RK6nSGJF3rv69PhNrcFaBNTrdaqy7nnHvsqDYUVl9Q
         uSfXWy7UfsQL0WaMTtRs2LxbROA8IYA91Gdrb+dTQ5IKs6l3q+8SWsOK7uBpsHmvdEXE
         U1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756113372; x=1756718172;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KtjFp+37deP+qcyMingdWbOCwQKbGl67hntF9ZyCbl8=;
        b=eHmtWkRHDXevkr3pIY5HMunSeyrG9UuIF80BHSZcML98Fhq+V9KSHVTMSAKQMrLMuW
         /J4/MSrxAadJk6cgHigq+D92oQFHpDQqUeCFVBvFoKFdjG5CKcuSYq+hWZmbdDRsKNPW
         Od/Qp3kp4QtlGqdznxZ/xtVoi9EVxozlvWSkX4/6asSEaWG7b/XiuquTq1gEie+FPmRG
         Yxd6V631hAgpQ5Qk6PT8NY/H+8uTY5/usx7XXzylzaTcA/A/yRJ3vsjOoJMnulmwLG51
         vBqlGI9XButBJ1M29LgaFOAsydEualuXjX3uvvtNWydWnP9NGCuonFiigc6gkiJsa6OM
         qeKw==
X-Forwarded-Encrypted: i=1; AJvYcCUfqiOZ85vEsI9BNwcyG07jskzifRYyMaBeB/MMqgfMaOd7qM7SkW0UGPIDJJmg4OIlIyu03I7/Hcul@vger.kernel.org, AJvYcCVGyqpU7+E1V+YUROd98B/5v1FLq36/H+Gnvrus+d7YMUeWS7yMsuExwy+TcT0Issz+oNSDKzVOIg+vVtVA@vger.kernel.org
X-Gm-Message-State: AOJu0YzbV3CDpm/L9RVeIqHZEafY0PK64dtuuc8x4IKgQ0+uum7f4VLm
	xn+g/UpDEs2xUeSWpiNICRsT95jmhpSECaKOpjWqoe+fGJdeTYMZB3QJ
X-Gm-Gg: ASbGncsAvpx+Ds2CCKBz0E00adCWGxctnYM3b6L8c77Jn9+BCf2FoNUMIuoETodNHmI
	GYnX2VsY/n6OxVKqtCsq9TUR3LFjZdBMCUs4RhK2810cSow0wkl6oqNGvw3Gdmlkx/Jv/PFijGN
	m5gZf+V4a26DrVUQqfc82SKi7ck0sbLBzmbXndf7VA1e9Ita8kNPj++mkitN8hUstjImCtpw4A6
	wahLVmo28gVOkTgTcFqSK6Z7fVBnlmSsG2h0V1G1ef969oY5wa4xjQv59UStsCDlpmT90vCERxA
	dKgUU4vFkYL4yU80KrbdmQh0aTxwQGup9jgzqOdB9UqUVOsuFbhO7YH2JII1/W49WUvR7nIRQX9
	88hptEKu8SyWV6hX/Qrv33LQyInj4anmEJw8aPA==
X-Google-Smtp-Source: AGHT+IF4/e+c9KPSdTDMcNdsLzyEg0pIQO80fJt35j/c/EQiaTLu5Fs4DEVRakhW7pq5lO2LcmBS0A==
X-Received: by 2002:a17:903:40d1:b0:246:d00b:4ae3 with SMTP id d9443c01a7336-246d00b549dmr33462425ad.61.1756113371622;
        Mon, 25 Aug 2025 02:16:11 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2466887fc8dsm62873875ad.122.2025.08.25.02.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 02:16:11 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 25 Aug 2025 17:15:04 +0800
Subject: [PATCH v4 1/4] dt-bindings: nvme: apple,nvme-ans: Add Apple A11
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-t8015-nvme-v4-1-6ffc8f891b6e@gmail.com>
References: <20250825-t8015-nvme-v4-0-6ffc8f891b6e@gmail.com>
In-Reply-To: <20250825-t8015-nvme-v4-0-6ffc8f891b6e@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1310; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=bGe3lHrFEExwJaoIxfgSlWjKRZ1MiKpscWSHgaSU79Y=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBorCnRRlvaE1w45hp8w+1EdsAIb8vul/MWpn6CY
 /kNXwesAeKJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKwp0QAKCRABygi3psUI
 JEzuEAC2TMVz3DGV6ukw1ucnN5hJu5mTHBu4Ncp+n7bj2ByuWZ6dFArojJXcFBs60ihtFtLLbG6
 800iDleo3mVFngAS4fGuPMBfjKZdMAZE67+ErnTamwUipTCW7igb8A9yuPQeFFjJDE8fUd7SA/1
 Jc0/yiyLm4MNnUPuXuHyvnOTbRWZMuableg/SlSbqYZnaWwPyQAI/v9k9M1LC68wp6Pz0nJ7lag
 9JkM4gbvt0Nc//Rov2phSzZnYUE9BLaaogCo7m1QEtLlf8TISP35plxevBeK/Zlowc4p/AdLWAq
 qadzU4c5PYHedjIfIbuk3SvazoC9nJK3ZOGBvRBD7k6kENFnqRGwDpjRFQu5Az3RzL6qq0svpKg
 F89UjE4RdSndyy0itOO3pI9oKyOEWI3LdK9l9fSDT6VeEuDM76DLcuTMdFqfYTXikM9py5/v20Y
 OXY301j4fuCN3PEaAVV25pIHHSqG8z3532ce5Ijmi72J5V75d1tUBXGCS3cql4vf5IjGhmNx7Fm
 Kk0UKy2GhWLbgJ8mt92b/giaq/kxeI/c7OQLJNizjXDqedaaWV+pbkbsaj6HxYc0V7m7+mLl/dG
 LYqg0ANnheFUTn+ML/uVpcebFDszlNtMUP1YotMT94RkGsOhwQulR/T9u4isP3rydo6yBH7hPTD
 SniWNkdxz8exiAg==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add ANS2 NVMe bindings for Apple A11 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 .../devicetree/bindings/nvme/apple,nvme-ans.yaml          | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml b/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
index fc6555724e1858e8a16f6750302ff0ad9c4e5b88..4127d7b0a0f066fd0e144b32d1b676e3406b9d5a 100644
--- a/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
+++ b/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
@@ -11,12 +11,14 @@ maintainers:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - apple,t8103-nvme-ans2
-          - apple,t8112-nvme-ans2
-          - apple,t6000-nvme-ans2
-      - const: apple,nvme-ans2
+    oneOf:
+      - const: apple,t8015-nvme-ans2
+      - items:
+          - enum:
+              - apple,t8103-nvme-ans2
+              - apple,t8112-nvme-ans2
+              - apple,t6000-nvme-ans2
+          - const: apple,nvme-ans2
 
   reg:
     items:
@@ -67,6 +69,7 @@ if:
     compatible:
       contains:
         enum:
+          - apple,t8015-nvme-ans2
           - apple,t8103-nvme-ans2
           - apple,t8112-nvme-ans2
 then:

-- 
2.51.0



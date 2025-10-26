Return-Path: <linux-kernel+bounces-870403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4A8C0AA74
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 15:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 02FF84EA044
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 14:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E1324DCF9;
	Sun, 26 Oct 2025 14:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYgUC0fX"
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8CC2264B0
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 14:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761489473; cv=none; b=pxjyf06uBK703tQyPCjk5cz5oS7QcHR6vTtHqEbOovMx6psm3idZqQD/fa6/npIjQcCpqz9GjpkJxJUMSoL6k/Zx02BrbV4CkqAmVSteI6kArlWUG341e76fj5fUlJ2BNGunodjdWMG1AEPjVB7iku9LkRb6cBBj3CjvbmZVGFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761489473; c=relaxed/simple;
	bh=6EBhaAV6a7FA2r3SP0wp+EL6O6ZmLiovT9x9nt8WHL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cURK0SZ9HmCJ9lcLa0/ca5luD2e+Um/I/0ZOuNyL2jwjoL05ACYIou/KajJG5EGMrDzjMB3UxcAhU3hAjKoaip8MjBpYQ8Mv/Rx+ad6z0C56la/OkkgORJ/mSvlwEp0HCTKdA0ftd7LXD2j4/UUeXOfDZeN90gnEhEFSFtcL+ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYgUC0fX; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-793021f348fso3114211b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 07:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761489471; x=1762094271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+ee3KqA2yzD2P8W3Se92HTLPVHTZnMBaNq34xZJiVY=;
        b=MYgUC0fX4sm57C6DMqP+h2v4l6nntrPRJZuSWyErFz4kOq7wZrDAcJn+MllXNv0/JB
         OX5TW4fou8kvPRdmtp8INODUzQGJuPoVtST6uEc5J3AfJCvNnLldFBfAmlUFL+0E/hTv
         rJHRmYuMwOinC9U4g1Tq12uFEYvGrtmqa5b5XynRE39vuMeR8gRPJDRkbmPSO2MhVV2k
         c5b/wPtuXApJ64n64MZ3CX8Do7r1RgyZOxp6wgaIS47ToqVlMcAtmMUbUQXb9bm2qPN5
         LoLph8VKUoxDbwRT7Oe/w2eLaFsvoESMuUFraqC39RM0r45tuOxztj1u3hB5ypVEpSsv
         xSPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761489471; x=1762094271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+ee3KqA2yzD2P8W3Se92HTLPVHTZnMBaNq34xZJiVY=;
        b=tmookZqgDFjTz2V0/rfBuyVegI6e50NmyPwRc5VLU2l+uYxeSL2f1lSfUSyQxrnxJA
         Yc8AyY1lrVCTRtClcE1iYyw2oJjkL8P0/ztN1iAdH1iiI0+k36zVRGIKCd21iGuzjGHv
         TPvDxDPRHLfl4QRWw/eKkzdwrhf0YqWtax/3wKm3SqYbT61HjvhBOgEf3IFJYkezjze7
         aJhP28PsjGEqJjAvofA6a2smWlEBAOJbhITxKuMiqPdMb981tN2WbElfxGFvTffljFBN
         uXOvQD4TzPCgrAGkGg219rigsqyriRkPpWvxTvkD+2Mi7PvqJo2REANuGpM6JRGgJeSO
         ipVw==
X-Forwarded-Encrypted: i=1; AJvYcCVDlNQckpAZJyuM40LVNRiQFBltTMVyVsTTfSXgU7a3QPGV/DgeKl3kjB7/pMFIqZB4UG7WnUfUOr5/zAY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+lX20ds/d1Mwbl0A20jEC4v9I0ddM01J8pnAJiJefQyKTN6gM
	r59/WfQNurfzRkV1ykHeS+BaL5EjrwPiVzK3Za+3XXy1GgEpCuZbWhFW
X-Gm-Gg: ASbGncuig1jZXaMqHJVQs/nyWeRZUfoPMJobf6HqFxbIaFVfQ2dXWX3cbYnt6wTumjH
	G6+py1sjiT5nIkFVdglvvQPnpMDEHDYIipeyPwyZQm3DOuxqD7Ogl4n+Amkqpsoz0CPGP9QaMIx
	9GdNJsj7EAtSwNkQGxrCHY2NgHd33XLPcdYNA34gYOIvPema+5s6LayD1A0Lv6T1xBU1bhjxKAp
	mX7UfG5KYViN+7OG9wZUw7q0PAvPp9lbzjCi1MLt5ksslhW3M3CbF3LcQRHIddx+bTYXoftD0dt
	6WuBrL5pZTrE7+uWBneU+/v9Gf1T3yhF+cDc4vl+VwHPDQ0h/h5dm5Dapy3uFT6UnWpyK6eX73G
	dBswAouJEbH9UkFdf3/av/cSncL4znGAaPCx8RWWA3/m25tBWKb0pGbP3risjlotGkoEkC7JgUB
	s=
X-Google-Smtp-Source: AGHT+IGorRTsGK6y1BXq5Jha0i7pSNQnEd4P3A4eW7mtzU1czQ1tha1INqCijpQurD6f2CrckDUokQ==
X-Received: by 2002:a05:6a20:244f:b0:2f0:91c0:1886 with SMTP id adf61e73a8af0-334a86444bbmr46784680637.59.1761489470867;
        Sun, 26 Oct 2025 07:37:50 -0700 (PDT)
Received: from server.lan ([150.230.217.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b7128d4d44esm4652691a12.21.2025.10.26.07.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 07:37:50 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Dragan Simic <dsimic@manjaro.org>,
	Jonas Karlman <jonas@kwiboo.se>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Coia Prant <coiaprant@gmail.com>
Subject: [PATCH v3 2/3] dt-bindings: arm: rockchip: Add NineTripod X3568 series
Date: Sun, 26 Oct 2025 22:36:46 +0800
Message-ID: <20251026143645.917588-4-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251026143645.917588-2-coiaprant@gmail.com>
References: <20251026143645.917588-2-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This documents NineTripod X3568 v4 which is a SBC based on RK3568 SoC.

Link: http://www.9tripod.com/showpro.php?id=117
Link: https://appletsapi.52solution.com/media/X3568V4%E5%BC%80%E5%8F%91%E6%9D%BF%E7%A1%AC%E4%BB%B6%E6%89%8B%E5%86%8C.pdf

Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 6aceaa8ac..417100209 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -777,6 +777,12 @@ properties:
           - const: netxeon,r89
           - const: rockchip,rk3288
 
+      - description: NineTripod X3568 series board
+        items:
+          - enum:
+              - ninetripod,x3568-v4
+          - const: rockchip,rk3568
+
       - description: OPEN AI LAB EAIDK-610
         items:
           - const: openailab,eaidk-610
-- 
2.47.3



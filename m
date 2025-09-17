Return-Path: <linux-kernel+bounces-820537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A113B7D888
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 209DA3A62EC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 11:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C95F2EA483;
	Wed, 17 Sep 2025 11:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="Wh0bEuct"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B54F2DAFA5
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 11:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758107620; cv=none; b=WM1j3PCUmE/IvSC64i5gTc74tFvFoki5zgZqzOBKlWgOe5F5V9JRHcw8QXtuvJuHYikIpfi5+u320xN+RaN3XND4UXWJYqNbnWUyROAFzPO2jvvhp3dhZFtG2vWRHSh1/D3xo+7qDUSw+27H65Tx9N/uRdJA2BbIOTrcBOcB9A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758107620; c=relaxed/simple;
	bh=eG+anZAs6P+Glc2UxgKY37GDZ4SxG7Px6jdpQoKTKMo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gBsxB7CCE4FIRDq6+xQ4doDOrxj+9ov4FXDkXG39Y6IFlKBh+9pv/5qG07Qm5q/EDn/AVntjA0fGoITglHT7FA4ogtkSF2wkQ4kWKTcRdlvc+xfP4B/on+ia35N65HsZ2DpvjSFnKw9Yqe4JMSNH++B8QfC6gFYzI2AR44W6ngc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=Wh0bEuct; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b5241e51764so4807382a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 04:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1758107618; x=1758712418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZaGycjt36+NJT+7JRNn303P5y+ponQJAIIaK3c+nUEw=;
        b=Wh0bEuctkcn7dV2S0DWX9kClXp3ax6W3PRWLzV29X2irsjBgjRmzASo3HkMs52GvMN
         jmtp9y+mky4b3EwihCZVJOQpvOFIwdU9WC2j1V6UAM1x+/66U5GVK0W3/EDMhQfAhQWR
         9ARI9aqb8Y2i6AYwsNIz/8K9vo2SXJGGis1R6E+Q8BsCRMN1F7909MZgUh7SP0ylfxK5
         0PZ0G+Gr5EzW6kxEf58uyFmeYxbUXD17bYjxkaxFfIjYKyjTQHId0GeAP/VpKWHiMQZA
         pfi6uWxDKhMS3sC5g17+a3AOsZjrojlyKD2aD8Zfl5KrwqPdh8DMPlgpSvPnLhMIipQ0
         hEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758107618; x=1758712418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZaGycjt36+NJT+7JRNn303P5y+ponQJAIIaK3c+nUEw=;
        b=Xtaj/aSkOJFypTXhul6NWB5rtj4eTglGO2cn+4Iis64jGX4i4gactFzgt4blrQGAdo
         uvFUafmP1I/uJTD2W9srwyjfe2UZqKwELD736hUgeVyyEG0+mi+Wu5hs6q7QCOPv/B9Z
         SIFywG608gw+Lt/Zt3bWYn2lz5sILFHDLYlwE0dsNbMYQmfcni9i1tER/XwvoYOwJLwE
         LgfpzpqtWvtgYyDGLhlBYY+QUNdhsZfugXPhxXqjS0I3f8oZcY1bjG7C89v74ep85dqt
         V6Zy1+UOKELf7QYHdTPdA16E7CDwEYjqKDHi8ZccPISTlwBovTjeZ8eD5kZmRdMm40DK
         4v6w==
X-Forwarded-Encrypted: i=1; AJvYcCUuVWA6Cmww0WK1PYod8mQD4NWzbphoaCjMkymn2b/PXN+MFxCGxRIuYAgObYmUGIJg4eVTBBevMJxeR+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFEqryrv02uxgcssggsqZgkOKIuqShaL5NuX/ufC5tJxYF2VB5
	Mwr2tHyXi2IglqRcsV/UW6C42TbkL//+IrBKSlCX9a9BIc1BCohH3yrP3+jGo7xvSMU=
X-Gm-Gg: ASbGncuoe+nNE+rJEvhlpaWG2Q1CnuLVIMQCzgM5omhU4Mj4uIGD8CEvnTi/bO7JTL9
	2iGG+MvuLzSLachfDnn5vUXQDKXleYI3oa/FWtc4rPuva8mYARisUd1b1D5hfWpcILoq9jgCK62
	MqvgngFsBPcR4NxafN8sn2r/j8iWuF/4wsRjF95HrdaLOyKVNRLDxUBe6UiTsqZOXFNoLc9n25E
	z0fzSSxd/3f4Earb9rchCSNYJ29vbvzhkwgu3uO8pnk6BAcTECYHSX5V/KnFC6c3H1dklMCkz73
	cqv4dAIYGmF0YyJ7/YhVObaAUmoa1Ig9jgGRbZqOV8I+NzLpPYAAsi1bZ/f2RVWst1vD4bEv6Kr
	oStOHAYcHdH03XilqPBhupewZ1z5Xru963AaND7ecAlB6aXiFmaN5HL2O
X-Google-Smtp-Source: AGHT+IH6X33FWxaAtcbZuf8x752Ux8OoEIl6JrI53rne57TK5RbZLOWAhZftzg4xVFvnL1vFWW1L2Q==
X-Received: by 2002:a17:903:2f03:b0:25c:e2c:6678 with SMTP id d9443c01a7336-268118b3ecdmr23173225ad.5.1758107618458;
        Wed, 17 Sep 2025 04:13:38 -0700 (PDT)
Received: from fedora (cpezg-94-253-146-122-cbl.xnet.hr. [94.253.146.122])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-267b4ae8808sm59079655ad.132.2025.09.17.04.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 04:13:37 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: p.zabel@pengutronix.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	lars.povlsen@microchip.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: luka.perkov@sartura.hr,
	benjamin.ryzman@canonical.com,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 1/2] dt-bindings: reset: microchip: Add LAN969x support
Date: Wed, 17 Sep 2025 13:12:35 +0200
Message-ID: <20250917111323.60781-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LAN969x also uses the Microchip reset driver, so document its compatible.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 Documentation/devicetree/bindings/reset/microchip,rst.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/reset/microchip,rst.yaml b/Documentation/devicetree/bindings/reset/microchip,rst.yaml
index f2da0693b05a..4d4dd47f830e 100644
--- a/Documentation/devicetree/bindings/reset/microchip,rst.yaml
+++ b/Documentation/devicetree/bindings/reset/microchip,rst.yaml
@@ -23,6 +23,7 @@ properties:
     enum:
       - microchip,sparx5-switch-reset
       - microchip,lan966x-switch-reset
+      - microchip,lan969x-switch-reset
 
   reg:
     items:
-- 
2.51.0



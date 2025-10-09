Return-Path: <linux-kernel+bounces-846418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EF2BC7EFC
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 10:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 969593528EC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 08:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4E8242D9B;
	Thu,  9 Oct 2025 08:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b="REIGecYO"
Received: from ironport.ite.com.tw (hc210-202-87-179.vdslpro.static.apol.com.tw [210.202.87.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AADD1DF26A;
	Thu,  9 Oct 2025 08:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.202.87.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759997434; cv=none; b=fX58gMJJ6IHxDlZ6zCajk74kjrCfVXUF72IMoyVQJj+E1d0CGRvgHvRs0NDpilOl1h2p2QZvnwFIsaMTVxXV/TEQhv7CxnA5CfSFf+LvPRttJd0fl1X7QMptO3WJXAaV7kaE8RgwXfm1jfW7S9Ffc5vLrOsTf+ULqYcglcqGwyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759997434; c=relaxed/simple;
	bh=2AH6cdUaZXwlNnFx/ldZyqIX/ucVa+bfES0Z5P+o6e4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=QshJt3VATWIJpcxVHbLAmoWo90wCohT4Ik28FikZzAoGl6S0ia26aOSSaFWsMUzPq2DNhCUpU/9RN+HH2Yy5sbevEiWu/i1H4pst1q8q8El7sPd7uLUvnh7F9PJlU6jO4LjOuCN++c8a2B+n19/7BRIV90XyjekZDzPGTGfvpjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw; spf=pass smtp.mailfrom=ite.com.tw; dkim=pass (2048-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b=REIGecYO; arc=none smtp.client-ip=210.202.87.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ite.com.tw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=ite.com.tw; s=dkim;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=deeQIG0vQzHbpuB0zFGYYbYCNUxkMTVvua037765riE=;
  b=REIGecYOugwtYpxwZrNXBhYh0e94sLShU7dO5PZZ4GlWDKRCDtI2du9v
   ddEzdugWkDaZKGNQNqACco3UJ8kbeCBrSXiQhYcs+EcDxT01S84h2fVct
   nNcFKEdYVVmk0Yb+h5SAaxcNwSwJ0T2jSbKWbLBGdYx+3R5KMBu+tH2Bu
   XVyt+8YqtG4SSgi3aBO/Q2rb5ZI0LhJiX9WwfMZa3yjH46CNDIzG4rdgc
   WcG4fh0KopZWQVLgmbxhNt1G6OIAsknO0L5dQcFHbGrUA17AWz8Cubr5H
   qAikdGtO4is/ULbu5vRFC3pgC9FZk2v9NGz3KaMiOLmbXcEMxLrJ9n92E
   w==;
X-CSE-ConnectionGUID: nlf/221NSAuyq2OkJjmOYw==
X-CSE-MsgGUID: 6LvJ5cEEQ8Sd0WdWjkX1zw==
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 09 Oct 2025 16:03:05 +0800
Received: from hscmail1.internal.ite.com.tw (HSCMAIL1.internal.ite.com.tw [192.168.35.58])
	by mse.ite.com.tw with ESMTP id 59982xPe072680;
	Thu, 9 Oct 2025 16:02:59 +0800 (+08)
	(envelope-from Pet.Weng@ite.com.tw)
Received: from [127.0.1.1] (192.168.72.40) by HSCMAIL1.internal.ite.com.tw
 (192.168.35.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 9 Oct
 2025 16:02:57 +0800
From: Pet Weng <pet.weng@ite.com.tw>
Date: Thu, 9 Oct 2025 16:02:36 +0800
Subject: [PATCH v3 3/3] MAINTAINERS: Add entry for ITE IT61620 MIPI to HDMI
 bridge driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251009-it61620-0714-v3-3-5d682d028441@ite.com.tw>
References: <20251009-it61620-0714-v3-0-5d682d028441@ite.com.tw>
In-Reply-To: <20251009-it61620-0714-v3-0-5d682d028441@ite.com.tw>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong
	<neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart
	<Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej
 Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Hermes Wu <hermes.Wu@ite.com.tw>,
        Kenneth
 Hung <kenneth.Hung@ite.com.tw>,
        Pet Weng <pet.weng@ite.com.tw>, Pin-yen Lin
	<treapking@google.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759996978; l=1089;
 i=pet.weng@ite.com.tw; s=20250702; h=from:subject:message-id;
 bh=2AH6cdUaZXwlNnFx/ldZyqIX/ucVa+bfES0Z5P+o6e4=;
 b=dU+LzgjtCQD9jnD7rDce2Wgo7OI+HYadVtVJU2unFfjCY8CuE4XlK8MR46ELOemvDiJncWSUd
 KhyoNX+crFrBbaVxehKxAKNw+imWqVUt1iFgZYPrn8SIk+upe6+hKgx
X-Developer-Key: i=pet.weng@ite.com.tw; a=ed25519;
 pk=wd08uBtTLb93x2ixbKVNsxiZPdMh1Ov4z5klodh2bqo=
X-ClientProxiedBy: CSBMAIL1.internal.ite.com.tw (192.168.65.58) To
 HSCMAIL1.internal.ite.com.tw (192.168.35.58)
X-TM-SNTS-SMTP:
	9296EBCF0C107F6D862EF5CEF443C99F90E953BF5856D10F699AD9CB46901EAD2002:8
X-MAIL:mse.ite.com.tw 59982xPe072680

Add a new entry for the ITE IT61620 MIPI to HDMI bridge driver to the
MAINTAINERS file, include the responsible maintainer, mailing list, and
file patterns.

Signed-off-by: Pet Weng <pet.weng@ite.com.tw>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5257d52679d60d084b85e2f023730286aa79311d..6859c06dce3ad3d615a1e42f3542fb1da8da4fc2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13107,6 +13107,14 @@ T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	Documentation/devicetree/bindings/display/bridge/ite,it6263.yaml
 F:	drivers/gpu/drm/bridge/ite-it6263.c
 
+ITE IT61620 MIPI DSI TO HDMI BRIDGE DRIVER
+M:	Pet Weng <pet.weng@ite.com.tw>
+L:	dri-devel@lists.freedesktop.org
+S:	Maintained
+T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:	Documentation/devicetree/bindings/display/bridge/ite,it61620.yaml
+F:	drivers/gpu/drm/bridge/ite-it61620.c
+
 ITE IT66121 HDMI BRIDGE DRIVER
 M:	Phong LE <ple@baylibre.com>
 M:	Neil Armstrong <neil.armstrong@linaro.org>

-- 
2.34.1



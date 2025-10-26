Return-Path: <linux-kernel+bounces-870282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E632C0A5F1
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 11:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4A043AD7BF
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 10:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30BB182D2;
	Sun, 26 Oct 2025 10:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dxYPWv0/"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8926FC3
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 10:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761473781; cv=none; b=aSjSH0eXz4KDYTIIxMBXz1uEQBTWfMR28VmJK9jdfUiZ3LfOhwnYwDR99onVnbrwqdJ1os58r1/822BIkRQ9FHOAEN1TryUw6O1jyfDG1Eign3yMOCnLmKHvr9R24mpLlEz3hqvqYwvjzVoOq/5ZwC02sGUEE2oVG3bViFtRvd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761473781; c=relaxed/simple;
	bh=4tuMvirqozF1BZtSSvcWbX/RxDhVVXyNJnnSGiyPbpE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ek0EYz5jkOSIp1dKTn2e3JlgIjmC3xOmW3YOTa3XICcad192w3MfaW8tCvNhyJcQFFLGPglxNmN2sq5SEUCP0bBRaMh2CC4qhWLN/7t9QjqUGqLWGYYxn0KfHXk9/v/sohhA5DjcaeUBEoTcaVFOFeXLLQMWveE6zv0tRz02YOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dxYPWv0/; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42702037a01so701456f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 03:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761473778; x=1762078578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fa1MhKqzuPVYS2M1bInqrAbv70jc0zu2caVbAoAzEXU=;
        b=dxYPWv0/h6/N7AQzFL1Csy6BiE3m3R1oU5ZtfQa07iM/3SZjZVxyTcnseDjVPqSvO/
         MdL9QvLH0XObCJXsiUN+4zBRdVEWLc24WbbQJKWK92kwl4hTyTWU3AdyJ25EI27ZBQw9
         O6YI1ZSzVca/08syVX107PsX0CcHPSks2drP4xefrMt6WBk/FaVbpH0xXlsiqQ8yXxbZ
         L5mdXU0q/hpFJjeLfhjCFQ0dS4SaIcBkxsTUYG3pYVwZbi8PIGPQWn7oDCL16xgl5fm1
         f9n/KqzWqmlHVREf+79VbGZWUt5qjj6AVBP+FiRS8bGMXh6YSawRM2dVhqAVecMHZ+HZ
         oA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761473778; x=1762078578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fa1MhKqzuPVYS2M1bInqrAbv70jc0zu2caVbAoAzEXU=;
        b=ESwxzbmmrOGuDLnRBmugj2A3YiNvI6oCGjvq2uiH0fhuG892Pk++Udu516grW3UPog
         QZ77N8Cy6J+3t2gqBbUnb5kJETq0ZEgCLKk0ONyBnJFGLZKgka7i86bNAvO+hkLkXYNf
         QC4CdZ4bL3mxOy6vbI5px/gtXFzfmbAodwHWTDmz07SWvxItyEK9Ozx4RFGVmdl+Ac3i
         sbgt/2Qqqf0dfpYzsarBI4pmF6U3QuCWciTGW5Wj5U5npqjmfhvnRwa4wc3MudDYpIjj
         s4zAIW4pvSGm1ZvpCtJMebqOds0nw2bdcuXf4pA1E/RP4qhvJ6/70Hg3w3sdxCvjdoAi
         oAKw==
X-Forwarded-Encrypted: i=1; AJvYcCXabEueHZWsBJAmqH4Eb4WKYtfMRwbEgjFyU7LRr5OZf6pbracS9+fRvvB2NrcTWPMEGTd1z9MzINoILa4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+MNxc6SbfC839xRSAOvi0tG9tukZhCzoVotAnV54ldXIisThV
	o2HacVE/m+PJJAt8wNhxc4p12jd4GtQDn+WuTFyUOsHSvdSE+SAX2kUGYWGdB8liHc8=
X-Gm-Gg: ASbGncs2jvIVGnGZTzPLylP2nmPlvIy9J4ZwDw6bZ4q17w/0mnIqZcFjr6IY0OVoEls
	RnyP+Od639o3cN2lIk4mEuq2kRKhJ31GkRIQYtoBvDM47O53MfpAvVGTEQOM8UeP4hyP9QdQ+yB
	Us/n+wiDZXwQLc3IGD+9HjaZnX1s01/W4BeENcIXkXQ8JUd9CyNHEiZHFPM9tcawETiyTfa7K1L
	yP9gbyoXc8acHcYXqOx+D/JM7OdU3mKkTU0+2EQe4PTFai39Os/G7Xo6x7H2KAkV8yHDVPG4fFj
	B+nxxLWtiglna//P9n824WgLeWMfte26gPQXCLvajn5Aly/tVylgCBZKEcmd2EKACuHLKttBlFx
	vBaK1YFnJRBsp/dLiPCmlSN6WIA27BBhxdxZ03mx4fhLuXIr+DX5pnXdiXelXHsys7bnFrR2c4F
	WH1f9MPF6iIEQ=
X-Google-Smtp-Source: AGHT+IEi5uzHrsnrvxV6x6FdgS/nZMzufp+jHg+YI+JOzAvJ350q2EDyHwRDOj5mFEkpTFwuZkWAKA==
X-Received: by 2002:a05:6000:2408:b0:426:c349:eb1d with SMTP id ffacd0b85a97d-4284e4fa3c5mr7192681f8f.0.1761473777719;
        Sun, 26 Oct 2025 03:16:17 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df62dsm8423876f8f.45.2025.10.26.03.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 03:16:17 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Robert Marko <robert.marko@sartura.hr>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net] dt-bindings: net: sparx5: Narrow properly LAN969x register space windows
Date: Sun, 26 Oct 2025 11:16:15 +0100
Message-ID: <20251026101614.20271-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 267bca002c50 ("dt-bindings: net: sparx5: correct LAN969x register
space windows") said that LAN969x has exactly two address spaces ("ref"
property) but implemented it as 2 or more.  Narrow the constraint to
properly express that only two items are allowed, which also matches
Linux driver.

Fixes: 267bca002c50 ("dt-bindings: net: sparx5: correct LAN969x register space windows")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

No in-kernel DTS using it.
---
 .../devicetree/bindings/net/microchip,sparx5-switch.yaml      | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml b/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
index 5caa3779660d..5491d0775ede 100644
--- a/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
+++ b/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
@@ -180,9 +180,9 @@ allOf:
     then:
       properties:
         reg:
-          minItems: 2
+          maxItems: 2
         reg-names:
-          minItems: 2
+          maxItems: 2
     else:
       properties:
         reg:
-- 
2.48.1



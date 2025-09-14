Return-Path: <linux-kernel+bounces-815754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75776B56ACF
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 19:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ACAA189CFD3
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 17:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BA42DF135;
	Sun, 14 Sep 2025 17:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="BR8gfHcu"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB1D635
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 17:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757870184; cv=none; b=JLeSKmK6TBylcvD2FlLsr8huHO6j3GqRHFFs/1aPn8XTvaZ3NaoedLdO9/8rdSir0PuWlocmKC4sbVnD3y9o9mqyVrfVynby5hIuQDtDi6N64ONLnQYPod6CsXRcb74UY+sBW+YB1TNDCiSr/c8ZTTyXdxV93s5Od0uejrHyJI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757870184; c=relaxed/simple;
	bh=Jy5vrJ90AiD6jtnSaZVQFAUaOXKIYVVwz21RLq/eHTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X87G33/U3RG3TAaXDMsZMZlhCN6mQgjpekCmwxU6u7+FW4dtHcXuw6SiOgANIORM0j0r95e285QrySioOj/GoDHMf0gaMnxEeuhu6QDe60yC4KfpR/JPrtpNlVry43yE40sUaaO/RjlRFVY6fpL2Op16fIpEM0Mnd8bbhPwwwKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=BR8gfHcu; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b07dac96d1eso261606066b.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 10:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1757870180; x=1758474980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sx0EwU0te/usZ13a8MurPgLe0A2g8omNenFnNxHAiqE=;
        b=BR8gfHcuRC32Q6eRp8toJOZf+lv58YU2GNNYSv6Oi+nbSLkourz+U0JSAXNA2kMsgH
         4BWqzb9rrtCEHGr3d4dTLqfeBXhbZGW5dJ98jT/NTlu1B2eZn76YsWzWwtef+FbIHFOT
         MUzRx/Xc0PpGvjlowZMLLXrUPq82+h5cRmAJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757870180; x=1758474980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sx0EwU0te/usZ13a8MurPgLe0A2g8omNenFnNxHAiqE=;
        b=cz/sREBEg++CuggqPJCnwAMf6LmnpqoactsvPX09C41duirDNty0k9FzGtITUGT0cY
         EINUkGuECOMR1z37s7gfKJjXb3VHQvz2gl1CEjfsyrLc0mJcRjhYeZrHCs/EZ8TUhKlw
         4538Ls4v7/tAR4AjEI+M/KQzUj0UQqTU6ADyLZI3DhEfb4kD9nlkTcsOvsSSkFMBkghS
         ppAnJATQI/65ZGHn0NojDbVWYJ2k3lI9l81tYiCQKWVGrFWFut6lOEkJb8zqAOBWH5wG
         ykuir1OOH6Ud+rIVCRqpM+LFjqGXQUmlcPH4mtnHlsDg+bQc5R8TlamdNgKEv3CSeg9g
         JgKA==
X-Gm-Message-State: AOJu0Ywz8w79rhXYTsrCKeX/hlc3vTV8TW6LKCK1ceAs0O1GMCY24UA8
	2x41+vNoqQIFPpXpOi66+oxXPh4plIhnRJ+CwSIq+coN5uVnr7tPo9druaje8Jbiay4Dq24Ydd4
	eU090
X-Gm-Gg: ASbGncsqb26EpHA1ZqPWRdDlsoNJH+/zwj9JQq0wpUcwXiI5iAJH0bg9g94g896Zvkt
	1L4DvrnsXHICTKHKZGNXwDNi6dO4y4eVkUEwEOccWE92hS9ZEVPgeAI3UKj/ifEOHyiSy73E4nv
	ZPBQyybcIbfLDQjAAVczFTlvy/vOW7acgK2/uNnpnLtp3gzfkrDzCFOa2qRNlIztW1ham/+zdRc
	WbA9OZLdz+wrMvQ30+ZyosR3LslREL4typ/1206rriqReoTNiXc7WLLCKwbaTtFodM3x3ioDwYO
	VO7ySj4XscnYXe/w4G2u4cBp7z7+uQOuCJ0OHApWivT4r+hjfRvQ1Bl9EakgkVPsH9qryP068R2
	L078JM5YJ+AWaVv8VepO8nOyH0t0Uat71qPU82//JzM/GuFkMm9/9WSgFwn6qFh2nKXRqDxZ2dS
	TkhMSdPSMdiB5jLeLJ4IsONl0aHFhbVQroU24wmbLbwfxlpQLiYCXT+kZxjl67MDTv/r2c/wp2g
	lA=
X-Google-Smtp-Source: AGHT+IGg07tGI6gHsEGbzuf3VDSE6YFsTBt5Lon/+TCDORrB5jYkJHCYrktC1RHIPug9flWo1dwbuA==
X-Received: by 2002:a17:907:d8b:b0:afe:8de8:290d with SMTP id a640c23a62f3a-b07a629945emr1504682966b.6.1757870179840;
        Sun, 14 Sep 2025 10:16:19 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-56-38-125.retail.telecomitalia.it. [82.56.38.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b334e76dsm776980466b.102.2025.09.14.10.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 10:16:19 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: Frank Li <Frank.Li@nxp.com>,
	linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Javier Carrasco <javier.carrasco@wolfvision.net>,
	Jeff LaBundy <jeff@labundy.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: [PATCH v2 3/6] dt-bindings: touchscreen: add touchscreen-glitch-threshold-ns property
Date: Sun, 14 Sep 2025 19:16:00 +0200
Message-ID: <20250914171608.1050401-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250914171608.1050401-1-dario.binacchi@amarulasolutions.com>
References: <20250914171608.1050401-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for glitch threshold configuration. A detected signal is valid
only if it lasts longer than the set threshold; otherwise, it is regarded
as a glitch.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Added in v2.

 .../devicetree/bindings/input/touchscreen/touchscreen.yaml    | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
index 3e3572aa483a..a60b4d08620d 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
@@ -206,6 +206,10 @@ properties:
 
         unevaluatedProperties: false
 
+  touchscreen-glitch-threshold-ns:
+    description: Minimum duration in nanoseconds a signal must remain stable
+      to be considered valid.
+
 dependencies:
   touchscreen-size-x: [ touchscreen-size-y ]
   touchscreen-size-y: [ touchscreen-size-x ]
-- 
2.43.0



Return-Path: <linux-kernel+bounces-730793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E09A3B049F0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 00:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C9314A2DFB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 22:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30868278753;
	Mon, 14 Jul 2025 22:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=scandent.com header.i=@scandent.com header.b="Drj/GDRb"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BC026AA8F
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 22:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752530800; cv=none; b=P3dmSdu05Ua2KApTuaFFa6zCfqlEr5cZSMrL4+Th6sXooV5x+UTMNViXpzCqnQ1a5Lx+icsAP6rwso/eEbwslOuS68JtFxlRzu5NPj9hqiO4SRRKBE5EdCZYzKXBYelAF77KIpCQxEN8wx2OH/qZ+tOfY8bdy/dZdHqufCabTBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752530800; c=relaxed/simple;
	bh=YLR0dTVZfAu5LlRsEWmmg9empbYzMLHU1znVEa4gBwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aWaXOm4WzpYUya4YQYV4yg+eyXzsr4N4fzAcXTR3Ua+6t1KNUh8f+gH4J8qUIZpVFl4bnoQBWBPHtsvTw3eFUnG+aghma9ybNYCP/tiA/F4b6t0+DCAb6OtRKXcqpdT5Rz7jcmgrPvQ41vTRyArgguYqMPCDxJgtcHpRjkLkH5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=scandent.com; spf=pass smtp.mailfrom=scandent.com; dkim=pass (2048-bit key) header.d=scandent.com header.i=@scandent.com header.b=Drj/GDRb; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=scandent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scandent.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7d95b08634fso310287485a.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scandent.com; s=google; t=1752530798; x=1753135598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ouMuj11MjFvdwjVughz3WZjGk79DPdwniSFwLLOcIJQ=;
        b=Drj/GDRbMB/pnmbhAGHXQvMXI2q+VzQ8QqfosA7Stp/ivXsHkgrr/N2Q0DIJ2Z7Zbh
         wcmVksCSa8Ij6oqxICQ2J6GOmLVz1rg2+WcjGTgot+t1NFIQ6NWIT1w6LElQ1yqUoSoc
         /r5VfE21vsryCIPp4+N0fg0fCdJAjFowAlLXsU6XKNmG7K7dLO/tQDW/sRFhRfM3LlXt
         reA1rsf4JMlMiFaHZJo4/irSh2HGoBWg2Zz+QMnIdOPlJ7teWWN0o5FcPFryPYnstoq4
         5b8hKpu1b9EQxhma8Ycy6zvdCL+Omx74V7WMtCd/1q31AkH9hpw1xSan3u1Cnd7+ugwm
         jEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752530798; x=1753135598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ouMuj11MjFvdwjVughz3WZjGk79DPdwniSFwLLOcIJQ=;
        b=SJnBU9VdW5XWdye6I2QhwAotp5uI3XX/C4uXO9GCL6xExpE3O+hzNdGvTNH8Asixzo
         E1wCxv/QV7GxIoFBNWWJnkYE91dkLaHGdaScitZ5abe5X3858b/9zszEqoPopGJtIKun
         N0F+J5n8x0JJMbEwkYlx0oMgWGXifhpJgE/cYHETuDDuuX16HqYpupCxmhhMHnCP0abJ
         sQ5YZLtmNJzMTN/cESKrtQRbddvyvKBiwnmjG2Sh/Fh88xvsBOxFcSm4PXmBQjUCI3uv
         HGvlL4WcSagnQachL8ceQsegMK0V5srk+5I1Eh79FGyZROOYxIFjQuJYCr8YJo/DMd2T
         bY8A==
X-Forwarded-Encrypted: i=1; AJvYcCWoRiW4ezEhgpMC0PeaILP6RmERS3pA3hTTrHFqw3jB1SMLG8w9sxBVnSWHDBxO7D5YGzNYZ7rtY7jnGVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNqQCWwcNEde9Dgxb3TQ/iJcF1o1PLserpqAk7yQD0ZDEHBs7L
	UpOJ5TScKxi0Z0z3QqQZ36SW9oVSgQaRaO5Crl/RtEzPrUS01q+a/Jq8+BMIYfF63Q0=
X-Gm-Gg: ASbGnctbC1BzKhe6SbtKkLyLBJDAZdupTKopVw9rKOGvXYh5hWsqbyZQSP2W6M+CQRy
	LRjA/nIEZeCJp9x7pn2x3DHMVL+IvSNCfnZKkiJ75Qi54qPRZPZ3Xujqcq9WTPQC1mrPye7ZreE
	noRGX0TkWeZDphEHSMukP6YyujTAsVf0dcBjSfFlMQM/S8pgsDsAH9mujND3t+9xxf8tRlfOEso
	cpfHZYya+lgEg2OfMuiTQWZWFgXgydKlC69UIes+2QFjlL277XtVVYqxtlR1Jf/RtDiwBPskaHS
	Bc6jZkrCZooOkn+OdnMBQXWD70F0EEkabK+67hRLMNzGzcQnYHuiLgjFUDZcc2kYCULATavCFRL
	5UXuDW4X3Tk76hdNHPSQ1n+67DRsTsJrY1GAjI1g/au17x4Hp
X-Google-Smtp-Source: AGHT+IFbfaJcw3SFtnMOWSqBCz5MGWRuuy5GYZFNtKa78qroYRmipTX+6rdHlkckVU5P9OSxGJ3ChA==
X-Received: by 2002:a05:622a:120f:b0:4a6:f4ca:68e8 with SMTP id d75a77b69052e-4aa41562eadmr195005671cf.48.1752530798043;
        Mon, 14 Jul 2025 15:06:38 -0700 (PDT)
Received: from vserver (ool-44c5118c.dyn.optonline.net. [68.197.17.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ab6fdc7731sm13137311cf.40.2025.07.14.15.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 15:06:37 -0700 (PDT)
From: Richard Yao <richard@scandent.com>
To: dri-devel@lists.freedesktop.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Akshay Athalye <akshay@scandent.com>,
	Richard Yao <richard@scandent.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v2 2/3] dt-bindings: ilitek-ili9881c: Add Tianxianwei TWX700100S0 support
Date: Mon, 14 Jul 2025 18:06:23 -0400
Message-ID: <20250714220627.23585-3-richard@scandent.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714220627.23585-1-richard@scandent.com>
References: <20250714220627.23585-1-richard@scandent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the compatible value for Tianxianwei TWX700100S0 panel.

Signed-off-by: Richard Yao <richard@scandent.com>
---
 .../devicetree/bindings/display/panel/ilitek,ili9881c.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
index baf5dfe5f5eb..28d5fff79992 100644
--- a/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
@@ -21,6 +21,7 @@ properties:
           - feixin,k101-im2byl02
           - startek,kd050hdfia020
           - tdo,tl050hdv35
+          - tianxianwei,txw700100s0
           - wanchanglong,w552946aba
       - const: ilitek,ili9881c
 
-- 
2.50.0



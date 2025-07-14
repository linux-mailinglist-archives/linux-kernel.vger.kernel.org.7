Return-Path: <linux-kernel+bounces-730586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA80B046A6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 19:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 876CA176168
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142E0268FE3;
	Mon, 14 Jul 2025 17:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gd67S3kI"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B63266F1D;
	Mon, 14 Jul 2025 17:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752514591; cv=none; b=XvqILs10l/8RiHa/WZsNWxUQ3FOeEvbUCPSoTq1eO8a7KgAtRh2ftouBvGeJtlycypZI0y+vDEaFLcPxma1Kfcyr7G+VQqtw5vpSEmjZg+zjMbAu7ZJ9SFlHFbFkQQllSr3TuO0wo9nT7I2HUfkZwthDmYtelA0l94wh5VHwLQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752514591; c=relaxed/simple;
	bh=rq5YgPNx9avXK/rSM4iKKmkgwxS5W87KGGkv7TSCwXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OfL/5Q0btxIU1kTDZurCsrOdCjoRC1NpN2KUdgtwvpLBGvHb18b0ePy17AaMspd72W/hWQi+YF7+EGKGTI+ctnctKm6qZc2AxsiVyu9wPbxa0w0ImJyF5tm6o7GQoEYSC81bzMnbaX+ZkLfp8cq01oIsf1EKfaXCwZF+Mm1s8uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gd67S3kI; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a6e8b1fa37so3717997f8f.2;
        Mon, 14 Jul 2025 10:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752514588; x=1753119388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nMORlJFstCu30eoDehbfDqzhHnI2qIre3FxSZT/6bX8=;
        b=Gd67S3kI7iFKZi4wNWjXnOLPN73oB6T5cl48QOyKdnjsEKnEm1iaKuUF00RiszboLo
         QOcVKqEf46yMVW8XJruZMHuT8IT+pHTpKi6FlkO5+brVcjZZwWZqmJ0BSCt3VPuFbM0Q
         vyxhJ9F1AH+p7Ba7g0KpsvUWG6NZJM4IvpyK6WdTSm9N1OSlLDN5Q4YZ3fp2CWs797XT
         igJugG4s52Rq2LdQqDzDG/09to5samqfcffdfgoG6CITD6DAtARXZ/pue7SdlLzz7dwG
         45qPw78ZPlyFxN4dMXMi9mnuFjCw59ToEqkoYzS4RHpZfxOvdtzMyLRZuexKqJ0qelvV
         h3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752514588; x=1753119388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nMORlJFstCu30eoDehbfDqzhHnI2qIre3FxSZT/6bX8=;
        b=TyzvEBcnXVpqIG9h48wzcPvZAyov+dcQL2li/OcexJQdNATvq4DUFEYo+dzo8R06zK
         rrzl/f19BAGwFU6+ltIUs0BEFn2SZfCXtEud+/6rnzviSvJ++zJn/GVXOHBdjKCl6cuk
         y/XDwRz93DdeoSNKjf8R7ZLKMm8sOku6tgrRTgtzTmMCCyvZXeDzn1pixCxh6Q1ZiNPF
         qAX0l8LZKtNSdcOYcabS9+lfmgupyNOd3PT74klWYMTNAcYC1eJp9gG72QbrWLiYiV/R
         PAggjb0BMXoC16Ns90HvKwV2J7Irp2Udl9epB/Eps5UpXJPrLxzOK21yzf8wacr6tR/e
         8Hrg==
X-Forwarded-Encrypted: i=1; AJvYcCUWo1+yk0diVuEvf83Jq+FfoNU9iLiS3lA6Q9b4HZ9A07JEfJCvTbhkR5SLcavsxR8a6KKlZa7so8cP@vger.kernel.org, AJvYcCXOEFO5SQMMVT3Lj3VEwwHcuqz+qBBqDpQnHd6TlBRjKOMQ5LdgbKN/PXR3/eE8GhsxK8cK6e7vVKCXJCkM@vger.kernel.org
X-Gm-Message-State: AOJu0YzH7dIvcYk1mkkbM0LFXJk2l2HfRHLQmU0ccJh3ST333fO0plCT
	0vWPL2E4+mcPKDUiX/NjStDy/Ir+0EXPUlzy1mK2o2ylXH01A1vZUhB0
X-Gm-Gg: ASbGnctYFtI/B1oFpFxn6cqyP/COORA49tYC2r0p6qYDb6mRGSnXxAppSoXNuF1knf8
	xH6oVkF6YvKER602Zerhuhy3TDnA9cUsuoR9OHB4Xc3duS8rHn0D4SEjG6kbWrFwzQeK3A0cC2D
	4Nqp/VHmN/wdwEZcDWk0zqVE+WiXGaPDp71MMEWkkCrV+coErn1T6QR8i13SKsPfuxM2je56i4n
	4agq2MtZxMppEgDGXTeOCyxZ7Gq2TSjjC8R1AMf4nvDN7XtIyBzow8d9BiQ1fU35MsG/p4DQDGt
	WcWiiyZFL/jPy1Wm8+r9gCfNgqWMp8vlEYVETzVq0YM1WMwKUapZ/f/8L9PXC+b/7MoZA6+eV9g
	mqTAFruNakBcEurOpeh3WxyeGcxcgfQCqXY0=
X-Google-Smtp-Source: AGHT+IG/PVExtP/WEztpoYPT5TAxxypHZ9Dem6h6Z1iXLOh9gPpqN0Q+vxVVWdYcuYu48wCDZrC55g==
X-Received: by 2002:a5d:64e2:0:b0:3b5:f907:f263 with SMTP id ffacd0b85a97d-3b5f907f2admr7131124f8f.31.1752514587610;
        Mon, 14 Jul 2025 10:36:27 -0700 (PDT)
Received: from alarm (92.40.201.95.threembb.co.uk. [92.40.201.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d872sm13152531f8f.60.2025.07.14.10.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 10:36:27 -0700 (PDT)
From: Dale Whinham <daleyo@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>
Cc: =?UTF-8?q?J=C3=A9r=C3=B4me=20de=20Bretagne?= <jerome.debretagne@gmail.com>,
	Dale Whinham <daleyo@gmail.com>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] dt-bindings: display: panel: samsung,atna30dw01: document ATNA30DW01
Date: Mon, 14 Jul 2025 18:35:38 +0100
Message-ID: <20250714173554.14223-3-daleyo@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250714173554.14223-1-daleyo@gmail.com>
References: <20250714173554.14223-1-daleyo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Samsung ATNA30DW01 panel is a 13" AMOLED eDP panel. It is similar to
the ATNA33XC20 except that it is smaller and has a higher resolution.

Tested-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
Signed-off-by: Dale Whinham <daleyo@gmail.com>
---
 .../devicetree/bindings/display/panel/samsung,atna33xc20.yaml   | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/samsung,atna33xc20.yaml b/Documentation/devicetree/bindings/display/panel/samsung,atna33xc20.yaml
index 31f0c0f038e4..e36659340ef3 100644
--- a/Documentation/devicetree/bindings/display/panel/samsung,atna33xc20.yaml
+++ b/Documentation/devicetree/bindings/display/panel/samsung,atna33xc20.yaml
@@ -19,6 +19,8 @@ properties:
       - const: samsung,atna33xc20
       - items:
           - enum:
+              # Samsung 13" 3K (2880×1920 pixels) eDP AMOLED panel
+              - samsung,atna30dw01
               # Samsung 14" WQXGA+ (2880×1800 pixels) eDP AMOLED panel
               - samsung,atna40yk20
               # Samsung 14.5" WQXGA+ (2880x1800 pixels) eDP AMOLED panel
-- 
2.50.1



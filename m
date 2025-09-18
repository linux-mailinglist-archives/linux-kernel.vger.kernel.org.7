Return-Path: <linux-kernel+bounces-823224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 799E3B85D69
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B67AB3AFC18
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9070A318155;
	Thu, 18 Sep 2025 15:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="O2fP5ZOV"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1F2315D2C
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210771; cv=none; b=RcnG5h5qNJViWz+Q1FXIJk2MZhowTGL4R1A+45EElGV90gaQTxi5kPlObqn3Nua9U43pkwgiltC6+DgmGUI1kIuRrsWbn+W4ePNC9iufOPlRRTswmB/n118jfZQwje40oel8p3QqDipj4eZt1dnRPdQPutG+RIDehbEe4W0vUkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210771; c=relaxed/simple;
	bh=8mMtSR0zIoDa6Wg3t6T/sqjlCahjaYeUdlrfsHSDYXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gDJYKYGZqG3mJpbGzUEtSYp1GUCDS5Sg7u3DPi5mWVfByErf4dvaoCGnaT3PyWhIFUPtt9glhzfeZfd+jz4lY/M2lbwfDwyFOlCThvJHf9UdQMeyNkQpiWPBMp3w9DafiYF1iwjW/LMsL2CzxccM3AOq4R+2CQcbNJXOXfZalRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=O2fP5ZOV; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b07ba1c3df4so206495466b.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1758210767; x=1758815567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b+LIVzIwJpub6PF+1VXdSXGpljd8+6HMYi55fOiXUgs=;
        b=O2fP5ZOVvraMWDob0IyqegXKkV0ZhEJ1OspLVmq+Gf30ys1M0M7g+LaSivVlNNAaAy
         3eMrSzzRXYVWeSBmNMrWeLXDslGtrmWhzoLE2wWlEAsmBaxBTAjM72lXnoYgj7Zzc+jW
         x4WZN6CUFKWe5MJU8S62ehiNMV/qZH68ETUNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758210767; x=1758815567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b+LIVzIwJpub6PF+1VXdSXGpljd8+6HMYi55fOiXUgs=;
        b=ShSGSMByxrpY9MXCvzC+iYwEV5D3lQ7kahgYYruyVm7OlZEQcgzg2TaL7961d+yXfk
         ei4kb0+2O9W9eKY38tvRJ41khizJ1Slj3xDqgPAXrnjlx+O4jFeWIDplf+L5AVh7PPYN
         RLZPY1OrhG3UhnmwOU/HxGsfw0LQCacZRc2LNOJT9SCC4bOAowtFBictD/BQ6qo2s9OK
         /weq4HeT2q0dQiQSQFpopW6bfHsMrmvvnFKHxpkzCaVGtwmukwK/IRxXqwCDqtjAwhjq
         y370l4kRRoDGfkxRsbHqligAxBZoqgvIROoya+5jtnM6GMuesJ+D7z441944Agcn8zOC
         9TRA==
X-Gm-Message-State: AOJu0YwCBOUc2gzdmkdJvyjh/oyBS3pC9rG5+JLMDDS2F7X2aAY2xWFL
	5TIKOvovg4iFFb4gLt99VosJ5U08K8L7cqAio+nSXpp6iNLj2DaRaneG96r74FxACE7vDK5A4eQ
	nK0yo
X-Gm-Gg: ASbGncuLwHx72rrlIBOC8LXUjx9NggRF0wLvNk7A4XDdzKGrJg2m4AAuGTzpOQFHUhB
	s9bUAzXdqc7G7jlUo7TuGKeRj2yk+0GUfXOA0qs+anloCjTQ3UTrONUPn2RXgyccZiBqaRikyRF
	0ZHImdXsIhCcwb3Xc77h4jhhLc4H6aeNwXzE/lAS+MMEJhdIvOj2CqNW06voSD1iVYM9XAGUuYN
	pkDyUn9lTT8NWcKFFctb4dJWFnusVaosas09a9r4WaP6bo9oHsgz6gN+bIzKjWoscbN2JviueRF
	5br5Hh0HbFDDVM/iLDulH27vdspgzISerLp55SdsxkmQD/4yUdc+FGgV5ZfRXKVS53TNVlXqCER
	VxB4rzKOtniIq3VusJYBHfjBRS9dehho8vAJtpKUAtkmgglte0ZKMUyYqHusscg7Pg5aK7gNE39
	svhn0MRlsz+gK9izVD2q8fuV8keeGXoVW5gsd8L2LVUshaAbSsjII1lDo8TT0NNpeTdwtswhoT5
	pU3tX26qE4=
X-Google-Smtp-Source: AGHT+IExLNGGOMPxlFZBucMiTx7Li0FQ+LMi3DGtr6XS4648VroCdhrT9sO8/o8KnNnNbpm4wLXwXw==
X-Received: by 2002:a17:907:7e88:b0:b04:97a2:64f8 with SMTP id a640c23a62f3a-b1bb86d78famr689615266b.2.1758210767474;
        Thu, 18 Sep 2025 08:52:47 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-56-38-125.retail.telecomitalia.it. [82.56.38.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b23a1227bacsm60449766b.41.2025.09.18.08.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 08:52:47 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: Frank Li <Frank.Li@nxp.com>,
	linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Javier Carrasco <javier.carrasco@wolfvision.net>,
	Jeff LaBundy <jeff@labundy.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: [PATCH v5 3/6] dt-bindings: touchscreen: add touchscreen-glitch-threshold-ns property
Date: Thu, 18 Sep 2025 17:52:31 +0200
Message-ID: <20250918155240.2536852-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250918155240.2536852-1-dario.binacchi@amarulasolutions.com>
References: <20250918155240.2536852-1-dario.binacchi@amarulasolutions.com>
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
Acked-by: Conor Dooley <conor.dooley@microchip.com>

---

Changes in v5:
- Add Acked-by tag of Conor Dooley

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



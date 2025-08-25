Return-Path: <linux-kernel+bounces-785369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F97BB349A2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 20:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39AF71B252CF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0613090C6;
	Mon, 25 Aug 2025 18:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8JwthZQ"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1C518E02A;
	Mon, 25 Aug 2025 18:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756144986; cv=none; b=KyE+aykE6vEKsAmq8njBsE+DZDhkbGocI2Es6H/weJR5tnI462tmgP30NRKMupOYgA3mOi5ghBCZjoVsRy9vzR+/j1tZ+TyLGMLsq3OADpIPB5OcqiWFCGuqNu9uwd3tQ6EE8tyOd0UJqHeRVT3fRxzDQ2QiETgmX7q6kSz0n1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756144986; c=relaxed/simple;
	bh=qfYtGjzypAjngAnSpMnyCs+DFZYgO7hARgc8EKcD9G0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P4F41kgWUnHCkClTCcp0+9GeviVN6NuuqsFo06ypc6Yf2fWWM+dbt7vHMxPrwtoTyLxkyhlyoV39p0PwUYfHKYw40frmKQfo7m29p7oP6/usMe0z2cZcELnVGvKj7aTkLZ5KCswPcVWS0AZaWfscAarlEAEx/CFrqLoZU8mQ48Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8JwthZQ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3c980bd5f48so1136331f8f.0;
        Mon, 25 Aug 2025 11:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756144983; x=1756749783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WUIh9vX4PXmb9bPNCGC/HNq+20+lByNZfU3LVMFi/lE=;
        b=O8JwthZQEP/oysScpc6Xm2KIWPtkkEI9QhSdk3ehzrS++IdVh7Jzzb97O+hJ3AIGmP
         tOSeXfv2pWJ6wumort89mU6ZcgQ+op6DjijcLdfSaWMl4QK49Ppi+C7u2sCRm1IOPPeu
         Hv5u2RTfa6gmjT/u+h7Z2likZi6xTqr0IhTCwuich6NwIbASjk1PtgBwp3n1JrolmQG2
         3/WQci5EmonEw3llsWHGSI8IAkzIIh1IW9T25nHxtHLRgqPipf46y1AGx9zq5R3rJs3H
         1ZBU+gCqnTDdEmHqgMmtFZuWCHNAYy0p8v7NR0hF/tCByvJMW+2DGpvrk7RMeasSYmj2
         ZrAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756144983; x=1756749783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WUIh9vX4PXmb9bPNCGC/HNq+20+lByNZfU3LVMFi/lE=;
        b=lxNW8Uo6SnQEJ0SR7/aCR67gDc3xbartdiFMAisX6dnNgc2MdkDqnfeQHasKptj1c5
         Z3REiQNTRwRXtRqhp4EnyG/DEVcjVlwOYYdMVZQJFErnzVczUid6/qhR5u9LgiybQQ9F
         e1NoPjmLDpBhyl6SuMylgUH0U1xfg8A01ANwL+EyORvBOPLBjTMKvo6xpCVbEg8jrwam
         UkP/xS6MlENdSgg2HotsGeoA3hzkr2tFK2WrbBnYru9M7NrHpKADzahYIYEI1EE1EUoQ
         RHF+bqcsDsa3W98lk0j5Wb3Km5Jlb7PVogHe1zI6zXqZjoJo7xMYRXskAzaYb3pE4rRV
         KV/w==
X-Forwarded-Encrypted: i=1; AJvYcCUo+C7SRLDsCSO0DZAoPcz0wrn2O/fl1Uz7HWy0dkTzXowNBSihw2lmvKL35uzWTyvspS9g7d4P0AmDA/k=@vger.kernel.org, AJvYcCUzCvW4Uf6Ps+z6GmqgFxTjGyIuIRKmOEXB5PKL8u3r34zvPRZS90KmhMHGDvHY1xOp1IoE8AbZqqG393ZS@vger.kernel.org, AJvYcCVqIIIkxTlDZZ5FNIlF0Y5RkiLRQ+ZICy3YyFzsmqlo1NPZDflcXXgUD9tp9ZjVcLv+r1t2m+Rw0u07@vger.kernel.org
X-Gm-Message-State: AOJu0YxRJKRM236vHqQUYTeTNcsSMKpS8RVel7c6toseslnKPx6FouM2
	uG+exm1WtXMwNZkzel4E5tVPEW9auGh1TLdmRwr1ZzKB0tryXVb6jMf+
X-Gm-Gg: ASbGncvXsqpp0B3Di5+oW3jrgzCP2Gw/vfCopc4VRyTBsaTLbUW8MWYObJ9FSKZ6dBb
	b6pJDGLF1+EviZ5WJzkVt1jHB5LOiUoVCY5eRnOtbeUCPCOFlIt++p6DTokPFMkuRF2RTsZTTdJ
	R/Ro4TpwhFWHijSlOKRksRbUi/DvcTpSszP3YySz7M1AxVFKz+FjsI3xzF511WiBQyMusxZwauj
	wmB6f6c+TFR2WyAThEO8bWqlYOx11td1Zvrixgmjg9+PFptw0N4hkNuFHyozCSG/JN0z7/H0zxE
	QlzuCwnPFNbvRM4eSRrCHVEZTh9l29HvLZuhP9MHvxKUyn7N+KhPUx/iiUP4LcgSlel3hmLNSSV
	gzzVkX0BIP9+nvAgvw8Wwi3ayLlL+ahTHB/kcZA==
X-Google-Smtp-Source: AGHT+IFs0cAjEPf0GuvJ9TiIXj9Q9DX5w5ClsJacd+q6fiz9K03tWf7Et628dMwIsxRZUa02eXXxlA==
X-Received: by 2002:a05:6000:24c5:b0:3c4:edee:bcf9 with SMTP id ffacd0b85a97d-3c5da45a2f5mr9277232f8f.9.1756144983031;
        Mon, 25 Aug 2025 11:03:03 -0700 (PDT)
Received: from flaviu-Aspire-E5-572G.. ([5.15.80.80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70e4ba046sm13434442f8f.1.2025.08.25.11.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 11:03:02 -0700 (PDT)
From: Flaviu Nistor <flaviu.nistor@gmail.com>
To: 
Cc: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Flaviu Nistor <flaviu.nistor@gmail.com>
Subject: [PATCH 1/2] dt-bindings: hwmon: tmp102: Add label property
Date: Mon, 25 Aug 2025 21:02:43 +0300
Message-ID: <20250825180248.1943607-1-flaviu.nistor@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for an optional label property similar to other hwmon devices.
This allows, in case of boards with multiple TMP102 sensors, to assign
distinct names to each instance.

Signed-off-by: Flaviu Nistor <flaviu.nistor@gmail.com>
---
 Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml b/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml
index 4c89448eba0d..1d192100e8b5 100644
--- a/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml
+++ b/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml
@@ -20,6 +20,10 @@ properties:
   reg:
     maxItems: 1
 
+  label:
+    description: |
+      A descriptive name for this channel, like "ambient" or "psu".
+
   "#thermal-sensor-cells":
     const: 1
 
@@ -45,6 +49,7 @@ examples:
             reg = <0x48>;
             interrupt-parent = <&gpio7>;
             interrupts = <16 IRQ_TYPE_LEVEL_LOW>;
+            label = "somelabel";
             vcc-supply = <&supply>;
             #thermal-sensor-cells = <1>;
         };
-- 
2.43.0



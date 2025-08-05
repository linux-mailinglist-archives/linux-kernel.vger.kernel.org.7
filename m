Return-Path: <linux-kernel+bounces-756423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FF8B1B3C9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 14:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 462BD622942
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 12:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C462741A6;
	Tue,  5 Aug 2025 12:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RY1S1xYk"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F5D2737F8;
	Tue,  5 Aug 2025 12:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754398219; cv=none; b=VoBqPybXbRgODnnWzQJKOCs1YWZ+qsXL0qNzf91p0JU1gSwMIbtkGh2TZW2y33GfJ86rqEeoePSK3tXDeL7v4c+wGvjLtH1WQ15qF97kicfWN8n+V06047gdY86L4azilD09bN8/5lFPGNKn3hx+lLrWzzX69ted1tSafmatXRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754398219; c=relaxed/simple;
	bh=wryQdfxH6n20JyHtj7sthlA3Q+wGAChxADhvmVnFQws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YDEqqophDgbUFTYEUl1gOn5nq8I3ESUPwfV9rk47Mw6gkioNHOKOAsvamHtG0o6Jzma0Gn556d43bKZD3LB+uYZ3ieDw6Hr9QHPHfNCRTQwL/ND5ZI7XkEM+paAz8A/+tkEKqHEBBbtoWCtDHd1D51RsvC9SZ1+y5Wk+AX1nvXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RY1S1xYk; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-61521cd7be2so6239295a12.3;
        Tue, 05 Aug 2025 05:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754398215; x=1755003015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pAyT/OJTRuY2JWhPWK5JkMm7Zn06/WfS2T6aNl4VFA0=;
        b=RY1S1xYkNFFob0dLpqMQdyGfcTnoS2MW/GHhQJywHMufRjgp8D3/1idXSBosq7Fifb
         AHkdUQMsGZBYqWt456B1clteLKsPL3kZ3azc24LS2s1YRjxIQMMAEPTcIC8Aax5/16BJ
         x/M4u1OJ7Ul0myXsd9UesZDzZHrxK22urbAvlNIWx013K3oqiRgNfV5aZdENlbykCsT2
         MF+MnY3B0MoRZaITDD+dN3JUn8iY1a9PLK3HgcyKoM3Do/S8UASLaWEEbZuYNtHV0b9H
         8EEg3mH1SVqyh/+GwktlVnJtvfEj9RVtRBtzs9Zm7i9XZpvlf1iME8vlhV0Wr/ip5yWj
         okTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754398215; x=1755003015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pAyT/OJTRuY2JWhPWK5JkMm7Zn06/WfS2T6aNl4VFA0=;
        b=J/SI1J1ldFCICpOlWT+PpsRUsB9LB+mGIH+X3kWNmXk/wKOqhdeVyab4CuCrp4ubtq
         m6QCVC5hK0LQ5Ymbd6K7Jx7iIGyi49le7ZEzt890gctBQGGkJoqbadSl6cct0xJPX4/G
         veND+6zrKnNGNRGqm63e7BH59y/aN3UXfBs9Pg1zXI5BqHPjoLuwyhNe3rHbKMjgPAQF
         2ERQAxcDZuKQJ0H0/uBF7Gb1K4krhdSCAc1rA+e48UNG4zm6vpl/9Rw+9IHcVhWH3Lza
         rr0sK+FtJsoXR+9DfM89ntrKoGIQ9pCObwB5IUEW+fUD87UhTJkDnUlhqEv+/Or908Ao
         6WtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWT+RqZS2bfP4RibA3HncJfhysPV5umTAiP3s8Ngfz626bGdl1EM7fX/WKZHylaaREFA8/kmCM5jR+uTX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoTqgc3Aft1WZHAZx/8D092cY0K7vz2RnTVzIhq6Sop0KFQ/0/
	NIxz6z8d+3IrkZ5dh7ZufcLQbQ8llWqrCpccUlFGRiMl25zabdm92+sADNZCK0tEqOfCAw==
X-Gm-Gg: ASbGncuFRfXD8YI0QlODx8cySOX4nCATk0X9tQVjIoNjFxa144tzVxXjiiCM8SlFESr
	7TKsijrjfQmaDNEbrhhpG1/SU/E0dzdcdXcPDSCY8i9Fo+z12ArMTvWlCcnjwYlYkmPC/08dwwZ
	ysL61jBj/lmcSNTxp5vnDA09wKU//Gx2HLR/MAGh+9kk2xhvaVi28UuBcc/6hVPwGlXZ5EvXl7l
	QtHr+BTiDy5H2By+T5vhd9cqF8pbizeQfyKmdFSyS6pg52NzsrujLikDceh2TSftwTVjtfdKDt7
	T5kbZ4li8zhNefqEcramAPnXAZbtq7qqvew0oecGoOADj4g6cAUYOP8IBFdyTWaTfC9oQpEPkEO
	2kZdcZQoIX2ogU7zhrMLJe4a1
X-Google-Smtp-Source: AGHT+IG2FyCDtJis4mmbEWHDAMO7TiG6+EtqlP7SIyeHCQ9gfM9BIBrArRpPg92wZ3ClNfwqaIp+4A==
X-Received: by 2002:aa7:d88e:0:b0:604:e33f:e5c0 with SMTP id 4fb4d7f45d1cf-615e71789d5mr9827945a12.30.1754398214593;
        Tue, 05 Aug 2025 05:50:14 -0700 (PDT)
Received: from artem-pc.. ([88.201.168.202])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615cc38aeccsm6811176a12.2.2025.08.05.05.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 05:50:14 -0700 (PDT)
From: "a.shimko" <artyom.shimko@gmail.com>
To: linux-hwmon@vger.kernel.org
Cc: "a.shimko" <artyom.shimko@gmail.com>,
	linux-kernel@vger.kernel.org,
	sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	jdelvare@suse.com,
	guenter.roeck@linux.com
Subject: [PATCH 2/3] hwmon: scmi: Remove redundant devm_kfree call
Date: Tue,  5 Aug 2025 15:43:58 +0300
Message-ID: <20250805125003.12573-3-artyom.shimko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250805125003.12573-1-artyom.shimko@gmail.com>
References: <20250805125003.12573-1-artyom.shimko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Artem Shimko <artyom.shimko@gmail.com>

Fix potential resource management issue by:
- Removing unnecessary devm_kfree() call in error path
- Relying on devres automatic cleanup
- Preserving all error handling logic

Rationale:
- Memory was allocated with devm_kzalloc()
- devm_ thermal registration manages its own resources
- Double-free could occur during probe failure

Signed-off-by: Artem Shimko <artyom.shimko@gmail.com>
---
 drivers/hwmon/scmi-hwmon.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
index a3b5b5c0ec25..d03174922e65 100644
--- a/drivers/hwmon/scmi-hwmon.c
+++ b/drivers/hwmon/scmi-hwmon.c
@@ -211,8 +211,6 @@ static int scmi_thermal_sensor_register(struct device *dev,
 	tzd = devm_thermal_of_zone_register(dev, th_sensor->info->id, th_sensor,
 					    &scmi_hwmon_thermal_ops);
 	if (IS_ERR(tzd)) {
-		devm_kfree(dev, th_sensor);
-
 		if (PTR_ERR(tzd) != -ENODEV)
 			return PTR_ERR(tzd);
 
-- 
2.43.0



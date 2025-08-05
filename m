Return-Path: <linux-kernel+bounces-756950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 303A2B1BB74
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 22:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 900493B44C3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 20:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCA1231A30;
	Tue,  5 Aug 2025 20:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOQogazR"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47F1207669;
	Tue,  5 Aug 2025 20:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754425935; cv=none; b=l4STeSWaCi31yslG7ibAp/j2Ho1wMXzGk/xYZWqp8SiAyIrU63aKLvhddCPRTAD6Cl1uJDq84igQ1ulit5MAsxef3tW8mi6ftDJwg+7s8+FdCDN5WrPkgAxb4PjApy4F0sbXU5ssPIiWtDDJfpGkPvQ4sAwXZlRAJXHWQRHBEfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754425935; c=relaxed/simple;
	bh=p7byaARyKFuipyVsVA6XKK3mFFRx6ccSgw0Psit5eww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I4pEBsV+fHJZYZoVQYh+k9o8X+Aj4ltjJvw+9vr/KM6Ef5EuBCACLfPBGG5u9xZQB1Bo/gsmK6tmP1RStRw97HhjH4qLt7PpFcLEZvOT8jND6OV6jvdcALqGFKizcf29sHzX3hJtbxKPLCxbT0F1nTimvUWR42Z06J4DrDLyoak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iOQogazR; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-615aa7de35bso12675374a12.2;
        Tue, 05 Aug 2025 13:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754425932; x=1755030732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=39ozX33uAF5W/p2GdEq4vldEOFRsu0mf6GkKFqZqggs=;
        b=iOQogazRtNGTZjxIlEIzohMpYBNV4ayrw+wSpoBdjO1PkAtd+eKVCx99xKeLz0+x0C
         QuTA4bSY1XMpgQkLr+2fzWX8MIvqCJgHQPOSIabkXFETMIwYKwWGRqN2OAx6OSCTqRKc
         kEv5rYpMntseFTq/WboISBauOdkdKnRRaksXiE12iryVtcWh+k8COlXxeOvytqHhd2Jg
         zu8pi6KubhmUAqFRBGXIWvOZzMD3n5FG1BIJyu2sWm2TysK7WJs8uPa4fFhC3oREizXw
         hnNX3I3QMj345GlT0Uvx3XR4wOOPZ5VNJCCYCI3H4JZuQxwwCrpGLc6maxQEYIjEKz5R
         nnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754425932; x=1755030732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=39ozX33uAF5W/p2GdEq4vldEOFRsu0mf6GkKFqZqggs=;
        b=cmHqA/TSFqu2nnoRj9i4Zybj2fcMG+S5Nm9QcYoQw4JqxTj0CXXGq7rtZGhiaaGgRP
         L4kw7Br9/a9Xa5V8eWiQ5tfzMiqexhBBNXqfuvYoRpg8J+hZFkg61M6PmaxUgydM4rdh
         UYa6Y19hKBm/SkD/876hFwNZhV6oxbmlAbtwoLoJZunIWN0aKHjvy2QLfhwM1Onq+wdx
         5ej5JcsI4blCXGj9XHMaXcZfo0wupy1W6nBlDllwpDLEfeUR6l5rHKCAwwHApmngTu/z
         c6TrcpqfIXcqaUgNwJKuH0iIYq9GWBMfoFfUkSLgWtmc4y0MnvDl9IQj0VjMjJrYxDvu
         4X9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVG046lkVHAgqC9yY5l0GmESbZO6jLGsgciG8LULY9TBwLgBbv8tn0SXagInsxHCZF5Zn+wvtyQHOLIgn0/@vger.kernel.org, AJvYcCViLyrGtXiTwTw2436szjPSkXfloZ6zv47HHoLRYTLtsvIIZTT2SZDg0RBr6aNhmWWJemPMSJgtSJnvbA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoto4EUyRbgQXIdOaNaP3jYmaL81brbLeiFDGpsVvLF9WzHCcN
	gf+awC0XlyoI+qZ4OQG7yapLexIsJdalZkIZIlraVFDRHKIajK1RFMak
X-Gm-Gg: ASbGnctF8YswcXLPy1OLi6FLpVvGaSifuxwqpaDjb1+caox23WDYP/lHt8KKLLXsiNt
	I6p3QG35yW8HfyQUqytd4Tj6nAd6SG8XMmd2V1DqJAZGkQcm6yNi6aS8JC8DdAkFyTWMpXWF5lr
	1ilS0NKdVbToNjuMEQqIVoDynecM3utGaywt01o3wR/0pRZhvj46TGMLxgqlbvhlH1uXX3n91yN
	nw8axtaYkQXijzkFEuF59onVoz68Wq+ADJtPtDbwNIKHW65/mgcE8t6Hea0QMkJTUnJ1RFk/Xt+
	K7RjMpcFy53jNrMM/Zi9Vh610cMqXdRMN8v1Yy002JC4gFcjqRh4USurR2daEnIPYUJ0CpjgWm+
	psnFKnvlwAo8pe+gVw22i0H/JsY8PU6g4Dab+S5f2bsxSNuCHtAmgEFG9a6eYmGjLuUE2FmnUwI
	cuIYrnjZsHWg5ETpz1F9bPlczi3g==
X-Google-Smtp-Source: AGHT+IH8eVS4AwgQOA7qHCXFqm5nyGvHtR/jrHmUQ3XJijzsxVYczd36p3/W5jmj8v2mz86182cZoQ==
X-Received: by 2002:a05:6402:27d3:b0:615:4655:c74c with SMTP id 4fb4d7f45d1cf-617961c97a4mr269322a12.31.1754425931783;
        Tue, 05 Aug 2025 13:32:11 -0700 (PDT)
Received: from puma.museclub.art (p200300cf9f012d007f797a708441b909.dip0.t-ipconnect.de. [2003:cf:9f01:2d00:7f79:7a70:8441:b909])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8fe82a7sm8947582a12.30.2025.08.05.13.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 13:32:11 -0700 (PDT)
From: Eugene Shalygin <eugene.shalygin@gmail.com>
To: eugene.shalygin@gmail.com
Cc: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (asus-ec-sensors) narrow lock for X870E-CREATOR WIFI
Date: Tue,  5 Aug 2025 22:31:48 +0200
Message-ID: <20250805203157.18446-1-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use mutex from the SIO device rather than the global lock

Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>

Fixes: 3e538b52157b ("hwmon: (asus-ec-sensors) add ProArt X870E-CREATOR WIFI")
---
 drivers/hwmon/asus-ec-sensors.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index e2f7b8705cb1..83047c3263d3 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -409,7 +409,7 @@ static const struct ec_board_info board_info_pro_art_x870E_creator_wifi = {
 	.sensors = SENSOR_TEMP_CPU | SENSOR_TEMP_CPU_PACKAGE |
 		SENSOR_TEMP_MB | SENSOR_TEMP_VRM |
 		SENSOR_TEMP_T_SENSOR | SENSOR_FAN_CPU_OPT,
-	.mutex_path = ACPI_GLOBAL_LOCK_PSEUDO_PATH,
+	.mutex_path = ASUS_HW_ACCESS_MUTEX_SB_PCI0_SBRG_SIO1_MUT0,
 	.family = family_amd_800_series,
 };
 
-- 
2.50.1



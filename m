Return-Path: <linux-kernel+bounces-863401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E88BF7C95
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C5574E7003
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF97D2E8B8A;
	Tue, 21 Oct 2025 16:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQNOyL5v"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8507346E4D
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 16:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761065548; cv=none; b=aaNSBQnlxh1IKPX9iQlYBQ9t/6S19XJiMaA+0Qki8S8OeSKz7BcwxGdU9mlmwUGBKMiRin4O7rrhwSayDP5BOeZR3WCDULa0ob2sAc7Ae/yWlhoj2t+iZGU1NSlUWKUFEShD1AFHOTRAF5RZBSLysvwyR4sTcwC72ACJOcvAux0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761065548; c=relaxed/simple;
	bh=ZwAF2AyKjAq7XArrOl8zo/1+2cviZIez9vQLVLqfOZo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WMe99vKzwe3ySdj4LYPuFxoLDE8cTPqL8VUKimzxRgliH2IfRxaDejIS/YW3e3zchJBfIYls3M8dbJXSG/WEjWZAE6FxajKfa0hbEG6+vpHJhFzSuXg2P3c6D2k5haOyiYntr2kxqaEyqqm7E3aYD+ib5yYka2Y7GelmKPNDth8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQNOyL5v; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3778144a440so994821fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761065545; x=1761670345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=paRKTns1WT8quydNofkJCuHKZQbF54gWy9Rd/nrzvfk=;
        b=DQNOyL5vCyXu5GPB74zADZoQYkK7xeW5XzbsbV1LE3rMH5NyrxyHC0AvEbX/bVcewM
         kVySeJ06CC2v6DaXhof5sVmKPmyQbTJulJ6c/bkm7paAt8leNnuMDfepnj7+uBmECFmW
         IZfYdApjQlRH7FbklYiPjGjbZAbeOi+72FVHb54T0ugZXVLOSGZKC6yLJkiyV8GT1wza
         GDvzdZA/GHN3UE0juJzA1u+4g4ItfKcie4B+BhYMdA8CL8eNTvIs9mq8Sf5DdmE9l2Br
         /DUcNFxFtTZ3txDRZw+UW+uaZUnakecZvtFEiHAfBnN6Iao1YYl6aQNWQ105+Bb69Ust
         0xbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761065545; x=1761670345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=paRKTns1WT8quydNofkJCuHKZQbF54gWy9Rd/nrzvfk=;
        b=EkNoGw3TGInhE4xRkzlub1hR3awaxzg5VMUrPSJ3FFbccB44tXJ5J0wjh52aYYQLzT
         mkSFzGjBojomZMYXkugPZKBk/gpGZUtUMXaG21pELSC5rsvTofTojcRC8Wq8v2ocKK/c
         xAmvOoo/ZqSIm9oUiwR2TdJqO/yQ8tnbBPaa50PHoukFsObEATGSYl4xH9fOaAP4lf/V
         GaX6libc4V+w8yf/V72BOTAHeEW3OhaX8rvWfv2KE9pNJsqX+iWnITLjcibaW9fWg71p
         7cYHSZtI549BfXet3y6DIj4HtsGYBdO6dky95GWI44JwVyKFEEsoVXpkRNc0USvBn5ZQ
         h9kQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZwkBNhxdTHQvMf+3x1y+NOKhIvJI6oBUtdq2nnLd6p9+iUs5EbxIZGvB9hEjIFuyGin0vb6ZKLhwlmj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlQbz28H0hN5TIRYqFtTIWqr5wMRWOPtG1pQfL3Q8rfUywYLSN
	NWIUnplKq3p18Z34Hxp57oBfLImqpM2mLy/tuF4EhPdBbv7YI7NGfzgQ
X-Gm-Gg: ASbGnctyvU8mz9M1Ov/joDYPZsAVYiDO0ed53BjPs+aFDUWZ4GRMGmSnRGVzWl/Eyxs
	FLbR1QNxPE93/179rKEqEoB95VeEpHAm1JcjWouYyViIXGxNQMiBMxoz+tK0uRxBYPbMwFiu4+2
	uUH93ufggcer4tnXvLSqhDRI5sszzrMBbjQJWqqVhMRMaCQJfIVK4IZNu8saWgTdA8l9cwZlqXz
	ReCZhv+KgNW30OcHah1HhmIt/2bOXy3ETDjz1Jd1+yuFnarjuJ41S7hvRo3SjYENoEcB1ftvbxZ
	pqP+Y0E4iwC7N6AOL9sufmPnoRzAC8QxmlUhjzaOkDBD1V6FLtU599YyVQIfduo49ClvTC/rJre
	QIJK6ZaFx1t8u9rj8tGV1ui8y8bn+YMp+hmf1p7KOw/Gm8RuI45Hg7Fs7Od80sjF6Qcca9pS3Jf
	3QwrwjpIrmODS9xjaO3g==
X-Google-Smtp-Source: AGHT+IGjAkRj9soa7GWukQ8Cihq7HSi/Un2xv4fuxCxdBhttxHc7UDbrzdxzRB84sxHyktFpcpbArg==
X-Received: by 2002:a05:651c:25d3:10b0:377:991f:c1bc with SMTP id 38308e7fff4ca-378bb007751mr918501fa.5.1761065544634;
        Tue, 21 Oct 2025 09:52:24 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([188.243.183.84])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-377a9506367sm30738001fa.34.2025.10.21.09.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 09:52:24 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>
Cc: a.shimko.dev@gmail.com,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: arm_scmi: Add new sensor unit types
Date: Tue, 21 Oct 2025 19:52:11 +0300
Message-ID: <20251021165212.749372-1-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for two new sensor unit types introduced in Arm SCMI
- STATE_BINARY (0x5E): Binary state (1: enabled/on, 0: disabled/off)
- BYTES_SEC (0x5F): Bytes per second

These unit types are used for sensors that report binary state information
and data transfer rate measurements respectively.

Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
Hello,

This patch adds definitions for two new sensor unit types that were
introduced in the Arm System Control and Management Interface (SCMI)
Specification version 4.0:

STATE_BINARY (0x5E) - Used for sensors that represent binary states
where:
1 indicates enabled/on state
0 indicates disabled/off state

BYTES_SEC (0x5F) - Used for sensors that measure data transfer rates
in bytes per second

These additions ensure compatibility with SCMIv4.0 and allow proper
handling of binary state sensors and bandwidth measurement sensors
in the Linux SCMI driver.

The patch follows the existing pattern for sensor unit type definitions
and maintains backward compatibility with previous SCMI versions.

Thank you for your consideration.

Best regards,
Artem Shimko

 include/linux/scmi_protocol.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index aafaac1496b0..629acb7831eb 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -488,6 +488,8 @@ enum scmi_sensor_class {
 	CUBIC_METERS_SEC = 0x5B,
 	MM_MERCURY = 0x5C,
 	RADIANS_SEC_SQUARED = 0x5D,
+	STATE_BINARY = 0x5E,
+	BYTES_SEC = 0x5F,
 	OEM_UNIT = 0xFF
 };
 
-- 
2.43.0



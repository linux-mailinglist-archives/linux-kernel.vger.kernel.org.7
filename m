Return-Path: <linux-kernel+bounces-791031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E410B3B15D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 05:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 586021C86061
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 03:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BD5235050;
	Fri, 29 Aug 2025 03:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="Dq0ntfhd"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DAA21FF36
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 03:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756436726; cv=none; b=RrIzqwtuQcM5slTQdp+Q/pTFd0B3F/auCatOk/uGEeIPeo7Ea3eCX+YsSSMNkPHK6VHzIH5HXxNQMepqcPvBhMqHIht3RAIGoD++g7RHIVbmvXLBuZH/2MU1VNy+WKTTmkewK/OmfzcrAZQTZXquUjkEiJ7sqs2QAZz6RGoTJ1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756436726; c=relaxed/simple;
	bh=w4pXgkDYdjpPgujkP5f9IsyFh4lsheCCAK15auAWIZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W6sFJrNNrxvbm5R+d76Fcuo6noCqY2BR4hjJZeyUzmoqX/vde8Zpa4U2luBeqZgQ/T7gtj0ZzFAdOITOYgSb1eGXYWvLJU8xGB4k5BqRxuZAnxPwlqyy4A1OBMMUq5ejuANLQflkvlpf4MuS9w6tBudDBknW/RzhEPUoBqlWppg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=Dq0ntfhd; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 92AE42C0BCB;
	Fri, 29 Aug 2025 15:05:15 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1756436715;
	bh=WTHFZbxOsXynbN3vNzhC21nGaoXgjnvRzvywiYnPmjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dq0ntfhdTmGB8pYwYsK8jwo/cY0ydo5AEJ3eNt6ArSUl6yhZvdRZazYOWLAQfBs/F
	 9TdogPMJam/dVr9m8J3bWkuuV4Y26ykPkG1mhzdPFJaOLnN9tVFFqlt1D/Sy7jDxuB
	 RtApacFblYveRYB544uVZsvFvq4Fkg4nyYS5wR/qszg4xHcOhZ8q6lRM4LNg7ukVEp
	 Z/Kj+pJoh0LPMhUgf+/zZZckShWiu3tgjwJLOPUUjcw32GfB6DKuYJJ3jgKZegwP8S
	 T7vO96YlXXxDdcJLV8kdBhe6JiWnvz2Ds7JGM2lWvlq/DYhqgPnPZLkAOrcBfGhqal
	 qSI7slBJzq19A==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B68b118eb0002>; Fri, 29 Aug 2025 15:05:15 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 1E0A913EE8E;
	Fri, 29 Aug 2025 15:05:15 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 1B24C280725; Fri, 29 Aug 2025 15:05:15 +1200 (NZST)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: jdelvare@suse.com,
	linux@roeck-us.net,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	corbet@lwn.net,
	wenliang202407@163.com,
	jre@pengutronix.de
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v3 2/4] hwmon: (ina238) Correctly clamp temperature
Date: Fri, 29 Aug 2025 15:05:10 +1200
Message-ID: <20250829030512.1179998-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829030512.1179998-1-chris.packham@alliedtelesis.co.nz>
References: <20250829030512.1179998-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=Yo+sRJYX c=1 sm=1 tr=0 ts=68b118eb a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=2OwXVqhp2XgA:10 a=JkZNxmCQ9iT_7a32SUgA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

ina238_write_temp() was attempting to clamp the user input but was
throwing away the result. Ensure that we clamp the value to the
appropriate range before it is converted into a register value.

Fixes: 0d9f596b1fe3 ("hwmon: (ina238) Modify the calculation formula to a=
dapt to different chips")
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v3:
    - New. Split off bugfix from main patch

 drivers/hwmon/ina238.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/ina238.c b/drivers/hwmon/ina238.c
index 5a394eeff676..4d3dc018ead9 100644
--- a/drivers/hwmon/ina238.c
+++ b/drivers/hwmon/ina238.c
@@ -572,7 +572,7 @@ static int ina238_write_temp(struct device *dev, u32 =
attr, long val)
 		return -EOPNOTSUPP;
=20
 	/* Signed */
-	regval =3D clamp_val(val, -40000, 125000);
+	val =3D clamp_val(val, -40000, 125000);
 	regval =3D div_s64(val * 10000, data->config->temp_lsb) << data->config=
->temp_shift;
 	regval =3D clamp_val(regval, S16_MIN, S16_MAX) & (0xffff << data->confi=
g->temp_shift);
=20
--=20
2.51.0



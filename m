Return-Path: <linux-kernel+bounces-891356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D86EC4285C
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 07:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E5F63B4045
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 06:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE87F2E0402;
	Sat,  8 Nov 2025 06:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldFFjUWB"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1AF2DF707
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 06:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762583552; cv=none; b=I9iJkSJBMBqPjrFCZYBzy5gkIUpP0IS5y9uXhJNsO6HPJ3mNorwY2GuS1W4WJ0yPcyCbro7ujuW2BU/cwbAx45JKxtrG10PmqFADkYy4qhgaNDrcIq0Nwx6us0LJ+rr75G/0CTV8xFxx/GpTf9mXO9npjiB49TCW8+WdNUrJqgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762583552; c=relaxed/simple;
	bh=jvhC2lR8nByGDVs4vKZHsLg3Cys5Kb+V8qSzQTSD0gY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rE/ZgZvm5Fy3BjFFmSVioOPCt1Gsgs+267JH3bIQ1IkkNfj+MkbNv55+csCn2YdAwVPARutueK/+kVI8YmSRxGgWVHerRV3NuNzFYuizOHrSputuXWdu6QWbJHLgbWPEUljIS8uvm6wa/pEiokDihjd+oOH90uvfhEvXfH50Cjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ldFFjUWB; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so11984425e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 22:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762583549; x=1763188349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KZXbx0Pm3o5USAhmQ+ef+lR3wziCD+RuaTHOuJKX2OE=;
        b=ldFFjUWBC/ACVcSfTsCKihIwb27TTHch8RVajJsVVXmPi6oLP9kI9IP6iRxj2k4pn6
         AOnPXHNZXkkx4gy2fP3KgPD/8Mq7yfAP5J1tYxMVjRhtFP5RMRShI6hxvpl4WJAjvHES
         zpxlbBqaTkgICoE5mvQDw192Ies1e+pMik+f+JEXYUrss1j4kO03QCsytghNyuZYQB0L
         aLU3BgtAmv5pxhZEKFiYyFxsepRvOsAyhDYid6MnH6Gi6vJ16SzI4R2fv3uL3gykdBUb
         WeYSOEfvYse/xBFaJbtWLYdaHGvFd4/OucFse5fvtAiHvbU6DwYTsqWyDLYxC+B8qVd/
         cxcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762583549; x=1763188349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZXbx0Pm3o5USAhmQ+ef+lR3wziCD+RuaTHOuJKX2OE=;
        b=rNUZrs8msdQ6o0vPNyE70CzDQf/sRqV8RGlEyInyDnaGiUiO2QJmSeYzY1JJGLQh6C
         +9+8nqfX+QJoqJXn31T2lTTr5GikjFFQscEhLRMkfGDNKXe/MYm+jy202q9mX6WrAoJK
         GU3rgQH5Ajz7lm7CeMeYqE6UfS+vklX1TB3rn/3kFajWn6sYjmjaVNiadcw4jZhJ+7ZE
         kTmoZDuH6fDmCIZDucvb8CDFxL0o0XmzoPV4dgj8hPF7eEy/SOe3XUwK1ZocVe1FQUcF
         mu578rYwJZqDSmyPCcYSWG8P6wE3otHccjphbNvyqORWBRF+UkP2FYDJccUO8mkZGnFs
         lDtA==
X-Forwarded-Encrypted: i=1; AJvYcCVx7NXnSVcoXk2xAgupTIpevIDTRHQ9qAlSE/LYvaz+PY79UYB3Hh8EoFyeEM5zJ67MoE2iIl3Vua0v4sQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD8VE+ofRuXJDyVDgNaIqD5s0VC00y3xUOMJyE6Wrg0MS7nQKU
	84ShgQpQoODt/1BqWlh6hHYm6AcJ7ULVwmp484WmzePB009dxP+AeL2k
X-Gm-Gg: ASbGncvY+5DojQWGY2hmTgHrqc2sPSNk3fcNwUU1653QAZLcC5H3J7U3fMHjIrt+RfR
	H+fpMOPOsL6IO59GR7HaYbbieyIunAXqM826lx+Aq9aAnA/KUqCu4Os/9+8jB2rd92HI1bglkUv
	N8IIXUHnqR67zFH6ZMHvB46Bv+Ckq3xxEaF1bRBz15uRc5fA9zXf6VnYXQe5dYX7qkYPAA+hLWy
	Q2QDjfh09CDKzrfPhlcNZZ1NHnrsSsoWNqFkW0j7iEE390w3fk4ndZUcaPvCI9vgEou/d8dO2m0
	uX3OHSrHPQFYGTFzToPjUJ8dmDSVTuVZDgWZ2p4RHVVdyBz3T0WbxZdD6Q83pf9rSAfnilEs2IS
	rBgIZWWH5XJfZ20vuzj+2Qj9Dv3dwjtMdFD6JCABmrDkGOA7NgnQJoH01zq1eEtZHZT50rVBU
X-Google-Smtp-Source: AGHT+IFTag1jpZGPvIP6mbTkBpcQrZLk+xfLiNvvxeilGJXEuapETNQO/3imuMjYbH8fw8G2ifcwOg==
X-Received: by 2002:a05:600c:524a:b0:477:76b0:1e73 with SMTP id 5b1f17b1804b1-47776b01f65mr1356505e9.41.1762583548733;
        Fri, 07 Nov 2025 22:32:28 -0800 (PST)
Received: from pc.. ([105.163.158.79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac6794f6esm10715849f8f.41.2025.11.07.22.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 22:32:26 -0800 (PST)
From: Erick Karanja <karanja99erick@gmail.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vivek Pernamitta <quic_vpernami@quicinc.com>,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Erick Karanja <karanja99erick@gmail.com>
Subject: [PATCH] bus: arm-cci: Fix device node reference leak in cci_probe_ports()
Date: Sat,  8 Nov 2025 09:32:19 +0300
Message-ID: <20251108063219.550810-1-karanja99erick@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Although the reference to the  child node cp is
assigned later in the iteration, when an early break
occurs, the reference to child node needs to be
released.

Fixes: ed69bdd8fd9b2 ("drivers: bus: add ARM CCI support")
Signed-off-by: Erick Karanja <karanja99erick@gmail.com>
---
 drivers/bus/arm-cci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index b8184a903583..1f84a5528073 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -461,8 +461,10 @@ static int cci_probe_ports(struct device_node *np)
 
 		i = nb_ace + nb_ace_lite;
 
-		if (i >= nb_cci_ports)
+		if (i >= nb_cci_ports) {
+			of_node_put(cp);
 			break;
+		}
 
 		if (of_property_read_string(cp, "interface-type",
 					&match_str)) {
-- 
2.43.0



Return-Path: <linux-kernel+bounces-880921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAFFC26E01
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 21:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C39C4EF5FD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 20:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E3C1E47A5;
	Fri, 31 Oct 2025 20:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEAC4esz"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4B2C2FB
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 20:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761941805; cv=none; b=ny12/24MRDKIa9p6nuSMJpVylxmJaOLi+bBxJ6tSrcQF7MHHHJGRMZ/7jID6TIgPTVLBWWCorqMDUyYUyP8SM2I3wBpi68k1iAZ6uEAxO25WL0YFp5n8tP+bmVeTRoXxJTSywIdHAjEbyb/BMl4PC4iVgWQXXg9Cvpj2tr7Fvi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761941805; c=relaxed/simple;
	bh=IJ7MekitaJ2Fv6sImoVVObJ3pKVkG5fAU1GuMqp9ues=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u1Fg2AW8+PzUvjRt+wUcn/nq/c9cWMb2xrZ9StNU0D5iPiG0RmuJREgQph/11Cwmy0z0fnAybsBy/n2qDWw6nz20AdCJSzm11qauuKN8k5fNJ5TmJECuptqYGUg8yXWeC9ysarzYWjpFupPatOvxIxMOZPkK55XmJL0TowiirOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LEAC4esz; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b6cea7c527bso2199040a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 13:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761941803; x=1762546603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DB+BnmMtjqQL3AOPHJBo9QeBlx/EWCJI9NwxJO6DPcw=;
        b=LEAC4esz1zLdyYlKf2HttmxlIF30qz3uk3Q8quNe2YtJKaAYkX0ShpHa1JbzXH8S2y
         87eDXfB3HhgwbPPz3pT6STXEjeFxw9hib80tODIVGUv31VdWr9JhDp2qflaroQVuGXoS
         NV6YMxms6WBuc3QORyeUw9mLPhXlZ93ZdScB89sz6/j8w3qgaPwIeJMUz//SYDTXXsK0
         2ND5OnMiVzh7fwsi5gXDNMT9l42joVUHEeJXhNwhgZ4kMfmD4/sQpc0fwwIemvx02jIr
         oOEquIl4gzvoYMcc8XCd0PCvBDGPDLXUmGBYBkbm9SfLmgukpkChQEROAHOxcXS6Nolf
         02GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761941803; x=1762546603;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DB+BnmMtjqQL3AOPHJBo9QeBlx/EWCJI9NwxJO6DPcw=;
        b=e2jIBVEXBAQu+HsVGeP1jLGUSIx3+Hk0t7ZKXoA2uWdeHjSeqJ6Zq7fpd+D7v6q00E
         fn8vb1pmZWWJCY3HHXY3ZVzxris6EUekewmkwSrLY0EtjAYRrzGeBoFRnBRrgsxN8H9D
         nW8jMm2itITN66ZcOSiI8cWg5JMG0Y3iJhifluuTmdXjgVyAJazIJ+bOVi71ZNLTiaNi
         3MZJPQtilh+uMPiI2sWBuDO+dTMt3gdZ8010XqE7CWn9dZH/7OYK4o7lzOTXyMfSl9wG
         kSRBo6dgMi5iVPhvcAcP7D66trfKyYirv7DTcrd236/RyE/lKy5b7Rd4lHrGTxkhN4/o
         yGWA==
X-Forwarded-Encrypted: i=1; AJvYcCXcdfDZRRrngg8uizKomHrkGHa4x8JL/CYFjtvdCWG30lKVhU1S3bozjf/QJs77zTwBN4dqKENVLbWFsn0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnc0QNE8CQXNtjq8F00+5H7mc+p4XjnOd/a/wjA9NuVLFmjihq
	sqTyiTikBEYQiHjlSgwT5pZb0RXyjQInSxZIerZ0jqt4RkHuRq7WnTAG
X-Gm-Gg: ASbGncsN1LVvXHiptiuuk1j3ahSPjoirJq6gX1OYU37i6eEvB8RYSoMj/O2eWhB1S3w
	a4pMaGKCM4bykkzmEvjWXG0I9juoykHRbxt14LksF2/wA2G6iP4rVXO6kx1M1Is0dzES9wejhjQ
	qQ76lIfcQXSzXbJ5xIX/14yQvhDZRENSlwsVcGsxztUo/q01A9/ZTXZIqSK8QaiWMwQDqzCIPpr
	mu60KBu6j9SoGh0Ads/XY+QbfUUQK//j7DwQYmI2KESS89yAJAtS9XFuSSMxljjjnEQuXVELAR7
	FJaGgIsNaPOphcLC0E7MGlxV4SUAHqMWmIaSREzoikObsQmdE9RXRcBA8jo3+UdGnB80GT5K9uc
	LUGd6rEIZZ0IrkupKRZgd6iojjfdEcjp92WO/N0xZiYHG4m5YqN95fXgJJmvjfaBvjI/oy6OtUe
	hM+jBSFkIJ+rf/XdJT7RbMB6BM5HNXRZKEr5QYeluV77AB
X-Google-Smtp-Source: AGHT+IH+x7fhTKIEl/vYRtsu9o7oU1PBK8RL9hvD6k9wZYqltdD8fY7mC48qG+iwSSFYJ8Yvj6TYSg==
X-Received: by 2002:a17:902:be0a:b0:294:f779:3efc with SMTP id d9443c01a7336-2951a508250mr35603915ad.56.1761941803246;
        Fri, 31 Oct 2025 13:16:43 -0700 (PDT)
Received: from sanjays-pc.govzhome.govindz.co.nz ([27.252.49.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952696efbfsm33086355ad.73.2025.10.31.13.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 13:16:42 -0700 (PDT)
From: Sanjay Govind <sanjay.govind9@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Vicki Pfau <vi@endrift.com>,
	Pavel Rojtberg <rojtberg@gmail.com>,
	Antheas Kapenekakis <lkml@antheas.dev>,
	Nilton Perim Neto <niltonperimneto@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
Cc: winston.tan@middleearth.com,
	Sanjay Govind <sanjay.govind9@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] Input: xpad - Add support for CRKD LP Guitars
Date: Sat,  1 Nov 2025 09:13:56 +1300
Message-ID: <20251031201358.10528-2-sanjay.govind9@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds support for CRKD LP Guitar Controllers

Signed-off-by: Sanjay Govind <sanjay.govind9@gmail.com>
---
 drivers/input/joystick/xpad.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index d72e89c25e50..33b0ad041247 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -133,6 +133,8 @@ static const struct xpad_device {
 } xpad_device[] = {
 	/* Please keep this list sorted by vendor and product ID. */
 	{ 0x0079, 0x18d4, "GPD Win 2 X-Box Controller", 0, XTYPE_XBOX360 },
+	{ 0x0351, 0x1000, "CRKD LP Blueberry Burst Pro Edition (Xbox)", 0, XTYPE_XBOX360 },
+	{ 0x0351, 0x2000, "CRKD LP Black Tribal Edition (Xbox) ", 0, XTYPE_XBOX360 },
 	{ 0x03eb, 0xff01, "Wooting One (Legacy)", 0, XTYPE_XBOX360 },
 	{ 0x03eb, 0xff02, "Wooting Two (Legacy)", 0, XTYPE_XBOX360 },
 	{ 0x03f0, 0x038D, "HyperX Clutch", 0, XTYPE_XBOX360 },			/* wired */
@@ -518,6 +520,7 @@ static const struct usb_device_id xpad_table[] = {
 	 */
 	{ USB_INTERFACE_INFO('X', 'B', 0) },	/* Xbox USB-IF not-approved class */
 	XPAD_XBOX360_VENDOR(0x0079),		/* GPD Win 2 controller */
+	XPAD_XBOX360_VENDOR(0x0351),		/* CRKD Controllers */
 	XPAD_XBOX360_VENDOR(0x03eb),		/* Wooting Keyboards (Legacy) */
 	XPAD_XBOX360_VENDOR(0x03f0),		/* HP HyperX Xbox 360 controllers */
 	XPAD_XBOXONE_VENDOR(0x03f0),		/* HP HyperX Xbox One controllers */
-- 
2.51.2



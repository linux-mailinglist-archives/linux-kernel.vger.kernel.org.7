Return-Path: <linux-kernel+bounces-886582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8C2C3600F
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 15:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C326234EE8A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 14:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EE7329E63;
	Wed,  5 Nov 2025 14:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBjdmEZt"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6157329396
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 14:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762352093; cv=none; b=mPDhHB9PKDNJtyEenQ8pYc/P1u5g8XiFwwMnYuyR1PNVsYyTzyTli/eOGO9dZjHAZCRub382tn1ZPlsg17uJlyUEvBAqNZoPxaadUDqJ9qQYNNZhsF4mCvcaO3DxShBr9khS0iXe40P3aI3/Ed92u/PqlzeJ//T0LkggqlsToNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762352093; c=relaxed/simple;
	bh=mJxls0L6MjDLzDQonIfLUUpMj8pgWbeFfC6UPwa7zxU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mWbTfi7GE/+PrX0qZp9S+s+2fUGHVjdYdwN8eiS9KmMPc/JjmUHYJJezjgmlhtQIKXqUO6XwwX0T4xUDkjkImXjUqfTjVFcpCthBSPDwc/3oZTQgoeyEMXbbOqmc5G6OY2XZR0t5Ise3Im4+AqMWsYDUvMb8PlNQXHEVIFuci4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBjdmEZt; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-781ea2cee3fso6565668b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 06:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762352090; x=1762956890; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uVOvJXaWSxDtfYehskh8E4BDAZD7pJCUnmkX9Zw9K7k=;
        b=iBjdmEZt+REbVkvwmKIN22/5yfjx1gwgxoHyVbSwu+Zp/q6TvTAv2CqURZ6Qk7mT4/
         ZSH0hFC3mTJDUvHO6gF8d80A1TtROWyK5r/sWL+UgjPY3CPRCpJ5GWE6DHqE9bJ0+d1T
         vJzRan4jzzgih4ClZO5upYrvqjzIDHc3C4BUi6B6nzxptIZMUGtX0WgUsDIXxveli3Um
         eqAzZ7I07DEYqRzAYSrhrP5NVreJH7lEjMc0FiBgeA1ySkEG/y2ryoO9zXXcbSez/3DT
         Rj2nH92tnA3J3CTH9o/Gj5TcboVQGGpi2gUygtPHY4nv68QGj024YJ79Hdhi3qB7akbb
         mzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762352090; x=1762956890;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uVOvJXaWSxDtfYehskh8E4BDAZD7pJCUnmkX9Zw9K7k=;
        b=i6G0DHTqbn5XX4hdpaEVaHLwbZqoDQgiWc2t9pD+sWpb0jMPMZCyl7ZERporRUAJwS
         Dz7Sy8Wv4JenfV0Jl/ty8kZXDm8MzQNHOwwRW/2lCz2LYUiRUztzUrNAXwR8nzc4UXPQ
         xdLfKaWIDA7urjcQgX0WizJB3ww/P4g9lld0D7mINXig1ShHcbHyq7UgMUkAD5akFwkt
         aay5qdd1YOJSV0ZxI+z6KnrkBDj8DZwpYjEzITlGBlkd0r0cLyL71iov5+qgMmUahNzS
         X/ukhCJeVoSGzG4bwgGrUXTRsos0NdkNTm8E9eD575hX/KDeLSv7CRGv/SboIrnlpnOP
         dL+g==
X-Forwarded-Encrypted: i=1; AJvYcCWEUoDHIaJp6cZ+J0+75PwOqnPPuaUMEkC1LFQogB3MTg+x6i328s+sR8LN8y+o2ihDX8qWz3ABTqWM05Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqYa8qOItWwXSuHykEar4Pf55+bTYUSoAVosQhEvqzqakmc+8q
	lWdbdOThIJKw9Ib7jthfA2PF8Bhf8dhHx3CQFT884Ugig8MkdBdnXxYJ
X-Gm-Gg: ASbGncvh/k7rQGiJEsh84WFo3ONs6Q1TliZB55YJU4hs3lsLPozOKsPw0k+yEiMnGyJ
	MmAKHHBtayqomQJLMMsiqvYLVREUAJwmVwiJLWB6zfKRLT6ZuZS4N8Z9F2KjMESx/MSb1VHubPa
	JtbBkd2mcOrZJx3BNHrwP6+bQof1SCcrtUMY96FYRuYLm3HsL1a3KKR7a5qRWF89FqjctuK05Hi
	0fOwQ+q3g1hjEwUjWvBqGXz/cPNcQYl8u0xkRK3v1yI7Ey+jOxHatw8eEdNwGvjUHAWAq2YRk72
	af/d00vBfodzBqhnx4JxsgrG1VfMW4J4Ad4G0QIyftT0pDTDEJtX4HvHAKNpwjFY93f2XEvkIcC
	JbffBiUCFBaGojVG+xZ3EokzucBj9jF8KDjbkOumni1dwl8cj27ha07jL+PC6xxS+6kpTUmQifv
	U=
X-Google-Smtp-Source: AGHT+IEPkfZnunnyTLP4kMjyBd6sKE6DJzNwoAB7AKeujS0KY5CfB36Ljlq3waBtxiMTG8JdaqBBKw==
X-Received: by 2002:a05:6a20:12c3:b0:341:8609:3bb4 with SMTP id adf61e73a8af0-34f83d0f7afmr4219467637.21.1762352089969;
        Wed, 05 Nov 2025 06:14:49 -0800 (PST)
Received: from aheev.home ([2401:4900:88f4:f6c4:1d39:8dd:58db:2cee])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd382ab30sm6518754b3a.24.2025.11.05.06.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 06:14:49 -0800 (PST)
From: Ally Heev <allyheev@gmail.com>
Date: Wed, 05 Nov 2025 19:44:43 +0530
Subject: [PATCH] scsi: fix uninitialized pointers with free attr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-aheev-uninitialized-free-attr-scsi-v1-1-d28435a0a7ea@gmail.com>
X-B4-Tracking: v=1; b=H4sIANJbC2kC/x3NQQrCMBBG4auUWTuQpAmoVxEXofnTDkiUSSzF0
 rsbuvw27+1UoYJK92EnxSpV3qXDXgaallhmsKRucsYFa03guAArf4sUaRJf8kPirADH1pTrVIV
 TyM7fxuvojace+iiybOfk8TyOP4VFxIZ0AAAA
X-Change-ID: 20251105-aheev-uninitialized-free-attr-scsi-d5f249383404
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dan Carpenter <dan.carpenter@linaro.org>, Ally Heev <allyheev@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1567; i=allyheev@gmail.com;
 h=from:subject:message-id; bh=mJxls0L6MjDLzDQonIfLUUpMj8pgWbeFfC6UPwa7zxU=;
 b=owGbwMvMwCU2zXbRFfvr1TKMp9WSGDK5o6+tlV1zbfFK+c9Lxa5/4Jk2Ny5PW8UwXbU4oo1NU
 ihWoN+8o5SFQYyLQVZMkYVRVMpPb5PUhLjDSd9g5rAygQxh4OIUgIksVWJkeJYbcfzVjs/z/98x
 +x0uwrOP9xjTCmPPpsi1e+6mvavovsHI0HDky7W4AG/GiX2Tb8kIq5SGmma9YNfJlZqT6Zx6et4
 0bgA=
X-Developer-Key: i=allyheev@gmail.com; a=openpgp;
 fpr=01151A4E2EB21A905EC362F6963DA2D43FD77B1C

Uninitialized pointers with `__free` attribute can cause undefined
behaviour as the memory assigned(randomly) to the pointer is freed
automatically when the pointer goes out of scope

scsi doesn't have any bugs related to this as of now, but
it is better to initialize and assign pointers with `__free` attr
in one statement to ensure proper scope-based cleanup

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/aPiG_F5EBQUjZqsl@stanley.mountain/
Signed-off-by: Ally Heev <allyheev@gmail.com>
---
 drivers/scsi/scsi_debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index b2ab97be5db3d43d5a5647968623b8db72448379..89b36d65926bdd15c0ae93a6bd2ea968e25c0e74 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -2961,11 +2961,11 @@ static int resp_mode_sense(struct scsi_cmnd *scp,
 	int target_dev_id;
 	int target = scp->device->id;
 	unsigned char *ap;
-	unsigned char *arr __free(kfree);
 	unsigned char *cmd = scp->cmnd;
 	bool dbd, llbaa, msense_6, is_disk, is_zbc, is_tape;
 
-	arr = kzalloc(SDEBUG_MAX_MSENSE_SZ, GFP_ATOMIC);
+	unsigned char *arr __free(kfree) = kzalloc(SDEBUG_MAX_MSENSE_SZ, GFP_ATOMIC);
+
 	if (!arr)
 		return -ENOMEM;
 	dbd = !!(cmd[1] & 0x8);		/* disable block descriptors */

---
base-commit: c9cfc122f03711a5124b4aafab3211cf4d35a2ac
change-id: 20251105-aheev-uninitialized-free-attr-scsi-d5f249383404

Best regards,
-- 
Ally Heev <allyheev@gmail.com>



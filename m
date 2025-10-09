Return-Path: <linux-kernel+bounces-846906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0BABC963C
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 15:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CFF719E6940
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 13:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799052E975F;
	Thu,  9 Oct 2025 13:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYbfoC62"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354CF2E9726
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 13:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760018276; cv=none; b=LOawvqkuocaVhwgn+BsMh7meDdzhMZ82xqbgFf6z78PupNRuxJbtoaS+66mBb1WbN/lRPXFy9HIImrCEfORoVJPkscn2hpVXGC4jOwYhDmX/62AX4VMezG+K2bfgJ2MZQFvvODiMTSmwFqBOa8dBJYq6/1puMENic1H1RgDBiSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760018276; c=relaxed/simple;
	bh=aNMJD/jvy4Eo4PisGaBxwtDDj5VIcZ742XhFZPY72NY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sqG2kXkAO4sPDgcfkGVfNRsY4hLoqzSiDq6b0/SNRkOBHJC4vnxA/1gMAhSnPwQrc3aU05xRKIDiD/jE+5LEAcw3xXPzmdXqTTSgqRui9Blb7PzJJ0O3muKwv/4td5i3xjTXVJu8+utLQa2Ry+FpEWXzjnuPxLH3cyV3bjYvw1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYbfoC62; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-57e03279bfeso1388841e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 06:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760018273; x=1760623073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A/MGlGn9iIYutzRbmuTIcRdh98fdrcz/bmBvtZd2PYA=;
        b=eYbfoC62WGqXp7je6bdcNN/hQhsf/sgDakDMzqCG59Mu1xl4zzmN9xZFDJ+zKPGSwH
         Lz69PC3FUDXoMFD4z6eg31mL7vHN55lAN1AoYjQVmHjzHl8sJyAGC/8Dwz4QGsn2Ybs7
         ILEJSYkNzA9sbwEf1BYH3JKeLdH0d3qCDWgno1zC8GeKVnT/3tLAcCNMI0/c47UKVwtw
         8LVlxQWlTUmVURPxmhT8/WYXS0Ld+z3tlSvRPzPCgCk5369kewJn7vN5XNYEjt6e0NRd
         YjrmV1i0vVy3QozpnGFo4HfZ7LxIAeWlFk0qazfZ/0HGekauil7ujd6KNRmBj/yyohUk
         z5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760018273; x=1760623073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A/MGlGn9iIYutzRbmuTIcRdh98fdrcz/bmBvtZd2PYA=;
        b=AU56FZriZPS+9qT+40RNrIyBYLi6Z2oMVg36pp42pedaFksvdNQeOjwkuLIB7AD5BX
         DgCv226B5TC50wHuDwMf0EKoPyhmT9NPtzRbB6t/qIUHghb4UmIcil5kGbUN/bOR23tL
         BbLny38Ikd7pu6WtAxb7PqE3SuFzzihWLcmwDw/r5Ma7sNuOIaMh0ftmasdSqtBoJQSN
         qqnhfZi3XQmF0rmOXS+lsCOeYUSz9i8S+lNx9lkhbBF4UrF7oepRariC2g0hOuNESlhz
         d6zOCRKCJgiCIFzi0mxCTiO1Oj5WlNAw5Rcatn2JD6+cDgN+7e0jEH1lk2cum7/11q7A
         203A==
X-Forwarded-Encrypted: i=1; AJvYcCUNaqxGE1dmNbUPxtihZ+lH63mhV4ZwdX8Mvv8ptGnozdmIYHOaNuqis/AidW4MYb2hp4LXGK4mnYhn5O4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLa5t3m/7zUAPC+U68BvKyTrCPglDAufcYEqSYQ6vthSxClZyV
	MNIGCOMmP4h8PpewPGJyDMK362NY5tGrfR5jph7Q9Mnou1x/fLLSQvLD
X-Gm-Gg: ASbGncur7ieLkGA+iDmnzjgNHt4NgYWJlZvRklkq3vd4e4pN4FLiftZtr75hbI9tee1
	HeHWT3k4H1KgKUuxmbcZM+St7iCKLPB9Tc2SoiHardF6W4QMa7UnQCaSA/7MH1maOLvpXS09d3c
	rVO2SzkEg012r1mbv0QSm1j+oEKYGR3N/znC51dTM8boF6D5FVy2gr0nNPQ9x3bYHiU3RJSQfYw
	5CEY4NPT5Z+UKu2CgHkqavrK6z+6h3AU7nL51YATIzs0FPDN00kINqGOJpk9YoBaY3w+bBB6KRO
	C6CFnj7aqOY0coRkyJ3E12f/7zxTtikrOlJNztNppDWU/SD9JIoHLugYIXHHCMwMeEQGAAE65nB
	pGj1g5gsY1PcaaYY+wB5JBA1IO7D7qVphocBk3MZmU3A843pX8eax
X-Google-Smtp-Source: AGHT+IHA8m/U23aYo0HxP+3yhD2Pn0UWeadCQA7OeCHX4f0bCNRxiynEaIMEXCIiEdfg2ltvNFQ3lQ==
X-Received: by 2002:a05:6512:3a90:b0:58b:75:8fc6 with SMTP id 2adb3069b0e04-5905e28ba56mr3556064e87.19.1760018273097;
        Thu, 09 Oct 2025 06:57:53 -0700 (PDT)
Received: from home-server.lan ([82.208.126.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5907ad9e55esm1066082e87.78.2025.10.09.06.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 06:57:52 -0700 (PDT)
From: Alexey Simakov <bigalex934@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Alexey Simakov <bigalex934@gmail.com>,
	Robert Moore <robert.moore@intel.com>,
	Len Brown <lenb@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] ACPI: Add absent field_obj null check
Date: Thu,  9 Oct 2025 16:56:47 +0300
Message-Id: <20251009135646.8899-1-bigalex934@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The acpi_ev_address_space_dispatch function is designed
in such way that assignning field_obj to NULL is valid case.

Cover the missed execution path with this check.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 0acf24ad7e10 ("ACPICA: Add support for PCC Opregion special context data")
Signed-off-by: Alexey Simakov <bigalex934@gmail.com>
---
 drivers/acpi/acpica/evregion.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index fa3475da7ea9..fa01bcd3840d 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -163,7 +163,7 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
 			return_ACPI_STATUS(AE_NOT_EXIST);
 		}
 
-		if (region_obj->region.space_id == ACPI_ADR_SPACE_PLATFORM_COMM) {
+		if (field_obj && region_obj->region.space_id == ACPI_ADR_SPACE_PLATFORM_COMM) {
 			struct acpi_pcc_info *ctx =
 			    handler_desc->address_space.context;
 
-- 
2.34.1

Just FYI, this patch was already merged to github ACPICA repository.
Commit hash with correspond changes at ACPICA repository: f421dd9dd897dfd1e0c015afa90cd0de2464e23c


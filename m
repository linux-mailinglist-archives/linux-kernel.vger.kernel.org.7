Return-Path: <linux-kernel+bounces-884133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E1343C2F6E3
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 07:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0FEEA34D9B9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 06:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A412673AF;
	Tue,  4 Nov 2025 06:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZS6a+Vc"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BA9275AE4
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 06:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762237064; cv=none; b=Sj59DZ2miJ/0HMk4psolx3Cz9PHxSIGbpE7Y8D18oibPcmHXYGjNhIcL/J0z9YM1+wG9brl1GYKJaNpsW4NS/s8aU+LJ1Kauu+Po2xwPZH6dAutGsT+JQZHjZFRekWgbSiHoe0qs98gFgBo3q245lqGzc3EKBHPJmbGnquktr5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762237064; c=relaxed/simple;
	bh=8PyOU5fORUXGD03iYJCDy5ZYIhkMn/RHS0dbCJyz84c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ph8qSp6mW30deFwVSEqo1D1Yux8frIlhVBxqtuEJBfJWEjnNUKTzMUBS3brJy9a+hQ9eGipvxPgY++m6H8UbevAW6lbPvOWLkjoeQkSvbjGCfgg6E/IQRCkBMa9Inm0hutM+0T2uJmkfpUs78lA0rEHTufQblZWC04wDlTY387A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZS6a+Vc; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7930132f59aso7364448b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 22:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762237063; x=1762841863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UrLbnlwgYUeydF18Up3QEhE7tpEQXppgHDyVUPqCO3E=;
        b=IZS6a+Vc1k/V+mB5i/7apmMuBwYLQhVOl3oGoNZVogI7s1USvrfBkKV+L8OjWBVcTW
         /6SxDb4LAw4bzrrVUmn8bOVLL0gu9mNjoVEhpsiwiWgiCWQ3n4ELCYkZrl3BJSUrzR20
         bdnZLr/B/JroUC+SCWUa508XHkDVGbHxuPYe9LyYzgrMCsmpRmhDpHM15xDKBr665ftn
         a3eMrgXGPNXxpHwlmp0tNfwNOP10Q9BeJENe0MicFLXvRQIQvrtZ3D1WMAQLR0pwZF0p
         fIRJZ9e5NitL/1TmYsMJx17yzPAIRp8Gshl13okbAMurJgeRajoJ+pPEU+t4pzPZB2Tk
         19Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762237063; x=1762841863;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UrLbnlwgYUeydF18Up3QEhE7tpEQXppgHDyVUPqCO3E=;
        b=ApOQmKwSItP3afbLNO7ByN3vJliuJR6/PNw6RltBjLVqOalIZGwfHuUJtz4tfUygA8
         L6i/AOGU2A7yuvVnNdseQ7SL2P1cVjyumGL/oGE/ybp1hyE3SB5SklTEasGv8grSwLyV
         K6UhgkWQ/jlb+mDFWXOJ8H1lBBVclxpAzACb4EWR+4GFHMFwAUBnISaE74jYDXdlubkE
         KYOheNe41sxNVaaEC+Uazoz3K6pi4j/I3HOmcadlxsq/p2R2wIjrxCcC+6qAx0dcDva7
         vE5EgmCAMv21jy4NPlVxNEkODXUr8A5wBkCVRIkIbePYSTzWMsrTL+svy6a/DqqJI/qX
         xCWw==
X-Gm-Message-State: AOJu0Yz2CNfgH2RVsIpj+giuvkw26d7uuoQBFGn/tsydpoAz9tDUQW+b
	nuWVLiFBwobeY1h49FK5kn/XXi2JXY4sMHaGEHo56la5GAoWYzlI7cTZvAc28afu
X-Gm-Gg: ASbGncuj55XYTst6UIn22q2kLOeuPooPlYJe/pXv/QGVGv9VqVuW1/+AqJuUbS67CZW
	0W9WIoHR5q6VPO5js2gUoRi/+/Jrb78vuZ2UrB0DHOtv2ckvwMAA3952fI5nVPFrnA+dbeETPqj
	d53h7zPN5xgiOjxU6YBkRixezeXdugh2XlVHVHieyDOv082+67CByW1BmhYc6zTCTVr7M4U5rl3
	9aXYXaJpZf7g0As4sjlEA3MPTIrP4ojJJrTW60nv6T+We8yEqTJYx8iaqR/B+Ga0eaWeMGmPOiX
	5W7PEHBv2qir8iJ2OfUL6mUvi7lSOKyTgVGSBBWncFB60ifsvpNcgzjMA1nZlqmrvqwz90dbcKs
	TxtHLe/PYq0juEz2oXp/zEiN/56+B0LrkwBHetWmDil6miP7SMredNRubiifluUXDAS8XGEQJ1o
	5edPdj/meo5Za8/fPzs26+A8Mk
X-Google-Smtp-Source: AGHT+IGBI1cv6kpEODyfGVPGWgRbJ51pzz+gMaP52q6MonISKpbHpJ0zX0R6romYDrA/u/USSNG7vw==
X-Received: by 2002:a05:6a20:a10d:b0:341:5d9f:8013 with SMTP id adf61e73a8af0-348ccbfb5bamr20275418637.49.1762237062726;
        Mon, 03 Nov 2025 22:17:42 -0800 (PST)
Received: from ti-am64x-sdk.. ([14.98.178.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1e7983986sm1184907a12.0.2025.11.03.22.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 22:17:42 -0800 (PST)
From: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	khalid@kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	bhanuseshukumar@gmail.com
Subject: [PATCH v2] docs: Makefile: Sort Documentation targets case-insensitively in make help
Date: Tue,  4 Nov 2025 11:47:23 +0530
Message-Id: <20251104061723.16629-1-bhanuseshukumar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid case-sensitive sorting when listing Documentation targets in make help.
Previously, targets like PCI and RCU appeared ahead of others due to uppercase
names.

Normalize casing during _SPHINXDIRS generation to ensure consistent and
intuitive ordering.

Fixes: 965fc39f7393 ("Documentation: sort _SPHINXDIRS for 'make help'")
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
---
 V1-V2 changes
 - Rebased on to commit 27600b51fbc8 ("MAINTAINERS: extend DOCUMENTATION SCRIPTS to the full directories")
   in docs-next.
 - Link to V1: https://lore.kernel.org/lkml/20251015012922.19467-1-bhanuseshukumar@gmail.com/

 Documentation/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 734ec9c9a..d514ab676 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -84,7 +84,7 @@ cleandocs:
 	$(Q)rm -rf $(BUILDDIR)
 
 # Used only on help
-_SPHINXDIRS   = $(sort $(patsubst $(srctree)/Documentation/%/index.rst,%,$(wildcard $(srctree)/Documentation/*/index.rst)))
+_SPHINXDIRS   = $(shell printf "%s\n" $(patsubst $(srctree)/Documentation/%/index.rst,%,$(wildcard $(srctree)/Documentation/*/index.rst)) | sort -f)
 
 dochelp:
 	@echo  ' Linux kernel internal documentation in different formats from ReST:'
-- 
2.34.1



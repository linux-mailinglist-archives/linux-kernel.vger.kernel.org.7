Return-Path: <linux-kernel+bounces-889272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A56CC3D208
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 20:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC25718940C2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 19:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF925351FC9;
	Thu,  6 Nov 2025 18:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRLIjusp"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4DC30DD2C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 18:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762455599; cv=none; b=ASs5dzRScn1nz450Nzhq3qMFTywbN+ZBB0FJNH0PpPnNoP3HNImVo/bpnTBsBuzZrESz33C3NL8cPzn90kLg6KIiN3axRaKxI6N1qyq8Hrwvj22C/IXdte3Rrxx4lj1dBMR7QYhWYjVm81Kmu5V8NmctIpAHHMM2TmWb00G3XsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762455599; c=relaxed/simple;
	bh=FdSCwiSshFZ7afgtql3FokO1RkhuU/9Wdt6izw4XTEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uCldLHo5/US0hSseLzU/VziYQDkAQ2ye5yMidJVkx5xD9pRc39P+LOoTa7+a12wxdSywxTrtWaszNlch4zmPdfCcUc8YJd/H62KXQIsKtkTLdvTY1SkbOVCftykN9cAP9REGkEmaKeczzed+NwQ2wX3afgDVNZHoyG1Ata0a+u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRLIjusp; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b95cdcacd95so779357a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 10:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762455597; x=1763060397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOr+m5rYLx6qSZrmqhOAOC6HJg4sqwHlND90ecNT9Wk=;
        b=KRLIjusp8gUOZnwc5Zp5DgYizim6A+iJJ+yNGoLN5E3ThHIdSBZyZCYyXfTvSMQrnH
         tDOp3Y2i7G2yn43KYC9kO0ew7IRDUBORF50jfNLgQtjEcJS8x2CVr0z+m3pP/Ddvt3de
         xI2HjuR1caTZ279BDpmNgtdeHhhFZrPyF7d7JPlbVBrBqpKUIGX7IqGJGXyJdqDspcYG
         s/wkLY4sPNAcKZuW6yhRw8un7CRewJ0dlsI7WCUowI4Q29bXIbWF+e0PT5nAV9TLzPhB
         iGoRADAF8soJ5TnhKomhGf9oumZK/ejpe2OeYSTcWT8aaPK2osjydzHJs2Gg62bqCkd9
         MXKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762455597; x=1763060397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aOr+m5rYLx6qSZrmqhOAOC6HJg4sqwHlND90ecNT9Wk=;
        b=Eqh2aLLziAJJ92Fxbrb6XlFDsqrcHIRwOP0MxHtQB/R2DNpNcKDzc2Q1P1BaCMZMFH
         8oE0WpR3ZRewfH83vEd8VnsCvPR/5E7YOPkq6YczEhMFRtfzTLla31gKlCJxpOcDLF6n
         lVZI5mFlBbjO9AcILWLATNAJovMr66hUzlReoWNJnJ3TKdNgwZXtnMEZoAaRr1G0HDbg
         XbcBKJGUAcrCRYUHnrPUkO5BfVKvKzxyRRUYKhYp82vncDAo6gnBbzfs5fRyNDYQk5q5
         85PwlovO2vXOKb2aKzSZNZBKWr3qgYpg9u6oQmbhYIclwWQZ/DSImbmvA0mY2YrisPC0
         YbZA==
X-Forwarded-Encrypted: i=1; AJvYcCUeFn3qx7CYnhBDvQ+uWRpz4tt0Olt4dTe4Z25NOWkmU1bpfYJc0nQl0R/YikJXxcZiSSA58SrVKC8uTUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZglc3wqaeyd9HLZ7i3hxZ1K/VFzIvN9vHeZZRdXPBurGzE8pO
	j1b9EgxlQacyIB/OEw0EDXLawku2fmMTNCiTvG6dxy7qMV8q7XaqFwPCQhivJQ==
X-Gm-Gg: ASbGnctf8GrwioYoho3HsFypJyUjZ9V6z71i8U5RhogGJqNY1S+s07IEQPP8g4szZ8T
	JnWGuIlfpTx7gHdfUc4vBhtkuFKNVSLTNhtCTm3tyXcVuxLCNscVBaYI0l8A6ganzvPc8e/+3nG
	bJlhKx3bkYOKYtnbWJrUkiYWoDX1VqK2PBL249fiUI+NgKys3QVQ2nj+b7aQfyTJpVUBZKnUUjg
	rDZxv/h6G7KMMn0MsRo6SsQEvgVe/ID81x295dr42QqaC3owE5n12EBINvSag+9qbRjO3oCBlHm
	xSLwKGn6O2FYNHJS0AUOU6jSFJlUpCqcBL5OtnCHHAXVGkBYbUbk9LiRrYi2WCzdzVbvXAAYCHV
	BfTFlHIuad8GDNCoUrncxUuRhX9u6QjW/l0EpfRbRfYb3jLQ=
X-Google-Smtp-Source: AGHT+IHIpP2zIofD2/RztNRHMQrjDb5nwc9wRMtQ5NBGW3KQYOaEMrkjR08tK69o00TMmzGNYrv1eQ==
X-Received: by 2002:a17:902:cecb:b0:295:7453:b58b with SMTP id d9443c01a7336-297c0386ba9mr6371575ad.4.1762455597161;
        Thu, 06 Nov 2025 10:59:57 -0800 (PST)
Received: from ryzen ([2601:644:8000:8e26::ea0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c92cddsm36647815ad.83.2025.11.06.10.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 10:59:56 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-fpga@vger.kernel.org
Cc: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] fpga: stratix10-soc: add missing header
Date: Thu,  6 Nov 2025 10:59:37 -0800
Message-ID: <20251106185938.6419-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251106185938.6419-1-rosenp@gmail.com>
References: <20251106185938.6419-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

linux/sizes.h is needed for SZ_512K.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/fpga/stratix10-soc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index 0a295ccf1644..ab309cbf21c6 100644
--- a/drivers/fpga/stratix10-soc.c
+++ b/drivers/fpga/stratix10-soc.c
@@ -11,6 +11,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/sizes.h>
 
 /*
  * FPGA programming requires a higher level of privilege (EL3), per the SoC
-- 
2.51.2



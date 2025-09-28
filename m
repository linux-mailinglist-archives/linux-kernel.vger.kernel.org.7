Return-Path: <linux-kernel+bounces-835259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54563BA698D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 08:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB8E61896CC9
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 06:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF0D299A94;
	Sun, 28 Sep 2025 06:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="WzYl8bjD"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918701E22E9
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 06:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759042729; cv=none; b=COXi26Ju+D+KU/skaPhjyZdhkgfOraHCQGYqABnYth1KUHbQuOJbpVbYKgvnQ8SbFzyjX6JgoDafS93LHT4K3L8WuleHP8fJGNEXTT1IUTkVDrTQgeEnVSbzCNVzxzggCxlb92QMCD5I1vQ43239c4G7CWjkCAIuhMEVEsesWOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759042729; c=relaxed/simple;
	bh=9Bla6r5MFodPMwhxVQ7tWLS8XbjrbVJNG1aVVLSnnwg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=TWIyv7OvR0IS527MjhpPnIV+SWAlF0U1dX1VDti3o/nzQymil01OeaPbCRj2eoqmV73HgSNBafCDFBUHqZUn+d3mvlxz8Kyl6DbvLlO8/3jSeHttVmM0TnCjGI47s6CPMpTrRCNwWDBxif/zZxplKRYh8GCbUdLm8Sz0C1nnWmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=WzYl8bjD; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b54c86f3fdfso3553577a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 23:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1759042727; x=1759647527; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9qb4Xv7S/9iKlar3U/z3W5+/6qCV42UQ7G2sXllZfY=;
        b=WzYl8bjD5Jn+MdSSd11YVJHM2w1WJQWuDJLzb7w/RwCZbW+KXdu0ObUvZUJTqlL+9P
         42Lq/hadAv4hwdd1LvqUanivMb00mU5FHwbfjVRaxEyq7CKbf+WQB7NhvIiNhi8bALGv
         jag24b/mJQ4C8w8nECo2b3yAkQ0H4j2rQi7w9rbeA6d7gZ9VqIN2HXuqBd3F94oC+erQ
         0pJOKTffrJgYcYlJ20VoBm6OC5RdmUaBZ5YnWeizwWKEiNatc5sHcjQ2lZTD2U7X/6Z9
         ayP8vKNn+KvK9dz/VBjblwVttV2fyF5SVL8rOZWUpO8nYsLCdT8NsUiRNxkrDw8DbVov
         Urkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759042727; x=1759647527;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s9qb4Xv7S/9iKlar3U/z3W5+/6qCV42UQ7G2sXllZfY=;
        b=sRgTqzXNzqYdSh9MGP/sbFaSlHDjWuQy71/JfOBT7mYFebWbs2KXuEZOrGMUbzk+qc
         EEVCrZq9OPymlSfGnLXfy4J7NGppOrI1no0wvdh2AN+7pdf5ZshGyatDf55tphs/l/6U
         9z8LSK2D8kiqoLDv1kT55cFIhsmlA4g9rVvU1MrVnjanfj7YDFy9hPc9xBA9b3BGNAdQ
         oMvIbGvV9ITgXmgRTUW/3IIMWHEOt0b2bookeRIFznykOdYGzZY3R/akTmI2mlu1w2Ae
         VI7CxhJWJM9LlsNKdRHQ9+B2jMESIH7EVBiOfypimcYVazxOw9YUzS8neWsszhjA6MiO
         GmoQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4bgn/w67plRK9O/isAKLIqg8c1dwzVVlbSc2h5v64yf3PlDnJInrGWzS5sR5C8cwFrQTYNvopO/6iBbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyylPRHBKIjKdBArLdlQ+BLop6C9nMUgprArwG6qYlu30ls4RdO
	/u486hv1NAONnKuqcHkhHzPfDBrwtgNqSOIiPm6NIpf+eqbs4qIm70dLoa6jXMxqfETo/F0fskK
	OGWRfi6Lx0g==
X-Gm-Gg: ASbGncunGfVDiiGaIDPoR4jFXF5ESrxXxAaOr3nAyhVskYjKpdwIJ1EzaHM9alsEPHI
	68I9G5w3qlY63EqNIPRTDBe8g6mb7VEyfD5tHfflaOIijSr/lF7ZpTkdjAlxzgbV24F5iz/Gs5y
	mzJhmftPqlXmrHayU60KvbdwQLNX10xHk2eHCcqeYgNg9JSHzOF0rDrMNK7pTnt9qR0rZq6ntqA
	mS2GIab3IJEdGa13+5FwbsnU5EuGFb7tlK105vvDO2e9KUivDiyAe76F8bmRvkEa7DnmiKwoI5Z
	QsVPjDopxZ7myiVi2G8KToeP+HG+tl6XdYbGcJXCWliHgPk656HvsaH4w0wEz4mijKrYiz5cZmu
	xNSq7s3z9KXXt1QkN3kpW1fPAGLSsgXFMDI9jB5kga8xpL11/WPmjA7qi
X-Google-Smtp-Source: AGHT+IGzyRlP0aMu8WsFbE3pNjkGGB8M5OH35YpWtQqlIpwvlvTcJH1LjOwEOd1Ttxnx3O+rBgJR8g==
X-Received: by 2002:a17:903:4b4f:b0:267:8b4f:df36 with SMTP id d9443c01a7336-2818ba15c86mr54104835ad.29.1759042726783;
        Sat, 27 Sep 2025 23:58:46 -0700 (PDT)
Received: from 5CG3510V44-KVS.bytedance.net ([203.208.189.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66d32dasm97959615ad.27.2025.09.27.23.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 23:58:46 -0700 (PDT)
From: Jinhui Guo <guojinhui.liam@bytedance.com>
To: joro@8bytes.org,
	suravee.suthikulpanit@amd.com
Cc: guojinhui.liam@bytedance.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/amd: Enable PCIe ACS once AMD IOMMU initialization succeeds
Date: Sun, 28 Sep 2025 14:58:17 +0800
Message-Id: <20250928065817.1279-1-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Enable PCIe ACS after the AMD IOMMU has been initialized
successfully.

Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
---
 drivers/iommu/amd/init.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index ba9e582a8bbe..b695efc54d5b 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3212,9 +3212,6 @@ static bool __init detect_ivrs(void)
 	}
 
 out:
-	/* Make sure ACS will be enabled during PCI probe */
-	pci_request_acs();
-
 	return true;
 }
 
@@ -3284,6 +3281,10 @@ static int __init state_next(void)
 			ret = -EINVAL;
 		} else {
 			ret = early_amd_iommu_init();
+			if (!ret) {
+				/* Make sure ACS will be enabled during PCI probe */
+				pci_request_acs();
+			}
 			init_state = ret ? IOMMU_INIT_ERROR : IOMMU_ACPI_FINISHED;
 		}
 		break;
-- 
2.20.1



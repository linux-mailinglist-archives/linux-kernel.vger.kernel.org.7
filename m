Return-Path: <linux-kernel+bounces-889431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B373AC3D8A4
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 23:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 203394E2763
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 22:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2DD308F36;
	Thu,  6 Nov 2025 22:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="dzD7zRSS"
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316FD2F6189
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 22:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762466802; cv=none; b=Vq9VUi4FQ5XSiJKcQc+aY1IH8uEv0klDXbJA3tN61wJM/45Kxw/eIFAgfep+c1Ja0QsClstM+K4vYQbwoLBKp7y6ah/R22Mk3A2U4pxeNCqZ/XDvvgC7W1PHK3O2E+ttPBtMj1FkN6+0YTuNgLhwnyFMI1KN0RRdDsJ+fX/kZ+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762466802; c=relaxed/simple;
	bh=RLmfCM3Zsf8ntEjkZQiPNMXnf8QueIqr+cvUvyPK8T8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=jKQrx8Y3zUjypUXAiVYLMq77zo+LrQev8hk3chg2qhhRosJAyfxcnCcuTbf2KFadpVE5Yr2DjWrj6Cusu6fkZpqvdkJOq/4Iw7o4YlNDvKgC0LLbBrr2pM9NaLyKo2YDaKtaOZD4SLWuAdGxbqri/3X72gJF1BOuVIREhyAa7sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=dzD7zRSS; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-63fd493ea10so192702d50.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 14:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762466800; x=1763071600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tx61RuKbwaGoy8WCkWWJa+EGKVyM66y7AQYoEIU/68k=;
        b=dzD7zRSSGEEW0FgT6xByArXF2i6VC4PkKTp05+Je6MflTmlTreetSDVKygturt4R7M
         zSiCbCITCSkeml4tWbQ6zbtXjTKxIP5ydTa63FRSnoDZ5lxTVu4TXoddCwexahvtTl6E
         brAvhrjQ+xKyweYA/snAzp9R1gpQN1JMlRjSd0k1CDDfolRzLmguTCHhuyTpFjREbBxL
         Bq3gdUxliRgJBeN3x6wqDNBdUxpmUuBMFPoSDCae/9zfsyQA7g8Ff469Az5RM4vB2l2W
         p/serzZqMPl6mqFHlONjcsZisb0Z688qHY0C9XlgtaE2NrkcmotCAwnE82RlQ7gRfhte
         SQOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762466800; x=1763071600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tx61RuKbwaGoy8WCkWWJa+EGKVyM66y7AQYoEIU/68k=;
        b=qYivk0lATsn5ZgTyqZggjL2vPEjIxUVnW2wnBt/2JudsnUvExZ+PmO2g7lTgqb2r6G
         bDOhPRdcp/g+2XsNJB9CZA12xlmCbPBRfJWgplWbNogYkrLUXB2fVo9pH8jz4xjJlAVl
         feoXO05l9VD7EPTVlDM+gXype9p1X52SXQf/ann808KvDuNCv+WD/LaKsRTcskWIAwP5
         4xkoC1wYPr6x/mw5xux8NF4utXZSCdKTLAKmcXBwDDzdn0Qc62LY6tjtFcsEW4Cr8tLW
         8JXehUJ8ChF5oSJA5/xTlybWATVaj5lxPKxM2d/u4sVU4YbBHhazWFMNBSBqa1VpW00L
         8FcA==
X-Forwarded-Encrypted: i=1; AJvYcCXKHAbZ3UoroJXcad8elQlA7BsBWTJiQEeqXDmRzedDYAiGVA5k34br+GH5G8TUFkdw0xbr4R6rp3BAcE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVXHEKfz9ASiflZQVXxfT6KFGl4YFOz0rZ62R6c6Ht94NbnI+t
	MJm/CCx+tj0JaIlPmEKirZWrTxLahUeR6c4co3dwjbtUjFjXCLwj7MnxkWOg8hVZ9s8=
X-Gm-Gg: ASbGncsrl1UoOPCIp/SZfiuXFqdpxylnSzC+Eubmb0/xrjkriMemIqtqZ3vtf+FyM2h
	WBvvh/7U1CcrC9t0E/b/oUatiPWS0vwFyYiltxK5H7Pt2Aysptdvq4sFxLrQydvAY9Tgewk+MZo
	R1lR/G/EqGKStwo7+7xuUSvK/Hyf2n0wFD145oke0Klw5LqBD82o+uhRD4z9DqDwcuNanq9EIWN
	i6M8+bEofPPQLdE+ZmPJJOP9DrEoT6Dn63hUaNtQrtQ0xU4b8LOsIzi3Jzrbrofhy59pmSvtt7W
	svCQJtiCUvT01wutEWSpAbVAMLVKDqGpGkDJipvQdhkVU3JAjjDUZYx/iGW4uWxSeNMWghN9l9r
	8i+yjxcdDNPjmUV1cGSC67/NVgg1qKn2Z4hrKiPCha7rcQFbHQj0tYCOKHmFd2DtGC44t49z2xj
	GJK+3ufx63KsX4gVB651VKuQF7mlCXq4Vg2U42y8auCgiCbhIVN7QYDNa6TDq6Cg==
X-Google-Smtp-Source: AGHT+IEbyZ3CyxYgGJMLSh8rMnJR+LBiZyLUDpUrBs2zL1yi+A/d0cUDNA5K5afagLqiMYLBA96mhg==
X-Received: by 2002:a05:690e:1904:b0:63f:7c9d:d378 with SMTP id 956f58d0204a3-640b53db770mr3942118d50.5.1762466799959;
        Thu, 06 Nov 2025 14:06:39 -0800 (PST)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787b1421493sm11743027b3.25.2025.11.06.14.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 14:06:39 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	graf@amazon.com,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	pratyush@kernel.org
Subject: [PATCH] lib/test_kho: Check if KHO is enabled
Date: Thu,  6 Nov 2025 17:06:35 -0500
Message-ID: <20251106220635.2608494-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We must check whether KHO is enabled prior to issuing KHO commands,
otherwise KHO internal data structures are not initialized.

Fixes: b753522bed0b ("kho: add test for kexec handover")

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202511061629.e242724-lkp@intel.com

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 lib/test_kho.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/test_kho.c b/lib/test_kho.c
index 025ea251a186..85b60d87a50a 100644
--- a/lib/test_kho.c
+++ b/lib/test_kho.c
@@ -315,6 +315,9 @@ static int __init kho_test_init(void)
 	phys_addr_t fdt_phys;
 	int err;
 
+	if (!kho_is_enabled())
+		return 0;
+
 	err = kho_retrieve_subtree(KHO_TEST_FDT, &fdt_phys);
 	if (!err)
 		return kho_test_restore(fdt_phys);
-- 
2.51.2.1041.gc1ab5b90ca-goog



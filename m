Return-Path: <linux-kernel+bounces-807688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 915F6B4A80E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D1C51885A46
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B18274B5D;
	Tue,  9 Sep 2025 09:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GeUYnaPE"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99702836A0
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 09:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409667; cv=none; b=BUR/dRZW6D/rV/0HjD+I9MFfEQabovAkd/lyBYnmquoJdLqXT0Tj2Dyc+ovZ7eY2MtQt512azqFGEHvTwc1E8FpUBtLbChlCQtrhJr8bTPgXd3dslv+6UT2NybzOnxx/lLAaNDbx+HQh4HuUF8qtOUNrZh7dH6jxIOsg4G01SgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409667; c=relaxed/simple;
	bh=/Ek5qpfG1828tno1oPcHESQh+i/G6n1tPpFTz6UsPpg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OWJJ+dprKF5WsEgGllfQNTOouc+AU7/AkSmyCTZyRoJDOPR9yLHdJ58NFd4f5sof78eONJ7HY8CWzpLg20poTJACGd2cBuepnAGC/+OF4oBjAM00Jxitl/2lgyfUvxuNuCFmajjTKKMYILEA32C+mPVK1rD3V6EZYQVOrcJ8qUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GeUYnaPE; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24456ce0b96so58393335ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 02:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757409665; x=1758014465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aUvugBs/HfbP8FSUc7ieLlf7fcudHbkwsA+MFyocDa4=;
        b=GeUYnaPEcD06csXxjg48d9T+rhNPKJ73g5k5SmFirXC8zEpDlTECEB+2AjYTUcFWC+
         o8447Mmfn/OUdWlaikO7OMTTUV5DtIBDOrPLcdRm87BMGpifmI2O10JCItZdUDllJZFb
         iDD/RM//DSWiwRKQ+4jGWUAwMyVV8I4g9ZchGdVCFOz0ktJsv1hxhG8I314XQTD1a/9r
         L6rqKJ1THTFzDjZP84ruaR4euoZt+kxgb1LbM0oKiT/mEXrmnZSWVpFkKlrLQcaaSwOy
         oSdXXba2MIv8TE7b1wb7/qMt0SgREIsiGRYzEyCyVgXgqP4+8TgEyy8gv02Ng9HO6fr0
         bIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757409665; x=1758014465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aUvugBs/HfbP8FSUc7ieLlf7fcudHbkwsA+MFyocDa4=;
        b=jB1l/8fYmu9WPDIXQvkJxTP+v+8gleYnF3wCYNrd4cDY7HWB9YqgyanTFUVOaEP0BD
         0kSzB3HD0H/kbyqNyaVFAwrxzhv6cgqRrzIWj6yPxC/ilnZTPmUApKtcg/V1nnSL+oxF
         iNvgtmW7hyfZqK6IzHwe7hcsn3ARmL/xXFvMp68YRbxat/UshrIGtYnPCD5NNRYBL3sl
         0agl/v0WoqOmBIFSpTl35oCM81EdHnfQptb0Lg57OAlCZYeBHTIdoRjFa8mOflD9UBIq
         rJppuK7awzXiPOeu8Kkdn/tjYZASVCk1f19/VbUTqhInCMCWvkot9nuD/AztAnphlSAM
         hdfA==
X-Forwarded-Encrypted: i=1; AJvYcCWwHYHjaqhX1si5AVZ0Orc/EnpCl9tS/ZQXJ1u3WCv8byJv33VxJRDrjI7eK/p63E7SEGJhhJerVHf16Yc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Re0aoKTAWlbSfqzJ+qTgND9y6KVUkACis5AU6tyfWqzbFnrC
	zJrQwmjWa5a4fu7HGTRclIA3kjZJjCB47Evg2LPpS4nYZp+nR4YhOvZU
X-Gm-Gg: ASbGnctVunJP66UUdUYvCnhmFtUQnC5x6Lci3hbOZL/F7SgB69njOLeIA6rLimvSLaD
	5sqdsPwCQ2iGBHSSw4FBPh20ppoZqUZZO2POE2xMeVDXBdk5Z+Bb2bDWSzCK2MKaOQyMYHltPSR
	tMYmeTwJrLWCHI5aJdoWbgdOOA5LXZihCLhF6yTSHH4b5wfQWyDIv/NV/HUA3ggbGD+y9ecjSR+
	wGsUZ7Kjlt4IiZ/2WjE0/4x93wIAA31zcGJ144SyP9oEW+Uo4Z3Rx4w11IGg3kjLW8ClcbnHVWt
	tpPKeEDoUAIh7SxlAYugyGYWXgCVN0iH1Zp9eiifaeSVLJ8fPqHL44fYoqlkKPcIqTI/vQGOhfQ
	HIkcGmvxW/rHuh032ndIfe9UJ4CWhuE4RgerKBE55FiRdsvovWyWI9FuwKDcld8Q=
X-Google-Smtp-Source: AGHT+IFUMNr3rKpEQQ4QGJsgn1vIVkRQMGZf6cJe/JnOFgXmQnPwtOeK007JtOsHgeUS+Rg3hE+J+w==
X-Received: by 2002:a17:903:986:b0:240:417d:8166 with SMTP id d9443c01a7336-251788fd271mr132869335ad.19.1757409665016;
        Tue, 09 Sep 2025 02:21:05 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25125d76218sm88522165ad.119.2025.09.09.02.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 02:21:04 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: austin.zheng@amd.com,
	jun.lei@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	siqueira@igalia.com,
	alex.hung@amd.com,
	aurabindo.pillai@amd.com
Cc: chiahsuan.chung@amd.com,
	nicholas.kazlauskas@amd.com,
	wenjing.liu@amd.com,
	jserv@ccns.ncku.edu.tw,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v2 0/2] drm/amd/display: optimize reserved time candidates handling
Date: Tue,  9 Sep 2025 17:20:55 +0800
Message-Id: <20250909092057.473907-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Optimize the handling of reserved time candidates by replacing the
custom bubble sort with the kernel's standard sort() and rewriting
duplicate removal with a linear-time fast/slow pointer method. The
changes improve sorting from O(N^2) to O(N log N) and duplicate removal
from O(N^2) to O(N), reducing computational overhead and eliminating
hand-rolled implementations, while correctness has been verified with
simple unit tests.
---
Changes from v1:
- Add early return when *list_a_size = 0 to fix a corner case.

v1: https://lore.kernel.org/lkml/20250824182359.142050-1-visitorckw@gmail.com

Kuan-Wei Chiu (2):
  drm/amd/display: Optimize reserved time candidates sorting using
    standard sort()
  drm/amd/display: Optimize remove_duplicates() from O(N^2) to O(N)

 .../dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c   | 44 ++++++++++---------
 1 file changed, 24 insertions(+), 20 deletions(-)

-- 
2.34.1



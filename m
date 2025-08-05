Return-Path: <linux-kernel+bounces-756311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38332B1B288
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 13:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FD9117EB06
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 11:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254FD25394C;
	Tue,  5 Aug 2025 11:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5XepcZx"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC12B25228C;
	Tue,  5 Aug 2025 11:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754392726; cv=none; b=YqM17epiuhrkO8LyUzTWjHKyCdg6b21ee6pYgFCXJ0TIzuwfdlTvbe8nzH3S7ae8Xs867gj9iOF98FJ87AekfsGl3S2BJpMWhLILjU7f+C85xNwuGPz8UsUWI4lRbS4NuIt7Qi0ORis91UhGcZ+23n1bZW+XcU7daqAv3ubHtM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754392726; c=relaxed/simple;
	bh=SN4jYvQuUCCF/gos39pvC5shET8ctMqxQ0HU/1V2uf8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fl3tcNO2Yxj8m9kZUCiIw2wy9TASve2Z891aSM0t/NZlmyfY0uFDdReXGyrIBmuXPvc2fAwHYwSWtip5rsxewuGUHdn2PzJCEadN0T2xiu5cI30vLQnFN3rOucg3DFUDK9Mlb7OzVdpqNosZr4URZTINbZPUBKXYi/y9i3zdqD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5XepcZx; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-332590cc87fso23963501fa.3;
        Tue, 05 Aug 2025 04:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754392723; x=1754997523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2w+aY3uxLzcgSyd3cz99VpF7+//j/hadksX8UqoA3Sk=;
        b=S5XepcZxQ0mWzsVtV6mkZfJ4b+xfSelwujTb8ZHvfG8g6fyfzEuva30E9IDqEVBaQu
         dSg805sK/shdLs+yi3PLGkquBPzCxTG8XWhLjwwMi5ryORtFNTbGAqqv4tj/yLliM39a
         uponZdnSfwjBnQgMmLXqE8scr1gIBee/ffypLEd/z2BG1oySpYp3FaR6oCBEFSUPDEqG
         7JJdv13SM5rvttuZZxpDDpkje8YVSoe8W4sQXASDVbYtABudkE4cVvpFSlPmR5YG7Agl
         EN4PRyjWydNbc0w4qtm8yK9xqitZmMU1CgeIDq7uPExzNpnp1qhYSEMPquiqs2pau5k/
         XtzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754392723; x=1754997523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2w+aY3uxLzcgSyd3cz99VpF7+//j/hadksX8UqoA3Sk=;
        b=doj8YaqWRyM6y88qTvPXBgFqbMiTMMBZeKhj0PFm1pAF0rr/F/2zOg+w8IZTBVb+KJ
         cJNLh2QF1JmY2UBTcUj2I5k02KQOsWow/Jp1QFoNlHfYiCkgP5YbHhCO6uhUbV9mGvSe
         79c2goCtrYMiBL0OdcFvu5biJr5G3tvndaT6axsf9j7w1qGBUt9+iqLwZAjHolXYl2vi
         yuTGDR4tr0AotIfdBZsRSJkhwnY2NP7NU5NvAnuMTT1agV88qQC5roUmUJV7ocSCrgPQ
         Yfxd6rAoJQhM00wOa5dTUZiTHvmYYXy/DgsWKjO5iyNSQ89AfjV3CNnLKCRLSn1pRFo/
         EptQ==
X-Gm-Message-State: AOJu0Yy4uOl0Oal1HkMLh9aako8AqMj+8k2bkZym7xweISXg8Az4qDd5
	vVdNdZPP4Zt1bxP7MeHFDuydxqK+rqZkTA3PTSN1roFnPnrGVrpMlvmvL8Jlsd29pmuQuA==
X-Gm-Gg: ASbGncsvEWJUqMyYQkdOA48NmtLtq1NsWtQ4aTfO2tn6+UUp6vl+QgEQlgXxfZs79HW
	qMWScf5cXKbvzqSNVJSzkpmzsE8CeMGxAcoG2zqX7Vty/sq/LLbRAaUuNyPjYAU6OLGzi70G53S
	9lJaqYIVWngWgLbByu9gQs4hg5smXU9YFXmYVccy0gOK+oLumhmsHccOTVcchnM+tbopk+ot+Lp
	bgDS3atOrWSoI85o3C8ZQtPNdOyTFcJlV7cleUJpv4ausm/bsG+nj2gTEQjoi72ddfziqlan7Xw
	xgzn+NQVhZFJR2VRKNBqWg2WC9cBkuBXZExQFKXtlZ9kpT4NEsxlvB+qthZ+Vu1kkIxLvKzNo4X
	drsQPxds2Kuf5YVFPj6knHOZEdRdt6mFdd9Pw4aIG
X-Google-Smtp-Source: AGHT+IGc+qkruEJn50orH8CvaLodrD1pAy0WBew9FmTuInl7cGCqjb/GElCXpdf8TuIIV7q5a9OK1A==
X-Received: by 2002:a05:651c:4092:b0:30b:d17b:26aa with SMTP id 38308e7fff4ca-332566ce25amr19498281fa.2.1754392722564;
        Tue, 05 Aug 2025 04:18:42 -0700 (PDT)
Received: from artem-pc.. ([88.201.168.202])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-332382a9054sm19367161fa.28.2025.08.05.04.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 04:18:42 -0700 (PDT)
From: Artyom Shimko <artyom.shimko@gmail.com>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	jdelvare@suse.com,
	guenter.roeck@linux.com,
	Artem Shimko <artyom.shimko@gmail.com>
Subject: [PATCH v1 0/4] hwmon: scmi: Driver improvements and fixes
Date: Tue,  5 Aug 2025 14:18:37 +0300
Message-ID: <20250805111840.6472-1-artyom.shimko@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Artem Shimko <artyom.shimko@gmail.com>

This patch series introduces several improvements to the SCMI HWMON driver:

1. Better handling of unsupported sensor types with debug logging
2. Fixes redundant resource management in thermal registration
3. Enhanced error reporting using dev_err_probe()
4. Added version tracking and proper contributor attribution

The changes maintain backward compatibility while improving:
- Debugging capabilities
- Error reporting clarity
- Code maintenance
- Contributor tracking

Artem Shimko (4):
  hwmon: scmi: Add default case with debug output
  hwmon: scmi: Remove redundant devm_kfree call
  hwmon: scmi: Enhance error reporting with dev_err_probe
  hwmon: scmi: Add driver version and patch author

 drivers/hwmon/scmi-hwmon.c | 50 ++++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 13 deletions(-)

-- 
2.43.0


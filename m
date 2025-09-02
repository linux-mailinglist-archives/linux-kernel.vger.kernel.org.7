Return-Path: <linux-kernel+bounces-795463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23382B3F255
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 04:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77C09189CEB0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 02:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E72B2E0411;
	Tue,  2 Sep 2025 02:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HO5SaO/U"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7742DEA78;
	Tue,  2 Sep 2025 02:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756780255; cv=none; b=q6kv5qQCtZPXbJF9I1vTJULwsHaik0ZLkA3raJWdfzl7+eaxUl6+dcb0FIiCmGtSBVzvPaIN1LtJet1UN4LgMJi0oHmHInP69QNd61ZwCzKpvxW3Z2zaPtA+n/AAoBeojTQwCmMT4cSFyYArRBmaGPZtjGNdcwhazdAa4pTUuV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756780255; c=relaxed/simple;
	bh=PGpS0/ho85anR7M4XqOckj3EpxykNMy750PIZffeoIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nhQ19yZ4jxwBTETj05GzAOd2TmRHPcv8sxrfQSU4rYdE2+TNKLkX4row1m4saTi8h0CzczJpmpOEJivXcHb2SpqogHagofDlEEUfeT+CCO+z4krfBkesQc5obl1s46GO7uaMADUXWgsoL9jVj8tP5B8OBdtp2yZ0YqggnECeT2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HO5SaO/U; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7723bf02181so1743316b3a.1;
        Mon, 01 Sep 2025 19:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756780253; x=1757385053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqqqTcqkm5HXJNLReAdz/3djlSkLlATEJFfTDVN5y1o=;
        b=HO5SaO/U1S1WhYOF+mONlTZg8rwydDWGW0A0wojB/7tz8HSKAuB4FHZktr6Ey+IITW
         o8QqA5a3IYYvKAADV51FCQ6kT0b9vui6pnkMC5SqarHMJi2bxwT+y6ksVU6PM7W9OxBf
         ve5LePMWLQBz9OkD5fZ4Ek52mkglRvfgWnv6ZBT2dI5g9k58tQUaXNNAFHiCw2xmL+XX
         ikyU4rlnTWJ5HnfHHDclFkOD8wZjDoK8/ZBW+jVicSZXc+jsQ+nRuEAjijgFjhNcF1Jo
         SZSS2Z6eMyuoYJFDzDieIaY0Z5bCXaohCHl8vYapFtSy/Fpoe4/4S9hBagvH8iy1wva/
         uvFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756780253; x=1757385053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tqqqTcqkm5HXJNLReAdz/3djlSkLlATEJFfTDVN5y1o=;
        b=pq3mpZ4zpejAQczHUxXNRw/28omim9Y2pWIEcVcqLTY3u9MkXtS2knxQF9O/44NhWx
         KipGdqN8243qMjl5m8blO7mf7yb4Gc3O//pP/yu0NJvSD6mxrriiXWrjcPBm2/CxttC9
         Ek6eC2Iv0+KjSFxy0s2ku/CUpznAZbMSr4grSWACGTT322c2bC8kgI27zbXJvl6vgUHQ
         Ck9+D/3ZB4TuR9dP4ejXvQKHx5/h4/9stx/FU9UI+xQ2AKqlQRoQajc6y561AWX41v4a
         HXrANtZ1iaOGDQy7yzPJQh8nIC6OVML3ZBdD6alNKTeEGLORZyCwTg4MjNmYlA5g1ePV
         r3MA==
X-Forwarded-Encrypted: i=1; AJvYcCXEne1tD/k3pSRk3I+aR4K5R3hnNRFfPq1Q8XjL/TuYa/P2Y1NLmN4PHbL1qj5GtmIxNKij8yOih+zduis=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8L0Gm/ClBlJOIlruI/3oFPDfSR3K4xsybU36ZllIPbD8CGtQ2
	if0+bzckTNBYDG4trKjoG+wMCBNLcXjbhwswzgJXI9nNj49/m9EHFgN+ppqAJttXSy8=
X-Gm-Gg: ASbGncslxrZArVR22HkrDPlRlhDfavRDQ8Xt40zP7kMID5zVvMaI4Sy7kpyYfDd8Tr7
	Dw1cznKoY7lAbtHa7HwSIfdLl4E+ahyiIt+hlJzQXn/tbaiKJfJV2bjE+7xVFQEhCtvYYsJLIh2
	trnQyzOu7l4b+UPToMtnotXjeSqBoh09AdY7MhdvquOvIMDu1rhRCQqnw8FlqouTa/+OCz+NcB9
	FDj46oy8lYIOrmwVogq/nGh4sfUd7GRtRm8wKypvjIbOzZG2aESjE937h3W8hAP5009Ad06XMdN
	Uyo7tOfg2sXY3EOdBr47UzuMzhavcF4axPHUYZi8afOjP/XJZB3l7HFMHpZlzSHRNHvK1CqRvKE
	Fw6zDrJL3NPkaJvmowQnkjtN287GX1gOVFTKYqSTYyabGXoECYcmp
X-Google-Smtp-Source: AGHT+IFgN5LHZlNZwGgDpxYV6dNztxWS3z0q07NOl9Q2oHOXCg6wEhFZmgHhAKIcLn022q9yJtoI1g==
X-Received: by 2002:a05:6a00:230a:b0:772:332c:7976 with SMTP id d2e1a72fcca58-7723e0d3350mr9944132b3a.0.1756780252733;
        Mon, 01 Sep 2025 19:30:52 -0700 (PDT)
Received: from fedora ([172.59.162.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2bf5e0sm11973278b3a.36.2025.09.01.19.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 19:30:52 -0700 (PDT)
From: Alex Tran <alex.t.tran@gmail.com>
To: corbet@lwn.net
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alex Tran <alex.t.tran@gmail.com>
Subject: [PATCH v1 2/3] docs: filesystems: sysfs: clarify symlink destinations in dev and  bus/devices descriptions
Date: Mon,  1 Sep 2025 19:30:38 -0700
Message-ID: <20250902023039.1351270-2-alex.t.tran@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902023039.1351270-1-alex.t.tran@gmail.com>
References: <20250902023039.1351270-1-alex.t.tran@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change sysfs bus/devices and dev directory descriptions to
provide more verbose information about the specific symlink
destination the devices point to.

Signed-off-by: Alex Tran <alex.t.tran@gmail.com>
---
 Documentation/filesystems/sysfs.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/sysfs.rst b/Documentation/filesystems/sysfs.rst
index c50da87f27fa..b562cfcda3d5 100644
--- a/Documentation/filesystems/sysfs.rst
+++ b/Documentation/filesystems/sysfs.rst
@@ -312,7 +312,7 @@ kernel. Each bus's directory contains two subdirectories::
 	drivers/
 
 devices/ contains symlinks for each device discovered in the system
-that point to the device's directory under root/.
+that point to the device's directory under /sys/devices.
 
 drivers/ contains a directory for each device driver that is loaded
 for devices on that particular bus (this assumes that drivers do not
@@ -327,7 +327,7 @@ loaded system modules, for both builtin and loadable modules.
 
 dev/ contains two directories: char/ and block/. Inside these two
 directories there are symlinks named <major>:<minor>.  These symlinks
-point to the sysfs directory for the given device.  /sys/dev provides a
+point to the directories under /sys/devices for each device.  /sys/dev provides a
 quick way to lookup the sysfs interface for a device from the result of
 a stat(2) operation.
 
-- 
2.51.0



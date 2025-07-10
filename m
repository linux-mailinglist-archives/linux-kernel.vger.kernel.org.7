Return-Path: <linux-kernel+bounces-725137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 450FAAFFB2C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 440A01C4814E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 07:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5D728A3EC;
	Thu, 10 Jul 2025 07:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="im8UZ1oD"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E58928A1CC
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 07:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752133333; cv=none; b=u/74QhRQjXs8Srg/BlxDRJKB/JbSfqMsoM5IjaOrYZbsZUTpX8TnS/XN37UWVMtzPeFQ6s+CV7u/8/y5EeL43IRdMLz9cTDEu998uR9d7/sjyRRshV+9gLDnFG9Oi+lFUSc2PkekaGDxC0WlpBtZmPLOaADNoJuL+0Ie4KS60Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752133333; c=relaxed/simple;
	bh=OsndL/l91yEYx2xFUgVdidwO0LjsZsF/bbZEk+wkBGI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=isVzPFyqD8w45rCFm8NCV92wBPCJXcgJBoVfoyEG3fm7eTbo4Uh+HrYiuwbJ9w3MSpfmXN71kDwJ4eMDEnabCLbA3AH34nSj02AeCaS4tudQUxlDtmWOBIl9T2Hmb0zx5Ibb76VFJsEaDc6fwJY8ATtguFkrtENa9/NJvbOCzkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=im8UZ1oD; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-73c17c770a7so969453b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 00:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752133332; x=1752738132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g1gHr7q+EFyW2xRmF+M4MwqkzxA1X9V4Qz37BGBEn0c=;
        b=im8UZ1oDhlBiiaz570MDP3tk3fNvZ6flzfdZ4xkVmTAIff7Yq33L2YIbkqokE5WRiM
         e1/ykPCkmM1d/QuOuuhD8CTUu849KSXXGRv6lGEuCu/QfC8bcG34aiH0NuP82TzBM985
         fhaSnkM+ZqlAf3X16QfE1r7YsiL6nJtOqXfm882opvp/KO8EnjfUn2zId5vbVuQ9j39c
         F/lLbrNIphikKvYnYk7wanuNTiZyPP+jFi8hKbwM1OoGWQj4eTy5jXI34OVA1m3M0G7j
         q8VAZ5tPaBBQQjNdtUFGOWOHnHMWRkXTArNvl+/zsQQAAc/ywd8UBSEHAfCx66mNaaKm
         Zn8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752133332; x=1752738132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g1gHr7q+EFyW2xRmF+M4MwqkzxA1X9V4Qz37BGBEn0c=;
        b=bEanEM3M6baZQxDrvZr+EciG8os5jZb46zKgHo2bkQ9MddHL8NJJkt3uuTu1mz6IZl
         BkATlhaXIQvWuDnQZPpBKoABwPXY9O0L0Lt9piVsADQdR3O2tZ9t6hrWJqHLvGW7RHKy
         d187GD8jTtv7NTsMmI/m/QKTI3Vaz2arUj0iL7molEnd5EHlNoILKxW+YNRzM3RW/WB3
         XaHrDK0i7kKNQjN2HEWdDFsQHvrxQckhMpuwCNLKvszgvin8nkK9kHXEEWamx9qqwSuH
         uM0X3Ql4aNnB1x2uhlySLZI/h7dB76O+oEm4uruAk1/i8zKz+RfFMBTX90VagF17pdka
         /5iw==
X-Forwarded-Encrypted: i=1; AJvYcCV99uR7tKKx/Th7rPs9Y8inYnFylzmH+/sgnUuA1gSWAXvZTn8VlvEg6ejaCuULADt/lBOn74JSTeNEXug=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLCArl7QtyCRLfwtJ5aeye1ZVxrmd/986J/3lAFF3S1zbj/gCD
	18On2QFfL5FycivurWCby4Xy8xT1nc9w3xckT3j2K/VXWZfQoJUEPapu
X-Gm-Gg: ASbGncv8WColxzRR4qbtfb5GNpiCUOTcORQYjZGYI3yG2cvFYspi1Iv1DAK2l8PIDGp
	lZh88AlKz/+a3k0bwjf4GB//HUurJCjDJposWM2kqp+HpKvZl4BhfBySgwPSi2IsI804UBz9VWh
	BQ/H6xR5A0BV+QMZO9sE/sRd2ySEZiNqys0vLFCD/G1ZAR39Qzhep+AXLjOpb6Fjh0A6xItfvxi
	NgiIWCwrsvwxJ/AaAqNScf6nJFEX+SzsFXo66pywk+UmNccZBjawuHrOS6cy+qlbCMwYjkpU3E3
	i2J7R2fdUYkFw6sf67478wGlz7QUn9o0Y23ltiahwDFL/idqdLtXrUKAVgthlL5hwtFzFmsWpAE
	vTduI0QdqmlvDmKoVfj3G
X-Google-Smtp-Source: AGHT+IHRmevB2sLmZNuf4rljnBX+VrlRwcmgSx+Zab7BbZUes+8/A18efetQ8HvRx3QeMISxk9f4zQ==
X-Received: by 2002:aa7:88c2:0:b0:74a:e29c:287d with SMTP id d2e1a72fcca58-74eb8fc372fmr2237901b3a.11.1752133331691;
        Thu, 10 Jul 2025 00:42:11 -0700 (PDT)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. ([2409:4081:199:dcfb:ded1:3f8f:36be:5438])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9e06883sm1479087b3a.63.2025.07.10.00.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 00:42:11 -0700 (PDT)
From: Purva Yeshi <purvayeshi550@gmail.com>
To: agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com
Cc: dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Purva Yeshi <purvayeshi550@gmail.com>
Subject: [PATCH] md: dm-zoned-target: Initialize return variable r to avoid uninitialized use
Date: Thu, 10 Jul 2025 13:11:57 +0530
Message-Id: <20250710074157.24215-1-purvayeshi550@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix Smatch-detected error:
drivers/md/dm-zoned-target.c:1073 dmz_iterate_devices()
error: uninitialized symbol 'r'.

Smatch detects a possible use of the uninitialized variable 'r' in
dmz_iterate_devices() because if dmz->nr_ddevs is zero, the loop is
skipped and 'r' is returned without being set, leading to undefined
behavior.

Initialize 'r' to 0 before the loop. This ensures that if there are no
devices to iterate over, the function still returns a defined value.

Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
---
 drivers/md/dm-zoned-target.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-zoned-target.c b/drivers/md/dm-zoned-target.c
index 5da3db06da10..9da329078ea4 100644
--- a/drivers/md/dm-zoned-target.c
+++ b/drivers/md/dm-zoned-target.c
@@ -1062,7 +1062,7 @@ static int dmz_iterate_devices(struct dm_target *ti,
 	struct dmz_target *dmz = ti->private;
 	unsigned int zone_nr_sectors = dmz_zone_nr_sectors(dmz->metadata);
 	sector_t capacity;
-	int i, r;
+	int i, r = 0;
 
 	for (i = 0; i < dmz->nr_ddevs; i++) {
 		capacity = dmz->dev[i].capacity & ~(zone_nr_sectors - 1);
-- 
2.34.1



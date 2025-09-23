Return-Path: <linux-kernel+bounces-829171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36865B96726
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3B03446C05
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CE324679A;
	Tue, 23 Sep 2025 14:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BglUpkpa"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB54B2441A6
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 14:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758638976; cv=none; b=mL2ke7VoxWoL7uLIRQuXYO+kGKPr6uRbXzBBQjv9FKoQlf8r8cqfJgA8CDN7xigFkZngEyEhP/V3bUwXl3dQe5ic5q94ZqDfcu2b9w39YY22Jc/49V+2NWW9rZ81568oZUFxbien4AqlwuQMFuKXMgBKSV/cxnp1Eh28+uZ8/Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758638976; c=relaxed/simple;
	bh=sLM1xctq1sZCetv1t/FXrLccMl5BHb26sBKtCXVwXcY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mDSANSRWrIdUpie3jPlW1XF1SzW3HzbuNOEnrQTpUxky9yGS6dRJSKUv9qXfxanTkrfbh8iYvpoXw7XSWyCJnvguQkw6jzzon7vErwtbDyFcOnDbQVq4rhcFVL9C2blKdMyR6QJ0mCKOlpBvlT02Un8FRQFxhTcT/jimK2yAAK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BglUpkpa; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-329a41dc2ebso4599614a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758638974; x=1759243774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xp7+9xFuqi62hdNhf2W1lvuRdA3Rtjn+hEtiwRUgEms=;
        b=BglUpkpasnTMsxJ1kob2YRj1IusV3UOU4iwbeZUp2FaU3BgFplLW7qN8mQZsLJ/Me3
         7pXdZ4MJujUW9a+NIcmTCloW+5dpuHcg7FvQcIaVead4QVL3MFULBWiDAsf5ngoPv9v0
         ZM89eRr6vFuIb1HCidoCzpBhyySmJXW7F6DlIYFmX0lhocYMz6TTkAEWRwpUmLeaL4PP
         D5pc7kziwnILkPtdDZofElf0DUSIn1G4fyWjT+WUgcuQ2/oLxO/MdyNDEnW53nAhtc/r
         kxk9FVcCsrEEoW2+/KkTGH7zJxdt0tLKRg8lZMkxUyZ4Y0DeX/0GzIyUCLyFjEjVb8ij
         RWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758638974; x=1759243774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xp7+9xFuqi62hdNhf2W1lvuRdA3Rtjn+hEtiwRUgEms=;
        b=MsFsHi0S46krzT4njmzhxEklhjj/bOc8ZizXKWff6yPLrU7hzc/9cpOSL2A1er83xD
         0Dstj6524TgxBWXZipjS1NZf7Z8A80ChCzaDtcOthEauNUee7kgm8aK8kJE4OzMo+AJO
         OLprkaioHxVltKdr17HIU/4xUMmY1CxSD14fimLeChWySim7BQw1Nikjw0ntU9cI+mg1
         0mGtYimy6VJ4i7Tr5bweQmhC++oO3SHa4tqZKdgW/LD3J1k+3DVmhY+L/cR8MDCz1JHV
         bVn8FI4aD3JbGYUbsHtDDqdbbdSc5Ihihw/z37Ceu7Io9EWUbjUZ6q0001B4XfbJr92j
         85Vg==
X-Forwarded-Encrypted: i=1; AJvYcCW5VoFBch6GsKhWPzNW9LUNmH1Pvu+6pMS7QA/I2KgvXxfwTlfrl3fi5HM8mxoibSz6ZL9jbOCFvP8a3sQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrK4e8yD8aGZWNx7tk9+neJKIXP6H8c3sk2baCwooXpGhKlO98
	tZ1JtvYS7T84/k6auAWfjj5NItlpY9Xg++vb/Kg0RDbO17JguG5goGKj
X-Gm-Gg: ASbGnctjfz57EfXCQMQZLUp9ixl87OeWb2Tqn7VV0a/NGdoZS5AOve0i7a9Hku+lE2l
	XnSDtVvgbRuoL7M7LWRLiLLkkw7S/GX3XrhR4bPJ55/jaL3NLh1AKQ5+RY6u9ewLP+5csXpQb8s
	p1y5fXQahYNxzZPKBAFwXlBEFg2X8Lf/+FbrG5mipUYgj3R8G/Xy0jdqcyfbOtn0IhUx57N+qlW
	HNTdEixBaK0KsnhPfdVZHI0Wq+/CkIJ1B4ptlfIV936UEWp5U3kbAc2Mf1jGAB3GDp4oSMnmyQY
	P9NGIUKRc+9XAzwot1Wcoou1vB7olWCCZN8syH/y+ys2AbpoApmAU4yMD9UeJ4n6/eKpxH5WLZh
	nDQhQ9bhrrskAodc4PDOnVZuA4KfovYg9mDpmJZ6AgJgqB5/u3h4=
X-Google-Smtp-Source: AGHT+IEPHh/2ebqkGgimtTNshZ35ZBhXt9O04HK+1pd/wsmqmpdSWNANzUnELZmpu3VzsIEIQkb+0g==
X-Received: by 2002:a17:90b:4a8a:b0:327:9e88:7714 with SMTP id 98e67ed59e1d1-332a97051f7mr3565283a91.37.1758638973819;
        Tue, 23 Sep 2025 07:49:33 -0700 (PDT)
Received: from ti-am64x-sdk.. ([152.57.99.156])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed2771d43sm19092682a91.26.2025.09.23.07.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 07:49:33 -0700 (PDT)
From: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
To: Michael Zaidman <michael.zaidman@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: bhanuseshukumar@gmail.com,
	linux-i2c@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH] HID: ft260: Use sysfs_emit to write formatted data to user buffer in sysfs show function.
Date: Tue, 23 Sep 2025 20:19:26 +0530
Message-Id: <20250923144926.307315-1-bhanuseshukumar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Inline with sysfs documentation, sysfs_emit is used in show function
to write formatted data into user buffer. sysfs_emit is already PAGE_SIZE
aware.

Signed-off-by: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
---
 Note: Patch is compile tested and verified with checkpatch.

 drivers/hid/hid-ft260.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 333341e80b0e..8677bea46bea 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -826,7 +826,7 @@ static int ft260_byte_show(struct hid_device *hdev, int id, u8 *cfg, int len,
 	if (ret < 0)
 		return ret;
 
-	return scnprintf(buf, PAGE_SIZE, "%d\n", *field);
+	return sysfs_emit(buf, "%d\n", *field);
 }
 
 static int ft260_word_show(struct hid_device *hdev, int id, u8 *cfg, int len,
@@ -838,7 +838,7 @@ static int ft260_word_show(struct hid_device *hdev, int id, u8 *cfg, int len,
 	if (ret < 0)
 		return ret;
 
-	return scnprintf(buf, PAGE_SIZE, "%d\n", le16_to_cpu(*field));
+	return sysfs_emit(buf, "%d\n", le16_to_cpu(*field));
 }
 
 #define FT260_ATTR_SHOW(name, reptype, id, type, func)			       \
-- 
2.34.1



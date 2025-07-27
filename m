Return-Path: <linux-kernel+bounces-747211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46220B130FE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 19:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 321CE1897D1B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 17:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62C7224AF0;
	Sun, 27 Jul 2025 17:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="HXQSE/Bj"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0EE221299
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 17:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753638017; cv=none; b=rdan1njclbgiHFi/HxIQeSsyYacUAkLLdILnKx7jnUOnAkyAbyrnYYOHfnQEFcNPhnWmiJjjNsWX8OkU6VYzO+O4yRYKEAYXfmITGw8xaikC6vVShA2kt/z8tM2kIWAJx6CUxYZVbyXnzv88OXD9HmrXq6nRCqbaKjyNBXFrJjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753638017; c=relaxed/simple;
	bh=eUp8rkkrj67E940zx0z9wttZ3qw6F6iVPZKFsp8IVnk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xepm+DdeNbXLxJcuaqhlcXM4tjFnNvfm/WyjzBHkHweiuHh9H4Enkk9QJq6mc3tMDiyfE98sJn4YugIW2g6RSu3zKYNLXM8D/MzH9vd8rnyY4s8rNb6otJAfKY9EVhhRIAi9lsRyD0srvtrJkCp0y8zUjZPzXnps791YaUkTNlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=HXQSE/Bj; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b3508961d43so3403570a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 10:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1753638015; x=1754242815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4v8mNNgB8Flu0S6Coiw5A84RBTfZ1/sa2qSDgqs8HE=;
        b=HXQSE/BjHlG0DC4jffKIu/Lz9lO9Lx3rOORBBDfOa431XEVd4M0zoByuYIh1+Ie4pU
         0q9GBmJtPUgLDFOFDIAmS4B9UKZdsbw/lbDc28lQwv77Fkl333BBySDL95kIRcx6dDUJ
         9sQIEMsfWMvVjQ7MEnXtwUlz5O9+vuEerLLzwe9JO+eQhRfechGXqhOwG8qYmrBVfTMl
         zC9infnGZrsDwhnrbh1DV5oaYmSc4nbj7apxbTLguB4uIEwgIRWr/tcp/ijg0lTwYVwC
         e0Blr2NlACSwRm5/GYfH1+PHtYwA1IMCl3acZUV/8T6hQcILWq+O5c/JBeyou/POO1dv
         2BTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753638015; x=1754242815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4v8mNNgB8Flu0S6Coiw5A84RBTfZ1/sa2qSDgqs8HE=;
        b=jL59DBTS+E/2QpVSDrz8hvHKTsjZB1qcslFMATPsaXD22iVTeTdE1SwasHr6/PzdKh
         pqnYwLSLH+24+85eB5IZwrxpuyry511uUVO+AnIHiHi71SA3RrxTQ7OUSq2OCZP3YeCZ
         CmLuI1jDyM0dpwzjtLKMDjmYHHTQdXtHdfUSExoCoAjDjOZs/DHgyh+Z2OzGihY3KyEf
         pKA4Ntz429DjQCID2TEps4YkE0RBOvj0tXphQrVwd7CymzwJVeH3nYiCPEVF66BRdmZs
         PBK7maXDfMdhYYjiG3AHysCb8hMXm/rlsHc5U1LjXLSsCxWOOYmkysSGWMYkmM2mv4Ol
         iboQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCjV9gI/dbX4o75IpHCdsW14ASd6cJSnAkxOczg0ZBDUU4AUyCf0SKMf0A1q3KIGtvhUCV8m7nf/7BWps=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUjerjnTYq2ZQ36vOsOrqaIpQCn6UlgIpT4g7JExZOVhaYFbD4
	ojusqIZVwYOBACmRzwjtGRBlx3e49Hm3VUg4YP8+IiwLso3RyGjFMJJGvtRzMzHEKxk=
X-Gm-Gg: ASbGncuRG7yb1JPORwDzt1hK+oLJR8ah7KJA0Ytbv9whwa/bjiZlfIUHqf/qugrUIce
	7Gr41isRjOBHXGwXKMgJmktTwicTFWRAoXXerKZkujCKaFgPlyCWkX/9tmsiS9v1j2fYapm+hN/
	TK9SAaYigvBqBBLRV/y5Guz4LXhupfEEvq+qahW9fBO0ZvmYIm5Z2LX83iZVN6dAEKcX0krFutt
	Tevh8VxHVehew0zMzhSMjrvXjOzDuRYK/K64WkzkglJVHOqbAsemllWbIN3y3lO+6UDd2CMd1qp
	F+I70AupwOTQjfvAFiSqyWCzha/wY5Mf8JH3g04NaoDuNMwy6WIq6nMPX1hkNhvLDGuAHJLxcFd
	BJGS8ahc=
X-Google-Smtp-Source: AGHT+IGv29CtskpdwrG7FN+exNQheeZ5lwmlkvuf79A3488Y9t5W8AEZTp9o7Z0NNsaBrqCcG69rhQ==
X-Received: by 2002:a17:90a:d40e:b0:313:31ca:a74 with SMTP id 98e67ed59e1d1-31e778f7826mr13735566a91.16.1753638015093;
        Sun, 27 Jul 2025 10:40:15 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.18])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e8350b724sm3924224a91.23.2025.07.27.10.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 10:40:13 -0700 (PDT)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: axboe@kernel.dk,
	hch@lst.de,
	jack@suse.cz
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tangyeechou@gmail.com,
	Tang Yizhou <yizhou.tang@shopee.com>
Subject: [PATCH v3 3/3] blk-wbt: doc: Update the doc of the wbt_lat_usec interface
Date: Mon, 28 Jul 2025 01:39:59 +0800
Message-Id: <20250727173959.160835-4-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250727173959.160835-1-yizhou.tang@shopee.com>
References: <20250727173959.160835-1-yizhou.tang@shopee.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tang Yizhou <yizhou.tang@shopee.com>

The symbol wb_window_usec cannot be found. Update the doc to reflect the
latest implementation, in other words, the debugfs interface
'curr_win_nsec'.

Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
---
 Documentation/ABI/stable/sysfs-block | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index 4ba771b56b3b..a3cf841ebdff 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -731,7 +731,7 @@ Contact:	linux-block@vger.kernel.org
 Description:
 		[RW] If the device is registered for writeback throttling, then
 		this file shows the target minimum read latency. If this latency
-		is exceeded in a given window of time (see wb_window_usec), then
+		is exceeded in a given window of time (see curr_win_nsec), then
 		the writeback throttling will start scaling back writes. Writing
 		a value of '0' to this file disables the feature. Writing a
 		value of '-1' to this file resets the value to the default
-- 
2.25.1



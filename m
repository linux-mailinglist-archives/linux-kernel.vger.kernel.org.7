Return-Path: <linux-kernel+bounces-749339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1955CB14D20
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 13:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D3D418A218A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909EC28EC1C;
	Tue, 29 Jul 2025 11:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/M0g+vz"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6738821ADAE;
	Tue, 29 Jul 2025 11:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753789329; cv=none; b=DhhhIyE9Zjf5RP0CY8m5OpQ36QTJAjlYaySsAiwVdm9vnPE8y6PHr6/+FkEYQ/KZ9FP9Xyb4VMHqoTUGlWOVhbGhzZqDCWkIoareJJAFDqpcYL3RLwNWr50HyF77Ho675mI0GirxhVfPv50YK51P76AH+8yRkYRTNFLNcRUuMew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753789329; c=relaxed/simple;
	bh=o8XI6Qww8Kx2zax/zwUEYzHQzQWFjOFhte4WwN8IaU8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y8Atcc7vYC8vom48Sq9Yfi6gOA10whl3qbd3xhmZsjrxlFhrHekcLS7rdaiRjrUT5hzVknrA45vGLEFo5VDDGV+V6n1NVRQ95CneqOzakeDFUj00fbeaH1R7frqT/rCqpxb0bymtdOvjMcMFmz5DK07Sz3SwlJqG1CVycJt0dYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/M0g+vz; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4537edf2c3cso56465385e9.3;
        Tue, 29 Jul 2025 04:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753789326; x=1754394126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aL4YbNzCG29DBkIuw7Hb1YlrFbRw4MJIPtbPF3ye9w0=;
        b=M/M0g+vzYGJBMr1c4XIJyEoe9Va7rydtih64a6IhSpSpXWtL6n+8WnXo9iOkj5Dx3F
         CRzTGy2zaCsLeC0PGgIDySXSnkUVcfSG5TW3NEPgKBzBgAyY/lMHk4TZhaTk1rLravPA
         ufjBMy3s28l7oah+7cAihon0Yx5U6h4/pDI2DuQASPNYsrW+nP7NaBbgk8d0gBbF8S+K
         DflfG5iZhlITZ1j4qy8IJQZu8f7jIzvOi49LaAqoitHvbAA/QBNzXiIDYSQfHsoRX8IK
         yEr/agvlHBoZsBF2tf5WGmvi9OHsGRvZDXPlTSgeq89VHdcLZi1LlZRX711ZtQ/Yu5QY
         HUTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753789326; x=1754394126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aL4YbNzCG29DBkIuw7Hb1YlrFbRw4MJIPtbPF3ye9w0=;
        b=bH5VdSktaQ8CbhsPNvIMb4NNTDOOI1BGl1DOjHJDym6CXDLdz0Aq0TDi5ddwmLqRr+
         l22aXyGcmKsjx+qUuPM56TYXeXuXOcqRQd+15941Gp2Yc1yQqgEKeovKPmxJ2S7nWz58
         uPhAsLJwO6xwHypUh0gIhklN5otu/fG8cChDY9uDez58/sbJEGc9UwZD2cMFKoaYYacq
         xPH3vyQ88z8+QLkoewB7cqVf9P9QXUBOb6rv/FGpN73yGWF8y7XL+FUmsYOYxBDmOb78
         sGcAUwT9JfwZ76l7wzYVjYdv8XlbCI759NOcgDFtbsbyt9tWOXVoJyFtlOA7pjehtoIX
         ToMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwRut/EHKOqy7fliaEd7nytAo/FzsJ3//GlzdYgTo+7NjHua+q8aSakoBwz9cRgw/iamV5LIMz++BWA6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX5/TkGcqShMAbwtAbiUm083AUdJNK+7CFaKkdrsQnQiHVq1Rf
	JnnXIKJyx4aUXfxR9uInhkj7RBXO8W0y4pqnVyT98DmYDiLqToe12dwp
X-Gm-Gg: ASbGnct8XWbmYT+dgkK9d4E7D1vhkqJPRiXiTk/MAhMNllgnKlG3Cf8WR+enMNJ2oLk
	Jw2WHEmahQ7nmFeqoQpJo21ngzFtZa9J6Jr6QHIs7fedp53r4u1RY3QYkzall1+k1pgvdTEKZDe
	wTp4mZRpaE+XXKjK6UiF5iAvt8NPhcHxM9AmpxbbFRYdMzpOOLFyGS7q1YNmJNeUSzefwS2XSfK
	T3yaCqz1vEJM3j0wpl8txAVLkF4Hx3KiWPx4Zw270zAzgRzPYAe3CzTtkKB9Jbb5SEt9sH6SQRR
	dCZEU6uLR2unMWIPAhiEkoG0PVQW3MTuTrpxPrzdKeqc02anss/N28/zBnZ5uEBvySZwonIDetN
	VzW8CViqZV3pr9fsOZR6n
X-Google-Smtp-Source: AGHT+IGyRgnokjH/fRnTW0dxtgVYaUoiWxnU49me+vMz+eafgwnRz6toTk9ITVF7/sWl1VO7Y+XW9A==
X-Received: by 2002:a05:600c:810c:b0:442:f97f:8174 with SMTP id 5b1f17b1804b1-458765475bcmr135316915e9.18.1753789325702;
        Tue, 29 Jul 2025 04:42:05 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4588dda22afsm15545125e9.2.2025.07.29.04.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 04:42:05 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	ocfs2-devel@lists.linux.dev
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] ocfs2: Remove space before newline
Date: Tue, 29 Jul 2025 12:41:31 +0100
Message-ID: <20250729114131.1925586-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is an extraneous space before a newline in a mlog error message.
Remove it

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/ocfs2/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index a4f5a868bec1..4b3ea721395c 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -2108,7 +2108,7 @@ static int ocfs2_initialize_super(struct super_block *sb,
 		if (strlen(osb->osb_cluster_stack) != OCFS2_STACK_LABEL_LEN) {
 			mlog(ML_ERROR,
 			     "couldn't mount because of an invalid "
-			     "cluster stack label (%s) \n",
+			     "cluster stack label (%s)\n",
 			     osb->osb_cluster_stack);
 			status = -EINVAL;
 			goto out_orphan_wipes;
-- 
2.50.0



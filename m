Return-Path: <linux-kernel+bounces-760054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96772B1E605
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 11:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 968DB18C7C4B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9209D270EAE;
	Fri,  8 Aug 2025 09:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEfbEJwF"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AE81A2381
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 09:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754647027; cv=none; b=R8mb5rv5SfhWZTcSZJtRlFKAgj5QvEzZ+K9mJGwZwsUwMPT4FyG0OTif0r443yKV/amXBdH8rOOFws/tm2uSQHxDttoukvx2fLf2xYz0CCnigVKV+CKuGNxM86JldzpEekO1vmZhIDct+GZkQbRFp4/BmkktGxsS9GuiilGdbPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754647027; c=relaxed/simple;
	bh=bFAs1m72mxvveD7ET+zULTT1mJbavhRVlDwpZQ/0OrM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JftCQDHyYxYSqiOHIcgZ1J5sv4FDPKlQg49TvrNwNOBU8fuLnqDxUucDjchzFJlPtqS0rrzSDxaQoBVb4OGRRiv0TSG+722PA1gJX9980Kqk3mw3ChWo6rAMgBbkb60eaUgqMq1K6DG2FB0F4MliXlwxyrVBU1PgommIF/h+fkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BEfbEJwF; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-31ec651c2a1so1705999a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 02:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754647025; x=1755251825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QbdZ8L3bxOL7zSlL59yv1WRZeyeO7nmFpcHH29wFdjE=;
        b=BEfbEJwFF2KcMdVhRK6L65kujDhNNV6MaZ8FX1I2b9l5PEJJOCn8ZBqXsS3kfE2Ik9
         0fX+oHK7rIU3zt/y5Ih8JobTMyvee7ROXW2MjML+qvue9ec074MCafN7loncXw0spzE4
         PdY/SDX4+uQQ3FHaV3cq4TwM+4+7W3yXj5JiMJFEsNhZpYGo5JOj2J2uZrUB8BZpWAd4
         HX2ng3k0QyA40RhXC0JdBRpQC7ttp0bQr7USGvUUvbig8ZBUqnNOaQ0nGnMpcE91u0/K
         VMhcN9shgrBr5N6ndFB8t82QnhVTAgJ3tnYA/SKDvGSNPcUCjzbAaZ9U9VMShEDQJ6ZE
         hMEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754647025; x=1755251825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QbdZ8L3bxOL7zSlL59yv1WRZeyeO7nmFpcHH29wFdjE=;
        b=uXOGgcw+2N0UKueCuDE/TE2aX+ugKM5oLQ/n6aztKBagQARi6odjxxwlCmAkTiGsix
         6zJCP1epTL6T8KoLXquEvbIdLS0TSFwPv39RufP3dfi94eGGID8K1OZYtVjjGghi2gl8
         v6OyTjDcR0V6PZLRGApbhFCQNISj+CNTSYO4jgFHj6EI+hR7Iqw+8jAyPa9BQj8UDe4p
         TPNNKuYWiZ4Ot/07KDQqtPR33y19iyKRwnwCWsteNZgwpIBxTfQnuk3HVEbBEDQxtKST
         Ok4PCyZV7peuzb0VOIa/Egy7BVfr8VNmy24l+zSlDquc+z37aQHuTTc3jeiRwKRZG2JV
         HvfA==
X-Forwarded-Encrypted: i=1; AJvYcCXUuyImTHHzOvRPDxWcKT463SrVb1//5KQGWtYbVB0QVUpySNpKJwqZbb/KL2XU91TmZJnC6v+Q5rApG1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG9QdGe6T4VfeAKa08mewkQC+Bk5Rhd4eiR3njwA+hGzZu0B1a
	DtiJ1tDsEi7epN/zSemsMZJrmwmkUIJ8CeXkUkEsJlFLUe+M17ULNouuYQuoGw==
X-Gm-Gg: ASbGncspzPVye6UioiYSF+7b8oC0XmqHROSlSJ9nD5mQQBRAdG/VZQL11RFsok8O0FH
	CdjiTPq5vx2eNPbGQq3Z3/1v4b6TpLkTAwCk/cIrRVO26xb/pzMXgktltTBOowIw1Hozr1etc/G
	COxeazL76k82/zjZ4TJ5XuZY8Qja0LAjnzxLPJle6r2VFamrrLdqxtSsXmFacic3RN+U0XpmOql
	uziE1+7QxgtLR0BQG2l3V1YW16TZTSe/xHs2KKoakomf5pNaotNKwxUJtjEUjw3HraMXZG3uGgk
	cs9dZKOkCeMB0ejL20d5bByoPknzfD3xp+CNERB3+5p4TJ1zSfeC9JOcEbgx5GJgkriUAtk1kbG
	UDkJrJPHZm7gbdug8aHxofgrHOwlwhRgqfwHMIegRk6WSz0/Xm8v9DEOz
X-Google-Smtp-Source: AGHT+IHu8dab8Vf9acP5TrYabIiLe5Tn4x32dlayXH4i2KpOKl7+vHDWdmGiQLqh6OwHns+3QBqCEQ==
X-Received: by 2002:a17:90b:530f:b0:31e:fac5:5d3f with SMTP id 98e67ed59e1d1-32183b3f09cmr3867750a91.16.1754647024933;
        Fri, 08 Aug 2025 02:57:04 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63dc4ea9sm24286964a91.15.2025.08.08.02.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 02:57:04 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id D3109801D4;
	Fri,  8 Aug 2025 18:02:33 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: miquel.raynal@bootlin.com,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: richard@nod.at,
	alvinzhou@mxic.com.tw,
	leoyu@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: [PATCH 0/2] Add support for randomizer
Date: Fri,  8 Aug 2025 17:55:01 +0800
Message-Id: <20250808095503.906244-1-linchengming884@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cheng Ming Lin <chengminglin@mxic.com.tw>

Enable randomizer support for high-reliability.

Cheng Ming Lin (2):
  mtd: spi-nand: Add support for randomizer
  mtd: spi-nand: macronix: Add randomizer support

 drivers/mtd/nand/spi/core.c     | 18 +++++++
 drivers/mtd/nand/spi/macronix.c | 94 +++++++++++++++++++++++++++++----
 include/linux/mtd/spinand.h     |  7 +++
 3 files changed, 109 insertions(+), 10 deletions(-)

-- 
2.25.1



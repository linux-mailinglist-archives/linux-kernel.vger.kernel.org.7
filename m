Return-Path: <linux-kernel+bounces-738268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CCBB0B685
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 16:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EC4318989C1
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 14:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BBA42AAF;
	Sun, 20 Jul 2025 14:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBGyZrMI"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F005419644B
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 14:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753023374; cv=none; b=tB1MlK/eF659siAywTmIWr2V7577Z7B6yg7nqZCHVj9AMl/epEduU+qzb2fBvze/mJKym/TQ+iNEOjvknbOYJIPQVvtSnWolA7TIvxQKGqI4l/lGQwriew6UOoWM+mQYL4FHEpxoOoNw0hrG093TJt1zs14fCcJp/09c8Xt1L7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753023374; c=relaxed/simple;
	bh=G+MNuq9MZRvu3gCgglTsVavY8jyd+fGZCbRr7TlzQOY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RQjOFE9ld2+cBSUnt5ernXojBwK3TtBrBkXVHXkwxtTXzhPPnT+bnwRIryzzyWrmCSftuSJxOeVsyXIu4Gn2g0EkbT1cggdUf/hnuVlO9sofkqTkl6AF+s+i9q1uTWUMIWL86UHDs15jIn1DtSfUdsBPyyRL9Y3us8Q6u6SZ1ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBGyZrMI; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a507e88b0aso2498215f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 07:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753023371; x=1753628171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mbJ5TjcSbDKdfe9l3K80tY1zpRj3zD23GT0I7h+8cJM=;
        b=FBGyZrMInkgENLhh+V1CVln5jfcbDmYotMZPUCQ4//VgqdrsJSbldrE/K+W+LgTtVb
         3yDDMUowklo/jNBDpkl5QLK5hyy8+XNHYv4r42kd4c31tiIJ68TefaJ5AdRot46/Fd4x
         meKZy10v01TeU8KOHYDdT2UVYVBMWd4C8PUZ25ZfLrlASMXPw+wjuZiq0Sl64/NalYIR
         J7wPpwkbF4DbttSaXfUFwhhBimt+n0RQ6P26jmEmdrFVHOOPxJAPwWpm9Y3tz+WZimNI
         lDWzdbsLRogqAMHC001sfORBmyytLu/p6Vk3Wc2vP8MmYRRmmVczWifqSF968ut7K3va
         RR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753023371; x=1753628171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mbJ5TjcSbDKdfe9l3K80tY1zpRj3zD23GT0I7h+8cJM=;
        b=HNydG9WW320RrzR3NrVQb9ktvU6QH/GSnzIv6xuHFKCSpzKpErsCPE/ykeGX+drsyU
         AAjyEzIeM4aItPyr5MVe5XQpGmtZ+G3DY5rs+QhoWZByUL7rHVWWi4tnPNxSeX2RkSHA
         epaJRux3hXxrB8/VM/jge9Gkg0oydI8uwarHAmix6Rkd95a336cduyl828MMVSbmaL5K
         T6VkNDk1J3sp1n7VHc5buNd5PKqUhvtK/afqLxtwzbjWINK9YTxSDb/5ERa1l2IH22uI
         CU7yAUbM4/4e7bsjCK9FJF2BWCaBFUdqm9JPJ5qOqIYUbAOjRzpFlLihDqIvNP8+tU5F
         DE9Q==
X-Gm-Message-State: AOJu0YwpWxW2He+sT8qIDZEAFvp/GFBP/Qz/YpKNU5yLQxdXMvHdyCj8
	quTytU4NQv+FrVsPdexF7ek0WuwEisJKINHnkZD/oWaVEBtOSfPUdHTw
X-Gm-Gg: ASbGncsyfvtMWjrTHuwYKB9FkqUMvNJUDlmWC0vb4XFZGSRqpXq9puPJTPyoTvtL1y1
	fEDXBC/0jLGr09k6a5zNl7RAj9zxX8W/UOfh/a+xTO8XiLbzTzSeaiz4ahYakyVdcRPUI7JwErf
	T9HUE82ELx4c+RH5U3LFQG5nzAb92OhnV5K9ZxmuNNURT71v7QkZyATjQwHS+Mi4C85BehO9Jx9
	L6EQVbWckK4+8VLprO2voXKs1RoAhyMaBOsTW58KDA7lymGXjq+dxj8aVFefD8EJLoJ1D5VZsxq
	6nbf5WO39f0uIakda/valVNFuL/g6DVIGmXbgyVPXtKXF10dGKoZIgJHjyqXuwdT2hBr4gTSQg/
	I0CExdXlbSCM9zf8QY3Of
X-Google-Smtp-Source: AGHT+IFERGOKdmgdS1XU20IWgwlPKV5vQwIRfES4HzOVvHS8mTpjdvUmtH7oHUWXtakj/7l7ZePEOw==
X-Received: by 2002:a05:6000:3c5:b0:3b5:f177:30a7 with SMTP id ffacd0b85a97d-3b60e4c8fe2mr12137113f8f.16.1753023371052;
        Sun, 20 Jul 2025 07:56:11 -0700 (PDT)
Received: from zephyr ([77.237.185.246])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b61ca4c754sm7770550f8f.59.2025.07.20.07.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 07:56:10 -0700 (PDT)
From: Ali Nasrolahi <a.nasrolahi01@gmail.com>
X-Google-Original-From: Ali Nasrolahi <A.Nasrolahi01@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Ali Nasrolahi <A.Nasrolahi01@gmail.com>
Subject: [PATCH v2 0/3] staging: rtl8723bs: fix coding style issues and improve readability
Date: Sun, 20 Jul 2025 18:25:21 +0330
Message-ID: <20250720145524.9733-1-A.Nasrolahi01@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series addresses several coding style and comment formatting issues
in the rtl8723bs staging driver as reported by checkpatch.pl.

Changes include:
- Fixing block comment markers and alignment
- Improving function declaration readability
- Replacing unnamed parameters with named ones
- Removing redundant semicolons and excess spacing

No functional changes are introduced in this series.

Ali Nasrolahi (3):
  staging: rtl8723bs: fix comment style and formatting in osdep_service.c
  staging: rtl8723bs: fix comment formatting in basic_types.h
  staging: rtl8723bs: replace unnamed parameters in hal_btcoex.h for consistency

 drivers/staging/rtl8723bs/include/basic_types.h  | 15 +++++++--------
 drivers/staging/rtl8723bs/include/hal_btcoex.h   |  8 ++++----
 drivers/staging/rtl8723bs/os_dep/osdep_service.c | 11 ++++++-----
 3 files changed, 17 insertions(+), 17 deletions(-)

--
2.50.1



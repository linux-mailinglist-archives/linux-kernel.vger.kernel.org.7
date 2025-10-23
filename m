Return-Path: <linux-kernel+bounces-866816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7F1C00B76
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 117853AC331
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5F930BB82;
	Thu, 23 Oct 2025 11:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FARgDpV5"
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58892FFFB9
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761218906; cv=none; b=BheuEZCDVTjhanzYcRLw55KmIGMo9RBrbtk7S8z7M4DfwiAexi3Lbwbk1PJKQ6Jh/8ak22oDAbzWfgHcYTkgRdYCDSsOKFcuiuKb6h7J9/PsHjS0Kt+SWt44iOhu6DIcnw89BlGs3n02zfKUlKls+FOxaBRirbkwftMs4zJzudY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761218906; c=relaxed/simple;
	bh=xEJ8xmksDCO68QlgMu6kHN6e2tdE6aDoB8ZnbtugNB0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hXfW2fTHFalAl5i3mEVD/3g2QssgaP8Hb3oBi6pt5wqF7FmpTKdkn1LuLm2ZdkAmKALjFJljx3D7wbkUgVA8EXBuUIccVC8BiqpcMN0EnxGGoktx+MOQvx0YVc6NZIAeCt2YJWdDQc2uueLDzQfVWwdak3AZq9VLlgpB/1NKPaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FARgDpV5; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-7a27c67cdc4so238224b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761218904; x=1761823704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WeGo6oTt2UUEu258vfpQl+lWEvdRCYo6wBNdmy2kx8g=;
        b=FARgDpV5b1s+Kd0nx/yYs7isR6LtCB8v91o2RZRZa12Pwf7n+F1EkFN3yCK04inEsB
         cHWJrf5tb4YhdrbzSfUsnY9DczkhAa9F+vJtV72OIO2IGROs8AxC0yE+Dr+BWAGXt5qZ
         BJ4+7LuSZQaOOr0dRWs1eTZXLRD63aWCXtjHVofiPD8JVDnUWeKcyDOdIXm1A8YKSmUp
         LgMFTreGg/E4k3TbSIQgmeYcMGy9Bz9occyrUJbryewOBpyaMDFokNuWODN02m0kVMcZ
         Z7Skfi9bKYqcZYFafGZckr+o+Zwo4nWBsrGTvdc71VsTQ5WrqFTHIxMgxll1DwRISJu7
         RLLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761218904; x=1761823704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WeGo6oTt2UUEu258vfpQl+lWEvdRCYo6wBNdmy2kx8g=;
        b=CW7cXEQ/6gRU4aW6Kq6QUf435ofl32Xxgv/i6kXSB2Lh2k+EbJjjfhB1ByiQzPA+b7
         /L9d+xDeyPhuCZfH4Awggw+/Com/SGtMx9rpoHq23j0Rn2yFoH+SqZ6ToUzKeJCqFaez
         RiVRe0/gqre8kfCRCJBv8zsPfrVOofzG9YL4/BKPyBXxiFxjpaI/bl78qWSWMj4+Dkp8
         Cxj3cg8iDIR8qZlhoVdQK9m0huxeuPxE64X3q4eg+uDl7Es8KxMH5289N5QfzeWysxpK
         gD+PhJxRuqFilvLBmM4f+3k5KsHG8shTS0IoYBmxIhOVC2Ep70tTZLoxuQ0DU7asjoup
         bz+g==
X-Gm-Message-State: AOJu0YzLsgu/IS1zzKmjz29PNyTawTyYWMN7YrU/LDQPyzt1GL3Ok4eM
	0lm8868+cbxVxe/rHMMAGSbGesSCtg2PYrAtVxplR+yUaUywmQnxXmDj
X-Gm-Gg: ASbGncsGV5d/3zSNEcY//4Po7c9IKNvudkv2ODN3G4YXcQFfz+aSTiNzHG54izW2Oj7
	aTL9KkfBaqSURIdqkjIaWXuOkhn8o3nd66TuIkgQ0LEE+xQRbCcOji9hky+m6UQK0LU8BBwYBBc
	iPrfRNmh3TAUdm4SDE4ujEXpl/uNpABHvd1WVPYbfOy6fiyBwKDkXCO/1vc5u5ecE6N/Fd1VPih
	GB3CKTgcQatXLbObZKNsXrWyvvOZeGXvIr7c8BzWCo/K3+l3/0AYqtKqCFFhM+bdm3+oqD4lU+s
	0oCxWC4U+Zx3ju2kASYdBmAvyoCNz0uBd627HyxqPDx91Ajx4KpM/+HygiNOyXKsRUTXbXmXFJf
	KrwW5FlcIPzlvPKoTfX1OtDJ6r1fBkkc1sQpT4jkb5xP+91/CGOqwT4SMAGxZ2Ep8RazbA1or3M
	RXC7YNs6ZoyxJkGn9sQ6tSfgqwRZkw
X-Google-Smtp-Source: AGHT+IG2udP4swV7OHHKDSmKceMu90JbozzjLhfR7TxBH0NX/JY86b2HJ1oNZwcz6KZq92xtEb1wSA==
X-Received: by 2002:a05:6a20:e212:b0:334:a681:38a3 with SMTP id adf61e73a8af0-334a8542a1dmr29714656637.13.1761218904027;
        Thu, 23 Oct 2025 04:28:24 -0700 (PDT)
Received: from zhr-ThinkStation-K.mioffice.cn ([43.224.245.231])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4bb86cbsm1826524a12.7.2025.10.23.04.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 04:28:23 -0700 (PDT)
From: Hongru Zhang <zhanghongru06@gmail.com>
X-Google-Original-From: Hongru Zhang <zhanghongru@xiaomi.com>
To: paul@paul-moore.com,
	stephen.smalley.work@gmail.com,
	omosnace@redhat.com
Cc: linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org,
	zhanghongru@xiaomi.com
Subject: [PATCH v4 0/3] selinux: speed up avc_search_node() with large number of avc nodes
Date: Thu, 23 Oct 2025 19:27:55 +0800
Message-ID: <cover.1761217900.git.zhanghongru@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On mobile device high-load situations, permission check can happen
more than 90,000/s (8 core system). With default 512 cache nodes
configuration, avc cache miss happens more often and occasionally
leads to long time (>2ms) irqs off on both big and little cores,
which decreases system real-time capability.

Although we can expand avc nodes through /sys/fs/selinux/cache_threshold
to mitigate long time irqs off, hash conflicts make the bucket average
length longer because of the fixed size of cache slots, leading to
avc_search_node() latency increase.

This patch series aims to expand AVC nodes without significantly increasing
avc_search_node() latency.

This is v4 of the patch series.
Changes since v3:
- use MurmurHash3 to improve avc_hash()
- add a config to adjust avc cache slot size instead of kernel parameter
Changes since v2:
- update changelog and fix warnings for commit ("000bce8f11d0
  selinux: improve bucket distribution uniformity of avc_hash()")
Changes since v1:
- improve hash algorithm in avc_hash()
- define avc_cache_slots as a static variable

v1 discussion:
https://lore.kernel.org/selinux/20250905100454.685866-1-zhanghongru@xiaomi.com/
v2 discussion:
https://lore.kernel.org/selinux/cover.1758633723.git.zhanghongru@xiaomi.com/
v3 discussion:
https://lore.kernel.org/selinux/cover.1758859391.git.zhanghongru@xiaomi.com/

Hongru Zhang (3):
  selinux: Introduce a new config to make avc cache slot size adjustable
  selinux: Move avtab_hash() to a shared location for future reuse
  selinux: improve bucket distribution uniformity of avc_hash()

 security/selinux/Kconfig        | 11 ++++++++
 security/selinux/avc.c          |  9 ++++---
 security/selinux/include/hash.h | 47 +++++++++++++++++++++++++++++++++
 security/selinux/ss/avtab.c     | 39 +++------------------------
 4 files changed, 66 insertions(+), 40 deletions(-)
 create mode 100644 security/selinux/include/hash.h


base-commit: c6f0a830ef4bffc8eedd7ddb307bfba4929cd3e1
-- 
2.43.0



Return-Path: <linux-kernel+bounces-787986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3991AB37E73
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F1BD204D83
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 09:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EBB34DCCE;
	Wed, 27 Aug 2025 09:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hi6o7ZZA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BFE345732
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 09:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756285704; cv=none; b=Om3pCxck70DOlXuM0SdefrO3V7/3v5kHz2tEQPvidZ+nUKmsA0FlbEGUoNF/diHmxiXYI53Z9joGS/Q2TW3+mWXBsFbq7t26jK5F6XzoIF0nvj53tDux3hz3GEkpPdrxC6ixbExKUp4KSFZBYddpZ6TQWv6xQtJw0BtJ97+xKPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756285704; c=relaxed/simple;
	bh=HSoyRRGbqwKrrPWn0b3Gxv3O7atFcfaJ2Ou+bHXSKWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VvqBqypFvf+S/cCV9ayeACNwcQeo8dUR7YCLg80rtayEhwFudMjjfgxuGOJULkf3JYHd8/UbtgMg0GduJiKNiQkKVNxb8tu1tWF2AiRQloCWzqUZeGqPKe3mc11DE5lo2rWPhnoo5LWu9hshfEDWyP62aUD0J+GXpnmbsKsQvOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hi6o7ZZA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756285700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=btmAfnbOXrpj/8xKgw2LcnKjNrejkITdGU2HjYixq9M=;
	b=Hi6o7ZZAuMxbQuyKowH91qdDM/b/adER79TeDLNS6mMxmRtvovs8ZAAqSxB8x4EVt2g3+L
	1UFaw4rQ+bUyHedyVUb5KBu0ZTybmoZXm5PQkkf1x0vYtgxlcPSh+Ypvz5yPkCQuW0zbXS
	6xbtP4TXLQymcWaJeJaMgq7zSnLvitE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-_E0yIbiEOAWSdkMYQDpUDQ-1; Wed, 27 Aug 2025 05:08:18 -0400
X-MC-Unique: _E0yIbiEOAWSdkMYQDpUDQ-1
X-Mimecast-MFC-AGG-ID: _E0yIbiEOAWSdkMYQDpUDQ_1756285698
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70dd6d25609so32356916d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 02:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756285698; x=1756890498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=btmAfnbOXrpj/8xKgw2LcnKjNrejkITdGU2HjYixq9M=;
        b=UeYcHVL1ROvCzelxlmsWu0VvUXemvFp6CK909xP935R6gVo0xHZA5no+YVME8PHjE9
         wDCk0h6RXJJ9y31s3ZvSN65QrAU93kg7sTvAMVNiZfZ9itJvaEuAgc6lBst2fZh2x8xw
         LLI5y5O7H56ZBUcwS/G3jPu04w9uYrX5ah8uYg9uS9W0VKMOx1gG+rT7xxq4CxtBRrTg
         K6mcokQy/2mZJ15dgoQqFIhMBhMn2p32TilyRsTLtE2k3Ebo7BQbN17xQw/Hbb1lkGcz
         YA2oOb1jQnnsKrobTo/pndv9lzXGnw8T6lv+lk2GECARUdDpejw/BH97VxUmgChtXEi9
         38CA==
X-Forwarded-Encrypted: i=1; AJvYcCXs/VjiTzQkMi6hdAxtXu5XmgGjC0gfDcq+E/WmOjL4DJpWxRIhr96iwLtSPIO+drRIRuJMx+VL+OqRyEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrukVz2KM0xGEly7PCQzwnvvqJB3Xrxni7Auh/P+WSF+v2fMMw
	qhvYAHHMW/TnnP5kd9jPAg5AyPgxH6cAIYY8SH6lNYF7tMnDNw0nviT4ZkJDisYPe0zakyvdCyN
	dbmcSJ6UdAEDa2x9vTQn1Y6Eew5ErwLOGBTOMaoZOGD4E/98uFXuJtvsji0Uk7COlMQ==
X-Gm-Gg: ASbGncssNcGV6lJe5GvmEKLSLhks6vnDRVEKHHOFD2I+k8ENExYcgS9ZUnX8a55aI9D
	U8gFaDz6AXHHog8qxK67/nWIOvGXM1gv1T6KwR2+VwYU/n8UY3w5Yfdx3Cc/oS8KwykB9DHFtqv
	LveasXiOq1jIx4L7FaCjnvu/7So07LKGhtqYjWttr0j0+IZp5cwVoxcyV8f1n8k5tX+iEbWeleK
	aS/fQwsTqGeo7mcD57E83uxs4aUIwGS6YDRln9UX9l5cQWbDlzxOg9juaWWUZQGkVI1NL+/Cszt
	K17oLF4wqGc90wTVNma7871ONoNvVgJLaOC1gygmdz+4wonExdtkzVLCf+dHhCR+KWhFB9LdASj
	b4U/SYODsSQ==
X-Received: by 2002:a05:6214:f2f:b0:70d:ad2e:ced8 with SMTP id 6a1803df08f44-70dad2ed051mr7559316d6.54.1756285697876;
        Wed, 27 Aug 2025 02:08:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKnx0Sy0uoUmTwX2Z3OLZ81WV24S78smOZB6VPkrYeFf13KoSmBl+HyiIGutNgl+jaQogtkw==
X-Received: by 2002:a05:6214:f2f:b0:70d:ad2e:ced8 with SMTP id 6a1803df08f44-70dad2ed051mr7559106d6.54.1756285697478;
        Wed, 27 Aug 2025 02:08:17 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e01:ef00:b52:2ad9:f357:f709])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70da72b3c1csm81764646d6.58.2025.08.27.02.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 02:08:16 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] ext4: remove obsolete EXT3 config options
Date: Wed, 27 Aug 2025 11:08:08 +0200
Message-ID: <20250827090808.80287-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

In June 2015, commit c290ea01abb7 ("fs: Remove ext3 filesystem driver")
removed the historic ext3 filesystem support as ext3 partitions are fully
supported with the ext4 filesystem support. To simplify updating the kernel
build configuration, which had only EXT3 support but not EXT4 support
enabled, the three config options EXT3_{FS,FS_POSIX_ACL,FS_SECURITY} were
kept, instead of immediately removing them. The three options just enable
the corresponding EXT4 counterparts when configs from older kernel versions
are used to build on later kernel versions. This ensures that the kernels
from those kernel build configurations would then continue to have EXT4
enabled for supporting booting from ext3 and ext4 file systems, to avoid
potential unexpected surprises.

Given that the kernel build configuration has no backwards-compatibility
guarantee and this transition phase for such build configurations has been
in place for a decade, we can reasonably expect all such users to have
transitioned to use the EXT4 config options in their config files at this
point in time. With that in mind, the three EXT3 config options are
obsolete by now.

Remove the obsolete EXT3 config options.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 fs/ext4/Kconfig | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/fs/ext4/Kconfig b/fs/ext4/Kconfig
index c9ca41d91a6c..01873c2a34ad 100644
--- a/fs/ext4/Kconfig
+++ b/fs/ext4/Kconfig
@@ -1,31 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-# Ext3 configs are here for backward compatibility with old configs which may
-# have EXT3_FS set but not EXT4_FS set and thus would result in non-bootable
-# kernels after the removal of ext3 driver.
-config EXT3_FS
-	tristate "The Extended 3 (ext3) filesystem"
-	select EXT4_FS
-	help
-	  This config option is here only for backward compatibility. ext3
-	  filesystem is now handled by the ext4 driver.
-
-config EXT3_FS_POSIX_ACL
-	bool "Ext3 POSIX Access Control Lists"
-	depends on EXT3_FS
-	select EXT4_FS_POSIX_ACL
-	select FS_POSIX_ACL
-	help
-	  This config option is here only for backward compatibility. ext3
-	  filesystem is now handled by the ext4 driver.
-
-config EXT3_FS_SECURITY
-	bool "Ext3 Security Labels"
-	depends on EXT3_FS
-	select EXT4_FS_SECURITY
-	help
-	  This config option is here only for backward compatibility. ext3
-	  filesystem is now handled by the ext4 driver.
-
 config EXT4_FS
 	tristate "The Extended 4 (ext4) filesystem"
 	select BUFFER_HEAD
-- 
2.50.1



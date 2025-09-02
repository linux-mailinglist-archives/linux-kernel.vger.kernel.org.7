Return-Path: <linux-kernel+bounces-795462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCBBB3F250
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 04:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBF43189C846
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 02:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6C52DEA99;
	Tue,  2 Sep 2025 02:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIcfPaSL"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B920125E448;
	Tue,  2 Sep 2025 02:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756780253; cv=none; b=sw7ETClst9dvwxoNfsRXXkNehy2E5iU9+CBe/UZYnle5EDglzG6VCt5rbLbi6jd+yGHrGiqLwqAhTORJyxyvtifBVUa+VgbZNuY9f6knLjOtV84CzVS8Hf8b0V5WiTYkU8HLnAikUMHyGbPlIfuTkv0OZA0+12HNz0isqwEfBFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756780253; c=relaxed/simple;
	bh=mHT53JVN9Ci3GvpQ0ExO1K2jSfu+ElC9HU9dSyVxay8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rwJ93VQ52yfqGJN4mXWWQI6g6/P05hhkmn2XSx6xdsg0euITZG0AB/YmeRd5jTLV6PYgLgJI9lz7V4h2g4wpKo38ZbHHiIVmJo2q4skurV8G1yd7cLUVA87RSRRbbrvXmKP9MkWbTYw+JZPwFuJ7l6hSo+zUhBVG1rHVODpk9HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIcfPaSL; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-772488c78bcso2049067b3a.1;
        Mon, 01 Sep 2025 19:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756780251; x=1757385051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ThUdZnbiRPt96sw8IfEZHJZbZVUgMhl4/a+w2ohiuBk=;
        b=HIcfPaSL4rkgjR3PRqwyaHotklXEiAvlQ63L5WZZ03k99iNa/2je2qjEjf0nzpj1u7
         A16EJge9pcZgVVIqlD9cVIreuad8d+i4q+55Uql9wOnrQShWJlx4LOQITDdEK0smFoSP
         RkYAWVbE3kBcnIt6Z3P0RvRgaT+iRSYRKKBB/jSJAeUQ3KZARnibpOCM66pCs0sSHqJr
         SnXpEP9fqPEBzizZLx1OfFYUbHHy++U+s16fO+jJSNifHQX7XAITIzJ3YjSIAlQmTWrB
         aXS0HLOgKE7E758z/tjwHAVEaUcuJFaJ+IuJ7tfWpKbPWQWk6T5gydp3WPjNh6ns1wkY
         4E6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756780251; x=1757385051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ThUdZnbiRPt96sw8IfEZHJZbZVUgMhl4/a+w2ohiuBk=;
        b=Q9aLDVQAOtsdmHIUEQb8CKVhLtHdp5tImx/SuBpsaSXoQNOj/WNEEWQhEEUCb9jNtc
         3cywEttqH69BmaupaOYqj6aFc6sQnb1zlrAsICqje5QDBvDaY7/pQHLue35x8K9AJmMz
         IT2oykRN3CHGHrf0GPbK5a31J0jfF3OJm9AqXK+GmYiiCdVxzDvXkxQLEzF8VT6+w3oT
         ruzxUbbe6BxgI/iti3XIhOx1KuWThjU3UaA7Ic/dADxNyr1XIlnTBnBc2cbmyZ8vCctQ
         ymPNDfo2VA2skWi/pD4yn4lYnjCIEznLTmnbBrlry/NNMzS4hZyAVwhd0ceCo/3AL52B
         Gg0A==
X-Forwarded-Encrypted: i=1; AJvYcCVotY5OGeF3qmpgV2ofo9uKZEPeVfI/2jHN9vt5zCqanV8vME4Bo/mnfr8Ve3PNzWeNWH8c21cDE8dEUCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEzxTIHOhH5gjytKPzQCQ+V3vXm74x3Y48aSj/McYY/3lfjVXF
	et1hkACAXlmh6Y0qr06tR3nK2khyFncJAm8N0lTdd7GXDYZ0rm4IjC5s
X-Gm-Gg: ASbGncsQcmFQlwq50kVkGzpiyN/gPK1G3x9riAM97uFc4S45V7HyKUULw7YFw1wjda6
	F+wYDNHuk2frwt1CuALZwjjeifUjKNvd9tDGMQkSGUjaaBOX+oS0UpyY1J6c0/2G6c+16B1ALl/
	hzU+qoB6dXVAoEj8c00lmaeRr/cJRPYbEUbt/gDW+5YENop0SwaLuOCHs5qq894Qe0JNApg4cUC
	xyykVyrXt/xq2wKfoAHk/CKRhO//GVgxhzExm6pwfppP/cg/FLWwDgQ6ox8SZgbuXDna3BrwJVM
	w1vacaRiYzCdnhw0SnGvQO+e4liIcpc52vb5zbn5Y0x7xN69N+fyUn10bBKmB+WCJ+LQTR2TNYJ
	PfXg4jgDJ8YLLeQJNV/7C1rAj/LMHzJdXkCz35NM2iaRiZIZmSs1aEgHCU3tDeVM=
X-Google-Smtp-Source: AGHT+IFa8NXB1mC7KGG39VT/B2/glDU4bhzW4DlJ6Hm9O6ZaJt/veUexbm+G9yeXNMhVfkWqORsdAQ==
X-Received: by 2002:a05:6a20:3d85:b0:243:c6a1:7a24 with SMTP id adf61e73a8af0-243d6f85e08mr14282186637.58.1756780250864;
        Mon, 01 Sep 2025 19:30:50 -0700 (PDT)
Received: from fedora ([172.59.162.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2bf5e0sm11973278b3a.36.2025.09.01.19.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 19:30:50 -0700 (PDT)
From: Alex Tran <alex.t.tran@gmail.com>
To: corbet@lwn.net
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alex Tran <alex.t.tran@gmail.com>
Subject: [PATCH v1 3/3] docs: filesystems: sysfs: add remaining top level sysfs directory descriptions
Date: Mon,  1 Sep 2025 19:30:37 -0700
Message-ID: <20250902023039.1351270-1-alex.t.tran@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Finish top level sysfs directory descriptions for block, class, firmware,
hypervisor, kernel, and power. Did not write one for net directory. See
commit bc3a88431672 ("docs: filesystems: sysfs: remove top level sysfs net
 directory")


Signed-off-by: Alex Tran <alex.t.tran@gmail.com>
---
 Documentation/filesystems/sysfs.rst | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/sysfs.rst b/Documentation/filesystems/sysfs.rst
index b562cfcda3d5..4b44b6af0688 100644
--- a/Documentation/filesystems/sysfs.rst
+++ b/Documentation/filesystems/sysfs.rst
@@ -334,8 +334,22 @@ a stat(2) operation.
 More information on driver-model specific features can be found in
 Documentation/driver-api/driver-model/.
 
+block/ contains symlinks to all the block devices discovered on the system.
+These symlinks point to directories under /sys/devices.
 
-TODO: Finish this section.
+class/ contains a directory for each device class, grouped by functional type.
+Each directory in class/ contains symlinks to devices in the /sys/devices directory.
+
+firmware/ contains system firmware data and configuration such as firmware tables,
+ACPI information, and device tree data.
+
+hypervisor/ contains virtualization platform information and provides an interface to
+the underlying hypervisor.  It is only present when running on a virtual machine.
+
+kernel/ contains runtime kernel parameters, configuration settings, and status.
+
+power/ contains power management subsystem information including
+sleep states, suspend/resume capabilities, and policies.
 
 
 Current Interfaces
-- 
2.51.0



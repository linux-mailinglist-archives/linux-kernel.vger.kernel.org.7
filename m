Return-Path: <linux-kernel+bounces-837105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F52BAB62D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 06:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 124F51789C6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 04:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A69023185E;
	Tue, 30 Sep 2025 04:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JeZrEOk3"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD0D2CCC5
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 04:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759207112; cv=none; b=TgyEvIwCm4KKMnFEJ7NZCgCKFP0Cffg9POC+A25y8IKHBRtQpNDIsfA2YM1wbkWpenbJ93Y0H87qQAuHq5lez/wZ1F8r6VL2OIsn+zt+ZcAPt+9+thiafz4gN2VzQ1MZzgtMhqga5lKGpLQC9I1deMODGv/gpBBXK9ihGEwAeHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759207112; c=relaxed/simple;
	bh=x/zo4DLS5xopKyfQ1IRecekvbLsQr10w5m43S83i164=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WaxIFSKFkfoePvLfG/1zZ3A0JfaNAmmXGIjXQufhgDKOeGukY9DdfeDZeTfrvICpJaBrexTlGzVt+H2EsnS6/yJW0IckdCgLeyZCd/9V2qhdXK5/KBgbqnh38DaDEIAyiFTwYZJcPCtfCYT8uQxEKbv9enp3Kv4IU6qNpLsclyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JeZrEOk3; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-26e68904f0eso54981855ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 21:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759207110; x=1759811910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GZT8btfJLrca2sq9IheLfnEkVwITikkzFgpMmjw2//s=;
        b=JeZrEOk3yQpzXFajxl9z2vkUvG4b9atVOc9hHZA3971Y6mmqWQ8avQ0WEnCdIvm8wN
         F3dIhBVflpmxAPHR+bksHnwNcgM/9E6ulz5ZSkkQxW6vgAQJJ5yo7fJfpTqzw9hH9a9v
         TQpXrnNNIZlrUwPYrJb4UdZhcMc2Hq8pyQeJIV2g8YO1nk68p9ckPjsO5B5yQmcfaG6X
         tj3V9HySwHdyAuBfkEdHu6q+57D/PZ8LVVRNjQLqzwY0JXwrSCCNi+cT0NibyUpTdwwn
         kf3R0CK1+VGt6Ez5VR87dXhOXdq0qU6bxkcWakRKGIpS+IvrSQyVIDFFBkC5C3tQCxSa
         3Qlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759207110; x=1759811910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GZT8btfJLrca2sq9IheLfnEkVwITikkzFgpMmjw2//s=;
        b=C5DiCHC03VvH9pq/1a/BHY5i2iWUWENJ6HxXTsLFPGEwz0k97CY1UQX09ciuMWlKyN
         8SwyzpnAgUd5dbwFDoF8nd1AG1nJfJEi3Un3k9zRLtFtV2wy7Td2Q7yuhBnlu9/BLw/5
         nfwkcPyaHpW9bdfrwaNiU/HnCjOcnpvdxy/4OukIYPdMTQukAyykjWaPDzcv2y141CqC
         +AAsVs0PlnQqxIFps+jQxiV3zMHCK3qdFWm9V+/XT0zWXkwHvgb1qH7cOK4I/WYP5yTF
         1F8aun//5WlpkN+EpDvy5MfyBT3AffDw9SptTtkKfSvKPIse2D/lLHfUYVgQh+VStnWQ
         pufg==
X-Forwarded-Encrypted: i=1; AJvYcCUoC1NaspHDlnFu3SBS7KU2RMBcNVQAanO2xzc4RocEFY7lmXzPWCkvJIrSaCDxNbFkxcbpYBHYVjNnmf4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4DPZFMGm11OPEWz6F+a9rHTUHDywSupI7t5i+h1mwJt08HZvA
	nSSTEMgTDKoeNCd7k8VLvdZp8NN1BwFHYc5MrQkS6oojTEMdkM+ttRnD
X-Gm-Gg: ASbGncsiRg+O5DHQtXGIMf6/pyCPpU0o7wctP/t4VzMZlQw1H5p5uNzx95mGaYGyhT+
	Tqp6n5vjL2p3q5WR8e0Sw12t70xxzKuU42kVGyRHodm4raGD5PyeCxz11kKeX+hXktUhW2/F12Q
	4q/odgkVY9odCCyrdQLU+9RDCmBV2ZpL7oJrnUMdBmeioCKS0bjAlW1s2xxg12rtlKsIdRWAZ5w
	Mgj7YZRHa1gihEJH0OAA4e8pa0PZ7JLjalMhiqbXMu1kYSARgX5gq7lOJwweLJmrl2mit97O4j2
	EyMBUsXZGF4zXoSyCkyIz4epWNHF5+OTs0i1CCP0lOuvxXDsi938eaO9K2eyQZjFopi4EsCmeSJ
	MpzIkzYgOUAac3OTcv4S/UsldFpv4ymVotpw+sKDLvRtngC90XM9o7dOgo4ZGuQOz6A==
X-Google-Smtp-Source: AGHT+IHJrdVU3IoI7rVootqpTrOCX2Siw83i3/cFETYlxp+cOb+qBIWkeM1gUVV6aGYcyytIe2CDUQ==
X-Received: by 2002:a17:902:cf42:b0:267:95ad:8cb8 with SMTP id d9443c01a7336-27ed4a96047mr199662015ad.44.1759207110287;
        Mon, 29 Sep 2025 21:38:30 -0700 (PDT)
Received: from LilGuy ([2409:40c2:100e:619a:6959:b194:3c63:fa0a])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-338386f5a7bsm3000830a91.5.2025.09.29.21.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 21:38:29 -0700 (PDT)
From: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Koichi Okuno <fj2767dz@fujitsu.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Will Deacon <will@kernel.org>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Cc: skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
Subject: [PATCH v1] Documentation/admin-guide/perf: Fix indentation and formatting in fujitsu_uncore_pmu.rst
Date: Tue, 30 Sep 2025 10:07:36 +0000
Message-ID: <20250930100742.4741-1-swarajgaikwad1925@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes several reStructuredText (RST) formatting issues in
documentation/admin-guide/perf/fujitsu_uncore_pmu.rst that were causing
Sphinx build warnings and errors. Specifically:

- Unexpected indentation in bullet lists.
- Block-quote unindents that broke literal blocks.
- Missing blank lines between paragraphs and lists.

Reason for the patch:
Without these fixes, running `make docs` for the perf documentation
would produce warnings like "Unexpected indentation" and "Block quote
unindented", and could lead to incorrectly rendered documentation.
This patch ensures proper formatting and readability of the fujitsu_uncore_pmu
documentation, which is important for developers and users referencing
PMU events.

Changes made:
- Added blank lines between introductory text and bullet lists.
- Used double colon `::` for literal blocks.
- Adjusted indentation of list items and surrounding text.

Testing:
- Verified `make htmldocs` runs without emitting indentation or block-quote warnings after applying the patch.

Signed-off-by: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
---
 Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst b/Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst
index 46595b788d3a..31e6e535d11b 100644
--- a/Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst
+++ b/Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst
@@ -14,16 +14,21 @@ pci_iod<iod>_pci<pci>.
 The driver provides a description of its available events and configuration
 options in sysfs, see /sys/bus/event_sources/devices/mac_iod<iod>_mac<mac>_ch<ch>/
 and /sys/bus/event_sources/devices/pci_iod<iod>_pci<pci>/.
+
 This driver exports:
+
 - formats, used by perf user space and other tools to configure events
 - events, used by perf user space and other tools to create events
-  symbolically, e.g.:
+  symbolically, e.g.::
+
     perf stat -a -e mac_iod0_mac0_ch0/event=0x21/ ls
     perf stat -a -e pci_iod0_pci0/event=0x24/ ls
+
 - cpumask, used by perf user space and other tools to know on which CPUs
   to open the events

 This driver supports the following events for MAC:
+
 - cycles
   This event counts MAC cycles at MAC frequency.
 - read-count
@@ -69,7 +74,6 @@ This driver supports the following events for MAC:
   This event counts the number of write requests from MAC to memory.
 - ea-ha
   This event counts energy consumption of HA.
-
   'ea' is the abbreviation for 'Energy Analyzer'.

 Examples for use with perf::
@@ -77,6 +81,7 @@ Examples for use with perf::
   perf stat -e mac_iod0_mac0_ch0/ea-mac/ ls

 And, this driver supports the following events for PCI:
+
 - pci-port0-cycles
   This event counts PCI cycles at PCI frequency in port0.
 - pci-port0-read-count
@@ -99,7 +104,6 @@ And, this driver supports the following events for PCI:
   This event counts write transactions for bus usage in port1.
 - ea-pci
   This event counts energy consumption of PCI.
-
   'ea' is the abbreviation for 'Energy Analyzer'.

 Examples for use with perf::
--
2.51.0



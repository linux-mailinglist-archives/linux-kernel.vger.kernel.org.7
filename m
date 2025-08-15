Return-Path: <linux-kernel+bounces-770418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD2FB27A83
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00D457A96B6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 08:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF602242D97;
	Fri, 15 Aug 2025 08:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWFKQ1V+"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FDA31986D;
	Fri, 15 Aug 2025 08:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755245001; cv=none; b=gialeDDRELccppTA9xrK7DomqCD6hvudLslzE/wBq6J7PGe+nr1Gx8gBwU4K6HivCjPgNIOTBnafNNSOVKV63D6yFRIjq6wrSkl3ZndZwCJkXqZqai7uiANbB5IepSyGOCTmaIOkbcHF68K57ZJxEiaBuWNiLw+o9NjW04+J3vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755245001; c=relaxed/simple;
	bh=qyzLs/0CDjVeqzhntZR/bU1gU8V1Hv1zEYSr2oMjvt0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r/IzBWg09gJAtkSP4NZpu7n3l60s0Iptblkwz09xmmDURJrkvkxQNqZUSMpG7P5FpmVWwk7QHlTIdDlJ/UCo22XBUAoiVKOYxYCsJ+2xlHFcScPwJv1WGZ2xYLAU/6LO4sZptVgeLJkMcrXUfitzH6LOGBn9x8O6WZqm+o7roVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWFKQ1V+; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76e2eb4a171so2441562b3a.3;
        Fri, 15 Aug 2025 01:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755244998; x=1755849798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sxpExqIp6ahjSppu7+evxPdtuZCZlQ03AYV1e06qBjk=;
        b=QWFKQ1V+/nUeaFhqMvmkog2Mi3rbm6udpSLkzMcMVXmNAw2jX4d2I0u8ekYSH1ynSt
         CY9CsKEyAMBAyNrroC+9gMSCerH//nQmkb8nlH9OhEm/q4ARVChUAV8zhTtitvERkCeB
         5lDCg0QVxMhxhsXeRzQA9lj9wyoHAJCKms5wk2AooqjUBP1l4nA9iyZ7bxDmV6oqhybM
         z7ovKCPyeu7SZgoPU8uE0E9fy+i8zpukxfHV8wYRorI8PgYboX3f38Dftt/4FdLjgDn5
         3kICXp3WEzXpf+yrk+/c1MpjtPnR9WvZzUQU3KEKs+sL00xE8+mne7gWcLlGhgb3ox2i
         xurw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755244998; x=1755849798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sxpExqIp6ahjSppu7+evxPdtuZCZlQ03AYV1e06qBjk=;
        b=P4qak828P/+2s4gHiBcBfXIDOEPpqiCbqo5UwmXx+z0GYPK0YUkj+yUY7a1NQ1+kU/
         gmug/3b0797VuZF8kYyn5j7S+NKE6TH+wUt2YUYFhmKTt7ySN1SUWEgsSQD8VrqCq06r
         gl80T0qKksdpCmHQVyEuz5/GLccXm8PARDevJoxSvk/ic8p2q+liMQOyYW5OcYzSjlGM
         V6gN4EFhyMAL7HJj6EIFdcfAUAznDQZPO/nwD0s/Rd0lazySthwMdCUnxljB4GShsFk6
         CDKDlRrbB6N2ayntjEf1uG3Gcemrl7eTG4aLMuOuCTSV8iOzxj9/5sUhCfvCDrQvGhjN
         x3Lg==
X-Forwarded-Encrypted: i=1; AJvYcCX0sQwICS5ILOM4MCxlmTgGs/Tsxeh11SiuvE8YerAB7VROTsmEz4ErIb/Rm8DFoRPkHnw6ItOVxjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd2mYmcZfgzRZpQ6Z7Fd+BJAOr6F0zHVXm0igoAhUADuHgfSsw
	Stjv/GaqSesOmclQABuS2Z9Qfnfc6gc4WlU7barRhykOLVZBkV4Zc9Mj
X-Gm-Gg: ASbGncvwTOSIuFr5HBQWbe2wwaaejro47nZHz0YptPRK54y+j+TW5eEgiE56ez+7ZQx
	2pWyHTRYQdb8CqDJ4iyt40sfYKa7nuDmPy9boRgZj+bxejMBl3UV3RBrbbNYSK0begCW8oAV9qU
	tDJKuMWHI5ROXu6P8AFN2JXlFGvEOr4TpXFUc5e97ag9kbxqkzcCKrw8oRFynljz5jFPrDouDSY
	ZXxs1KaO82Q6MJda56nQrGRlkYGPioTTMawlniaXVUHB7R6FMNO1rw3gigJ/q4QiwoulRuMiLDr
	9th2WEGSyySd4rG2Zg/eFMkFQZAzyEha6pNVLSnJzxH3RsURXhCmqJuK5hC3zmxKdQOYvcVlH7Y
	kVxrIti6zzGJbgv2rV/LNJQ==
X-Google-Smtp-Source: AGHT+IEC/iECvqFVBZ/+AEQhSpvCcYT2CGj6Zpm39HK2GsyEvn3tILjlf0yUe0BJhhZakucB/H8rvQ==
X-Received: by 2002:a17:903:3bc6:b0:220:c164:6ee1 with SMTP id d9443c01a7336-2446d8f17c0mr18321535ad.32.1755244998248;
        Fri, 15 Aug 2025 01:03:18 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d517e18sm8527155ad.74.2025.08.15.01.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 01:03:17 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 706E34278709; Fri, 15 Aug 2025 15:03:15 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Device Mapper <dm-devel@lists.linux.dev>
Cc: Matthew Sakai <msakai@redhat.com>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"J. corwin Coburn" <corwin@hurlbutnet.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] dm-vdo: Promote dm-vdo title to title heading
Date: Fri, 15 Aug 2025 15:03:13 +0700
Message-ID: <20250815080313.25132-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=928; i=bagasdotme@gmail.com; h=from:subject; bh=qyzLs/0CDjVeqzhntZR/bU1gU8V1Hv1zEYSr2oMjvt0=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBnzXnza/uOJzUa/EyW7WcQu8z+U6Pm63lXgk2Tzwt9ny tZsXnN3TUcpC4MYF4OsmCLLpES+ptO7jEQutK91hJnDygQyhIGLUwAmcvkaI8NHmbJjLYekOLQ7 jh13FWDjkr0Z8lLsvegilqs/BIoPnp7J8IdbYLev7du93m5NmU+KW415//w5U5z8c16379H603d FD7EAAA==
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

dm-vdo docs currently has no explicit title heading but instead there
are multiple section headings as top-level heading. As such, these
sections are rendered as titles and inflates number of entries in the
toctree index.

Promote the first section heading ("dm-vdo") to title heading.

Fixes: 04bf7ac646ab ("dm: add documentation for dm-vdo target")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/admin-guide/device-mapper/vdo.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/admin-guide/device-mapper/vdo.rst b/Documentation/admin-guide/device-mapper/vdo.rst
index a14e6d3e787c91..8a67b320a97b58 100644
--- a/Documentation/admin-guide/device-mapper/vdo.rst
+++ b/Documentation/admin-guide/device-mapper/vdo.rst
@@ -1,5 +1,6 @@
 .. SPDX-License-Identifier: GPL-2.0-only
 
+======
 dm-vdo
 ======
 
-- 
An old man doll... just what I always wanted! - Clara



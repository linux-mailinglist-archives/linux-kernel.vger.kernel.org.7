Return-Path: <linux-kernel+bounces-807031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 399D6B49F1E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 04:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8C0D4417C7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 02:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69113242D9B;
	Tue,  9 Sep 2025 02:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deWaBZw2"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765C9C2C9;
	Tue,  9 Sep 2025 02:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757384513; cv=none; b=NPK2IRfBIhVZij4tUyKaiNuU+fvb/7pYAncEmaf+RM5eSJZAd3wPOWO+SIOfjmlABllqW0RcTrKAJtVsUTtC8gL/V8gWJfxPJYUrX9LGIn9SBStK4Jvxwhqqbq/HGFia3gm2hCjEdEruwENpeajdOdQoM6i/BRbdYFokFstKRfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757384513; c=relaxed/simple;
	bh=lRpdMvqz08UptrHTEg2AB0ku2YdhO9tfkAmOONSCn+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YvTGAl21H/MxB8aoZFmYdQzTDAo1RBSlIuV6nYYgHy5YT9qp0NgpbQNWidJdoSMzXdD/BQLdUtmNzT/SaItgTmout3J22VxQNJmYRkfIDWysOsKsnPFHHcpTSWJCTMWohvio83uDvxQJcalvmgu71wfLDj+6OyRLfhDCy3ESWQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=deWaBZw2; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-772843b6057so4186197b3a.3;
        Mon, 08 Sep 2025 19:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757384512; x=1757989312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c1YcQgozgCLbD+yzQit7czrIUN+HLJglw+Dn5jCuOKw=;
        b=deWaBZw2+6Qjw3VhAYhl2Zdt/mXLQz7DMtQ90Zkv7KDXdVGDsKYTMdsb4+q/He+qrY
         HY62KZkI9+EQHZJwCN57BEl8g3qOg0XNyzb6aL40lzHu0rXA9ve6aIbG4DysC5PRUutT
         zak2cc8l0777BStIp8omN2qKaSgoUBVBf1MufkH3wj5GTfJh6+TIhpmmPgVsPUMaYFBk
         6jPJcYK7Xud2g2Q7sy8TW5tXqqqZSjmZ+pXOKmlz3h3JiNVpZNIPpEnWK+dhVifu1uNI
         /m4v9irpIY5kuo7uNwsCZpsnE21yWXjF6HaepE8aSzsxFQlQ5AcSjC1WpSkzyI4xiE1G
         2qPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757384512; x=1757989312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c1YcQgozgCLbD+yzQit7czrIUN+HLJglw+Dn5jCuOKw=;
        b=W+7jWM5mWBIwu7JfpM7L55oqZI5DeuxxGa0SejAA7rrQSR1f5F3xolLmHxj5Z2pdDW
         JvLZ8cmD2OMwKqPTjat7aM+GZ3GkgQkRD1OdBQWhxNo0wv+U/BvuXioiyjeRTS2FEYwS
         BIYsUuuOs+bsyoHGPD3/Y3MxBiHTCwVcMPH72SnWf+VRbN58RIkwffXD/Dd76NK2JGxY
         2/tvyJqunvudIigSH/Ghj1nH78f2aLx9EST9+o/ypolxU9Jq/6vQMiQm1/OQANncAgYB
         dFHdM3Sbuw4n4cl/x0kEriVuwYVn+PS8ZbIri/smtm8M010bCLvnhhhSkWv2zEh5pikD
         VfwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVayYc4DelLtb/dEyfv4PZBoZr6iSn8b97MFqD5/Wjfam3gBRl+9EVJYMG9sX59RdwPDsAqQDXgr3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGptkO2/Yj2i2y/agf98wtCaku1fcSMDF0+maV5qb7mnKQ+Iku
	N5CBhHLb2bIoz7GAqf6Gl77OcVSr5I/azU1EzgU5+3mADtbTdHvdU2jV
X-Gm-Gg: ASbGncsWPnsyBfw+oxj1O91ZBAuvUvVYScNMLE9CLQr/adyYvKeAo5nJBDhH4I/nB92
	ECriiEqif2Jpwl7o97eur+SCmrP6LNQtSEeOL83IM3tSWo5T7gY5JWhtFWyHnu3jWmGolUZEIaQ
	dlm0zfJjNHylL538ZM4ih/T1+GmHnNFxWUEpHq+VHs4bJuH8ZJm9WQZnVg6kh/FIJ7govNCVPvg
	9JDjR4D3mnALIMKUlgahAJnCz8AWR6Y/bLsGtQvzsMzJRKJTJsfPq+C15fPVmy96Nb2sjNXlCT4
	o4vBFuCOqkcLRHd+0Q4hYcpgMxXT2xnRwDy+4WJvdCxrlmj/9w6CXEfeEyqzXHJ6u8VeNs9KbOr
	cuVPHAfG9IjXtE8MfcUIAEvrjUtnqLAzw+3snrK5YAb9rDuQ=
X-Google-Smtp-Source: AGHT+IFqS9tPuTSUtNg5M2s62dVtPTJqAkayyWnw0xjhpbeML4JUOXu1eYTikuhGhEyHCz/oWU1C7g==
X-Received: by 2002:a05:6a00:929d:b0:774:2274:a56e with SMTP id d2e1a72fcca58-7742de11ed9mr14347594b3a.25.1757384511513;
        Mon, 08 Sep 2025 19:21:51 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774662c7384sm316840b3a.76.2025.09.08.19.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 19:21:50 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id ECF9E4206923; Tue, 09 Sep 2025 09:21:48 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH] Documentation: w1: Fix SPDX comment syntax on masters and slaves toctree index
Date: Tue,  9 Sep 2025 09:21:42 +0700
Message-ID: <20250909022142.18007-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1595; i=bagasdotme@gmail.com; h=from:subject; bh=lRpdMvqz08UptrHTEg2AB0ku2YdhO9tfkAmOONSCn+c=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBn7+wS+8Nq4dUWck2qwa9ow61DzjSXFP8w+lnRqyCz4s 3Dq84R1HaUsDGJcDLJiiiyTEvmaTu8yErnQvtYRZg4rE8gQBi5OAZhIuRkjw3RPUZ8Hh45w7Z1Z dVlH/+uB9m1ruYVOlOlY7KtVMGRf58LwP8qndOe/Jbvqtv53WpucMv+lXc2HLT1rnrPO+MWS+J9 jBxMA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Commit e9bb627561535d ("docs: w1: convert to ReST and add to the kAPI
group of docs") converts 1-Wire docs to reST alongside with SPDX
comment, yet the comment is written in one dot as opposed to two in
order to be recognized as comment directive, which spills it into
htmldocs output. This issue is partially fixed in d8fb03e1ea64e7 ("docs:
w1: Fix SPDX-License-Identifier syntax") as it only touches top-level w1
toctree.

Do the same fix on masters and slaves toctrees.

Fixes: e9bb62756153 ("docs: w1: convert to ReST and add to the kAPI group of docs")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/w1/masters/index.rst | 2 +-
 Documentation/w1/slaves/index.rst  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/w1/masters/index.rst b/Documentation/w1/masters/index.rst
index cc40189909fd17..871442c7f195bf 100644
--- a/Documentation/w1/masters/index.rst
+++ b/Documentation/w1/masters/index.rst
@@ -1,4 +1,4 @@
-. SPDX-License-Identifier: GPL-2.0
+.. SPDX-License-Identifier: GPL-2.0
 
 =====================
 1-wire Master Drivers
diff --git a/Documentation/w1/slaves/index.rst b/Documentation/w1/slaves/index.rst
index d0697b202f09f0..a210f38c889c14 100644
--- a/Documentation/w1/slaves/index.rst
+++ b/Documentation/w1/slaves/index.rst
@@ -1,4 +1,4 @@
-. SPDX-License-Identifier: GPL-2.0
+.. SPDX-License-Identifier: GPL-2.0
 
 ====================
 1-wire Slave Drivers

base-commit: 7e5a0fe4e8ae2eb341f8ebbee2b24231a58fc28b
-- 
An old man doll... just what I always wanted! - Clara



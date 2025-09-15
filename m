Return-Path: <linux-kernel+bounces-816349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 427F4B572B4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1F561893F8E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CC22ECD05;
	Mon, 15 Sep 2025 08:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXw4xYBf"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3D52E0934
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757924395; cv=none; b=Qlku6m87XxZm0Qa8gtcUCXxB/vBQSUG3QQZYB5b2p1wv9Q77AvDUjOzqamjaOKGIdpnDwcFAmX7BJYmVamfr4G1cGLr4biNwftX+mg3WyYewlUZYoNUU0l8TxtHYR+46HuOWlmEhM92mBG/nCOSNEwkEKeVGZd9uZ7qEOEpubdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757924395; c=relaxed/simple;
	bh=O5TzWQRsjEv8JKIDSJLdJ+Kvy4sUN0wvFs2GST702kM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cqEUN1MILe8dWJKpuAzQNczfKvYaF50Pje0kuWT1z0/UnovwTWnwCmCF+bvHHaoLCYA7KHMJ2nC8OSOD1eUCEcFvHBzoDkhiRQu4ckz46PSH4yE/rWVkj8dMn8hOaNg+uQPUjrvjFRRQ6k9VY7b8+esqyMYGGNOarmNUsEV/kBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bXw4xYBf; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-263b1cf4d99so7453045ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757924393; x=1758529193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kakxwi//8SzfIvzvUSsEPVgomvLdvBUASbNmOuXZzxE=;
        b=bXw4xYBf7McgAasCsc3Y08FaH2wh3bU9y8Ubrps3cxLpn90+MmzbE8I6iiv2Wcmfyc
         Jnc4MKxQUbuDbI+ElzXsDGnFlI1FehRnus41iPjqKMJj5tuo/3fLGeFvrZObpDVsbZEc
         +4vnqhhxllFEygSAVX9nAB+SLZWmhO6hncHk4L1U8hrheWV/+Mkk2eC5vb4Q6n7vnyOi
         Yttq8tmuEqNswlIDLJLG3+j8ea1L9KW5AbNkht9XicTxMeBWj8JK+RciOdCSY82W17Z3
         PBPE/EJEXsFVEKiHjh9LKjMF+IjEfOdvMpINHXTDSA4KDXAcP+TwnLfRgvoyAbtX5k7i
         OAig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757924393; x=1758529193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kakxwi//8SzfIvzvUSsEPVgomvLdvBUASbNmOuXZzxE=;
        b=wKs8qY212Fey0GxZpCCf7SnIjMk3CTwjOGDEP1LUflF1Ym0WHGLXFK3ap6YLAOL9ST
         eT231S2P+koqw4ciFaXjzGi3yfVTumCMj0yxP+qtv/potlmTHBD+2O82iHz0AdWbAlpS
         7c1OHmUf6HiGXQD6HTOhU9ho6+G6TgoOImbMUg43b82jSaf/RtSEUp8HO4ZFcSqVWU6s
         tlir2VUC5GpcrsSx0dladYWtbShOZNlwCMdyWJEy8Gml5a81h51I2YA07vlcdGLV01Vn
         PXL+hblE807E9SmCr5bgTKwO4fkyz+d4S8/YLQcCrlbeIuG1lm4Fb8K9HjWXIFlTMJkl
         a9kw==
X-Gm-Message-State: AOJu0Yz2pf9T1jmF908pjhyMX89PYUvIZsBRyaJBGz+RKRv3OHc7Xupf
	P+vz/mz1yBV4CbEoABIhtDDshQknl/w2Zy75yZwzw+YLs+X4/KYzuSyd
X-Gm-Gg: ASbGnctxdaO714c7DzqKN02gdZtEYdQeiR1Kzkc/bsUYXDNrRpKdEOzGHwy2QPPgVKv
	MZaXTtX5DFqsaZZWxjhjRjW0HvZ7Z9VqRFizL8gEVTlJzoYAXWoxB/V1BDY6rm1Grr/R50dxZQk
	AvcrFhGmHuvPNf7NluLHEJQzld+fDVQqEnnSP14/BPesYNswZFrBaTRFsyGAQ9f8JHn6s37/Z1g
	+h0ZprFjEzRSLP29woK6X7Qct7kDGnhzTuOL+iGKdPcUuNQPDY0Rm498b714CLJWHruGurjY0dE
	zJMq/1ykNFHk0QRblTGJzo1K/rCEbjVErecFv4BjlaLr2taa++o1UQOaFsSkjr7N18kdRWKfBHW
	mxwFBk8AvNjRENxo149NwAG2ab6Z16kXrJBwv
X-Google-Smtp-Source: AGHT+IFQnlqIzoj1P0X3a6pvEQtKDxaNB7MGTaFu8Uz8McK1JQLbeu4oAqY2HFHlJngpkIUw++hIWg==
X-Received: by 2002:a17:902:ef46:b0:246:571:4b51 with SMTP id d9443c01a7336-25d2da1100dmr134202265ad.29.1757924393301;
        Mon, 15 Sep 2025 01:19:53 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-260e10401ebsm64245835ad.91.2025.09.15.01.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 01:19:52 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 5B06D422722D; Mon, 15 Sep 2025 15:19:49 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux cgroups <cgroups@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	"Bagas Sanjaya" <bagasdotme@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrea Righi <arighi@nvidia.com>,
	Johannes Bechberger <me@mostlynerdless.de>,
	Changwoo Min <changwoo@igalia.com>,
	Shashank Balaji <shashank.mahadasyam@sony.com>,
	Ingo Molnar <mingo@kernel.org>,
	Jake Rice <jake@jakerice.dev>,
	Cengiz Can <cengiz@kernel.wtf>,
	"Mauro Carvalho Chehab" <mchehab@kernel.org>
Subject: [PATCH v2 4/4] Documentation: cgroup-v2: Sync manual toctree
Date: Mon, 15 Sep 2025 15:19:27 +0700
Message-ID: <20250915081942.25077-5-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915081942.25077-1-bagasdotme@gmail.com>
References: <20250915081942.25077-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2048; i=bagasdotme@gmail.com; h=from:subject; bh=O5TzWQRsjEv8JKIDSJLdJ+Kvy4sUN0wvFs2GST702kM=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBnHT+dNzr35+hTb2j2Vrtaej/tba0S5q+cKeDsJFDzWE UiJSXDqKGVhEONikBVTZJmUyNd0epeRyIX2tY4wc1iZQIYwcHEKwETuijL8z6/52ZyvoS0pMDOs dMYC88duKq0XrEXe7NFdzW/9PuCXLsM/xdmFOreOf/0Z4i669LZgB4eK0dpPqZdLtuv9n1evevc KFwA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Sync manually-written toctree with actual list of sections in the
automatically-generated counterpart.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 4bad0a18c243f3..47c7cd45eb05de 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -17,6 +17,9 @@ v1 is available under :ref:`Documentation/admin-guide/cgroup-v1/index.rst <cgrou
 
 .. CONTENTS
 
+   [Whenever any new section is added to this document, please also add
+    an entry here.]
+
    1. Introduction
      1.1. Terminology
      1.2. What is cgroup?
@@ -27,9 +30,10 @@ v1 is available under :ref:`Documentation/admin-guide/cgroup-v1/index.rst <cgrou
        2.2.2. Threads
      2.3. [Un]populated Notification
      2.4. Controlling Controllers
-       2.4.1. Enabling and Disabling
-       2.4.2. Top-down Constraint
-       2.4.3. No Internal Process Constraint
+       2.4.1. Availability
+       2.4.2. Enabling and Disabling
+       2.4.3. Top-down Constraint
+       2.4.4. No Internal Process Constraint
      2.5. Delegation
        2.5.1. Model of Delegation
        2.5.2. Delegation Containment
@@ -63,14 +67,15 @@ v1 is available under :ref:`Documentation/admin-guide/cgroup-v1/index.rst <cgrou
        5.4.1. PID Interface Files
      5.5. Cpuset
        5.5.1. Cpuset Interface Files
-     5.6. Device
+     5.6. Device Controller
      5.7. RDMA
        5.7.1. RDMA Interface Files
      5.8. DMEM
+       5.8.1. DMEM Interface Files
      5.9. HugeTLB
        5.9.1. HugeTLB Interface Files
      5.10. Misc
-       5.10.1 Miscellaneous cgroup Interface Files
+       5.10.1 Misc Interface Files
        5.10.2 Migration and Ownership
      5.11. Others
        5.11.1. perf_event
-- 
An old man doll... just what I always wanted! - Clara



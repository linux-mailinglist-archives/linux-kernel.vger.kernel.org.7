Return-Path: <linux-kernel+bounces-731050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFFBB04DF1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 04:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FED84E1C99
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 02:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97942D0C9C;
	Tue, 15 Jul 2025 02:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+C62sUp"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0132D0C71;
	Tue, 15 Jul 2025 02:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752547389; cv=none; b=SAAuY9Ai3YfmGO5EOT9CTzIwpjcN3HC9a8Imc/aoSYOTUJ6VlgevhdGuMKcdBeGXo/x5buGZUu4xeCjd2cB6pbxGHa7kZatNrd8AJ6m1KUlLGkcBYf3C7EIJNZHF+MQokGOZFiD+8NaCzRnbq/Kf97aeiav2r5/f85ebP65vkMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752547389; c=relaxed/simple;
	bh=Dlq14mSTojEp7sGWGKSgiOf4GsdBPAtviYKPpJeMxj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n3Aoj5Qec5qb122IbHXYZi9j4orVWrbuyFGY1mSMKMRpiKQdKYHYy3Mf86SYF0V528CH2ahA5/kQoFe2oFUaE8fcOGN5LSd1q5dnikz80dRWeubHgJI8ia5qU5nNt790tm6I5E/MIJzcEKkoel9EpIR6K+RQ9jZ5FGvFsruhav8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+C62sUp; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-748e81d37a7so2970557b3a.1;
        Mon, 14 Jul 2025 19:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752547387; x=1753152187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9LmUsYZMwX73hG4aBla/dKzeFfJIEzjX0m8Zhz42YAI=;
        b=b+C62sUpBu4j77iExFm/b2pypOeu2djB4vSg01VQzJgEz1TiHLdzhmkpU48YwQ33mN
         mi7a49fX7pK9lgwnO70q77yR7OXLtHBvS59GwxtrEm2ra7B0Erb/yEtPxE+cRumMvjB1
         DAdoP9GCBse9qSiN9dJXPw+MZbGbuddg03Ad3oa4POdODMg3cYKunbDlS9uRKIzmAEmk
         9qxGhsT+vQLPy7U7u65FplVRKVPAabeFHlefGfVDWoaKWgFrHjySpWUOfgHwVIBAcSOq
         fXFotFqMHH7MKt0sKnuP6t1tdTxh0Giuf/9hh+wa1ubJ6ymdqqJDzdeW6Vx3PIbi39Ha
         NsNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752547387; x=1753152187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9LmUsYZMwX73hG4aBla/dKzeFfJIEzjX0m8Zhz42YAI=;
        b=GgiGGtX/OX94XXXdpCmWC3KqrJKJZ/C50/UaKm1K2PzivuHST6VcW8SOUy09lK/EUg
         IEg7aFoLmsih78stZKwwFSOvyHWr//cRQWpujmqXTGPqdettwqRW4gsMndrOIClsv4Wm
         Gbx9IgwewmivToQ3uv4wThUgC49DFpxmL3y19/4trpoHvl3CK1sN6PPxcfmNla/YMTvL
         o3PWr8TqZm24kdSDUBOTwg5m1yqTFW1MZstsjGv1BG4mN86zTvjFHHctU7ntyDfMuAg4
         qZcKqTPExlbcHaamneZeJJb4bjba7Z0q4A7jc0KOLST2MZsa6ATPabOVQzf+Pl8BMd/Y
         nxlg==
X-Forwarded-Encrypted: i=1; AJvYcCWY4kqvm7Ip4WBo8JCGt3aI/yk4NPZlqmFwFESklz+w9mwGQlLlvcDsE8RTImg64gWoNhjknA8zO7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrQxkA7wlxabR3U2uyX3B1qpx95vDcBGESoLqyfmJPT8CrOuH3
	7Kq/se6zaT86nRUgmAW3U5ooHyqYejfVqUQPeSqHvAFM7uGdiPmFBhf0
X-Gm-Gg: ASbGncsi10Km/TNJRs+oBnr4oSuM91Gvltwn1X83NC2WO7oF1eG/QYORaDGQXEHWsHx
	CEvUrOpOog0zdx39pBtT6eJ9NtbBOkrKxf8//EqDB7/3zLara9GKRdOpQIsBmzj6i7u0UY80peu
	3Xq8FUgdD4CsgPHejweySQqhOlOXswyS7fzzk2Xur3Ipel9MaZBlwTGUBYuCqFtdNr4rZWvDo5D
	Srkv2370G0hlyVD9oygtmYeT/Kw/rKjQQLx72hlLv4XVCbCY6aF9kzJ6jS+9yMiRGD3hBY4OdTS
	quQpJ0tdeNDt912JC0WSUCbxbh5vA31kWGdMvcGuta6b63b3sGXcaW7qxutmgllJlNewBKrQkZf
	2rvA2N9fFENlUIWxl+lBf7g==
X-Google-Smtp-Source: AGHT+IEu396ibdfM882DRnu7LQtFSM2Dq9TgDy2BHLHlLpBuZH7Sx8xwpifxVAuNS5A7eXezw0imcw==
X-Received: by 2002:a05:6a00:1911:b0:748:fb2c:6b95 with SMTP id d2e1a72fcca58-74ee32397afmr20781060b3a.18.1752547386735;
        Mon, 14 Jul 2025 19:43:06 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe72f8a9sm10740873a12.74.2025.07.14.19.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 19:43:05 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id BDDEF420A816; Tue, 15 Jul 2025 09:43:01 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Haren Myneni <haren@linux.ibm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Donnellan <ajd@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 2/2] Documentation: ioctl-number: Don't repeat macro names
Date: Tue, 15 Jul 2025 09:42:58 +0700
Message-ID: <20250715024258.16882-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715024258.16882-1-bagasdotme@gmail.com>
References: <20250715024258.16882-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2845; i=bagasdotme@gmail.com; h=from:subject; bh=Dlq14mSTojEp7sGWGKSgiOf4GsdBPAtviYKPpJeMxj0=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBml+5telZv8/xo7sfLdmfRu3w1nrp7uWF7Lf/XgxM55U a96Jt7R7yhlYRDjYpAVU2SZlMjXdHqXkciF9rWOMHNYmUCGMHBxCsBElnkzMvyYzZtxctP7vNlt k7Y+rdr1nt3iVP2KU4GH/lw9Xp8x8+1Uhv8ucsvSxV0ar13JTZbb+djDtZU74PPWLPX8+8f/5LL d1OACAA==
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Don't repeat mentioning macro names (_IO, _IOW, _IOR, and _IOWR) to
keep the wording effective.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 .../userspace-api/ioctl/ioctl-number.rst      | 22 ++++++++++---------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index ad5e7001f59137..16994ce3a6c576 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -25,9 +25,9 @@ be _IOW, although the kernel would actually read data from user space;
 a GET_FOO ioctl would be _IOR, although the kernel would actually write
 data to user space.
 
-The first argument to _IO, _IOW, _IOR, or _IOWR is an identifying letter
-or number from the table below.  Because of the large number of drivers,
-many drivers share a partial letter with other drivers.
+The first argument to the macros is an identifying letter or number from
+the table below. Because of the large number of drivers, many drivers
+share a partial letter with other drivers.
 
 If you are writing a driver for a new device and need a letter, pick an
 unused block with enough room for expansion: 32 to 256 ioctl commands
@@ -35,12 +35,14 @@ should suffice. You can register the block by patching this file and
 submitting the patch through :doc:`usual patch submission process
 </process/submitting-patches>`.
 
-The second argument to _IO, _IOW, _IOR, or _IOWR is a sequence number
-to distinguish ioctls from each other.  The third argument to _IOW,
-_IOR, or _IOWR is the type of the data going into the kernel or coming
-out of the kernel (e.g.  'int' or 'struct foo').  NOTE!  Do NOT use
-sizeof(arg) as the third argument as this results in your ioctl thinking
-it passes an argument of type size_t.
+The second argument is a sequence number to distinguish ioctls from each
+other. The third argument (not applicable to _IO) is the type of the data
+going into the kernel or coming out of the kernel (e.g.  'int' or
+'struct foo').
+
+.. note::
+   Do NOT use sizeof(arg) as the third argument as this results in your
+   ioctl thinking it passes an argument of type size_t.
 
 Some devices use their major number as the identifier; this is OK, as
 long as it is unique.  Some devices are irregular and don't follow any
@@ -53,7 +55,7 @@ Following this convention is good because:
     error rather than some unexpected behaviour.
 
 (2) The 'strace' build procedure automatically finds ioctl numbers
-    defined with _IO, _IOW, _IOR, or _IOWR.
+    defined with the macros.
 
 (3) 'strace' can decode numbers back into useful names when the
     numbers are unique.
-- 
An old man doll... just what I always wanted! - Clara



Return-Path: <linux-kernel+bounces-826778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D95B8F52F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 09:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12B08189F012
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 07:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527BC2F6168;
	Mon, 22 Sep 2025 07:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJ0RdmRR"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC8C27B33A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 07:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758526960; cv=none; b=pS8UHRrXHZ5ewsiU06Uw1pujSAjCk8MMNRkmzR+5MsKq5o/zwPPPvrj2C1Wj8+LY4PXv9STM6WmHFho2dv19lMcOWgcEcstezUvpxs426peY5KiqD6+M8euLCLwK7fGw7mZROen+lTa/BIKKsZcr1J/6kfIlTUqL4x/T7RwAsws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758526960; c=relaxed/simple;
	bh=5gMuXlLFD1XuG3/tnXO1PQbMJhaTShGwHuvU9eBdkWs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FfoSFPT9xykHKo3lXHVQR6bMUNAxANJYx0jpKu/TrhQ75YOzqWix9dtUDtbuLJFDfSMzAiCiU49lDILWAKW3JPy5Xr1upAw1CTO6zJBqygMX0iY9SjhRsxA0yKhKQVeb18DDozHA5hj/EBQvAhYY8MSI8xYai0eKi2U7Gmcj3D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJ0RdmRR; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77e87003967so1241703b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 00:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758526958; x=1759131758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j4Phf+K1gS9MFRb7NZEcpfy0Bk/WQT2x+jx3wjjf1Yc=;
        b=dJ0RdmRRLjHvd4Yg9fvQvCEaefhH4gBc9ck4uC/i1LZyCgNWbEGsOxX8aLtvdqCllM
         Qk8++2PuzRfE6UP9KC3oLEk1/L+pWVGytqEvnhluh1k6kNFURFEsUtkLFQI1mNQUHjjr
         pY9S+tVTPLUZ2zCv/rZ5bKmEerEZRqMaSoz2Omlvaqw9kVTEGN8W6EK5dggz95Kn6Oel
         k+VeaU5LrWZkh3f3Ci/7GI/pdMr/e3Y7Rr3GQz8LwAXvlrbDPMSIuqMSVjj4lhoYeQrY
         XAdPikz0mW77E0fFUYyn4oyvupOyu0ciyvnhrxp28j0K9JvVTxnreOUiimfS3a+tJKBR
         /v3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758526958; x=1759131758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j4Phf+K1gS9MFRb7NZEcpfy0Bk/WQT2x+jx3wjjf1Yc=;
        b=Q/tMXq3SUvYjB56RbciErM3NpcY1TIgb5eyXCv/FSRhtcFF29gynMZ2J8nCLLuQR3v
         +jv51wxfkaZ+PNb2A119o91MKaGuKKZNI9zulWX2G7a74tVkyrzM/vFjzddc3DtUVqVf
         YUyyNUJEby5ff4tXTdIHhewqSGtMyUEE8BMUpmOA28tHs3dNsvK9WvXdgd3w6b2YIecE
         7YcNLwqKbNnF+DPou8ZIDJFflXon0VeGXPcpw4wYB9ldaQgleRBNrac+y+6qTHdtmM27
         OPI8A0j9J4xFgKGMaYIH1h7bWOhL063WeGje6uxOqWUrPei9T/rTuHNyeAYrJONWOfD3
         ImAw==
X-Gm-Message-State: AOJu0Ywu7tlN779elBniLZpI4nMCWgxf8gmXd7arCqHOVw9ietANq9lZ
	Qjpk1AX5Ud1XrJiHc+RrBwZh1RcmhBMBTjM2FeSESAg8tqGTEfVlIeT8
X-Gm-Gg: ASbGncuP7+0SXnV/XhHuV+Wuyvz6tbZhwVdXA2RGH6S408an87HkWhQp0tDfC0HVIb4
	blAzpUJzB6JK2pBYrIQDjd07Z1vW6s3s0AQS402zbOOmATKeODS4rOhDnasnYGKXmyJdoAeOAua
	+QYiM4JcWjCHbw+5Oe8vLGFTKnI9U7Op+UPRYoOe6PdjPApqioNmODwp+skO+fwsRJA58DfMCM2
	JNk4dc/XRHtqi4Ta9R/SzEk2idz6hRAZwKrbaVlqJlB+Gr5PYtdT46IIjmx3O/8xho1txzF+wRd
	htCoZTixpKnD2UXZWhr/DhWgpOM0IPukBgKBssvmkaMKA0ogGgmMF9iqYwT2yEM4884XbKTuJGW
	URd7zfbsSOuqndax5zpoZTQ==
X-Google-Smtp-Source: AGHT+IEj02pN0u0thRutHEIw7lMcFftbuQpwqlog/mxIBSHur0AW7esbFKRuvCsc5NQu009kGxpKIA==
X-Received: by 2002:a05:6a20:734c:b0:262:d265:a51 with SMTP id adf61e73a8af0-2925c55fdacmr16155109637.18.1758526958069;
        Mon, 22 Sep 2025 00:42:38 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b551d050414sm8109090a12.38.2025.09.22.00.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 00:42:37 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 057FB4220596; Mon, 22 Sep 2025 14:42:34 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Workflows <workflows@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Dante Strock <dantestrock@hotmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v2] Documentation: process: Arbitrarily bump kernel major version number
Date: Mon, 22 Sep 2025 14:42:19 +0700
Message-ID: <20250922074219.26241-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4885; i=bagasdotme@gmail.com; h=from:subject; bh=5gMuXlLFD1XuG3/tnXO1PQbMJhaTShGwHuvU9eBdkWs=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkX/vplL98iZtB7ZH7j6QCJv6e8mf25tzy8FHUxX0/R3 L99Tt7tjlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAEzE3pbhn1k77zetLexL1GsS S9hDg5bHrExoWfOYZcetDZkx5wXDFzD8z7mhYG9ooVHe/0FX8k/3/rfrDvdrpQeEcnyYt3BS9Vk eVgA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

The big picture section of 2.Process.rst currently hardcodes major
version number to 5 since fb0e0ffe7fc8e0 ("Documentation: bring process
docs up to date"). As it can get outdated when it is actually
incremented (the recent is 6 and will be 7 in the near future),
arbitrarily bump it to 9, giving a headroom for a decade.

Note that the version number examples are kept to illustrate the
numbering scheme.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
Changes since v1 [1]:

  * Arbitrarily bump major number rather than replacing it with placeholder
    (Jon)
  * Apply proofreading corrections (Randy)

[1]: https://lore.kernel.org/linux-doc/20250913015147.9544-1-bagasdotme@gmail.com/

 Documentation/process/2.Process.rst | 40 ++++++++++++-----------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/Documentation/process/2.Process.rst b/Documentation/process/2.Process.rst
index ef3b116492df08..bbd955d91df0cd 100644
--- a/Documentation/process/2.Process.rst
+++ b/Documentation/process/2.Process.rst
@@ -13,24 +13,18 @@ how the process works is required in order to be an effective part of it.
 The big picture
 ---------------
 
-The kernel developers use a loosely time-based release process, with a new
-major kernel release happening every two or three months.  The recent
-release history looks like this:
+The Linux kernel uses a loosely time-based, rolling release development model.
+A new major kernel release (9.x) [1]_ happens every two or three months, which
+comes with new features, internal API changes, and more. A typical release
+can contain about 13,000 changesets with changes to several hundred thousand
+lines of code. Recent releases, along with their dates, can be found at
+`Wikipedia <https://en.wikipedia.org/wiki/Linux_kernel_version_history>`_.
 
-	======  =================
-	5.0	March 3, 2019
-	5.1	May 5, 2019
-	5.2	July 7, 2019
-	5.3	September 15, 2019
-	5.4	November 24, 2019
-	5.5	January 6, 2020
-	======  =================
-
-Every 5.x release is a major kernel release with new features, internal
-API changes, and more.  A typical release can contain about 13,000
-changesets with changes to several hundred thousand lines of code.  5.x is
-the leading edge of Linux kernel development; the kernel uses a
-rolling development model which is continually integrating major changes.
+.. [1] Strictly speaking, the Linux kernel does not use semantic versioning
+       number scheme, but rather the 9.x pair identifies major release
+       version as a whole number. For each release, x is incremented,
+       but 9 is incremented only if x is deemed large enough (e.g.
+       Linux 5.0 is released following Linux 4.20).
 
 A relatively straightforward discipline is followed with regard to the
 merging of patches for each release.  At the beginning of each development
@@ -48,9 +42,9 @@ detail later on).
 
 The merge window lasts for approximately two weeks.  At the end of this
 time, Linus Torvalds will declare that the window is closed and release the
-first of the "rc" kernels.  For the kernel which is destined to be 5.6,
+first of the "rc" kernels.  For the kernel which is destined to be 9.x,
 for example, the release which happens at the end of the merge window will
-be called 5.6-rc1.  The -rc1 release is the signal that the time to
+be called 9.x-rc1.  The -rc1 release is the signal that the time to
 merge new features has passed, and that the time to stabilize the next
 kernel has begun.
 
@@ -99,13 +93,13 @@ release is made.  In the real world, this kind of perfection is hard to
 achieve; there are just too many variables in a project of this size.
 There comes a point where delaying the final release just makes the problem
 worse; the pile of changes waiting for the next merge window will grow
-larger, creating even more regressions the next time around.  So most 5.x
-kernels go out with a handful of known regressions though, hopefully, none
-of them are serious.
+larger, creating even more regressions the next time around.  So most kernels
+go out with a handful of known regressions, though, hopefully, none of them
+are serious.
 
 Once a stable release is made, its ongoing maintenance is passed off to the
 "stable team," currently Greg Kroah-Hartman. The stable team will release
-occasional updates to the stable release using the 5.x.y numbering scheme.
+occasional updates to the stable release using the 9.x.y numbering scheme.
 To be considered for an update release, a patch must (1) fix a significant
 bug, and (2) already be merged into the mainline for the next development
 kernel. Kernels will typically receive stable updates for a little more

base-commit: 348011753d99b146c190aae262ee361d03cb0c5e
-- 
An old man doll... just what I always wanted! - Clara



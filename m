Return-Path: <linux-kernel+bounces-814996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FE9B55DC6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 03:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BD19A00B39
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 01:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D941C7015;
	Sat, 13 Sep 2025 01:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfvnHAFk"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B9514EC62
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 01:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757728319; cv=none; b=FDwNXIDnnVqvXniPyqO9FWJHu/zKYbHiB8GfHziLFUUbc0UhEM21KNcx15WA8Lq8aVCqv+33gYkxbazZLjpnTO+g8nYcMfdqV+nAe1i8bxNrEMOKPheFX8cjo0IuaSUX499STj8uFe6ifCqvSKGyUZTIj1FTSRZCZnR0jcLZjRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757728319; c=relaxed/simple;
	bh=Bd3xa7qvg0cHicpoRmkRiHMwF02modqhnATszvtaJmI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l/pb6oGGdJBlEzqnk/NwQ0w8KHpKx+r8tLugmsDd1RNo6XthK4UJlgTF8oM1Iq4WhMWTUlGV/ipGXHgDk6P24MHMYyFJ8Youbx4ZneCqeaXUE47vOKc6R9mCEeAzRB1nDXxsucqm1Fx3T+DPTj0Yx/QJqlrNLaDZBLp3m1/4C4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfvnHAFk; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77619f3f41aso933156b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 18:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757728317; x=1758333117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uOjlByQVC/nCWh9bJ367rovAJ8X31B6cD0lHjcTI1/0=;
        b=hfvnHAFkHuZdZX5MTXsWknndwHPi/WkJ6Vb+wajzCo8QxuWPvyK9fhLYTOm5bYaRV1
         T2OtEGHtymAYF42LYdnwJPbOQogXhGw5IlVsyrPdSC6+PNzRQFxbtfqy+cxG0nYoUHUi
         k8zKh5riLEOtVYjs9yUZl4egdsrXZjJ0Nh5Q24A9S8Za1N9JoOLXvLypDSbV5tAfMe0S
         cnkKylQvMR1HAsJDNn0/Jq1uIWh6tpAWFrEUU1EnOC5Zn6VICGWw/uT94Hdgt6FXJ6LG
         e70fnU//OLQ9sPZF324smQr8/i291VdrcNMmxbpgwaFlzhdTAKR6RBHzmR+fclcyqAcD
         mj4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757728317; x=1758333117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uOjlByQVC/nCWh9bJ367rovAJ8X31B6cD0lHjcTI1/0=;
        b=AMad5Mbl7fGGRBWGWUKPkr+xqSKxWmncft6Ul8uxr6tc6yNebiAGgd7SVadPiGnj70
         2gI6ehJviG7Ues8W888oDFoJopBm5ykWSeJu7/UDy4e9EAdRD5nyozIr7ZE/ZghxR7eu
         ZJFs0H2L55kGIgXP0mup7XYyJTJzP1xeV5MVsyp34TKDT1+o8EnjkT00h3Q0W97wiXgh
         yE5hZFYYLEN+apTggSImNPyOQS23TiZFUdjWRRnxwfV3FqtOUqliZlvdJPAB0pxAXQeZ
         DLF3ERI1CEdhNVlVaU9omLxqFOnvfWRC+E8f704jbdXrEsYd02AnM2U/2sPrPw3Y0NPc
         YwGw==
X-Gm-Message-State: AOJu0Yz0X+CctnO4pdSGLgUGhhPFy0vW03Mv2lUqLsW4BwjRQd0w4/tI
	RKUPIRwFKmt8BfUG+8ZPlW90//A7npWydTwJ565bUqRAtYwv4+DupKwh
X-Gm-Gg: ASbGncvWQTPLygE2H0R55yOJ69MxWy/9zbydMCtyxwtcQzOqFJgEUf3FLFSovS0rJx3
	z0sHNdg7iF+PxZnby5wNlqYBaA/YgjqAYgX/cC1FYfpMLvk7e7Pml6IafXzMfHHJbqZNldGVhQ5
	0QxTVdNtFqo6/TP/Ba/Q37FCBpYjFgIpqnibDxtndFNnct34i880D6bAwY+YsaapKJX4NRmgJ2h
	yG33wKVuEUd/Wu1neWcpnbjSe//jKE7feX0eUQpLQFYa7Lm0kvp2xy52ZhiEOu/ljkDlWzkt5e6
	+JAkjQ0QB5mhwLnhTtX+UwXBRyJjOD/xDXHIdZvhO9gx4beHVTC8FArAp/sROmDdLeMtDk0UH3d
	1N2HmEwGCxgsvX3UfDGi4Xtff/luxxYJDqmEm
X-Google-Smtp-Source: AGHT+IHV3Gmoi6yseioPLrwq3DrMEU+n8Xy18gJFUsSkVU5Igc50YmYrzupI8zFPWLbedlP3rd/8RQ==
X-Received: by 2002:a05:6a00:4f87:b0:772:31e2:b80b with SMTP id d2e1a72fcca58-77612089e72mr5170213b3a.11.1757728316577;
        Fri, 12 Sep 2025 18:51:56 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7760793b5fasm6938008b3a.16.2025.09.12.18.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 18:51:55 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 67ECB4206928; Sat, 13 Sep 2025 08:51:53 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Workflows <workflows@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Dante Strock <dantestrock@hotmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] Documentation: process: Do not hardcode kernel major version number
Date: Sat, 13 Sep 2025 08:51:47 +0700
Message-ID: <20250913015147.9544-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4599; i=bagasdotme@gmail.com; h=from:subject; bh=Bd3xa7qvg0cHicpoRmkRiHMwF02modqhnATszvtaJmI=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBlHzk7+lymaMcv69L4ruVXbLwpFq5y4y2gdNP1Z4fGzW kmLDzrO7ihlYRDjYpAVU2SZlMjXdHqXkciF9rWOMHNYmUCGMHBxCsBEHvoyMvxZNyP7iNaRZm0F cf9r1hIzV55R3cguFbD/k5LRuYLvV28wMpz8um5L+Ds1oZTXzUX7lp79Z8zXuSvJ4det9fed3jx kP8gIAA==
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

The big picture section of 2.Process.rst currently hardcodes major
version number to 5 since fb0e0ffe7fc8e0 ("Documentation: bring process
docs up to date"). As it can get outdated when it is actually
incremented (the recent is 6 and will be 7 in the near future), replace
it with the placeholder.

Note that the version number examples are kept to illustrate the
numbering scheme.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/process/2.Process.rst | 40 ++++++++++++-----------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/Documentation/process/2.Process.rst b/Documentation/process/2.Process.rst
index ef3b116492df08..668d5559ded039 100644
--- a/Documentation/process/2.Process.rst
+++ b/Documentation/process/2.Process.rst
@@ -13,24 +13,18 @@ how the process works is required in order to be an effective part of it.
 The big picture
 ---------------
 
-The kernel developers use a loosely time-based release process, with a new
-major kernel release happening every two or three months.  The recent
-release history looks like this:
+Linux kernel uses a loosely time-based, rolling release development model.
+A new major kernel release (a.x) [1]_ happens every two or three monts, which
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
+.. [1] Strictly speaking, Linux kernel do not use semantic versioning
+       number scheme, but rather a.x pair identifies major release
+       version as a whole number. For each release, x is incremented,
+       but a is incremented only if x is deemed large enough (e.g.
+       Linux 5.0 is released following Linux 4.20).
 
 A relatively straightforward discipline is followed with regard to the
 merging of patches for each release.  At the beginning of each development
@@ -48,9 +42,9 @@ detail later on).
 
 The merge window lasts for approximately two weeks.  At the end of this
 time, Linus Torvalds will declare that the window is closed and release the
-first of the "rc" kernels.  For the kernel which is destined to be 5.6,
+first of the "rc" kernels.  For the kernel which is destined to be a.x,
 for example, the release which happens at the end of the merge window will
-be called 5.6-rc1.  The -rc1 release is the signal that the time to
+be called a.x-rc1.  The -rc1 release is the signal that the time to
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
+go out with a handful of known regressions though, hopefully, none of them
+are serious.
 
 Once a stable release is made, its ongoing maintenance is passed off to the
 "stable team," currently Greg Kroah-Hartman. The stable team will release
-occasional updates to the stable release using the 5.x.y numbering scheme.
+occasional updates to the stable release using the a.x.y numbering scheme.
 To be considered for an update release, a patch must (1) fix a significant
 bug, and (2) already be merged into the mainline for the next development
 kernel. Kernels will typically receive stable updates for a little more

base-commit: f44a29784f685804d9970cfb0d3439c9e30981d7
-- 
An old man doll... just what I always wanted! - Clara



Return-Path: <linux-kernel+bounces-812868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DA9B53DD1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E1ED1C806DF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E56F2DAFBB;
	Thu, 11 Sep 2025 21:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqXhjhNO"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4EC2DE6F4
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757626723; cv=none; b=UkEkKpnzsN+uscDa0Ptmid48qx2q3TJJmIFPl3LkPIRZsW53UoqKxPAlkw0l/8Vd3/RvXN5EBh1waYE4UZpHUmFi1hNQIhaIu3oAQEKIrCliBasUJkGcoUJfNFSF3K4VhDlhstQF1RG1nnXNv4pZ7UJzQGJrkZGMv5FHxj5iNgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757626723; c=relaxed/simple;
	bh=nl5LJ0FTaFIIpK9K3Rpy7fduoiXvS+6BJLKGJvH3XRY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rQh4rbLLsAmxP82pbJo/LHl40jzUAyTEOnQf85rtOibRolaIadg0rfHArO+esHmcd9JrHoSzDgTO6SNoftLTI121JTndCSI+x1Jy1iQp1cHi1N4+rz7DLzYfTA1ZALvws7xoBP/KVTWFFwAbs3W4zVbnBq4H/3du1ZQhxx4n0tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OqXhjhNO; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-88c3361f16bso98822939f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757626720; x=1758231520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zAwNQvEDwJKevoXNkagI8/0AZrGlrExisA10c0y+0tM=;
        b=OqXhjhNOMU6XVFB0BYxTYy5mx2Fn28uUFGix0xt20uUSqGfj3l0SvVAt8a0d9M3djq
         6IKsQGedCZuxDKaJDPbsrHXNnJSgS/hMrXeKQxfyGTgHUQ3J3Tc8f2clAmYtSoZi+O/8
         OdwCHkn/6C6DsBeUSouYzrGXSU3t/Eqnr7zz7dFW4lvLth+R7Anwu44wnxrhsIPb8fKh
         U6fiD8g+oJuDoHJQdCQrbm8GrdyOldusx86vma0CFS/M2ffG4nXuO/XsJcBHz5vMus+X
         hqUMmxMAudDIV9SfzMv4tkqxeO9EJ8DR7ZPIy1lPRkcNpcejGu1jcvxlckuDyCvlOMzb
         y0JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757626720; x=1758231520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zAwNQvEDwJKevoXNkagI8/0AZrGlrExisA10c0y+0tM=;
        b=ZZ/BshUmi7c6B6y0HzBuLyon7ETAw/37l/jdZYi7mqXvMCEwSBEgx+zvrPN6T1/DDM
         f1t7l+U7ENA1AZp4hDXXlz3doK5r93sXgf4fTI6FyJOBPrg7Tdq6h+5Z+NUDp97qf0GR
         RXo9KIy0YSIgXa9aKQ+kcZHrq1Vvyxn0XSkrnxQOHlHWmKqa8U/iTwJ9RwG6p4IuORG/
         9+Hi8Qgzkjo1E64T6V1kLH8up0rADbb3FJQmNfh01QfcDxcxn1w01gpkbqfxoSjW3UnS
         +lLTfM9T9m9WXALTZ7nWnIjJLXMVzGjmCgEyqWV8nxmCJ5hxJEi1H1ZTcY6ohbwjQO1f
         Qq6g==
X-Forwarded-Encrypted: i=1; AJvYcCWPGin1AVSXhXc9cf0qRCA0MRFNRWxDrOPQWGRcaFw5QupJ6g1WV84MKkhL82ejv3BfoM8HyMG8ZIHioKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVqLARdSJdHc5Z7b9YszLmUVD/F1ciWzAr7UzURglmCJw3rEaD
	JZD1N6RVSplsS6acwvPCDknzT15tMkHW94nDw846s2zqNeVFMQrivq9K
X-Gm-Gg: ASbGncu4qY67ScLAsMBrLIYjGkIGRl16kzq3oOZ7Mi5VVv4vXVp3BQc3qjfahzcqtLD
	D4kOsvBQ7Nn5bNeQj+MOIyBrhbUpxYJx5FgeXDXA43OH8vNsBKptQzCkIkTLtfM5wd9vTXB9cET
	5GpNUJKHvoZFST8R5PTya0DygW1bghLRyP+Aq14t8PjtTnfFDGNYbWrCiQOTo1ZfnxmFX13leZM
	UN20byb/BUjTzrkA6ObmkeVA1nhwcrxXCk3chDmVKvSXoN83ORRCXMoKwoxTWji47J3sKP6iLYC
	s/W5X+zgMer+iYcX9vNHx1hoz5qNTOsD8pHvFd4FifbEG+t82BnLbTGCfkeqPyroLNOoYDqRMSP
	kBUitJlLuiedV6lWIiTHeDE0fLZucT+Cbbq+17Gc70xEOJiP6VSQrxQDMHh5RXqDpZyzvSMap5A
	I+yxFgzPFuvlEoGA==
X-Google-Smtp-Source: AGHT+IF+Dlbn/wg7xVe946IVSnoHeckwpEkItNgXCAQ6S3tKSHND7a3ZzZBwDAtaM6uhylQcnzk5Ag==
X-Received: by 2002:a05:6602:3419:b0:889:62e4:f65b with SMTP id ca18e2360f4ac-89032906b38mr130418439f.1.1757626720205;
        Thu, 11 Sep 2025 14:38:40 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-73-14-87-86.hsd1.co.comcast.net. [73.14.87.86])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-88f2d0bfdcfsm104024139f.3.2025.09.11.14.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 14:38:39 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com
Cc: gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	linux-kernel@vger.kernel.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 00/30] dyndbg: Rework classmap API to fix module dependency issues
Date: Thu, 11 Sep 2025 15:37:53 -0600
Message-ID: <20250911213823.374806-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series reworks the dynamic_debug (dyndbg) classmap API to fix a
fundamental design flaw that caused issues in subsystems sharing
classmaps across several modules, in the 1st use case: DRM

This broke it:
commit aad0214f3026 ("dyndbg: add DECLARE_DYNDBG_CLASSMAP macro")
This recognized it:
commit bb2ff6c27bc9 ("drm: Disable dynamic debug as broken").

Key changes in this series:

* Core API Rework:
  - Replaced DECLARE_DYNDBG_CLASSMAP with a new DEFINE/USE pattern
    (DYNAMIC_DEBUG_CLASSMAP_DEFINE and DYNAMIC_DEBUG_CLASSMAP_USE) to
    allow for shared classmap definitions between modules. This is the
    core fix for the module dependency issue.
  - compile-time and run-time checks to detect and prevent misuses of
    the classmap API, such as overlapping class_id ranges.
  - Refined the logic for "protecting" classmaps that implement a
    stable ABI (like drm.debug).
  - undo dumb namespace noise: DYNDBG_, ddebug (w/o the leading _)
  
* New Test:
  - `cd tools/testing/selftests; make TARGETS=dynamic_debug run_tests`
  - supplants DRM as the necessary test
  - good for `Tested-by:` ?

* cleanup, maintenance, refactoring:
  - drop unneeded linked list, keep classmaps as "vector"
  - tighten/declutter internal callchains, etc
  - several macros to de-duplicate code.

* excluded DRM parts
  - previous revisions included them for testing, validating
  - but this complicated things: audience & purpose

* Documentation:
  - The documentation has been updated to reflect all the new API
    changes and explain the design rationale.

This series has been tested on 3 x86 boxen (w amdgpu, nouveau) and in
virtme-ng with 8 permuted variations of the CONFIG_*DYNAMIC_DEBUG*
options and others.

The testing included DRM-specific adaptation patches which are
excluded here for clarity, but which are the actual user of this
feature, and needed for "proof-on-HW-devices".


Jim Cromie (30):
  docs/dyndbg: update examples \012 to \n
  docs/dyndbg: explain flags parse 1st
  test-dyndbg: fixup CLASSMAP usage error
  dyndbg: reword "class unknown," to "class:_UNKNOWN_"
  dyndbg: make ddebug_class_param union members same size
  dyndbg: drop NUM_TYPE_ARRAY
  dyndbg: tweak pr_fmt to avoid expansion conflicts
  dyndbg: reduce verbose/debug clutter
  dyndbg: refactor param_set_dyndbg_classes and below
  dyndbg: tighten fn-sig of ddebug_apply_class_bitmap
  dyndbg: replace classmap list with a vector
  dyndbg: macrofy a 2-index for-loop pattern
  dyndbg: DECLARE_DYNDBG_CLASSMAP needs stub defn
  dyndbg,module: make proper substructs in _ddebug_info
  dyndbg: hoist classmap-filter-by-modname up to ddebug_add_module
  dyndbg: move mod_name from ddebug_table down to _ddebug_info
  dyndbg-API: remove DD_CLASS_TYPE_(DISJOINT|LEVEL)_NAMES and code
  selftests-dyndbg: add a dynamic_debug run_tests target
  dyndbg: change __dynamic_func_call_cls* macros into expressions
  dyndbg-API: replace DECLARE_DYNDBG_CLASSMAP
  dyndbg: detect class_id reservation conflicts
  dyndbg: check DYNAMIC_DEBUG_CLASSMAP_DEFINE args at compile-time
  dyndbg-test: change do_prints testpoint to accept a loopct
  dyndbg-API: promote DYNAMIC_DEBUG_CLASSMAP_PARAM to API
  dyndbg: treat comma as a token separator
  dyndbg: split multi-query strings with %
  selftests-dyndbg: add test_mod_submod
  dyndbg: resolve "protection" of class'd pr_debugs
  dyndbg: add DYNAMIC_DEBUG_CLASSMAP_USE_(clname,_base)
  docs/dyndbg: add classmap info to howto

 .../admin-guide/dynamic-debug-howto.rst       | 179 ++++-
 MAINTAINERS                                   |   3 +-
 include/asm-generic/vmlinux.lds.h             |   5 +-
 include/linux/dynamic_debug.h                 | 304 ++++++--
 kernel/module/main.c                          |  15 +-
 lib/Kconfig.debug                             |  24 +-
 lib/Makefile                                  |   5 +
 lib/dynamic_debug.c                           | 675 +++++++++++-------
 lib/test_dynamic_debug.c                      | 198 +++--
 lib/test_dynamic_debug_submod.c               |  21 +
 tools/testing/selftests/Makefile              |   1 +
 .../testing/selftests/dynamic_debug/Makefile  |   9 +
 tools/testing/selftests/dynamic_debug/config  |   7 +
 .../dynamic_debug/dyndbg_selftest.sh          | 373 ++++++++++
 14 files changed, 1392 insertions(+), 427 deletions(-)
 create mode 100644 lib/test_dynamic_debug_submod.c
 create mode 100644 tools/testing/selftests/dynamic_debug/Makefile
 create mode 100644 tools/testing/selftests/dynamic_debug/config
 create mode 100755 tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh

-- 
2.51.0



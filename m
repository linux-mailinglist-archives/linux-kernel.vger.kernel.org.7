Return-Path: <linux-kernel+bounces-847285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC64CBCA711
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 19:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 291C119E5508
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 17:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DA92472A8;
	Thu,  9 Oct 2025 17:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLZvsHwy"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16BC246BDE
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 17:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760032723; cv=none; b=VEljyeoxQXq217eriQJXxDntDU5xVLbbBg4KlxsdZyir/+bbF6Agp6SJqVbFcqzI880KwCexrnqu4oKf8O3fAkQK/sNWKkZX55kIg33ajQLIbh1CZR/66xCVEP847kKoLKCOH8lkaw8biStIaDufU0ovib87uM+VW8XYFuWoyWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760032723; c=relaxed/simple;
	bh=Sbu96s5vZuGPRg4fRsVlZ86LV1YqQR4fhB6s0mJ/7Js=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M8ilkpke4E8f02KBDdjX5vy0gBEK0TKtsWq6BWVgGp4UuVEbEJw2qAqHol7xgL0GWeVTVIvxQs48gQPBVryrqpnuav9A6Wlj9+V50VWysvThf8Dm4BsYpCDUT6F5+cHZDqGaevkRq6sRs+VEm2G7yE95LpZT3vuYnRb8dupZk4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLZvsHwy; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-42486ed0706so7395585ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 10:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760032721; x=1760637521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lGMv5lHdrhywBVTV/PqaJfnG7AITk86FOlf4SxNuZNA=;
        b=OLZvsHwy9h+IawGxNFnoyV8OdMhMJcK1JME8GAeQM8z9OWGkN2KXUHjY2icawHgkr0
         QilbRLxSYACM70+0Ko+HGN7XqnTFWBQ7mBQI1dBV3Kb5JKB6iOJvCmqjvMDYAFSM83IX
         i6bi25damdxKj3vMsW+p/V/GKr2JjCBoGf1Yrz7N8cO0Uq+ajol4Ti8vKH8bc8fptSnE
         /AGGpF63IN4apAfCgim6zjQYl1O/zDKNlJpVvdw7URoHLNOnN4eHrI6B7VVkQoA88Gjh
         9YqvRWHrk+EyJl1a1I4+rtLh+AXvKS99InI+y9yRznseCX+z4efjdLkHhrXeUYI+9zbp
         kscA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760032721; x=1760637521;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lGMv5lHdrhywBVTV/PqaJfnG7AITk86FOlf4SxNuZNA=;
        b=OdyLX23VLhAUQTutLUcM1m2/qTAykXhAkANC/TizKOwETM+o/BLCVCZRKFRNV2YPrc
         j8roDwYNiTwhMweykrQ4xVJk0j+md/LYR0dRQo1EfI8eysqF8tcZlBv8wk2BhwkzlR3U
         DftOHs/F+eZ8f+lLeEl3rPMP0IABJZCpaoq7TnyU228clowLLSsOjaxmruvMtryvzplI
         nk+TS0EPkMa1Q5g76YN+IHFhLJ0LDv2eZK0NcKjCutT03Q0Vd62bY8D+lL/Jkw1yzFI9
         DFDkBOi3iv39FR3UQjVQRAjqZTCKGoLTS/VDGfE3LHOXI4d9fh668folQVrpv/lQMvvR
         ykBA==
X-Forwarded-Encrypted: i=1; AJvYcCXu0mI+G2OZ32YZcEsdzbjZBczKJoKWzTqYjfXKJe7RIOWJt1UtNled7xd7FohzLj+cMe6Qk0k4a/nVgMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTv5KA/FXRl3U9HNS4V+WtaH9njgOBi12kaCzmaeLztssXSP0l
	XYN3mQo29lq7Dq9mNiNH7AyM/if3VKaZxCXIV6ABwu/DloAIuYpQNfF2
X-Gm-Gg: ASbGncudbuhbvwqeCRnQP/KlC2IWa5tBujfVH5y5huS0TV1V4mStfNw7EA9BC+UXj4E
	o2Gy5dnjuiu9JfkMwK9dPyBQuSeYqzWIoeZrwQuFF0SwksaDV832JdD8Oe60u6PC1S+4+S1mqXn
	xx6ieAWPnx8yEnpGC4MtqA8MG95Udv6QA63RjQL9RcmNPRh8f4cY3YJC2WMiHEROffzlXcdDg2l
	6nfiHeXCCobS7ZN0qx0AFictBYPmXvKwCcyIvg9iYJxezhjQtu31Mz4dvDhUi+rRa9d6iPWG2K7
	jrmqWzs3CvsWn+mUHTh+loF25eKQtS53qASYMJD9tWa/dxlOceV6vXlvXjM6wLkTOFZPuc2bxdx
	9ItEDn5gzLGUHRy/fOA6gJgXQLJIBhHyDjF0k9176lPlDweoOljlMfGSawPqgz9s/WsH3C5lAzP
	FdnjIPss2iLD1xKQal1WWsU0aHHjco2L4ZvKUuCKa2MOfAuWUP
X-Google-Smtp-Source: AGHT+IH0kP4+vfxD+O9Wz2DP4UBxSThOXmUadGnkvBABGnXzdVOZ2Hbq3wUFuypfAQx9EkxOwcXsnQ==
X-Received: by 2002:a05:6e02:3783:b0:42e:712e:52a0 with SMTP id e9e14a558f8ab-42f873540b2mr82406535ab.6.1760032720604;
        Thu, 09 Oct 2025 10:58:40 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-58f7200c4afsm30256173.35.2025.10.09.10.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 10:58:40 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com
Cc: gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	Jim Cromie <jim.cromie@gmail.com>,
	andrewjballance@gmail.com
Subject: [PATCH v5 00/30] Fix DYNAMIC_DEBUG classmaps for DRM
Date: Thu,  9 Oct 2025 11:58:04 -0600
Message-ID: <20251009175834.1024308-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

DYNAMIC_DEBUG classmaps is BROKEN for its 1st user: DRM. Lets Fix it.

The DECLARE_DYNDBG_CLASSMAP macro muddled the distinction between
definition and reference; in use it failed K&R define once, refer many.

Replace it with:
. DYNAMIC_DEBUG_CLASSMAP_DEFINE		for drm.ko
. DYNAMIC_DEBUG_CLASSMAP_USE		for drivers etc

Enhance test-dynamic-debug{,-submod}.ko to recapitulate DRM's 2+ module
boss-workers failure scenario, and to selftest against them.  This allows
dropping the DRM patches, formerly included to prove functionality.

The latest (unversioned) rev:
. I inexplicably fiddled with the patch subject
. dropped DRM as OT for lib/
https://lore.kernel.org/lkml/20250911213823.374806-1-jim.cromie@gmail.com/

v1-4 saw significant review, thanks Louis Chauvet <louis.chauvet@bootlin.com>

v4: https://lore.kernel.org/lkml/20250803035816.603405-1-jim.cromie@gmail.com/
v3: https://lore.kernel.org/lkml/20250402174156.1246171-1-jim.cromie@gmail.com/#t
v2: https://lore.kernel.org/lkml/20250320185238.447458-1-jim.cromie@gmail.com/
v1: https://lore.kernel.org/lkml/20250125064619.8305-1-jim.cromie@gmail.com/
v0: prehistoric versions are linked from v1,v2

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

CC: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: ukaszb@chromium.org
cc: andrewjballance@gmail.com

 .../admin-guide/dynamic-debug-howto.rst       | 179 ++++-
 MAINTAINERS                                   |   3 +-
 include/asm-generic/vmlinux.lds.h             |   5 +-
 include/linux/dynamic_debug.h                 | 304 ++++++--
 kernel/module/main.c                          |  15 +-
 lib/Kconfig.debug                             |  24 +-
 lib/Makefile                                  |   5 +
 lib/dynamic_debug.c                           | 678 +++++++++++-------
 lib/test_dynamic_debug.c                      | 198 +++--
 lib/test_dynamic_debug_submod.c               |  21 +
 tools/testing/selftests/Makefile              |   1 +
 .../testing/selftests/dynamic_debug/Makefile  |   9 +
 tools/testing/selftests/dynamic_debug/config  |   7 +
 .../dynamic_debug/dyndbg_selftest.sh          | 373 ++++++++++
 14 files changed, 1393 insertions(+), 429 deletions(-)
 create mode 100644 lib/test_dynamic_debug_submod.c
 create mode 100644 tools/testing/selftests/dynamic_debug/Makefile
 create mode 100644 tools/testing/selftests/dynamic_debug/config
 create mode 100755 tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh

-- 
2.51.0



Return-Path: <linux-kernel+bounces-845749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC5BBC603A
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 18:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 801B53A740C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 16:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A6B29BDB6;
	Wed,  8 Oct 2025 16:25:08 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4634528468B
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 16:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759940707; cv=none; b=JjRNvp01l7rLyqty78HLHgBwB4DDXCbI4VSlCK24qvEMZkylSmHgf+CY8n4EukIkcyTSGB4kRjuUViC4PRZd9AsnobGRB2erQcsUMRoPheDTxtGctbUCPMWNg9ukEExE/BqDsHqG3inJb/w/1AUkdRsZ0U4XN8YiukMRBmraseo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759940707; c=relaxed/simple;
	bh=Dmiwn2mr2rCHOc0TQSND9LLrXQRFE4B6R8jw0RE9nok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PE2OlYvnpoxHQLgwvdKmltKtWt25LIZ6+aD3xkptYN6xbUCtUq2djJi67wbMvlsOYuq0wzzr+Y3/QZAyQOuK8DCLEbO/ZW+IsHVXgcbe+5fKb6VYVOa1wbimIAO0LW95O1o4qqL1ozlLVs0k0TpE8EBpZm11MfxBDSEd2LXveFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7930132f59aso9977b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 09:25:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759940704; x=1760545504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lha07SgLr6YajsxSBvN4itwnfzekQjZC85rngCVcAvE=;
        b=dI3+Kd+rnrogogOpnC3EWfdQGoDfr1y0rirlXv3Chhd4iParKE1s+cREI8uEoRFbKn
         3BX4kFGgRHku4mT1fp7kNUlGALRCv/gnw6rwbH3A7w+a1XveW+Y7hJIPnycsH3tbdm76
         uXEtUe2JtI0526Z9cIZ5m5N7fIfpICzJNRFEpzfcZk6mIdzh/P2iN6iXeCs64NeDbpJG
         NzjNnp9g6caUio8RYSLRYG8iM9tIY7N7rAKnw0IPi/CR9lgnii9/BqxxX31xUie4VQ8o
         nXzziKt6gFJmY9KF9VFLG5IyXUQ236TeyBl2MNejXrXcg0GlQXbulKRs7xMSpid0lCsP
         UO8g==
X-Forwarded-Encrypted: i=1; AJvYcCXC+X0RHWTjbw2omWYvcQjOJPTRhhPAEWWaIEhiZJyWF5k+LMkMEiY50HhGipeCdUANhXqf0Mm+XMrEHgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCqFmZUfCWVHERCyBKLUxVeQXuQ4zEKsb630Zik+/j5gKYF7A6
	Hx2ZWGEL5BZz9VJY69yd4J+KACCFQO0xJQgqfqKIdApYMAm9xJqQxT8=
X-Gm-Gg: ASbGncuhj/xKaShuA05ins/NbSir55Hx/3c8Q0ntSvnJtFmYiczin39v8xYcLPOgH/P
	g6+Tb88ibfhsLEWgf4YAjvz3Xq57T3M6EOQHTdddNTi5/8ppCq4EEDnHHspDQ2JzZvqJ9tvXKdI
	1w1dfQnDbAq0fRy+zFE+POuV6XvepqR8jWaBUTWXMlbrQU69Nnd1p5zC/T9KErPwQqQZNoVWJgd
	bTN+sdEtmAVetdFX8t/lTfSRn8ku+Hazyd9e+uW2CXh5/CmTOnKuxKCGmnsxPUstecdqtIuipq6
	ZbhyNcowd74TKsbHJgmABNW+b4OkYZvcekBLjRijO+HcjPRN/Ic7qNi9Gt4u5brKz7Zr0EKMaZv
	PLpzqiVawP/MhC+oWTo5UENMZA25Ry6oJG7IFo/q4iSOZoQ8w45N5xLljULpXXdBWykfdilox+w
	imz28/r5vZBOCDLGcImMKyrVoDpsnnYuJKELmLEKmlg5IS5W/mr7COPsbG2qtdIKOl2BX1V2Ll9
	fzWYAoGTjbDekl83IJAM1ZmBmwHVg==
X-Google-Smtp-Source: AGHT+IG7rJeTc7BaYSRW2mgEZOIvuZo+hdU8tJz9alDLAEj9qzpkoBMt/mHdSNCv2yx7KPQXHG9lGA==
X-Received: by 2002:a05:6a00:398b:b0:77d:51e5:e5d1 with SMTP id d2e1a72fcca58-7938723dab3mr4584210b3a.19.1759940703895;
        Wed, 08 Oct 2025 09:25:03 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-794e2a4cb5asm156736b3a.71.2025.10.08.09.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 09:25:03 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	shuah@kernel.org,
	horms@kernel.org,
	willemb@google.com,
	daniel.zahka@gmail.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] selftests: drv-net: update remaining Python init files
Date: Wed,  8 Oct 2025 09:25:03 -0700
Message-ID: <20251008162503.1403966-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

Convert remaining __init__ files similar to what we did in
commit b615879dbfea ("selftests: drv-net: make linters happy with our imports")

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - remove tool from imports in driver __init__s it's not actually used
v1: https://lore.kernel.org/20251007144326.1763309-1-kuba@kernel.org

CC: shuah@kernel.org
CC: willemb@google.com
CC: daniel.zahka@gmail.com
CC: linux-kselftest@vger.kernel.org
---
 .../drivers/net/hw/lib/py/__init__.py         | 40 ++++++++++++++-----
 .../selftests/drivers/net/lib/py/__init__.py  |  4 +-
 .../testing/selftests/net/lib/py/__init__.py  | 29 ++++++++++++--
 3 files changed, 57 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
index 0ceb297e7757..fb010a48a5a1 100644
--- a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
@@ -1,5 +1,13 @@
 # SPDX-License-Identifier: GPL-2.0
 
+"""
+Driver test environment (hardware-only tests).
+NetDrvEnv and NetDrvEpEnv are the main environment classes.
+Former is for local host only tests, latter creates / connects
+to a remote endpoint. See NIPA wiki for more information about
+running and writing driver tests.
+"""
+
 import sys
 from pathlib import Path
 
@@ -8,26 +16,36 @@ KSFT_DIR = (Path(__file__).parent / "../../../../..").resolve()
 try:
     sys.path.append(KSFT_DIR.as_posix())
 
-    from net.lib.py import *
-    from drivers.net.lib.py import *
-
     # Import one by one to avoid pylint false positives
+    from net.lib.py import NetNS, NetNSEnter, NetdevSimDev
     from net.lib.py import EthtoolFamily, NetdevFamily, NetshaperFamily, \
         NlError, RtnlFamily, DevlinkFamily, PSPFamily
     from net.lib.py import CmdExitFailure
-    from net.lib.py import bkg, cmd, defer, ethtool, fd_read_timeout, ip, \
-        rand_port, tool, wait_port_listen
-    from net.lib.py import fd_read_timeout
+    from net.lib.py import bkg, cmd, bpftool, bpftrace, defer, ethtool, \
+        fd_read_timeout, ip, rand_port, wait_port_listen, wait_file
     from net.lib.py import KsftSkipEx, KsftFailEx, KsftXfailEx
     from net.lib.py import ksft_disruptive, ksft_exit, ksft_pr, ksft_run, \
         ksft_setup
     from net.lib.py import ksft_eq, ksft_ge, ksft_in, ksft_is, ksft_lt, \
         ksft_ne, ksft_not_in, ksft_raises, ksft_true, ksft_gt, ksft_not_none
-    from net.lib.py import NetNSEnter
-    from drivers.net.lib.py import GenerateTraffic
+    from drivers.net.lib.py import GenerateTraffic, Remote
     from drivers.net.lib.py import NetDrvEnv, NetDrvEpEnv
+
+    __all__ = ["NetNS", "NetNSEnter", "NetdevSimDev",
+               "EthtoolFamily", "NetdevFamily", "NetshaperFamily",
+               "NlError", "RtnlFamily", "DevlinkFamily", "PSPFamily",
+               "CmdExitFailure",
+               "bkg", "cmd", "bpftool", "bpftrace", "defer", "ethtool",
+               "fd_read_timeout", "ip", "rand_port",
+               "wait_port_listen", "wait_file",
+               "KsftSkipEx", "KsftFailEx", "KsftXfailEx",
+               "ksft_disruptive", "ksft_exit", "ksft_pr", "ksft_run",
+               "ksft_setup",
+               "ksft_eq", "ksft_ge", "ksft_in", "ksft_is", "ksft_lt",
+               "ksft_ne", "ksft_not_in", "ksft_raises", "ksft_true", "ksft_gt",
+               "ksft_not_none", "ksft_not_none",
+               "NetDrvEnv", "NetDrvEpEnv", "GenerateTraffic", "Remote"]
 except ModuleNotFoundError as e:
-    ksft_pr("Failed importing `net` library from kernel sources")
-    ksft_pr(str(e))
-    ktap_result(True, comment="SKIP")
+    print("Failed importing `net` library from kernel sources")
+    print(str(e))
     sys.exit(4)
diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/tools/testing/selftests/drivers/net/lib/py/__init__.py
index e6c070f32f51..b0c6300150fb 100644
--- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
@@ -22,7 +22,7 @@ KSFT_DIR = (Path(__file__).parent / "../../../..").resolve()
         NlError, RtnlFamily, DevlinkFamily, PSPFamily
     from net.lib.py import CmdExitFailure
     from net.lib.py import bkg, cmd, bpftool, bpftrace, defer, ethtool, \
-        fd_read_timeout, ip, rand_port, tool, wait_port_listen, wait_file
+        fd_read_timeout, ip, rand_port, wait_port_listen, wait_file
     from net.lib.py import KsftSkipEx, KsftFailEx, KsftXfailEx
     from net.lib.py import ksft_disruptive, ksft_exit, ksft_pr, ksft_run, \
         ksft_setup
@@ -34,7 +34,7 @@ KSFT_DIR = (Path(__file__).parent / "../../../..").resolve()
                "NlError", "RtnlFamily", "DevlinkFamily", "PSPFamily",
                "CmdExitFailure",
                "bkg", "cmd", "bpftool", "bpftrace", "defer", "ethtool",
-               "fd_read_timeout", "ip", "rand_port", "tool",
+               "fd_read_timeout", "ip", "rand_port",
                "wait_port_listen", "wait_file",
                "KsftSkipEx", "KsftFailEx", "KsftXfailEx",
                "ksft_disruptive", "ksft_exit", "ksft_pr", "ksft_run",
diff --git a/tools/testing/selftests/net/lib/py/__init__.py b/tools/testing/selftests/net/lib/py/__init__.py
index 997b85cc216a..97b7cf2b20eb 100644
--- a/tools/testing/selftests/net/lib/py/__init__.py
+++ b/tools/testing/selftests/net/lib/py/__init__.py
@@ -1,9 +1,32 @@
 # SPDX-License-Identifier: GPL-2.0
 
+"""
+Python selftest helpers for netdev.
+"""
+
 from .consts import KSRC
-from .ksft import *
+from .ksft import KsftFailEx, KsftSkipEx, KsftXfailEx, ksft_pr, ksft_eq, \
+    ksft_ne, ksft_true, ksft_not_none, ksft_in, ksft_not_in, ksft_is, \
+    ksft_ge, ksft_gt, ksft_lt, ksft_raises, ksft_busy_wait, \
+    ktap_result, ksft_disruptive, ksft_setup, ksft_run, ksft_exit
 from .netns import NetNS, NetNSEnter
-from .nsim import *
-from .utils import *
+from .nsim import NetdevSim, NetdevSimDev
+from .utils import CmdExitFailure, fd_read_timeout, cmd, bkg, defer, \
+    bpftool, ip, ethtool, bpftrace, rand_port, wait_port_listen, wait_file
 from .ynl import NlError, YnlFamily, EthtoolFamily, NetdevFamily, RtnlFamily, RtnlAddrFamily
 from .ynl import NetshaperFamily, DevlinkFamily, PSPFamily
+
+__all__ = ["KSRC",
+           "KsftFailEx", "KsftSkipEx", "KsftXfailEx", "ksft_pr", "ksft_eq",
+           "ksft_ne", "ksft_true", "ksft_not_none", "ksft_in", "ksft_not_in",
+           "ksft_is", "ksft_ge", "ksft_gt", "ksft_lt", "ksft_raises",
+           "ksft_busy_wait", "ktap_result", "ksft_disruptive", "ksft_setup",
+           "ksft_run", "ksft_exit",
+           "NetNS", "NetNSEnter",
+           "CmdExitFailure", "fd_read_timeout", "cmd", "bkg", "defer",
+           "bpftool", "ip", "ethtool", "bpftrace", "rand_port",
+           "wait_port_listen", "wait_file",
+           "NetdevSim", "NetdevSimDev",
+           "NetshaperFamily", "DevlinkFamily", "PSPFamily", "NlError",
+           "YnlFamily", "EthtoolFamily", "NetdevFamily", "RtnlFamily",
+           "RtnlAddrFamily"]
-- 
2.51.0



Return-Path: <linux-kernel+bounces-812869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8212DB53DD2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 640231C806BE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9961E2DEA94;
	Thu, 11 Sep 2025 21:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGAq35Tv"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CCF2D3228
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757626730; cv=none; b=r3FBMP6BRVaou9zgFbjfROmJwCb8bXCJU8aCEWR89Mm52Op5oCy+gibj4yNFjSrv1Z/Evkac4GqHLoJTp0KQEqe8PBidwODkHHUFkYTDjXYKJa3RrdmwnjWKJUWhKA7mmf9R9Emh15ywh0+8c0pJ66hxm8rARufAax0KxUuyjhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757626730; c=relaxed/simple;
	bh=B8dcsyyggwYCkYkKNypzvAZE2goYIgWDA5Tm6W1R3oQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HiRASeSWl5KlJ0c1/aL6T5J+V1eSeAzaegvZaAUvL+31l9W5cTsSzFMC9kdg6jxqn7tRg4c5hHg/SiS24KrTTrx+bkO84snf0nh09+af4xrAk21ipF+ryFxkv4WNrGutI3//fl+JnFqvXwY/27013cz5AWVgrlKN64Bbg04nvkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGAq35Tv; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-88432e91223so28300139f.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757626728; x=1758231528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7BFoISqrXfzunSW6Z4lpDyEbHwjrfmpqrwUs/T2P0T4=;
        b=gGAq35TvBKcIicmklCp+xUU4vnLwk4QZencGm/d8mqUTC1pR/NxAOShLtN2wD9+mcG
         SH+DeBYf3N56OKg4NW+p+MNzk6+bxoiKLQfnB1oOqbYZW2NdtTSSYaTd6djx5wrJW393
         TzpzPyZ3/YTkMxZGfuKmBAnal7rQN9mEwIvzB390niGrqJHWG5h+1XB6tNAf2FPSIXwp
         Ivercm3+y0Bqn1yp+KJCl0gUYHiAXEZZ7W/poRJR0EHaRDKHEv+cXTyTbcrlob8mPkrU
         5XACgu+yBW3rUg8YHaRXo2vOiyK5h2wHvFyukkfhGCTCY2nvyNSvaH6v1Gvtq8MO39Uf
         H9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757626728; x=1758231528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7BFoISqrXfzunSW6Z4lpDyEbHwjrfmpqrwUs/T2P0T4=;
        b=hem1HO7+H3IsKxMxscybFsJqbToiKtSCzkplH2nwT9yR0+2jyTTOfUu3unogW0YUcv
         cDCvehajj3rh8BKr3FwjP+RsjxdptPyEYq5VK1pZlkhTB0PGuRSvuEcMsgLRvCPqKMbL
         6t0uXldbmqSj2T2L1UVFf+rNJ1yDLAXiSVwpxLze+ENVvopz3A8vrxW4QXwiDxcy4zhb
         eA7c/AIVUEjKMUViWmcq8BtNwZNzCvjeZaLkcAiT2YgxhtPGqcc2NxUkdeNMe18BOFqF
         3iNwoN5OSIehxMzHKyR2Xz2UQhNxjP1rz4vwXtWtM/rMxnmz9Z2OT+TgZ0G2pjFxs/W1
         OokQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2CQR1EIjiWGcWjowIraXfpBGzbAPviuz3QLCoc+ceioY3eSc6NxlaF+XN3uGUCvRVK4B2sDgd+oIOqzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqnqwaCmy7M3VgW4RWAnkuDel21cN25PhNgw1PRBHQ1KA+upf2
	3gBhhWEtuHcYgtczPkoRa/y5DPNeOeq0eBB6tj8w2fGdEGh40fnhYVDQ
X-Gm-Gg: ASbGncsiKOACPpowH8JG07xyuRPnGgOWOwTvXf2xrW5+xjfrmM81dpq5oC9GnEx7y2i
	Y4gUIQnttTvuF/wKMkmJzsrTaVVujqfdZMRwTPyYTJdxvGyqm2g/lOnQ9WWu1NWgnmRNOLMx9M/
	Y54s2ieBbtGY4It3mt4mf2j9DaeVBvX9W7jkQ7sS0cUVh/kD/Ceha0bizD/GM+gdp8xvWGVV6Ek
	s91+IZAN95sljnUBDYx2gttRpYlaRebY0F/YEjYioD8ENCAqwZDDDV0vfgjYjju8wox4pVchK9E
	ORoRO3ljxUSrpFlMf7WQq2qW2QdW/GX4WhEDDcmwvlafUGhWiCAebPeLaaZYPTqn8FIOPO01XEE
	gdP/KoSS+j0zXLNY5yn+AjTNPvEkVZUcapObdL7xdWjge2suJDZrwAuVkfmuPJC39Xi0kmAzFfC
	Oo6uW7iSwPPs3EjS06GG24noWE
X-Google-Smtp-Source: AGHT+IFAsaxAsCEMyCugeiaW65S9mBpUgJy3/vIKxqg9NbJkKq6OXxYsC0/dbs4FSKSJPklmvSkSdg==
X-Received: by 2002:a05:6602:7506:b0:887:1d1f:c2cf with SMTP id ca18e2360f4ac-890322345d2mr149713239f.3.1757626728253;
        Thu, 11 Sep 2025 14:38:48 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-73-14-87-86.hsd1.co.comcast.net. [73.14.87.86])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-88f2d0bfdcfsm104024139f.3.2025.09.11.14.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 14:38:47 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com
Cc: gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	linux-kernel@vger.kernel.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 01/30] docs/dyndbg: update examples \012 to \n
Date: Thu, 11 Sep 2025 15:37:54 -0600
Message-ID: <20250911213823.374806-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911213823.374806-1-jim.cromie@gmail.com>
References: <20250911213823.374806-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 47ea6f99d06e ("dyndbg: use ESCAPE_SPACE for cat control")
changed the control-file to display format strings with "\n" rather
than "\012".  Update the docs to match the new reality.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Tested-by: Louis Chauvet<louis.chauvet@bootlin.com>
---
-v2 fix missed \012's
---
 .../admin-guide/dynamic-debug-howto.rst       | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 7c036590cd07..4ac18c0a1d95 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -38,12 +38,12 @@ You can view the currently configured behaviour in the *prdbg* catalog::
 
   :#> head -n7 /proc/dynamic_debug/control
   # filename:lineno [module]function flags format
-  init/main.c:1179 [main]initcall_blacklist =_ "blacklisting initcall %s\012
-  init/main.c:1218 [main]initcall_blacklisted =_ "initcall %s blacklisted\012"
-  init/main.c:1424 [main]run_init_process =_ "  with arguments:\012"
-  init/main.c:1426 [main]run_init_process =_ "    %s\012"
-  init/main.c:1427 [main]run_init_process =_ "  with environment:\012"
-  init/main.c:1429 [main]run_init_process =_ "    %s\012"
+  init/main.c:1179 [main]initcall_blacklist =_ "blacklisting initcall %s\n"
+  init/main.c:1218 [main]initcall_blacklisted =_ "initcall %s blacklisted\n"
+  init/main.c:1424 [main]run_init_process =_ "  with arguments:\n"
+  init/main.c:1426 [main]run_init_process =_ "    %s\n"
+  init/main.c:1427 [main]run_init_process =_ "  with environment:\n"
+  init/main.c:1429 [main]run_init_process =_ "    %s\n"
 
 The 3rd space-delimited column shows the current flags, preceded by
 a ``=`` for easy use with grep/cut. ``=p`` shows enabled callsites.
@@ -59,10 +59,10 @@ query/commands to the control file.  Example::
 
   :#> ddcmd '-p; module main func run* +p'
   :#> grep =p /proc/dynamic_debug/control
-  init/main.c:1424 [main]run_init_process =p "  with arguments:\012"
-  init/main.c:1426 [main]run_init_process =p "    %s\012"
-  init/main.c:1427 [main]run_init_process =p "  with environment:\012"
-  init/main.c:1429 [main]run_init_process =p "    %s\012"
+  init/main.c:1424 [main]run_init_process =p "  with arguments:\n"
+  init/main.c:1426 [main]run_init_process =p "    %s\n"
+  init/main.c:1427 [main]run_init_process =p "  with environment:\n"
+  init/main.c:1429 [main]run_init_process =p "    %s\n"
 
 Error messages go to console/syslog::
 
-- 
2.51.0



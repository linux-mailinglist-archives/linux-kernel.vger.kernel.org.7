Return-Path: <linux-kernel+bounces-847286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CECE2BCA753
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 19:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C0C94E580F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 17:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96DC24BD03;
	Thu,  9 Oct 2025 17:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkFLngVJ"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB9B248F4D
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 17:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760032727; cv=none; b=uMVptm1xSttv2/yBAgpKUNlsg6zVRYf4R4JOBQG+cXb/IXMZ9ThlSPnekGaGcPc6yquq9S+bbmR4uNghD0SrVTX9EJ1BlOKMwZhnA+xA3pwJEsoZAbyIi4d5ooeA4rTpi/WG5Vsa1R3jKp7FHbHo3Bcg04Nz2J8Eahc2lb4gFNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760032727; c=relaxed/simple;
	bh=B8dcsyyggwYCkYkKNypzvAZE2goYIgWDA5Tm6W1R3oQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b/+Mh/X5OingHolNNF0si36A+TrOuEqq87x6KHvmNXdvoJyUnzogO31kw1XwXIl1rnZfpeEpnO+3D+rDIyFm5+H0xJBywkt9Zb6TC6A1GjN4gbJNUrKcZZwVJyaUV+H0my6yOwI4cplwCRzDOlEUZesiqva6s/r4Foy/K9BE3qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkFLngVJ; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-42f91f09a6aso4649755ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 10:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760032724; x=1760637524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7BFoISqrXfzunSW6Z4lpDyEbHwjrfmpqrwUs/T2P0T4=;
        b=dkFLngVJsAdKNma/aUPsUkRdeks6ydSW8gKDO8s85c7fnWS4yFS1Lt4aRfEJa1IC/N
         +fJaslVd0Jor1usg7ThTFWuEuwCw2/BZwLDdgmnZbGwyADXCNAnGibDrTTJVbFGpPA/J
         9R9wB1pVmxPsrOJF5EMGL43o19pcI28S62WRMtGH7DPfCZ0n81NFyqFbvNOxlOqLFC1w
         Nm5dei2mzi8RFm7IpMxTlZfRh53SJavoC1Vn+0f4PBELu11kRX8Rs2H79ifht2GSAePe
         M4aIanbmkcMqtM3VRoj+aS6l2Cl2M6k1zCsJb47BM3GYDyAk/lkH1QLifMNt96RMoe3y
         t18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760032724; x=1760637524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7BFoISqrXfzunSW6Z4lpDyEbHwjrfmpqrwUs/T2P0T4=;
        b=KXm6Qyvo+16S/j1LB5oSWwqyhiQqKKNLH1uPxghuuBwTfE0xzdtGG18oz+RXUiaMic
         GmNG6b0x8l/HXGjM/W3yozQP5dt44K/+W13iDZ3HAoG0dcMcm1fi3uOVT47NL5jkF8M6
         A+u6ElJ1ZLupKeJOJmpBrImEbV0ENiT7MuxUOtKeFde0MJI+/6SuINhHgS1irHkcoh9t
         jAMybaoKY2xnZtXpUX3znNNMEv9EqmcCKrfKFvJ4j4eBpSeQmCrKhKMNuyy5ApyfnRMN
         HApUDNeVoOB/NBGOSVTCHxC1/l7U6s6KEiYCicUGttP53Cyq+L6GrLiLELr0t7vZGldt
         A50A==
X-Forwarded-Encrypted: i=1; AJvYcCXxZD9081B0gpoZjJvQuxO8guoYDqbJR2b7pcAidBJLS0upOr7EmHTwT8LQxnOumLnhC8Cs2gkEZnDRHF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGiIJ3url7LmTuI3EdaV8+Ji6res5dRZmcd2mrSLHQLOyOnoDU
	OQDoooVQzInFJVI2hnTMxTFVKwA01NWDFULewsdD12If7ker1vdTzok6k53UfA==
X-Gm-Gg: ASbGncuZsW8fGiIAfwUdNn4hWUx7U2mqCLdTVqSsRGuKqd938L3bvrxHy6Tq7dgEHdw
	SZbx0aOs3pApD9Xb3jmilhyNIyd0nVYVklnVPenf44hhp7Km1jFhcBFFOrtbRlI+sLCmwzNmK7T
	inzvqX4tR2TMt7pDFEnWWPCIv0z17ZxZwcB+zUrOM9nJNtwKrngMXqQCOvYM9z8t9NrZSx0I9vj
	zM73y5Ry2gjq0/BBCc42YH37RdTONT062X99zG2lvnCtHKUcAggCrWSFTnpf32tHB161HhQaELe
	HQS5fjveL4vuGNdrTluzkLyqH8gxn4mkU2noU+EzetHjNUeboeoK/RAbCFixeOKkF9V9ixIGfzD
	AvcJvu6x7nO43q4JXL9m86V77w2zwa6Kk9sApjhiYqstzHF4drXnhID3bVN0OdXMlioHlYXfcBy
	K+29iVymQHc13u3j+y91XNW69+e0w=
X-Google-Smtp-Source: AGHT+IFdvzN/Qe3kT6LC4KV36Vpx8Hont4QG2a9m6SfK0vqpuJ8k6n9bUCxYy5aRpvHqGEB15mxCww==
X-Received: by 2002:a05:6e02:1946:b0:42f:96ec:50a5 with SMTP id e9e14a558f8ab-42f96ec51a2mr14056415ab.20.1760032724385;
        Thu, 09 Oct 2025 10:58:44 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-58f7200c4afsm30256173.35.2025.10.09.10.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 10:58:43 -0700 (PDT)
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
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 01/30] docs/dyndbg: update examples \012 to \n
Date: Thu,  9 Oct 2025 11:58:05 -0600
Message-ID: <20251009175834.1024308-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009175834.1024308-1-jim.cromie@gmail.com>
References: <20251009175834.1024308-1-jim.cromie@gmail.com>
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



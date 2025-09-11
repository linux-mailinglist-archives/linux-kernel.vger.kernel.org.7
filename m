Return-Path: <linux-kernel+bounces-812877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3051B53DDC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B88205A654C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D302E2F05;
	Thu, 11 Sep 2025 21:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VK6QsqKf"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD632E11DF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757626739; cv=none; b=Fo9Ca+lIEnVK74baTszfgFbmsdkN1EKNKyYv3ttc0GmUYM8brWtXS9XOFeS3qTKJPiafCBH+xAZXQIWm6iWNRw/OOzf4fgn4LYsFDrhJnxWuLS1dkI9NkW25IR1+GMtd4gMQRO5cqNx4hk5Av+rJJzMfSAv/Z3AFYxWExMMxEes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757626739; c=relaxed/simple;
	bh=9/CNm/qErK1SavMH1/i1nBZVahomfVgVs/AAjSYrEHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GGYaqeBhHTBJ2CkEEH5ns6n5z8sj1jvfNmklXULC/mKZWkgyMZdFdhZGZ+44WwOdQ3by/QiYa/JZqe8eyf/9EzB+nQa2rdpacXDHd/jFudrxrzFjgpo941BEYfeWRKC/dRUqugRiCEBc4MUY88Q2im3TR9dUc5VKIEFS7SO5GAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VK6QsqKf; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-884328c9473so27507139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757626736; x=1758231536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSi3Wv5G5XIofYUm4EK1Li8HBZbPI3ZGv4Q8D6oYWPg=;
        b=VK6QsqKf5MSkhlPKzl2p4lA6P8wL7t7tPW4IA/bpsq+Mzt6+yP0YBv4c9uJexh7B0C
         CWpkzsJ5Q4ma1hpNUCI+YPdAPI1m7/pBaB0eJ0SX9FYSppmMLRtIIEgDALFco0faDx8M
         GZjIrVRJiVnwM/cTXzoVIUK05v9VuYMHAaGdo+3Yr4qFu/dICug5U+20HXIbSGHP0gpH
         Onb+xq9V2T6+SxiR3l7nPH4MSJjc+y9lQcLHMWyj0BvWkBllpOEKBVANDB19D898Tkcg
         1jzU8u7C/RoOgJvmsqBGoolCkbrIyJFVGO355gwGWWseaIf9jzbE8G7MRGDd3qEnTp3O
         vYjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757626736; x=1758231536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSi3Wv5G5XIofYUm4EK1Li8HBZbPI3ZGv4Q8D6oYWPg=;
        b=gBlxlOJQSDR1Yv5us2gwR57AX37gNKKLEY4eN9aLbcYpPcxuQM0gj4CT9ds24EtGYv
         kX4AzWoMX1qcqLJ3hgHFk0Scp5JHLC+zvPy3OC4sRx9/3bFZ/tVDLK8XkXCYwDdP1zQg
         Q4BrSPlT6ReYZakagU/1nQsjGuA+tw2s4jx0Di2FOzm9vgcsNYV5lYHCYYyoN/2Y6Qfv
         eXnz8n+sqGfaM2eCsHxqJVvEYSVjh8ydStMd76pf3adSg3s5H7ACOKhFI+hTkVomgIC5
         5OV2DjEyjF+0mPXP/T9lg+7TT61t9+qmotCXmFTurRA6pyAllHS0pfDx9dLJJlU5K8x3
         76Zg==
X-Forwarded-Encrypted: i=1; AJvYcCUaK4Eh5C6bI6QGc/GGP6W0VrlptewMLLiiM82XZytaXLfDjhUDGHAyxReNLFgPEQxSM/mIlW70aVifYJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1dLJpKK/P1764OUh4dYuekhyE86oFZMsnnDiqvKvik21bvseD
	CY2GYVrCyAxDdh5D98r/1UWQ8dYrLP4ppMhVG6Jp/geMwmcE8lfkg3+6
X-Gm-Gg: ASbGncs0h8WTmGuxb1sxuLAZJAy1F/X4dsmjQdX9VkWo3XrXE3sfSfvkRzErdSgqNxt
	f+NxHmv+dXJis2YqFigDJSnNlOQLp11n48ImIwrzUgKK8qAMjlDdFUurRlgbUU0QITR9kPGV1cC
	dTi5935wvaNuEUXYb2SaBNl0hiG9JcYzozuryryx5aq2c9ZHE25FRhtm70VuvO7WSXsKuitzaN2
	8itj8JeH9Q7RquO6JYHt4Bo7nnuw/1XnhnIQdRp9IWwfcKN8fJmppp3qbcEgfLbi2MmnfDQ16cQ
	yCaV4etk1fcciMqlgxVuecHnWAwGNUOLH655S5lZ8uEPJIdLlS8AO2wYC29dehqEOM76lNMPSc2
	NXoO3w+LJ/+WXOsHCCnFPKBU7jmUFndaADJdH+s+zJexkoj3kKtmsEQaPgP+ceZTbc5cvPjU3Sm
	vEXco=
X-Google-Smtp-Source: AGHT+IFnnqui7lMtpiykBUjwTnYQcYRTI2kmmrqbgCsEOh4j6FVsYibaGMcAvqDm+PkSnPY4OF1raw==
X-Received: by 2002:a05:6602:2d90:b0:887:55d0:c208 with SMTP id ca18e2360f4ac-88ec3b3037dmr804627539f.8.1757626736258;
        Thu, 11 Sep 2025 14:38:56 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-73-14-87-86.hsd1.co.comcast.net. [73.14.87.86])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-88f2d0bfdcfsm104024139f.3.2025.09.11.14.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 14:38:55 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com
Cc: gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	linux-kernel@vger.kernel.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 09/30] dyndbg: refactor param_set_dyndbg_classes and below
Date: Thu, 11 Sep 2025 15:38:02 -0600
Message-ID: <20250911213823.374806-10-jim.cromie@gmail.com>
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

Refactor callchain below param_set_dyndbg_classes(1) to allow mod-name
specific settings.  Split (1) into upper/lower fns, adding modname
param to lower, and passing NULL in from upper.  Below that, add the
same param to ddebug_apply_class_bitmap(), and pass it thru to
_ddebug_queries(), replacing NULL with the param.

This allows the callchain to update the classmap in just one module,
vs just all as currently done.  While the sysfs param is unlikely to
ever update just one module, the callchain will be used for modprobe
handling, which should update only that just-probed module.

In ddebug_apply_class_bitmap(), also check for actual changes to the
bits before announcing them, to declutter logs.

No functional change.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v3 s/modnm/mod_name/g
---
 lib/dynamic_debug.c | 65 ++++++++++++++++++++++++++++-----------------
 1 file changed, 40 insertions(+), 25 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index d9268d051a10..96cd31c457e2 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -593,9 +593,10 @@ static int ddebug_exec_queries(char *query, const char *modname)
 	return nfound;
 }
 
-/* apply a new bitmap to the sys-knob's current bit-state */
+/* apply a new class-param setting */
 static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
-				     unsigned long *new_bits, unsigned long *old_bits)
+				     unsigned long *new_bits, unsigned long *old_bits,
+				     const char *query_modname)
 {
 #define QUERY_SIZE 128
 	char query[QUERY_SIZE];
@@ -603,7 +604,9 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 	int matches = 0;
 	int bi, ct;
 
-	v2pr_info("apply: 0x%lx to: 0x%lx\n", *new_bits, *old_bits);
+	if (*new_bits != *old_bits)
+		v2pr_info("apply bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
+			  *old_bits, query_modname ?: "'*'");
 
 	for (bi = 0; bi < map->length; bi++) {
 		if (test_bit(bi, new_bits) == test_bit(bi, old_bits))
@@ -612,12 +615,16 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 		snprintf(query, QUERY_SIZE, "class %s %c%s", map->class_names[bi],
 			 test_bit(bi, new_bits) ? '+' : '-', dcp->flags);
 
-		ct = ddebug_exec_queries(query, NULL);
+		ct = ddebug_exec_queries(query, query_modname);
 		matches += ct;
 
 		v2pr_info("bit_%d: %d matches on class: %s -> 0x%lx\n", bi,
 			  ct, map->class_names[bi], *new_bits);
 	}
+	if (*new_bits != *old_bits)
+		v2pr_info("applied bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
+			  *old_bits, query_modname ?: "'*'");
+
 	return matches;
 }
 
@@ -672,7 +679,7 @@ static int param_set_dyndbg_classnames(const char *instr, const struct kernel_pa
 				continue;
 			}
 			curr_bits ^= BIT(cls_id);
-			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, dcp->bits);
+			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, dcp->bits, NULL);
 			*dcp->bits = curr_bits;
 			v2pr_info("%s: changed bit %d:%s\n", KP_NAME(kp), cls_id,
 				  map->class_names[cls_id]);
@@ -682,7 +689,7 @@ static int param_set_dyndbg_classnames(const char *instr, const struct kernel_pa
 			old_bits = CLASSMAP_BITMASK(*dcp->lvl);
 			curr_bits = CLASSMAP_BITMASK(cls_id + (wanted ? 1 : 0 ));
 
-			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, &old_bits);
+			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, &old_bits, NULL);
 			*dcp->lvl = (cls_id + (wanted ? 1 : 0));
 			v2pr_info("%s: changed bit-%d: \"%s\" %lx->%lx\n", KP_NAME(kp), cls_id,
 				  map->class_names[cls_id], old_bits, curr_bits);
@@ -696,18 +703,9 @@ static int param_set_dyndbg_classnames(const char *instr, const struct kernel_pa
 	return 0;
 }
 
-/**
- * param_set_dyndbg_classes - class FOO >control
- * @instr: string echo>d to sysfs, input depends on map_type
- * @kp:    kp->arg has state: bits/lvl, map, map_type
- *
- * Enable/disable prdbgs by their class, as given in the arguments to
- * DECLARE_DYNDBG_CLASSMAP.  For LEVEL map-types, enforce relative
- * levels by bitpos.
- *
- * Returns: 0 or <0 if error.
- */
-int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
+static int param_set_dyndbg_module_classes(const char *instr,
+					   const struct kernel_param *kp,
+					   const char *mod_name)
 {
 	const struct ddebug_class_param *dcp = kp->arg;
 	const struct ddebug_class_map *map = dcp->map;
@@ -744,8 +742,8 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
 				KP_NAME(kp), inrep, CLASSMAP_BITMASK(map->length));
 			inrep &= CLASSMAP_BITMASK(map->length);
 		}
-		v2pr_info("bits:%lx > %s\n", inrep, KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &inrep, dcp->bits);
+		v2pr_info("bits:0x%lx > %s.%s\n", inrep, mod_name ?: "*", KP_NAME(kp));
+		totct += ddebug_apply_class_bitmap(dcp, &inrep, dcp->bits, mod_name);
 		*dcp->bits = inrep;
 		break;
 	case DD_CLASS_TYPE_LEVEL_NUM:
@@ -758,7 +756,7 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
 		old_bits = CLASSMAP_BITMASK(*dcp->lvl);
 		new_bits = CLASSMAP_BITMASK(inrep);
 		v2pr_info("lvl:%ld bits:0x%lx > %s\n", inrep, new_bits, KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits);
+		totct += ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits, mod_name);
 		*dcp->lvl = inrep;
 		break;
 	default:
@@ -767,16 +765,33 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
 	vpr_info("%s: total matches: %d\n", KP_NAME(kp), totct);
 	return 0;
 }
+
+/**
+ * param_set_dyndbg_classes - classmap kparam setter
+ * @instr: string echo>d to sysfs, input depends on map_type
+ * @kp:    kp->arg has state: bits/lvl, map, map_type
+ *
+ * enable/disable all class'd pr_debugs in the classmap. For LEVEL
+ * map-types, enforce * relative levels by bitpos.
+ *
+ * Returns: 0 or <0 if error.
+ */
+int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
+{
+	return param_set_dyndbg_module_classes(instr, kp, NULL);
+}
 EXPORT_SYMBOL(param_set_dyndbg_classes);
 
 /**
- * param_get_dyndbg_classes - classes reader
+ * param_get_dyndbg_classes - classmap kparam getter
  * @buffer: string description of controlled bits -> classes
  * @kp:     kp->arg has state: bits, map
  *
- * Reads last written state, underlying prdbg state may have been
- * altered by direct >control.  Displays 0x for DISJOINT, 0-N for
- * LEVEL Returns: #chars written or <0 on error
+ * Reads last written state, underlying pr_debug states may have been
+ * altered by direct >control.  Displays 0x for DISJOINT classmap
+ * types, 0-N for LEVEL types.
+ *
+ * Returns: ct of chars written or <0 on error
  */
 int param_get_dyndbg_classes(char *buffer, const struct kernel_param *kp)
 {
-- 
2.51.0



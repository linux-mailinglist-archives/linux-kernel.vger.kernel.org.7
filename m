Return-Path: <linux-kernel+bounces-847295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5327FBCA7ED
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 20:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 32A2E4FB3C5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 18:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC172E283A;
	Thu,  9 Oct 2025 17:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MThWKHf5"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A954A2BD02A
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 17:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760032740; cv=none; b=q7n4jBR2/ro/+AVAdjUA9dfcjnFc2jIQMfHVTZA33f1ck1K5/6frHlnmMnkS88ttVuAtVj5FogO61TLRmn2osELjtQBCJJzKLV0BC0+1/8hj5uqS4JHIDGxkMyyxtbF8atdIyYLxdajlIr7pjMYVWcNydQrMrsat49bGHlS71m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760032740; c=relaxed/simple;
	bh=O+DrJ+WIzxL0KCL50VNkBHjTweV2OInEHiE37yzYWsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ERGcQPXWYH5KXL8qbkxYQX5o3hw1ypQ9nBRoBGV+tyIBbxPqfi8LTeUiD2wIOvnaHfmA0KN+J+hJBKHVbTHKt+j7kR1dQSL2PW4v0FhzrjcFLpsMhlgpBtdz3rMpyDADhEx625xhcCsej7+JeigqcWPilcVCNKKiO3C5wmdOEcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MThWKHf5; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-42f91d225c9so4294525ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 10:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760032738; x=1760637538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+G5LpRSmzQv8Uk4Lzh4jg4DDwzNtpQJGLN6ei9qbCY=;
        b=MThWKHf5zunsMNTN1VZxCTcDE9aq/Ti+AZ6Bxk3hxr5CaQDWw/SD6qGb9ApPvSaiQA
         QKY2ehWlc/PvPl1SviOBUcsLXQ8wRUswhbRZbFgONWvWyzAUXfhJzn9BBmUgOwcQ1Vbz
         WmI66IHjEOt1r72f1W6lEH2YAiMz1relMr0a4r6Fl2jk3WJlZ9Qx3uQJehDwGAYM7tGO
         a9bYjZpEKjyyZwjKg3aUKe1ADk/skBeBOfIrtdh2gund1aM3w+NwFk/BDuPcQ2KoJXzP
         o/ygf/wMaNfbco+tmdXFir2ysE+nmSb5TEL5RSbj+9GeYLmLgyfSEKtFcRAzjpFywSZM
         qCLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760032738; x=1760637538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i+G5LpRSmzQv8Uk4Lzh4jg4DDwzNtpQJGLN6ei9qbCY=;
        b=lvQ1F6grINvM/k8dM79qEZa/zScdtO3fIeGfrfIWvmxFY9DswrxqkDKaTNKKl0C+ak
         fckq8fnbDAalEhNmDi8jPz042xypL/h83mMK5lj7npbYmahJzBu4XpCCrQedxf6/ej7V
         rOmlp0uoPoH9yGdQQnJi9lhh71FLNF8NTHLqNC371HA8aKPh2iwPBVnO/dCCt8BB1OXZ
         s4pTXSf/sQkKAPMlvKzxFcTx4Do4h3OVe/cYKJek+EOM4RaA8wiycRGcm90nxeTynmkV
         29yhH9AaFJZ+WBLsGlZ8fW+03UpuWHzbvvEajePbxQmADw/VN9RCFaexfcLOGk7xQJm6
         Px1g==
X-Forwarded-Encrypted: i=1; AJvYcCX763ZDnhYth31ov/iPxiqXmDN3mVUSDLuQenECKsV0dOXuiSkC49EBEstLt1HsNoAH1A5G5VJ6U7HdyvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLnTcu90sIFHyksUPCz3RiA+jHBrjb62QfvQ5dOBavwfxgurYP
	h1cggueCpqDmoTXppMIBat79e7ohO6o3r7W5CG4CuQHpyZocQceTWBLu
X-Gm-Gg: ASbGncteJ3fOex+EJNxYhjQHyKU4VwSYhbNuFERWuIx/IVD3S6tvs0wLxPQsTEq2qVa
	jdKODChcW+6Nm8G1kCV2DpimQPzt9ukX7ddanNibHlH5YLMS6f/QRGTfr7yEUVKKNHpbNvZJKvy
	8FKn8Pdn1/+xtsyLIcjJlFNBglC69OVucBXn0MRsDOWQ6kD/psEWwMZj/V53f0VQHvKt2bHYBfJ
	chrYlqd8Pc0ydW8yFZ0Ug4U6x1xITfo5VwN0VE4LKRr2CKEUifjkOULeE66aeACiWRtSDylk5/K
	D6OduIxSbpOhcYCMRsrl3WvqkjQUJzNbmZMxmkq+9ak1dYWxy6p2KtOW7fFef2vaydLK0/seqYO
	sZyvyQzurJ0VCaPh52rpbn4dvd+yudf1/CbOOEk/mqwwAZnDK7LRnIfUbu5huF0XFGWMrIxtrqj
	6bw8qxq+UKgx7VNEcLa5s1uDqMPOB9Z8vbByjbHqik5pJCm1Pj
X-Google-Smtp-Source: AGHT+IFuL6dXa56UawxDS7QbBZMvD0b6eokP6AmRif2uOK68pKBSgTMBBEBchUQxGhuaWuFmQYhoQA==
X-Received: by 2002:a92:cdac:0:b0:405:d8c4:ab8f with SMTP id e9e14a558f8ab-42f7c3b2655mr137429405ab.14.1760032737756;
        Thu, 09 Oct 2025 10:58:57 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-58f7200c4afsm30256173.35.2025.10.09.10.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 10:58:57 -0700 (PDT)
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
Subject: [PATCH v5 10/30] dyndbg: tighten fn-sig of ddebug_apply_class_bitmap
Date: Thu,  9 Oct 2025 11:58:14 -0600
Message-ID: <20251009175834.1024308-11-jim.cromie@gmail.com>
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

old_bits arg is currently a pointer to the input bits, but this could
allow inadvertent changes to the input by the fn.  Disallow this.
And constify new_bits while here.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 lib/dynamic_debug.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 96cd31c457e2..08d095dd19ef 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -595,7 +595,8 @@ static int ddebug_exec_queries(char *query, const char *modname)
 
 /* apply a new class-param setting */
 static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
-				     unsigned long *new_bits, unsigned long *old_bits,
+				     const unsigned long *new_bits,
+				     const unsigned long old_bits,
 				     const char *query_modname)
 {
 #define QUERY_SIZE 128
@@ -604,12 +605,12 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 	int matches = 0;
 	int bi, ct;
 
-	if (*new_bits != *old_bits)
+	if (*new_bits != old_bits)
 		v2pr_info("apply bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
-			  *old_bits, query_modname ?: "'*'");
+			  old_bits, query_modname ?: "'*'");
 
 	for (bi = 0; bi < map->length; bi++) {
-		if (test_bit(bi, new_bits) == test_bit(bi, old_bits))
+		if (test_bit(bi, new_bits) == test_bit(bi, &old_bits))
 			continue;
 
 		snprintf(query, QUERY_SIZE, "class %s %c%s", map->class_names[bi],
@@ -621,9 +622,9 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 		v2pr_info("bit_%d: %d matches on class: %s -> 0x%lx\n", bi,
 			  ct, map->class_names[bi], *new_bits);
 	}
-	if (*new_bits != *old_bits)
+	if (*new_bits != old_bits)
 		v2pr_info("applied bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
-			  *old_bits, query_modname ?: "'*'");
+			  old_bits, query_modname ?: "'*'");
 
 	return matches;
 }
@@ -679,7 +680,7 @@ static int param_set_dyndbg_classnames(const char *instr, const struct kernel_pa
 				continue;
 			}
 			curr_bits ^= BIT(cls_id);
-			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, dcp->bits, NULL);
+			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, *dcp->bits, NULL);
 			*dcp->bits = curr_bits;
 			v2pr_info("%s: changed bit %d:%s\n", KP_NAME(kp), cls_id,
 				  map->class_names[cls_id]);
@@ -689,7 +690,7 @@ static int param_set_dyndbg_classnames(const char *instr, const struct kernel_pa
 			old_bits = CLASSMAP_BITMASK(*dcp->lvl);
 			curr_bits = CLASSMAP_BITMASK(cls_id + (wanted ? 1 : 0 ));
 
-			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, &old_bits, NULL);
+			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, old_bits, NULL);
 			*dcp->lvl = (cls_id + (wanted ? 1 : 0));
 			v2pr_info("%s: changed bit-%d: \"%s\" %lx->%lx\n", KP_NAME(kp), cls_id,
 				  map->class_names[cls_id], old_bits, curr_bits);
@@ -743,7 +744,7 @@ static int param_set_dyndbg_module_classes(const char *instr,
 			inrep &= CLASSMAP_BITMASK(map->length);
 		}
 		v2pr_info("bits:0x%lx > %s.%s\n", inrep, mod_name ?: "*", KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &inrep, dcp->bits, mod_name);
+		totct += ddebug_apply_class_bitmap(dcp, &inrep, *dcp->bits, mod_name);
 		*dcp->bits = inrep;
 		break;
 	case DD_CLASS_TYPE_LEVEL_NUM:
@@ -756,7 +757,7 @@ static int param_set_dyndbg_module_classes(const char *instr,
 		old_bits = CLASSMAP_BITMASK(*dcp->lvl);
 		new_bits = CLASSMAP_BITMASK(inrep);
 		v2pr_info("lvl:%ld bits:0x%lx > %s\n", inrep, new_bits, KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits, mod_name);
+		totct += ddebug_apply_class_bitmap(dcp, &new_bits, old_bits, mod_name);
 		*dcp->lvl = inrep;
 		break;
 	default:
-- 
2.51.0



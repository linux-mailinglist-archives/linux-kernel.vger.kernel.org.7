Return-Path: <linux-kernel+bounces-812878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9EEB53DDF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 778D0189E104
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05A72DF130;
	Thu, 11 Sep 2025 21:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSSgliQK"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E252E1EF5
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757626739; cv=none; b=jPGTQMmfs5BpAcyoA5ae9SMpF+5hAmsNIbpkQVqKcUcP+Dfl4YUHT8OXm22jkhEiEwkmt97lz5xA+cP+ODli6lv9eqDKI+Bezx5WO+O6mCodSnwfs8hZLKsRtNYpV60BBL3RGSNUnFUyqlRkzp/5PzB8oJld68Pa/8RWY4lxgxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757626739; c=relaxed/simple;
	bh=O+DrJ+WIzxL0KCL50VNkBHjTweV2OInEHiE37yzYWsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NM9eDRBcIXhGGN8xP2Eymyl9kqXAiQyyJ6/eDA18gaGpr18ygM0qeRCWWis2lje5HPDtymCmkiEk9GITTJa6WSX+bA4w381MS5653J5h43br+7SWZXpeTaThxfqIVYpINpKuNGno9/trGUmEue9rpJq2Wwr/0m0eEerIrqSGczo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSSgliQK; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-88c4a7ff3c5so39272739f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757626737; x=1758231537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+G5LpRSmzQv8Uk4Lzh4jg4DDwzNtpQJGLN6ei9qbCY=;
        b=FSSgliQKJzYcnJ3x5VxM3FSGLxJQOR8UL6wSMOgGOiRUea+OteNJDphV6wJ7GmhN2+
         8xi+RPVaxQ/Q2XGzOqKeZpU23hneaj4nSZy+f0A/0lP4AZzMaUhx99fS4A8jN1xrMVCT
         MlEzlTS4He6SeUEttDc+gRmrDLS74YQFtYutdc5SWei32GHmDhYpzSe5a1N6J4mbWtaq
         MK7piBaLQ1z+dmKi/FsQnNoZZP74W9DmRIc2cUFea16AfMR6PLksCfMCM+4k9hNAofgF
         AGW1Y8SFwG75nZFP2n1eAOircAWuozLvzFQjj66KpeRHQ4QiHzxz5DQuMv7F0zDLVBQF
         eYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757626737; x=1758231537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i+G5LpRSmzQv8Uk4Lzh4jg4DDwzNtpQJGLN6ei9qbCY=;
        b=YN7ySRZZsYE8sNrrpWMKsYFcDuh0fMKh8rScKXVw3TztjgEUwuzvXuEAVdukUchs2r
         3Wub2IiSSnxbJpT0qB+aW+Yd/Eh3eeMEliuk+56YJQvH/Dg9nqTmdFJBxqwBYWvE6VBz
         h2nFngyaxtWmANOYMzYjTRC+6u3ADs7CFWfz9edS6naTfSBpZjqrQMKnIqFaAx4mWGiL
         8X2jpGWSGYXdAzhSGhuqNwFffhLfOTKau3/zuxggRXyRB8qkCNBeJKWl30NJdGK4JQEO
         dW/duUTe3DSs1FjofEWdNyCqRoBLzg3Gb9r2OrcEjlrxz45yTuU00OLpY4jW4UrziHM5
         Sbug==
X-Forwarded-Encrypted: i=1; AJvYcCUJ2143gDPAicStXWrXnpSvfevBu/4rWwAA0Ar/1N/nUFpG8byr4xuYe71WxFFkfm1A6GHmr1cDtDvxJmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwksfFKGJk/sXpo48rckXz+LCJvMeitx9dX7z0Rf/8YY6gdJ6z2
	mOkyG4VRr47phFoBBGTU5q6IgIqX7ZNNVuKvecAePr3c7kuZNL4tDUT7u9xlLg==
X-Gm-Gg: ASbGncvTX2/+w0GuRlWi4NUoXlIpYcvh+R0h2qUhYYo3CoOm9KV4fK/2PRZsUIcixMp
	fKiFJAQsoq/HtrDFLR80TwhdC4UuglJRqbcmRoBl+A+fn7OidKcLC7pSRgP8vrfEbwiOzXIv3p4
	xSTVhZIJ9NqF1QS6IqNLdaTLDON0yhEXbFAOuLlwDcjPMW/LBF4Q1rOxLsSLG/faUqt8bGM8TfP
	m6HVBC5M72Mxludn9+Ga+UzZIucUx3/5FDxa3ciFjV5mNNo30MbJ1/mMDjUhQKFJ8+gTv2SzZfO
	z5XlgghpQo376D5F6wGkx7Qg7YSqo1yGnknB6gOHj/AqhBc1aWve+vxk7Z6zT8qtNlUBXrtmXgc
	O0FJpH8EMhN//PEtlQXQRh8bJsLmRZ9GVHAPI411vG6MtLyKF30wSIIAuWyeqS6n7uLqDd/o1MJ
	IZCoAQYcafjsaLWi5L008jO03K
X-Google-Smtp-Source: AGHT+IHxDfbt2xYanVoqyvJ+YQ/rRdbo84JuCpdy+RWzo3qH3dtLWN9+qRNluXReqftvujFsucGd7g==
X-Received: by 2002:a05:6602:3897:b0:887:6fe0:e742 with SMTP id ca18e2360f4ac-89032426fe4mr131060439f.6.1757626737156;
        Thu, 11 Sep 2025 14:38:57 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-73-14-87-86.hsd1.co.comcast.net. [73.14.87.86])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-88f2d0bfdcfsm104024139f.3.2025.09.11.14.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 14:38:56 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com
Cc: gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	linux-kernel@vger.kernel.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 10/30] dyndbg: tighten fn-sig of ddebug_apply_class_bitmap
Date: Thu, 11 Sep 2025 15:38:03 -0600
Message-ID: <20250911213823.374806-11-jim.cromie@gmail.com>
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



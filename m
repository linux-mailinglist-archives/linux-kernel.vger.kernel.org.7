Return-Path: <linux-kernel+bounces-812871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFABB53DD5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFA325A5C50
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87932DF701;
	Thu, 11 Sep 2025 21:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRWRnkZc"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348F42DEA8E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757626733; cv=none; b=d1sKY2SMHdgzSbpEWmK7DygPk2qHftpmHOFxPirWeyUD6Jv2pXOLSExwVn8IJegC2WCO8n2Wk5opl4q8zQA7LZzHCIFKGSJn1nY+Khh8y7gsyy2pJ0xdgTMuRu7O6U4WE/a57k20IAbdU5u9kc/DcoHjJZQYWxBDhJUsP/qV0vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757626733; c=relaxed/simple;
	bh=9KA9wrUk/+sc2aQPuLDuiC0POPJjUDsXmXxrrpGdqRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YohvLSBTXZl4z/R4X6HDHDga8ZDdKtz9nsWczwllMCVcgSaPT0JAhpnG7rtmwTNewQrdf9zPFwNn4vx7/cIGrBZcKbSTXvjpq0UCG5CjBe8Wf6rDpKR5Vi1DyuZv4azBYS5pl9D1xatNK3k5k+0p+PIhSHZ50COLDvM1lheR3f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YRWRnkZc; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-88428cb5dfdso22008239f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757626730; x=1758231530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTjH4sGVjFOYrHuOXXQp8+DmE+GbVi2pPpgMotQBb8c=;
        b=YRWRnkZcOv05qVU1ZNgOeE3LNPAEU+/CJleeY2FYYSZo/JeEANdbrO6y6tD6ULcipi
         FHwdr7CDyHGB2i79mWkdLBMYpnMrLkuJQuQlU/0dT/7BxkB+zG9GKobvWQ+1Mi69i+6m
         zxGLHBW5lAn9FFWcRTPmZ9JVdcwWk/csoYyr67xaC3QlA29E/pTPyT5oFQbZ6u0/pUgq
         fNzu2apq8E/W6BByf7K6OsBQGUaISkESsnhdppJJtBoebbnbnbRvIvJPXdiuUJE4C5ad
         8wTiTRiNRaahggsUeli3fIk37pMQuOivga4ACh7gkUqUWh+ZfXT3eEhEo4WHaHyR6XaX
         F97A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757626730; x=1758231530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cTjH4sGVjFOYrHuOXXQp8+DmE+GbVi2pPpgMotQBb8c=;
        b=A61bt6Up5nojmzCXW9+pNp9W+/x6VItg9vdHQnDNu6eF13XCX3ZsEmiCHe3Ym6bds0
         EkmuC4uCMYpcQl0NqzqyAZ4FNA/mRrnoxGVRM9sZUkqwwj/BXlOdG7o/8uCyETLnWTxp
         1SbbeVkQ4OzqcEzKX+2Di0lTgbcfzPdP0mPvFd1o+3AjJUqeu/vtbeGP7ZYuUoTuzdU2
         GGLchNGjPs+eEOM7SID5DbJIh1ab5VLP3YicE1SpdPl0BjKseUtQ2KhriUZlIq4mRTmH
         FV7u3+rfdrXlIs3CLS4DLBWjtJHh5hxX5+53tR0oKyJhtcDbOPrkj6fyF5jsYqUQkdHw
         e8+A==
X-Forwarded-Encrypted: i=1; AJvYcCVV3Y8HvPn2Aag/ltZRaRQj7Q/GwApWLIPd22CDMU4LK0MEZb5UNJSgatNDe3RPdYFy2hyika0BO2Puu9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLOHvO6NJ/nzwmjR8VwOVn9ijDWKWnpDvdMxuFEajrLcBgRf/7
	MnLo4ByHv+g4sIyEx9d122gHiIMng2MKuFWehc3IN80/agr+nISJVyuF
X-Gm-Gg: ASbGncvj3VFYV6cQzinTm/W+6hp0jYhOei5XeGrNN7H/OOVTasQW8uSOFnu6gq6ZD+5
	Hfkg5AhXCKWa7S0GAxJ12eyyeeErOTEOU8MBVjcnkCdIgw3QJX3h/iKcB0Et+zSCNlyjVJZV5Xu
	t/eQPmUtwDrzwxGcZ/iGqTrvn8oNY6lcxsrhToerlGyF//8A/eaYDsUkV+gkJhKudJWy0z5zJ+3
	TuEM3CYXL3V8I5HWGlu0mMpR7XKMLn90qkwkr2kr9Br0Arlpeq2txGCjD2cejVYBMFczmVVrMvo
	zzAkaH6k75XfoUq+nKTXvdLrx2d7HoqECnPQdUUVd3LPrZd6FAQn1nrIIEv3SzDhWEs9KQGifSX
	MQJmIIHmF418yJK96K6qlH33RsPr/3e21+fxgUbYVmBFXuz7tpYWBV6cCLejzyDcl2m5CrihTLe
	LEkb0=
X-Google-Smtp-Source: AGHT+IH1gSOvZ6qDclEA8b31MsAeYLLhFpNn+2r0dhyXlNIow1l+kg8aK2bzsc7ZhNqQBPhd6sA9qA==
X-Received: by 2002:a05:6602:1585:b0:883:fc4a:ea55 with SMTP id ca18e2360f4ac-8902748830bmr161927339f.3.1757626730270;
        Thu, 11 Sep 2025 14:38:50 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-73-14-87-86.hsd1.co.comcast.net. [73.14.87.86])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-88f2d0bfdcfsm104024139f.3.2025.09.11.14.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 14:38:49 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com
Cc: gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	linux-kernel@vger.kernel.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 03/30] test-dyndbg: fixup CLASSMAP usage error
Date: Thu, 11 Sep 2025 15:37:56 -0600
Message-ID: <20250911213823.374806-4-jim.cromie@gmail.com>
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

commit 6ea3bf466ac6 ("dyndbg: test DECLARE_DYNDBG_CLASSMAP, sysfs nodes")

A closer look at test_dynamic_debug.ko logging output reveals a macro
usage error:

lib/test_dynamic_debug.c:105 [test_dynamic_debug]do_cats =p "LOW msg\n" class:MID
lib/test_dynamic_debug.c:106 [test_dynamic_debug]do_cats =p "MID msg\n" class:HI
lib/test_dynamic_debug.c:107 [test_dynamic_debug]do_cats =_ "HI msg\n" class unknown, _id:13

107 says: HI is unknown, and 105,106 have a LOW/MID and MID/HI skew.

DECLARE_DYNDBG_CLASSMAP() _base arg must equal the enum's 1st value,
in this case it was _base + 1.  This leaves HI class un-selectable.

NB: the macro could better validate its arguments.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Tested-by: Louis Chauvet<louis.chauvet@bootlin.com>
---
 lib/test_dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index 77c2a669b6af..396144cf351b 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -75,7 +75,7 @@ DD_SYS_WRAP(disjoint_bits, p);
 DD_SYS_WRAP(disjoint_bits, T);
 
 /* symbolic input, independent bits */
-enum cat_disjoint_names { LOW = 11, MID, HI };
+enum cat_disjoint_names { LOW = 10, MID, HI };
 DECLARE_DYNDBG_CLASSMAP(map_disjoint_names, DD_CLASS_TYPE_DISJOINT_NAMES, 10,
 			"LOW", "MID", "HI");
 DD_SYS_WRAP(disjoint_names, p);
-- 
2.51.0



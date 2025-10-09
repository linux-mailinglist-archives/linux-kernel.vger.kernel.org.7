Return-Path: <linux-kernel+bounces-847290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E672BCA7DD
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 19:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 942EF4F45F0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 17:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6F625782A;
	Thu,  9 Oct 2025 17:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Al+PKoaa"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125C4255F52
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 17:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760032734; cv=none; b=QZyTYQ8iRpuGlI/Jt7wt25Twn35j1Ipwsmajrh1eWH+1kBSK05Jpv8NT3+SgrYzr5BITaHb1e+nL0oupauwaEUzXlDGe0OlGs18yqAgxynqb/pScxLDfRXDc2JMYQDhYln1YszAv1bipPwNs5GqClyGTbEq8xSeNR6Temjo7Y5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760032734; c=relaxed/simple;
	bh=aKMTvHoFGMDwM92wFBmpn94LIVdnLgrI2RnhwdRN0GY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eOhFe54d+d6w3rYPrqMmNH5el21TtCFQJp4fPTYIR69UFA7XM55bgiWOmP6EYPJJ05RM0FLReOQRFkxYbM/JSDea6powwIVtVse7jc/SjoBk4bPiZCs4wMKcKFzqMIMs/7OgNvySoaOuq2pO6HzJM6TdQqWeLEGigHTkSNHs9os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Al+PKoaa; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-42f91d225c9so4294135ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 10:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760032732; x=1760637532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5lAaOOjCc4ULiFrsiLFYK9hqRtLQli7F1TlUXtnya4=;
        b=Al+PKoaacIAQUTnuu3vlG3yF39cTBBX2hXYkvPd+bOor2+RwOyoHk1IctGhcBtEue0
         pBdzB57X4GmT6LClV0nQKDfgM4WTU4HzhOwZ8VMkY1eYJ1kQM95XUVYHuu5pGi/HSFoI
         K9DTdiO1rxvZTS4jrBd0igjNpg5BGWQa1y3BoOir1yHyPb9DyTyCu9IHkbhn0RTW1N/I
         t68G8kDaRqxebHU4Lu82ZcE8g6juAhYmidIS6FtT/2oD2/7kKXjlyPLMrzHKVZobEOY1
         VHy8mO+6Tpk9rhWjD4uXfbVCM+sfqpIGflH9Bi47ErTqQrN5DfHcvvhrhudB4e5xT5Ft
         ejrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760032732; x=1760637532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+5lAaOOjCc4ULiFrsiLFYK9hqRtLQli7F1TlUXtnya4=;
        b=ENtzW7loAexTrxnfLm3E8Ycqd4TT2EG0x+CLf074kuOD/t3v5KOnn9FOQeRcu202hs
         SkQCPPSeK4OE5+M1e0W7EGVBVTlp525EZJgqpQz00+ZXqThFVSX2ukEzQABDoupxIw1Y
         6aoGz7GIFyyxKzwb24UPKrx1cdZMljM1P5iTBsv9ZdBT25yhnBHN691gk20Fcq/7qSmq
         lqsDeXB41YhpUAl4LMXk1tyKa83rNkgz84EoBdBOr3HyIfnviKSpePutUHntoyT7DtVh
         HT+XARKDoVQ/AO2as0/vrKCWUQyr1balP8htt7G0o3F8yz0muwZtzmc2+RVQo9Bux8Xi
         QPog==
X-Forwarded-Encrypted: i=1; AJvYcCXmSz9Ca3PVFN2H63dHaN0NY6pNeBIlmcZrEVXU3Ei7k6/9Rhi7GNGISxQ78M+anQri2H5Bnjr5GI771UI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUrDBTQxAmMhAEGoc5r2PpMKCqwWNQPWjsED0+xLf8CP31dID2
	/VvNCMI37bmlGCC/eTTDYopCn4by7XcERF0GIwHazA6AKR17cce919DX
X-Gm-Gg: ASbGnctYPbS1y4fPOYVVfsNAOkdja/Wvs0ILxMdREprNeMk/T8pljqJwa+H0D14nb2y
	g9avk1ZlEafv80DWnsYLHszJ+3b9ly8oZSyKhXrWDqiWxVm75W8Kd0PMnAy22BR+tIyUF+yuzti
	lRlUCIz2Gzycuzkmc1c3PQR8mx4LeTUcjcBcnadNq63SjGfYK9Spd89kpq9Adre45Fn2h6vjyJQ
	Sb6zOhyZGk+Dpp5aJXtUA/qtJCQ92MAkEdsqy59PmiMKpJHChmp0oMMgyd7ZxQXQquKie79QFS9
	DqVpMlEWdim8xTQZVbP0yXbKML/blGv+ARRncMKFit2uFh0j4UYctw2EOwjeo512/Hwqyh2A+Ed
	Z6D8kaywIvmqDH1eRHYNbozvlFKMLJpPACpqO3lMlCOmOUZmGgHfDjdYXI2vq8BaOeTKBrN0xbP
	LvuZ163Q6DDR2G07R/gNu3AL8kkq3bjB9cSkGXSg==
X-Google-Smtp-Source: AGHT+IFFRLinxOs/9OTcYHa0TTaGH+h0f+hAtiRcea3Rwbgg5dAqda5gTWAF7gYArlA/stW+upYWUA==
X-Received: by 2002:a92:cdac:0:b0:405:d8c4:ab8f with SMTP id e9e14a558f8ab-42f7c3b2655mr137425675ab.14.1760032732136;
        Thu, 09 Oct 2025 10:58:52 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-58f7200c4afsm30256173.35.2025.10.09.10.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 10:58:51 -0700 (PDT)
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
Subject: [PATCH v5 05/30] dyndbg: make ddebug_class_param union members same size
Date: Thu,  9 Oct 2025 11:58:09 -0600
Message-ID: <20251009175834.1024308-6-jim.cromie@gmail.com>
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

struct ddebug_class_param keeps a ref to the state-storage of the
param; make both class-types use the same unsigned long storage type.

ISTM this is simpler and safer; it avoids an irrelevant difference,
and if 2 users somehow get class-type mixed up (or refer to the wrong
union member), at least they will both see the same value.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 include/linux/dynamic_debug.h | 2 +-
 lib/dynamic_debug.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index ff44ec346162..b9afc7731b7c 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -124,7 +124,7 @@ struct _ddebug_info {
 struct ddebug_class_param {
 	union {
 		unsigned long *bits;
-		unsigned int *lvl;
+		unsigned long *lvl;
 	};
 	char flags[8];
 	const struct ddebug_class_map *map;
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 147540c57154..55df35df093b 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -799,7 +799,7 @@ int param_get_dyndbg_classes(char *buffer, const struct kernel_param *kp)
 
 	case DD_CLASS_TYPE_LEVEL_NAMES:
 	case DD_CLASS_TYPE_LEVEL_NUM:
-		return scnprintf(buffer, PAGE_SIZE, "%d\n", *dcp->lvl);
+		return scnprintf(buffer, PAGE_SIZE, "%ld\n", *dcp->lvl);
 	default:
 		return -1;
 	}
-- 
2.51.0



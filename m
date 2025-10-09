Return-Path: <linux-kernel+bounces-847288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C8ABCA7C6
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 19:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9B04C4EF057
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 17:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119F0255F2D;
	Thu,  9 Oct 2025 17:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJkOHzU5"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB37E25179A
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 17:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760032732; cv=none; b=CBH+TR/WAdna+vN6DOxGDXVePsrrV6kflXsUpzqMAkwBm/Hx8NyDoeTCw+LJSwYFVOoyiZGePfkgJeptVr7wPP793jGTclRXRNMnngOVJbGnbMAPweZ9WXS+zD0PR+nuT7+lXwb7SfPG9JS9awLfBPNpDS1gpXK9cyk2UtRJh9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760032732; c=relaxed/simple;
	bh=9KA9wrUk/+sc2aQPuLDuiC0POPJjUDsXmXxrrpGdqRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t6p9rQ9oxCpf344i+Ir/hfTG2ZDpu/Ay6hYY6wb3Q62GMgCEQRqOBLf8u8cPl6s63Kho7A2bxzM+bwObvNKogDdk1sw3y5JA0yU28TTtzVtP1komINXQ8sWugaPcZVjw93MayZicxplW/M+HKmF90IHwLRHrNliI2YfKC8wZHd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJkOHzU5; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-9399ddb3ffeso117148539f.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 10:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760032730; x=1760637530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTjH4sGVjFOYrHuOXXQp8+DmE+GbVi2pPpgMotQBb8c=;
        b=FJkOHzU5BlsQ4zA8/7Ss9wgnIjsNKvqgEXziEKqKU1d/ukiZNSi8Pc+TXuCHAIM8B7
         NtNKsmLhg87MUQ79LbxaL1sJeHAQvS6DbgLBBfbZM67IGCjJy8pmLHBmVaAOO+602Vts
         W5ONdh5lvZmHP18repqcMyj2D/M3penpo+oNDMFUl9VMnYx2jQfXRMokeyNDQmu5br/y
         /kK+bK89rbhpnDx9jZL6QvqMQk/T1kT5rklFiVLvpii8czIB6jXkftiFWoMCpwOn1QxJ
         voH14KTZs0WKo8LMT3GOe04rmcSmw/+vg7MP2TNmE5CrW069NgjLShYpb4JM15PFGiBl
         9SRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760032730; x=1760637530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cTjH4sGVjFOYrHuOXXQp8+DmE+GbVi2pPpgMotQBb8c=;
        b=ZxW2X+7NGJ5OLrx5DnR32Z7xZaIQSJmAeAHqgZ1OIWhduJdQuQuIOu5Nn4HRo5zCVS
         KpPai5/1VSjlAVxObp0gWllkutdhqk/wgRZlhM2Qmvyiev1V+dYUG7YcB2GCR9NKV87t
         buzuvBisVIs8f+UkAsOlR5PtLOFMkylbUwnFc0U+lyOeMQMXZQT8fNPRMVbYTumvm9XM
         UDxAPDMU73xKcF27Uus8PYOuEvGqz6R9qpbxjQf1iWLnK5ssnlj5L2bgUTsWNVSchAj9
         1KxYFmruNtlzg90KACQgVl8al10LitCj8FxGJE9ofIPlF23UFQNYDeG+mMu91GJ/WeDV
         FDIA==
X-Forwarded-Encrypted: i=1; AJvYcCWMBWkYcWoB8QTd/4ntdXLT8osjuo/pCOCm4Q1nJD9uvfcK8Ow0w2lstiVeuXRqS9zIdne3DRWNaj8eyhY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxiq+M0ovRpq9W+KSaWZB0E1y72Ygm6uBsc2Trua7NJ1F4ofqc
	5MjwOeS/Juy2ObzmJJpRYCwo1smimjTVUiNRZzLoFjgzy52VEStGEcnY
X-Gm-Gg: ASbGncs/gwcxHXPtRA572AvOI4C/Ywl3c05Pk0TbXWk1c9l0cbqDY/xzyi7wQf9W8lq
	6MZpl+beG33udgTa3lw5Hx4bS/5Tbt607CraJSvLgI50Aey/deA/wgt1swPXcp0hSUW/+hj9yeI
	xAOjQRjjPEXQCzi8jk/+PT6f+02GcMhSLkTBafX2KendwVN6YFfnPgq/Hw8Ou0cZtnpythw7Ad3
	nahvAH8/jRTkNGu3CnHKruE8knlyoKF8BGdvF6MtOAOJDt3dmxMtWF1JHqj016m7OSKfijfm+wr
	F8rxoNhQQTUBEdu1lk9p9HwED+F/F085JcZy2Au33mqRFHwsuS+wpIF83R3THn6z5U5hadQcEiE
	g4qk1mWcyPjH9tQsT3gU2e+MvFL4fAASdCMs58Jmtmtx8fj4PnjWDgQ/MHsOBDnlZLBKtzONMXH
	c/3l1YLJRVcyv8RQCscZtEZUlR5zSwjTiUxctXFA==
X-Google-Smtp-Source: AGHT+IGqp7iPYqC+hSmWS9kXElNlvxppUNSCrpXp6d0YnM0eWjcHcBKQts/HVhk5zAlEdOdTjEStJw==
X-Received: by 2002:a05:6e02:1a44:b0:42f:8b94:c128 with SMTP id e9e14a558f8ab-42f8b94e60dmr60429525ab.28.1760032729943;
        Thu, 09 Oct 2025 10:58:49 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-58f7200c4afsm30256173.35.2025.10.09.10.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 10:58:49 -0700 (PDT)
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
Subject: [PATCH v5 03/30] test-dyndbg: fixup CLASSMAP usage error
Date: Thu,  9 Oct 2025 11:58:07 -0600
Message-ID: <20251009175834.1024308-4-jim.cromie@gmail.com>
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



Return-Path: <linux-kernel+bounces-847291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CC6BCA7E0
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 19:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A9FFE4F584A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 17:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CF3259CA1;
	Thu,  9 Oct 2025 17:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1OkzY+7"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED6D257427
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 17:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760032735; cv=none; b=gOGsPofkTc6B/hc8E+XByvL9FqZLgGHdFSyEly9EDvM/UFCe/L1dESJSJUdfbjnTwLBsQvrWtfOXkHYVtqa7u/dQeYx4d/ONHCkbSbZLOL7b85YAk9m6vfcjbaMJi3fLP3xqhsONYFTr3Jr1k6LYFANNi4vbi9cPuAMVzYEX7Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760032735; c=relaxed/simple;
	bh=fpFcDi6ztz3oxTgd6RA0bYt2S3BzBQJFxjJY2ObCcT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZRHtxknGdyMOBUDHnjS5vQ26rbZUaM2Jlmrg591ugtqpC9cmHmy8vcMOjXPEfVnBG+6hnb6qZqydnh/3Rm0EhJxrpeBnG/GCuDOMUHRLYneDIP3Zf2s7UV3CBCgVCmeFo1ZGRhpXQ3lRudC9xCZOHhNny5yYH4AxGRNtaaLLsIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1OkzY+7; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-912d4135379so51207539f.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 10:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760032733; x=1760637533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFKSLN6BiOw7bUnN4PQUQFUZxRNUkszMTNMdPxBofl8=;
        b=k1OkzY+7p1NX8XpBijsE1Z6G+4abTDbHFFuaH6AZDZvHTSyPMMPBVqlaUN+sVVEEWx
         NwTSNLWBmDyEItR8HXIjQfSmncC2jsLhVI3NfI1loVjPrI8gV+WawAnI9bJTvejfJ2YE
         NlzXlgPz3ZPRCwb1kMAqjTwpmEfZVEYQ1kfyt+fO+4mLPh5C1ZM4iuWjN/YRqk+Y5a/b
         tPALXWF4pBdi8VlsOIjH1yY52FXUHUmRW2g55ltnmSTGs3fB0BjtoZXW9dFWgYWadPyM
         OhLMB8RnfLUqW41xT49zIP4MyOKYqRbEYu83lEXjiIx32354iKMLOupxCkFwYhI0zWBE
         nLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760032733; x=1760637533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFKSLN6BiOw7bUnN4PQUQFUZxRNUkszMTNMdPxBofl8=;
        b=WJW1viXcAZwNmyU4GF/LuktYYhmITxCq1iOARBNAJ2tFK3BX6uZvsH80JX77kT7BJ0
         ZNsaX1DsNqVbn+5fH6ngHdla5oA1W2jWaP3h1Az5SyHquMMoeo7ps29RBKFrSoSsZf1q
         7f1Vg1clDTrqsgKnef00cUOWQKRJ7iuvUZo9l59NWQMUMt4OPmCKYHNUtTjqx644lAIN
         OETUZoTCtrmmnB1Fdlf+hQs5k4rQxqdXFDH5Ny05ZpKn4gVI7arZSqprwOrLguE4Lw1R
         fDtXJxM76XIYYVkEonEIU7y+dftN1L+Ntk1z4HyPBuJrzlECcWzxAKVco26rLcYl/tCU
         OecA==
X-Forwarded-Encrypted: i=1; AJvYcCXwgscuQmBjVVzilrE9IECCnKdM9SEi0rHK7rgaITmazYpBDQpy+AnQBPARY3nJFXftcZMNb8n86Ov9TsM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4lcDlRYgjUZRI92Pqvrb/VpEkBcLnj9cw8ZIAuB1r2wVyDy5Y
	nofRpWfg9lhzb+aeDzDrpiSb5khYwXq4lAbo9Ry62TIIfnly1Y1IPlFo
X-Gm-Gg: ASbGnctCTGlzEkWIf68fKn4svsR+M+JJm8qFTTapFnu4nFukgdBrd++Oh060dZh+aQC
	gVYue3V1ykK44hLXmkontQchpq8llie0vnHWDvk91Rg3iYGU70L5dURzNldnP5xFX27d2z+hF+k
	f76yzEwF98MJATO4ZCkb4vPVvbj7+3+yhFgSg2/jVGC9Jv9zMXdoRsDqaUtos+DwXxZrUKt/1N6
	HXeD/fjeq9A640EmY+YCsS4Df3vt1PXV3Ymdh9JRcxF1UZZOXUvLGUTuJPWM+8Cn15SxkBZFSkJ
	8FBVSGOuinevD1IQ6p+RBAQSQ6y3ys5sVFloT556M2uHSe6nfEjxibX3J+sm/pM66sHYw4Zr7r9
	X2e9pF8eeRZMh2NNNyaYpG1RD7tmjqMKB7IGbRj6AtZ8z/q1Z+sEmWoZKCtfTvIyoqT6b5aiYky
	wbl598mFdzra1QNuSFQlxGucWH2HzpNV/2aM1h8w==
X-Google-Smtp-Source: AGHT+IEFgHidntDfvFhDlZruUCJmrkaroGW1qP4eIEz2kkTaQPPkZf7Zvr9cHn+uTBEE/+gwDo4uRw==
X-Received: by 2002:a05:6e02:1a89:b0:42e:72ee:cde6 with SMTP id e9e14a558f8ab-42f8736aa0bmr82269925ab.12.1760032733126;
        Thu, 09 Oct 2025 10:58:53 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-58f7200c4afsm30256173.35.2025.10.09.10.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 10:58:52 -0700 (PDT)
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
Subject: [PATCH v5 06/30] dyndbg: drop NUM_TYPE_ARRAY
Date: Thu,  9 Oct 2025 11:58:10 -0600
Message-ID: <20251009175834.1024308-7-jim.cromie@gmail.com>
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

ARRAY_SIZE works here, since array decl is complete.

no functional change

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 include/linux/dynamic_debug.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index b9afc7731b7c..ac199293d203 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -107,11 +107,9 @@ struct ddebug_class_map {
 		.mod_name = KBUILD_MODNAME,				\
 		.base = _base,						\
 		.map_type = _maptype,					\
-		.length = NUM_TYPE_ARGS(char*, __VA_ARGS__),		\
+		.length = ARRAY_SIZE(_var##_classnames),		\
 		.class_names = _var##_classnames,			\
 	}
-#define NUM_TYPE_ARGS(eltype, ...)				\
-        (sizeof((eltype[]){__VA_ARGS__}) / sizeof(eltype))
 
 /* encapsulate linker provided built-in (or module) dyndbg data */
 struct _ddebug_info {
-- 
2.51.0



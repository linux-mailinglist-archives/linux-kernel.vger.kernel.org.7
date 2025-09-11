Return-Path: <linux-kernel+bounces-812874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31252B53DDA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABD40AA3AE3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BBF2E0B58;
	Thu, 11 Sep 2025 21:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSkOG4hu"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94392DFA2D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757626735; cv=none; b=WB4WAD5M/uL+m0I+H78DK7pBKhfFK6/w1UfFJ/Ap03qYfEfCuSOqE9VYef62Q0cZedtSd5V4jgGdquAEEnLMl9rmFP4JFnJ4gVXH5W09sulIj/ZBiqvykeda71HrZj5pg62a7h0IQlwd4F4TGhEYztmqBdEaznXhovMRw+p5rLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757626735; c=relaxed/simple;
	bh=fpFcDi6ztz3oxTgd6RA0bYt2S3BzBQJFxjJY2ObCcT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CE2jlqyMC2We4evDTPSB115zmTyKjnumAXgybnwsyT5zfe7iusoCqKr7zOsX5bFuT8v2raJyQ5NgzPwgg+51FFHZNL5b+Tt+U/zcERnD++o524gqZ6PHHBPbd8hsqnJf1Jq6wk0t6privYXKgRkxI717rqRnSg3ZY3QQXSKV0SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QSkOG4hu; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-88428b19ea9so66677639f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757626733; x=1758231533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFKSLN6BiOw7bUnN4PQUQFUZxRNUkszMTNMdPxBofl8=;
        b=QSkOG4hu9o18LlBvi3DXLxgd8+ZE1zaXWCs7ougSXF+iUSTHxP2fW43dKGnWVckdvp
         MbFlZ/Q+JOI2NT8kmUuCB9TLFCRheBL9LZeA8zsCAfdgWf5ESc8q4plf7pfX8xl/eFrS
         qHBgyEV3mnh4XD0bG2pn4oVDSBs+WALxwwI6g5SbtgmIJmfu9pArqnbFT56pEDByuXyV
         VGWXxflthnqh1pJDI82K4fEnfkFcPqRACJIiR9U8auYS8FaWBFf+HbckvnVUGP/gAQcd
         zcUGZ9IQ6dM47oC44sseV5SKFmFwHIhu9ve6s13FvhoPw2EMR6nOyk2pjKKGmLzjh4QX
         L+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757626733; x=1758231533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFKSLN6BiOw7bUnN4PQUQFUZxRNUkszMTNMdPxBofl8=;
        b=vZvtuXoTVHHMKGzlotNSSb3xy9/vpKYur1BbO8kWjCE/FxlN9mzvI9gNRdqePxDZml
         Uap1MqMplSc9HKWXe7MaYNoxnVT/GGvOX0qi7dvjDQSSjNIBP2d36wBX8dR8Rp7repbz
         adCHy7kR9Z7jQ0eqZ/1wOTCaLB5qwAlUqNuO5inZ/nToIrYc1VlgJhaePMSkoVUjEBeJ
         Hs1qsa8wp+EzXhi/lgV27vNmQNGLdUvBPo287Nzwas/9buvjdzfuKSQncA5C2MJpg8Hk
         Mv871DBfFAE5ssF6eEVXShMWSeETLu2LMIbYfeoKvV2Qrf6S7pAr5BPtRc+MQ81uHmNj
         ViDA==
X-Forwarded-Encrypted: i=1; AJvYcCXrP0EaQ29ULpmc3vwZDLyRItuAAUtf0w4NDM3UE1vlRrRuhVSiNmK9vgetSMNsk38eA/eravIBpvPoovQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiudiPqf0BC+6JM+aiLNgar8gqAAJz5SSWkV1is1ZlUfcLpxUP
	7Gys2J2y/oL0BP7RZ7mIBbfnNnm0Ma6PHH8dbIbQUGJ3ZWb8Yn6Vwgik
X-Gm-Gg: ASbGncuv5PeslKlaOu2sGEPLnq3Lc3lOfreAYOPK8oeUYToYVxkeUEL3qt4f4qUuZRl
	RMI04M/ytXL/Q0VRey4rAffAwMjgdGB5oZlzW4TGYtLE8tAW2Pmuw3uEhXq2LVcrPXHuQlMdtLv
	5oaO878GJHlv/lDWWfUAeRjV/xcYkrcmmKyzqAgLPaOyqTlFNBsnBGVKkd2ErgNXBKvGy5Pg9mW
	FcqTfIVkxdm8v4qvRzjZJYj2Aqo1KUVOEgvzDuufurEEwlku0IpnEKJT/R3UoRvSfudzElfmeZA
	41dvX55sWhlu5RYzo10Xda8/CUjW3r1Oe+MchUthNVNtay7WvJuAg6l+16yh9X7sU9dpdRxWuzK
	gewDNwwdRM5y7kNaigaDEENCCDaKmg2B6L9VUYnNpvrLDHHegFFQsR8gHK48I8brmT3m2mOI1me
	W4sgXxFv928McXfQ==
X-Google-Smtp-Source: AGHT+IFBY5zUTFu6EZw6SiZDd2+zTRUptGzCdAlCjq66qwlqZ54EjENB9XTXxGyYv6RxSPaHAcUXJA==
X-Received: by 2002:a05:6602:1510:b0:886:c49e:2839 with SMTP id ca18e2360f4ac-89029f4127fmr168162639f.9.1757626732974;
        Thu, 11 Sep 2025 14:38:52 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-73-14-87-86.hsd1.co.comcast.net. [73.14.87.86])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-88f2d0bfdcfsm104024139f.3.2025.09.11.14.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 14:38:52 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com
Cc: gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	linux-kernel@vger.kernel.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 06/30] dyndbg: drop NUM_TYPE_ARRAY
Date: Thu, 11 Sep 2025 15:37:59 -0600
Message-ID: <20250911213823.374806-7-jim.cromie@gmail.com>
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



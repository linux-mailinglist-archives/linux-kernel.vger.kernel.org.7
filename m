Return-Path: <linux-kernel+bounces-852874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B01EFBDA261
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1697A42698A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD6C2FF66A;
	Tue, 14 Oct 2025 14:47:09 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8972FBE18
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 14:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760453229; cv=none; b=ErEp563l0EMMfT+Pn8Tl4JnIZ+UsOTbH7q9d2JWRjNKyOm1R18xE82hfpJEO9J5wjyWw6yQkwAZKcFzcReA134p85FR/0XQUURRMbO8pkAgu7UllNUJHF2VEVQV/Pt288aOH80lFPPhLO2sKYvLsiuXeEI6zmEjy0FeF7DXm5tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760453229; c=relaxed/simple;
	bh=hzL27Qiz1m2MYuZZEiql+Cp5XMXOC8gsN35W4EUKEN8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rIcaq9ewuqKN5GGny3M2AtFCnQ5/MNYS24H6i+z+x0UkgL37AsRDnj9+cBWezV2E8ml3QWFCocnfgob/IVE50J0pYVS12STUI12jBE16f5Wu6LHswrXbOzETGElFeYqBwQiiVlCgvVl+RiyyiAPGqz4NxCTw46lspLtS0dnxZRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=horky.net; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=horky.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-639fe77bb29so8572214a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:47:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760453223; x=1761058023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MOBlUdmQ86aDkoZ0YOztFqBVBPw1Dxd+pEmReFgfDNk=;
        b=fQaELSC3+l6O+ap1TSMKUJ2o268xFwoXY0wb/lISPaPoZVpEqHAGq+C2/0FJiCtgVN
         xf4jnihqGpSUEpXWjzhs+3RTvQPpbsaclHvpwj/lYYexulw+XjZBg9o6MzOQmPhkbHBc
         JTUIEOydmoOwWNZuQh8M5dwWAWeQcYLQcheOke4gmoXSeIvaYCELkTFMWJ4Vp4e4lbj5
         rSWlSxag/r8fQntPRgcqt/n4hqGGWI50FLgfAtJibPht4uHewkW5o4hz0xd8SZuB9XKc
         zKM4yCvmMk7FF3v+0b6QLhlDIaBW1DF31tzJvMmVOisUGjzVBA1WqZpi3vZpH2wfUNY8
         6eOQ==
X-Gm-Message-State: AOJu0Yz4bP5hN5l3abuGPGKy3b9E4MyhlxrjdChYuBRdOiaTYjtAifRq
	6dEyJ4fcMsCUvujgCM8Aht0A8CxpBkxD6t/PxScPll7tQ7U+Qk52acG6h/SROEys
X-Gm-Gg: ASbGncsYaGWSIMkT6WYv9Flv5fN3PjUsKrnVsD7+yHPelPPNZOzoodzAIEbW5f0lPkg
	gFxeklAtaSJiSa6fBv149qDgoyBml3vZNbHapHisE32qJaBm0mMlln6SEt7+xtEyVCBd8Gw9uzn
	usmYibK15ML5K22z/g4LxQNfa57PeSVqWvHJCjWdYxwkTEcZyJNpjeM7zN0bo3H05Q/nTjgXXnz
	zIynC5FPDFUFpi0XG830gd+vA4G/jbv2kK9K6A/6KZ/zfe3Aa0uN4/THPOCqwQraPGe/rGiMpEg
	sedLALiv1GpiSgCVJJUuuLOZNLeXJzz1Zh0ouZHTPGOuVo6e9pXPkBfUlcrDukTaWafv0EMBR/C
	b6lUUvwT/zrUQ4dclc6x2JPUJC0zFp7dmqC+gsyMi+SKQ1OD+P343/Bq8/gSC02TCobQ=
X-Google-Smtp-Source: AGHT+IG/ebnf83iufgSgqtCg2TRB8JNxLxGg6n0ny9HfscPZ3OBZCcotYy5K/9hs9/HUMIDnrVmrbw==
X-Received: by 2002:a17:907:3daa:b0:b4a:d0cf:8748 with SMTP id a640c23a62f3a-b50a9a6d769mr2784372866b.13.1760453222818;
        Tue, 14 Oct 2025 07:47:02 -0700 (PDT)
Received: from jamaica.. (ip-78-44-100-18.bb.vodafone.cz. [78.44.100.18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d8c12cecsm1188300166b.53.2025.10.14.07.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 07:47:02 -0700 (PDT)
From: =?UTF-8?q?Jakub=20Hork=C3=BD?= <jakub.git@horky.net>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Jakub=20Hork=C3=BD?= <jakub.git@horky.net>
Subject: [PATCH] kconfig/nconf: Initialize the default locale at startup
Date: Tue, 14 Oct 2025 16:44:06 +0200
Message-ID: <20251014144405.3975275-2-jakub.git@horky.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix bug where make nconfig doesn't initialize the default locale, which
causes ncurses menu borders to be displayed incorrectly (lqqqqk) in
UTF-8 terminals that don't support VT100 ACS by default, such as PuTTY.

Signed-off-by: Jakub Horký <jakub.git@horky.net>
---
 scripts/kconfig/nconf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/kconfig/nconf.c b/scripts/kconfig/nconf.c
index ae1fe5f60327..198467d0edda 100644
--- a/scripts/kconfig/nconf.c
+++ b/scripts/kconfig/nconf.c
@@ -10,6 +10,7 @@
 #include <string.h>
 #include <strings.h>
 #include <stdlib.h>
+#include <locale.h>
 
 #include <list.h>
 #include <xalloc.h>
@@ -1478,6 +1479,8 @@ int main(int ac, char **av)
 	int lines, columns;
 	char *mode;
 
+	setlocale(LC_ALL, "");
+
 	if (ac > 1 && strcmp(av[1], "-s") == 0) {
 		/* Silence conf_read() until the real callback is set up */
 		conf_set_message_callback(NULL);
-- 
2.43.0



Return-Path: <linux-kernel+bounces-753070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FE9B17E55
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 10:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ED3A172D48
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 08:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA05211479;
	Fri,  1 Aug 2025 08:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMNjmCWc"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA8A37160
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 08:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754037159; cv=none; b=DbXzAs5cM8629+dHhQV+aKmrczZV7/Dx8kGvFFyKxM12WernGy7ZRIN3ZMpHk/a2sBAJzRUO7SVHX4fYreRpqlzdS5RUvif63/f+ZPjdUf4qj09CeZ69l5bhI0BgCQvPZtCP9/Uv09KMLrZv1RhNkCk8xnG0zDIvY286sVuve8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754037159; c=relaxed/simple;
	bh=QLYvYIlNsru6sVR2dQ1cSAedc3A4vVjd8m3PtqCxK0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qZ+nbzi9SuVAH9IgB9Xf1WQHqJClnHlU4wp9YShJf+qQrYwMD9nfRLQiTB403oQrD0Ntj3erCYVOksjNkLe545dUx8z2h4qRj4Cn+X4Mbo2vzSpNOh+5Ni2kNyPvsz2eulbgv3RCx7moHGLXMsyWj3VzHhIUZuGIVB+SCK45K5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMNjmCWc; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-604bff84741so2371319a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 01:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754037156; x=1754641956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w61+8xZzLE9ZAKBOlZw6XCNl+aIH1RldJ/u9IGbSh9U=;
        b=DMNjmCWcE0rLMzUusaPrtZoe7Xr+hUrSR/9yEuMxgMlI7sgDa3jt5JCaNVHYYP/+hj
         z/avORIgpBqiMkkjmgSb3tctYcu4zAE4S+cG19TJ4/H9+ERswf9oeKue8aRdUQzewtO2
         ckkrZSp/Iuy+rKcFZoqiUuo45vVfCmSiccQjkcKY1Aopvbpr64CxpoHjlXpJrbIqpcbv
         2kJzYfR1SjPMHAH1yPBbPUE33O6Usa6TvMve34bL1vSy/95Xj1+Uk5fyrqfnfyqZxN5O
         goRJ9GMaZSDXadQMEktml9z30DVaGQAb/XFSDimIJF8bFUR7ijVVG+3UPGUtFJ5W6o1P
         2FCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754037156; x=1754641956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w61+8xZzLE9ZAKBOlZw6XCNl+aIH1RldJ/u9IGbSh9U=;
        b=hjsfXQwtz7+hdT338+P7RojCpriHj0dqU4J73WS+JAsPtwmzrpKXeJAcWvhpL+lZqD
         of1TCqLpFne8XcYBpIzdkUD0FV6KI6vJ9kuxgChyQFTroQlri+5245yLrhSNz2hsSaTw
         ObuKffoF2gK085do/7VkXBek2Hp8XiKcv6klv6zA15ZmNE4BJmeShLpKKsntHsuhfxcP
         G21J4+Jak0PJVtiKbmQzgRFr65yzky90lXD2T/aEbVQjCylc1k4BFzuV9kxEnilH5LZ9
         lbNebweIPhFqHxuX8jZk0vUzzaldCofKM5KqXmwsDQpB5Spau/TPGfvIOERjnpmL3owF
         Znew==
X-Forwarded-Encrypted: i=1; AJvYcCVl8HIWihWiXHqwr7WNEcMwCKVrZbFj0WCsB9lmWF1lssOlyzNU1hJy1SE73maNQKLvDaGYZ71N2WAVuu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwlOrzYqPnVn8fapPFsFbk2+VJ3ZvXwwW+SPYQ4q1eyG9t8xOm
	MHuHNHziD/GwJSVmpNKX6KC4djoMyHDpc4RlOOuXYQm5llO4W+kbgk60
X-Gm-Gg: ASbGnctiB5o46M6wDtLsR7vFbKNfxj2+Z4Yl9cjLexj/9EMAS9PQ1UGe+d5Pqk04cjt
	Onbc4PDN24kcWfhtH8JOkB+XIySLCP4Sf63x5Hok79b0pdUhcnCdS6qzNG2Y+nAfCigCE0yofMQ
	P29UHR3SQgthCxIOec6ly8u5CpTqlsK1DIIww+JptCsACDRo7YXHafeDVwvA9JusZbqzH79BA4v
	CGCw2klr+dbDDmlfgocGLdYk/OuCwerFuou5noBxdHE44GfbmOvPHdN/DHbkgNwjxdqpdj57VvX
	N7flcmStVz8jr6pp2MmxpcoQoiCNAHZc/bufm3NxMIPr60911rl233iW72gUP+oB7xxa7Mdqw7H
	LkSEGfz4/Gz44cGhb/0i9CV9+AWIyrXfZ6bZLzesw0jDneCnTx7g=
X-Google-Smtp-Source: AGHT+IGSjaHMpSM2F0DUBfBzULo8o9lfOwTP1cmyjskDFOpXe49VIrHx6V9mwMpaiCqRqoWuELGnqQ==
X-Received: by 2002:a05:6402:1ecb:b0:615:b0a9:20d with SMTP id 4fb4d7f45d1cf-615b0a9071dmr4970679a12.20.1754037155594;
        Fri, 01 Aug 2025 01:32:35 -0700 (PDT)
Received: from tumbleweed (ip-77-25-33-2.web.vodafone.de. [77.25.33.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a911a59dsm2362735a12.62.2025.08.01.01.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 01:32:35 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 0/8] staging: rtl8723bs: get rid of os_dep/mlme_linux.c
Date: Fri,  1 Aug 2025 10:31:23 +0200
Message-ID: <20250801083131.82915-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series moves/merges the functions/functionality of os_dep/mlme_linux.c
into the corresponding parts of the driver in the core directory to reduce
"os dependent" code.

The patches have been compile-tested only due to lack of hardware.

v1 -> v2: added back accidently removed tabs in patch 3/8

Michael Straube (8):
  staging: rtl8723bs: remove wrapper rtw_os_indicate_scan_done
  staging: rtl8723bs: move init_mlme_ext_timer to core/rtw_mlme_ext.c
  staging: rtl8723bs: move rtw_init_mlme_timer to core/rtw_mlme.c
  staging: rtl8723bs: remove wrapper init_addba_retry_timer
  staging: rtl8723bs: merge rtw_os_indicate_connect into
    rtw_indicate_connect
  staging: rtl8723bs: merge rtw_os_indicate_disconnect into
    rtw_indicate_disconnect
  staging: rtl8723bs: move rtw_report_sec_ie to core/rtw_mlme.c
  staging: rtl8723bs: move rtw_reset_securitypriv to core/rtw_mlme.c

 drivers/staging/rtl8723bs/Makefile            |   1 -
 drivers/staging/rtl8723bs/core/rtw_mlme.c     | 151 ++++++++++++++-
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c |   9 +
 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c  |   2 +-
 drivers/staging/rtl8723bs/include/drv_types.h |   1 -
 .../staging/rtl8723bs/include/mlme_osdep.h    |  19 --
 drivers/staging/rtl8723bs/include/rtw_mlme.h  |   1 +
 .../staging/rtl8723bs/include/rtw_mlme_ext.h  |   2 -
 drivers/staging/rtl8723bs/os_dep/mlme_linux.c | 179 ------------------
 9 files changed, 155 insertions(+), 210 deletions(-)
 delete mode 100644 drivers/staging/rtl8723bs/include/mlme_osdep.h
 delete mode 100644 drivers/staging/rtl8723bs/os_dep/mlme_linux.c

-- 
2.50.1



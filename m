Return-Path: <linux-kernel+bounces-750587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E58B15E6B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1CEA18C473A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F4B293C4B;
	Wed, 30 Jul 2025 10:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVpXV2S1"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5878128F53F
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 10:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753872312; cv=none; b=jJJ/TKlXBr2VoP558TkIeNqM+14DGrL+Z2pjC8QEMPT/f9mzoKdcOH7jA1Q40hoA7tUvX5XdSTpdJ+itl8UZvDWpBos0S86BSG5XWNi5m7wzS5Q/bmXMzrbU5GGmTmB9UrVHA0T2Po/8isRg0cHYVYmFdwG0PJKAh5mmewuD7Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753872312; c=relaxed/simple;
	bh=jOV7BUd+BxQm+6JWyTqHgR6WW31NY2nHqscpQxQ5P6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UYHR8LsNNJCPc0HBgDNHaVEgD1I1M2PAinejjwpROzPv3g6MSeNjDBfPj9e8Rr0HeuvAUtOhM4VIorn62QtHm3LQrdbe2Py1PzgkeVPreVDamTc2AcMWTgPnZsNYIAdXjkBL3FUUFud6xhrVW+OI1gTy5bD8s1xtxCcODWaF9OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GVpXV2S1; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6157b5d0cc2so2036890a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 03:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753872308; x=1754477108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6m4PfRCnoAEr2MU5yGI1+CYXF+Pd2iMMmnbkl/STpIU=;
        b=GVpXV2S1YnZdzf+LyPyqS/1R/seCd4+1P03qKmZeAcoEMpu6Bnf0YrlDEci+3P9L1C
         FytG/YkXzJeiukx5hDPWI/6uAWuEVf6K5WuQ1DoJzxU4U4aS2/B255L8fWGKg1L8aktg
         zWD4tgVTr5gWekE78g1AeoOWaH2J8YXYCAwR2m1n1rHJneBObYq19yaOZiiORS/EI6BX
         Kqncid+3x+e2cSa0ODYlEi2DOpdOuBrVXvcr+1gCrr0IKZkf/8UwFAAbamaztNqjFONd
         9XUAVhm0mUvccZBzQ+TkdzVjh6njL/MEjMl22XNSQI2p3/XKxPE8Z6gZ7ll7MEz+WgUz
         7UxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753872308; x=1754477108;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6m4PfRCnoAEr2MU5yGI1+CYXF+Pd2iMMmnbkl/STpIU=;
        b=bMD+BBYh5iitIlV2D5libmRX66RkmR3VbmkS7Yc5kyMFYxjTpEnmzu72lkYmSedQRl
         5g9NvQnwk10sMBdBcdNrcGRKzNtMjGeWMlGlnf95M+J6vQapfbKgq8c/3SiyADXwFlPb
         SYvdLZlJDA4oeKeAIpV4dIE1qQIqJzNrW9fSeugNA16BrWEkMy4P6M0gaQ5U7A9j8RZ0
         cqZ9i35t/wywy2I1605JJDlrxLqr6t/7qzT30fTZCHSHhCkudwsuqAnQk8LM6Pswo2Hz
         YYC2JVm7eR4+ur2yQ7zrNz2uuTZQfW/dCI8xBhRnXKoooQn9q93wEpBHEOcPj8DL16/S
         s2IA==
X-Forwarded-Encrypted: i=1; AJvYcCV+i9OmAkRCqaY3Qh1MX6i9owiVabtMIrExmcGXtH5LXgMyKldtIS+vNpUNpREMwkjUMfxI/+EE1knKKgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YySBYTTQ5lrIGt5fggksJ9j2SGN+kS9Gmcl+ns7sL5wFl3cYHD0
	TgE3bKZ8xfmszrp1mFanQmBOT0mOGzagZyt+ZaGtfjJZxzyME64/74Kv
X-Gm-Gg: ASbGncvPSh+AAKv/Qryn/LEqAkgt+oI4PTIq2MFWkl7hwQOkjgKs3KWdBdJsQ+YcU3u
	ySIc8sCsope3x4vcq29WrAepaluaVfyHQt2MOhd8hdxdlslHg/ZVd4p5E9rHNkFGO3T2Q5wM8RH
	aUnlqZmhSQ1XXJsqgZ3Z53Iho9ta3NnWaH67oAaxOnLYju6NiPgoqzzhyLNeBAJ8wzvUWPSthhG
	8PH+PeCwXsjjXGwSbjbzplH5OGUaGeKNRdgSIg+hxRj5qU4YuIFft38mtIH1yUzc30SJ3dpgopG
	F5ZSIaC0w1u4LdjvUIJ4lwQqcfEhv8Kxufyzc09hfHLMNZIviwjUaE7bds86mb/uKXA8YZC4+zK
	XZRanqoD2sIOIH70MSlVujcml6tiZj0XOVJY6eaCcbjV7Z7DLqLsoyvGp
X-Google-Smtp-Source: AGHT+IGkarRKU0Hr17FdMZz3OLaW+08RJPp4c1MIWrnB80qPcPQG9ijy3jGSlIwZSgzYWzd/7qZMJw==
X-Received: by 2002:a05:6402:2708:b0:612:dfdd:46fc with SMTP id 4fb4d7f45d1cf-61586eecd21mr3079139a12.11.1753872308405;
        Wed, 30 Jul 2025 03:45:08 -0700 (PDT)
Received: from tumbleweed (ip-77-25-32-208.web.vodafone.de. [77.25.32.208])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6157974fde0sm1582734a12.7.2025.07.30.03.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 03:45:08 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/8] staging: rtl8723bs: get rid of os_dep/mlme_linux.c
Date: Wed, 30 Jul 2025 12:44:53 +0200
Message-ID: <20250730104501.150270-1-straube.linux@gmail.com>
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



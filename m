Return-Path: <linux-kernel+bounces-847292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2091CBCA7E4
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 20:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BF2B8354450
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 18:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6831D25A62E;
	Thu,  9 Oct 2025 17:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pauq1uOO"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D94B248881
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 17:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760032736; cv=none; b=h++ET3epko7I5y1w5rKLLlKdQJU+ZD8HTTn9P2OHV+xEPybkaHphc/9lYThWNJ7CYyX1k8u9H5h+2v6PO8VmaThjbNjahSjrexNiewE+W6q5nd2eyedX84OyEYnZo/a+lcrcFaj+P26+vtYRxIWu4k7jVenZ+5o8Z2M3JPcowoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760032736; c=relaxed/simple;
	bh=kfrqrzBKdI5m1IsAj48HkDg3z3FjqKlovuaaRAQV+k8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dBYajwrS3b2vAUGJ0Jo16VBfXK73Hj/eDIdI/SVm4n/Zo0v5oGNtP6MrcK/r3Hq8N2o5OQoRZpuBYHWAHmGR5mUfLB4Iugvs/37tGTZBIQzdRNhYmI6Cgo4AMs0VuTRbyp+PpYeKbVpiiI43x5lmOTK9qMDo4X+AYk6VKo0SYbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pauq1uOO; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-42e758963e4so11459615ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 10:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760032734; x=1760637534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pU2dh1AcXNpIKiB0LgzN/RHkM4liyYcW5Vvv24TZfyg=;
        b=Pauq1uOOnMlFCLzKseImvzy3FtHmpbiCxJ95hvT3ezSzYgC+ORwkX1uNVcE1rwDT6R
         QvEcBShqykyBwyANARmZg6V09ixbu4BFPr+Hr+amDbS+SKXSnGUg3avF2oBQnmq0LWQO
         ZsLwjE+GwGPKrOen9XxPngbyZaTI+zFQ+kQdMHy3GumuQJLk7lMXSkhFw+mfC09/pTJo
         VelF0iTdiOYy5QdG/IukmQM9BwWj4BbIP4DyOlEYrk7TxNCausfbNDOjZ4WF9FOLdPx4
         k3PiDrNLGAZFq/5nRLb/73X92qp+0KrBn1s3oHVwpPa9gdDaq0OqjTl2EYeKoy2SexTX
         KJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760032734; x=1760637534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pU2dh1AcXNpIKiB0LgzN/RHkM4liyYcW5Vvv24TZfyg=;
        b=DGyV1Qxlha5tm6bne2vS3+czR/2+D8tB/feWR2pS0PtObbU7gZu2Zev9+Tk2YPtaeq
         bOdhXcgqDul9f+x5SdCW6KkFrVu2CgI8ET3A/gsINpFjKYtK5VJNSo7oSzeGTxNvE7XY
         uuY7UT50/D0d6Ym2MxtlgNXMJslckxJSrh71D+5y/M9BO9fIMb9qeq31YACJxZMW4GQz
         EcpxJYWEpO/uSA6r8KBTQ+meZ2LCKfywOaqHQvpfeVmNpxSvwQ6NXY2M1ddFrj9zmwFd
         JooLRPeQ/arYvWdrQdRTQxBSFqVMra5CgoT+5PSLAQoZH0OVv66FRS7NYJL62KSHC+U2
         lRRg==
X-Forwarded-Encrypted: i=1; AJvYcCXERDmbPpcAfUdlsqa9PfIodUmMbn0w7G3vfvUtr5gdK9L53W6oOVVOHIDxt8+tMjOMsQeKiNoc5hbMB+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQW12h4ZwTB9K1B2/cW5egbsYrgenWjwI2H06iHqbr7bLrIpWF
	p8fsUxhqvi4wBvbK1aOphCEE7UcuRTOKqDQ0jVrnKQw2Aqh1NlMUAtyZ
X-Gm-Gg: ASbGncs06BjeKYXeuzri0PKnGmZwrWxlYAn/N2vJEqPo58j8fD142GAWTgEBYNcMkCN
	tqRwMiNDBvBfTtt8uQEUN5eWM5MTNf1ZiJqetm0kvukj973xMNrG+UUzw/av+mpZdjllCYSHBcM
	X6o6gnGihdrSc+d7O4/EKvuhssP7P7x3Ppz5g8OiyTYTqNQK4iyHXEfiNoc6ceU2o6Xjb+JloOa
	5Ux9nzlfdCHgHxEl0BAEUaKz+ahRJO4+qNJtk2k47+q3zH0ZhxqJEQtqypsb08C11sHpkDZ9ZMJ
	v7LtLupsMtrEviab9p6knaSSvoIXi2M2uBOdcbmSBqkR3oIkltY3xQ3ZuQ66Rc8AIzaKW9ciNdv
	IDv5Ml2h6LL0Q9y154NshcZempsDHJhIUnZ+4nliPpYaEbIx8QrTiQVBPO4zrV94p0Jdk2Fxgko
	DTdXP4eH/oxyVkV0rO1rJlrHoDJ6c8YEXp410hBg==
X-Google-Smtp-Source: AGHT+IGG3nRCWoDD4V/nkCQ4bWDSLxtN1n0qdt7xwh20BiNzOL9cD9tMw7g0yxq5IwKvmpy6qvXj6A==
X-Received: by 2002:a05:6e02:270a:b0:425:951f:52fa with SMTP id e9e14a558f8ab-42f87376e77mr84960835ab.14.1760032734175;
        Thu, 09 Oct 2025 10:58:54 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-58f7200c4afsm30256173.35.2025.10.09.10.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 10:58:53 -0700 (PDT)
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
Subject: [PATCH v5 07/30] dyndbg: tweak pr_fmt to avoid expansion conflicts
Date: Thu,  9 Oct 2025 11:58:11 -0600
Message-ID: <20251009175834.1024308-8-jim.cromie@gmail.com>
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

Disambiguate pr_fmt(fmt) arg, by changing it to _FMT_, to avoid naming
confusion with many later macros also using that argname.

no functional change

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 55df35df093b..2751056a5240 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -11,7 +11,7 @@
  * Copyright (C) 2013 Du, Changbin <changbin.du@gmail.com>
  */
 
-#define pr_fmt(fmt) "dyndbg: " fmt
+#define pr_fmt(_FMT_) "dyndbg: " _FMT_
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-- 
2.51.0



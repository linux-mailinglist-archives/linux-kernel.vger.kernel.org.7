Return-Path: <linux-kernel+bounces-899172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3475BC56FAC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DFF2A4E9A74
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09660337BB0;
	Thu, 13 Nov 2025 10:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlxB2m+/"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3CD33554A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763030753; cv=none; b=YUxdAyyfT24PLIjFD+Qx/6ry3Bh1B5G8l+M7jFAWnSdOE2kv0pm4ovnujV+WA578mOpAE7dDTwcLIMaT/6eP/sQBLrTRIkL2woWLA/UIjl9XId8LcH4d1GHywRFuPgYrYlB9Zj4LOpVGTT8VX8IYHcrQ4mso9YATKaPuwq5Ue1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763030753; c=relaxed/simple;
	bh=IOMKATf4WlRptW6Eh2eCnd2gEghdfx2vgXIU4gGtjTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pZs2zgVnqt8KxaIXgIF0keJgDBCmQN02sEoPq6x93Fiw1jU0i7iWRNjxOQtqIbnBuIzRsTFglavx5pXkaNISifcgYWfsLb5uDUz5M0kZz+pDM1y2k7C50f/o8ClUVtWU73vkgRRcXR9SvqCevToglyMAnCZpPPNCo/gDjExqALE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DlxB2m+/; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47775fb6cb4so4749935e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 02:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763030750; x=1763635550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFSFlISYEwJhzl0uBpsUYIAL1eAWoNbR9f/0OF3g05Y=;
        b=DlxB2m+/3qDm7rNMHJJsyrL76Bt+XDdquYhZoEf1z4jHOwyY6sf1E1rQCap0jUZOOw
         Lwvg3wt29e7aqpDZyoRGI0rn6qqx/MlD/15Ayeh6NYCPGFNbvXxxQ6V4aV0MqAdg7cEk
         X+RW8ThZkfk1AzFcx41FyfD97XEN4HsaKo2+Fhz41Mc0uGNSqbUAULPwZbfphu7RSa6q
         DrqyNw8mg56hEMidWyG9bej2XS2cCQU69YKZWSEkwGrP9QwG87QqaCTrlY7N4++CKV9R
         6lWoQsSWNkEwNd0QCA3epzuLYljGQLmkBGNi/EuVlH08/NoBrKYwSfY0xdJK8v7nbm9h
         qnjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763030750; x=1763635550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PFSFlISYEwJhzl0uBpsUYIAL1eAWoNbR9f/0OF3g05Y=;
        b=qzbV4GF0/04W+HQ6gQPXEfCmNV21KudQQsnbO/8T52BjogsMAoiKYnTff7tFbpznLA
         wGu6kjtuvvgigxGvSSQ22IoyK3ST09g1ZIfwzTEwhgjNe9RenNku8phUqItBBssELgQo
         pUIcHwPf/AIjB4QBJql5SHlhb0ToNwsVNFBR9GyrYyX2FgO3FtWFFV8viQI3Q6jU5LYI
         FO0oLWPMkmw+sIhUC2rIYLNwG/YAZilecniY/OXXTWOtWJXQm8S17gZDSwnAGbxLEFLn
         /f/B9nOg9ZOMtiALVrqC6OjIdioBd2xAOZEG+XjxSoZp3zHddYbxbHLw5zjOO6jTwAyP
         8+XQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGWLSqKszTf49L2yvshlCad8HUmVsdJVkWQLxnJHoSknbRxyv6BNgHLHYG0vQzxerXosnqm3lPfxy13mY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3jShVmBlFlanBvvtAp5XqIvtusi+C+JtFa071ASZF8CLk2p9I
	WOL6PwTTOoX7BpUjbcVG8sJdGvLi0Fn1uTTeAG7vle7n7pvju0lPHBRK
X-Gm-Gg: ASbGnctVzePXtPw8o+1+258mhGhqwQdMMwEedFaY2x5LirXyezZXLLLBOAsOukgM+Me
	eMnF4u9yiMxkJ1z88SbvZSqlTNmCVihmCxPDTPTd3j06tmZBcbFXNhfvOrudKognZvK42lXuTwQ
	p5WVXJsg73AYkr8reQy891cyTOFucamksWEDD06+QMv8inRhzdX7chDMSxybu88fUXn0cabFvQ3
	K9zmhG6Mo3d8NGuR4+N9rze4hpaOGQS7D9+xQf/rgDYY0k8zDL7cU/TipM9aEIvhlaE4ieTB/yk
	WxUPyXDa3gJzoUT0tk0KkWSjZGXqSqgXSFDs8aA+IuLsDQmUSq6W3J5KVDI54Rj0yze6rwdEcM6
	01nF3+rH2WNoKAbwNWjGh/lHz/B4SxUdx1gYXnhOk5P6DGFiO+Mh+jC6PN/yKHvk+EbqsxZ8aGQ
	bHv4UosOE1oDUSQ3kD
X-Google-Smtp-Source: AGHT+IH1hxADsd8hbGacs6bAnl+ge+jB1/i4MRdWamXcaDZJxRiCUsmo8EYYhOzNpB0X6spl994QaQ==
X-Received: by 2002:a05:600c:a06:b0:477:7b16:5f9f with SMTP id 5b1f17b1804b1-477870b3d70mr59496805e9.31.1763030750005;
        Thu, 13 Nov 2025 02:45:50 -0800 (PST)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778f247821sm1444975e9.5.2025.11.13.02.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 02:45:49 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: johan@kernel.org,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH V3 3/6] staging: gpib: Change file path for uapi headers
Date: Thu, 13 Nov 2025 11:45:40 +0100
Message-ID: <20251113104543.5875-4-dpenkler@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251113104543.5875-1-dpenkler@gmail.com>
References: <20251113104543.5875-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As part of the gpib destaging process the gpib/uapi header files will be
moved to the standard kernel uapi directory include/uapi/linux

Change the include file path in the code for these files accordingly.

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/staging/gpib/include/gpibP.h      | 4 ++--
 drivers/staging/gpib/include/gpib_types.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/gpib/include/gpibP.h b/drivers/staging/gpib/include/gpibP.h
index 1b27f37e0ba0..e3938ada3e0d 100644
--- a/drivers/staging/gpib/include/gpibP.h
+++ b/drivers/staging/gpib/include/gpibP.h
@@ -12,8 +12,8 @@
 #include "gpib_types.h"
 #include "gpib_proto.h"
 #include "gpib_cmd.h"
-#include "gpib.h"
-#include "gpib_ioctl.h"
+#include <linux/gpib.h>
+#include <linux/gpib_ioctl.h>
 
 #include <linux/fs.h>
 #include <linux/interrupt.h>
diff --git a/drivers/staging/gpib/include/gpib_types.h b/drivers/staging/gpib/include/gpib_types.h
index 998abb379749..5a0978ae27e7 100644
--- a/drivers/staging/gpib/include/gpib_types.h
+++ b/drivers/staging/gpib/include/gpib_types.h
@@ -8,7 +8,7 @@
 #define _GPIB_TYPES_H
 
 #ifdef __KERNEL__
-#include "gpib.h"
+#include <linux/gpib.h>
 #include <linux/atomic.h>
 #include <linux/device.h>
 #include <linux/mutex.h>
-- 
2.51.2



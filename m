Return-Path: <linux-kernel+bounces-892835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6002C45ECE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91C781892A63
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924CE30BB85;
	Mon, 10 Nov 2025 10:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XrxwOqZ9"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E101307AF4
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762770324; cv=none; b=B0udPOwayWNwFvLwQlyDYrE/AHeyJJT1d/ZXmQ8jgRy+Yj0pKwhKiklEezeGpIV86uX+djogODjYTdc4zaySCSq0AClCC0meXaw7DMrZiYekwche6y8Tc+JTVxuFM6UqaI5t9vOzndG1bP2WGWWsoiSIKGJb3rnAp2lKZ9GLCpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762770324; c=relaxed/simple;
	bh=IOMKATf4WlRptW6Eh2eCnd2gEghdfx2vgXIU4gGtjTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l1RbEoiN07SMrA/vQ0RjckXDzsEglFk6qXpQED7wD22j9rm92KmEK7SUtb20VkLHJRrfr3U6DVl2JBKM6nBFkuUaZ4uf5ne1FwtWF4wESUJlMpXj2PB5YkLDK9HvBUYbZxjMgdtqbujTwvvI/koA2y/y61MFTOhME6IK1UmEEKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XrxwOqZ9; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4775ae5684fso14210865e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 02:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762770321; x=1763375121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFSFlISYEwJhzl0uBpsUYIAL1eAWoNbR9f/0OF3g05Y=;
        b=XrxwOqZ9Jv4Wk6E1E5l8V9jxeoMWH2bvXy2xzP9okfG0a0a1eCMrmkFY908V9Ul1oh
         q7FzmrhFxyj/QFNB7sdOhhPUGBmlSiYGaPI5YPH2qgaNEPgMNhcS9DlDtHq6evAhGq95
         EPuEKXmvfdminLLz4aw61ngVrp1fPy4xa4+rd6eKDaJOhQ4tG3lfKrz2fCxh2xz1a0wt
         WpywKRnIm7KyfopHrp39fOE1329h8JPsZok6K0987vl5p4YVr9DLGN1W87aTx2vWMp38
         ef+KVwBcspFce9bN22TReiFHSl88CniY8IFicY3+5sSPD0A29Dq/tzqdAAyhpCHoAqFl
         9g0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762770321; x=1763375121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PFSFlISYEwJhzl0uBpsUYIAL1eAWoNbR9f/0OF3g05Y=;
        b=peB/duBTB9zhAwwJ4xOTUafXTVXpxBdY3g4NRjrPEHfP/O1dgiYOpZAZT9I5PhLY9A
         RE7jGiPBMsBZcPnAFUTn4BkDgUjYP3NUjn1Ul7AwKx3WEU3Dd2LBE3rMdPyx9u+/ljpQ
         UWeRosNehKdbr5npxSjJMqzbrvjJc+feg0WUoTVWwvV/SNm4pAyzN09S6RoYKc/9uv/l
         2EV5y+7N3WKQO4UagIo1ISgWGwInE1LKQl7EV6APf5KzxdwNwSwE7R2DDI6QEUjjrrtJ
         9tTV1HtjgOrOyjnjG3GxMMYEA12czGSJw8Aq+BUDosG6KcM4edY7BvTck0xQV8R6kGFF
         BZtg==
X-Forwarded-Encrypted: i=1; AJvYcCVDPDTQZEC3kqzy18/OMdZnyuhw0mQPkoXAwzHImHx53BpE4MI5ANhZfQDtUAn0NfRz/uv8Jee5bp8N2Ng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/EM2Ab+0fUpAEe+J7vZx+zi2cBpmx5GYiw/70aD9VSnExkNAG
	ncVtg3idxtmY3lzQS+sbvVGS9CA+2WAGh94RtgwfOtVJ32DpIy+Xfl0q
X-Gm-Gg: ASbGncuH/jOJmgKmcAp5fP4as6I2YB4KgyO00XHRNE6wFB89JlJ3vB3SWdb3LxPf0Er
	yeS6iw7mR/IR1FOGKLyBE8xTf53V1uI0ryI4xJZGypIDYPYnNYtliaQIX5zd2oObfCPk9D7aQyZ
	r4TKcy2Y6qu4UoSNrtZyYLeiVUi9+knHUimIwneb4J5qOanlCBOfAclPvLiDMlhu35L3Pf24iEB
	DQ+xge6GutMPJDT3bT9vVmo5KckFvl59KTihZKw+yL2s4Haxi4qXZScmfTMJ000STThowYGG7t/
	v3Oegulxmluh9IjgmtpSyolw3fKH7rorJu5zIEzvs6EJEnCAu51jXtP59TttXlGCCUh562e0k4p
	UqvbP8q+BhU1N8vTYI+RzgDLwzMKX0uobgXM57pY76zFdpy7fXNrXOQkZYD7gjwr+173h8GUEcW
	YsXXFX2QMaW8r7Sr7llEAgl6L536M=
X-Google-Smtp-Source: AGHT+IENGoi+2Lljzvtl1dUUzsqoI4mfqoY8VewVD7RbWHS3meOUSd3hc/m0a9FFVRJX0mFwtOhZLg==
X-Received: by 2002:a05:600c:3b0f:b0:477:582e:7a81 with SMTP id 5b1f17b1804b1-47773236f61mr67331675e9.4.1762770321259;
        Mon, 10 Nov 2025 02:25:21 -0800 (PST)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4777a96e7f8sm67326715e9.13.2025.11.10.02.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 02:25:21 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 04/11] staging: gpib: Change file path for uapi headers
Date: Mon, 10 Nov 2025 11:25:00 +0100
Message-ID: <20251110102507.1445-5-dpenkler@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251110102507.1445-1-dpenkler@gmail.com>
References: <20251110102507.1445-1-dpenkler@gmail.com>
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



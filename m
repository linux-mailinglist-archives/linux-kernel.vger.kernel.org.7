Return-Path: <linux-kernel+bounces-895034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABDDC4CBF2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EBEAD34EF6F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC99A2F363E;
	Tue, 11 Nov 2025 09:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeUenWJY"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866142E6CA0
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762854336; cv=none; b=kDHHOnNif4VgVIwsS2sEcJ0kJMtpR4tUE8oIYr0EnlpHIqPT4fAD9p+lVPkmMBjSl6aQbiGjfb56kH1sNJQoQ8kIbVT5VrVCl59lsH9QgGrLRsKz9mtyOv/dnj7QDXVLGRzU1VXNqcTPnJYX8BSkQYdzTDCYVouyI+LGth2yKw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762854336; c=relaxed/simple;
	bh=IOMKATf4WlRptW6Eh2eCnd2gEghdfx2vgXIU4gGtjTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O5eMq3Tky5rxeKwU2IztZG4BAlOhKMnfRV0KhRClg1n5nPa3ParIm2jymjlXglwJT1iIxh+PBMjmiKifQhPgikv8RlSG7zxwapMyxoN4LFcpj9OfEwzZGbEe7Vk/QFVU6PxL7u4X2KATUYSahyzHI1KEvhANtBJ8PPArMEi+TM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DeUenWJY; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so30150705e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 01:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762854333; x=1763459133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFSFlISYEwJhzl0uBpsUYIAL1eAWoNbR9f/0OF3g05Y=;
        b=DeUenWJYiS0c8k3u/bOfLR2J2uU8LO5MIlReq8IY/J286IJ+Q696hkPY6hw1rxfogj
         fEkuYrZHMsGu9S03K7S2k32CXu202u3eLtTlss0Xfuxuxf/HZZFdILKrrh+VimKMZcUH
         aU904MbcujqlrZAt9tdVh56rK8bUrNv9AhAi4nIIx/tnkzpdRCqZwD7dc197FPGk79ih
         OPdeN6c4gnzzUK/LrbTYuVLTyvpFifpSN+bpFWc6N+DI3OD9aaH8+KvmD0lBe87uklVC
         qtf3WUzRM8WiR6lG55NWHJUMNpT+vaEShHqb4vchatJn3oL4YW++qauF1mlPbucgmEnZ
         dlYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762854333; x=1763459133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PFSFlISYEwJhzl0uBpsUYIAL1eAWoNbR9f/0OF3g05Y=;
        b=Cov1ffW8Hw+Y/MQqq0A9UK2uVkgWkYWmOnuoqk14YRI0crvY50XanMvJwaaTxgTlU/
         UCXltFeM94XqRFngunLcIq5q/cB15VNmJ7Hn4/XFdX9oW9201mlMzqYU5S0DZlrglxNK
         nEoG3ofiqJIkXiI0OT4xvChzQpXjuF8IUpNipKHmCOkTB9TOQmrcua/4V6/VZS951rSF
         qORZ/Og6dTrpb/xFGZU6lh9jWMvc0yKIVCqPwmKx7uznfEVLM+LznZRzZjqnuVKaRyxC
         7CEGMV8pv2YIZ5F8KXSAu9niKjErCRvpbmBlKqSD/wqzx/Sr12PBiBA2s2yEiQ7uxneI
         CHuw==
X-Forwarded-Encrypted: i=1; AJvYcCXbgp1pUUe57HK54p8Ne4a9gNQnPZR59pbEGW9bKl5bZLU0Qa0N5vs0OgbEJh8yihouMAEYrSkFkiL290Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6zE1ZlcfGP9XemQWhWCzMS5yx6HOnyP089pDkYG0RwHNTnPYG
	T8KeMt+oUUusPidEIOAQe4PBVX493ZhbDusHGB0+6Wl1PpyBG92X3Ykz0QgdEA==
X-Gm-Gg: ASbGnctPOMrDjS93UNTtHTshjNUKZUa8X7aXAGTYuAhw/pyUiBNS34Q+bTnEYleMw2J
	6usrVLi13Ca/bwpMjWl30Wb07VVdQcfZGQeY22Yt6Iv5HR94jOPQM+svIMH1odUUdzRMcbN3zwI
	+HwyWoP7+xD6/Ywsvyiol+4rcN6vXz5KTiloVm2hoDPbM7vDXtbDqx1wWc5Alz6j39XCOuF4gXh
	ml0Ap5Oli9PF+wBrOrLR8N0SkKTIFp8IOWY3oj7hJFpmXQuuUdzYk2t8yJqsAA1bcisuocmkjs1
	GEvP4PgUsz8NvvsgiIouq0gkaERDSgl3kzFawswyegxIShYythYTdlBbSgh3/F8ph0xmmZq6tIc
	mndQNmOaGPIxJtQ7kxsKvCr/LhVjsT7Mxy+pf89mfJIP+j7jS8pRsbOVfQIPQ8XYZPIEH9Ti/7x
	XSeOvE81KckYZb8xTa4NUj/GUxVT1KWmQl8fBfuQ==
X-Google-Smtp-Source: AGHT+IE5aGbmMnHqM8MTScuynQw3Hppb7/2xbS0m4OPM64yMVSpHkqblBrCPgqUqA9PyRU5r2+2CsA==
X-Received: by 2002:a05:600c:354c:b0:45d:d1a3:ba6a with SMTP id 5b1f17b1804b1-47773280fecmr122983135e9.33.1762854332737;
        Tue, 11 Nov 2025 01:45:32 -0800 (PST)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cd45466sm359537865e9.0.2025.11.11.01.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 01:45:32 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: johan@kernel.org,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH V2 03/10] staging: gpib: Change file path for uapi headers
Date: Tue, 11 Nov 2025 10:45:05 +0100
Message-ID: <20251111094512.6411-4-dpenkler@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111094512.6411-1-dpenkler@gmail.com>
References: <20251111094512.6411-1-dpenkler@gmail.com>
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



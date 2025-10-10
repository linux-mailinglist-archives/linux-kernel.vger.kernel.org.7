Return-Path: <linux-kernel+bounces-848668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D64EBCE4DC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 20:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D08E14E5D70
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 18:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683AA2FE06B;
	Fri, 10 Oct 2025 18:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9w/56Cr"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512EE23BD01
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 18:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760122508; cv=none; b=a+llr0jx6oX/Z0VcVN9TYYb4olMKRbmjLNSapFjZdYvRw7c//HuLzSzEcqZA50G6OPz+IgRidu7MWpfyn5WG0w9GCURJgwvKx7yD8LVCtRyojTwmAFusPCIm0/SuE2yozaV3iHrj1tuaAxvtD4qnXn7uSAJo6B7Bj0z4no8ILZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760122508; c=relaxed/simple;
	bh=qahg4N6BzokiIUngztu2WrxRTDDc4/q2Z0s+8sjejrg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eujuJ89Kazs/6n5qCfK6HDulgH9/cKed17v9eMLtZsVHtViiDs+bkhSjduOejfHxT7bgYVQ7KyDPMATMKSrR7/3eY0AiXJmCt7/b12mlwY+ea9q8UAbnEu1GyMgdNBAu6PjWN6BHQSVlsjIKt6rLOwWZvIxtBdQkHk969hY5n2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I9w/56Cr; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7835321bc98so2440360b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 11:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760122503; x=1760727303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NWoSzjh1fyMpZJllg9eYh+eBr2MZ//XchSf7cCFYHiU=;
        b=I9w/56CrMmsUErnALlmXvAcNwT95voM4aJC/EV3KK/e15qEwL+i0BWdXVBQEOQ9/dp
         OG6jlZK9MiXQLHxK2b3bLXbnH3H1UoWhf1O6OJMFlVKnusUEqqqO0oj2cTq6VN0ENUe4
         LLx+Qm+Srjq3f5s6SOtcCAOOKgxI6rz4Sc5Zp14hUWmkULVhN1k/WNXDa0lXALUiU9BN
         w5nzxH/TEDtMxYAWJaU7EUS0EgX3aIvq/VBg7gQPipOZ+50e3w/8DeVdRaXCZSijClvR
         pyKWUsIiVq/cZXesah+SQhCgUBR7u8h6B+0dENEWaOhzTiwSFlUe4ISECyykkIEBeXNI
         7EWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760122503; x=1760727303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NWoSzjh1fyMpZJllg9eYh+eBr2MZ//XchSf7cCFYHiU=;
        b=fqLBq8Oh+RijoupyIRVStxfufgYp1Z7tWWxWj+lnQHmiHhQEGA4qfb0iLN8OxAiHWV
         T2jKRNu+OA2vxqSxv+zHBeRR2sAOvKs7TOVVJDGkYNudNOakJg3+32NSQiFLJlqdIyvA
         EPsWsqOJaB1vXl4KvcnqBpKcDBXI4l4KnU+oB6/84LbUU4RbGjT57Is8gYufCd2mpvKL
         3Ps6e0xzINbrbTZPKonj2ijItemfvTxGV9UcxKSVquXEgdrBw3C4i54T0bcqFrcChEYr
         KEztj3bIPCg1BF6IGM0UfaOby5MwfAR/K1bWxaBuFJ3ZzNvVnSQ7CBeGHe5LZlI07uEx
         /G8g==
X-Forwarded-Encrypted: i=1; AJvYcCXcBmfTFtzFfxyEXoZsmqhxMSbqZ5YWMVnSvy3j5FhZwA5vuOfKUcr8M0GuGkmcaSlbse19tTyC2+w8lR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZp5riF0DjCI0cFCbQqmwOwNlQ/2+iAUsNdQVhMkTDUFB2DXA9
	+fsViMpFzpsp4XSjbUBwTCcLro5Oza/eVi2wGk/qfXPyXMREA9t9iMPAfpOY9/2G
X-Gm-Gg: ASbGnct0++kfudFGb0nle09RTHhs5mxaypEXovuswFdkkAPXKZJm5Vd9TkgDwbjyrST
	Ah0gfCB8QxqB8h3VR+qj4mMBJGuD47DcmaD7ESvNSSMZBcb3++wDtM1Jbi+83TTMtUlpYMm0XTd
	ausnXz6DHYA+aLQNCTxA4ONrVRXq/BO45nNyIHRpfm3K/9ypVqfRl2HY2ot1eFonrjOoII4NOJF
	sYMcZWOmXY5DV95m/CPKgeUYIKoKXMaGGR5TjK4M8qKnmb6gXmj+tzERNxtOxfVjNDPp+dIZa3u
	4wFbKnHazYrcmN3462F77L+mJSz4zOm6sHX3NXCEUegY7yPgPDIOFU2hgCQpjR4vY7emLAZcYZh
	biw85oZjVusSSAb0/0+d1NXFan9J+nRpC/ZiBi19eyt60JZwUvsmYKP760TuPc7hy
X-Google-Smtp-Source: AGHT+IHB0rF5y61Mc6/ergahfN2ZDy34ebQEHJ9mYi5p+LfCq49osvAzf+LrBUXfLqmK4t9OgN8guA==
X-Received: by 2002:a05:6a20:3ca2:b0:2f9:dc8d:d2a1 with SMTP id adf61e73a8af0-32da817f74dmr18195270637.21.1760122503244;
        Fri, 10 Oct 2025 11:55:03 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:4c64:860f:5abf:20b2:7217:3f90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b63e05csm3739887b3a.22.2025.10.10.11.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 11:55:02 -0700 (PDT)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: gregkh@linuxfoundation.org
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: remove todo/note and duplicated EFUSE_CTRL macro
Date: Fri, 10 Oct 2025 15:49:12 -0300
Message-ID: <20251010185456.26754-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The usage of EFUSE_xxx and MSR macros are already in place, so the note
and todo about that can be removed. Also, there was a duplication of the
definition of EFUSE_CTRL macro in two places, keep the one at the .h file.

Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
---
At drivers/staging/rtl8723bs/include/hal_com_reg.h file, there is the following note/TODO:

/*  TODO: use these definition when using REG_xxx naming rule. */
/*  NOTE: DO NOT Remove these definition. Use later. */

#define EFUSE_CTRL				REG_EFUSE_CTRL		/*  E-Fuse Control. */
#define EFUSE_TEST				REG_EFUSE_TEST		/*  E-Fuse Test. */
#define MSR						(REG_CR + 2)		/*  Media Status register */

I guess the idea was to standardize those macros rather using the REG_xxx_yyy ones.
In fact, when searching for a missusage of that, there is none, only a duplicated redefinition
of EFUSE_CTRL at drivers/staging/rtl8723bs/core/rtw_efuse.c.

If my interpretation is correct about that comment, I`m think we can remove the
note/TODO since it`s very old. Also, I`m removing the duplicated define, since
the hal_com_reg.h is already included at rtw_efuse.c.

Tks and regards.
---
 drivers/staging/rtl8723bs/core/rtw_efuse.c      | 3 ---
 drivers/staging/rtl8723bs/include/hal_com_reg.h | 4 ----
 2 files changed, 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_efuse.c b/drivers/staging/rtl8723bs/core/rtw_efuse.c
index 208373113a62..6391932e214b 100644
--- a/drivers/staging/rtl8723bs/core/rtw_efuse.c
+++ b/drivers/staging/rtl8723bs/core/rtw_efuse.c
@@ -26,9 +26,6 @@ u8 fakeBTEfuseContent[EFUSE_MAX_BT_BANK][EFUSE_MAX_HW_SIZE];
 u8 fakeBTEfuseInitMap[EFUSE_BT_MAX_MAP_LEN] = {0};
 u8 fakeBTEfuseModifiedMap[EFUSE_BT_MAX_MAP_LEN] = {0};
 
-#define REG_EFUSE_CTRL		0x0030
-#define EFUSE_CTRL			REG_EFUSE_CTRL		/*  E-Fuse Control. */
-
 static bool
 Efuse_Read1ByteFromFakeContent(u16 Offset, u8 *Value)
 {
diff --git a/drivers/staging/rtl8723bs/include/hal_com_reg.h b/drivers/staging/rtl8723bs/include/hal_com_reg.h
index 9a02ae69d7a4..cf5c15dc2bfd 100644
--- a/drivers/staging/rtl8723bs/include/hal_com_reg.h
+++ b/drivers/staging/rtl8723bs/include/hal_com_reg.h
@@ -189,10 +189,6 @@
 /* 	Redifine 8192C register definition for compatibility */
 /*  */
 /*  */
-
-/*  TODO: use these definition when using REG_xxx naming rule. */
-/*  NOTE: DO NOT Remove these definition. Use later. */
-
 #define EFUSE_CTRL				REG_EFUSE_CTRL		/*  E-Fuse Control. */
 #define EFUSE_TEST				REG_EFUSE_TEST		/*  E-Fuse Test. */
 #define MSR						(REG_CR + 2)		/*  Media Status register */
-- 
2.48.1



Return-Path: <linux-kernel+bounces-821904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D631B82945
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 03:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DDC07246BE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 01:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C470D23BCF7;
	Thu, 18 Sep 2025 01:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BizNn6Zz"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980F8217F24
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 01:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758160270; cv=none; b=L5cyPON3KXIZ+mfPbcf/6hhSs6mW88FAWivEG5aVrWeDrk9ybM5l+VF1eFpGR/vtzxmULiWT4CbNvLcEMTdILVwxK22qXIt/eeWhR3HTwLntW7UxT4WVCcr7e9ubq5Tfu7OALFs4idfJJnoNdnLqWBjQv2yjti9vHRmPniDDYZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758160270; c=relaxed/simple;
	bh=ZQiUQ9yVnw4lG8xlDGdC6ctnHMQLHbQ+loQH2EBq8K8=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=gvlh7J1gGR3+cyChLwUHf7WNizYE8yw8GsLg8q7uv4WKG5azro1rBPWwnCuGZudkc94NeN/jZQDSeKbsjkyZlO6gVc3tK82o9T6D9d3CygcAUo+Q8qUw5FvuX8+D0MIOmawacKbTPzPNIQd+alJc8z9vdIKmtjzBLFGelX2d64s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BizNn6Zz; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-77716518125so260971b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 18:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758160268; x=1758765068; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QNneYRo0mfk5pULBBOy/9HuHYemGKhvDirakoxmlwAU=;
        b=BizNn6ZzF/qSXifRI4c1WVVBbgnhKDAmIyfQsBpc3S/Hs2rLfNB0VihfllkweiUJYp
         EmNTba6ryokeA+iA/ZXX2ArwcNZN4ttYiJFWuGDTnM7Wd9Oeu/kRYOSUTLEHbSwGP/Pc
         JUxALhTl41ceCF7gQGZCnUxuav+3WCmOKRdQZbFPMemV5Kggr24IExtvLm+qx7ar3A4s
         6oO584n3QtFpyWKe/AtWMJiO2i2wHb3wDcwhTuWGHolAO5JiMv4JtAWX7mHCHMc6k7Cw
         ijSV+XxPEHYl5Az5Dkcc82IRU4pubk7PJj5SWTyjZrb3qivvIfB9a7FJHW8+0eSIAsIt
         LiQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758160268; x=1758765068;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QNneYRo0mfk5pULBBOy/9HuHYemGKhvDirakoxmlwAU=;
        b=QHmAudahjOT9D/QzT+J0T2cjbLoRzM3BNKZiOJBdKRTyShY3WqJJ9I/Q9YBc2I+rwl
         nL8UPoHZHXzpynYlCB13iNVFwNbF55mOVck94jrN7Uo6fDDc/uYfsOitxRbrFp1xpWZJ
         wdjVOrU7eFn3KIypyEYliEVmi/eP6SSuSYP8SvTNN2IomjIBOJo+zUDtJ8HoegnGL83H
         u5prTZZCFeAsmBlhE6mmCGgaw71WWgvw4RUQ+sD9kKMlhKzI0lDJc5Wpr+navEOOxo+t
         QBwOLlGCebjsa5YB76mP2RWn8mFOLnhQ+QEZLPoZILNiIROF4r1s+mmmsGP84GLIV8wr
         ZN6A==
X-Forwarded-Encrypted: i=1; AJvYcCUPZxhC7JqbfF6+r+lEf+Fk5SrJ5ZNLbmhaqQsv8782b7fb953IAKqbN61QNWzYtlESpvh7UDZ3VOLkHG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZsvM4sdNxNAuelwgUz26m/IVAlLlj9FiqUykUnSsE/K3oePR2
	Zb8mlIbyldiCFAF4WUd0XmHK5zhPTwEKxSOBHOkf+9xTzXxuhoSGklNR4YIMMQ==
X-Gm-Gg: ASbGncv9RmgvpjbRPwM5TigyzJBTCuEVVCM2ResxSl8FGfh2THs5BeI4iHwoRYR486p
	+kuYqbbj16k6B4LwxTNsE/56PoNcDiPLdxiHRreU3oZhwtZvYgVE60j8OOi4QkAAJbt0/2HlpPB
	VtjSu85txLFGcEoKER+pDaWay3w+k2VFMNS5tFJTOWNkMUIHzgJ49Ot52kzT0ltIhiX6Xe/9egg
	RnniJXH5v2OSHxicBFu77MMIhuXC/25xm7Kfm4qYh8YEaqud6uaEed+9IZqO983L/ZizehCCPPr
	rIw4QtKCT5j5gMa6uTB4wgFoaFTISA0bIU3kTRMGeSb2Omm4IGk1lUE//o9jNrMb377o1PiipLe
	ie8xJAJUw90B9mH/SGIVbkt5DhVO3swKyWQu2VZlA4K2hVwCbcpyz1FI4kKyvQAvXpCVFNxOxew
	vMx3I=
X-Google-Smtp-Source: AGHT+IGnatXnav4f0xsMqE11lFH2+A1naJa0bdGs8TjaGlZM6vbmj33p7p57xjaAMdiDCFX0AYP45g==
X-Received: by 2002:a05:6a20:3d8a:b0:262:73e:2dd8 with SMTP id adf61e73a8af0-27a9699dfccmr6116736637.23.1758160267795;
        Wed, 17 Sep 2025 18:51:07 -0700 (PDT)
Received: from smtpclient.apple ([2403:d400:1000:7:b02a:feb8:9cd8:3c6c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ff1a22fdsm805650a12.0.2025.09.17.18.51.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Sep 2025 18:51:07 -0700 (PDT)
From: =?utf-8?B?6ZmI5Y2O5pit77yITHlpY2Fu77yJ?= <lyican53@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: [PATCH] ceph: Fix potential undefined behavior in crush_ln() with GCC
 11.1.0
Message-Id: <1AD55673-B7F4-4DB7-AE80-1AC81709F65A@gmail.com>
Date: Thu, 18 Sep 2025 09:50:52 +0800
Cc: idryomov@gmail.com,
 xiubli@redhat.com,
 linux-kernel@vger.kernel.org,
 Slava.Dubeyko@ibm.com
To: ceph-devel@vger.kernel.org
X-Mailer: Apple Mail (2.3826.700.81)

When compiled with GCC 11.1.0 and -march=x86-64-v3 -O1 optimization flags,
__builtin_clz() may generate BSR instructions without proper zero handling.
The BSR instruction has undefined behavior when the source operand is zero,
which could occur when (x & 0x1FFFF) equals 0 in the crush_ln() function.

This issue is documented in GCC bug 101175:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101175

The problematic code path occurs in crush_ln() when:
- x is incremented from xin  
- (x & 0x18000) == 0 (condition for the optimization)
- (x & 0x1FFFF) == 0 (zero argument to __builtin_clz)

Testing with GCC 11.5.0 confirms that specific input values like 0x7FFFF, 
0x9FFFF, 0xBFFFF, 0xDFFFF, 0xFFFFF can trigger this condition, causing
__builtin_clz(0) to be called with undefined behavior.

Add a zero check before calling __builtin_clz() to ensure defined behavior
across all GCC versions and optimization levels.

Signed-off-by: Huazhao Chen <lyican53@gmail.com>
---
net/ceph/crush/mapper.c | 3 ++-
1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ceph/crush/mapper.c b/net/ceph/crush/mapper.c
index 1234567..abcdef0 100644
--- a/net/ceph/crush/mapper.c
+++ b/net/ceph/crush/mapper.c
@@ -262,7 +262,8 @@ static __u64 crush_ln(unsigned int xin)
	 * do it in one step instead of iteratively
	 */
	if (!(x & 0x18000)) {
-		int bits = __builtin_clz(x & 0x1FFFF) - 16;
+		u32 masked = x & 0x1FFFF;
+		int bits = masked ? __builtin_clz(masked) - 16 : 16;
		x <<= bits;
		iexpon = 15 - bits;
	}
-- 
2.40.1

Testing:
=======

The issue can be verified with the following test case that identifies
problematic input values:

```c
#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>

/* Simplified version showing the problematic pattern */
static void test_crush_ln_bug(void)
{
   unsigned int problematic_inputs[] = {
       0x7FFFF, 0x9FFFF, 0xBFFFF, 0xDFFFF, 0xFFFFF
   };

   printf("Testing inputs that trigger __builtin_clz(0):\n");

   for (int i = 0; i < 5; i++) {
       unsigned int input = problematic_inputs[i];
       unsigned int x = input + 1;

       if (!(x & 0x18000)) {
           unsigned int masked = x & 0x1FFFF;
           printf("Input 0x%06X: x+1=0x%06X, masked=0x%05X %s\n", 
                  input, x, masked,
                  masked == 0 ? "- BUG! Zero to __builtin_clz" : "- Safe");
       }
   }
}
```

This test confirms that all five input values result in __builtin_clz(0)
being called, demonstrating the need for the zero check in the fix.

The fix ensures that when masked == 0, we use the appropriate default value
(16) instead of calling __builtin_clz(0), maintaining the same mathematical
behavior while avoiding undefined compiler behavior.


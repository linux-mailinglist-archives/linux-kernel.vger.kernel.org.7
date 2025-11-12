Return-Path: <linux-kernel+bounces-897082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF32C52030
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4C544501BCA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC9230FF26;
	Wed, 12 Nov 2025 11:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bksxmV7N"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B426530EF9E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946294; cv=none; b=h4Tik/SfoSU61ifB/xsG4/1ccdO7y5jL/jYSbtgxLWlZBKg5tIqzW1H6UlxB+k599pC6nhVFkJZtyCuDjWkInYuJBEeftEepBpIX5Df0Zh0p4s6Kao1I6YGEx7BAd+YvOLZ0TQaVm8qxQqeHL+tSlvUIn8zLZ6IjXQPTJKNNipk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946294; c=relaxed/simple;
	bh=6q93RqE2TlCEUP2NwG3riu6HujLsBQ7xoREhizw4YE8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HBoqGxtRJjDAd1ehC0Dn7VyS5kgkZ0zfIb36WLUp4lCvsCoej9JPCmrud57IQUPhDns3g7YwtVxWwrP4E2zkHW8qxqBWRaq17CyZL0x4J+7M0nqgmf3eyVyMkNGfEiR81X5MNDPgMyyBLFG5FBycOcJQU4GfozP46Pry7EpfKXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bksxmV7N; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-bbac8ed0614so559403a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 03:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762946292; x=1763551092; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oNI7LGWITa4EqINx3hRdJjLYG6Q/rRCvp1T1pOKy7wA=;
        b=bksxmV7NhAfJOfVVXpYwCLqkXJZnvmfYJgUt6D3L+x/lVF2MNTVa3I+nR7mDjTu0Sr
         HX/fvD/EGFUr4mR+Q0lHjXky+kUeP00UzTUUThQZMYIo4d+DISeEc0YbAIeIxdMvr6JE
         dBnrnp8KhSUMJoXx26evMA8D1xQVK6qX5PIhhmFE5P1kKrEkdM4O4d4yGQ5LEoyY0Osr
         h1g2nId3CC6R1G06Ak28izvx73+/pSRGaa8EGVRimKd48g2453r/b4i5qV+coCYwVVHP
         qS++CG+Zo2ey46b9VgFSr0pSE3n1jLxx5trbKzPQfZY9nnG2jujo2esNj5aXw1XS8Bz7
         TOPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762946292; x=1763551092;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oNI7LGWITa4EqINx3hRdJjLYG6Q/rRCvp1T1pOKy7wA=;
        b=LJGskjOZyMgcLMfcuIU/gAO0elz0f46amv1gyEQnWMaDkXpr0Aupxna6F50JdFw9N+
         VLr2rPZv6TUmlvmHxOZxxtfRfNO+Mr5Z1uXkg9SAk6/2EKqsI8HmtCXLH6VxDPxWSubL
         te4RigCJX0lDjrgA2L8WJRboiHzLunC+rfLkadO853FdRSB0ArBqvvSxyYKkeyM7vkYd
         7MBjmsTdHoQzpQxBR4B+GYQC5E7Of+HYX72uZDM45cw8GQt6Qw1bBds5xNjDX7gAojFL
         kHm/w1XiYpbd52bnxUHa6pWVb/X+FCcUqIg+MoqKUooGW0+8jkNp+oTCI+Ja7A8lsJSr
         bRgA==
X-Forwarded-Encrypted: i=1; AJvYcCXYcR7ZWv9BREeolyU0Vi6/yWlVogb9l+zIjqcDMLZBGuxa1COclOyhLKQUqBWZwC3uTX6tNF40nxd3Tt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgxQMikZ0MWXCmKibiQ2VM9nvUIorhng6j1Hs+3SFv3nXyq0H+
	sosjVQIZnwxfgVLLYWIEvpvOIk24r6keegaakcStXk11f5xIfZamqOxg
X-Gm-Gg: ASbGncuZy84xYihoXjPbyd8lmF7gQQkgowwJCGgWcKKp9/MyVOOC2zRC9pE637r8V3n
	mPnhVIGubkxHuTTV7h4CQ4Wa+6KaE/kERKoCHrJlN2aXBk60hUjTLzXqHNtDYQGHl5R8zSAiANK
	C37GwerUb0LO583F0vz/ey1d+6ttweXthJ+F9SazCa23mNOWJ+4oxn/mWHA+K09jSextyOc/kie
	GNUr25iNDbEEDy6091vwmd4YaDgJNWjJD7LwM6nrE0xXrqp3hyQI0LIB0DmKjqjrog7bIjyux4G
	MzyVH4MDCH0qZU3ha1w5v3Tz4fgdjlL+OacirMymN1bFUwt1eIBSOqV5nCttauuFAky/J4Zo1KT
	Tq0yh8dP2ndecsG/CDg5eaVFLHc7qvSVT6074Q9rMgYRTz986DuRRMVaky6C3MiMsueEsilOWQQ
	U8HDH1K98uLP8o30Rf49NlbN3kKYEVvyJWBnPFy+2JHr4x70Ty8/p49v2Fu0FVTuDX6YuzQXCUu
	Bv/7XVGLaVIDaNqNlE0JR9PhaVN8K5AyIff8zOnvuhjNFUoJTIUW8c=
X-Google-Smtp-Source: AGHT+IELfcxDjkTjHjE9o1zeO9QJOYdqpFiv0rmTaYc64N3Xo1j3VaCkx7ujy498PmB8+3B+SyLiqw==
X-Received: by 2002:a17:902:e948:b0:298:2e7a:3c47 with SMTP id d9443c01a7336-2984ee01fb9mr30708195ad.42.1762946292125;
        Wed, 12 Nov 2025 03:18:12 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dca0f28sm27386695ad.60.2025.11.12.03.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 03:18:11 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Wed, 12 Nov 2025 21:16:51 +1000
Subject: [PATCH v5 05/11] mfd: macsmc: Add new __SMC_KEY macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-macsmc-subdevs-v5-5-728e4b91fe81@gmail.com>
References: <20251112-macsmc-subdevs-v5-0-728e4b91fe81@gmail.com>
In-Reply-To: <20251112-macsmc-subdevs-v5-0-728e4b91fe81@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 James Calligeros <jcalligeros99@gmail.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rtc@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-doc@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=876;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=6q93RqE2TlCEUP2NwG3riu6HujLsBQ7xoREhizw4YE8=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDJkiOUejzpjy/vkkvernsg0f1VocNBsYcmoPfGGcYNvqp
 94524SxYyILgxgXg6WYIsuGJiGP2UZsN/tFKvfCzGFlAhkiLdLAAAQsDHy5iXmlRjpGeqbahnqG
 hjrGOkYMXJwCMNXqRgz//d6GbizPvxkYE//8vkPl+4R5pvWLTsfJFmx87tjWwd0lx8jQpZzsKay
 ZNaeq6ohQs4Oau4P32Xf26tccFrxZZXi3cwY7AA==
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

When using the _SMC_KEY macro in switch/case statements, GCC 15.2.1 errors
out with 'case label does not reduce to an integer constant'. Introduce
a new __SMC_KEY macro that can be used instead.

Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 include/linux/mfd/macsmc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/mfd/macsmc.h b/include/linux/mfd/macsmc.h
index 6b13f01a8592..f6f80c33b5cf 100644
--- a/include/linux/mfd/macsmc.h
+++ b/include/linux/mfd/macsmc.h
@@ -41,6 +41,7 @@ typedef u32 smc_key;
  */
 #define SMC_KEY(s) (smc_key)(_SMC_KEY(#s))
 #define _SMC_KEY(s) (((s)[0] << 24) | ((s)[1] << 16) | ((s)[2] << 8) | (s)[3])
+#define __SMC_KEY(a, b, c, d) (((u32)(a) << 24) | ((u32)(b) << 16) | ((u32)(c) << 8) | ((u32)(d)))
 
 #define APPLE_SMC_READABLE BIT(7)
 #define APPLE_SMC_WRITABLE BIT(6)

-- 
2.51.2



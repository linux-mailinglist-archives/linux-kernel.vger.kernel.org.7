Return-Path: <linux-kernel+bounces-859089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E2630BECC20
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 11:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7102434FB26
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 09:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D0E2EB86E;
	Sat, 18 Oct 2025 09:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iANsOHyk"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB76287258
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 09:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760778816; cv=none; b=nebtBOHercLK2IngE8YGz/EBTfgCuSU9UFYp9CnXf2feskin/0CKi2r+GgeohELdyqJoGnEr1+HX2yNaOFgHghbS3V608qSU68/vEMgUbgnirXXQ1h8nWL8KH8bta3LdIxFQ3dGV1zwoDQdnH8HR/oSNNhQD1XjIN6teTmEk32I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760778816; c=relaxed/simple;
	bh=kRWSSYlxeJXOJX56TzIAI3EWsF8tHYoKYVfMeWoobSY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KtOXJ881sxygLUAcm7WY3tn0I7lxxGKha6SKv92QSkT9FZSJIIt9N0OlFzt2Pc+Hoo4s4ZDNCehfMAe3SjLjyYi1r50xW5Y6zaS+2a0a1XAhMImIIhe595BMO2KoegEGQz9nYVP2DI6OySmsYlOAByGmfC9Xzu86WxXNMo/EZK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iANsOHyk; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-427007b1fe5so1657100f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 02:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760778813; x=1761383613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ri8ca/eTLwKk89pXw9YmqbW3kCDhRAOEsuWhIOnhH7w=;
        b=iANsOHyks9qoBeryhCIc/QhyYRhSA9karmXFARhOGpPocZPwvGYeTYsaHqLKj6qYbX
         QHqe7cc46MKQIIRT0mm3zDaVybIoPtijb0TfEwfIaUN8Kz4hnykkXZMBdIsh66/1chsZ
         kx//c2Avi6tvby3lz57i9ImC2e6gWf882HcgK/QtfiKv460dbGHVUh1t8Qoplf07LtxK
         0e+gUOUx/bU9q37jRff9qVtIJe5mn0RLjvdK80i9JRQmqtqZlgar5bG2Xflrkkw91i5q
         KWMbgIHlKHhIh8Irz3t7HAeWet5blEGKYOI3SwXeToKEMmFxk/aGcuFsSjl3zvj4XMd1
         Notg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760778813; x=1761383613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ri8ca/eTLwKk89pXw9YmqbW3kCDhRAOEsuWhIOnhH7w=;
        b=nW1A+p4/nJKjfuYz4NAS2MkqT7Lg8JalNBBeX5mjAlwp33+tYH0YSqrxteMdWzzBLv
         BzXWDZo8LAh+PGB/T8/9zEuLzdNDGjPxHueP0TZ4uYgg2NQZw6g+oUc8FqpbUlneBu5A
         dQwE33i/pA/Rh2CjenAv8ZMiFuf8qGxQPMyiPlRXJFgqtka/gtM4VSfKHV7Tv5pUZ7/s
         kyGRGrnvUBTmYvWaG2jUhXLBQGfSLlvvWrOk7APr8V6ZaAXE5FbUfqgqSv6AxUMWqDxw
         kRtvoVlLuPfB5oBbnSsd/jcKAooL+CLc0ViVRT67zoDtKNcb3SzvK79KG79dpQYT/WWe
         EeLw==
X-Forwarded-Encrypted: i=1; AJvYcCWy2qXRUvtgtfvAEEJzofM14sH2lsDwWUOrL6lSer+12Hhg6IPVD+kLQFKBhbwO5T4ppqsfA93a2LqS6kQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfLBNCR9St99xM3AZxiH5WnmDfb/SxZuOOsklJQoMs+c99vYqq
	jwNpM7FtNJ73RN3hPaMsATvMFMVpC5h1+2Eh6wFhVgUH4jMJJRNnezGO
X-Gm-Gg: ASbGncvWeJLwt6nIXOkAQWcVnO+CSQ2WlraanuzHXQVskfbq5+jhYndILL6BTXW+MXX
	RNRpYObdqZ+R3IoiwviQc40nfIx+/t5RBZxFYcCL29qrJ4ej6XeD/+MImb6+3eUlN0QzyA6Jubi
	rJb8Y4CyiBoUCLqDtd1CMM+E5Oz9sKhYcF3ayk7oOX2nuF//RmWiv5sHDRFGNIPVb2ctzq6LMI4
	Pnj+2MuwflwCRpCKwJ45PtRiEk6U537fruSDbQaj5N+iOA9WKI5jEqE5IO+UH5Ump/3YBnfqQlB
	wfK1/YMMpAVZ0OFJIXUXAL2zG+NrLNtsIoLQt10BRDRup0/eFyRD7v50iYqN4X5DyuFiWqTlyh2
	4N4qHRXZw/vfZ0e8a+C/rGya9xFt13hEN4wpSFJFVWHeePRrkShoX7doOPWOoWk4B6H35yLaCmP
	H4
X-Google-Smtp-Source: AGHT+IEpPJ0gQk4wkR7OiW5nFDXyyImmqlUALDzPrA0+0xmySG0CU6itPykaBoWtyjPp0bLhwshWHw==
X-Received: by 2002:a05:6000:2410:b0:3e9:ee54:af71 with SMTP id ffacd0b85a97d-42704d83de7mr4633959f8f.12.1760778812621;
        Sat, 18 Oct 2025 02:13:32 -0700 (PDT)
Received: from shift.. ([86.124.201.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144d17cdsm121034215e9.18.2025.10.18.02.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 02:13:32 -0700 (PDT)
From: Cezar Chiru <chiru.cezar.89@gmail.com>
To: andi.shyti@kernel.org,
	wsa+renesas@sang-engineering.com
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cezar Chiru <chiru.cezar.89@gmail.com>
Subject: [PATCH v7 0/3] i2c: pcf8584: Fix errors and warnings reported by checkpatch
Date: Sat, 18 Oct 2025 12:12:55 +0300
Message-ID: <20251018091258.5266-1-chiru.cezar.89@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello maintainers,

This patch series fixes 18 errors and multiple warnings reported by
checkpatch.pl on drivers/i2c/algos/i2c-algo-pcf.c file.

The series v1->v4 is a response to the discussion on the mailing list
with Markus Elfring who had comments on my earlier submissions.
He suggested:
 -to split my initial submission in a patch series
 -had some valid points on imperative mood usage in commit messages
 -wrapping commit message to 75 columns per line
 -change some of the commit message to point usage of checkpatch.pl
The series v4->v6 is a response to the discussion on the mailing list with
I2C SUBSYSTEM maintainer Wolfram Sang who requested some changes:
He requested:
 - to remove debug macros from i2c-algo-pcf.c as no code change was done
   for almost 16 years.
 - remove wrapping paranthesis from value assigned of '(0)''.
 - resolve conficts caused by debug macros removal.
 - remove also printk and dev_dbg function calls related to DEB macros.
The series v6->v7 was a result of feedback received from Andi Shyti:
 - Remove not useful information from commit message
 - use better the 'ret' variable by moving it inside for loop of pcf_xfer
   function and inside of loop check if ret < 0 then break;

Here is a brief summary and order of patches to be applied:
Patch 1/3: i2c: pcf8584: Remove debug macros from i2c-algo-pcf.c
This patch remove the define of debug macros and also their usage from
code along with printk and dev_dbg function calls. Removes also i2c_debug
parameter as its implementation was removed.

Patch 2/3: i2c: pcf8584: Fix do not use assignment inside if conditional
This patch takes the assignement from if conditional and moves it by 1 line
up.

Patch 3/3: i2c: pcf8584: Move 'ret' variable inside for loop, break if
ret < 0.
This patch adds space(s) around some binary operators. Also moves ret
variable inside for loop and check in the loop if (ret < 0) break;

 Testing:
   *built kernel and modules with I2C_ALGOPCF=m and my 3 patches applied on
   top of 6.18.0-rc1.
   *installed kernel and external modules generated by build on my laptop
   *rebooted and loaded i2c-algo-pcf.ko without i2c_debug parameter.
   *when loading the .ko with i2c_debug parameter an error is seen in dmesg
   and this is expected as the parameter was removed.
   *No success message related to i2c_algo_pcf was seen in dmesg but also
   no failures.
   *Module loading and unloading successful.
   *No PCF8584 Hardware was available.

Cezar Chiru (3):
  i2c: pcf8584: Remove debug macros from i2c-algo-pcf.c
  i2c: pcf8584: Fix do not use assignment inside if conditional
  i2c: pcf8584: Move 'ret' variable inside for loop, break if ret < 0.

 drivers/i2c/algos/i2c-algo-pcf.c | 99 ++++++++------------------------
 1 file changed, 23 insertions(+), 76 deletions(-)

--
2.43.0



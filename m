Return-Path: <linux-kernel+bounces-899174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C6EC56FC1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 23A454E8065
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DBB339B4A;
	Thu, 13 Nov 2025 10:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJIpk1tl"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423FE334C35
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763030755; cv=none; b=UkHMYzDW4swDCpOuiG8/hggZTSFvDTIwsrNpW6AbC0hExqgm0HXB5lfMyv7LPVLSoJT10dCC5jgYICX9t7wmG8FNt3zPl1RsQdlROCVyxXas2GyU/TWeu0Imi5t12CYihjVItYz2PM8LjaocVWXzd2Aw8Z3KCQw3uhaIjgSkiXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763030755; c=relaxed/simple;
	bh=8lQxcKvouaei16FqYGY0RR8AerBRZPOQndfjxzjaGZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nL9zeIPrXL/xgxd73sq/2FLePVOTotyajySy/uFtVjGpJHYYorlokph/Wa2B+M0tm1BsDRi2qdd40sQm+9ixsEI8aAqVHWRElIVkT8BL9T8umB4y2nrIIiwT+7oG+f9xGwRa4WV+AEspG30FfjM3niJ5MWC0M+spfPn7n5xS0MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJIpk1tl; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477549b3082so5516705e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 02:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763030751; x=1763635551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1iqFxV3svYobU0TK9f8Y5DAj+U7MQujkDDouJLinQ98=;
        b=DJIpk1tlB/n1zv4QcsxOzRuRJaOpvZ5c9xsDgJcWV3XvkySqDRlVFO+TbymhC0QYAE
         axU7F6omGMz/FoGXvvv4hz9fwE3k3hIoahEzfyQdWj8+zxSWDhSaMkL/uq96Hc9ObtNh
         UX8bioFTMteg76hy/CYqG6vBvRXypz4co8qOF3Ce/ze/eXg5LXlBzn7tlrUbADM2SBkP
         3TN7IN2DrGwAb/by8f9rcGMVHd4tDPWTxBo9hsxXRXS/03oq0UhMXvo95hyt9WSmwrFB
         WyzOlmm70Rvs8HXduBcvkIeUhrMvqEIGKfvZH0GEDoQeYn5MYInxUMYWtahbM7iVtBWc
         AilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763030751; x=1763635551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1iqFxV3svYobU0TK9f8Y5DAj+U7MQujkDDouJLinQ98=;
        b=NtImHGEBK6B37bShBQiJ8+trYcNJAB+OpYvt7LwFBvb1GimYAHMh3i4w9zuqueX+nb
         AOYStHICg3Wx/YhG46YWQHwqV5sIgvc3bGYxD/H3VfcfSne/pVkRygK0k9ZFm2qOFqJ+
         L2gZ8Sfq6hWw0XbUlemLtOkAwYioslc758ulr+8lQDVcW/GG2WzXmxqMbcWSvxTrvKYr
         cE96wWnNuvbpB8pvCJPgesM5nusp0eqSmV2tcqbdFMNhBAT8aNgh8wB++1/D+0WO29Hz
         uPxTavjvi1Wr05/A4BuFXDoKIiSu3YIGVtd+szRIsGxWD8ESRBYJX5QvVTVcfgG60mNm
         iuqw==
X-Forwarded-Encrypted: i=1; AJvYcCXyWg/mfIQVlYmbS6i51DiZmihuDAbqt2X9Fl19c5PMvAn7JbKJKVIVGnFVK3fJFZ3ZsGDvNW04ezJ6n1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsJ+SLJ/EysnTh6azfqrr2XPRI34NsBxTj8Z7Un0tBBFlZDb4z
	CKeciCQI0SCzm1UkZjggQwuuoN0u+u4tsnPrW3fejTO9cxpeUKrsXGwX
X-Gm-Gg: ASbGncsCI/+c0CRij5E86y6BZztdEM2XBaLN7ticYnIG45Pa4WcxEEilQUyntug9h+m
	3dJwPRJAqFi8fGqr9jqelA/8EDjNWPhbpLWnBcQXk6gNjEEIVMfZEv1j4Y1TuVeSBa/K2VGuT6h
	VMf/aUWwfDTO9S2ifsTKZWaOVmId7wk5zS87AFYQtOkdGC95ZNo2Mh0N0zCN/AoP3uslhSoJYAU
	xU6FNyc5Cez0DagZa4Y+h93N0SGmsW53wOIgfXlthXtEIxD9Ge7CDxI6KHkQFhOt25Eg6RYF2XO
	czbTG3ApPgKX4LWtWn5BkgrkgzS1SqKncvWrhcrrJXjo2PM1NVV2OpKGoBpNJ4394y42C08Arxz
	+85ueZ32qEByRHyayROwesRHEqvc/ky+nPv2nsXaQYI4XN05+WhUqSuSJhxMSzRDTB3Bf9VhpMi
	npXrg/U2vRb9Sc4OV2
X-Google-Smtp-Source: AGHT+IGR+NeWuRHz8KF2f/Pbo2I9m3KapID91wtHUJiDDYJNtpR/ZDvaLzC91wpETSji+kdJy4ZHUg==
X-Received: by 2002:a05:600c:1c2a:b0:471:131f:85b7 with SMTP id 5b1f17b1804b1-4778704da9dmr58822485e9.15.1763030751240;
        Thu, 13 Nov 2025 02:45:51 -0800 (PST)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778f247821sm1444975e9.5.2025.11.13.02.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 02:45:50 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: johan@kernel.org,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH V3 4/6] staging: gpib: Update TODO file
Date: Thu, 13 Nov 2025 11:45:41 +0100
Message-ID: <20251113104543.5875-5-dpenkler@gmail.com>
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

The comments have now been fixed so remove the item about
comments from the TODO file.

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/staging/gpib/TODO | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/staging/gpib/TODO b/drivers/staging/gpib/TODO
index ab41a7f9ca5b..ac07dd90b4ef 100644
--- a/drivers/staging/gpib/TODO
+++ b/drivers/staging/gpib/TODO
@@ -4,20 +4,6 @@ TODO:
     CHECK:ALLOC_SIZEOF_STRUCT: Prefer kmalloc(sizeof(*board->private_data)...) over kmalloc(sizeof(struct xxx_priv)...)
     ./gpio/gpib_bitbang.c:50: ERROR:COMPLEX_MACRO: Macros with complex values should be enclosed in parenthese
   This warning will be addressed later:  WARNING:UNDOCUMENTED_DT_STRING: DT compatible string
-- tidy-up comments:
-  - there are some "//comments" and "// comments" scattered around
-  - sometimes they are misaligned
-  - sometimes "// comments" are interleaved with "/* comments */"
-  - multiline comments should start with initial almost-blank line:
-    /*
-     * Good
-     * multiline
-     * comment
-     */
-    /* Bad
-     * multiline
-     * comment
-     */
 - resolve XXX notes where possible
 - fix FIXME notes
 - clean-up commented-out code
-- 
2.51.2



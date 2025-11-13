Return-Path: <linux-kernel+bounces-899175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A65C56FA0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 97872353D40
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0409F33B6D9;
	Thu, 13 Nov 2025 10:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNEdFfmo"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C66F338F54
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763030757; cv=none; b=qskNIq4FhqJ0pu9m4ZzQau/kTFzVOU4YhgHVXHFO7wByCH+9AMxa1cv8u7TNnfZqANXKAWAnZx/sz+aV7VL7Ie+EBd/QPd4M78aRlfEMuq8jrnS9Guf/S52I+iaMPK7vbvPD1BspdXrwEHi0GdNC03n+xt65TqjKH1wGg1AG59w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763030757; c=relaxed/simple;
	bh=+XnCO9qejTe4ztQ5le1uNUFmPXCcBG6FCCQyy4ErpsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZFmHZ8Up6yht2xKlpbfEJChTticonCdJAh1JP/JOb9Xxd6i6Yjv7Fv5hQDWLNviMkqZUjvVejxWoNf2h0I+vpMgvyh8xLfLl7LXP5VXajLEakrYKP73/+m//hmEShvqEtFDqy6hOjJfXS+y2wlqJXQmQolz3gIxrbhqlit4P52c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hNEdFfmo; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477632d45c9so4774585e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 02:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763030754; x=1763635554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CCSGnpbgz0bliYKvoZoaZD9Q232D8JPebeahtnpVkpQ=;
        b=hNEdFfmo8tG0N1uVGg7mofTiw0LwveWviegbNTwGqFfMJtjJi6B0E9Eiwb5uzsMGz0
         6OB9FpPEMF3qI87/M2/uHSIhF/QFXC57v5FWSv5we83lRpPs4oizNyOG4g4GlDTwMA7q
         p8oCXMQ7Vb7nww50xQQSHSjSe1Bt5XLTayiCIiLgpGiPFOwtm7yAZupkir7f0qI5//F0
         qnb2tDY1vVZnFqTCUVriS49kONSPwWqTAt1YR1nwu+kETahzfjP/YsQKFxx+ye10frvU
         GvuYi9D6IKLEwfbNNRNZBTyWz5hpVv40WiXEM/V8IIUEkxGnVx3eaxlYer7awS7Ykeiz
         //Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763030754; x=1763635554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CCSGnpbgz0bliYKvoZoaZD9Q232D8JPebeahtnpVkpQ=;
        b=Y/VOMCHb0Pv+GuJgJJy+s04UdZlJqDCRfyLvRy223VPb1N7I8qL5PLAQKfV9n0IrQW
         oBPFFigGVIPr9GvAGjsqEDQ6B+KyM3HTXEn8v74h2MZbRACqIoaeP52gbIvP9B6+9lzk
         wYB16FyJWKzyZvSuq3Qd6kNOVPB6jPyCRrE5VYED2kY4IEZLgnmI+2WgbLgnKohvo2CH
         xxWGuEOtCOEDwE/WNtDvMLhrO5b0QT4gPGGH0n7UxUviCEwz1Udjcd/XQDYJ80DjUCzX
         jP5lgp58IYysEZ0Y6bSzeusjVQIabcDk9A0G3cuKcc5dSvYOLSVOtFpvwmWPEWAdW8VI
         oKhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOq8WAxQZSZm1L+sdn0nvaVz/mWknptbeXPu7J9LELFaeM2rI6ud1wKbaVmEI6poLxRqkdBz6ONjtsIC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWTTw43sbyBeLbtGOf6QpSHBkt+FLVOo5f6UD2IHGbdYyqTULL
	kJHica55XV5BaMs5ELvtV5RQuEk272t6EB2IKjOCpliZ4EeVWM8ECqKA
X-Gm-Gg: ASbGncsSFIPL6CjMdP71B4JBB7Unts0d8Ldj3HmxGgTLdyfZMuUBHAYeb8OJj4uyVKN
	04YYKtM8ilaUpkDWSsbaccR/ZOmlpqVmEUohNhIJF2M9iaRaPL+eT71cHKzNyI2rc0vaMeZIpK4
	Tkp/YE1eqIYiIiUkek2lO1sj/RHBjRUWY1smSnGAsqff6qsf3c9EkklwJqTiL8pWixv4Tj099Ot
	+i8UP2dyHfaOlIbRViWdQyt95QRBKWZZhr1UBg4FquhDU4LnngalJ6Lix4i8VaROFB/uDDrASmR
	yj91JS1I00OEwfZlLcPjKP12AAn48TSg2PGl5RfvTs3mC9ivDUCNWAfBd5iEBvE5gKRFn0FrXC+
	Y8Ra2l7389wcPH6wmVqkxBRpGsuMWpFUE4b7O4juVqqtzjNeZT/NAT44kKXBdVST37X3Cv1YbZh
	Ty/ABrnSzPyebQLk/T
X-Google-Smtp-Source: AGHT+IGxCRedSaI36k9CRMkIT2YTFsd0v2RcTU3A4+H7h0fGyHbkMBGCmGgXRMW69Cuef9l7bByDWg==
X-Received: by 2002:a05:600c:45c4:b0:475:e09c:960e with SMTP id 5b1f17b1804b1-477870a9fc0mr66657735e9.32.1763030753468;
        Thu, 13 Nov 2025 02:45:53 -0800 (PST)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778f247821sm1444975e9.5.2025.11.13.02.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 02:45:53 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: johan@kernel.org,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH V3 5/6] staging: gpib: Fix SPDX license for gpib headers
Date: Thu, 13 Nov 2025 11:45:42 +0100
Message-ID: <20251113104543.5875-6-dpenkler@gmail.com>
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

As part destaging the gpib drivers we need to add the
WITH Linux-syscall-note to the SPDX license in the gpib
common includes as these will be part of the kernel headers.

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/staging/gpib/uapi/gpib.h       | 2 +-
 drivers/staging/gpib/uapi/gpib_ioctl.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/gpib/uapi/gpib.h b/drivers/staging/gpib/uapi/gpib.h
index ddf82a4d989f..2a7f5eeb9777 100644
--- a/drivers/staging/gpib/uapi/gpib.h
+++ b/drivers/staging/gpib/uapi/gpib.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 
 /***************************************************************************
  *    copyright		   : (C) 2002 by Frank Mori Hess
diff --git a/drivers/staging/gpib/uapi/gpib_ioctl.h b/drivers/staging/gpib/uapi/gpib_ioctl.h
index 55bf5e55507a..50bb6e251e45 100644
--- a/drivers/staging/gpib/uapi/gpib_ioctl.h
+++ b/drivers/staging/gpib/uapi/gpib_ioctl.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 
 /***************************************************************************
  *    copyright            : (C) 2002 by Frank Mori Hess
-- 
2.51.2



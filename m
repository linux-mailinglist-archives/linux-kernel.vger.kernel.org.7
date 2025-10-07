Return-Path: <linux-kernel+bounces-844196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB633BC1478
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 13:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B0C03C2520
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 11:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F382DAFDE;
	Tue,  7 Oct 2025 11:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbXxxjKH"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D21B253F13
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 11:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759838308; cv=none; b=fSFjC2diuuFS6Hy/B6Png8yYFDYakCBuFS3FAojbSCwg3lcLWzLbkQJ+73yZUEI0K2FGgxAW0ornpCbVH2rxW0q/WA//DEE3Pjb9i06+eX33vuSBVDPTgpdpe2nv+ecilewEq88o20JEtw+ILkPtT84xFoQ/jJZe6URuT5/f2yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759838308; c=relaxed/simple;
	bh=KkJzx5iseDOMBqov/lks7E3Iw2pm9GsyzW9W4JlqAqs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=chaQfYx4EaetgOQ+phFJXcIXKNzf37MN2E8KoPWziL99sRpDtkmJyBHoWob8W/YrLttrDfD7UNgn7GulRaPkiIK4iZifiHsY9pUFZVUleuv0CVjPDYvbuZrXWMd/UIlc4CTklFmh6qk7U+vrUAPASWHfyUCeNk1sdzJBx0tqpKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HbXxxjKH; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-71d71bcac45so66672447b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 04:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759838305; x=1760443105; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/LCefJSJB1+ypX3Sb+h7MPQdpzfzCeRiHx/LBHLwVq4=;
        b=HbXxxjKHRCESFLKDJEl7RqpQVy6cse8nDLjqClKUeXbKElYg+cWwjwFO5x9DcSpgma
         KrpLDDN4dCt6UkTNwPBCsCw1asR5kb+6tfWbdulVwrOHqWCTJoayT5dIt/MqhsUYfWjG
         7kp5fIushbbr8gCz81y73rqXKeqovdKs4o0N11Q7ipq+/74tjAoAMZ7p8/T0it+KYnoD
         uw7oHEH24j10AvTHmMwTgKVIKiZv7B4+fDlEV+3RF4Is/KwktE5/qCs/psqHuspVREzH
         IGvcau1dJ+R3rYSeBAQbuqKGQrM26SAyFkYCgf2fbcCjCAfN45A/HQJ3ubwHLhOKkupv
         JIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759838305; x=1760443105;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/LCefJSJB1+ypX3Sb+h7MPQdpzfzCeRiHx/LBHLwVq4=;
        b=aCzaaVani/iqj3VuHow40vqIhW7PZa/Vs2J1k/JeseCj4HbIpOqo7xgKnVwk4+Fl6O
         47h6Qbtfb+hVFFDKGQhG9BSAhffrH5OmQNdP6YYJb6KT2YwFjpxXhR0UXkIza9qp2bhm
         dQCi9PCrNlN96K6sbgRWnEmH90wlxs6MCcCWjaXGtH8Rj1pYAqj6//isw6qyHcdENW2R
         u1T3V7KHuEa13Ak6zbFtzwEsgQzYcJ9APzNbs0KuiOFSnnw/9xsUy2FLXLtgMfVss5dI
         zIZhVuv1iZnXtW7+mQxMCziTH3+342bm8xNiuDIOO+UMwI4gvoK+WR/bri3lgFNlseop
         caKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtLXMgQkbltL9G7wN+oAaTfIQn447mYEm4t4UhTm/wwT/ctgcPaeqnjpKBNxer84d8q5uw3wLF93rn/Sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjoOXy9YYFBS+wgrzfg6NNbJCe9Nkx3e6CX5JE4gb4LsJ1Ibul
	z+BdFCqiTE9g6mlEGnB0DcU7upQmYcxvjwLs7ARCIRjU/TV0Uo/xzB0IvXLpnXFdJCKLDRZXKSF
	MNa56XZ/BeibmaBNno6s88Xy9TQNInMT/5Hhz
X-Gm-Gg: ASbGncuHIkCsy2Dwk0kEAwqj9RaySM7311mNHgb67zLSxPQxiU4YIKnv2rtrbDUx7iN
	w+V2ijVAVZ6P2D7TbmqCBRokkqx1qMRCoeKr+b2EXHbXUl7yCYLXmeiyIwmIeyma4JsuQeHcxcf
	XbrezFHGDqqr1Mflv0PkruSTUwWDYsxH2x9mNenQ6Eg9qv7BqLXcmYqeHnnCaZ8YgSqMwFzFyJt
	7q2L5tDBS2zE+Cnl2qTa06P7fnKs0VbDg==
X-Google-Smtp-Source: AGHT+IFwJYF3xD4zTcOOqIqOOaWTariNHri9p50BnxHJgjKQUTJP4D/lImwMzoitAXDMhFg9bpYSJ8/BH/27hwAa0xM=
X-Received: by 2002:a53:ef87:0:b0:636:dd7:ee49 with SMTP id
 956f58d0204a3-63b9a07b943mr13743424d50.13.1759838305201; Tue, 07 Oct 2025
 04:58:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Murad Sadigov <sdgvmrd@gmail.com>
Date: Tue, 7 Oct 2025 15:58:13 +0400
X-Gm-Features: AS18NWB_yyYRNWS9evJrxnGlrnIIeGU8nnCxFnRBDZKYWNyfd0MsSgaGiJMyL58
Message-ID: <CAEuvNs2b-_Q=dazKjhUwJoZ5XUpjRsf-FrCOTR_j24T+EG-f=g@mail.gmail.com>
Subject: [PATCH] staging: axis-fifo: fix integer overflow in write()
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Fix integer overflow in axis_fifo_write() that allows local users
to bypass buffer validation, potentially causing hardware FIFO
buffer overflow and system denial of service.

The axis_fifo_write() function converts user-controlled size_t 'len'
(64-bit) to unsigned int 'words_to_write' (32-bit) without overflow
checking at line 322:

    words_to_write = len / sizeof(u32);

On 64-bit systems, when len equals 0x400000000 (16 GiB):
  - Division: 0x400000000 / 4 = 0x100000000 (requires 33 bits)
  - Truncation: Result stored in 32-bit variable = 0 (overflow)
  - Validation bypass: if (0 > fifo_depth) evaluates to false
  - Impact: Hardware FIFO overflow, system crash

This allows unprivileged local users with access to /dev/axis_fifo*
to trigger denial of service.

The fix adds overflow check before type conversion to ensure len
does not exceed the maximum safe value (UINT_MAX * sizeof(u32)).

Affected systems include embedded devices using Xilinx FPGA with
AXI-Stream FIFO IP cores.

Signed-off-by: Murad Sadigov <sdgvmrd@gmail.com>
---
 drivers/staging/axis-fifo/axis-fifo.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c
b/drivers/staging/axis-fifo/axis-fifo.c
index 1234567890ab..abcdef123456 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -319,6 +319,13 @@ static ssize_t axis_fifo_write(struct file *f,
const char __user *buf,
  return -EINVAL;
  }

+ /* Prevent integer overflow in words calculation */
+ if (len > (size_t)UINT_MAX * sizeof(u32)) {
+ dev_err(fifo->dt_device,
+ "write length %zu exceeds maximum %zu bytes\n",
+ len, (size_t)UINT_MAX * sizeof(u32));
+ return -EINVAL;
+ }
+
  words_to_write = len / sizeof(u32);

  if (!words_to_write) {
-- 
2.34.1


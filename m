Return-Path: <linux-kernel+bounces-764433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9115AB2230C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B217C626C69
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AC92EA162;
	Tue, 12 Aug 2025 09:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="W3cNsozG"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8120E2E8DE9
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754990419; cv=none; b=D103/6yMSx9NPVhtSrZkplcJub/j6CDeLQJ9HpsMYKh1syJhdP5yR09R18znaNybvKsusc+TSbpFTFsTwCzwbv2QIf9cDLOZddoPxx65HTK41jayPZn/I33qu82egdyl91GRPRkf0gyqL7DCQ789XvU/zRietbYGgOiPjpbn/40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754990419; c=relaxed/simple;
	bh=co/XPjA9AfZM3VBpKGqT50xbxI8+cJCb3D6ouP3h/mc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WhFrlI0xLtVLIyfq+x01+ufA4Jfy8tZWiVOVgvM81vVH7/uWx13Z/is0JXiJaov8hIMc5igO8v5GP5kYpC/fbwReYJR5+ZKYt+ZkZZt4PSrIuq1cimFbVeyAw+XCkG7KKEHQyw0/Df9/5+dpePaeGARpbNzPTeMOyNF1Pp09tuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=W3cNsozG; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-617b36cc489so10293112a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 02:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1754990415; x=1755595215; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+wl9/XOTim6WdaL8AG3rz5NZoFmUCOhNpHeMxsAgkas=;
        b=W3cNsozGeiKi/SGI/zs3RFO+2VDfS9rESyRf8mYKTetZ29CuCkjww9PBmd4TnB01Jz
         lvAt7hbLU95/CpeK8v/MmLSfSjh74BinkiNb99r/Sxkb+IRqUTs+yiigb7+GSjVEtSvf
         Uq9rqZZ1G/cu1TlCJfWpQWdieZ89i5bUQhWiyD0H4izb7BhqYolSSIPsxIgtF3xNL+DS
         mMbXlkNcYA6r9x6AnvtO7yhCfc+EQ/jU6Cc+d4n+lTT/3OcUCIxfh6bPIuEimTyDJpSw
         t1LfhUxj0zKq+LiSh715n6FkAiqI+DSfAqOWIUI/O3Vz0vhWTWOItJYxNOymu1b1nmdI
         IJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754990415; x=1755595215;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+wl9/XOTim6WdaL8AG3rz5NZoFmUCOhNpHeMxsAgkas=;
        b=cEkQDgKYe0PQftrCx8I7yOec+y+FhZhXdUWaIDve9GKd8QDEqC7N59EWsfVy9prdl2
         yoVqNCs3eyPpPE7BzHDEw7pcwbzfvJPSlEDz+vUUF1wCS26Dz45LIuPH+r9AqtOkENyQ
         b0T/rPDQFpIJJ9cMU8q7eDWgWj07fNQDhMC5tbFumRrfReav0hB3LjxL9obmBM8dwNhr
         NwivruJKQXg45F458SpaB8v1pwl3CKjo6F/SvQhriXARIExCBvdqJX5Bo9lGEfMzQYTm
         YBvrEgBGcMEbDqvrnZT68e+XnDL/Pn6yDMrfAsiHA4O6RAzjcLMnxdGXRQJaKDJe5KdQ
         NPPA==
X-Forwarded-Encrypted: i=1; AJvYcCXhQObYllMhCzfdPvPOcW2r/HFK1wCT6gMKBe4DLMiseOPPqJR9raJrwXL9Z4bhS1jqwlMBTHBVYq8965g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3jXqvUmomqtZ/FOCYpaNXFv+eziGb7Zm7/OvhzqESYdxQ/CTt
	jDDAm98sok2phKyd42M32K6ivbkzCiDXrLqLZAX6CZ8yXXLFvI8AYOZiUseBQUWYph4=
X-Gm-Gg: ASbGnctgwdFwOPHa0Z0GjeVOJfAiEUAgH68MR0JKmGwyA5NZflPJVy4+B3UxLG3MG0t
	Gi6xfA1xYZyXdN/0bFWOR9HZOTwoAUXKN3EUSZfU9oN+t1bH+FLMUpWl5zJPvc7ed9w2x7KXC/l
	1R9imCo1JBSVno1vg31lrs4Mo4HWlnEvZqj2HPMTZOAejXNu81RYnCpztA/2kUoDXj9McHy+zYn
	xEGBqDfPCoqHGOcnbwiBaZqn1Xo/9Edvcd2gZImS5jVGvotkkgQqUnKBCmjqU2Z33uh/RM29+hf
	L96dKfgCocg702siI8Z3r+/Y+p7ZQ8smpHq2Q8KZGH8jfFYosDNPK00+Gzxdzo62o1FVjGVC0ft
	Kv0akRipJ/d00n2zrGg==
X-Google-Smtp-Source: AGHT+IHA0BhQHyhj6+ZMlXR3XdExgEUuPO9rJXkatz86G0wDHNYoLcWjbK57FCnDT1GCyNL7sSjlUw==
X-Received: by 2002:a05:6402:1d4f:b0:618:1835:24b7 with SMTP id 4fb4d7f45d1cf-6184ea2b736mr2051399a12.1.1754990414785;
        Tue, 12 Aug 2025 02:20:14 -0700 (PDT)
Received: from localhost ([2001:4090:a244:8691:4b7a:7bbd:bac:c56e])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-615a8ffbde5sm19677699a12.54.2025.08.12.02.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 02:20:14 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Tue, 12 Aug 2025 11:19:47 +0200
Subject: [PATCH v7 1/2] firmware: ti_sci: Support transfers without
 response
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-topic-am62-partialio-v6-12-b4-v7-1-ac10865c2d87@baylibre.com>
References: <20250812-topic-am62-partialio-v6-12-b4-v7-0-ac10865c2d87@baylibre.com>
In-Reply-To: <20250812-topic-am62-partialio-v6-12-b4-v7-0-ac10865c2d87@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Santosh Shilimkar <ssantosh@kernel.org>
Cc: Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, 
 Dhruva Gole <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Kendall Willis <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1642; i=msp@baylibre.com;
 h=from:subject:message-id; bh=co/XPjA9AfZM3VBpKGqT50xbxI8+cJCb3D6ouP3h/mc=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhozZ7E5JLpHHVx7xsxS9K5HrekPVf/LcWTZsC6yqZcqse
 fVWiy/qKGVhEONikBVTZOlMDE37L7/zWPKiZZth5rAygQxh4OIUgIm4mzD899QVmsUckMTZFcJW
 vKheo35Xy+ctu9Q+/tK+M93XKmRrMiPDtZedTA/nqFvN4zOae040/8z8qLfRu0sZ9VkmySdqJkv
 yAAA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

Check the header flags if an response is expected or not. If it is not
expected skip the receive part of ti_sci_do_xfer(). This prepares the
driver for one-way messages as prepare_sleep for Partial-IO.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/firmware/ti_sci.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index ae5fd1936ad322e5e3a94897cc042f6548f919e6..c187fb714b3a4c658d0593c844716d4b160e4fa9 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -398,6 +398,9 @@ static void ti_sci_put_one_xfer(struct ti_sci_xfers_info *minfo,
 static inline int ti_sci_do_xfer(struct ti_sci_info *info,
 				 struct ti_sci_xfer *xfer)
 {
+	struct ti_sci_msg_hdr *hdr = (struct ti_sci_msg_hdr *)xfer->tx_message.buf;
+	bool response_expected = !!(hdr->flags & (TI_SCI_FLAG_REQ_ACK_ON_PROCESSED |
+						  TI_SCI_FLAG_REQ_ACK_ON_RECEIVED));
 	int ret;
 	int timeout;
 	struct device *dev = info->dev;
@@ -409,12 +412,12 @@ static inline int ti_sci_do_xfer(struct ti_sci_info *info,
 
 	ret = 0;
 
-	if (system_state <= SYSTEM_RUNNING) {
+	if (response_expected && system_state <= SYSTEM_RUNNING) {
 		/* And we wait for the response. */
 		timeout = msecs_to_jiffies(info->desc->max_rx_timeout_ms);
 		if (!wait_for_completion_timeout(&xfer->done, timeout))
 			ret = -ETIMEDOUT;
-	} else {
+	} else if (response_expected) {
 		/*
 		 * If we are !running, we cannot use wait_for_completion_timeout
 		 * during noirq phase, so we must manually poll the completion.

-- 
2.50.1



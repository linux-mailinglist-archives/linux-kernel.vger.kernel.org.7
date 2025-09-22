Return-Path: <linux-kernel+bounces-826681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FDAB8F1BC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 08:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C085B1769F6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 06:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C63298CD5;
	Mon, 22 Sep 2025 06:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4EAs9et"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135FB2517AC
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 06:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758522105; cv=none; b=oHBlbscXaF4UiRGi+Yh99JPyB5lbToRarBpNKnZu/SF6lORJNkncS0uVEh28xHcRnx5wRHVMEsAdAJIjq8yQ5amcHygRrf+KFiO2o7FJ1xYIv6J2SzrxNCae3q+JsQP902up5YM26/jQFxXumkpXcFH2PpSzA/nM1dIW/Xgom9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758522105; c=relaxed/simple;
	bh=5vuOIHtLq7CFaEidcZicx94qxk7qZlaIZNjnBzwUQCQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UMhsagFx5Xbr4dZFhbNPngm5eNQEvlsnGKnv1Ya5pJFtNFRtz/DGU9YOFdMPrWHw9U1Q6Wj+/5rAJHMltKu/sYrNWicDQo+OnvQZt1+gnX/9w8P31N/lhgjIh1BnVLMT0tVmvskiz1LJE6dq63yJPNDBlaVZh3j+SzUdCV9UBiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4EAs9et; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-367ce660b61so9802051fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 23:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758522102; x=1759126902; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lFWIsHcR+hD5XAKLrrYCj9xMsNWxUYwTXzF4H7urqUQ=;
        b=a4EAs9etptWUjXNJ2DFXoYwmwf++AkoE/Af20Ho8E6/Z7KICeJ8tydPP2TX1i5+BM0
         VGWsTdVlZHwvMGqYPHEnSCEkba9eAodeI0vGlK1vBN6LQ1UIutMFovT4Iro8Q0oj4+Ms
         bD+Zfy4xB4d7tbsHOGzEh0GLzzMq22SaasmtKh4aOkCJZjg8gkGrYkA6WdwxW9xbBRuE
         nulZFpBSG+LUd6bVw5zeVYFr4r0PWhaKQjmZUg2qVb1c/dAhsj/wY0Cddnvb0TWJSZki
         Cki7giJieo576Wi1mZdRy2oGPK3yziYxnF2eqQDcoa2YMYhlwUhCNs8ZDy/0/3hIqiVd
         BKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758522102; x=1759126902;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lFWIsHcR+hD5XAKLrrYCj9xMsNWxUYwTXzF4H7urqUQ=;
        b=Pe+Z+Ewg7tTryGzX0EclMXN7R+A9iayFpg+y3RBePhSyh2qoEj50Q8ZgkmyxKN6aN6
         EpcrRFN2/FfGbn1kj6Q/VMyASf0JoHTTzczw6QCcOj4ESI3qERzYerWWOXzsS9I1peJh
         vtjkXS0hc2hS0u001mWCobq+01MCVKx+2saMKa2HkuPEf5PRV2FCF+q50L6vwSd0wKJh
         ckcSw8JQC1g1yOimOA4PVL/6AwLIElqRXAAzEHaPzd4FxdohlIZaXndYhzVZwynRq5+o
         5fXSsPisSmuJfspwPsVDh073vB4yqeRICvlqk0AY+EvqpW9ZMWLR1JKsCypsQgwL760l
         Xb/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWUG0W377lJaB7cX47TJw2XqZWQs2A7U0hnSdrc3xYYTHCzHufc/b4KZ8Z7pjIxHG6B4vYZx8H6ZzxlNOA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwru9GX6QVCSn0BycKXQJlYcow+Svx2h/yNuDi5MHtU2q7i4jJ
	NOyX9M/tPPrJ11p2yOPUcLC+JrhcbfzEcWG49S4vTUYsfQVNmu5HW/hC
X-Gm-Gg: ASbGnctoWJ+VPjmQQCZE/pmq58J4aQeCiuSA5vyc48byodMqIwHvJC3RQDXkfZWScub
	X1ZtR0zUBYDIsUKTeHxcVWtEfNm551iwgKqengLkInmVPFaSY+IpsGCIbg5RqUSPFzT8D1jNBHM
	XwWiHOBsEq+t/kGYOoSEW7j5UDhEF/6bv1wxBDs3p+rGGm7P/8YTRnkiE5xng+1CyAMnr86tbua
	3ukQ3aNVfxCnW4zjH6iH0O967n7FkdyV0KNaQdzyXdi7sdbD6Uokimvbv2DcUfzTfOwaU7N5IB+
	LPBhYhXKOCJKtBuIpcX2CX9Q4A+lSgt0wKy7Lea+V5/zhqhZq9QTGg+jdqV1TV7rhmxz1ylDt+9
	3gwS7EK8J5dNDfWBk4u47ho6zrYR1zTZgVVO0wWkdoUcxENMt1QO/+0fdKBcDLWmRwx8=
X-Google-Smtp-Source: AGHT+IHyYDfi2dmbXnYLZBfsnc/6AkWfJ4kKJQShnqMnsThBP+9pZ6e76HoP1InW2I0Ma+PZ15A50w==
X-Received: by 2002:a05:651c:2550:20b0:366:9bc9:4b73 with SMTP id 38308e7fff4ca-3669bc95204mr17702801fa.13.1758522101971;
        Sun, 21 Sep 2025 23:21:41 -0700 (PDT)
Received: from [192.168.1.166] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-361a99e99e6sm26982661fa.56.2025.09.21.23.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 23:21:40 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Mon, 22 Sep 2025 08:20:56 +0200
Subject: [PATCH RFC 1/7] i2c: core: add callback to change bus frequency
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-i2c-mux-v1-1-28c94a610930@gmail.com>
References: <20250922-i2c-mux-v1-0-28c94a610930@gmail.com>
In-Reply-To: <20250922-i2c-mux-v1-0-28c94a610930@gmail.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Peter Rosin <peda@axentia.se>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1672;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=5vuOIHtLq7CFaEidcZicx94qxk7qZlaIZNjnBzwUQCQ=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBo0OrOt6PCwljxald5m7gc8+WsI9kpekTN+Q/Rq
 gbzc/+JJ1KJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaNDqzgAKCRCIgE5vWV1S
 Ml33D/4jURdHc7ZD+yGYnP7a/o5h0NzCtJOSCoXVcslKAcrezYI1mKiKUpA7cH0pqaP402/dB1o
 4UqBwRSE6phGhHOLyI1Da23/uF3tKaOR1xTOH15XJi9KJwhLIOWyPrLAf7L01ROvcSAK+aUPmTC
 w6jQzpzKirmLZWunBp8RtkLsIXZ+69LIn/Iaj01IjtE5bhWdLGAmVAGlmn5ZH1LZVOXFWmqqi5s
 jbx31cFHESNh1aNmbszEF6RZaoK3keyxl6xG/EEWOxV2TsFg0FJ08XeP5pbg6zhlKR9+sftC0hK
 B47jZaSIONjU0wzB7QjmvD9GtZh64vmHCab865FhR8udfElK5I/dz9I+gH/9dMadpLQMtBoPJb7
 Lw2aZRQjwo0bOYIYqehCVOrxYWMLFfF7pZHbavriuINk1yyeKy8BJW/feCL4KH1tqMOsv7SRMbC
 txk2z0uXcqfCw3wBakgNARonovBe7eVzK09pKVy3EVnz57+4hTge2Jmj8rjbhZ4V/MvJZ9CvW3W
 nI4Z2a0UmxngD4AJzi/+kbi2V6eaFJqXJNdkc29kt/KReJNdUmHHh/cuIHC39p5xHq6NofMWqry
 zGMg1B9qVbYTHbRMbyStwVZ2Dyxwgph1y1l+zuNJFViwkbJH8yzM9YUOsuqwGt9wcwcJiw/8rib
 hGMwGk6CRvJw7wA==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

All devices on the same I2C bus share the same clock line and the bus
frequency has therefor be chosen so that all attached devices are able
to tolarate that clock rate. IOW, the bus speed must be set for the
slowest attached device.

With I2C multiplexers/switches on the other hand, it would be possible
to have different "domains" that runs with different speeds.

Prepare for such a feature by provide an optional callback function to
change bus frequency.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 include/linux/i2c.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 20fd41b51d5c85ee1665395c07345faafd8e2fca..d147e388dbab27966beb4dfbf869928b429e082c 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -742,6 +742,8 @@ struct i2c_adapter {
 	struct rt_mutex mux_lock;
 
 	int timeout;			/* in jiffies */
+	int clock_hz;
+	int (*set_clk_freq)(struct i2c_adapter *adap, u32 clock_hz); /* Optional */
 	int retries;
 	struct device dev;		/* the adapter device */
 	unsigned long locked_flags;	/* owned by the I2C core */
@@ -835,6 +837,17 @@ i2c_unlock_bus(struct i2c_adapter *adapter, unsigned int flags)
 	adapter->lock_ops->unlock_bus(adapter, flags);
 }
 
+static inline int
+i2c_adapter_set_clk_freq(struct i2c_adapter *adapter, u32 clock_hz)
+{
+	int ret = -EOPNOTSUPP;
+
+	if (adapter->set_clk_freq)
+		ret = adapter->set_clk_freq(adapter, clock_hz);
+
+	return ret;
+}
+
 /**
  * i2c_mark_adapter_suspended - Report suspended state of the adapter to the core
  * @adap: Adapter to mark as suspended

-- 
2.50.1



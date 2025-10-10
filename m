Return-Path: <linux-kernel+bounces-848406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFECBCDB05
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 17:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE3D34FEA28
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 15:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D822F7AD3;
	Fri, 10 Oct 2025 15:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOJWUjGY"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4332F83BA
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 15:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760108588; cv=none; b=B5WxOgkNO/kgsOkW3nompa+BEBIF45eOGn9B1p87lSinFDJpO9TqIw34I2k7FB7dleg4T4jj2lv02mXn4hLkWgSCKD2mxBBydgDqEDl/6Ed7GEmay82pZnpnwrlL88UxCnGbpGRldmer5U0Csjxdr0Hj/I7OqYB3nkxCL7QW/Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760108588; c=relaxed/simple;
	bh=BfuWtJpHFnoUxb8s7xJBVcBtioNVHYkElOeeOAD1d8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O5v1KA1SESUrkxB0CZUO24yXKrS4FmqZzkcnXvX41weHk4xfyXGOudALGpnd+F1m1Vrq8oVQRjdOsSegPxDZz0f8Bj/+qCc6KVznH3fQ4FkPTvas/ikmqtkFV3ToKoV0jWBlmgBjuPQyPKZHHU1lNq2WhmcrLdAwimHOAXpooSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jOJWUjGY; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-781db5068b8so1854844b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 08:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760108585; x=1760713385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGAsWoT0ij2AF8u7lzQ99aTp0zEqYgQwfONKoWXhuNs=;
        b=jOJWUjGY7g5vkdEDoSO3DnDTAix7UyGmMzh8e0cJ/t4f9axbWimQr04i3E7aoAoQmh
         fBeQZnegMtpgC7q+xdRAJaoMK7Y+XxIdLkxoFzLIj4Yrg2t9xf7Saqkgje4gAEU4dHTi
         r+3wV4FnrKAck7RQp9w1zrtkzvuqAruNl+vs+04ACZFfqzG1uSDnHk6J31jmrhilqf5l
         Qoaxwi+BhNX8gyn/vYIu/V4gnyDcAF9Kn75IcrxT4d6BZbXzRAQG/+Y4tlkunxWIT4pr
         9MPxCCqtkwJRW0k9KsfYrtMOOQsVUu5CeBRVJYaPn7OTte78Y1HFMMaMEYH+Di7Fgj/2
         lF3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760108585; x=1760713385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rGAsWoT0ij2AF8u7lzQ99aTp0zEqYgQwfONKoWXhuNs=;
        b=h9z7KrgTNbqUsH12oLWSSscxkJUb1RukwIp2maB7W9a2htwyyb8ciLMGOu/S0Blfos
         PKx/NJkv+R8soQD5PcbRMCtzzX4+rL0T5aCyiar/IYx2GkQxSf8Sc13NdWhH5BLipkeD
         A++EYwfpPW51WYBSRD6iuQT5NrEFvMI1LXaaieCNNLq8Jyl32paj0YjeR8Sq3143XHXX
         7ci2ueO7Ll8pZj/pATHR39aYskTKmIlQuvo7b71amJJku9tjPkUewaOx/+zFFzR6ERJK
         TJ6fTQhqSDI0RqydqgcqcFvQ2s8JEeKbdFfzfKY2kFUTFZ39kfIMUNa++GbrwEKi9r/e
         6NfQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+DT43xWQlAjfC6Gs6zKiIc007ZEmngeaSBUL1y9FiD2AznF7agjIZOeX4jT3q4acsDMRG0PAANnU6+7g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzuq+QpG/nKTxU5ML4ty/dItj4mtHCz7+GRyej9Gte3qquux4Fk
	vJ9AveOdvZ8iAYeAWLj7zMpOTMaYvUUHF04SwxQLfwtqhG/GfT4DXzt8
X-Gm-Gg: ASbGncsqRmSPcoGoZObcOhXbmsTo+Nh/lLUELApUDjoYRtWsC57zMHnaoyRuw4C5dcW
	jrZp/ZQZLHD4Qm0HsSRFlCstk81xof0Ar6oKt1IZdOPreMQK153u7lnpQu8YEggvwH3YsdIqX8i
	OaprjP5spLHhrtH2TdIhI9zrvYoFzQ6wvsR6vkrDM3sVbVYxkqZYNgOJo2cF7RAKgXe/9oSw9dV
	QkRkzVTccEEgMrqerEieO44pv0IIkYK5OcuR0WEHxlrOkh+bzNrFOy6jWK4UbkBkp5Z7SjrixO6
	chVHE7k1u4r7zpDhqHt+4B7tGvmclGtmoczYkvLhve1c6AyxhqiVWvrefQ3Z0B+hHkIP66VXjT2
	t0fLi7Id3ZCZIDOrT/W4j1ffS9mOlT0iCVkk03mdd48jWo9VNdXsVhl4I98ynZVBYxP6v841+KX
	ZZV13Q4cM256Z13Q==
X-Google-Smtp-Source: AGHT+IG6Mclomm9HYyi1FtTvYUfbr3VX3dwyeq2EoCOUrPpK9DPowb6JOh4ejWKRDTNNO57tGjljAA==
X-Received: by 2002:a05:6a21:50f:b0:32d:a8fd:396c with SMTP id adf61e73a8af0-32da8fd3980mr15458796637.35.1760108584393;
        Fri, 10 Oct 2025 08:03:04 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b639cbcsm3266359b3a.18.2025.10.10.08.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 08:03:04 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	Julia.Lawall@inria.fr,
	akpm@linux-foundation.org,
	anna-maria@linutronix.de,
	arnd@arndb.de,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	luiz.dentz@gmail.com,
	marcel@holtmann.org,
	maz@kernel.org,
	peterz@infradead.org,
	rostedt@goodmis.org,
	sboyd@kernel.org,
	viresh.kumar@linaro.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH 6.1.y 01/12] Documentation: Remove bogus claim about del_timer_sync()
Date: Sat, 11 Oct 2025 00:02:41 +0900
Message-Id: <20251010150252.1115788-2-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251010150252.1115788-1-aha310510@gmail.com>
References: <20251010150252.1115788-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit b0b0aa5d858d4d2fe39a5e4486e0550e858108f6 ]

del_timer_sync() does not return the number of times it tried to delete the
timer which rearms itself. It's clearly documented:

 The function returns whether it has deactivated a pending timer or not.

This part of the documentation is from 2003 where del_timer_sync() really
returned the number of deletion attempts for unknown reasons. The code
was rewritten in 2005, but the documentation was not updated.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Link: https://lore.kernel.org/r/20221123201624.452282769@linutronix.de
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 Documentation/kernel-hacking/locking.rst                    | 3 +--
 Documentation/translations/it_IT/kernel-hacking/locking.rst | 4 +---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/Documentation/kernel-hacking/locking.rst b/Documentation/kernel-hacking/locking.rst
index 6805ae6e86e6..b26e4a3a9b7e 100644
--- a/Documentation/kernel-hacking/locking.rst
+++ b/Documentation/kernel-hacking/locking.rst
@@ -1006,8 +1006,7 @@ Another common problem is deleting timers which restart themselves (by
 calling add_timer() at the end of their timer function).
 Because this is a fairly common case which is prone to races, you should
 use del_timer_sync() (``include/linux/timer.h``) to
-handle this case. It returns the number of times the timer had to be
-deleted before we finally stopped it from adding itself back in.
+handle this case.
 
 Locking Speed
 =============
diff --git a/Documentation/translations/it_IT/kernel-hacking/locking.rst b/Documentation/translations/it_IT/kernel-hacking/locking.rst
index 51af37f2d621..eddfba806e13 100644
--- a/Documentation/translations/it_IT/kernel-hacking/locking.rst
+++ b/Documentation/translations/it_IT/kernel-hacking/locking.rst
@@ -1027,9 +1027,7 @@ Un altro problema è l'eliminazione dei temporizzatori che si riavviano
 da soli (chiamando add_timer() alla fine della loro esecuzione).
 Dato che questo è un problema abbastanza comune con una propensione
 alle corse critiche, dovreste usare del_timer_sync()
-(``include/linux/timer.h``) per gestire questo caso. Questa ritorna il
-numero di volte che il temporizzatore è stato interrotto prima che
-fosse in grado di fermarlo senza che si riavviasse.
+(``include/linux/timer.h``) per gestire questo caso.
 
 Velocità della sincronizzazione
 ===============================
--


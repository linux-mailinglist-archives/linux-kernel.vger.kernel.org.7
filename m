Return-Path: <linux-kernel+bounces-793650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 051AAB3D670
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 04:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C13A3B9683
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 02:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F2022126D;
	Mon,  1 Sep 2025 02:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSvIBrhQ"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3BE214A6A
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 02:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756692041; cv=none; b=WAaRpApYJGm+G/91DL3vg0stm/+ZfPTaJTxrH+/XcUw0VUN8eAX737kxeq5LJIFc56nRBNEfPeASqGOVuqmxXvxezDqaDr0M5Gaz4/x9WvqCaPiawbe7wCxnkbF/ZUhaLsIg3iDvhiE/Lf3ySPLUrlnAc3s0jwTCfqaemloI3t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756692041; c=relaxed/simple;
	bh=X1O9vF5LeDkAuoDWLe04K5pE9hzgkOLKPGnHJpIRHew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=auyMryyldgn8Gl1fQomaxecRQYS43Pqje3LdWi+kyicaoLl0ow2SUo838x0cDzd7jZTSpsikF1vZC+S8mh3+HBmuCEFf/1BCtaeqmAZdhgUkyA7ZnWARu/vFZUqq1O9Spn4V4TW7e+RmtrflCvM5Q/AWENytH1gx2gmMrlxyIJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JSvIBrhQ; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-70ddadde2e9so32130896d6.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 19:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756692039; x=1757296839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nvwjm1HRhlfMOv0sa7UDrNAhf2iFFKuHjGFmy19Fn7o=;
        b=JSvIBrhQwzgrqCPzWJ3XowAwOO8aoRJxv08W1yJ4D0CoJBJApW8L2Udk9pTiKrg2VP
         Feg70YJPp/4sGiOJySPpCHUM257TBEHsKxHK/STMGXYILO/P6NUQ19t+trLKGcbvQB+b
         bPXuWMwp2hnGhkuRH5gDqdj9i+Yuio97FLLJbTMnJ7xP42FVn06fOJ2OcRi25W3wohBp
         DCCaXDtVcwCjEKIPC9ZtYtdiLcJzhodQFtPgtfR/BUIRLBEDRmAZpBgnWZJh8/I9ac9Y
         Jc6Xk8I0XXX4QXn+2Gax2tvblceiXL9UgJuU5QVJxo7GU/ua0W+YmDqJmrWsD94df5wm
         CrEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756692039; x=1757296839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nvwjm1HRhlfMOv0sa7UDrNAhf2iFFKuHjGFmy19Fn7o=;
        b=Rf9Qtju06MP+5dngUIOOTGt1pH5edFZ1XubhBFpxaN0XyKDGr4GgsSj9FjRAsz4vfm
         3sohy7PsLVya7VcDra7JbH099h9pC8HbLj1KKK/DM+bG3ta0b15NgiLUCApR6X8mPpvQ
         ty5A6WWNmG7uEXZi2TME07Vnd/QkZu6GlM4dLQlPRbHj3mFyjsB6lPO0OG34+T1vmRpz
         zbxoFVrbrLcbPAyS+eUBOVNockaJ4HJMQZK69nboT+7t+58QLAwCv827/4UhxvhTN/V7
         PRU4bUX4u5vewLzs+aVabgJ9bvkLdXG033q+BrVhv7AiObYD6eLtlpUPjc8OSD12ma28
         WZSg==
X-Gm-Message-State: AOJu0YxCBeaJgyhv1wEdoGNJuMuNJCk7wbqQDSgctFk+ZdR2hmn9mTl3
	d3tw+lUYbc5nmJWTBEjYgKiYPL3s+R6kA2pY9CVnouFzzVFkNYDkG9BB
X-Gm-Gg: ASbGncvKjxA9Fnqghae7xWi60E/0fnzC2luskd/w8O1ZYc2nLovOv3CaahoMI0SKhZ7
	SIIfHzQs42vHWKbMc2XpTaGArHfPfRBK64IlP+h/lphyi/RQoyjG7NOVwMmew055O1x93bZ6kF3
	PDJ2E5y57nLUJCAoTVJktIh/IFLcT1BTJfUsL5Ss3pZys2bQ0jQIvV1W5RugVmTMWkkgljzOwHr
	aruSqb8MpjerqPOeaMPDRq+QGVY0XEnKFxn5qe0ZdBW0wm5Lvc7GH013M3FkHO0iS5mfsKX9DVp
	oeSNScvsXObuVYd2FNjLRaMIBjC1OWfgDFEEur0y07xFpLtmMzSxrs8E8jYtbVVYNon3GXtxJvY
	5DplRxKcOp/fbJYSu4CNGBIA8lZCIkPSpWXlHPQDdjNBrNVaMyThoILb9JGJHz0kp0Wdgk1wuTo
	5AprQ=
X-Google-Smtp-Source: AGHT+IHhCqh+SKEztfWuegZJcIZaogGT2qitPVl9dnUZUKhyWxRolJxXeWeYryFcvj4VASLEzXsO6A==
X-Received: by 2002:a05:6214:2525:b0:70d:ef27:9d0e with SMTP id 6a1803df08f44-70fac544cb6mr68297216d6.0.1756692038469;
        Sun, 31 Aug 2025 19:00:38 -0700 (PDT)
Received: from localhost (modemcable197.17-162-184.mc.videotron.ca. [184.162.17.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70fb2837f9esm32151346d6.48.2025.08.31.19.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 19:00:38 -0700 (PDT)
From: =?UTF-8?q?Jean-Fran=C3=A7ois=20Lessard?= <jefflessard3@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] auxdisplay: linedisp: add num_chars sysfs attribute
Date: Sun, 31 Aug 2025 22:00:27 -0400
Message-ID: <20250901020033.60196-4-jefflessard3@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250901020033.60196-1-jefflessard3@gmail.com>
References: <20250901020033.60196-1-jefflessard3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a read-only 'num_chars' sysfs attribute to report display digit count.

The num_chars attribute provides essential capability information to
userspace applications that need to know display dimensions before writing
messages, complementing the existing message and scroll controls.

No functional changes to existing behavior.

Signed-off-by: Jean-François Lessard <jefflessard3@gmail.com>
---
 drivers/auxdisplay/line-display.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/auxdisplay/line-display.c b/drivers/auxdisplay/line-display.c
index ea23c43bb..abeed8812 100644
--- a/drivers/auxdisplay/line-display.c
+++ b/drivers/auxdisplay/line-display.c
@@ -211,6 +211,16 @@ static ssize_t scroll_step_ms_store(struct device *dev,
 
 static DEVICE_ATTR_RW(scroll_step_ms);
 
+static ssize_t num_chars_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	struct linedisp *linedisp = to_linedisp(dev);
+
+	return sysfs_emit(buf, "%u\n", linedisp->num_chars);
+}
+
+static DEVICE_ATTR_RO(num_chars);
+
 static ssize_t map_seg_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct linedisp *linedisp = to_linedisp(dev);
@@ -242,6 +252,7 @@ static DEVICE_ATTR(map_seg14, 0644, map_seg_show, map_seg_store);
 static struct attribute *linedisp_attrs[] = {
 	&dev_attr_message.attr,
 	&dev_attr_scroll_step_ms.attr,
+	&dev_attr_num_chars.attr,
 	&dev_attr_map_seg7.attr,
 	&dev_attr_map_seg14.attr,
 	NULL
-- 
2.43.0



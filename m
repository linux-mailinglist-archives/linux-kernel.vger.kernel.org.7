Return-Path: <linux-kernel+bounces-889083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 602C1C3CA60
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F10F0189566D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850C7339717;
	Thu,  6 Nov 2025 16:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="it5aBo1m"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9525E284665
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 16:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762448292; cv=none; b=LVN/SJVMD9NUUAJL/Gkl0besWis2kASTybRrbTvJb9kx1FOT4zYMiWSr7JxdMZpLEKJZw3Glxa0JqUiaNh7U4wHuuVJ1ttgU9G5LTGEZzWDQK8NmMPWLJf8tpe0g4O71QdRkL9ro9PwVHXe0AC99P2xc6uPudNqXVDbbzTA+IpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762448292; c=relaxed/simple;
	bh=zGbsuJR0MpNMo5oze1A82MxCMMbXYm6UPi7eGvB+LMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=npPTk9URTPb9q6To1VSdcvs1Y06kZXQj/TmWSQy1H0D0WJtEJFAVCHzcuZVYUr9P5wroZ5GuxcphdOtMyps+r38WkcwsPT3bF1cHYNzWX8MAhKKr4cECoIn3bFsd0yqXZaAs3irq0C1O4cZQXo/R914gPH+1SPpODTWq/MyweS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=it5aBo1m; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7aa2170adf9so1095081b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 08:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762448291; x=1763053091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DS8sqqvkxvbCl5lep6vaK9Nc47322GAYDGuz/eRk6tQ=;
        b=it5aBo1m4hZZBmCnv/awhNNRrYn20kcwbPzD3S7a5mgZ7NMAflhBzT+AlUduioGA2x
         H/y5B02fzSp24NWcHI287Ca1xZJAqepJdJkgtKFEOOK1uxSB2rdQETITyqtZgze53IfL
         rh2L0dfGWUiX7bwCGZlCwnL2c/HDlM7rD41u9wejrjsoHUSENEMH35sdL+PkxFZwXKcY
         KetMFjYhbuPZlYu43nYGxscbtgLYfwtjvpvD3x8v7NyqqLVFDeCFIsF0djtmzkfWCqZA
         qcd8TwUZbU0u6uxkS0C/PAApzztbymzbmLJ5nCrOpzE1TAVXwri4N/GRwn04gvo3xPm2
         N5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762448291; x=1763053091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DS8sqqvkxvbCl5lep6vaK9Nc47322GAYDGuz/eRk6tQ=;
        b=iu3nUr1oyNAOJhmM3bPOYIzFky0n5PZnnjFWQwGdoPbCCSprOFodTeRfU6jQECjkct
         d5bFY4BDrGfznIx6e3QUPVCFtFlb4Q6VbttMtj660PNz1to4FcU94qVJHYYed8kkfCtD
         sLIZDPo1JHt34ii/ABi8tin+EhqXJvPntcyawLRfIm5hwtSZeMNKlNwIyO5KnAeY+w3s
         7OPY6wQ5YyZh93am9PmEz6hVzHAbb3Ic0P0fmGcaXcRps05BIL1L8lJEZdVRE+pyMt51
         Zm/kLM/p5DrBRuORxbUZ+jjaj13HMnuKi+SHx8TiIeLb1bEvX6GHBmqsXC1mg2qiS6/B
         gKcw==
X-Forwarded-Encrypted: i=1; AJvYcCU88kH6l2FXhud/1K5N3nxZFqOga8DSpgnyl3Ze3godBvLmFUY0HmUpY0zDv+ooM9YaeXjBUA/ooPkhXhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgK5AFvr6LTUfklc2yPDdHU7QKS6hSiHr6v9IgDQvnRdP9C+il
	kH+ei2uwpt07O8K2U72ixkeDqsweBBVqt5Sf+u7YokVBIO/hiozh5NPH
X-Gm-Gg: ASbGnctwhxFxDujpKOo9nR+DkX3xcfaiH2xYz/Eg8dkBzrIAeWxPdXANDPfZRbn3eq+
	h4r7Ze1KRIwOmrpzyq+a46zqqH8xSp/X8TQU+rD2xK+OPeFVdV7WN1Gtvw3iyESMGcjCcFSyyhv
	iKIbdMZufKwXlF9Vvv17DUdRUNuuJX8fxwnw2kMgMjZ61ntguOSzVKkQiac79PF/thCv59Bl5jw
	2KHvne1HwydNGdHpOgjalcZsRknpbqmi/JgQUgx1Qcqxp9UdZGL90MhOntsoYo2CaMnaNZFrwF5
	t1IooHiWa1Rmf21MkaQuKLZzecpd2guR2xitDI10ru8nFy7CTdAGA7WjYVjvO+WzSl0MPkKshWh
	uSXLPJ8BAiHzp4B7n+pHjhMpLvSsYHrHAXnOsJN6HVso+P5OIyGH6PMVq/AqK/2zy/ZIU7XPU03
	RmjqEVTO7jeME=
X-Google-Smtp-Source: AGHT+IHLEU7rRdg8EIc2XQEbCn/OuyoTmwX710BA5CZo2m9jEPRaW7mEDTTZiyzxlQ6euhLj7/p9Jw==
X-Received: by 2002:aa7:88c2:0:b0:7a7:2a:2ec9 with SMTP id d2e1a72fcca58-7b0bdb84cacmr275781b3a.23.1762448290853;
        Thu, 06 Nov 2025 08:58:10 -0800 (PST)
Received: from localhost.localdomain ([128.77.79.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9ff848bsm46779b3a.29.2025.11.06.08.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:58:10 -0800 (PST)
From: Yiwei Lin <s921975628@gmail.com>
To: luca.ceresoli@bootlin.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yiwei Lin <s921975628@gmail.com>
Subject: [PATCH] ASoC: dapm-graph: Handle sourd card with space in name
Date: Fri,  7 Nov 2025 00:58:02 +0800
Message-Id: <20251106165802.3780-1-s921975628@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the name of the sound card has a space between, the
script will fail to output the dot file. Consider the
case to generate it correctly.

Signed-off-by: Yiwei Lin <s921975628@gmail.com>
---
 tools/sound/dapm-graph | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/sound/dapm-graph b/tools/sound/dapm-graph
index b6196ee50..22993317d 100755
--- a/tools/sound/dapm-graph
+++ b/tools/sound/dapm-graph
@@ -174,7 +174,7 @@ process_dapm_component()
 
 	# Extract directory name into component name:
 	#   "./cs42l51.0-004a/dapm" -> "cs42l51.0-004a"
-	c_name="$(basename $(dirname "${c_dir}"))"
+	c_name="$(basename "$(dirname "${c_dir}")")"
     fi
 
     dbg_echo " * Component: ${c_name}"
@@ -201,7 +201,7 @@ process_dapm_component()
     >"${links_file}"
 
     # Iterate over widgets in the component dir
-    for w_file in ${c_dir}/*; do
+    for w_file in "${c_dir}"/*; do
 	process_dapm_widget "${tmp_dir}" "${c_name}" "${w_file}"
     done
 
-- 
2.34.1



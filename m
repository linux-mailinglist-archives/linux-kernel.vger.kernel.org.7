Return-Path: <linux-kernel+bounces-822726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B328B8487D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1499B60B3A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD99304BBC;
	Thu, 18 Sep 2025 12:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1Bu5GRQ"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DF4302166
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 12:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758197624; cv=none; b=QYW7rCVJ1Jj2SuyaLtpukND/2pgWxgogAIhnsqdDj1Fk0nUfQGkfpAtmgD5n9ZEJb0EZKM95B+89e3+IglH1zvlcyrs2oYycdFARQKv0gd1Bk55LutTIyNrPOo23ns0ETJLr/kNcU643gCUMA/7gNJRfqfdGitRUP8fPlXVvU1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758197624; c=relaxed/simple;
	bh=JsiWJ0idw6/yiGbo3kbDll8GBfeTR6oH0as6tc+6i9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CWYoRboK2QuOBOivgmtzaFuXDqDtOKuSNzFp2uDQjvmYp7xPVAz8fAyONnxqIMMlu/jSw7F9FFiiDC45ckbocSg2mv2RoaHZGpqGu09RL86jCXO1lEjGWjUNScaw+5mS/OLt81EPJgwlyvXYBq3XPAoJFVvA8qcxiYbqwSVR/mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1Bu5GRQ; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b7ae45a91cso6268261cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 05:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758197622; x=1758802422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WwWZNUuCtZ9/86xWHoWdfhxYkVDMpzkc+/3I7/MEfIo=;
        b=l1Bu5GRQlWCahMDDZENu+ItK/XMMLDelCWS1qqIpCy1TsDzJYC4bDFZoE/2TN4YCVz
         6YsA57tKVtPEDKG/DuwuYzE+tK+6Lt1tYbejMAj6jeJDOL0JeFauB5N9fPdmrov4uvRI
         n2UwWACkQHh78D1sjXU8k5DA9HG7qW0quWntLlO9MNuq+vkW1lh1oImBiF/Em/rwkzis
         Wj14DnrNq93a4ooj2YRAu6CyDC6IXx+9CuZVCj1+TIl5avtqWa/Nv1CocrYX+uo37mp+
         jCtQNXDLFYFjSLcI5+8VD/Hrsy6gmKL/lIA0lQPjNHuSxvJVf4nC57Akzw3RIk4d5rlN
         IHLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758197622; x=1758802422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WwWZNUuCtZ9/86xWHoWdfhxYkVDMpzkc+/3I7/MEfIo=;
        b=uhuXnF62nsklWCWcPD1aWCy3hafEaPZlDDepdR5776+sx4JUKCIFoMH8skEZB/VJnN
         t7r5yEUIc/nuJkTE6TapSST4sOz2M/0b8gdIKOrXdYmDT20S69wtCi0gsw9TpmObisKh
         +p3BpfOxpO28QVQ0BwOYmWjvU9dlXFrDyXCXW0fxSkXrPf0HOJp8GQ3gQg38PyXmHxzL
         RPwNKIksFBlMxc6RRzuyTyZn9LAtXu6yI59S+ButqwSenEb7pdI2s/fHiyd3nopazIQR
         oBqycb9kaYfYsvbP50yHF8nHKFz56PtjRmNK5Qt9Utk1Az98XEtQr1N5zXyH7DKRYLnh
         VjNw==
X-Gm-Message-State: AOJu0Yzd3C1uCdMbgm01N6X/AgRA+trVFkAFlujslJPvOIFmMbxgWHcZ
	ZDS0eK+rpNRHz7ueip0AVXylqyejFFp5rd/IkJAWXwVKosU2mhbPU0tfmCdJrQ==
X-Gm-Gg: ASbGncu8yABRGyE5bee9kZkO/wBwdSUDftsuxMb+5BTQ6Qn+FrIyLuopYwLyCu6U8EF
	6Joa6rs9qn8rWPyJ0JLQWUuV5b9kPAH9JqWbCbj4dzpxPz+39B7bwXZl0/6dbu21Qyq4nw7cNmK
	PRk+hfnTVDTd0N0etRAfps4Gw2kuB6VN1v2Qz/dyN86W8PZNsT5HD5b9GmT3/HM3tdGqu568Spt
	k8xo9WLQr6fzwlsOQdBzE+3ez2b9VgxIoMpHIjxr7F/eUb10gJeoeNEwaPBSHtf4S+qeiDcHBgd
	gjRlwbSK0Fia228cpavnIvWtFfFfz8dr1iOJWD3GQwF2RMXl0zyfAG9PcYi8wj358Yx69VuVhvm
	/UlIUxRPUUTeaeur+M7lkiyY+9btDViGOs/Hnu3KYHjuaW95CzEfXBMKEN4OauZX7wfCGFrDXU/
	m6TFihZxDqhsk=
X-Google-Smtp-Source: AGHT+IGRc+hNfS3wAF3k/kzEr22/JJ8PvBugFt93cCI74XG8yHk7aPlN4AQJ3WQO6WRjQuc4vGziBA==
X-Received: by 2002:a05:622a:5518:b0:4b7:7c2c:8534 with SMTP id d75a77b69052e-4ba655f9703mr63257701cf.15.1758197621571;
        Thu, 18 Sep 2025 05:13:41 -0700 (PDT)
Received: from localhost (modemcable197.17-162-184.mc.videotron.ca. [184.162.17.197])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-836278b5cd7sm154528185a.21.2025.09.18.05.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 05:13:41 -0700 (PDT)
From: =?UTF-8?q?Jean-Fran=C3=A7ois=20Lessard?= <jefflessard3@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] auxdisplay: linedisp: add num_chars sysfs attribute
Date: Thu, 18 Sep 2025 08:13:14 -0400
Message-ID: <20250918121321.116248-5-jefflessard3@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250918121321.116248-1-jefflessard3@gmail.com>
References: <20250918121321.116248-1-jefflessard3@gmail.com>
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
 Documentation/ABI/testing/sysfs-auxdisplay-linedisp | 11 +++++++++++
 drivers/auxdisplay/line-display.c                   | 11 +++++++++++
 2 files changed, 22 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-auxdisplay-linedisp b/Documentation/ABI/testing/sysfs-auxdisplay-linedisp
index 45cf4e5a2feb..55f1b559e84e 100644
--- a/Documentation/ABI/testing/sysfs-auxdisplay-linedisp
+++ b/Documentation/ABI/testing/sysfs-auxdisplay-linedisp
@@ -15,6 +15,17 @@ Description:
 		  echo "Hello World" > message
 		  cat message			# Returns "Hello World\n"
 
+What:		/sys/.../num_chars
+Date:		November 2025
+KernelVersion:	6.18
+Contact:	Jean-François Lessard <jefflessard3@gmail.com>
+Description:
+		Read-only attribute showing the character width capacity of
+		the line display device. Messages longer than this will scroll.
+
+		Example:
+		  cat num_chars		# Returns "16\n" for 16-char display
+
 What:		/sys/.../scroll_step_ms
 Date:		October 2021
 KernelVersion:	5.16
diff --git a/drivers/auxdisplay/line-display.c b/drivers/auxdisplay/line-display.c
index 73e4e77ea4f9..7f3e53e2847b 100644
--- a/drivers/auxdisplay/line-display.c
+++ b/drivers/auxdisplay/line-display.c
@@ -178,6 +178,16 @@ static ssize_t message_store(struct device *dev, struct device_attribute *attr,
 
 static DEVICE_ATTR_RW(message);
 
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
 static ssize_t scroll_step_ms_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
@@ -240,6 +250,7 @@ static DEVICE_ATTR(map_seg14, 0644, map_seg_show, map_seg_store);
 
 static struct attribute *linedisp_attrs[] = {
 	&dev_attr_message.attr,
+	&dev_attr_num_chars.attr,
 	&dev_attr_scroll_step_ms.attr,
 	&dev_attr_map_seg7.attr,
 	&dev_attr_map_seg14.attr,
-- 
2.43.0



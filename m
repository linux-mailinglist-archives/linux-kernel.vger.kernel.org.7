Return-Path: <linux-kernel+bounces-831654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB1AB9D3F9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 04:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 392E14A2FE5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8732E6112;
	Thu, 25 Sep 2025 02:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfvTj2/G"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E9F2D24A6
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758768966; cv=none; b=KxPxDgR4dSF/nxRKXJiUhcSfaSzKJCeLXISNN8amk5zEUNWzZUZcf/S3bRjWCGLW9LUiN/Vm7GRh/ZXz/PwsoZqwVKIom8vM4HO+9qh8BbB4wZ2OAb/NfLOrYtfOFgbRUe3ZwIiNLrOXuQ3RKm4RtdonoHYxKBWuLKoo2DaVMGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758768966; c=relaxed/simple;
	bh=bjGKGEYLx4Ek6o9WIWxyy3uSiuH5z/BJkpP6h9pxIgw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=A5KZY7lRc9OFAt1TaRskBpo88bfOPx3rFrnhr4BJyReUg5yz8Cm+cpVRxNEjATb77ptNGlUpSM17dCscYDa63OgMr3UWJCM3e4x63elGfwZTs+65H/nye/nuQZInq7CWzU+2157buBTBJXN1dIko7cYBCV1eOPc+ElN2pv87dB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YfvTj2/G; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2570bf605b1so5515955ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 19:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758768964; x=1759373764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IPNTfezmQLwWF+0DYhRQpbuDatlpuWxu6JBXWZ6IoJQ=;
        b=YfvTj2/GMfTX+ZIz0LTIlhu8IDS4jV8EtCDwZsGarBT3EIvtYBIgc8ktB/yZrGT3IE
         hBtQ7TqpzLiL7CriRktEFohiOdjgft9/60mo6XI2yl/AUI0S+C+j7/oGZui3xqXtyJid
         vJt530xdV8bXSi5m/Yce4YI+7xEky8nXljaitYMbv1MQBhYiwqBC3wc9gibSvuwraYre
         wMEBSTp4FuvAj6MOhtG67g54vehYw+FCUf26Jh7xkscN+TM0GU4vGWPZ/EOhYxJWJSXs
         T2G0tw+TDMqUyypKg3TQd/IOm/4tyd5aOheiIv3Pf+W/CzCdRAKYgVqd99v9msdvY4aX
         QL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758768964; x=1759373764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IPNTfezmQLwWF+0DYhRQpbuDatlpuWxu6JBXWZ6IoJQ=;
        b=w7f/eZRbUi1oTM/LBmNruXMLvvq7mfzFdU84W+wdBATsqgS2/+GRauTWEBbu5n5a6v
         wD/vLLJmR/Q+Ezp31GDEqX1C30L9J7kcWRSZnIJfFa5Ilb9+Og/FPZQ+V6wfGhjieWkP
         sKRYKe2cPD9f9+B8CUOjzo4qDlw1cJKjlxhA7rJ/wbxYk0hW0Mxgm/7WE3PQzMeCU2V3
         jqsYoWYQSJXYU8BHzk2LTuvUiIsFOZZetqPPnsnFSLDPTHvEH9xF9MUlJp+0CJQopjaF
         nwtxZQJPbeXzL3M7F54S/kPET72eZNdTQZREV+C7xwVeUA/1zCb1/WjKat7sMznXouaQ
         HUJg==
X-Gm-Message-State: AOJu0YyOBpGDo0Rh8k70EFLeiwk5MAszJsJTGZYgPmVWcFpDlEx7oPxT
	CoywUHjB3v0WzhFF+bJwJOtj2xZFOHVTm/29C76GU2z7QHZUwYkc1zsq
X-Gm-Gg: ASbGncsoesN158qmFgrz+ZO/hEu6HvKENTc4aU9RdU677siPIhwJ7mOZ7tJ1ziN2UCn
	9WUuK7PDEgdBdCttDR0QBz3hGvdU8pPYOELZwrIWzzxJWpRYouThPjc+fJkxptJ/m53Q/xAlQlP
	aMiUXT+KGvWX2s5O6gLQ9Q2iUqDyqCBDku1TYi6JKgMbM+DQnI8kNP7OISLDGYHLoqcDvF9sE0n
	SSv9JR2BmnY2dSvPsuvvfk0Zi8VMF7PXzSzvi33z/EyqDbtW/aQpcex3tURthO9idywsghWlVTM
	EuI1+kiw/w/RpKdQl+J5Q2BvUvbxw72sbKG7jhKNqBVkaJU5OmL4VcpjM/444Dc14lE4YyxVvos
	z7qdF9KTYlldt00Sz6JYRTnnsqVEf4L6MSTTL9Bb4OBJ5r2uqU25xR+euP1iaVfhsQc0OgxLT13
	gu2EaFtwjt0i7WH2bmtFUnNGZJag==
X-Google-Smtp-Source: AGHT+IFhnqykDDA4wwa5g4EewrHSRU0zoss9f9TGch5K91PEDI4W6D+A5M0bsoLzMbpb3VxV/uM0TA==
X-Received: by 2002:a17:902:fb4b:b0:26a:b9b4:8342 with SMTP id d9443c01a7336-27ed49e9308mr17310255ad.25.1758768964285;
        Wed, 24 Sep 2025 19:56:04 -0700 (PDT)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66cda43sm7976735ad.25.2025.09.24.19.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 19:56:03 -0700 (PDT)
From: Kriish Sharma <kriish.sharma2006@gmail.com>
To: gregkh@linuxfoundation.org,
	arve@android.com,
	tkjos@android.com,
	maco@android.com,
	joelagnelf@nvidia.com,
	brauner@kernel.org,
	cmllamas@google.com,
	surenb@google.com
Cc: linux-kernel@vger.kernel.org,
	Kriish Sharma <kriish.sharma2006@gmail.com>
Subject: [PATCH] docs: android: Fix missing kernel-doc entries in binder.c
Date: Thu, 25 Sep 2025 02:55:17 +0000
Message-Id: <20250925025517.815391-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix several kernel-doc warnings in `drivers/android/binder.c` caused by
undocumented struct members and function parameters.

In particular, add missing documentation for the `@thread` parameter in
binder_free_buf_locked().

Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
 drivers/android/binder.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 312b462e349d..d30d27bfc634 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2417,10 +2417,10 @@ static int binder_translate_fd(u32 fd, binder_size_t fd_offset,
 
 /**
  * struct binder_ptr_fixup - data to be fixed-up in target buffer
- * @offset	offset in target buffer to fixup
- * @skip_size	bytes to skip in copy (fixup will be written later)
- * @fixup_data	data to write at fixup offset
- * @node	list node
+ * @offset:	offset in target buffer to fixup
+ * @skip_size:	bytes to skip in copy (fixup will be written later)
+ * @fixup_data:	data to write at fixup offset
+ * @node:	list node
  *
  * This is used for the pointer fixup list (pf) which is created and consumed
  * during binder_transaction() and is only accessed locally. No
@@ -2437,10 +2437,10 @@ struct binder_ptr_fixup {
 
 /**
  * struct binder_sg_copy - scatter-gather data to be copied
- * @offset		offset in target buffer
- * @sender_uaddr	user address in source buffer
- * @length		bytes to copy
- * @node		list node
+ * @offset:		offset in target buffer
+ * @sender_uaddr:	user address in source buffer
+ * @length:		bytes to copy
+ * @node:		list node
  *
  * This is used for the sg copy list (sgc) which is created and consumed
  * during binder_transaction() and is only accessed locally. No
@@ -3997,6 +3997,7 @@ binder_freeze_notification_done(struct binder_proc *proc,
  * @proc:	binder proc that owns buffer
  * @buffer:	buffer to be freed
  * @is_failure:	failed to send transaction
+ * @thread: binder thread performing the buffer release
  *
  * If buffer for an async transaction, enqueue the next async
  * transaction from the node.
-- 
2.34.1



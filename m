Return-Path: <linux-kernel+bounces-899857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A54EC58E9B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46F904A4C91
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADD0366549;
	Thu, 13 Nov 2025 16:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWEFJ+4D"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E268E364EBC
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052156; cv=none; b=cRUDKh6cObvLHKiuL8P7rrakJR89g9RlYC/xIAa5tuad9rwIQAYD9BtGR13JCazFqnLT3OniLffdp08fRNFFJCEh09S1ZBrPP/xy7W4jjfE64e9hDJIQPkigjYesDAoqG0hNW2DBYoNC5r8i3NaAl4IsQnCK/9daZb71JjZtd0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052156; c=relaxed/simple;
	bh=Weou4cUBuJ16J994m9Jw12hAclJS9i+Gx49oiGHsCsU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tVMYmD6xvEv6MA/9ZWFK0dnfEB7xG2pZCaujnpYyDS1qRlJWaNU0IoYEhOnICvfWYPslog0ZbN6sPWtKI8vVJP6XhnCFH6l+SnbhmsZkg6nNMim3LzWOHb3H5wKzJZTaCW0cGTv18wBZUcuNKb0HzdeppsMv09h5SMO+91Nw1ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWEFJ+4D; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-477774a878aso416475e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763052152; x=1763656952; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1hVzY4UcjZPSPLTWhsYT/R2QUElmT1sTuICo+mmiFn8=;
        b=IWEFJ+4DL/wy3+wN8YGUOIG92GC4IQERsK6S5w9DEXeTpZvWgW8LNzLpcld8NKSNlJ
         sCHbTEwdYzYj8dvXDUyPS2geINyWQ0i1MzVFsnfeKiupBzxwEVsdmX54tf0mQOwZeUQe
         CmRkRIbxpKCiO8i1R30QSUETpS4yNU4J31j/ZU6U+vRLawShMFL1wf/1lF272CrmcNdS
         E8Dmf94Js9XpgQKXZO3JB6QprrT+jiwziO2zKzPAdkAjwy7RNeaYhxq0gvWEfiOcrSYL
         jlzHGaNCdgup6jo4XcXS1C5yD7H0IpSY0rIQayexy8k3bO8HevF1368UObB150h3+wic
         cenA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763052152; x=1763656952;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1hVzY4UcjZPSPLTWhsYT/R2QUElmT1sTuICo+mmiFn8=;
        b=D5+6nPTyBuqNp7rEsoqKqqNn9SuiHRXl7KPCpVsUQdfElYrevEACHmnetxiPacaXcW
         dSGBKFqmoyT6bzuHOyfyxDtKErIKaRWEsb6qvrFWlQEEXlSLGitG2h4W2slwy0LS2hLI
         twzIjD2B/GsS7mMvmTUgpxANCG0HYud9ck2QpmzXiwJtq3bIq5Vms4e2ki7Ls10gQgmi
         SiEVEJTVGKDrqHxAaji5bfEvnNw8PO2Iec5ZFeKWg2SRl8ctRyQ8MNxwpWqtnVW+92EM
         Vyim06jguRmkTA6qwV91qeqWShIOSekv+NUsDEyjbcNxMy+CCJVZFIbDyaA0MIAdByvo
         0vJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWExyKGiQK/DjZERlUbzp5F6ut6sxgk+BeDi7ktLfjvOcC5nDIeY3LeYR+axDyq8rBYC3MhfDb3+o7sAAY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4BM8QK8DjXCk5j/6CteLLWZ3XB5cSExVLmpJfY2J7uaHS8ChE
	Ce23MPAoWpBxQ65gOAmyyDhZqBScOSPRqxIU2WyGSGgVHdZDTRlvEZY2
X-Gm-Gg: ASbGnctJFCB3WyDvvHsZh1oQn20K6TXAUH9Fp9RUcFDuVFQS/ufl0Gc30mYM3etL9ET
	ZCH40uCWhOGl3rFvAy66MT/mcr35tLXVNxyhGFB+BrZUza5rqeWNwE+cNUJ7v9AVQn8IWXCK73f
	Hzo8tMAdmklzdANKpR1UmGAxIlVWyj8mO1Ib2QvnSdN9i/bh9FhnXa/6jD2AYFF1EAfnz+vuSJL
	OTwGS0+KY9tFtHon4jONH02xbF4Qp8AsLKZlHq++9JqZWYBr7zTI4Tac1QaoH39L1pSJeLTHy7Z
	8flbCnWA/mjfR07FUFw5mYMO2M0vEc67gVrsCgWlqU1m1HikqLggu6mwl0ppPKvsiOk34SPq//F
	kcahvHPbCtxtvrD8L4kKAEr+uY9EXEgyrFf5NZCQ5hPbQzUx01KLTAOkuEhVJDvTbv7OopPSK9A
	/ejeuh7deloVq0RLwI/J0d8Mq1SQ==
X-Google-Smtp-Source: AGHT+IGL/X4HO9I7flrMiWlzkMQGvXs40YCMrVJCpAD7fTFYE/9mwv7lP2H6UO+hyYu+NjKatOjUZQ==
X-Received: by 2002:a05:600c:3b19:b0:477:555b:3411 with SMTP id 5b1f17b1804b1-4778fe5c885mr734175e9.1.1763052151844;
        Thu, 13 Nov 2025 08:42:31 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:43::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e8e6a1sm96002735e9.11.2025.11.13.08.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:42:31 -0800 (PST)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Thu, 13 Nov 2025 08:42:20 -0800
Subject: [PATCH net-next v2 3/4] netconsole: Dynamic allocation of userdata
 buffer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-netconsole_dynamic_extradata-v2-3-18cf7fed1026@meta.com>
References: <20251113-netconsole_dynamic_extradata-v2-0-18cf7fed1026@meta.com>
In-Reply-To: <20251113-netconsole_dynamic_extradata-v2-0-18cf7fed1026@meta.com>
To: Breno Leitao <leitao@debian.org>, Andre Carvalho <asantostc@gmail.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Gustavo Luiz Duarte <gustavold@gmail.com>
X-Mailer: b4 0.13.0

The userdata buffer in struct netconsole_target is currently statically
allocated with a size of MAX_USERDATA_ITEMS * MAX_EXTRADATA_ENTRY_LEN
(16 * 256 = 4096 bytes). This wastes memory when userdata entries are
not used or when only a few entries are configured, which is common in
typical usage scenarios. It also forces us to keep MAX_USERDATA_ITEMS
small to limit the memory wasted.

Change the userdata buffer from a static array to a dynamically
allocated pointer. The buffer is now allocated on-demand in
update_userdata() whenever userdata entries are added, modified, or
removed via configfs. The implementation calculates the exact size
needed for all current userdata entries, allocates a new buffer of that
size, formats the entries into it, and atomically swaps it with the old
buffer.

This approach provides several benefits:
- Memory efficiency: Targets with no userdata use zero bytes instead of
  4KB, and targets with userdata only allocate what they need;
- Scalability: Makes it practical to increase MAX_USERDATA_ITEMS to a
  much larger value without imposing a fixed memory cost on every
  target;
- No hot-path overhead: Allocation occurs during configuration (write to
  configfs), not during message transmission

If memory allocation fails during userdata update, -ENOMEM is returned
to userspace through the configfs attribute write operation.

The sysdata buffer remains statically allocated since it has a smaller
fixed size (MAX_SYSDATA_ITEMS * MAX_EXTRADATA_ENTRY_LEN = 4 * 256 = 1024
bytes) and its content length is less predictable.

Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
 drivers/net/netconsole.c | 84 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 54 insertions(+), 30 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 1bd811714322..12fbc303a824 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -155,7 +155,7 @@ struct netconsole_target {
 #ifdef	CONFIG_NETCONSOLE_DYNAMIC
 	struct config_group	group;
 	struct config_group	userdata_group;
-	char			userdata[MAX_EXTRADATA_ENTRY_LEN * MAX_USERDATA_ITEMS];
+	char			*userdata;
 	size_t			userdata_length;
 	char			sysdata[MAX_EXTRADATA_ENTRY_LEN * MAX_SYSDATA_ITEMS];
 
@@ -875,45 +875,61 @@ static ssize_t userdatum_value_show(struct config_item *item, char *buf)
 	return sysfs_emit(buf, "%s\n", &(to_userdatum(item)->value[0]));
 }
 
-static void update_userdata(struct netconsole_target *nt)
+static int update_userdata(struct netconsole_target *nt)
 {
+	struct userdatum *udm_item;
+	struct config_item *item;
 	struct list_head *entry;
-	int child_count = 0;
+	char *old_buf = NULL;
+	char *new_buf = NULL;
 	unsigned long flags;
+	int offset = 0;
+	int len = 0;
 
-	spin_lock_irqsave(&target_list_lock, flags);
-
-	/* Clear the current string in case the last userdatum was deleted */
-	nt->userdata_length = 0;
-	nt->userdata[0] = 0;
-
+	/* Calculate buffer size */
 	list_for_each(entry, &nt->userdata_group.cg_children) {
-		struct userdatum *udm_item;
-		struct config_item *item;
-
-		if (child_count >= MAX_USERDATA_ITEMS) {
-			spin_unlock_irqrestore(&target_list_lock, flags);
-			WARN_ON_ONCE(1);
-			return;
+		item = container_of(entry, struct config_item, ci_entry);
+		udm_item = to_userdatum(item);
+		/* Skip userdata with no value set */
+		if (udm_item->value[0]) {
+			len += snprintf(NULL, 0, " %s=%s\n", item->ci_name,
+					udm_item->value);
 		}
-		child_count++;
+	}
+
+	WARN_ON_ONCE(len > MAX_EXTRADATA_ENTRY_LEN * MAX_USERDATA_ITEMS);
+
+	/* Allocate new buffer */
+	if (len) {
+		new_buf = kmalloc(len + 1, GFP_KERNEL);
+		if (!new_buf)
+			return -ENOMEM;
+	}
 
+	/* Write userdata to new buffer */
+	list_for_each(entry, &nt->userdata_group.cg_children) {
 		item = container_of(entry, struct config_item, ci_entry);
 		udm_item = to_userdatum(item);
-
 		/* Skip userdata with no value set */
-		if (strnlen(udm_item->value, MAX_EXTRADATA_VALUE_LEN) == 0)
-			continue;
-
-		/* This doesn't overflow userdata since it will write
-		 * one entry length (1/MAX_USERDATA_ITEMS long), entry count is
-		 * checked to not exceed MAX items with child_count above
-		 */
-		nt->userdata_length += scnprintf(&nt->userdata[nt->userdata_length],
-						 MAX_EXTRADATA_ENTRY_LEN, " %s=%s\n",
-						 item->ci_name, udm_item->value);
+		if (udm_item->value[0]) {
+			offset += scnprintf(&new_buf[offset], len + 1 - offset,
+					    " %s=%s\n", item->ci_name,
+					    udm_item->value);
+		}
 	}
+
+	WARN_ON_ONCE(offset != len);
+
+	/* Switch to new buffer and free old buffer */
+	spin_lock_irqsave(&target_list_lock, flags);
+	old_buf = nt->userdata;
+	nt->userdata = new_buf;
+	nt->userdata_length = len;
 	spin_unlock_irqrestore(&target_list_lock, flags);
+
+	kfree(old_buf);
+
+	return 0;
 }
 
 static ssize_t userdatum_value_store(struct config_item *item, const char *buf,
@@ -937,7 +953,9 @@ static ssize_t userdatum_value_store(struct config_item *item, const char *buf,
 
 	ud = to_userdata(item->ci_parent);
 	nt = userdata_to_target(ud);
-	update_userdata(nt);
+	ret = update_userdata(nt);
+	if (ret < 0)
+		goto out_unlock;
 	ret = count;
 out_unlock:
 	mutex_unlock(&dynamic_netconsole_mutex);
@@ -1193,7 +1211,10 @@ static struct configfs_attribute *netconsole_target_attrs[] = {
 
 static void netconsole_target_release(struct config_item *item)
 {
-	kfree(to_target(item));
+	struct netconsole_target *nt = to_target(item);
+
+	kfree(nt->userdata);
+	kfree(nt);
 }
 
 static struct configfs_item_operations netconsole_target_item_ops = {
@@ -1874,6 +1895,9 @@ static struct netconsole_target *alloc_param_target(char *target_config,
 static void free_param_target(struct netconsole_target *nt)
 {
 	netpoll_cleanup(&nt->np);
+#ifdef	CONFIG_NETCONSOLE_DYNAMIC
+	kfree(nt->userdata);
+#endif
 	kfree(nt);
 }
 

-- 
2.47.3



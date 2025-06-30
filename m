Return-Path: <linux-kernel+bounces-709695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D107AEE12F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 16:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 999DB4025B3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 14:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADD028DF4A;
	Mon, 30 Jun 2025 14:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UEf1HAsj"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AA528D8E7
	for <linux-kernel@vger.kernel.org>; Mon, 30 Jun 2025 14:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751294178; cv=none; b=ZspN45El9/FIStttIJ+MXLdiaY+j3jfMSSoPgX9xInKBJkSE0YY7XuB++BoeAzI2dUjrVVNQ1OgjpA1zeatuabSstiJSX1tdsYuPp67CfnboHY4sLoRCJMXsTTXBAggiQhHasTY5BOGgnXchOxtPcX+JS7OXKG2TehYIqLDe+Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751294178; c=relaxed/simple;
	bh=WGV704Eo/1OZH4+nrAQdrHsDuKUNEEzinf+2Kc0d6hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ndZPv+xwiBZYftDmAbm385HHAFhSt1QCwpsYLosbPRVkKDz5FK6tJmQJy/zk5SqFClKM7kdw1qcOaU5QtK0X8rDeu6pNO6Hri1tcw/V3FbZ9pOjCyS0sONWujkAhPRBp34FikB57g7jrt63b168eIN3AXDKsKmBOu9+V8+2mLYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UEf1HAsj; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4535fbe0299so12899995e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jun 2025 07:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751294173; x=1751898973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYGr+w4GfcUkgYiVXycPX4UxZzSKxs2cIGs5isKRNhY=;
        b=UEf1HAsjZsitoMXcpw7QOe+2Fw5eHKJeBoA2QBD5Euxn9+YmBOeRDhzmOHJhl/ide5
         qWiXiB/eOJFXDCJWwxL/+GjmVqvL/RNQoF+PQTdwmnbwkC+MFWp/fzAHid+WIwVCRH7R
         1/2h+BZ2NbCtsL8yrGNWbpn8kUlaA9roZ4z9PWwL3tgnWZM7nopXwh2twC4B+yT/idgP
         ntP6zKwp9wV5D+mFFS3lcmfuiFvNFsNAwafC6hQjSpQDu4xri4jRT6cJrT2Rtr0y9ZWb
         Vvg0Kc/iM/EduRv5UvAC/OLdM2rlNEKzZMUgUHRHB/Sc0F0GELoIv/S2bcWGODPrSMTx
         8AZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751294173; x=1751898973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CYGr+w4GfcUkgYiVXycPX4UxZzSKxs2cIGs5isKRNhY=;
        b=IMrsN+v5oVGO1LRpxTUhfl4Nn67dqDwyinlRLQsmd4IKKbPoIJ0fZSThgik9yQBi1m
         o/GWPBKZn24Lm7DpfoQTnhgfiwkCtLQVXwIzPgPOGrWmqaP9CpsC+0L8FYFF2pzDtZvG
         ZkX/z/yJb4YIxc01Cm83WerogrVlTbk3sGF4DtL+oUas3JQRDPFACx9VVHhk35zV/sS4
         MQ3z7JRIIcXr5mlogmZep6E5/LBFB2vkq3oMLuyj9s3rFTrhxoW9xSnkvUdshHsf2R6n
         V/9OnAB+9BlDyi/GnCmPUS2DAul1wWxqLUGfzxiUsAxQx2gLmPaEB7592JT8QMCZRclT
         Fsgw==
X-Forwarded-Encrypted: i=1; AJvYcCX9vYCFjqZEULf7uqJXtP0QgMdhRQ/lQm9aWLT96nemKInq9LPyTg0k2g5/kyk7LKIyljgTiTNasZqmcCI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfhw8wSWsWSyfxiFkLWmjX5kAJxzz4TvDfGOTcFHcBImY0FlWL
	YeBUVPN+aGvkpkjiTLRmA8GTsy8OLddzvmNdmBzzyHG0DiAek0YbesaS/m99leVM+i4=
X-Gm-Gg: ASbGncsq7Pi63tkYF/RWLVXGdLR4VARxXQZR1gW4R3pcJiaTOgdjpxrsE95CpABKcen
	dQw3is5ZQkW3s7qVMsupcdUHOepwrS9BM0p+iWwar2i4MCPQnnMa6D8SQbikxxMi48yG1Ej7rtX
	hPN4nqQnF40nvd/dQSdBWhY87cSbWxNf3TtIKDzOXhv2kQpfVU28Y0W2Yz2bCAuE5ImtyW+qO1Z
	3t5l4ZKXuUBw7qDZ78chab55FnS/qyHfsSFp0oYb5u/A8plvYn9X7nfF+RABLKS5iKVNf1GBME6
	vN5SzPS3zkiSBxnVDZJ6kDv95waL4xifqo6/R7i+rauk1CcwxB7omJ5iXqKT6g==
X-Google-Smtp-Source: AGHT+IFKdSX/7On1Q0wj0XjtBIz1cLSj6YHaIR75PLNUipp/xh/X/AUZR64SxbA4mNUTIjWDWDxDXg==
X-Received: by 2002:a05:600c:3112:b0:43d:26e3:f2f6 with SMTP id 5b1f17b1804b1-4539ebf5521mr48135765e9.5.1751294172898;
        Mon, 30 Jun 2025 07:36:12 -0700 (PDT)
Received: from zovi.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a4064b1sm139691695e9.29.2025.06.30.07.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 07:36:12 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>
Cc: linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] module: Restore the moduleparam prefix length check
Date: Mon, 30 Jun 2025 16:32:34 +0200
Message-ID: <20250630143535.267745-4-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250630143535.267745-1-petr.pavlu@suse.com>
References: <20250630143535.267745-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The moduleparam code allows modules to provide their own definition of
MODULE_PARAM_PREFIX, instead of using the default KBUILD_MODNAME ".".

Commit 730b69d22525 ("module: check kernel param length at compile time,
not runtime") added a check to ensure the prefix doesn't exceed
MODULE_NAME_LEN, as this is what param_sysfs_builtin() expects.

Later, commit 58f86cc89c33 ("VERIFY_OCTAL_PERMISSIONS: stricter checking
for sysfs perms.") removed this check, but there is no indication this was
intentional.

Since the check is still useful for param_sysfs_builtin() to function
properly, reintroduce it in __module_param_call(), but in a modernized form
using static_assert().

While here, clean up the __module_param_call() comments. In particular,
remove the comment "Default value instead of permissions?", which comes
from commit 9774a1f54f17 ("[PATCH] Compile-time check re world-writeable
module params"). This comment was related to the test variable
__param_perm_check_##name, which was removed in the previously mentioned
commit 58f86cc89c33.

Fixes: 58f86cc89c33 ("VERIFY_OCTAL_PERMISSIONS: stricter checking for sysfs perms.")
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 include/linux/moduleparam.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index bfb85fd13e1f..110e9d09de24 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -282,10 +282,9 @@ struct kparam_array
 #define __moduleparam_const const
 #endif
 
-/* This is the fundamental function for registering boot/module
-   parameters. */
+/* This is the fundamental function for registering boot/module parameters. */
 #define __module_param_call(prefix, name, ops, arg, perm, level, flags)	\
-	/* Default value instead of permissions? */			\
+	static_assert(sizeof(""prefix) - 1 <= MAX_PARAM_PREFIX_LEN);	\
 	static const char __param_str_##name[] = prefix #name;		\
 	static struct kernel_param __moduleparam_const __param_##name	\
 	__used __section("__param")					\
-- 
2.49.0



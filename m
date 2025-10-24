Return-Path: <linux-kernel+bounces-869227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3925DC07583
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BAA21881C75
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312CB27EFEE;
	Fri, 24 Oct 2025 16:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDXnk4v6"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C49026ED2F
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 16:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761323776; cv=none; b=IW8QuByaEuKhm0e8PC75CBYhpSIz4M3St2cFuztTdTI1iCWrN7F+0Yi3n2yZAYUP0q7tvl93kPnNKiJ0NQfHXLBwLHugvtWvRSPLRy/LeMo1KkxNPVzeJs4sHthcsV2UZltCaCZcteamOXcp558aYN2NZqPHnQZWQv0EMzcIJOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761323776; c=relaxed/simple;
	bh=Qzgh4TwmdqAlsGKEFX9L3ufviEEfHBTNxvxl57muGoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k4zHxK/UffWd5ugS3MNkyRSYURbOJf8yZ2FBm2lmWNiykby5htuK543ECTmSih+25Om5t8sT2frSTpabuSqdS6ftHC/5yAlrI9n+ZYnMnlNRVkwERGZl4w9GrSuZ5ydMYkZhpkK4kfwrKDP/IBHfvO1cEfHxKHBVktAoZi845sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDXnk4v6; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-81fdd5d7b59so22071996d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761323773; x=1761928573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBtuboWe2Q4Plv4p7qqEyz/yAU9YybNXJhSJ5Y5XAWw=;
        b=MDXnk4v6AJ+waf0J0A8j7nuXNvOw48j+irRaQNHc/IMFaEYRJoU+N0mN+wyQnYjw4D
         UfE+KCzaekNifpmu6ejJdMWWXnBcORVhQJCfIxckXMbbfVZZvYeKFUmw/SmVoTP3T5gk
         H4l7pBoQwJsPTfQOUhXFQEWl3t4RCnK8kejg0njU/gCDzpJ/Li4tR38ZoL9TkvGp1rSl
         GZEV6GlsC5qQ8gZQ+PsSEIMqA5EacjyuY0AzGjSykBNGlnWlTJPEdgFm1hYcT4lvDPeW
         ZD9+93kz+b5v+7e/nN10QyalYO84RTAgANi/BWFQgRdzs5xzdTDf0iQN6H5d1iNqfni3
         sQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761323773; x=1761928573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QBtuboWe2Q4Plv4p7qqEyz/yAU9YybNXJhSJ5Y5XAWw=;
        b=hfwhiLDU6IRA1hGWkP+kZMx+GpfkWxnwRk+3pok2K4Tt0p27tGj49OEka2IWtGiq0e
         ttAHcgVWbhLzjZF7ygUoQg51+2ug6vit+yZvFyXKGHOyoUzRGXJh8E1ZU3T2K4A6tSvz
         0ydXs+jao5NJ+vtS6FZOWvbGw5QAhzXJwZlTcbOYBDAs9bzNS/wlxzj5fyVf4s057XLE
         iykKviseJW8BWkrMdm/ZGMZAVt7AatkgTNk0Z5ajWV5adIsdYxjj/M8wtlEGyLt9r8OY
         YGlQiikeHe34Anr1tJA4g/ojCUhyCqemvmrIfTBsAEgd1Qi4MtSRGiILrygAIjhkvgUy
         CQjw==
X-Forwarded-Encrypted: i=1; AJvYcCWJei9q+ITBUdTc3Y7tRlAYyDdJ5xB/Z0ATx+j7wpCSPBhZa8zLmWVUXTpQwssavSbiWp7FSXJ91Xj3ZU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcyAd1Wl29v2HjlVcXkZFv2a0OwSL3u+E8H2GjO1DB9hHsqkl1
	YXNITbrdY8I6JR+bl1qxWJcBY9UntVkhBZfthdm+R4cRBGD1xk2bmZLI
X-Gm-Gg: ASbGnctMGQgpUzRJ+DZa6baoezmEJO73U05oXaSw8yKDrofwqsELGs3o47cqxXrtFEj
	rH7dfkUZ6mKcz14QqwfFG9L0nsJ2nKERPMhGNgwCHsTuWe8v/SiU+GErGnTYNPf+1jwCxvLFftO
	06AvCw5jnoduQMZ6dsBlEy3yUOSWUXgMpMXIZTEKZENaX5/bHR6m9pGroVrJNE0JCmZyFzfDdUV
	r1v5NwcqVDpdj67Vh1QWMK8WIFoTpZ1yYyDMswVqLdcrq3ND/WRfvtlCy31QehhBJw9iafieFq1
	vnvHK+5hNxQ2ba2TLq1nwoLzIu6ftVGqYiLZJWOHCC1ZKkn4aV3ubvCNqkEd76m+VgIqw8U0MHp
	oNsn958WBnelN0k3x1d/PTITpfQVCGECu7TGnC8pMYubSUfg+uLfPkaiz24uOuwqCbU1H1NyiIb
	IZKvsy4STLjO9JhTVGfGyRULmv4BBd9XU=
X-Google-Smtp-Source: AGHT+IGKHP8NoxcYy/C47NubjPRMEfZKuZ2ykE1dPkqqxoalIE1zRnG5oQpATNvC6wV2Okf3syX3pA==
X-Received: by 2002:ad4:5cea:0:b0:798:513e:3bd with SMTP id 6a1803df08f44-87c20545decmr340344866d6.3.1761323773013;
        Fri, 24 Oct 2025 09:36:13 -0700 (PDT)
Received: from rpthibeault-XPS-13-9305.. ([23.233.177.113])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87f8fb6d2e4sm40908776d6.13.2025.10.24.09.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 09:36:12 -0700 (PDT)
From: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+a9a4bedfca6aa9d7fa24@syzkaller.appspotmail.com,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org
Subject: [PATCH v2] Bluetooth: hci_event: validate skb length for unknown CC opcode
Date: Fri, 24 Oct 2025 12:29:10 -0400
Message-ID: <20251024162912.221224-2-rpthibeault@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CABBYNZJtp0wqL_SJEk0wVo4DuadrBirmJ5VOe_TyE_RN8jOJNA@mail.gmail.com>
References: <CABBYNZJtp0wqL_SJEk0wVo4DuadrBirmJ5VOe_TyE_RN8jOJNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In hci_cmd_complete_evt(), if the command complete event has an unknown
opcode, we assume the first byte of the remaining skb->data contains the
return status. However, parameter data has previously been pulled in
hci_event_func(), which may leave the skb empty. If so, using skb->data[0]
for the return status uses un-init memory.

The fix is to check skb->len before using skb->data.

Reported-by: syzbot+a9a4bedfca6aa9d7fa24@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a9a4bedfca6aa9d7fa24
Tested-by: syzbot+a9a4bedfca6aa9d7fa24@syzkaller.appspotmail.com
Fixes: afcb3369f46ed ("Bluetooth: hci_event: Fix vendor (unknown) opcode status handling")
Signed-off-by: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
---
changes in v2:
- check skb->len before accessing skb->data in hci_cmd_complete_evt(). 
- remove v1’s changes
- update commit message and Fixes tag 

Thank you for the response Luiz. I didn’t want to spam you or the ML
with another reply since you were very clear.

 net/bluetooth/hci_event.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d790b0d4eb9a..d2ac95a824db 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4211,6 +4211,13 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, void *data,
 	}
 
 	if (i == ARRAY_SIZE(hci_cc_table)) {
+		if (!skb->len) {
+			bt_dev_err(hdev, "Unexpected cc 0x%4.4x with no status",
+				   *opcode);
+			*status = HCI_ERROR_UNSPECIFIED;
+			return;
+		}
+
 		/* Unknown opcode, assume byte 0 contains the status, so
 		 * that e.g. __hci_cmd_sync() properly returns errors
 		 * for vendor specific commands send by HCI drivers.
-- 
2.43.0



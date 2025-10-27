Return-Path: <linux-kernel+bounces-872067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE0EC0F3D4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59870565D52
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D3D31062E;
	Mon, 27 Oct 2025 16:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYb0q1IV"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B58630C60C
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 16:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761581334; cv=none; b=M4oM3p5zG1dFekF3GT3lyxpDezcAoWiLQES1qtNHLdnp8wmVAwahKrcQnUj3UXrs3aXV8FlC6u/b183yxUw5CQy2+adRlpkNrFDZhh9bUOtL38mbLsG5rudJT7ZY/IVJDz77drX66S77eu8QD3+UbHlZb2VUjyb7NgK79RAwaXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761581334; c=relaxed/simple;
	bh=fbDYJN+jZ1MymhQBKdbPsKqGnPjINAkJQJSVn0S5FIg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CqoKY4yk/BqXUb0RYp+m1cndIbM4L0gb3Qqdb0HC8QSTqbh9HKioJNtLZVWybDM13RiBmWbkM8dEAa9ByQ+oyTp87k6tM90kwZLIvZeznj98wDReEsFqKrzz4lj431zkqVzx8BgnjQBDaWLOyI6iMxbWnY0QYtM2Sxf2M8xh6jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PYb0q1IV; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42855f80f01so789032f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761581331; x=1762186131; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9+nFHdhEn9QZ3B5n0rJ6cFeS3k3aD4NWWF/na73TE3A=;
        b=PYb0q1IVThG2gforkbn221N9SuOGwPTNqCwPYpt2chtnp2KAruh/zvSb/7WnIfj7Wv
         xQwEfj6XjJAh2Q7pBfQP3EKxNJdn6qEMEa67tlJvl6EP5Or8Fs031Ll70OSjniakdPt5
         EpEnmPKf3T5vhXK3OCpvtPMBvo6wxZH5gudYfF79sZXiTa9PMtoj9Bd4jzry/wM/6VvL
         MgaoyehauUuwjHGz1APWbfBxDixEXlJttQrFTAn9hKV46t0OKfK9cDuU5Gbk1uI1U/U9
         /CO8choEB6fGnOWV37V9489zWFLg3RdYbJPRaYB82g2u3CnlFz56NBoNMS4XEKlIYLVk
         P58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761581331; x=1762186131;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9+nFHdhEn9QZ3B5n0rJ6cFeS3k3aD4NWWF/na73TE3A=;
        b=xEbjO+nMMPJFxzlqVzTb7/vzPGUe8/YbonKdDEnCkN5jAfNJTpr45MnUTZ8GZ/v6Wn
         c4Y7VsF+w2bNumiUaSa7ndPcCudnfotvMjD3Cuz6L3FLD+75ARFnx7DZB9okRFprVI6L
         6J5TKFpJyYUgWo4gtWx/4bnqnGHqSK38WunY82iywjO6T8hRjHcKArC1EK3e6mu2nHi9
         HXH/AvB/01gP1zQoiUXPEVmVQRxTFkKjRmTKsz6cOjc5nAypBJ3y0LaZYKVGmgkqOAGo
         xOubn3WyHMlC3owiIW6LpbA/jXRYqWr1qdTG0mbdwCrQcSmAgMCvNa/CB8MoXAprGAxH
         PPJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLED3NI9SZcv4SZhnEodVA+Lfvy1Ywtnk6hgfdXMYnMWPkgAiqCFGd3eVAXas69APM/Mfa/JXbhiInNEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YySf8tI8NzRl/Uo89S/HjKfAjbqg9Lu/ALpaonpdjyI1CCebDoF
	SDZyRUXcnmeRsCRHeKejmwutNAH/xLMMx1BqWeXtmnCRMOKqV8wa2Hy6
X-Gm-Gg: ASbGncvp35Ji4dVc9l5h8Ez7mEngrgo7NMBlz5LsMK5/Oi9oDbAl5tqtvbpkSxwF9mT
	7TCqPRBPP+lP7BQPyfWgww3DxEOg8erghJ2o9Bt9+hqrevmcImhvcYPr76rUBnCJucihJ363GHs
	gVD/sAIwuQ1SBbYPwIjbwNJgdGb9lLyW02CwwYe3c/M8i8x96NZltpMwbmXy0PAcBKOcJGqTGvt
	Ds2hDZDqHUMY0Yqcelyy+oMe7+YdIWIYwI6pkuu9o0CikGCmgHRs6TA+QFnalGKQW2AH9pU+tD5
	nJ1CfirT32iI5l3SVeBk6FE4uTX8f9h0KnSh4V5DMDU8YLR58M9dVdBa0OdhvGuEuTivLdUL/R1
	+V2E5vbNnpU9QKCSSA4LwyBdZbzKSVGHDJ/iJLrFoWLN6BGRmM/sNx783ngl/h4UzmJO6LkZsys
	OSBoJDBzmHjk7DCr4=
X-Google-Smtp-Source: AGHT+IGvrhg+F72g/BI8ulMkITIB/tcbuDwYGmTzwpOa/eEfVBRFpcZ01FZkRBh2w0gLtr8yteHE+w==
X-Received: by 2002:a05:6000:2911:b0:3ed:e1d8:bd7c with SMTP id ffacd0b85a97d-429a7e35d6emr137633f8f.2.1761581330612;
        Mon, 27 Oct 2025 09:08:50 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:58::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952db80fsm14663359f8f.31.2025.10.27.09.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 09:08:50 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Mon, 27 Oct 2025 09:08:11 -0700
Subject: [PATCH net v3] netconsole: Fix race condition in between reader
 and writer of userdata
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-netconsole-fix-race-v3-1-8d40a67e02d2@meta.com>
X-B4-Tracking: v=1; b=H4sIAOqY/2gC/22NTQ7CIBCFr9LMWgwdiqgr72G6QJxaEgsGSKNpu
 LsT4tLd+8n73gaZkqcM526DRKvPPgY2ateBm214kPB39oASdS9RikDFxZDjk8Tk3yJZx2I46Em
 ZmzZkgZevRNw16hV4ACOHs88lpk97WrFVPyj+ha4opFDK4NArdZTmdFmo2L2LC4y11i9796flu
 gAAAA==
To: Andre Carvalho <asantostc@gmail.com>, Simon Horman <horms@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthew Wood <thepacketgeek@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gustavo Luiz Duarte <gustavold@gmail.com>
X-Mailer: b4 0.13.0

The update_userdata() function constructs the complete userdata string
in nt->extradata_complete and updates nt->userdata_length. This data
is then read by write_msg() and write_ext_msg() when sending netconsole
messages. However, update_userdata() was not holding target_list_lock
during this process, allowing concurrent message transmission to read
partially updated userdata.

This race condition could result in netconsole messages containing
incomplete or inconsistent userdata - for example, reading the old
userdata_length with new extradata_complete content, or vice versa,
leading to truncated or corrupted output.

Fix this by acquiring target_list_lock with spin_lock_irqsave() before
updating extradata_complete and userdata_length, and releasing it after
both fields are fully updated. This ensures that readers see a
consistent view of the userdata, preventing corruption during concurrent
access.

The fix aligns with the existing locking pattern used throughout the
netconsole code, where target_list_lock protects access to target
fields including buf[] and msgcounter that are accessed during message
transmission.

Fixes: df03f830d099 ("net: netconsole: cache userdata formatted string in netconsole_target")
Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
This patch fixes a race condition in netconsole's userdata handling
where concurrent message transmission could read partially updated
userdata fields, resulting in corrupted netconsole output.

The patch fixes the issue by ensuring update_userdata() holds
the target_list_lock while updating both extradata_complete and
userdata_length, preventing readers from seeing inconsistent state.

Changes in v3:
- Drop testcase.
- Link to v2: https://lore.kernel.org/r/20251022-netconsole-fix-race-v2-0-337241338079@meta.com

Changes in v2:
- Added testcase to Makefile.
- Reordered fix and testcase to avoid failure in CI.
- testcase: delay cleanup until child process are killed, plus shellcheck fixes.
- Link to v1: https://lore.kernel.org/all/20251020-netconsole-fix-race-v1-0-b775be30ee8a@gmail.com/
---
 drivers/net/netconsole.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 194570443493..1f9cf6b12dfc 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -888,6 +888,9 @@ static void update_userdata(struct netconsole_target *nt)
 {
 	int complete_idx = 0, child_count = 0;
 	struct list_head *entry;
+	unsigned long flags;
+
+	spin_lock_irqsave(&target_list_lock, flags);
 
 	/* Clear the current string in case the last userdatum was deleted */
 	nt->userdata_length = 0;
@@ -918,6 +921,8 @@ static void update_userdata(struct netconsole_target *nt)
 	}
 	nt->userdata_length = strnlen(nt->extradata_complete,
 				      sizeof(nt->extradata_complete));
+
+	spin_unlock_irqrestore(&target_list_lock, flags);
 }
 
 static ssize_t userdatum_value_store(struct config_item *item, const char *buf,

---
base-commit: 84a905290cb4c3d9a71a9e3b2f2e02e031e7512f
change-id: 20251020-netconsole-fix-race-f465f37b57ea

Best regards,
-- 
Gustavo Duarte <gustavold@meta.com>



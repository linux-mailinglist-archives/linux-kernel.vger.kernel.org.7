Return-Path: <linux-kernel+bounces-749442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE80B14E73
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 15:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DC461888FC0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 13:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88BE19E7D0;
	Tue, 29 Jul 2025 13:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1QjtIfG"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9212A8F54;
	Tue, 29 Jul 2025 13:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753796148; cv=none; b=G8j+rl/oFzppZj6FDXYTRpQeGflF6QHOCXCBGI8StJk9J0X+vcxZrV0rd8FsNrfBmnJsr1+gb8VdpWfpUWxQpqJV5QuD9dcsou1FWdJCm4TGO+o2sbEwAlcUc/tJffcdNEDIsC/THUE4BS6fsWjIIGh24rc/am3XXzckOuICICA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753796148; c=relaxed/simple;
	bh=mXlo4P/Opfl5AHG129TMBtEeUm58/2c3wqIIOBMg0cE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A3p3xyae6nHSm4HhYYMZKVzQkYLe1rAJ2hrrF5F8Ya3vcd96aVfyxz7UzVmYlh3ZhXrNxn7Atc6aV1KuyWMo8/0whr+xZqMT7IlXqDfzPTdwx2p6oUHqL1KSQNfpZ8v5KPUB/e3ySzZ/fyMWSFd3E1K0uTGAaNSystkuI7e3I0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1QjtIfG; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4561ca74829so58136225e9.0;
        Tue, 29 Jul 2025 06:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753796145; x=1754400945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XVjYN8k5tT8FBgII2f3KKZiqL7dspTHCb/x3jGyFDhc=;
        b=e1QjtIfGD5aw9v8QlWpKg1I+5fCHNYw4judlXZHUDyxBiyTtRWQ2JFZqP8p6lUx8/O
         Iz3Oipn2epnvexGicXF+2J/QfQxCoC7qxr5ur+eBzTv7DT8f8cdTcJFK1+hfkqpXxXkY
         zdkSJtgafGFXFxWS3Rq60XIOeCrcHDNm320UCtfw1OvmYupURKgSmlY8d/eFnSrkHjSU
         pzctx1oRUV4aHXB+me8VB0Bi+qa0nERpc8mx/I+0FoQxuqSUAmLfbzlfQr1L6I4cPA2N
         M86GvW8aMfhkGE4P6YKYtDnRXgpeqzk606pTXEeC5ERnDTiclAt1VtuWxEpsP7k2Zdk6
         wkjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753796145; x=1754400945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XVjYN8k5tT8FBgII2f3KKZiqL7dspTHCb/x3jGyFDhc=;
        b=wFxUt4BfraIvQVHeEa+sTGyl6inwsdmCO/adU9VydMJULpSbMjjM712i/kxfNcGqWJ
         T8P52JGPC3S3KU+HARP59eoZJNXeY4vLFkYyM673FaVLlZ+0qwPo0bg0GMKBxEzUcahT
         cBgBk7rKEAe7I8RISY0lNjIKW9cCiNfWhDkb/Hj/VSsZmfqAwVXZAh2ZRFEZ5SNBmhVR
         VYMqAVyRhqLPZqs7oaK3gMeYuH1YTABN129+1hQnfVAk3KV55RRP+Ek/2fGth8pRoOLW
         r7mGaBuUPb+bdfsPr3TmO8DTOwy1MPCQ6M1ptSxSFcoepOB0HTH7zB73X6Oo5BVNPNZo
         Kdlw==
X-Forwarded-Encrypted: i=1; AJvYcCW8uhXBIVEXg85NQj3XVpc6W93nkkvjBhZj5WwFzjPFOw+phwOGhawTZFk5lLjGyBeMgBVl9oEBwNfbcwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOQzPm0Om+mJ5ahByVmHVUwVXLzwsHbuc4Yxb5ZqPLnA++Q9vP
	ptiS0cGHCTPwE/f4PTZ6u47Jqti508Uu/GD7ChRgP4KBekoADGluctER
X-Gm-Gg: ASbGncusJLSMp8BeBJgebJyfll3mAO1sVJUMkTvJj5rSzVKkTq8Z8ZvX8kGyXUqSFzQ
	uVM6ZHkZr3Cs6jtpGp1fyRsd1fzolVQouK+yATNH//sVAlziSAbG/xhGKbWtMF4aRJoeWZUQjRq
	eBcMOSvVa9CPgpl8OqzgIezwboDOt9zuSKUq8Q36blA4b9sPBzUNoo2nkqUquldCg/BNmNr55Jw
	KMh3RXx1RMnP7ThU3672adQtIe9GJtx2s8JFUWdiscCQg4ULR1wTCsKezenpFtd6I+7SyXKIUqY
	awuSOyfalxheMdEc/jDxPY1Mur0nuOcQ4Ns0i7vUg+SqziYU47cOT3qOlRr/hLVsAhllNqu1HrW
	Y/jctw9PhunmlAXRd7d/b
X-Google-Smtp-Source: AGHT+IHX1SA/PEJXzQCtDohLcARQ+FKdp0aj3Rxt6VkK4mHam7dWUOKN4l3AyCbxq6ugirxVTrBVsg==
X-Received: by 2002:a05:600c:3e0f:b0:456:f9f:657 with SMTP id 5b1f17b1804b1-4587ce6c8f2mr97488695e9.27.1753796144810;
        Tue, 29 Jul 2025 06:35:44 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4588e5e6232sm26161555e9.32.2025.07.29.06.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 06:35:44 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Mike Marshall <hubcap@omnibond.com>,
	Martin Brandenburg <martin@omnibond.com>,
	devel@lists.orangefs.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] orangefs: Remove space before newline
Date: Tue, 29 Jul 2025 14:35:10 +0100
Message-ID: <20250729133510.1934993-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There are a couple of instances of an extraneous space before a
newline in gossip_* messages. Remove the spaces.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/orangefs/inode.c            | 2 +-
 fs/orangefs/orangefs-debugfs.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index a01400cd41fd..ac1469a0d663 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -246,7 +246,7 @@ static void orangefs_readahead(struct readahead_control *rac)
 			&offset, &iter, readahead_length(rac),
 			inode->i_size, NULL, NULL, rac->file)) < 0)
 		gossip_debug(GOSSIP_FILE_DEBUG,
-			"%s: wait_for_direct_io failed. \n", __func__);
+			"%s: wait_for_direct_io failed.\n", __func__);
 	else
 		ret = 0;
 
diff --git a/fs/orangefs/orangefs-debugfs.c b/fs/orangefs/orangefs-debugfs.c
index 1c375fb65018..4582f53bb2d8 100644
--- a/fs/orangefs/orangefs-debugfs.c
+++ b/fs/orangefs/orangefs-debugfs.c
@@ -985,7 +985,7 @@ int orangefs_debugfs_new_client_string(void __user *arg)
 		/* Build a proper debug help string. */
 		ret = orangefs_prepare_debugfs_help_string(0);
 		if (ret) {
-			gossip_err("%s: no debug help string \n",
+			gossip_err("%s: no debug help string\n",
 				   __func__);
 			return ret;
 		}
-- 
2.50.0



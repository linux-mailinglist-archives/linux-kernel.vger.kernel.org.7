Return-Path: <linux-kernel+bounces-822079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8B4B82FA4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E115A4E1AED
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 05:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE022C0F81;
	Thu, 18 Sep 2025 05:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLVw5tiD"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7642BF3D7
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 05:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758172615; cv=none; b=EBlesjFf1pERI78i4KStFZW5J/FC5cLURMnyGVldq6tc2RJBAeCR9YlEEDJOU0mDWS/vazsYef+R6ByoQHAekejittemhIx4GvpbCNvzE3iPN0K9F+22WJi3K13gCnJsbyRN5fOb9XFLFWVAOESJQ92FfI9vX7srZzlzAm8OulA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758172615; c=relaxed/simple;
	bh=kvY4llqgRsxBvMcZ/CXo6FHDMPIg9Hmu3RD2Lrj2HZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gdkxLPm5zxJRDi8NprEJ8VEM1qS0NF1RjxGSlVaq5BHPWOAZnlFgIh/mIz89ZWOewHjq3a69t5N3ySJneTybdZ1umMdQ6MdLUJyNFnf0GYPE6kjZ+Hh1yvxEitJT1iZyxuof0XhfXsBYYa9HGy4m66BOuvqucOIABb0L9GvrGfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLVw5tiD; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2680cf68265so4432145ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 22:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758172613; x=1758777413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SfaLR+xtvYbSj0Yj5pLhRxT8PrYzixVb/sw/K5Eb4uM=;
        b=gLVw5tiDMmHT8ZLqPuBL1+FHXudrVGdojSG0wiaa/PzVvyqgWhniaWXw/wRa7Rw1lS
         rBB1wxmkDeDBScSOrhiHQJllgUolHJD6ecXCHO5MB4k/84GfRjN8CDci+V1bUPlmintx
         QwGcik7cqE92RslU0v7Qfdw89TCFbJObOAeId9/F0JxTfKpoO97w7iEFiZhKyoGWcv4H
         /r+gkkLtuWQJhJx1FTANMlMiX35B3KfFNPV58qHoQg7aWemZZCWuVxaSwb546S/Mb8wJ
         dZ/wxKNpcaCsdTf+dwGFe30qTh16JrQ9aTMEKbqan7p+LuqGNFUc9vXCXpGXJ+ICqEAW
         ynfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758172613; x=1758777413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SfaLR+xtvYbSj0Yj5pLhRxT8PrYzixVb/sw/K5Eb4uM=;
        b=rC8CkpOhtw+1BFLgE0N3DRPQngTNYQCdY/NBgxhUSPVYnZTyvu6mRA1zfyhpEuSFFw
         dK8pz4/rM01W6DDO05nK+4fsFY6zpyP9m3GVYF09wPXlDR479sRt54w7asq52Mc4T2Rw
         9jukyLJ1pqAcDjqAEyDKOOnytLNpfeLqWqlssLrQwewCFMxu+hfRCNyD5YpzlaGs3F7O
         ME4xvmh0Zr1FTHe2W6wBfvU3IV3eIrJmQ6lBAS5CnKxrc8LYcCD3bP26rzXtWmDVTCxo
         EN1hBl5AVTHdyd++xjqBGWse/5hgWmJi15bxtD9V2W2/Wc8lh8J53r1Q0xlJzxDWsn01
         TT0A==
X-Forwarded-Encrypted: i=1; AJvYcCU1qbIN0Lyjo/lthU5IeWYF/QBe2jeXR8mc736bxCxbsXsYSflFFwaCoD29ewJyDEa6yWjvw33aBuFjC9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLVLK8UtpQXMqDhCvXtMWAmhJKYE0XoMzQR/BYAiflGaBxdIJs
	iAViSAvxC8IsL+6pBzXNjUoWrhEK6hi57u4OGeTa1zpq1c2JFFQhVKqtWLyGbw==
X-Gm-Gg: ASbGnctZOLApH+Ess0SfG7v4fD9LggWjCEqZB88QtXSB5mwtOYiFiKZ3cMafR0cJCDu
	1AthM9Gw71c/2u+xlwlqv4cX2hWj3+5x8j0fZC1/225uSQvYJSFTrfRG/AhUZChQQnGnw0WJxME
	B/wxlcRBub8v0fnPv7W0M7zqgnak+z3wyKrymLSsBu8R6udj1zadsscHwlkqWXQLORqRT8nymqh
	PIK/7qv0uvpDuofSCEXKNOmiqI29dQc6NvYz4W11Og8dCnypwWkWK+/sH/oxmvyTFTxqK/bnz3x
	OeQsNOJgqdFncXwBRAhl9nRiwKN2tr158UA0BZzJmUw4sZ+rltR/xaJxHqwJmD4CM8ajrx4PD3a
	RIqHEhUmcdyEaKaMW2AYcUnZbSsWw+pZBxF1ZwcXrjH3nMS+8fQ1kdKFVKQTF8x7rGDNbC5meGp
	Thj6PFFOLSWng=
X-Google-Smtp-Source: AGHT+IEifDbjgR7s6TwejGaq1ZSUhh2KXIkEFHyaKhNV1A4v7AfhWkkpamL+EAMom7TUh85CJvEh6g==
X-Received: by 2002:a17:903:2345:b0:269:6401:7fdb with SMTP id d9443c01a7336-26964018c43mr56230345ad.17.1758172612995;
        Wed, 17 Sep 2025 22:16:52 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3306064edb8sm1208993a91.7.2025.09.17.22.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 22:16:52 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 531001061EF9; Thu, 18 Sep 2025 14:16:50 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v11 12/14] um: change machine name for uname output
Date: Thu, 18 Sep 2025 14:16:05 +0900
Message-ID: <8e75e4e2116d25a2bd6065ed6b53e57b0eb0a86f.1758171893.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1758171893.git.thehajime@gmail.com>
References: <cover.1758171893.git.thehajime@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit tries to display MMU/!MMU mode from the output of uname(2)
so that users can distinguish which mode of UML is running right now.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 arch/um/Makefile        | 6 ++++++
 arch/um/os-Linux/util.c | 3 ++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index 5371c9a1b11e..9bc8fc149514 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -153,6 +153,12 @@ export CFLAGS_vmlinux := $(LINK-y) $(LINK_WRAPS) $(LD_FLAGS_CMDLINE) $(CC_FLAGS_
 CLEAN_FILES += linux x.i gmon.out
 MRPROPER_FILES += $(HOST_DIR)/include/generated
 
+ifeq ($(CONFIG_MMU),y)
+UTS_MACHINE := "um"
+else
+UTS_MACHINE := "um\(nommu\)"
+endif
+
 archclean:
 	@find . \( -name '*.bb' -o -name '*.bbg' -o -name '*.da' \
 		-o -name '*.gcov' \) -type f -print | xargs rm -f
diff --git a/arch/um/os-Linux/util.c b/arch/um/os-Linux/util.c
index 4193e04d7e4a..20421e9f0f77 100644
--- a/arch/um/os-Linux/util.c
+++ b/arch/um/os-Linux/util.c
@@ -65,7 +65,8 @@ void setup_machinename(char *machine_out)
 	}
 # endif
 #endif
-	strcpy(machine_out, host.machine);
+	strcat(machine_out, "/");
+	strcat(machine_out, host.machine);
 }
 
 void setup_hostinfo(char *buf, int len)
-- 
2.43.0



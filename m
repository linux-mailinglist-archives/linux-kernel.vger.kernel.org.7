Return-Path: <linux-kernel+bounces-891388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D43C4C4292D
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 09:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 69B704E8328
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 08:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A1E2E9EC7;
	Sat,  8 Nov 2025 08:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjbkXCjv"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EC72E92D6
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 08:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762589181; cv=none; b=LZEsC93bQdWPjiSpgcNwrn8Xt+rwC3i/WIwZ7kojoGDssbtbEcK1WbzLVFUu2MsWJZ4Zx6dLK1AJGhom8p8LfvAa3aS088b75P3xVo7f07Maz/xVYowK//4dEcS/bMhZ5HgILgOCGeoqD+ksW//2M3CW/sTGtp1eESfIOnOvC1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762589181; c=relaxed/simple;
	bh=cP8tVJMzsmQcslbRgyEI/3kjgKDzqbQZXJLwSVZ1W2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SRYDCidj7u+DMJBqFeR7hXzwfxixokxys7fdK0Ro3uq/B62ji9utFPDu7WJKNScPpsW9iHFMbqlZCRIzZeNL+OTqF4Z3QYDCYbO6ZX/ZK0i0Q6ohao5Q51q3kzlpM2bN+9plWFlCXaGTs9BeIVEg9gzfgswr10oN5sxO4bgL8yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EjbkXCjv; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-794e300e20dso983041b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 00:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762589179; x=1763193979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9nqBnkNS4GHBgTUiwDcxL24xHY+Q8FfpyTOYW+ItBnc=;
        b=EjbkXCjv35/8ivMZecbKaYJ325YZOnBX6ODeRI7DcdjwPt9vwg1sydQhSaWu1SgvRf
         6xJ5jU3L4iMXg+Mt93z1pa4OzCO1eEp0QHWhWNcFXzRO4fbM22uC70b+2tPz2we/ZRp9
         XGftNxOM3NExBQ3/r07OOk6asvJNOIBCj/asHdKuRdNwrx2emBPThfkqzAF0ExkEdYuZ
         JZr+2e7Vch6S2t//eapm2XrExT1Xibv3EaToGercfVt3nl3ytUDR5KInrE/mJE9nEyJJ
         DzC3w0YN7QS4yr7YfeqEN3uYi8IkVATqTlfDB2crdUcGzusuYyO7zg7AolaWqqxQ7lkT
         BcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762589179; x=1763193979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9nqBnkNS4GHBgTUiwDcxL24xHY+Q8FfpyTOYW+ItBnc=;
        b=uXYhkDtwpWV+yWcbXoukwAEIGvBfeyjgYIdwNh2LCY5LWTkT3lA9hSBg7NLAlbj84j
         lqozIYPRyDggdxnTFalVCF0Bbccgc0Cg2rNEsHYba9TpjRCsLf1mREjdMriVHhT1luYl
         aVnflw6cEa7K2H3s9Ma2Tr08v0uAEl3ordNLjntE3CoOpXorEqXLKfhqCVg8EYVprP+O
         ySLGRYBJoQaLkdKAn1wFQR40BKy2gYqf4a1fSyBinKnLDqDv4w2HrEXSmn2VVgo2rD7U
         7yE0nJpwQzEObEuJd6pwqVl53+9rZLTslYTPxzBS041X2sb/df3iCUtOifH+oyQSO8JX
         v8uQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJk2uK4W85k4DSFjqrNX29QqN0NTuhycQYBFW5d5Cw1XPDUOodkGNTaPYMWXMD+Lo3/ukWyQxm0lj468s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz05rnGhtSzd5wrCze8dVT2O/v8VRoUjgeBmjofXXNzJXLnSNWw
	AULVOPMRdX7sJwpfFuIbkN7tgYzfu4PnnnOamZH6lnJscKIHK521rs7O
X-Gm-Gg: ASbGncuZfZ2uG1DSZ+dMS51cL2xXujmD9AK7nybhtexsNscupAFFUr4FttRVsWfENhl
	ldOiOKs5gCOxzkIZa9eLA1/r6QivKCmxFw51f/BdXPhRkNsW21JwKPiMLJv30+axSHqW3STMVt+
	hA7NxW5q4/DTXx+CU554NQp8jodrjDG+C2hf6m2Ttb8CxLc2/impBrCiq2EXa2nPz2BVU8DC71j
	Td+4BuXLDnFZT6tNh6ZhprXF3t4FiNQ3sdOxoJNNyT/ZdIY7XFxuBc0skirpWHYBxIkPuaSjkNt
	lsnj41e9sWxTqY2MRUNt6j95t8U40R7CNYLbghntJuqPFncGku75leIX4kBlC55mKed1KDNpJ3S
	paOHnH/6r/SRpOUgdKPB6knlmchu4CnJyiPTsCxe/+is+362TuDoYDLkG551tJsliwPmkPVwyjz
	8Ws8tvKH+lVVP5V/KOOy2vBR/zdeI8VtvuLOaErbQ0uiy9OoRnZmglxhP4
X-Google-Smtp-Source: AGHT+IEeLxoMDyJQgdBR8WYJmHiLhZ7pAXN7oI3a/DfOUHZJDQcbCb7YzFoFxJg3hJbK1bLn0MBfQg==
X-Received: by 2002:a05:6a20:a10a:b0:351:e1bc:e8cc with SMTP id adf61e73a8af0-352b5c009d0mr6591481637.5.1762589179593;
        Sat, 08 Nov 2025 00:06:19 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba8f8c880c5sm7230587a12.6.2025.11.08.00.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 00:06:18 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 346A711388D9; Sat,  8 Nov 2025 17:06:17 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v13 10/13] um: change machine name for uname output
Date: Sat,  8 Nov 2025 17:05:45 +0900
Message-ID: <7cfc1ecdcb8fe15edd92d3b1539994e28f3b6d5a.1762588860.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762588860.git.thehajime@gmail.com>
References: <cover.1762588860.git.thehajime@gmail.com>
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
index e3ad71a0d13c..5fb26f5dfcb6 100644
--- a/arch/um/os-Linux/util.c
+++ b/arch/um/os-Linux/util.c
@@ -64,7 +64,8 @@ void setup_machinename(char *machine_out)
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



Return-Path: <linux-kernel+bounces-881717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 311A5C28CCD
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 10:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1AF53AD22A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 09:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1569227380C;
	Sun,  2 Nov 2025 09:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGMj69tT"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E1A270EC3
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 09:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762077005; cv=none; b=ks5iROqpdWxzYSCixuxQbEssIsqEQ0JdVHcoInNzh415KlzVk6V9OzfIs2NIJ3INFwlE8+plZndp2w2eI8IefktNig54l5kIlTxiBO5JJuoOjSnAdSWirzdcEI3tt8tQbv4V2dLaVSjJfseDV4Vi81jPP2H5JaPfg7ujVQKleRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762077005; c=relaxed/simple;
	bh=cP8tVJMzsmQcslbRgyEI/3kjgKDzqbQZXJLwSVZ1W2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O5uSXYukAROSDPHLNvzQAagtD49Ee8JV6tOJ14L5X/gCVmRY4ljvukIQmLOcXo4zn3cqkNnQ6THUU82TjZ13ds9KzNViJ/UU4Myhp8o8iEtfyYUCuViVO4PBg6bCCaa4u4EPMTlPCxhT2NCa2b0P0DygZIEdsrHr3qNdo60jD6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGMj69tT; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-339e71ccf48so4076357a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 01:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762077003; x=1762681803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9nqBnkNS4GHBgTUiwDcxL24xHY+Q8FfpyTOYW+ItBnc=;
        b=YGMj69tTvSRTNY/wUYMs7Y+6gJz2ePklYCJwELy4wvZjZk7oQtB1qOp2tjnxg+c3+a
         W6NNr8xQkUJ1vsitqLqlneMVbeCH3EFCdMTOK2+tD0pDXn5WD6xX7SsPF/mzW+2Y/7D8
         9523bauD+gMz9+1sTZO4GEmkPlmEBp8MWt6SH/Wo48+/3w4C7+PeOISC9gDj7HHvl4PJ
         bbD0W0VF+i8pfZ0NikEEryUG7wq+4LX7ZnX3OB9lvcCyIPXFU/GI+9Md+SmzBAuxFFb9
         YLGe0Ytu7tiPWoEQWSph96e1EvuoJCPO3tTl/XRG8ibZF0RDBJevWT3lw4du+i+8fT3H
         /k5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762077003; x=1762681803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9nqBnkNS4GHBgTUiwDcxL24xHY+Q8FfpyTOYW+ItBnc=;
        b=WLycF/wqECQcfz2S4QLPEUgFSDpo7Gsec+rtjh3B1Sr38Zn8o9yjOfkJWfA4QFeCa6
         X5yfoVnYGZF5riy4KDOB/BbucDtTEPgym/TbT8DV4Llr70LYlscpUVHkj9X5ATfxybaH
         EA72kdPus0l9xNpc5a27dPyPdtZw1E5EX6ur+j26C6SI7YnN0dHl0QSViNsUBTcNt81Y
         IeB0luyXTLWQ4/3EwnqiqCGb9rHeYFalmsBXtUF5RwGNq4XjciuktJ88AncgUYs1C/wI
         eqX4ILpxzYNnQoR4JQFRnBa1CGrT4iak541x8KSx11SUtw04pkLkHVx/aCvvKdB9BVma
         /Xgw==
X-Forwarded-Encrypted: i=1; AJvYcCXz69b0TyPieIjAWE0t7LnKycH/ffWnaSMq1117UJZQEycPPalN2i1VQqPslBr2Dpq0xy5uXisY7ZvBXus=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKUQTBKM5vM+S7SNxZS5pIQmasb9ClEqrM6pNHdruIAzVPiSgJ
	DUEd18pfPNPVwU/oiR7dTO/G9gi97FNsSY877JWT/2qwziR3CRbV35qf
X-Gm-Gg: ASbGncseAj1nPxL5b8nbpangMQWG2/h4CbC+E5pvMW7uw1Bvvg2VAiC4qqkHeOuqRqI
	qk2i7zcrTM+SsXEN6ujflN+ksqfVgltVv3nEy7keRRpssXr0JhLxvr5cwFmWtGfe426MyVVVTBe
	Ut8e/dp+S5FS1gkt+4+THRsCAyFwwuaGCtsO0p3fSGAODq5vG7israjn5LFIUGd+Zs/nZbKWB4T
	DXGNVxCc+2l6XtUQMgfkWLjuZWYWeI57iPe6jGDmzeM+pKgEihrWAJ6wRCvsyb/Zgb4Ku7uQR3B
	9WxX43E7vNIWvXoiNfv824zSOj6f8hvFIcqswlAtxrGDiI6FS/JGX53WqNqb+MniH3TnN9Y0dVO
	1zOfDUXbmWnG0GPNOX4ThTP3o8aL6xv8xGLhDRlAvIPSeIlhgY4PsMShDOloy/Xrc9JAWELIeCS
	2GvSsJy/BmpCRq7i4bz2SsZtUpnXJaS311e8IiKIBAYGrcgA==
X-Google-Smtp-Source: AGHT+IHuXrm2fcu4utkxWrFy+W8BUf2g500DhuJfUTiIskvkxoz07jb3DhqnxeSGx4/0+emeuA/vkQ==
X-Received: by 2002:a17:90b:3e44:b0:341:194:5e7a with SMTP id 98e67ed59e1d1-3410194623fmr1787362a91.29.1762077002893;
        Sun, 02 Nov 2025 01:50:02 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-340999f9943sm6854469a91.1.2025.11.02.01.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 01:50:00 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 971AB1123811; Sun,  2 Nov 2025 18:49:56 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v12 10/13] um: change machine name for uname output
Date: Sun,  2 Nov 2025 18:49:35 +0900
Message-ID: <e37819e93cf5a593fa1b16444b3c7aa6b7885301.1762075876.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762075876.git.thehajime@gmail.com>
References: <cover.1762075876.git.thehajime@gmail.com>
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



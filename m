Return-Path: <linux-kernel+bounces-822241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1E0B835F2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 631BB723EC3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07502F4A00;
	Thu, 18 Sep 2025 07:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="da0ZIS0w"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859A32F3630
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758181175; cv=none; b=dTFcmhf4kRbiweTVkWT/kaplIQZY3JyIUV4pPkfWVMLt0YOdjgh8zkTwyYMOoN0Gt9UOHfYY3w0uOFxvzQj8LDAuIrUGjSIkMdwwhRF+qXBVIwL4LSo4I3wydldoGnbDNj0Gk8OiZIJu8BORSq/F/1MxaWkI4nIacs8bhIgzKFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758181175; c=relaxed/simple;
	bh=kvY4llqgRsxBvMcZ/CXo6FHDMPIg9Hmu3RD2Lrj2HZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uZICNGoCMGgKBrmES/Hom+8sww8YlT4bghfufk8WcNIf2RJDwXXiKgmtn6uEgrRCdocJyRUjNhWOf31UGUR6y2dH8mCCk0MUz5pJbM7ShOvzWEtuhN31ZQgfM6Fp57Djh0SEFQZYlrhHYTZrqBIKZdBgJ4uvT+1kp+khHaKR1B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=da0ZIS0w; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-77b0a93e067so639012b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 00:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758181173; x=1758785973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SfaLR+xtvYbSj0Yj5pLhRxT8PrYzixVb/sw/K5Eb4uM=;
        b=da0ZIS0w/hOpITEzJnNdt4IKqua8UbTSYVznh5BWj6Fg+2qFCMHD2ilbSMFXktHtg0
         Be0PSHDIwNcckLOXCGD+cwG4EujK282WJEnEAIODx8U7VSMIFGPIGkRgPUhqDDIRc2GH
         yRIYrAY8RX8TGQE9EtUGwZT4EZGpTWjG9YOuXizbR8EJ6Tk5PqgW0j2PRQNFicwuGyIW
         oBvH1o4vpum7wWR9MTSje8Q065U0BX5DrH/SMmJqyB96wYPyCIZoH5PELUacTnxGNRgD
         pHWPa7wXoeJkmQYNluYvOhceR6iUIWbpIVX5f+V3YZ0eD4A6YQfo3CBQH9XDMwnkWePU
         4Ylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758181173; x=1758785973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SfaLR+xtvYbSj0Yj5pLhRxT8PrYzixVb/sw/K5Eb4uM=;
        b=bfZ+l0qytIHah2+u4JU/XqZmk8kiGxt72qXgLKBRePsa9daqp5N9vTTOcfwRx6Cb4D
         s+SXMrHzy62B+ImfPGekJN2dToFLM4qYLkSyIAxLOu+TFi2/iltH0uY4Et3j9CpPK5JJ
         aDtC9J9PSUs/Hh9v5vpc33nOWTinILnYkAMW607ljooQy6+lcKZKjqtN/JMl3TLNE0/b
         EQN0XzgQ36LkQB8qiPrYh2EQ5orEVIAUk4NIqOdF57ON3t8t2D38ea7mBD1tG/dvfebh
         3dzVJ+jbWvFNbQrakTy3z/+BzsYkQPKJxokSE2on1b7ff+F1FcdDBXxu13bDAPRJbczi
         WZEw==
X-Forwarded-Encrypted: i=1; AJvYcCXOnZYakMNhdCNfzQznOGMp6Ecr9l/0bVyM9tMrL6SJjgZMDVIZ7ZTTPObLcI5Qx7vXN/wfvx0J2sX/qG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeHhbAlfyY0Q28+E1wnEMk2Zg0L8ufMtGyGCHz+8s3Qd17mNRD
	aG3hZww4R/P0AMYV10iHqizuiMszvGxdYoLNqJUlUTpkxTnI9KFPnP4j
X-Gm-Gg: ASbGncttjEnVObYZQMW+F+47ycCJdrSyO9uWUQBh7ofN78KThRMPbyJgH+WAuTid5ht
	CBAHxW0avYMF44+IiLVM06Ckl/+svS+HxBhPxmPl8BmmARirceDxPb87f6SNkbj+QvVMIRpygE4
	eXbnxpPQd5d7RibHEjoqBDMWsW8mCHhVqS2uT8PyNkcLNHrNf6K9QWZ+EYsf1DUtF24x3m3Zpmv
	qBjZALRyZ2KU+mUID1EWStENIc18w4uhLJt03ypL8GhSgbEbRKDGOcjKUpuNDFw6Sn/TBGx25L2
	h+y8XO5CuMDFeit988G6cHdoTebebOMm1VEjh05fhcde8ix+Hx8GZZsSrAg45oD7J+fLU+bvG29
	DaFwK7OHi8O+iY5Sn81xkBWVKYwvcHq3T0mEWm67uwDm2gzP+6CY0//C+7jkWynQ015m9WiIuT5
	oh4fesPyqwWHc=
X-Google-Smtp-Source: AGHT+IGoXWN5DJ8xIXCgwHsBi/4NPgC0UAZOi82Bbm/JRF9tQ/p87F/MCcBLJSl0bwTlX6e3XqHsuw==
X-Received: by 2002:a05:6a00:188b:b0:771:fbc3:f151 with SMTP id d2e1a72fcca58-77bf8e72b17mr6667074b3a.15.1758181172767;
        Thu, 18 Sep 2025 00:39:32 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfbb79c23sm1476897b3a.1.2025.09.18.00.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 00:39:32 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 328491062110; Thu, 18 Sep 2025 16:39:30 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v11 11/13] um: change machine name for uname output
Date: Thu, 18 Sep 2025 16:39:06 +0900
Message-ID: <4e20b02e2b44b1db9a6f80e59e6b0c00ab08d5f8.1758181109.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1758181109.git.thehajime@gmail.com>
References: <cover.1758181109.git.thehajime@gmail.com>
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



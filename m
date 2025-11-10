Return-Path: <linux-kernel+bounces-892834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 937C9C45ECB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1CC318924FC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D403081D2;
	Mon, 10 Nov 2025 10:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYAU+HvJ"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6BF3074AC
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762770323; cv=none; b=eOJgBXb7AGrBhzg/3iNX6/G1ZApy12q5kAu1lDnWOuUqfgaAjYlnMqyYk2KJh/npjmWKr5xIVNs4mZRLOspFlcx+H4PzBX52b8dBjBmQaLvac9bnzzx1U8BLgEqg9iDFiVRrizoz0X2x9Ey9jtFDIIBcFavdpjUD0zsjbrZq8UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762770323; c=relaxed/simple;
	bh=DgA+YQZ2PXtKWbfJH1XR71F2ykLEULNrwbgH40vjVnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UC7hqzzNUhZc9GFaNZcGbvFf+8SqvIgoY7h+RvrxlHdTjHQ4+GKY1N3F696c9juxtrVfG1yVuxrHKd00DVmmeFV9ktpFD2ThJFlR8YnYfnvyjmv8Rmhm4dTfYddxeka3dhnAxgqDvU/UmM9oO4nDkbm6xIVVtz6fhmEWmYRKg1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aYAU+HvJ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-477632b0621so19007175e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 02:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762770320; x=1763375120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Q6cLMd5HkJMSjJpe28rjQcWfQMB7GUBaFpYg6qXkBE=;
        b=aYAU+HvJPWzk80efMVTCBYuK0+1xJWD0v2xB8bsl9w3FAvgK97AVQaNwEhpPJ/P9g9
         fLPEmvX6APsbvV/xL7cVPirQisEsxcFBnP1SE6ZAEUKdTml/P+nGk3ECw1zw+JFGu8fA
         lZbcwkqvj7++0FlMRrCTUfjAsIYVTx3uXooTmxnx8Tz6iM6Wr9ch79ZXnGSijauuq5xM
         YOBTx04V3k+28P4Qizoc9eKVAxqx1l8iv0mw/vJ75+I8GX8DNkhPcMeA405nh0ZwCDcv
         HZWdgloX0/Mc/aDNSDsIk/BUjDv6dkSs01CqZxWq6+U3zggQgm/fbQFiJSNE0v8mWDfn
         ugQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762770320; x=1763375120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2Q6cLMd5HkJMSjJpe28rjQcWfQMB7GUBaFpYg6qXkBE=;
        b=PAiDr17pwtNlsy7878WdiGAkVipQg86+K9RJp8PXkeNlEMz8LWKZRTXpYtoQeU11+R
         WroMxfXdNzOA+8sdPTd+2vxBnwixkkLRE8OJ1vPYziSM7z2lh48FhhY2Fs752khyewE5
         Yq52CvWVOKQNlixf7LepEtLBOlDtdklfKBpgPIDO0ILdLqLejyC+TMMqmPcxme6FKxst
         4bDaCf/oAmOvUwyE2Uexd9+2yK7dSHxXe9ZBLRG9fkyptI+t6ofAmKmKIoPym6BI1hNB
         tt+FkUQvIdguA2YxKPoPi/s/NC9eI/54/IVw7GFsemTc3Epi3CPU3oRR4nNSJlbydjtu
         e1yg==
X-Forwarded-Encrypted: i=1; AJvYcCWu5no4+LZj++qWJ8l5ooo4nMjmOpsVXi41eOaf/qNv/83U7J7DQXaKCPLLtZod7pmicP1XKmWA1uQP9+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeYWX1PjWhKZ+CzLh1oTxRTdDsXmYi6sKT4MGQ4RmhjQghRKz0
	rtdPE0OEx0D4L+67rbETcCtr1qfA8C753wSTjUgApJzBW8HKaUWYM8YjgDYmJctV
X-Gm-Gg: ASbGnctYYe0xl3Wqdvrb619PLh9oTeJPw/jlixWAaS+MyHCXCR9CRZpXP7eR3uJ0HTb
	zUfc99U0Vof3c3BHMJFsPUx2Qz1oLtwbOF/jRLu/DbUwCVGQjNNK2/tuvcj6z0+Bg/DhXxBzXRd
	rs0/mJ/nR6Y0ILIeF7aGv64+i28U15Vfo8QOcFROEaql5MRXHletDOfDK7mHOMJS4qKpyNhGtk+
	uMtuv+EAjm6O+MZsbrrFwlggoCOS9VkoE4KNthQPWyDC4OxZeAhIoCL38sMdvHnVdGnvRi5aEHe
	2esvd89Ppi1kyzdtdLEdl51P3Flq8gUUoxByDLHEwIE4HLtzKDTFPtcLdQFvxff2g/hl7FUozUL
	L3N1AY387rKheEac1kwSFOmPMYxW4vGWq4tuGGn7ahki97or1wt8+Gb+DjclOcff6fEZnXkcE1W
	o4mDoCq20MLBkAmRxxreJq5Co4dKA=
X-Google-Smtp-Source: AGHT+IEPmVXfG8iep1LXV3JrYQl/ln16zPfrpGAOurbePOD3z7RijiLpRk26CpWCIM4FytWvWOm4Ew==
X-Received: by 2002:a05:600c:b86:b0:471:131f:85b7 with SMTP id 5b1f17b1804b1-47773236f9cmr64888705e9.15.1762770319920;
        Mon, 10 Nov 2025 02:25:19 -0800 (PST)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4777a96e7f8sm67326715e9.13.2025.11.10.02.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 02:25:19 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 03/11] staging: gpib: Remove gpib/uapi from search path
Date: Mon, 10 Nov 2025 11:24:59 +0100
Message-ID: <20251110102507.1445-4-dpenkler@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251110102507.1445-1-dpenkler@gmail.com>
References: <20251110102507.1445-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The gpib/uapi header files are being moved to include/uapi/linux
as part of the gpib destaging process. The latter directory is
automatically searched when building the drivers.

Remove gpib/uapi from the header file search path in subdir-ccflags

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/staging/gpib/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gpib/Makefile b/drivers/staging/gpib/Makefile
index d0e88f5c0844..2d44fed2a743 100644
--- a/drivers/staging/gpib/Makefile
+++ b/drivers/staging/gpib/Makefile
@@ -1,5 +1,5 @@
 
-subdir-ccflags-y += -I$(src)/include -I$(src)/uapi
+subdir-ccflags-y += -I$(src)/include
 
 obj-$(CONFIG_GPIB_AGILENT_82350B) += agilent_82350b/
 obj-$(CONFIG_GPIB_AGILENT_82357A) += agilent_82357a/
-- 
2.51.2



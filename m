Return-Path: <linux-kernel+bounces-781475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6561CB312E1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A0301CE6AE0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06332EDD69;
	Fri, 22 Aug 2025 09:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l2tAGsDb"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E865A2E8B61
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755854660; cv=none; b=mGIv7cNY6/nLly7X/SyMoubX8dIKJlaiKI+O2Q6cJBHJOensdG1rCFCUFFb9bhzGUwNdk5pj+KEnY+zuWpRQvTf5A+0LFkgyc/MuvMpf3GVIbFsqnybgFV7TRV2KbQi8Uf40B2QYGepsZ4UG4kWFDbKgllCsI1eq0uSIl2VUfDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755854660; c=relaxed/simple;
	bh=xBfS/aUPzryTTOAwRCBOYzWxM5jgrtLXSWJgAlMdQhE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ekg6Sx0uSf/jrAsaB8nU9s5jzgTIMWw+tgzLK7RSaMJZACgOcU+VqoW0KI0+HMoU8zhtAvpJkG1u9Ti5Onu5rzzQLgueUvk1qKojQ35GVDxD5dV2uvHJ/LRiIyBh1LYmoAW1jBKMvD/zM8/G19QGHfddtlIuAyzgAKW7wrAPSpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--khtsai.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l2tAGsDb; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--khtsai.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3250810462fso1006641a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 02:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755854658; x=1756459458; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yrv7lwvGLFeWfWcOe4UUVpb8JLfLX1obno5+HaM/rlM=;
        b=l2tAGsDbj9j4uPD8wFNKfc0RMkT9rvlXWQxiZ3SbogwFgLhJzfj2CmZz6CDPHl0Ztr
         xzfe8k6ro2qvwidwoqNj7I9tUoNxD82buoQWR5lQN8+DzuNA9dGUH/otzI3SLLjExMb5
         707M3n1rw4pkXQZC+Sq16BJNGU5P5lvHB1Q8lC5BUlKL5L9jntr/7igspySl6vov9/Jq
         JFtwj/uhCVWRwYPb3IQXN45aVmyqzXuPRdKlrlluEPYKczcGC8ikQjMunIEw2vmUPSNs
         GlrNAEKgubzirdsx8jXFold1275YyRnQNN/2Hi5d4sn4dfqjs/vZG+s8w3DCR3tPoFo/
         sZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755854658; x=1756459458;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yrv7lwvGLFeWfWcOe4UUVpb8JLfLX1obno5+HaM/rlM=;
        b=rj/kzrLg962bQA0bGl6jvDL5a1qqM2VmVDq1uKQLxUppT5Gntfca3Wi0byl+IJcJ7b
         D29T8SM2zcHjafQ/QKgFXTJdlU32MsqOO5qgqf4tknmBR+h07kLws+eVPGKipnotEoRL
         jPWfUrQV+BGa+G/SnK/VGXzePN09X5PuUzOdpkVt184OFmwsPiP8ob1LTxWYeEH0EUJc
         Cxef+Wnrk7RUaXWusVVQgrq3W31g8w/c7u3hidzSNI5BVm657HEqffeeFK3EEcbdmKdm
         mtOSTENvTAl6O/wTX1h4+xREzoXp20sE7mNtnH7RdTnFfgF9tomDU8rO2mmnVD8uPOsF
         whVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOVFuQVYOIj+YeXm0RMEgkrpLzEfb1nrR6RV3D6YRD7Zls1Zsb4WvUucnmUDz1dOlnnbEKgKDNWKqDi1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyMAR3wqYCL6BF78QPKkJual6OGg07X0RHtXpQQs4gEaLRHq+8
	1erbTuctftUHVFGOdE4McT+Q86Ftc1g/yC7bx7wRxyk3DGdbSL/Bavyk8oWnr6ah5CuqG/AzcHe
	xEnVTIw==
X-Google-Smtp-Source: AGHT+IFM1v6jfSSYzAEfLVNCVVilohJmWgKU4BYWL6TUTKngyH5l8ic3ymYK1v8JHYZOj4JOaVKofm7nx9c=
X-Received: from pjh3.prod.google.com ([2002:a17:90b:3f83:b0:325:23da:629b])
 (user=khtsai job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5101:b0:313:2206:adf1
 with SMTP id 98e67ed59e1d1-32515ec3611mr3371270a91.4.1755854658316; Fri, 22
 Aug 2025 02:24:18 -0700 (PDT)
Date: Fri, 22 Aug 2025 17:23:46 +0800
In-Reply-To: <20250822092411.173519-1-khtsai@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822092411.173519-1-khtsai@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250822092411.173519-2-khtsai@google.com>
Subject: [PATCH v2 2/2] usb: dwc3: Refactor dwc3_mode_show
From: Kuen-Han Tsai <khtsai@google.com>
To: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kuen-Han Tsai <khtsai@google.com>
Content-Type: text/plain; charset="UTF-8"

Use dwc3_mode_string as the single source of truth for mode-to-string
conversion.

Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
v1 -> v2: Added the Acked-by tag.

 drivers/usb/dwc3/debugfs.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/dwc3/debugfs.c b/drivers/usb/dwc3/debugfs.c
index ebf03468fac4..d18bf5e32cc8 100644
--- a/drivers/usb/dwc3/debugfs.c
+++ b/drivers/usb/dwc3/debugfs.c
@@ -402,6 +402,7 @@ static int dwc3_mode_show(struct seq_file *s, void *unused)
 	struct dwc3		*dwc = s->private;
 	unsigned long		flags;
 	u32			reg;
+	u32			mode;
 	int			ret;

 	ret = pm_runtime_resume_and_get(dwc->dev);
@@ -412,18 +413,15 @@ static int dwc3_mode_show(struct seq_file *s, void *unused)
 	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
 	spin_unlock_irqrestore(&dwc->lock, flags);

-	switch (DWC3_GCTL_PRTCAP(reg)) {
+	mode = DWC3_GCTL_PRTCAP(reg);
+	switch (mode) {
 	case DWC3_GCTL_PRTCAP_HOST:
-		seq_puts(s, "host\n");
-		break;
 	case DWC3_GCTL_PRTCAP_DEVICE:
-		seq_puts(s, "device\n");
-		break;
 	case DWC3_GCTL_PRTCAP_OTG:
-		seq_puts(s, "otg\n");
+		seq_printf(s, "%s\n", dwc3_mode_string(mode));
 		break;
 	default:
-		seq_printf(s, "UNKNOWN %08x\n", DWC3_GCTL_PRTCAP(reg));
+		seq_printf(s, "UNKNOWN %08x\n", mode);
 	}

 	pm_runtime_put_sync(dwc->dev);
--
2.51.0.261.g7ce5a0a67e-goog



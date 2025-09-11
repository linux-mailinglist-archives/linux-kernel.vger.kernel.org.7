Return-Path: <linux-kernel+bounces-812255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3D5B5351C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A8EC3AC307
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA45F338F51;
	Thu, 11 Sep 2025 14:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zup7xF4Q"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B786E32C312
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757600473; cv=none; b=KXUvulypuWTvbA+0t5onQZ7UZmflMhcpwtU1VSFAlbHTf6JvklC21SbLfkFMH9sXQgr5KuTnHZh9rJumoA9qBf8WuV/fTI/wsjDcGH4N4A4vDkR1fWwv3/w0exBtonPF9ou5ziiP5X3v2Gk2W7Tny1E+ojA8dapfQdlwbId+f/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757600473; c=relaxed/simple;
	bh=faJE+cTueXsphf9F2YTETRq7iQrxqJIPSY5Wh3BTBzY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XDrXXGOmxcVe++gjZXdr/bmomRE1Aw76qsG0khl4NkaagoD7x9jbgQMRVc66dzKK3lcLxjtf5flhAtCUXvTyhT1Y4cQyQRwWhGKMjzXoyE6IlJc+ISKqOo+VYm9bnet2K0IFf362Bbb3CARI1IrHogUS0ij7iB/Er+Iufax2MPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--guanyulin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zup7xF4Q; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--guanyulin.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-77264a9408cso1532685b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 07:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757600471; x=1758205271; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=di9vlGGwM3+bJg1YPMe3g5gvCbV0sk+DG/t3kCN+JkE=;
        b=zup7xF4QMFeplfJCe42tIwLdzE52Ge0PA/59veXAquSw5GgWEd1w4F3WK69SsyEjwo
         9LrROVzpMsF8dqU31smPQNRERvmxkngrAcbF26iZvLL+T17lBLx7p4Cy+6rVlVcsTW/b
         JUN5XcKKji06mRvVd5Qofqq2t+xLPpsTHyMBkK1ElM6EqXVKCJiGnMcNbu0HJGYji4nF
         oh7rOJMwH4I554VvZIgAcHjGg9u3J3beQIYRrNrzjozRevz4RGixTDzDKYbiqmsxSGkY
         C/QDQeqg1tF22a4tIyxxzqQBZThRI3wUPtTfqzwlSvET18IrrRXZlXaiRGC6ma2R3z7u
         pOlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757600471; x=1758205271;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=di9vlGGwM3+bJg1YPMe3g5gvCbV0sk+DG/t3kCN+JkE=;
        b=dFCFjVc473yIEttjmbP0sU6nbcjVulf1hEP8AnDwreeyXKvt7s9vjm5BbyXZxez160
         rn4bKlujtNJr4k9uVmorMv+798nlnfFlsKSb125vaWW3KzNJyES5gqDh4bK4ZPr000Vo
         DjLzrYp8J88pBifYryaVoGfxF48IEDSu6KFqCrvuoeTom609P4D6hV00gLDrjOO7+jeL
         DEHCaeiexjtV+nylVws9pdDAjraQeNUxJK7O6SudviC5pksOxfiML7kXR6bzwAWJdJTl
         U1FXWcwRA6j/Rets6HZfIh7hXYQcRLs8+URgUwhfAsOwgY11wX7owCB6Ek3uLSo2uMFt
         YBpg==
X-Forwarded-Encrypted: i=1; AJvYcCXsu/4etlzibUO38Qjx3ZgYXIVIbVNFER48q7KuSYUMqau6nDKjS5TJ8LMTvgPwqLl1wOL6mBfjDVDwOdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbxeqMun2mJJv8I14VVHnM4EJqRBrcMHPmR3UqW6fNlHX+Wyhy
	fZVI/PkIsXOvBFtcQ7hlJ3JQ953HYcjqFCIGXR2Oxmn9+1z93JDLIs5bTMJqa7euA0SqLTtuvRn
	JN8k1ya2vYhrg98M/JQ==
X-Google-Smtp-Source: AGHT+IEDuORbCh7ohTP+tivq97Pf4Ap22u0st5ArBD+NLXFiMsoCRDqV5AuP+Csi9xEgcunezW7ghFIJ8zClIOU=
X-Received: from pgew14.prod.google.com ([2002:a63:af0e:0:b0:b4c:5356:a130])
 (user=guanyulin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6300:210b:b0:251:1b8c:5643 with SMTP id adf61e73a8af0-253466eca6amr27762178637.50.1757600470961;
 Thu, 11 Sep 2025 07:21:10 -0700 (PDT)
Date: Thu, 11 Sep 2025 14:20:13 +0000
In-Reply-To: <20250911142051.90822-1-guanyulin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250911142051.90822-1-guanyulin@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250911142051.90822-2-guanyulin@google.com>
Subject: [PATCH v16 1/4] usb: xhci-plat: separate dev_pm_ops for each pm_event
From: Guan-Yu Lin <guanyulin@google.com>
To: gregkh@linuxfoundation.org, mathias.nyman@intel.com, hannelotta@gmail.com, 
	zijun.hu@oss.qualcomm.com, xu.yang_2@nxp.com, stern@rowland.harvard.edu, 
	andriy.shevchenko@linux.intel.com, amardeep.rai@intel.com, 
	dominique.martinet@atmark-techno.com, quic_wcheng@quicinc.com, 
	sakari.ailus@linux.intel.com, dh10.jung@samsung.com
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Guan-Yu Lin <guanyulin@google.com>
Content-Type: text/plain; charset="UTF-8"

Separate dev_pm_ops for different power events such as suspend, thaw,
and hibernation. This is crucial when xhci-plat driver needs to adapt
its behavior based on different power state changes.

Signed-off-by: Guan-Yu Lin <guanyulin@google.com>
---
 drivers/usb/host/xhci-plat.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 5eb51797de32..df2e942ad5f7 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -454,7 +454,7 @@ void xhci_plat_remove(struct platform_device *dev)
 }
 EXPORT_SYMBOL_GPL(xhci_plat_remove);
 
-static int xhci_plat_suspend(struct device *dev)
+static int xhci_plat_suspend_common(struct device *dev)
 {
 	struct usb_hcd	*hcd = dev_get_drvdata(dev);
 	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
@@ -482,6 +482,16 @@ static int xhci_plat_suspend(struct device *dev)
 	return 0;
 }
 
+static int xhci_plat_suspend(struct device *dev)
+{
+	return xhci_plat_suspend_common(dev);
+}
+
+static int xhci_plat_freeze(struct device *dev)
+{
+	return xhci_plat_suspend_common(dev);
+}
+
 static int xhci_plat_resume_common(struct device *dev, bool power_lost)
 {
 	struct usb_hcd	*hcd = dev_get_drvdata(dev);
@@ -529,6 +539,11 @@ static int xhci_plat_resume(struct device *dev)
 	return xhci_plat_resume_common(dev, false);
 }
 
+static int xhci_plat_thaw(struct device *dev)
+{
+	return xhci_plat_resume_common(dev, false);
+}
+
 static int xhci_plat_restore(struct device *dev)
 {
 	return xhci_plat_resume_common(dev, true);
@@ -558,9 +573,9 @@ static int __maybe_unused xhci_plat_runtime_resume(struct device *dev)
 const struct dev_pm_ops xhci_plat_pm_ops = {
 	.suspend = pm_sleep_ptr(xhci_plat_suspend),
 	.resume = pm_sleep_ptr(xhci_plat_resume),
-	.freeze = pm_sleep_ptr(xhci_plat_suspend),
-	.thaw = pm_sleep_ptr(xhci_plat_resume),
-	.poweroff = pm_sleep_ptr(xhci_plat_suspend),
+	.freeze = pm_sleep_ptr(xhci_plat_freeze),
+	.thaw = pm_sleep_ptr(xhci_plat_thaw),
+	.poweroff = pm_sleep_ptr(xhci_plat_freeze),
 	.restore = pm_sleep_ptr(xhci_plat_restore),
 
 	SET_RUNTIME_PM_OPS(xhci_plat_runtime_suspend,
-- 
2.51.0.384.g4c02a37b29-goog



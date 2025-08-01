Return-Path: <linux-kernel+bounces-752837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9F2B17B75
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 05:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D3271AA6B30
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 03:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D378A18DB01;
	Fri,  1 Aug 2025 03:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hYTY44ZO"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DB518C91F
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 03:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754019639; cv=none; b=DfzmrsITejc2lNl6UD3/mx177ZVH3Kar8opV01GEQ1NQz2xlTrvdMyHaEDwMA0fmS15g/aKqQCoAVQ76pWySOWKfXZeFQI/b7ajLQyr6BanuIACMZ+57W0GKjTR0CmTWcF0Q+7iL5ECFJUbdoiKYBPeez9OjmcLA67YrAc8f/cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754019639; c=relaxed/simple;
	bh=qw/l+oOIaR35sp4DSrzqYgEX/oL/BUhtqCC1TeZTTIw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j7umTmXtXd+YqV25+WzZJ3WU0IeziVUzDpN13/QKf5+U0l8atRnmbyz/MBzWLjO5Rnqk9YIe1uT/xsnjxnj98qOIasgJpRFqVrnGztncOkpd63y1+EwtA3wvV4Gd4M4f7xx6Q4A7EEp/nvo6KjsKW3NP0I57kaZ8sUwDDVsy/f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--guanyulin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hYTY44ZO; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--guanyulin.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-75ab147e0f7so1743292b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 20:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754019636; x=1754624436; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/wA8zWj3IHi5EGjxZe0hAzAqxv/u+HvHJFN6V2LV+9w=;
        b=hYTY44ZOOb16MU8qleS0Lo/G/8Us5GtWBy0FfIn0yeFp5GWgZmdY6m11/yxZxzNObv
         UxJvU+5+Kb9fID4Maci+/Etfs6BMzOMAQNMBj7vVYx4jxo+l/TM53tqA1USfPwQ3Pnmr
         ZMa2sF/LELZ/pA5EmbYRLkMDvhVkl40Fd8jA5pEZkb9uaxuhK8SPp3QmxX9x15ntj2SH
         OWbMhB6JuajSTHG4jADcbw1XMOTxZ7sgxEhZAh1gdeOoT3xI1ebSZe8zwbsuOri79Q98
         pcGGHZfSVA0cm5gqZad996DcMNKn+r5aK1fskOGNRU903Px4v1b1rXg6Gpr7xrqjdv1A
         Y/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754019636; x=1754624436;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/wA8zWj3IHi5EGjxZe0hAzAqxv/u+HvHJFN6V2LV+9w=;
        b=I+ZUXnmm/EKOQ9QlhwppXgGA7Au0v+xfVkJJogk7HEuI6hRKmihD0LOkbQTcIUwtDW
         oTf6aNOgvpKDsV9MusBnIFYlwySXTY/XEyFYRExuSzhKiA9bYMR4wZAZ+XuTBU4qDVMA
         OpNpr3FSroJAHwACz19gRVIY7SW/9GxOko37U2QDErYYcgUl0irifxLZaNChakxZwe0w
         +x/Jkz5sPJadADiXAgPp3iNbyGv+bv6pt+vqzyPgFyPQBlUJt50nU25x+7aTSLOGTY4E
         +SBw7F13PmgVY4XA2kRsxTEv96KR5qdjV7XfIAv+PWM0bXDH9Kb56Y5yXpDjgIHoLjqc
         kaeA==
X-Forwarded-Encrypted: i=1; AJvYcCUatUiy9SArUpX+A8dGVaB2Qt3++fyhvebmq9lJQhGVwCkd4i3ZA0dbQj8Dzb9BDwN1CNsvz+s2KicjSMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFidawIXmG+B/sPCwNr4Pui5CJSj8rnCFk2mex+9EJlr6jgF4w
	Y4NfsuJcLKUaH7PG46/2MDfnUMCfd6o251mpRkURm7/s99vYk8ySYhAYhWlSa2YgmbZhdYmMXjG
	87vnzEFxJi8QwKaBx2g==
X-Google-Smtp-Source: AGHT+IE7ZYE2G78VMvgr7QyQY3UGFoBv6nWkO+JYjwWdIf2eRZA8qO2YgC01bcZhcgqpeVje8R/Z5rh7HqE6ikg=
X-Received: from pfjw10.prod.google.com ([2002:aa7:9a0a:0:b0:748:fb38:1909])
 (user=guanyulin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:114a:b0:759:5208:59e with SMTP id d2e1a72fcca58-76ab0f21102mr14128350b3a.7.1754019635948;
 Thu, 31 Jul 2025 20:40:35 -0700 (PDT)
Date: Fri,  1 Aug 2025 03:39:30 +0000
In-Reply-To: <20250801034004.3314737-1-guanyulin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250801034004.3314737-1-guanyulin@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250801034004.3314737-2-guanyulin@google.com>
Subject: [PATCH v15 1/4] usb: xhci-plat: separate dev_pm_ops for each pm_event
From: Guan-Yu Lin <guanyulin@google.com>
To: gregkh@linuxfoundation.org, mathias.nyman@intel.com, hannelotta@gmail.com, 
	zijun.hu@oss.qualcomm.com, xu.yang_2@nxp.com, stern@rowland.harvard.edu, 
	andriy.shevchenko@linux.intel.com, ben@decadent.org.uk, 
	quic_wcheng@quicinc.com, krzysztof.kozlowski@linaro.org, 
	dh10.jung@samsung.com
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
2.50.1.565.gc32cd1483b-goog



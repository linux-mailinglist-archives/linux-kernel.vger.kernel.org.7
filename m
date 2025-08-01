Return-Path: <linux-kernel+bounces-752836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 471B1B17B73
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 05:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E21313B288E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 03:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D9A1917F4;
	Fri,  1 Aug 2025 03:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dsegX+ri"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2550333DF
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 03:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754019623; cv=none; b=TeWBr3tN/Lge9vwtuYFb/qXwMIu0WPjLBrTgcnzW3bsZDTPqM08H9NroSd91hCzMXc12Q0f/lQlG+KrncOM5a66cRnMvQWSTShiyot5Dhfl+cTTR/wjd/UPerpjO/z9gOoDnqvzT9d0POOdHSkQIVrskI7OWNjF4Y+zmY8XoxJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754019623; c=relaxed/simple;
	bh=OV1+ZEarw1CZNgD7WrvpJ0n8ILFFL2AjuYkYa+QJD1w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=juTxmhZrcH10RSD8kwGpyu5ULu3wFTXxQ5GkdlHV9Mq0edOMcEbPh7t2LUVOwD/PZSc979py2ToPribX+jsbAJawULfusEklL/Y+UbyvK2IbchgTODMATTBuIzTG4XqdSG0EjKW2a8iRiOTjox3tOGhikHYpu9RPILTKa57CdqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--guanyulin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dsegX+ri; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--guanyulin.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-315af08594fso505633a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 20:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754019621; x=1754624421; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f39FWPhY0Gdd2aoWJ6mofpptanULX1lsHIPkk89i2PE=;
        b=dsegX+riA2EGLcGaKcilaOaAqiNYJtK3geSaQvrobwzpsUvtYBnj8ta+5S6qls5aXC
         29+qEc1ud8Fvinw+2ilt75RVoHEod99d4lU3TUGiYFJGTxnYv31fPavAZuplRWypGMyk
         Cf60g9xU9To2mY78vLdpsAfWBscGkxdK3s48Gh2MvEbuNuocVlJ+/Yvl5oZdMYzbDYU6
         rzsB60fKZZIBM5/gbG7LhTYF8vs4q3Cc/ezYHCN3yv+D2fv+JfsbaGuH8SrWfNW0UkW6
         /dW5ttpboTt4/ev7jfG3i0nLlrDBx69EwZl+UlKJibq/+JFSjLEOaFWtvAUR8H3b0b4N
         W84g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754019621; x=1754624421;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f39FWPhY0Gdd2aoWJ6mofpptanULX1lsHIPkk89i2PE=;
        b=VOr4dqvSB250WutdeWDeY4sk3xOvWWvCoinzRXCz9Q2zKsPIeJ3kOzGHeFv3mYk77+
         DBAX4b0o9ZazQ3y9EkXH67615AzNofl3xRdAehd8m/SAqja4kg4Y/xhuNw4sdtEm4kRT
         SE/Dgob8NuHz28Pb917MXBpolhnHoncs/MWL7T1v6CfksDsLo9HcKbpS+alYm03KMUtV
         v6/KIDTsWPyZShfkbBOhFUjoUSfWaXwuXLgHG3GJsD4xiaqTiWHljZ6sNOcKY45KoQb/
         Zuyor8hbvMVEnlCF1Gp+aMo3QdBP5Ky+uldwHxxZKYZzlcMbPZCH2mTalk+NPXxnlPBI
         E6sw==
X-Forwarded-Encrypted: i=1; AJvYcCWJZsY9VLJcYYis0qpROWT0xVLwIhIbTYatx8BxSv6hKVgE9lFX10JC6/XdiPRxQEVxk5cTccbT7W7iZ9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoXf/dJDakSNkRY/d3ZL8WjZFvJhNN8H4d5P3zyRFWu14j5QCa
	AWcp0LBzOgIRyJwzt0Ymtx2nSZcKGEclvBDqtxhhUwayOobefuZLN8m8PPdqT13Wo/CN4qsRn16
	u40i1Z6yB/cY7wlQysQ==
X-Google-Smtp-Source: AGHT+IG/FFYYA9oMyYOfoTFTyQYsWSMwD4vUIRL0tUP+NYIcDKShDR6x+J2/WXAuLsGsKG+CjbH758ABueSDHbM=
X-Received: from pjh4.prod.google.com ([2002:a17:90b:3f84:b0:311:c5d3:c7d0])
 (user=guanyulin job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5103:b0:313:f6fa:5bb5 with SMTP id 98e67ed59e1d1-31f5de54a99mr14029445a91.18.1754019621411;
 Thu, 31 Jul 2025 20:40:21 -0700 (PDT)
Date: Fri,  1 Aug 2025 03:39:29 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250801034004.3314737-1-guanyulin@google.com>
Subject: [PATCH v15 0/4] Support system sleep with offloaded usb transfers
From: Guan-Yu Lin <guanyulin@google.com>
To: gregkh@linuxfoundation.org, mathias.nyman@intel.com, hannelotta@gmail.com, 
	zijun.hu@oss.qualcomm.com, xu.yang_2@nxp.com, stern@rowland.harvard.edu, 
	andriy.shevchenko@linux.intel.com, ben@decadent.org.uk, 
	quic_wcheng@quicinc.com, krzysztof.kozlowski@linaro.org, 
	dh10.jung@samsung.com
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Guan-Yu Lin <guanyulin@google.com>
Content-Type: text/plain; charset="UTF-8"

Wesley Cheng and Mathias Nyman's USB offload design enables a co-processor
to handle some USB transfers, potentially allowing the system to sleep
(suspend-to-RAM) and save power. However, Linux's System Sleep model halts
the USB host controller when the main system isn't managing any USB
transfers. To address this, the proposal modifies the system to recognize
offloaded USB transfers and manage power accordingly. This way, offloaded
USB transfers could still happen during system sleep (Suspend-to-RAM).

This involves two key steps:
1. Transfer Status Tracking: Propose offload_usage and corresponding apis
drivers could track USB transfers on the co-processor, ensuring the
system is aware of any ongoing activity.
2. Power Management Adjustment:  Modifications to the USB driver stack
(xhci host controller driver, and USB device drivers) allow the system to
sleep (Suspend-to-RAM) without disrupting co-processor managed USB
transfers. This involves adding conditional checks to bypass some power
management operations in the System Sleep model.

changelog
----------
Changes in v15:
- Rebase on TOT.

Changes in v14:
- Introduce CONFIG_USB_OFFLOAD for control usb offload related features.
- Specify __must_hold marco on usb_offload_check().
- Cosmetics changes on coding style.

Changes in v13:
- Ensure offload_usage is modified only when the device is neither
  suspended nor marked as "offload_at_suspend".
- Move lock manipulations into usb_offload_get()/usb_offload_put().
- Cosmetics changes on coding style.

Changes in v12:
- Rebase on TOT.
- Cosmetics changes on coding style.

Changes in v11:
- Use USB subsystem wrappers in usb_offload_get()/usb_offload_put().
- Refine logics and add comment in usb_suspend_both()/usb_resume_both().

Changes in v10:
- Remove unnecessary operations in dwc3 driver.
- Introduce CONFIG_USB_XHCI_SIDEBAND_SUSPEND to enable/disable offloaded
  usb transfers during system Suspend-to-RAM.
- Modify the approach to detect offloaded USB transfers when the system
  resumes from Suspend-to-RAM.
- Mark sideband activity when sideband interrupters are created/removed.
- Cosmetics changes on coding style.

Changes in v9:
- Remove unnecessary white space change.

Changes in v8:
- Change the runtime pm api to correct the error handling flow.
- Not flushing endpoints of actively offloaded USB devices to avoid
  possible USB transfer conflicts.

Changes in v7:
- Remove counting mechanism in struct usb_hcd. The USB device's offload
  status will be solely recorded in each related struct usb_device.
- Utilizes `needs_remote_wakeup` attribute in struct usb_interface to
  control the suspend flow of USB interfaces and associated USB endpoints.
  This addresses the need to support interrupt transfers generated by
  offloaded USB devices while the system is suspended.
- Block any offload_usage change during USB device suspend period.

Changes in v6:
- Fix build errors when CONFIG_USB_XHCI_SIDEBAND is disabled.
- Explicitly specify the data structure of the drvdata refereced in
  dwc3_suspend(), dwc3_resume().
- Move the initialization of counters to the patches introducing them.

Changes in v5:
- Walk through the USB children in usb_sideband_check() to determine the
  sideband activity under the specific USB device. 
- Replace atomic_t by refcount_t.
- Reduce logs by using dev_dbg & remove __func__.

Changes in v4:
- Isolate the feature into USB driver stack.
- Integrate with series "Introduce QC USB SND audio offloading support"

Changes in v3:
- Integrate the feature with the pm core framework.

Changes in v2:
- Cosmetics changes on coding style.

[v3] PM / core: conditionally skip system pm in device/driver model
[v2] usb: host: enable suspend-to-RAM control in userspace
[v1] [RFC] usb: host: Allow userspace to control usb suspend flows
---

Guan-Yu Lin (4):
  usb: xhci-plat: separate dev_pm_ops for each pm_event
  usb: offload: add apis for offload usage tracking
  xhci: sideband: add api to trace sideband usage
  usb: host: enable USB offload during system sleep

 drivers/usb/core/Kconfig          |  10 +++
 drivers/usb/core/Makefile         |   1 +
 drivers/usb/core/driver.c         |  50 +++++++++--
 drivers/usb/core/offload.c        | 136 ++++++++++++++++++++++++++++++
 drivers/usb/core/usb.c            |   1 +
 drivers/usb/host/Kconfig          |  11 +++
 drivers/usb/host/xhci-plat.c      |  42 ++++++++-
 drivers/usb/host/xhci-plat.h      |   1 +
 drivers/usb/host/xhci-sideband.c  |  38 +++++++++
 include/linux/usb.h               |  18 ++++
 include/linux/usb/xhci-sideband.h |   9 ++
 11 files changed, 307 insertions(+), 10 deletions(-)
 create mode 100644 drivers/usb/core/offload.c

-- 
2.50.1.565.gc32cd1483b-goog



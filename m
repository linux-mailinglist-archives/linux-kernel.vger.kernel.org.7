Return-Path: <linux-kernel+bounces-880665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F08C26481
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 327831A6461B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2A2306492;
	Fri, 31 Oct 2025 17:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G9nHaUnf"
Received: from mail-ot1-f74.google.com (mail-ot1-f74.google.com [209.85.210.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2993019B1
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 17:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761930370; cv=none; b=TuT+F3oiAAzln7CaUbo5IMM8vVZOB5YeruMYm3rRUH0GOOk6FnftAPB9jZWlWTvzcBCD8PbHS3OFnGCU+iNDjpCaAWCw6MOs42hSgcYi3WeW0LeCc2WTvXYDRgRiFyvE8TwLs4ZWiRcY1cYQ3U/CJo7McBwTgWUCZkISgwK3HRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761930370; c=relaxed/simple;
	bh=QwYo/Yoz+I4T+rZY/7ih9WEmyZPRtgRok11KJciMVYc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=glzCOXrAHYt54hwKrD83jOv3GpdyVMNS8ggnOdIINzGgR+Cikg53NifJnWbqZFDg5eq6Pnmnh7DxwglMt1mMId2p2nKj2WvYAROe/r4LI5XdCfKJEkMBQh5BqYhXw68UjNLX/xmxNmf2tDU6gTpqAsU6g9hGinlWMF4KD9oFIhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G9nHaUnf; arc=none smtp.client-ip=209.85.210.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com
Received: by mail-ot1-f74.google.com with SMTP id 46e09a7af769-7c3e149a815so4543108a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761930368; x=1762535168; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OY4ljaKFzmW3A8oE1zEU8ROXOLit9Ajx9xtSY2H7jXY=;
        b=G9nHaUnfUjt68aiP/CybRo7KmwBmq0K7B4ZpIEJlRCYW7Fps+ADEwraw2+Mk83Wopr
         //Ba16ZKuIb8LmVrMHN4VGcyZpQ+QKVis+CJxXuAksXD5PhnxTnysN79AZ5k5y6pUxC5
         VjNZr9+ciPUxYapnFnKi9VfN0MEgf8xsEstL5fN3GON0O0tt2GnLI8wMSU1bDw41Faz3
         QFw4iaUCIHgCgda/+/+nCwfe8erV8dOxdleg+ruabOBCH+vS5axxtU3uWnsOGbYAFogp
         m2wdvSjAeiy9MUFpg3PXT1UGyhrY74YuHkPEPPOATN2MH+GutjR4HM2HKDuC3wltCpNA
         +MqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761930368; x=1762535168;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OY4ljaKFzmW3A8oE1zEU8ROXOLit9Ajx9xtSY2H7jXY=;
        b=ChyVUia1s2Ohv+tv+D39iFCb3Qz3Cvj3dmc3HYC9yBeUioPLIZw2O8gf0YEKgOmavV
         wzkTY6X56YKYKrbwcMRK5jBLtXiRxXSjWcq5EU3f9cH3d1tZ6OWl8xHbnQW1KEkaC2NA
         m4LTT2dS9qBaIsg/YF1IUB81CAdSk12+yqYMnBKhAHvmiARRY514D4iKFcwUJIExYNwJ
         QzR5XKqHteYRB68eFQ2L7iozhJnOnejxq+JbdjbJRDtGYqQVbx7e0rQS2tyHZqZ8Hs8w
         6JPTe4PRJGvxkUBr4Hkfs51qPzGJVRyGWo3CxjAtLOvQbXBU4RBxLKjtG5lZcW8r6V6D
         JdKw==
X-Forwarded-Encrypted: i=1; AJvYcCW2sh558mYAyQjVmn2RyWwSM6nbajljwTP6QsurazjFvWndYyRTRVn9IDgPL6z5yhWcEXcZ4gX5P6GeFIg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2UNDZqenkj+c1Y75bWZMbZSwEu7vRo7wVO0vCqLvNi5ndJ93T
	cWt6gEBS+KhGJ44nv1mm3Mt+2Ij5K3iHjxNxfDGyDXmCicZbkP8/ztB7kg24i5McvrTogTPD33m
	BUoGamQlcmA==
X-Google-Smtp-Source: AGHT+IEnJVtmijC8TzZF5pGhOrZATGI47Fj98vUFRBqaKlvcaJ3uI54EHz3UXi30/Su9B2TFuWmC2JYVX9kc
X-Received: from otar9.prod.google.com ([2002:a05:6830:1c9:b0:7c3:e32e:483d])
 (user=rananta job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6830:6110:b0:7b2:8ab:69bd
 with SMTP id 46e09a7af769-7c696847015mr2109668a34.33.1761930368062; Fri, 31
 Oct 2025 10:06:08 -0700 (PDT)
Date: Fri, 31 Oct 2025 17:06:03 +0000
In-Reply-To: <20251031170603.2260022-1-rananta@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251031170603.2260022-1-rananta@google.com>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251031170603.2260022-3-rananta@google.com>
Subject: [PATCH v2 2/2] hisi_acc_vfio_pci: Add .match_token_uuid callback in hisi_acc_vfio_pci_migrn_ops
From: Raghavendra Rao Ananta <rananta@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Alex Williamson <alex@shazbot.org>, 
	Alex Williamson <alex.williamson@redhat.com>, Longfang Liu <liulongfang@huawei.com>, 
	David Matlack <dmatlack@google.com>
Cc: Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Raghavendra Rao Ananta <rananta@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The commit, <86624ba3b522> ("vfio/pci: Do vf_token checks for
VFIO_DEVICE_BIND_IOMMUFD") accidentally ignored including the
.match_token_uuid callback in the hisi_acc_vfio_pci_migrn_ops struct.
Introduce the missed callback here.

Fixes: 86624ba3b522 ("vfio/pci: Do vf_token checks for VFIO_DEVICE_BIND_IOMMUFD")
Cc: stable@vger.kernel.org
Suggested-by: Longfang Liu <liulongfang@huawei.com>
Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
index fde33f54e99ec..d07093d7cc3f5 100644
--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
@@ -1564,6 +1564,7 @@ static const struct vfio_device_ops hisi_acc_vfio_pci_migrn_ops = {
 	.mmap = hisi_acc_vfio_pci_mmap,
 	.request = vfio_pci_core_request,
 	.match = vfio_pci_core_match,
+	.match_token_uuid = vfio_pci_core_match_token_uuid,
 	.bind_iommufd = vfio_iommufd_physical_bind,
 	.unbind_iommufd = vfio_iommufd_physical_unbind,
 	.attach_ioas = vfio_iommufd_physical_attach_ioas,
-- 
2.51.1.930.gacf6e81ea2-goog



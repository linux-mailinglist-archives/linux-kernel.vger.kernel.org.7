Return-Path: <linux-kernel+bounces-848048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFCCBCC599
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 11:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F4ED400482
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 09:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B59E26A08A;
	Fri, 10 Oct 2025 09:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="MYqrMctT"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862CC2367D7
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 09:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760088679; cv=none; b=WXPI943HKgCpZk7jTQq6TGfUK5TK3KvrdLlggBriJbSCOOMvgSrDfeHEDyEcDhjx0oWaCOB1OysZWA3H1rlNYf/oZd+Y0SPL2uIwvM0BrUjcNiSBTpG0GSFzgyuxE6QKKyJItalfzO91N2vU1IIoCzmsDvkcrM1B4L/xmPI3FQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760088679; c=relaxed/simple;
	bh=qtyXxFNzYev+4sHY1k8Z/6Js1alEBiyh+ltp8YfTrc8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=IR57KO9ZpGOcIo+zKN+aZUKn7iiD940AF5N1SJyhx2KPiXCWMGejtZiAJk8YQBQAg5N95isF+XakhzLvr3WdpP4fFeu6xZpWuKpC4NlsvBqNJXXWpyTlHY2ZLzZnFv7gntc2oPInubPk75qIeBOajNDrWUX9ur4lGe/IpoeEHi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=MYqrMctT; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3322e6360bbso1848020a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 02:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1760088676; x=1760693476; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yfrfouF6ETlGfTduy0jm/scXEJivTXLL0/wFTholkM=;
        b=MYqrMctTtIRkUatV/tPgmzDTN6cdq2DHQm17cQVD9k7oZtZ6hFfK1A+aiKssKuO5U7
         sd0nCps+/GkOLHnovzKkTxw5godcnVy1JrUN81p7uuO2AHk5RYWqecZ9JleA4HNN/Tvx
         1jCLmoR7wBuAgKAUgy5Ha+gNzc5plo/dAJM8IllwZNQtcuKwC9Qve6pd2TvmzYuKvqZS
         Hiom6pdRxU/SWeu5VnPtWWQIegrpzx7RPssQKg+kX+PAJwNDoJBR7np4caEkUEwN2XSs
         T9c8YzGUxfu4dJW/+F35G2HRoaE/hSVL3LMrOi1M2q2xlDjLyHPK8KpH+tLrgOIMpfLh
         ObtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760088676; x=1760693476;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8yfrfouF6ETlGfTduy0jm/scXEJivTXLL0/wFTholkM=;
        b=o5Gh/V8J46/ZVYqoTypBqq1u5+INyrMOHTwkEuLNqIfEfOhMiyfB4mxM0yUGRXk4qz
         nL0/SWrRXuRz3iaG9iM5PV0iMwRTjnO092YVhEpInXLTb1t7QcJpqHrUWICNBQ3yUPr9
         Ddg4DlBBwH7B+C5LH4C8mBegHOvOTWj+hknF//kRboswMH1fkTM9bDrGkyIH7S2sD2IZ
         Kqtv0gKcCq4yPC3RYOtku6Dm70WnkD/ECtFdZinq3UpSPD/jUFQcTtZwxytnQb/YV0O/
         2JiVkdcMrC1RNa8EAfK1d+4PQnXos9fYzcvBwVAt36uHM6vjbf767FWLNXqWPA4Siacy
         XEHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXltXpNesLXVPqjeQuWp+7ML+sTvGw4bG7E3BAMvxvTVWO/8CCOVQ8+vSEwOOrjj7DphpHyNbAXLCQDPck=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYWkjk11ZANyGdf5Df3U93X/iMQZmiX2tnGBQCxeBOX1L+iFq2
	CLAVuZpgxaBop1kASSbk7lNbNz6X18TQEUe8lvrJhqwW+UvnPFteQY6gqYmrfcvi+9A=
X-Gm-Gg: ASbGnctYLJ2abc2rbN2is7aa5fkd3YvNvqOMxL4q7Dut8S0GXy07+GJbpto/aiJwiIa
	lC9DH72GcYgw8XijVxgtIaSh6tL9GmGreQTgGsN6D3OcBgWqqfJXR+VpPzBjJFcuRkLmd12vsFn
	DfhSlQVSq/+lU2D5tFrL6r8DtDj+00fYQlIxMSg2AqLslfEGBgN4UrwQa6ZmPzO8zXV9QSBZAuG
	JCRKE7OmoZPdljfGIgwgfgBYUkGmXxJDdMTLvrvrUcx5JVx92E24QVxiSjhDPEWAy5GflvrPkMu
	KQxuA2XHd3eL+7WDSVPawCEF9d77I9ZDWEMCt/bYQz4+uKJavq/g+cCJQ1cAbBIK49tpGsPHAb3
	mIOW7l5zrtIovbyVpgSJEGv7Kj0qNHz3th6Fpzgdr5yseNmeJ80v1xbeIEWVSdzymUUKP+4RIGH
	3rbeLLXww=
X-Google-Smtp-Source: AGHT+IHSgg7Vs/AmjdYxKvPGcURSAQYHV4ZPv29Nlxam3ApHMkecbSxOuVRV94M98KvI//bX8lmIYg==
X-Received: by 2002:a17:90b:17c2:b0:32b:baaa:21b0 with SMTP id 98e67ed59e1d1-33b510ff5dfmr15768963a91.6.1760088675545;
        Fri, 10 Oct 2025 02:31:15 -0700 (PDT)
Received: from 5CG3510V44-KVS.bytedance.net ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0e2d51sm2308775b3a.65.2025.10.10.02.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 02:31:15 -0700 (PDT)
From: Jinhui Guo <guojinhui.liam@bytedance.com>
To: bhelgaas@google.com
Cc: guojinhui.liam@bytedance.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] PCI: Fix potential double-free and add error logging
Date: Fri, 10 Oct 2025 17:30:21 +0800
Message-Id: <20251010093023.2569-1-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi all,

Two patches fix pci sysfs/procfs issues:

1. Avoid a double-free in pci_remove_resource_files() by clearing
   pdev->res_attr[i] and pdev->res_attr_wc[i] to NULL after kfree().
2. To make PCI bring-up failures easier to diagnose, log the errno
   returned by pci_create_sysfs_dev_files() and pci_proc_attach_device()
   in pci_bus_add_device().

Thanks,
Jinhui

----
Jinhui Guo (2):
  PCI/sysfs: Fix potential double-free in pci_remove_resource_files()
  PCI: Print the error code when PCI sysfs or procfs creation fails

 drivers/pci/bus.c       | 9 +++++++--
 drivers/pci/pci-sysfs.c | 2 ++
 2 files changed, 9 insertions(+), 2 deletions(-)

-- 
2.20.1



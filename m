Return-Path: <linux-kernel+bounces-840276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AEBBB4030
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 15:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C76CB192609F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 13:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5020D3115B1;
	Thu,  2 Oct 2025 13:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TtOU6QpN"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B000F30E84F
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 13:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759411151; cv=none; b=JDHekmGi4mI2xTQCwpLsxcOtDxIUGJ94cYAjo2YlJZwL4qwfxbz2Ikny4ZWXzYb0AXDHP5wxkMOSYitGCWF+aGws6VlH9fI0cChu37fAqXY8K/93we9sbQp0GBVLqtNc5VRP94/v6Kz4+gIeHZ5fl9CQJCnTPVVCZAMNCaL53VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759411151; c=relaxed/simple;
	bh=ppas900mz8UZ1nAze0k0cgvVf6bsDr1n1l1Zsx5qMIg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JwlzksK/JKgzDDjycr//1cDFahj1bt+zqIjzNxr614ZO6IyinfUrCvqzOvyYydrbhU6VKzod6ENhDIa0xoqxLHmfHNF1QFQW7NpEzUsq2Ntrv6SRcFPpXIb5ZtRYW5PG3x7XKbcMzuUkBSiTTiM8ocMCexC/yHHtBoD7PK9DAPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mclapinski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TtOU6QpN; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mclapinski.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b3d83a7b6d7so90302166b.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 06:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759411147; x=1760015947; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=opsuLXZalKgBtjjtUFfr16++aW0WmcWbDZvURSoXadw=;
        b=TtOU6QpNzv8icRxuaer3wPSVs9Qa9NuKzE9tzfCo1FhmvmFadrFWAI7ZcsFT6TDBT6
         4SzD0ioiXpkMgvuptYr43XoEQ3VGmnlvcQpqM4YCZUxqWpDjqaMRCzyOCvZuMLDjUzCc
         TxaqTVUXHLEwZuzj2/1OslrZXqvRLnGWva3h5dz5+X6nUPsNNDhhPLnuRoy5/uO012f9
         XnduKcQJyheRt7xLY87Fx9WC6+8t8oLgGEMVrU0w9Tp4M0+XI21rbaHzItQYtVdE0doG
         GB1Z07riVjSAZHus9SiBlTs3APCdTS/d3m8dAZI3ZFjMkX1iJU3e1xh0zYAUdEWnG/vL
         kNmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759411147; x=1760015947;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=opsuLXZalKgBtjjtUFfr16++aW0WmcWbDZvURSoXadw=;
        b=vRqVma3Ss7+3T+bLAOb1nRq3thJVRK8ZbCMWRFrwrBSqMFmPapiPMeg/YDdn8QCfc9
         +2tTqcWqxYcpvCbxX0L4aLnNb0v+DW+tOr7LzDRWHy2wCMXzLxNrvEaZ7gbKOTTjuQVv
         xtUjPK4VaKbdwo3VOg757I1G89egt3a4Wv/Oqc0A7fnK5QoiIexscWVzP2uRFFF9Qzvd
         6FPy6Khkr/FRebyEoq8I0ZUZzl+6BvfdbYpsbR8RtTUUYQi5hZCXED+7wNeRhEJT0uuF
         0pSfzl59ZiuSgPGsRyQM9B5sLpnPTONSDJhqwGvMYD6Tt70n/DBoHTqUztAwi6nsGgLe
         M5pg==
X-Forwarded-Encrypted: i=1; AJvYcCXQdXCXxgfcl6B7k8Mdbo8LJe7VoH1CjVelD+oYIovcoN4tbcZ5x1KQhWpuC1P5p+YN2DHZQE0M1+yrCvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsF5W7k+vJxQzAHwIygGE181T6laAAmYl6Pqx7QVEFMf4fK/Qu
	3xyeRgrc1wyDrOWdYKUOpO3ylA8Pq20JkJCt7ZRC17yPudthM9EeCvoonqZXv+BXWAbJWtXU2LB
	f8qW3ufG7gp56KAUjwMVuUQ==
X-Google-Smtp-Source: AGHT+IEBOtinBILzYUipbzKT6uP64K+v7i7D/BSugv8X6CMyxWJNMehP5LgieusjsvQy15d5i9FRZHYKNzdUhUgV
X-Received: from edqh26.prod.google.com ([2002:aa7:c61a:0:b0:637:b54a:d88e])
 (user=mclapinski job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:94d2:b0:b2f:2c8a:680b with SMTP id a640c23a62f3a-b46e7bbb560mr870743666b.58.1759411147168;
 Thu, 02 Oct 2025 06:19:07 -0700 (PDT)
Date: Thu,  2 Oct 2025 15:19:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251002131900.3252980-1-mclapinski@google.com>
Subject: [PATCH 1/1] dax: add PROBE_PREFER_ASYNCHRONOUS to the pmem driver
From: Michal Clapinski <mclapinski@google.com>
To: Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, 
	Michal Clapinski <mclapinski@google.com>
Content-Type: text/plain; charset="UTF-8"

Comments in linux/device/driver.h say that the goal is to do async
probing on all devices. The current behavior unnecessarily slows down
the boot by synchronous probing dax_pmem devices, so let's change that.

Signed-off-by: Michal Clapinski <mclapinski@google.com>
---
 drivers/dax/pmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dax/pmem.c b/drivers/dax/pmem.c
index bee93066a849..737654e8c5e8 100644
--- a/drivers/dax/pmem.c
+++ b/drivers/dax/pmem.c
@@ -77,6 +77,7 @@ static struct nd_device_driver dax_pmem_driver = {
 	.probe = dax_pmem_probe,
 	.drv = {
 		.name = "dax_pmem",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.type = ND_DRIVER_DAX_PMEM,
 };
-- 
2.51.0.618.g983fd99d29-goog



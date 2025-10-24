Return-Path: <linux-kernel+bounces-869551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20ABCC08263
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 23:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFAC13B6953
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 21:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690072FF66F;
	Fri, 24 Oct 2025 21:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vIN7buj8"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290692FF650
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 21:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761339940; cv=none; b=KPvYK0LykyH4Nw/VCla65N0D6gcdcqqVxerpMr6KZTcKabXknlWQ9DPDSM2RxUslQWHzVJixyH2Q5cOA1oU0au4iCVISWcYfKTNiDPnLno3TZsWR7vUumnLAU/Lpb2DhCDGOGiPxP8a2tGUXmNqAHSF+UziyEYVMV8YnKYEUScY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761339940; c=relaxed/simple;
	bh=iZaLtX3BgeruWBIIuF6rywebvdAOWRxMNZoMuebQSVQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jomHdcd/WbjIdkntYzZ0V2QQtCRvaIvH0MQvU/0mRsYwHXVojK2GCOf9PzHo6VqKDJ/D/uWgcrtgaP6x/yyBwb0HvY6OBvigTxX7hFayljSvBzrWQvFd1s14FxF6oWY26p2pwjMVgUxLWn0gfQX0q0TnP3Bn5ix5srEhpGPme3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mclapinski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vIN7buj8; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mclapinski.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b3cd833e7b5so279419066b.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 14:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761339937; x=1761944737; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Ds0NdqUYXASBVzHzkeWNidjXkrqGljV6rpvXJEwlSc=;
        b=vIN7buj8DMT5C8bwP8jyXEZazgrWHEFoM8e6FbttTzAcOp/RL5KBAlNi+s8BpUz1mj
         1zS7UOfjNhi7hYbsZEfaaoaISFWgj79ko2S4cv1W203huJmAicL/iT5D5x0J44rRARvv
         7cSgUoUspx4gAs/5apX97YWKmFMXfT25NAAQG37YLRdocAjJsyUvA+MwxeB8eGzV3p0O
         vnfCIDHYRxkZsWJunZd+3y5YJpET8dbI/0O1UGkuUDOBZ0z5v3EEAom85rgzQVlJWoh8
         +6Hd7cDLzGsFdLCn5bTYwPHcMo634D1cSRL7Xh/hnrUTg8GOzmRu2Z5djOlExoQdIX6h
         MhsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761339937; x=1761944737;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Ds0NdqUYXASBVzHzkeWNidjXkrqGljV6rpvXJEwlSc=;
        b=ozXzcLRYDFBqFYU4/laZXmgT7vC9YcQngFLXedyjgbX9Be9uKrOsL/o0GT1alXAGn6
         rgDzvgb+Q8D6/VbufaMSChLYiJ5tcY7HnCOZ22NF1FAdXRVbX/eE9JesOl8ntQXhDzUF
         G0Q7+NeWHRPmvil0R67cybSqkrwiCTohAhlFdOvzeFSGzUrxnwVefhI8/C4Z5hHhiH1e
         tL4lnoVl4EyF2JYObSB4UFJpX1eMAxihdwfbmzOU76ioFn2Z6QdGw9lwH6YT3lSc6K9G
         3V8GpcUV5t5oZc1qPByYTOxbhZXynpYRBeVcEw6Dq/vqNkqUN9lIkfrJE/UO2ZjtvY+D
         P1WQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhpMUSsaekSuAYlKinAkTLfVYp+o0+FYQcXXxriPjTksXNhiwuVIFsHEFK4QtqOqrnqFo7RzLg82kWha0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgGIxroEiXN/sczsuCRb34WDIxFRft2ee/TyFMws+8whMgTkBw
	1wbwwBNKKUSSV48MWqDcMzyhYT1JZl1lVUUfGE4CBG+VSXqAzUFINBxmZxe6bYDU9BlYu8Obkcz
	lRsEDB0z5GSXB6eGTNZmawQ==
X-Google-Smtp-Source: AGHT+IGFm0bKZf5luxEJnL4z4gMCnARfFasz39nHCFyvwVkRdTLaWDrTQIZRmknslrT4lvlOpHdDBmT1yTh40GS+
X-Received: from ejdm12.prod.google.com ([2002:a17:906:160c:b0:b5b:905b:ffa3])
 (user=mclapinski job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:1c28:b0:b3f:f207:b754 with SMTP id a640c23a62f3a-b6474941139mr3593500766b.30.1761339937274;
 Fri, 24 Oct 2025 14:05:37 -0700 (PDT)
Date: Fri, 24 Oct 2025 23:05:15 +0200
In-Reply-To: <20251024210518.2126504-1-mclapinski@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251024210518.2126504-1-mclapinski@google.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251024210518.2126504-3-mclapinski@google.com>
Subject: [PATCH v3 2/5] dax: add PROBE_PREFER_ASYNCHRONOUS to the kmem driver
From: Michal Clapinski <mclapinski@google.com>
To: Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, 
	Michal Clapinski <mclapinski@google.com>
Content-Type: text/plain; charset="UTF-8"

Signed-off-by: Michal Clapinski <mclapinski@google.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/kmem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index c036e4d0b610..4bfaab2cb728 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -274,6 +274,9 @@ static struct dax_device_driver device_dax_kmem_driver = {
 	.probe = dev_dax_kmem_probe,
 	.remove = dev_dax_kmem_remove,
 	.type = DAXDRV_KMEM_TYPE,
+	.drv = {
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
 };
 
 static int __init dax_kmem_init(void)
-- 
2.51.1.821.gb6fe4d2222-goog



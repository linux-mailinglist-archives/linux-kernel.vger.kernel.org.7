Return-Path: <linux-kernel+bounces-848053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 54EA2BCC5BA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 11:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1EA384E2562
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 09:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02577266560;
	Fri, 10 Oct 2025 09:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lFoIQnvb"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F59231A55
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 09:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760088768; cv=none; b=ImYERyp2P2zELhD0cFCvu5UHnE+cqJoXq573cpEMen+0ceCMZl6xfJmz4cFOCieiF6jcprRBIKj2YYCjopZ7vFhhE2Iv9Z0YYW1b51axRaLDPtpykyQV4KDKFj/pAltPtS3bAdm37hSFMhVrRzLzTeJHRaqmzGHU/ZHgxNhJHTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760088768; c=relaxed/simple;
	bh=8jR7JCx6mX9Zjdm10k9TjKk7p7TSQ/2gxTGENPOyPzM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Nlop03nDd62/k8C6XzLmR1bt2yhhNnbOgsq+vMlt0pxcGCACyE4Cii2vEdlGbGKjibSZk3/c2001Av21ZZ9g+N/kaQHXhXcDILjo0CL8FLjjKrRiUYeYWC6YyuPjPorC94wZA9CNQXSupV8Xyu4O18NhuAlEvHTxIhJqKnKEGHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lFoIQnvb; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-78125ed4052so2241698b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 02:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1760088766; x=1760693566; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e1j4JQEBprrAt8CIDcRJp5F0vEJV3rg2M42iK6PPNrQ=;
        b=lFoIQnvbzSz4sIbeEoGUrG35qqN3TGY0x3e78cgliwjD5buWtIvkJWchjDUgjhQEOe
         AZnzMb8m4W+a++0efs09hx+QEn5gOWi6wreVraJKlK5nk4J9qFlPKwMxwwtt/jqHIcWq
         WlyIU9zCrK+P1+dmq0/5lqhV+Nei3alHefEaFOuNAsRPv7pybR76qGA/PtzhfDcdrsND
         8+fWARd/L9bVv1pha1w5Zc8HgfhCMpDmjW0QqH3Ld2l06Es3d+5VtF8XUkv0IgPirQyf
         IkiBSpzFauVFTLdHszAQ2/u9hWoj5ccu7o2eRDhgVBFVo3eUBQDMAr12UBAgGnUHBpz1
         Xz3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760088766; x=1760693566;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e1j4JQEBprrAt8CIDcRJp5F0vEJV3rg2M42iK6PPNrQ=;
        b=QUQPrPCH5mIWwf49lTYgYKT8/cWwqOCn7Q4SNa9Ahic4OOu5YJcOUbUZCjV9uIOAwy
         y94yblUHMIPfqVDABOwq8s6vCyRz5l9uk4x+GsxxcqthCUVlYfJeWHYCF8wUp7udBgeu
         bZCkQre3YrTae9eKSNHZoPLtO4h7+Ihxy9bEKGpri619m2CVcIAyyGC9C+ngxJDZzbb9
         yayHrVfuemN5xXpCNxndnpFOSmtEzXiUfWN/T6+0S63vrplLLoEenVyviWXOlL7JQDRO
         sT7OFQIHFoijFIvN9UBi2/3fCaJw/ZJMzdk1AvmOmoko5/CsvzymKcrDsOZfcjK9GevR
         WcgQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4Gns7Xg9msLn6fm4EgFLUaeyk5NEbtaPkIgdNvo811Z3UboHJ1+f4J0BIoYh9TOVG/7KxxNinpue5LuM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8v/U4gT/hT1gIHBqU06gFtokEc2zYmrLgZ7L2UUjKE6wXiKuC
	dzAZvhq6RybpRyY5ctnJlurPlnonP68mI0k9F1UwglvMde2zPABOymNu+gU3pr+TEno=
X-Gm-Gg: ASbGncttdxYF2gfd9uuK5PpOytR2tmD+fgFbzwaBC0fLHvje3O2b10eNQjw1MKbFLUo
	JizmRWdJlhspBSfMQDZ+HitDq71lWpxV/7gKIB34BtHLaRJgJhNk/Ri1cGXi+sednYAu9GPQYrP
	04lBsrpLe2yVbWU6lxtISXtYFrXKa2CbBSqn7n4f6VaQ0nDcg3hUxwWVwyP8sBAekDdMMFvIqDR
	1lWhrVI4DbNH1cvly1kDK+xaUu3DaiaHgXhyPPWbzGEfnjslQQZ7C8kf7Gj2VtBZvdJ7bf/A7ji
	+yG0Tn/y2GGGRrfEuV/by0BQZ/ei1n/b60EqMVpuCBWQsYCYNJ7FBaI7MxDqYW5IBv3mtbFaIBJ
	kxkhDJBfKu22m41SICj0FbkqB7xazpgDkwanMnfNIktRTeJ/kZ2Xcj9PJeEu3ivDKwNIGs18aAu
	091CKQYV0Zua/7v/0SQA==
X-Google-Smtp-Source: AGHT+IEHvg8I+2J3GlYDkq/cIvoLiQvtAkgOU8NxYFWlvB/PSTBrQS6eSFQh8W9oHia17FqxPc8AoQ==
X-Received: by 2002:a05:6a00:399d:b0:781:2656:1d6b with SMTP id d2e1a72fcca58-7938763251bmr13394405b3a.24.1760088766109;
        Fri, 10 Oct 2025 02:32:46 -0700 (PDT)
Received: from 5CG3510V44-KVS.bytedance.net ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0e2d51sm2308775b3a.65.2025.10.10.02.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 02:32:45 -0700 (PDT)
From: Jinhui Guo <guojinhui.liam@bytedance.com>
To: bhelgaas@google.com
Cc: guojinhui.liam@bytedance.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] PCI/sysfs: Fix potential double-free in pci_remove_resource_files()
Date: Fri, 10 Oct 2025 17:30:22 +0800
Message-Id: <20251010093023.2569-2-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251010093023.2569-1-guojinhui.liam@bytedance.com>
References: <20251010093023.2569-1-guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Avoid a double-free in pci_remove_resource_files() by clearing
pdev->res_attr[i] and pdev->res_attr_wc[i] to NULL after kfree().
If pci_create_resource_files() fails it immediately calls
pci_remove_resource_files() to clean up, and the same function is
invoked again when the device is later removed from the PCI tree.
Without zeroing the pointers the second free would operate on stale
addresses, causing use-after-free or a double-free panic.

Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
---
 drivers/pci/pci-sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 9d6f74bd95f8..a8a27d6c62bb 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1222,12 +1222,14 @@ static void pci_remove_resource_files(struct pci_dev *pdev)
 		if (res_attr) {
 			sysfs_remove_bin_file(&pdev->dev.kobj, res_attr);
 			kfree(res_attr);
+			pdev->res_attr[i] = NULL;
 		}
 
 		res_attr = pdev->res_attr_wc[i];
 		if (res_attr) {
 			sysfs_remove_bin_file(&pdev->dev.kobj, res_attr);
 			kfree(res_attr);
+			pdev->res_attr_wc[i] = NULL;
 		}
 	}
 }
-- 
2.20.1



Return-Path: <linux-kernel+bounces-746473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BC2B12715
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 01:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A62113B4C85
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 23:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8E5259CA1;
	Fri, 25 Jul 2025 23:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="KkbD0+ld"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6196622F767
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 23:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753484823; cv=none; b=Vaj0E/s6qtg2WJ/ll/oXXtJ0bGmDoFPyPIcIPPuya1T7SmqYZTaOv/OXQPqIhdhEurxlEZ+6uGl0lzyd/K+lNuMmv9K+usUkFx0X2ko4GaZNJA/GKHvs85WgOzT/JLQ7SOJArmMxwgUSYSZzHFuKCy8SOR8x3klqmAn8j+fQs9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753484823; c=relaxed/simple;
	bh=Ea1M3599d0sp1UtJk0yYHb6F3eACngIzc05uzsl1XtM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=udkDMN+OaPjM/3k58+STevukNl3Zu1wFjq4pSnB5+SEuTeu6UEISDQajAGBSlVZwuzFuSGXVEb1bYwZpIUYeyizwbb/msf80EbMIKLmf5NPrh9WqirJ8zupdksSNqTPAYyAhAetQPFRYX6xGoCQdKODTGiRVVVAJoYCoYVcrxZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=KkbD0+ld; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-237311f5a54so22131695ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 16:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1753484821; x=1754089621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Enc9BeBbBRQ4mYj3iJUiJbnavkWYlwvRk90VdauwkTI=;
        b=KkbD0+ldj8+/wamscbGbWCyMf5O1CuF8+k5SCpyrT0YDReE7U9E7It5YWNIJcJJOCU
         R9V0aklTcStfeM0dLIBuUimk4Lp5uJU0+NDKdTApDpcO6rc+Yx2tLZg9SqoAKUXeZG5Z
         d71xMAUpuqgLTkNj3jiMc+fZZWODIQZS2qI1pO6Esim6riB78vm2S0fP47T5k1t3L0EI
         ILpSeQOVLCyrtdZZumJTGkDhC2ce0bLPMId8XJVZ9AZTiVJznbqwU8INA69zE93mcStn
         sdsnYObk/r0IjM1xlohX/nMDhs9VJjvHMoS9DJQ42fe/NGVtDmlavSjBMcHZMKNccFwf
         1mAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753484821; x=1754089621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Enc9BeBbBRQ4mYj3iJUiJbnavkWYlwvRk90VdauwkTI=;
        b=XPpgR3+XsCBttDGXLSpZadawESOLcpeYi2TZxUvAADoWjbPFqyU7Jh1i1aT5E92NSp
         AiQB9hCC+Kr9K5ZkgBOLdi3XUscJ8G7sl+J9o4zQcFVqnxGbRry/OaeGKOOLL6WglZ+v
         r7vrmOSS7kLzi0v4OX6FCBxWXTCAUk4RkPGcUlzj+Jl8R4cPdDFfiksrK4qLlN/VJy/b
         8z3rEtipw7TyLULQiDxEgz3n2+XmmI2N01zKuACBkBZYLlS3/aR8OvhhFDvbgCkG9EBk
         E/6ZhF66gnubMwb0Xa8Ke9m+XHoU+T/XAOVO7xr9vK2MKGOCoCz4t2Gv7B6B8uKNPGGF
         C26w==
X-Forwarded-Encrypted: i=1; AJvYcCUzltqYqTQnhrmboTJDVXVQzdwTDI1kUm5Vp2OuJvs+LSmgtzwxV1FuRfVSP4upXto67Timwpli8vtChZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbQ94XMyuX7Bpp4m1VuvXpSeHJFNP0th+N55k4hHzjSmnJBzAe
	+3HTXc4EZaYGLg+B0YYadR2rP+Sh5D8ZzkTgexAoPx5rLdZIONZmtM037EB09JCvSZY=
X-Gm-Gg: ASbGncv8T5uiYMXyEFKlgWP6Rh4aIh09jODFc4bUS1HgUIWO/5FkwP8ptHxjBIkvNoX
	PXOzGrE1nnAGozwm+bUcOd/tU+QoLHJKHKYpLxvbmGYqV4V9kIJ1bgR636EfCDgQJcgNeqY3Ikg
	8senYYbnKQERwbqL3Wg9MRQMAC5B5+pNNux4ZCScHXoj9AoE+OnZx586okjNtYlYA18rMiA9xC/
	e0ovLAqUuyQ80BgHMsT1TdoczSeJc60puvwjdlkcFqOu1dD+Lc2kUJtDkgkm6TKtIEW2pbjJiJS
	6vqcymoxIJy9B9tPDexEIVL4xXMB9TYB1UPbOmIcqaTzjKvs/lN2vKLZCd1p7WwWftHzdREHyCW
	ptpQmKlp5yHU6E/JqIrOuXYw1Bg9W0DpsExWAFNFYJ2uJOw==
X-Google-Smtp-Source: AGHT+IGHYLzNYVGgKXl7e2IG/Y+aFt8LWqtYYVeMQAQH8l/BeKnXK8rfgk9IxeVQEjtzftDsgLeiMA==
X-Received: by 2002:a17:903:2409:b0:234:8a4a:adac with SMTP id d9443c01a7336-23fb30ab831mr55184355ad.20.1753484821544;
        Fri, 25 Jul 2025 16:07:01 -0700 (PDT)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23fbe585538sm4991545ad.211.2025.07.25.16.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 16:07:01 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>
Cc: Mohamed Khalfella <mkhalfella@purestorage.com>,
	Hannes Reinecke <hare@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Randy Jennings <randyj@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvmet: Remove unnecessary assignment to ret in nvmet_ns_enable()
Date: Fri, 25 Jul 2025 16:06:39 -0700
Message-ID: <20250725230639.2017274-1-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 74d16965d7ac ("nvmet-loop: avoid using mutex in IO hotpath")
moved checking maximum number of namespaces in subsystem from
nvmet_ns_enable() to nvmet_ns_alloc(). The assignment to ret in
nvmet_ns_enable() is no longer needed, remove it.

Fixex: 74d16965d7ac ("nvmet-loop: avoid using mutex in IO hotpath")
Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/target/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index b6247e4afc9c..83f3d2f8ef2d 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -581,8 +581,6 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 	if (ns->enabled)
 		goto out_unlock;
 
-	ret = -EMFILE;
-
 	ret = nvmet_bdev_ns_enable(ns);
 	if (ret == -ENOTBLK)
 		ret = nvmet_file_ns_enable(ns);
-- 
2.49.1



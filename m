Return-Path: <linux-kernel+bounces-590339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A8CA7D1DB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 04:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F00D16D1FA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 02:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14299212B2D;
	Mon,  7 Apr 2025 02:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="q2/ke4be"
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD40379CF
	for <linux-kernel@vger.kernel.org>; Mon,  7 Apr 2025 02:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743991206; cv=none; b=J5NGykohal1t2ZRusDcgs72MRMzNzkHkKCNdhcr/53szJiBQ1ly0WstKYUhkd8bLkobJhTtnADcbcb1Mvz8Srjzt+LuNwNOfHxo28m4aX6F2zwL4zaf9ZCVhARiyIJR79bgPMEROU9dnhWXtG6C5eIQWQTbJb8CdVjaFEiuA72I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743991206; c=relaxed/simple;
	bh=OjW7sirI4IS4Y4QXXv3h7L/5IjMqP5oL4GYrNN7E54g=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=JxFiyOaFN3e6NgR3icU4lTISjX6g2QZw37r28kB0BaNxG76b4JoGVKKLJD1DZ7dhwGscpR2QV/7yJbd0SX2jv/+kEQrGwczX88lFBiXmg3n+3A98jNfWRI9g4C0uxtCndqEknMlPXBSSShFGbkdB86bPUGoIFtWHiEgKSxBFfrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=q2/ke4be; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1743991197;
	bh=f7swzQj4mWofnAn4dFhl+RlwFZfu35Jf3naxv/rGLNY=;
	h=From:To:Cc:Subject:Date;
	b=q2/ke4begHScBpO5rsmUrpilIkdogyAeqOdtO7HaKEls57PYSgBbvSEt+Kl1h2IYq
	 Rb2Vhtht5XAoDoT4MxMwgJR1LCPIMjRryck/NabQLYZIxxSllrvCwl8tz694RouflE
	 /wWCt8GtwU6zoL+KevMptAG/9zBpRSCBy9/CN4bc=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id D5D990F8; Mon, 07 Apr 2025 09:53:29 +0800
X-QQ-mid: xmsmtpt1743990809t2mz9ociz
Message-ID: <tencent_73EEE47E6ECCF538229C9B9E6A0272DA2B05@qq.com>
X-QQ-XMAILINFO: Mr5D3cXX4TfKUtE1b6hYYkV80lehL3QBTce6OMWyPfHikA4/tqOp8n5Dvs2MPJ
	 KtiODWpDc+/zHqNUrZisRy7BzHIc44YYOi+Gv0ISB11X0POiRcH5WfnK/d+eXWbkjhRBs4gYe2I5
	 YuKJgKzw7kffOQEtfj7hg/AgNDYgExiiZpTleagxYZbjKYkOllnK7Qpz4ZMrYpjPqucP9Wk7N407
	 B1Kuxz5Z+WPVtcPneLQKK5P+laF72WOIMoiRNAdWqHmC5ITAlgAcLDVRPEMM5Aoznx0iTNLUFjjp
	 +U5rtR7d8XJpAoQGZ/dz9o+6g33KSWNgqm8reKMUN7KD+ZVFkul5zzwxyHHPnX9c1mj32PNTKhV0
	 1nxk+gD1ZR7ndkxOl9zehfb77C1WKHMoH11zpjXmD3a/gNlYL/vsSQ19ketzweIlWoNhALSTfsHy
	 bwyJEPFIoOoYTvVbvfQk954IbZJYFao04Xe4rajiuDnT1RBvY/GOkAIvqovO4BP4pH1eo6GRVFg+
	 1qkDOKRp8MFj9G8bEm5zULtNeQO0c75ifbnlJK7KiPKONWmTpf074twfvWja5YZ74Eb6jV+2dvga
	 CGbna8hJZiT79Lto+yHeoCGa8zYV777AN81v4UU/5Z4atC8ivYZJOMvcOoYVIKzJnmyfXhX/N/ho
	 HOlJHlZrJw+jsgYXu69tzvnlMpt5ksh5LnCX1CInayzRxJv7qhqnzvGKPeb5xZSBL37+H8d4d6Bf
	 QIGkcrt6b4APgDnIe8YuhQk8CsVBcn5lLGjH4ykGJbY2PsgzsWASAj/iSX8IzfLAooEn3/xMrkDw
	 UYNcZUmzpW6JIU/Uz1L/MS/6aBhpBIGsvx2QMuG2zmeU8FmB+Aw+P/y3dQFrOj5r4+o1S/FJ6sVH
	 0ZQQc2+JH4jY+9UGkYDdeMwcQyyZpYW3qJ/189JPwxZiboAbOVq6JOM2Q9CjP2SGFVAIwi2Sm87d
	 fy1vlqZaWyqGXchA+M6dApCwmh9wF+fK+oc5NSFpUVIjj9dtRExQ==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: xiaopeitux@foxmail.com
To: robin.murphy@arm.com,
	joro@8bytes.org,
	will@kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH] iommu: remove unneeded semicolon
Date: Mon,  7 Apr 2025 09:53:28 +0800
X-OQ-MSGID: <343b725e7fb9361bfcbce8e559acc99f9cfb5e46.1743990747.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pei Xiao <xiaopei01@kylinos.cn>

cocci warnings:
	drivers/iommu/dma-iommu.c:1788:2-3: Unneeded semicolon

so remove unneeded semicolon to fix cocci warnings.

Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/iommu/dma-iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 6054d0ab8023..89fc5a7d033f 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1754,7 +1754,7 @@ static size_t cookie_msi_granule(const struct iommu_domain *domain)
 		return PAGE_SIZE;
 	default:
 		BUG();
-	};
+	}
 }
 
 static struct list_head *cookie_msi_pages(const struct iommu_domain *domain)
@@ -1766,7 +1766,7 @@ static struct list_head *cookie_msi_pages(const struct iommu_domain *domain)
 		return &domain->msi_cookie->msi_page_list;
 	default:
 		BUG();
-	};
+	}
 }
 
 static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
-- 
2.25.1



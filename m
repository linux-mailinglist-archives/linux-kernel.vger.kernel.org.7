Return-Path: <linux-kernel+bounces-729709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BE2B03A9C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 11:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B271C189E963
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 09:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8441223F429;
	Mon, 14 Jul 2025 09:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHYti68u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060F6241114
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 09:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752484592; cv=none; b=URnHNj7CPLQ90+tm2znr8JyylhzebHopry/8I5EqNrytgAcSQwRsJqnjbmf2Y202xXpY790IxQZRSaKv5zblcGfNqz7nKvREiOprFoe3iZCk4kbTkqiYuKkURjSu/ev17IqUbekxEDlgZI/R02p32Jzi+muIHAMdUk3j0Xl/pNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752484592; c=relaxed/simple;
	bh=EHkkGMG990RW999qEL6xHGIOP1Da82Ed2KKxscvok4M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=isWGdn7KbUwiMoiOn3djnuJ3LyGTFSkLsZwHmd0BNK1zCbiN+roXDa8qlYxhPGAHSo1XKZChZK7zEtL3YFqmC3yTu30Qq2oiVXUcEZmZKRzyu+wYjUo3kyC94y4D8BxT9NsZnAX8SlakkUuDrZ2k5r9Lp/YiTGGLdarBCJMMnKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHYti68u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C26FFC4AF0C;
	Mon, 14 Jul 2025 09:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752484591;
	bh=EHkkGMG990RW999qEL6xHGIOP1Da82Ed2KKxscvok4M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dHYti68u5key3zQoDOmqHc1mq5/Ji1JpVzQ3rNOXdksoiB56fb8yC1EVTVun1uPP7
	 LBntUcZvWq8ofUdCL7vz+3mxBJbBHGPzoBuFwQQOdoaPBMMyuBsDMqwxh7WkJ5MBOr
	 rCHT4k4SQTqcz4jv9eSRfO1ma5pJelcKnB7DaBcBN4YW/tSqQfnYcxHGNAU24Ei4xb
	 6RQHb3BEvhWaegwNVCO0u5rBCm//mlCNubqAIa3T1ttwZUEjCItGjS611zyCZpvj4i
	 VUEs1lSBOjqcxsVBRMNjhl/qTbVMpGGumsFiPUXIUcupZcZFsSaDdF9mUaAAzubs8V
	 yxfh3lDgAf0gQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB39BC83F26;
	Mon, 14 Jul 2025 09:16:31 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Mon, 14 Jul 2025 11:15:37 +0200
Subject: [PATCH RFC 6/8] nvme: Add a release ops to cdq file ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-jag-cdq-v1-6-01e027d256d5@kernel.org>
References: <20250714-jag-cdq-v1-0-01e027d256d5@kernel.org>
In-Reply-To: <20250714-jag-cdq-v1-0-01e027d256d5@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Klaus Jensen <k.jensen@samsung.com>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1127;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=EHkkGMG990RW999qEL6xHGIOP1Da82Ed2KKxscvok4M=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGh0yuzCPnoh3XuDoNYYYg9pd/tFQFMVzY5jm
 1hhsoBW+XgbM4kBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJodMrsAAoJELqXzVK3
 lkFPKH0L/0qsA6rA7Qq1k+nKg8zYcsedZJbW9A+9Njb5EJ9ozssyLfDi/X3F7mERgG3L4s06IMM
 lIXAJW6WeOi/bsENRotDv1nJmzZYbHF2zEjNjYnM0WgGbOzxHk1vgAmvd8ZXk61GAqal+gm4MsB
 7CxCoxBnFGCmzkpuOdqJrMM2FGQ8JROLPd0tqkwwbT0G+BvFp6UU8luqhfy9T8BVohqsBriRiRL
 tpUfm7nj9DqOhLMNMUhUbkbWdANEGzhvSioV2Dxtd+JbGMzIH72e4wZAG3Vrf7Pl5X+yP/IFd4d
 fxxHgq1CEQnRJscAFA05rYDaTQjKVgHkfZqNAhAkRtyetX4OU9B+MrcQ/pMze3S5MrrfAsEmc0T
 mT++IqnKhop6Jv88b6GXHvIWzgsPg+SfttxF91MNHrxJEJ9O8AvLuNTxB24lh+vQ5SzLG65cxzN
 ccvbUNGREcQtQXRNn3qGPeKVjA7X49tGvIPT/QcJvCXbDB6WQ6CGllmjtwMKNVsj8EHt2j02x97
 HE=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

When user space calls close on the file descriptor or crashes,
nvme_cdq_fops_release will ensure everything related to the CDQ is
properly released.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 drivers/nvme/host/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 427e482530bdb5c7124d1230f35693ba756ce4d9..4745b961c6b874375ff4399c104f312b5ac608b8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1313,10 +1313,18 @@ static ssize_t nvme_cdq_fops_read(struct file *filep, char __user *buf,
 	return nvme_cdq_traverse(cdq, nbytes, buf);
 }
 
+static int nvme_cdq_fops_release(struct inode *inode, struct file *filep)
+{
+	struct cdq_nvme_queue *cdq = filep->private_data;
+
+	return nvme_cdq_delete(cdq->ctrl, cdq->cdq_id);
+}
+
 static const struct file_operations cdq_fops = {
 	.owner		= THIS_MODULE,
 	.open		= nonseekable_open,
 	.read		= nvme_cdq_fops_read,
+	.release	= nvme_cdq_fops_release,
 };
 
 static int nvme_cdq_fd(struct cdq_nvme_queue *cdq, int *fdno)

-- 
2.47.2




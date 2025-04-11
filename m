Return-Path: <linux-kernel+bounces-599221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E68A850FE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 03:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBF1D1897972
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 01:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF2226FD92;
	Fri, 11 Apr 2025 01:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="BLcxJ+QL"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02E0A94F;
	Fri, 11 Apr 2025 01:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744333752; cv=none; b=ON48YXORDSfRQ8Z6Got9cVqtECATtwos//fR1tAX9ZJprJKJQ1JpmfbJQc7Z+vkgdQXQtQFipvxvbWXA3nRG2w6dLRQKCmZpx0Pm6+bKoGl9rdLjgQQsqAGzMhz6uiWmAUnGMtkoRWSzz+5/HghoUMYbNyihDEploQ4wFXoPtH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744333752; c=relaxed/simple;
	bh=22vA/YQbmT7BvV3qTGOurO5+bRhPG2XZ9z/54rSTIrs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YbmxQ/EWzQ8V4uPQmE5DgW9wCJWRTYXaFfknlSv2iyFYk03t2qG8rsPSptWH9ApTQ5/GIM2uB0qRINwTsyx6oMzghlYERDo0W7H8Qkp14GUqYxRi3jMFH8Dg6iEsHWoYP+lthEi59x07emRot/bkWK+KlqVFzT0aFWm7Cl+xmfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=BLcxJ+QL; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1744333748;
	bh=hnlplJMrlaC0dMDphlz7L6UrksHDLVz2lzXrxKirevo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BLcxJ+QLELrze4REYr90Q/cG0vzVyXSOZ3z4M8SFXbh9M+CsbEEgDjcznKmzeWLAS
	 1EBqwvzDyEehnzXHXtNScVMwfoYTrofIivVW/11368Do8nQo1qW72byMhpb24LIbYb
	 EF1RcSl22u/vuelr9vkXViZv7Ir8QcnvhnP5a03oxtLj8yppk22MJqyeYNehkStU/c
	 FDNWfxoEzJvCqe8SuLjuwkZZJmcosjxH1dH+sBWY0M1h+wsUMb4QPijgoUEpaUlFej
	 /1FAEx5XuTRS/g8RBQ4GbzLbov9LbwWo9kIzM6ONztVJCDN5y/kbFn3jxHWMwCJf92
	 /UyqdHzefeObw==
Received: from [127.0.1.1] (unknown [180.150.112.225])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id B97DA7D70E;
	Fri, 11 Apr 2025 09:09:07 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Fri, 11 Apr 2025 10:38:31 +0930
Subject: [PATCH 1/7] soc: aspeed: lpc-snoop: Cleanup resources in
 stack-order
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-aspeed-lpc-snoop-fixes-v1-1-64f522e3ad6f@codeconstruct.com.au>
References: <20250411-aspeed-lpc-snoop-fixes-v1-0-64f522e3ad6f@codeconstruct.com.au>
In-Reply-To: <20250411-aspeed-lpc-snoop-fixes-v1-0-64f522e3ad6f@codeconstruct.com.au>
To: linux-aspeed@lists.ozlabs.org
Cc: Joel Stanley <joel@jms.id.au>, Henry Martin <bsdhenrymartin@gmail.com>, 
 Jean Delvare <jdelvare@suse.de>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Andrew Geissler <geissonator@yahoo.com>, 
 Ninad Palsule <ninad@linux.ibm.com>, Patrick Venture <venture@google.com>, 
 Robert Lippert <roblip@gmail.com>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2

Free the kfifo after unregistering the miscdev in
aspeed_lpc_disable_snoop() as the kfifo is initialised before the
miscdev in aspeed_lpc_enable_snoop().

Fixes: 3772e5da4454 ("drivers/misc: Aspeed LPC snoop output using misc chardev")
Cc: stable@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 drivers/soc/aspeed/aspeed-lpc-snoop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
index 3e3f178b122615b33e10ff25a0b0fe7b40a0b667..bfa770ec51a889260d11c26e675f3320bf710a54 100644
--- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
+++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
@@ -263,8 +263,8 @@ static void aspeed_lpc_disable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 		return;
 	}
 
-	kfifo_free(&lpc_snoop->chan[channel].fifo);
 	misc_deregister(&lpc_snoop->chan[channel].miscdev);
+	kfifo_free(&lpc_snoop->chan[channel].fifo);
 }
 
 static int aspeed_lpc_snoop_probe(struct platform_device *pdev)

-- 
2.39.5



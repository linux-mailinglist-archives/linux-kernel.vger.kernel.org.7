Return-Path: <linux-kernel+bounces-884742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F66C30F7E
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 13:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A28BC3B5348
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 12:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC4127470;
	Tue,  4 Nov 2025 12:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Cg3UdGHU"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69228184524
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 12:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762258765; cv=none; b=L6iQzwoo7UgdAZz0MyykR6t9rvAPldd2wYC9cjkoxLp/BmCkFzyihKZi2OpE/vsUPdgGBcj+eAM+5nNggttQU4RNrGON/1w2Hly6flwjFGxTm64JYW0aMRLVr+usuvdFlX94YQi2/No3PQAIhO59KqjibtJ1wSgmMstTyhW6KXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762258765; c=relaxed/simple;
	bh=naG61RcBRWHGkldpjX97O4wAXw+SkqPt5MmRjq2jPfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C+ePdPvU7SPUA1zEwQsu49+Ul+vJL87laDJZAg37FS54KJLB/5oANFUcNgwn4VxqMqlhFSID6QAObsoVNezF9jSFvpmbSDflYAbghir2eWWQA015oxjFNNrpR8sc2nf0ZIkuq07X4El/hP1YWbz90iLpdeHArIo/M0LY3CH3SEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Cg3UdGHU; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=/V6JJWWUolx/tanmP6pEZfo9XdhqJ0w8YRiP5WtmcTQ=; b=Cg3UdGHUPGQinAHKGM6eUFk4si
	de2cw2I17yMw6QdX72XdncWCKRWWy0TsRuiG+MaN75SzarekPyMVQqS5auRK8tl3k07lbl1JBxAKI
	iRJJGz07v1d6te/3sMgnx/rznuDF5Hu2mVGZhUTdgr2nvkvUGpRrueUzOWmN7VVtl26hE1bhT6FNO
	QaRD16EdbvEBT5YTWh5ce5We6HhFzhGT8WydS/OVDk4SiTuxjq42UTNfXZh0+nFmycwk+or/2TFCu
	YECtWt1HYynXF7JLVHoWKTN1gikpRqj7+4jCVGyOFotJmVayAztpcwJyYaQP0/aur4VmDUAFJwVQW
	u7avPo5Q==;
Received: from [207.253.13.66] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGG0Q-0000000BmMm-1R06;
	Tue, 04 Nov 2025 12:19:22 +0000
From: Christoph Hellwig <hch@lst.de>
To: akpm@linux-foundation.org
Cc: lance.yang@linux.dev,
	mhiramat@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/hung_task: unexport sysctl_hung_task_timeout_secs
Date: Tue,  4 Nov 2025 07:19:20 -0500
Message-ID: <20251104121920.2430568-1-hch@lst.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

This was added by the bcachefs pull requests despite various
objections, and with bcachefs removed is now unused.

This reverts commit 5c3273ec3c6af356b29ff50a654f0dc33bf25a83.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/hung_task.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index b2c1f14b8129..1dfb9bc1bdef 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -50,7 +50,6 @@ static unsigned long __read_mostly sysctl_hung_task_detect_count;
  * Zero means infinite timeout - no checking done:
  */
 unsigned long __read_mostly sysctl_hung_task_timeout_secs = CONFIG_DEFAULT_HUNG_TASK_TIMEOUT;
-EXPORT_SYMBOL_GPL(sysctl_hung_task_timeout_secs);
 
 /*
  * Zero (default value) means use sysctl_hung_task_timeout_secs:
-- 
2.47.3



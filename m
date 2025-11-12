Return-Path: <linux-kernel+bounces-897802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 152EBC539DA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 35BFD3441A9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA73E343D86;
	Wed, 12 Nov 2025 17:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AT5U8QoU"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFB5199939
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 17:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762967686; cv=none; b=eVt70s1O9+RKyc2ABuHxl1qJmGy3wUMRx5sjFNU68qPZvIdF5hBGl/pSmqugaqZfgdkCuIiFy6SCp39JNdtuillo9ldEsiD97pwxgXEcgYb7E5budAMu6HuU2HaFaMZhoPYqmxDPj2w8RvzMuB5/1JABMIahy1W2so8o5tEpQbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762967686; c=relaxed/simple;
	bh=8l7DJPQX8maKkP3m/CpGd7Mw+yaaSMjfecqsPHISZY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V8b6GAop9XnqXBb9JrDHxXFrsekgfu4c6nmYyYGqUo8a4IM373Gh47RRC3d66hQ+Wtg5xDUNme2tuV6XVhyaLoWwyIU25LYLPO5idNuoMJd3u+eryaRWtYehi5WVKFshXgBu721dPYQMDr4wURJ0GjiamMiVCZmzdeS3NowM2Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AT5U8QoU; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762967681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZPcbU/HjyHzjDNdh8oZgw6FUm0OlxveuLUPT+TNJvls=;
	b=AT5U8QoU/4yVoI0kNxptJ2hvBfaaRXmzvm4o1oLcdkbjEWJmjVDR035GudP1Mt1XUGnOAU
	lfgMaWLQZWfiGWcCbAdJG0dRjyBPB9iZg+x6fbNrak6zJ9d14d3hh3FHICf1UGayxq4hLc
	aIiutbYgxmtzKZZ1giBVzcTShRrINrk=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Jason Andryuk <jason.andryuk@amd.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Thorsten Blum <thorsten.blum@linux.dev>
Cc: xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] drivers/xen/xenbus: Simplify return statement in join()
Date: Wed, 12 Nov 2025 18:14:07 +0100
Message-ID: <20251112171410.3140-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Don't unnecessarily negate 'buffer' and simplify the return statement.

Reviewed-by: Jason Andryuk <jason.andryuk@amd.com>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/xen/xenbus/xenbus_xs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/xenbus/xenbus_xs.c b/drivers/xen/xenbus/xenbus_xs.c
index 528682bf0c7f..7c6c12925326 100644
--- a/drivers/xen/xenbus/xenbus_xs.c
+++ b/drivers/xen/xenbus/xenbus_xs.c
@@ -407,7 +407,7 @@ static char *join(const char *dir, const char *name)
 		buffer = kasprintf(GFP_NOIO | __GFP_HIGH, "%s", dir);
 	else
 		buffer = kasprintf(GFP_NOIO | __GFP_HIGH, "%s/%s", dir, name);
-	return (!buffer) ? ERR_PTR(-ENOMEM) : buffer;
+	return buffer ?: ERR_PTR(-ENOMEM);
 }
 
 static char **split(char *strings, unsigned int len, unsigned int *num)
-- 
2.51.1



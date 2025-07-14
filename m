Return-Path: <linux-kernel+bounces-730482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DD8B04543
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 18:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63FDF164722
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A398A25F997;
	Mon, 14 Jul 2025 16:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B+mEE0QF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9360C2E36F0
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 16:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752509850; cv=none; b=YTIR+wrT5wHn+bROkjurXki7HulJ7uPIAqA2fy99kOFAjg1yFkb4/pn4ryu/xvddIyDzVjkdFr/0ABNU/8skhtQID7LiDX6Pl+n+pJQjjQh9dRTFudk4kIBZTYAJArnJsPVDWBZF5ldf3prw3Xnt+Gn0cKQEjYGJ2yatYzgt9a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752509850; c=relaxed/simple;
	bh=vg4Oh6MH+0fma2aCD4vkfmcRFiED09zblF5ZveyabYw=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=kAZmq36ypt+wSLYpoA3TfkJYlbAgrc6wgD/7fV38RtGwBtx1WaITQQZYt0HITn4hKtxnvTwhPB5Tx8ZSI1DS/nQKPoSHcevOaGXz5Q8PcY+hn3UGB3UgTyHwu2Bx6NZ9g+89wP19+sB0RT873n3Shrs1fUp+wrA6JZHf+SmU/Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B+mEE0QF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752509847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=IdkWORgQRX/v02euiHEounqm5FwbRCKcrBeNyY/I87o=;
	b=B+mEE0QF509YEDJXuEVv/xvSyntn8CY2hmlN0QGje+SgitWfgenvS1gU6Mz/P+YF5v4Tzh
	mRaIiRt0UvwtAkcN/0a9OibnTwZZrmO5hf+ELkQPYPhkP8FK1S7bTNta+/sZhEWk+N2oYU
	m5dQcqI2zoMDZClc7yWTfBRqlgsjbWA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-8--4Jk8XLIMU61Sn2Uz2NOeg-1; Mon,
 14 Jul 2025 12:17:22 -0400
X-MC-Unique: -4Jk8XLIMU61Sn2Uz2NOeg-1
X-Mimecast-MFC-AGG-ID: -4Jk8XLIMU61Sn2Uz2NOeg_1752509840
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3A4151809C9D;
	Mon, 14 Jul 2025 16:17:20 +0000 (UTC)
Received: from [10.22.80.10] (unknown [10.22.80.10])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5CFB719560A3;
	Mon, 14 Jul 2025 16:17:18 +0000 (UTC)
Date: Mon, 14 Jul 2025 18:17:15 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    Guanghui Feng <guanghuifeng@linux.alibaba.com>
cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH] tty: omit need_resched() before cond_resched()
Message-ID: <5a11ad09-5508-933c-f044-6a236bf00557@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

There's no need to call need_resched() because cond_resched() will do
nothing if need_resched() returns false.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 drivers/tty/tty_buffer.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: linux-2.6/drivers/tty/tty_buffer.c
===================================================================
--- linux-2.6.orig/drivers/tty/tty_buffer.c	2024-03-30 20:07:03.000000000 +0100
+++ linux-2.6/drivers/tty/tty_buffer.c	2025-07-14 18:06:00.000000000 +0200
@@ -499,8 +499,7 @@ static void flush_to_ldisc(struct work_s
 		if (!rcvd)
 			break;
 
-		if (need_resched())
-			cond_resched();
+		cond_resched();
 	}
 
 	mutex_unlock(&buf->lock);



Return-Path: <linux-kernel+bounces-817383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D52B58185
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C877C20473C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E822526E6FB;
	Mon, 15 Sep 2025 16:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gsB9wMXK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C410242D62
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 16:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757952218; cv=none; b=igUUDmHWhk76dUtT41V69fjG2NKn8D3NbzK4KXhKFAAdGzr2sGV0Bzw1iy6gi2mNO3bLT1ScaZT/CSn/NivR9xa84g00a2tJJuaIn0HjpCLuNb93OR/9pp4W633T1e2oftrhblwNiMKSiBXKTSn1VI2mMVx05/sheG5uGueyn8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757952218; c=relaxed/simple;
	bh=lz+21+pXWAdvl2nNDlkXW3ZFI2U/V3++gCtr1F/cu+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LtvO/ilqxMjYJaPApfF/MdV4Qx6AXcxRHdnmulSQyyhlFqS6EEd5bCTOaDsioNX4d4rQ2fXZ5tAgKuu10mS9lRj7KPerjFQLgxWmRAi5ZtGFAKScAUQ7h/zopWGIN+3ynNzmdpP9FTF9JN6OJ5Jz9jY5T7tFzevltcjoK6ijdJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gsB9wMXK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757952214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zyjSpWLvfqnwtpmHwJJOxa1B89j7LM2tZ53OHGLbRxs=;
	b=gsB9wMXK+0ghL3q7a/L5hYCT42ZoFaw016gabU6JxZMqPN4g/bZL0KvgGkQ+hr+g4s0Y7N
	uD69kk6iFdWwGesLC2YWzzeV1yRJ7CQ3uJJ2dzgMgJ0UGHexCoE8bBOnaGNILo7popICzv
	Av0mngneEKamVoZROGDHWRIk+J7gi+Q=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-R-pCV6EHOJGTRs0blYzTgw-1; Mon, 15 Sep 2025 12:03:32 -0400
X-MC-Unique: R-pCV6EHOJGTRs0blYzTgw-1
X-Mimecast-MFC-AGG-ID: R-pCV6EHOJGTRs0blYzTgw_1757952211
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-afcb72a8816so328125066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 09:03:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757952211; x=1758557011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zyjSpWLvfqnwtpmHwJJOxa1B89j7LM2tZ53OHGLbRxs=;
        b=C/LQP1E1SqQ8ghwmJ30fJ0m6OGSO127IHHFtid5KAqsPo1LTBb+57d6A1n68k5frxq
         r+w2y776kam/qAu7JNu7bs1XHVCW0jQgHAzVlD1QcZO38RxOx4rhuNcVt/0sFRJyknu+
         yumld086mSxEGkhFDP7QWBq/fxVQ8Vv0vzu79AT2tQFe60nNdDhMYwhUK9gLvkYZXzSe
         W6Gt2lsxZ4uyhKAcDq2ofZ/C9aZFJ+PhaA8J+vkD4GqZlQKOF09/Nhre+/ntBB7P/YD8
         DeivhHpzgx7gjwBau9KniTb/OYX8qm10MiviKcZcu7uDUsk/eBqx7X7s+BT26a30J/w+
         qaVQ==
X-Gm-Message-State: AOJu0YxrciFEdKJ/qnap/5hDQCaTyRVGDhZ/4PIMwVAb0qgbEqkDlsTX
	Nx7KmBRC+ycCKnSWmRzM2XI3lxNwrO/2kvOJmr4PbsnX60b0eyt/e60+RzzpFAQZmKbiBzq9oeN
	pue32UPMyXC1KhAMTf4l9UrZK5b7Ghfj1C6/x8WYwYJ0pOM7Ny50CYj9g4wb7ld9JSqw+xWG9Ml
	H4kuXXDzQvuaXK980tUjogrntKE7qPqjobcz1apOaSWbk=
X-Gm-Gg: ASbGncv58GtSbfnRZBiXYkvcFXM+LR5Tlmb462PWwU/MWrPpCI7iXLEpghoCQ+inr9H
	cu7KSNCl2Er2tEXhxiK4hNxBFS3+JIZu5gTeZCUTf6h5xjCc7dsuqhkOb3AkaTEi6zwPg6zX1Iv
	8OSPG7VcIw7wjJ26xmhir6vAiPiOeI4ryo4JbM/OJkElLF79ciKFa+yqoVTjzRAhu1foIk5i8Ny
	jed3eih2vJ7tKptIBOvCD0v61iIHt9i4umQN9HVIq2Gbklv4OsPGGJOghc6120arUGPOk7b/qyD
	TJzMKLPcVJ73MOH5vKHgG8G0l7Xg
X-Received: by 2002:a17:907:d16:b0:b04:3402:3940 with SMTP id a640c23a62f3a-b07c35d4d02mr1305643566b.27.1757952211138;
        Mon, 15 Sep 2025 09:03:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNtSBH6QlKSIfQdtkhP6WbRqJLxZsgUpRv3jEYGQSqAMd7B74yXmlLS/60ot7X5iMC+KioIg==
X-Received: by 2002:a17:907:d16:b0:b04:3402:3940 with SMTP id a640c23a62f3a-b07c35d4d02mr1305636166b.27.1757952210298;
        Mon, 15 Sep 2025 09:03:30 -0700 (PDT)
Received: from redhat.com ([31.187.78.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32dd413sm988048866b.71.2025.09.15.09.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 09:03:29 -0700 (PDT)
Date: Mon, 15 Sep 2025 12:03:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>, netdev@vger.kernel.org,
	stable@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH v3 3/3] vhost-net: flush batched before enabling notifications
Message-ID: <7b0c9cf7c81e39a59897b3a76d159aa0580b2baa.1757952021.git.mst@redhat.com>
References: <b93d3101a6c78f17a19bb0f883d72b30f66d1b54.1757952021.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b93d3101a6c78f17a19bb0f883d72b30f66d1b54.1757952021.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

Commit 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after
sendmsg") tries to defer the notification enabling by moving the logic
out of the loop after the vhost_tx_batch() when nothing new is spotted.
This caused unexpected side effects as the new logic is reused for
several other error conditions.

A previous patch reverted 8c2e6b26ffe2. Now, bring the performance
back up by flushing batched buffers before enabling notifications.

Link: https://lore.kernel.org/all/20250915024703.2206-2-jasowang@redhat.com
Reported-by: Jon Kohler <jon@nutanix.com>
Cc: stable@vger.kernel.org
Fixes: 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after sendmsg")
Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/net.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 57efd5c55f89..72ecb8691275 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -782,11 +782,18 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
 		if (head == vq->num) {
 			if (unlikely(busyloop_intr)) {
 				vhost_poll_queue(&vq->poll);
-			} else if (unlikely(vhost_enable_notify(&net->dev,
-								vq))) {
-				vhost_disable_notify(&net->dev, vq);
-				continue;
-			}
+			} else {
+				/* Flush batched packets before enabling
+				 * virtqueue notifications to reduce
+				 * unnecessary virtqueue kicks.
+				 */
+				vhost_tx_batch(net, nvq, sock, &msg);
+
+				if (unlikely(vhost_enable_notify(&net->dev,
+								 vq))) {
+					vhost_disable_notify(&net->dev, vq);
+					continue;
+				}
 			break;
 		}
 
-- 
MST



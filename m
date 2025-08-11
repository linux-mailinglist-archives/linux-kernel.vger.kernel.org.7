Return-Path: <linux-kernel+bounces-761817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9F3B1FEC9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E5C8172E1D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 05:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5C626FDA3;
	Mon, 11 Aug 2025 05:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Hu/xsv1l"
Received: from mail-il1-f225.google.com (mail-il1-f225.google.com [209.85.166.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3394265CCB
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 05:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754891434; cv=none; b=JyBqBWf8nF6elBHz7LXPP12SYALpnwwl+qTrSzvS69gPDGaKqNp1MYVJtnOMOibS6gmibAhKaz9Ym1AAG7Rt51FOhptxZocVplvGldcj+pu5Oc9zFZzCXCMiXkmRazDYe/h1o2VdZguHbyQBZhppl22tfg7anSjCSHLhkAqKJ/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754891434; c=relaxed/simple;
	bh=0yp2V2VVk7SzKuFUi/ZVfl/o+NZ050J3YB1CuCwPaGM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WzRUj1ZI0cUVjObqYTsRV0oAu3w9T6j9mEu7WW+PQKCPrGB7VBMBQFjWmtiPmTziZeWbXmZTBRmGa/rjmaXuJi/DnCBrXNNU710vrKTnb+gzDPAxRGI4fix3Ea5q69HyRmQta26RZdCY54fZEFwTxmd3QFXFB0+8CWwXIspatlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Hu/xsv1l; arc=none smtp.client-ip=209.85.166.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f225.google.com with SMTP id e9e14a558f8ab-3e513686d5fso8929675ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 22:50:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754891432; x=1755496232;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9FGXD3kaHwd6Vj5dcpPpaYy6WT0iTxp+nQotnuFSJvo=;
        b=TV3GjYv9FWrNEbyn/7ODIpAPpmlv0Od0/TAKnn97LLZIg9K1s9rmwz1kdsYX0EIvvj
         8sbbrioIIegWurxj1LYxOxIFWOBQkfhpaPo/cvs0TAUXn/N1LNl0RpczcZkPIcFSgjZ7
         ij7p+KHFCmH3sF330WOqbGlpg+iHucPP8GkKEPg+CVvVHyS5H4bSKc4ddmuu7Wff5Uxs
         VfMwzgOypOP5BHR9P4SVFF/9Ksh7IeTk9a9bfpSti0Pmj/1YitYr20w6O7DUiByoFp0J
         H2df5pC2QU48R/Ss0ExVJC1pjUmM1BTjU3UE2cIxhWVWS/EiAqUtBgtsXw+h1suMwS+c
         9TXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPAlOIlWVtuCssSAqUjfSazAxNKNawGw4iq+2sNSR3ojLWOrqvjRDQtvhSadMBSD76X2cxxD7g6piojGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe+2UtGSwagK2miirk2NylJWmGbZWkQ8EPqU+rZ4sENM/DJjaH
	a52RTkGjpNZSGYY1rNphuUoULqslXzAmu+djiLY3U79mFsrMkdNt7AcRNA7LFNFJotl6F027qnt
	H/nEAqgMdzoLaB3PrGG4+N8e6KMQsZ/H2D4ouX7nj0i+ax8EHgmZwNxQyMFh4D8pbdt8dU+ZoL7
	5Ln7tUwDF+sw57cwtA4trK087izV+vW0QA2HmmvK9aJuAkcWEyHqkq0153Hfs3hZ9Ky+2XRvM4Y
	zn2Ln1LvrYQVtusUcMl9dr85A==
X-Gm-Gg: ASbGncunqWEOj7f6WhSuMg1YFM37Te3NEHRSycv1DY0kP/iKyZuIOPgSDGLhpVLYavU
	4faeX3xd/FRLSOenLhyw0LzZCasI48vAJvHbt1zToke6ifXEnPWyA4DKavaFANkd5Reap4ZiXSd
	QwUQqQKSCEkC2T6CG7XI95otDCJYv/zTYypddaBG8XuxpOehtNLlsgnd0ruyLsDRGQmNusrG44l
	9OjeEQvGjSh6AKPWiD2hm5nhDGfFFdbDOivw0n1fGCuxMzL8OOwiRiwo6QmyKW1aLYzZ6rHOwX6
	+slLX9iF9ILbcoUWPtiQCjwhLCgv4VCG2qqYwzcwPfiGOePED1gQx1hBlwHS0hFBmhH/tF//OiB
	WcMUmcY9Aut3/aYkAvyOGN7PpisLTOVqdFs4Bd3mg/CoumQ6Bi5d7JSHHFtChDI8r+GmQms6BYc
	d9nJ+PpQ==
X-Google-Smtp-Source: AGHT+IG1n3A07NSP+rcvxyZ0cWjpZxPGlXqhcnHRCZEwB+IYIFtvOK3iSr81/9vnyQ6oVPt++ONrS/tYa07A
X-Received: by 2002:a05:6e02:b4f:b0:3e5:42ec:1364 with SMTP id e9e14a558f8ab-3e542ec1a9amr107234055ab.1.1754891431850;
        Sun, 10 Aug 2025 22:50:31 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-119.dlp.protect.broadcom.com. [144.49.247.119])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3e533cdca6asm6049255ab.53.2025.08.10.22.50.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Aug 2025 22:50:31 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e7ffe84278so851737785a.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 22:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1754891431; x=1755496231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9FGXD3kaHwd6Vj5dcpPpaYy6WT0iTxp+nQotnuFSJvo=;
        b=Hu/xsv1lHeaKP0Y/TICX/h21gFB3AHPyTXa/2a552THojLnYaoyz5O+I5zAsAv2t2o
         zVi3EyAIpAUlbDL5vKFhi+TTJUMn69EfwKawAA1UCdSbK8BMrbF0ZN/YgTPQ6UW+DjOW
         6lB2nS1uOufa45S2URM/BECqZRg3ARWqIG9WQ=
X-Forwarded-Encrypted: i=1; AJvYcCWFlNF7hbAA1JEvhhhTzRjbxGB9ceczAhxhEW2IdCGGMnv63lfIdcFxYHkJe/IAG5ORD7Vv5a5rcl+S6KA=@vger.kernel.org
X-Received: by 2002:a05:620a:5783:b0:7e8:1718:daf6 with SMTP id af79cd13be357-7e82c6840b7mr1332717285a.15.1754891430879;
        Sun, 10 Aug 2025 22:50:30 -0700 (PDT)
X-Received: by 2002:a05:620a:5783:b0:7e8:1718:daf6 with SMTP id af79cd13be357-7e82c6840b7mr1332714785a.15.1754891430374;
        Sun, 10 Aug 2025 22:50:30 -0700 (PDT)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e8050b6101sm1021477285a.26.2025.08.10.22.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 22:50:29 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	tapas.kundu@broadcom.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	stephen@networkplumber.org,
	linux-hyperv@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH] uio_hv_generic: Fix another memory leak in error handling  paths
Date: Sun, 10 Aug 2025 22:37:08 -0700
Message-Id: <20250811053708.145381-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

commit 0b0226be3a52dadd965644bc52a807961c2c26df upstream.

Memory allocated by 'vmbus_alloc_ring()' at the beginning of the probe
function is never freed in the error handling path.

Add the missing 'vmbus_free_ring()' call.

Note that it is already freed in the .remove function.

Fixes: cdfa835c6e5e ("uio_hv_generic: defer opening vmbus until first use")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Link: https://lore.kernel.org/r/0d86027b8eeed8e6360bc3d52bcdb328ff9bdca1.1620544055.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[Shivani: Modified to apply on 5.10.y]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 drivers/uio/uio_hv_generic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index 6625d340f..865a5b289 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -306,7 +306,7 @@ hv_uio_probe(struct hv_device *dev,
 	pdata->recv_buf = vzalloc(RECV_BUFFER_SIZE);
 	if (pdata->recv_buf == NULL) {
 		ret = -ENOMEM;
-		goto fail_close;
+		goto fail_free_ring;
 	}

 	ret = vmbus_establish_gpadl(channel, pdata->recv_buf,
@@ -366,6 +366,8 @@ hv_uio_probe(struct hv_device *dev,

 fail_close:
 	hv_uio_cleanup(dev, pdata);
+fail_free_ring:
+	vmbus_free_ring(dev->channel);

 	return ret;
 }


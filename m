Return-Path: <linux-kernel+bounces-761820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0963CB1FECF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B94E18920A1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 05:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC4A26FDA9;
	Mon, 11 Aug 2025 05:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HagoNJBb"
Received: from mail-yb1-f225.google.com (mail-yb1-f225.google.com [209.85.219.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26871F4628
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 05:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754891494; cv=none; b=RhrIVVSQBvhVtqN1N01oCE224VTsHcFnhWPqHOwJefmYjTIl6y/QdK9wqLc35FPqI3aHGVBZBfbSTTG7vBfNsgPPv939O61eL7/NFhBUArOIpvPhMOTjJVXj3UqTt3C+FEqHqMetFV5FnYQ01/o6QYwHrZLezK8IrI0lfE/ZQD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754891494; c=relaxed/simple;
	bh=0yp2V2VVk7SzKuFUi/ZVfl/o+NZ050J3YB1CuCwPaGM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kGN6am/KZSEuXzR5tytClsnyqFAkUOkHHHXP1CREXiVWwgPSzCr+78fyRxRvc7aR06eLRb6BXsUtQP3jF3JSgyUiFchESFWAW89vRGO1/3UGCngQ7ikWrhOyRKrgZknjV7Mo77YavLQKGyN7GIo64aTVWoeaYlLZc5In0gV4dFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HagoNJBb; arc=none smtp.client-ip=209.85.219.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f225.google.com with SMTP id 3f1490d57ef6-e7311e66a8eso3548998276.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 22:51:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754891492; x=1755496292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9FGXD3kaHwd6Vj5dcpPpaYy6WT0iTxp+nQotnuFSJvo=;
        b=mIsd+2S2vBjdz7cSHE1to2BcavSEFM0G6uH3s5NffZ0qnl4BzYKWZnhLCIoLt1dnat
         o1d+qRCRt04WVWqWbzkhL6meM+O2Ig5qhjqyMX07uqijxSgr3/8+sabfGpy1IhBCYaM1
         atl0sWWHKqNFEn6YMQl3m7CAwSXICTVIkM2+Bo/1TE+JxSKltVOkm+SNSlAV5QJvJf/I
         Ncm6c2/VXYmUJcQ+G9CtLOvtkDrPesWM8lxzFeGvK2i+0qXPeMCaquJdS/nsp7O7j5oN
         HDms5S9Eyzu3jBY3DgZXLjBgao3J2fVBaLyn0k0uHARL9gFF2tNM1srtoBqjxF68GgkN
         s+Gw==
X-Forwarded-Encrypted: i=1; AJvYcCWdwZBVUmTmJpOdi7+ABVIoVweVl4vtCFC8quppOajZeVz+U/czsaZGG/SfPmCqc2BC2vJlHc4c8c7wAio=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7n3Tpf+W/rX9xcEz3kkw/eOWvisV4ICTpAvfcN6Z57nRVaFUU
	LDG2z3XdtX4XgScV51/k9EdZbC6yual2JuEjh4+S2G+UaZnMwuEVpBylRiPT95dHMHorntg289+
	+4BI9ZJUB45yO8CazmPtthLpcH5fLtYVxk26CCxc3Iltsd7odfnaiSBM5v8UrgD6OyVzDDcPUXi
	7vA0IZ5PIcfCRBxHPc0JHH5K0uqyDHRQRDdIVjq1pX+ipZQJzHIbubvt9mPvtWknM7Rb7ux18vG
	gQlRfY16BIKfwp2Z3/6/m9dVA==
X-Gm-Gg: ASbGncuKACHa0ztG6iHGdOwTa4iwKscRKBJqth06YgrDxbsnijEmzIe9qNXDKPgVIGl
	dmLQjzUWjO1j7791NLzRxYqUwv9lh3zT1Rk8ffCQi2in/Ap2C1KmdFuCYrfNhshnEk/OjV7DcTK
	VmdmTCUYnKo0+b8tMyPpN+cns2pkBaizrGzk8fZqyrJDakeDS3A0bJnktZvLu0twtfGFICh1YxR
	jPMD3JKoK7ema03cgVI0H7GfVJrvD8+/Cb1DvURRuZDX8C/ul+e3GxEjoMWTj3X5ETW+DSMKTVz
	1YdrvDx6yRkasos5EKK3CzUJBNzb50weNd6YeKC+U2lZdHdZZrD9OnerTDEefIBk4t3fDrC2GSG
	itPeB9KGXbS7ZvURsE3vz3iTAvGXFSjtBpjvlLmIZJODQvk/VLJtejpD7P7sSqxR47relxnyl09
	JyHaw=
X-Google-Smtp-Source: AGHT+IE3j0FUSXUEAcHz9v35wX8bmstuqwiv6hJ7Fkp+0nQp8b58Hy6dUnq1ziZf+xdimxk4aKAS1TNsM2Uc
X-Received: by 2002:a05:690c:8695:20b0:71c:1142:f9ba with SMTP id 00721157ae682-71c11431bfdmr46886757b3.4.1754891491600;
        Sun, 10 Aug 2025 22:51:31 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-71c00ff5b8dsm2811267b3.0.2025.08.10.22.51.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Aug 2025 22:51:31 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-7073a5f61a6so76784886d6.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 22:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1754891491; x=1755496291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9FGXD3kaHwd6Vj5dcpPpaYy6WT0iTxp+nQotnuFSJvo=;
        b=HagoNJBbvs8WLIpLTExqvMa5PlAM3qXlrJWy6cq0p7jdveH0Jmk+/H+B7XHZ+y7nx8
         /Fp0ti8epILIQgjZGX4WGgJ+pwRksrsuUpJbCJmNc0LYsRPP6jGhpgGwoTOJzzoH5aOY
         IGKoE/Cs/J7G5FGHJKsXelDTXPeVcP9hWWlXc=
X-Forwarded-Encrypted: i=1; AJvYcCVl8uX6n/KUM/WODhX5YIST+IcmdmPBcNPs1eotlMDTnCD73nNwxOV5zHIL264iEMJlQUeDkMoiR1aFzso=@vger.kernel.org
X-Received: by 2002:a05:6214:c83:b0:707:bba:40d4 with SMTP id 6a1803df08f44-7099a1b9ccfmr151427606d6.11.1754891490838;
        Sun, 10 Aug 2025 22:51:30 -0700 (PDT)
X-Received: by 2002:a05:6214:c83:b0:707:bba:40d4 with SMTP id 6a1803df08f44-7099a1b9ccfmr151427376d6.11.1754891490332;
        Sun, 10 Aug 2025 22:51:30 -0700 (PDT)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077c9d6d6csm150672406d6.4.2025.08.10.22.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 22:51:29 -0700 (PDT)
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
Subject: [PATCH v5.10] uio_hv_generic: Fix another memory leak in error handling  paths
Date: Sun, 10 Aug 2025 22:38:08 -0700
Message-Id: <20250811053808.145482-1-shivani.agarwal@broadcom.com>
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


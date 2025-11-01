Return-Path: <linux-kernel+bounces-881134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E52BDC2789E
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 06:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8BC9E4E11DD
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 05:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAA628726E;
	Sat,  1 Nov 2025 05:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqoSwLs2"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B338B286887
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 05:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761975878; cv=none; b=ex82uOyyJIx4gNn6Au3YZqIuqjE7c1bNV736cZI1Ik0XjZM37RLQ4fB/ZgT9ocV8c8GWmt/5TeJ2he/sYgj6P3Clfvyxe6mGpZEK+jpD63VXCM55R/ZuzulIq/hNOm5w/BEGRmd7mTKFgfLlq6rA9lXaJJ4YCUSIdjW9e+urocs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761975878; c=relaxed/simple;
	bh=QoAanW8uPcUmodqCBbkdSS+W6EcjbWm0OuMo8lhfn4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HoREBiSQ6hsTEKVR3tAqhJPIUvS1eGxeJaZFGf7ONgaXdyBKrvUkUv3r0jH1aU/kUx2J0dXvDo4UaU0RndnKTIVkFElQ1SPq21pSjBa1g1oIVWN050fWbKWlPgOSnKkCrsP55uXZab62Bmqind28UKnimHz8kCsKmgoGse8DEKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kqoSwLs2; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-78125ed4052so4116635b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 22:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761975876; x=1762580676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hXfrEv5oiBHpW6muXJlmwbpRlo7zdmnpcibEEEHdvoI=;
        b=kqoSwLs2BHY6phzuu3KFVnu/bH4e6cl5I9EHme7FbXoriQIe/GinEuuk89cR0Pzczf
         76As40o15YGikZwen5C6bVQX3cPlsx/prXgAaSxhT3MXpuX0l5NqFW7ajWzeHAvtEjn/
         p7O8T9ogLKfrLqkwcVeq6fd5iGPZtZxiTseyIrSUv6wtqdfUydQ29o9rgyEX59FGrNcA
         rQ6fTPpboB1X3es8Yi+xnNuM+re9U7Jkk8pzYLdT92yeAN093poHtIg74GHuhiTRShkY
         jBuT0pydkQ3JfSgqqVRCySsH0oxPjkiSBulrjj2krurD17swTqdW4+LlYJEKZWzWsRrA
         zKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761975876; x=1762580676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hXfrEv5oiBHpW6muXJlmwbpRlo7zdmnpcibEEEHdvoI=;
        b=XeASAcKyyIDqvAbVjKB5rtcLDY99nIJp8gkj7sF2lb0mBl70FM3Q69kNecsIgs246L
         NaupsUxSvHJfTY+/K+gFp2Q/+zFpi5zj4mQMI4v/+OWvNB1GSPlvyhCPFjSRJlc1GQAf
         WbD2lGVb71zT6uBlzBEDBUWybXZdurk5e5jO0H7pt4JIXaA3ahLAOHtvkqXviwf5bE7a
         sCs4FNp5k6o31D5HV5b7f/cMtRcXFmCkPngglnHOEDn8O+OBVLx3EHJCTQwfJBSAv10y
         dc34z55whAxjVEcY7SeaHYRR1blOrWUfv74j279Uba6Z8iC1Zcb+w3vrRc5OnPoYN26w
         Sx/w==
X-Forwarded-Encrypted: i=1; AJvYcCUYnDOT7fnEVygvY7mNvTNmmGk7gqYiTqDVb8JVmXse03xnvgXmvncCpqfDugTNpPr3dlPA2oAF9RY2pPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqJM1NmK3DUFVaysFdgG/xEHDQPR4TWehrEOV/7IqT8n2zi/nf
	Sn60bdbqWk871wAME4Yu1/eo7b4qeYl4meUbqONROcF94UFRzSZzjwv7Nxsv05oX
X-Gm-Gg: ASbGncv1/aZl5X9fvqvFt0/se2yE9pdQynDT8vX3Vg8R4Zf4A6glMgUFyCUcfcycUqN
	ULU+wUp0BkFRvRlcYBorVIhdMi8qBBPquEyItgX90vV9i6TavZD9eFqIcbGbd5NDXJ6afySgSKz
	ffXSC1zs0zCsCAOb5MjOQ6M7rZdb4jy6Z/FEMJ6FY0WoGJ8L6XCFzpcWXBaN0MfgqKB80tCrK0h
	0waWH9z8dg8pogMIbzY2ykE6xa8uTT9rx2DIqOZ4cOuqRKvDKsvzy6lAKFmjJwpl5wVZHWjmXjc
	bEmabfnVjgdjDE602C5YEozz8KA3KTGgKBJrOfPug2tHR9zRQfFJZEf0pVL1agLaFSLNrT6m6N7
	jC8liWqU5+6FIIZLACvYyYatq6LgqIYTpIhv5NDaoBZr50aX7zOqeq3gUeecX311Xj0VCLTVS
X-Google-Smtp-Source: AGHT+IEGJ4mGhF1h11nXlNMyKOMIlTHFuQycoD3FINV1TwEi5cyxUm493MSp+VBY0wey3CeA3mtjJQ==
X-Received: by 2002:a05:6a20:3d86:b0:334:8ac9:bc5 with SMTP id adf61e73a8af0-348cc8e5729mr8648568637.36.1761975875916;
        Fri, 31 Oct 2025 22:44:35 -0700 (PDT)
Received: from fedora ([38.137.53.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7d897e86fsm4067572b3a.11.2025.10.31.22.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 22:44:35 -0700 (PDT)
From: Shi Hao <i.shihao.999@gmail.com>
To: philipp.reisner@linbit.com
Cc: lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com,
	axboe@kernel.dk,
	drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	i.shihao.999@gmail.com
Subject: [PATCH] drbd: replace kmap() with kmap_local_page() in receiver path
Date: Sat,  1 Nov 2025 11:14:22 +0530
Message-ID: <20251101054422.17045-1-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use kmap_local_page() instead of kmap() to avoid
CPU contention.

kmap() uses a global set of mapping slots that can cause contention
between multiple CPUs, while kmap_local_page() uses per-CPU slots
eliminating this contention. It also ensures non-sleeping operation
and provides better cache locality.

Convert kmap() to kmap_local_page() as it aligns with ongoing
kernel efforts to modernize kmap() usage for better multi-core
scalability.

Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
---
 drivers/block/drbd/drbd_receiver.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index caaf2781136d..14821420ea50 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1736,13 +1736,13 @@ read_in_block(struct drbd_peer_device *peer_device, u64 id, sector_t sector,
 	page = peer_req->pages;
 	page_chain_for_each(page) {
 		unsigned len = min_t(int, ds, PAGE_SIZE);
-		data = kmap(page);
+		data = kmap_local_page(page);
 		err = drbd_recv_all_warn(peer_device->connection, data, len);
 		if (drbd_insert_fault(device, DRBD_FAULT_RECEIVE)) {
 			drbd_err(device, "Fault injection: Corrupting data on receive\n");
 			data[0] = data[0] ^ (unsigned long)-1;
 		}
-		kunmap(page);
+		kunmap_local(data);
 		if (err) {
 			drbd_free_peer_req(device, peer_req);
 			return NULL;
@@ -1777,7 +1777,7 @@ static int drbd_drain_block(struct drbd_peer_device *peer_device, int data_size)

 	page = drbd_alloc_pages(peer_device, 1, 1);

-	data = kmap(page);
+	data = kmap_local_page(page);
 	while (data_size) {
 		unsigned int len = min_t(int, data_size, PAGE_SIZE);

@@ -1786,7 +1786,7 @@ static int drbd_drain_block(struct drbd_peer_device *peer_device, int data_size)
 			break;
 		data_size -= len;
 	}
-	kunmap(page);
+	kunmap_local(data);
 	drbd_free_pages(peer_device->device, page);
 	return err;
 }
--
2.51.0



Return-Path: <linux-kernel+bounces-875085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5533BC1831B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 04:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E5C024FE00F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 03:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3141D63F7;
	Wed, 29 Oct 2025 03:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMjbPFCu"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F9A285042
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 03:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761708982; cv=none; b=ULWODgCQy5bSEyP/aF84jeSwpMVCwt3n5rr/b7ZP45j+ZQjD31sPkLs7ys4Rypm84uppb4qNqV7HZok07QufXz/TKvZcT7IXoh5mPkuKmr6a/JZtGQt+GW+AdkrKba2ZeKlK7+r8DJLlNftJI5AXgKDDw7mpAZnSlzHu4hGh5Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761708982; c=relaxed/simple;
	bh=JjeI8UAzfBC854auP7OdUILptuEOBu9o+fyhFZjyqrE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tNa8eafDxWgUhm6jeSmVc0V3DQLVCXlydbGAy76bdhmB1ri7MMgxE8c0i+CfRSewEooyJ+HybCc/rQghBG8YUW3cMei4NPlFIpYcEBKtY8zqQMzUcaCK8sireL5+aurAUAlivuWCFeeMLfc+xrtZiygpBBAZuEWlBPPH6RSUM3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMjbPFCu; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b6cf1a9527fso360238a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 20:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761708980; x=1762313780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4KFQRQSGfTM2DCXucYOUjxAN7CzQGIAPT4+vm618YSs=;
        b=mMjbPFCuel5fFYKOEpA3WIbTLIe6ZKHMPKfgAIIKkfbEXZscCcgkNCERQw+n392xww
         fbU63PuJmg/+37Vg3KFSKJI8MzruQmQw3ouxzCEiPW6lzc3zHRoAaYbbd36ZOqkjoS6y
         40fkmiUrSnWyBECBkwQYYTJchyrdJhsdc+6po/vpKfPiDkoVInze6u6+IwvW8Nm9FGbQ
         ae2c0K7OpEXP4eWwmi08Ir3QGZk2+bmdz8+t+MvEVSIkRlviecEqvTr8oQAvcDgl23Wz
         Zkya5ejGo1fhtQf2RUKFMPxyeWyTJkcscDS70CuUsaQYvpwJgGSz7n2k4zzj9zhsMu1e
         9wug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761708980; x=1762313780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4KFQRQSGfTM2DCXucYOUjxAN7CzQGIAPT4+vm618YSs=;
        b=rQRxZQC3zLPqMOOrSH+mwtNL9t/GiT11cTJr8r0TR8Zt5SIAj+Ix0eEPy/gPND+5OU
         qwusHW1cOZAiUXLXuh6PAuSHognpg30+i7EQZT6x00Xho5iRbOEWH7gSNlDVZYwneGtV
         tOpsrzw/dYrN8P2WbpCgc/0hKlHgNKxyDXBbHKdSdGTeW/y/R9ACmT1IToPcyeyxr58T
         JPGrBPXAzAYcipMSSdZIHdcJ2+kJA6M7B8y94h9UTyPSAvOBtgZCa8trRfzYpB2mgclt
         lq153epFNg1SubFvp1gk+jfF0SOBHArYUaaeEHDZHNf02GItIGCH7CWPlYdgkpxWLhkm
         /LKw==
X-Forwarded-Encrypted: i=1; AJvYcCVTp5ikWmcEF5LiarigIdOxKCzfuMzMh9SUxZpmDlSgrDMe8dD22U0EQTEvIsqDPfxAoAeKaMVCIBO8aMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXHZDi4b2+nDyOhkO/I1iIV1lPaCxKhhukxZafv1HVLZ3i/lSu
	FBjYbHvOuAAHKKKxyp+Lbn9oAXlwfuSYGxRW2RyW0Y+wRoDigpl+7g5T
X-Gm-Gg: ASbGncvEFSbaNnugBJN9lFFpyUaKmo9uL4MV6EI8fCCRmCk/NK1X+tCDg7DzCWJcszU
	Yi/SMfNJsjqo/vdhAqQplO80HKCAALarBTPZnddIobp9xGsSpKJqLamPRyJlo39ocCLsK0pd9gS
	GIo3mtJSvCc9UqDYV14iTSlFLJznXJK7jmB/SAaJV519n/vmDbJx/8x2gs5lEb5dn2VqdklLz38
	dwozWbWshn8Vm2nF+Yso0i2EByG9KTExgSul6irxlTDMy5Qd7zNkffKGZqnr7bR2sVOQ53XGto9
	9nQP/gWBP50Qh1P5e4VS7OtCyY/nGsHyLeE0XBC0B6GZh3TEBF6dKo18LszWExOVZlv1Zeeel6d
	wdcdnBRvdIK/qj7UZYgxIPWWQn9XBOevK/IRnCt5kRwViRxa1yTd1GxOYOIlGFhkt3Zrmow==
X-Google-Smtp-Source: AGHT+IESE7CJsQY/WY628QryMAKelqQ/Edj6cNUuCksIAiMU46Z8F5oD6rzOrts+HuduuM1Ib5/7Hw==
X-Received: by 2002:a17:902:fc4e:b0:27d:6cb6:f7c2 with SMTP id d9443c01a7336-294de9cf938mr17416625ad.17.1761708980026;
        Tue, 28 Oct 2025 20:36:20 -0700 (PDT)
Received: from hsukr3.. ([2405:201:d019:4872:4680:8a:2bce:378c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d40b50sm135972885ad.75.2025.10.28.20.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 20:36:19 -0700 (PDT)
From: Sukrut Heroorkar <hsukrut3@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: shuah@kernel.org,
	david.hunter.linux@gmail.com,
	Sukrut Heroorkar <hsukrut3@gmail.com>
Subject: [PATCH] virtio: document @vaddr in virtqueue_map_free_coherent kernel-doc comment
Date: Wed, 29 Oct 2025 09:05:58 +0530
Message-ID: <20251029033559.83145-1-hsukrut3@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Building with W=1 reports:
Warning: drivers/virtio/virtio_ring.c:3174 function parameter 'vaddr'
not described in 'virtqueue_map_free_coherent'

The @vaddr parameter was introduced when virtqueue_map_free_coherent
was added in order to provide map operations to virtio device, but it
was never documented. Document @vaddr to silence this warning.

Fixes: bee8c7c24b73 ("virtio: introduce map ops in virtio core")
Signed-off-by: Sukrut Heroorkar <hsukrut3@gmail.com>
---
 drivers/virtio/virtio_ring.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 7b6205253b46..d763060ff0f6 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -3166,6 +3166,7 @@ EXPORT_SYMBOL_GPL(virtqueue_map_alloc_coherent);
  * @vdev: the virtio device we are talking to
  * @map: metadata for performing mapping
  * @size: the size of the buffer
+ * @vaddr: virtual address of the buffer
  * @map_handle: the mapped address that needs to be freed
  *
  */
-- 
2.43.0



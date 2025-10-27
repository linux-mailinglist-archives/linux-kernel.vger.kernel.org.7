Return-Path: <linux-kernel+bounces-870886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A58C0BE85
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 07:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C3313BD60C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 06:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9752DA740;
	Mon, 27 Oct 2025 06:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cn7WUuKZ"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0212D7DDA
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 06:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761545277; cv=none; b=h+ykjmv26mQfoIQNs28fng16bIKyscy3v3joexybUtCilBqTkmxiB7fxvs88ZcEkU6L3u08XORmfjB3+M7VwddfXjjxyH70qPdRCsD2qWWVg4GiFiepxZTBg8KnFCFzXlZlItM0DgUW3baUJ8xMJPt0YVdotg/HL0cbflETfIqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761545277; c=relaxed/simple;
	bh=2r27UqdYRY/th9NT3KvLaQBAFAv+vHzCvNeRmfAsipQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Dy6gcxlwWY6/ZfIslGatQ0dthj5LOvpWINCMa39OWR+BQqWwLmORDFo2yRL8jQzqH/Ia6OPXgRAoLdP14okpmx2eH/PPvXCWhSe1bf9MR9AHj+wIH0iwiKbR9mDMKJyMsSDzZ0BRbFJxt85cPoukgahgDEFr/AGhJqQY7jgPxB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cn7WUuKZ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-26d0fbe238bso30265885ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 23:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761545276; x=1762150076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4FyP7h5NR2Q1a8ZGF1Za3mDWy2+W/UZG/poMuoDyAsA=;
        b=cn7WUuKZWO4i24/kSYes8hqPCLJa8+p/UPwL/NZOa8JNhMznj01ildmn3X0oKXsWJE
         Sbznu5vGNI3h4Fn+x5ePY9VkhUpvun3kj4CBE4zs1yxY9hY2YI1sGAfYLGz+LHnEnjpa
         241gi5w/fHQDH44eveIm3deTZcLBmdkjTXLoQAolKq0X+8vPiNLQ7eubTY/79vq5CtTf
         WmC2YzdEyiHDGnqvQ1h2XfJo7Qhj0Bk5RGYX7KZZEvEHx8WHl4seONdPhi5Ys6Zfn3+L
         pFp9u6G43Au1HQHuP1p5hJ+Uis4+dqaed9p/aSlKMvlpIml5Ml9pfb421TpHSyX3Torf
         ixvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761545276; x=1762150076;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4FyP7h5NR2Q1a8ZGF1Za3mDWy2+W/UZG/poMuoDyAsA=;
        b=fbQRnK/VOenjdhkyF94Ay6yoJ+6dusc6lvoUEBw67f/liakQOe1YjcCfT7LSPx9SbP
         ewvwnOi8unqe3gi3VRVFm1rmwk4H8Y64RixkyMRWdWctDK0nsdF3PE/D59DAuBLdeWUv
         x0iygswN6SYzx1/1ZylXET/5DmmWmRUfMEOqrZv+o1cj5nkjTX96nJuVdv80or754KJE
         xIul74e3MCb2KkREfdsOy4/pVYMrK+6xb/52ErEJ7JCAMQW9opoMjWfMbFdefWqPJA0P
         XQ1HFAwF5VPcGcGRjo0VFMDUBnZ+eoTSLENBM9sAz+/CwDDGw+52JFMXYik45JNLoAAA
         23Jg==
X-Forwarded-Encrypted: i=1; AJvYcCWyjWifqJiIAKLdftVZ9ttVtZN2Be1YuzDdRTY9Iuh2caWYox7gHBsBzmhDuVtst6NHYJFaNo9A+wdIfnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKCCggVtAsN/zZ5G8kEiVbG1HGDyYz667xuB68ok2051bM0Izs
	yOQHCBTNnxbQEhfN4Aygr3Y9ha2OAhqYXv1j/EL585S04vGCuaea5mUE
X-Gm-Gg: ASbGnctbtvmkPbzgTTv/gP/NLaB9VHhDbuRks7ONnKzTq5op5XYP8VGvIK58ri3bh7O
	lTKafWDLcrRrd2fj4DVBh18HWIxeOueN1zE3CLtOfbQ/DZdUlhG4JWR1fOjasrJXooR0fAFNZZ9
	ix7mdG3MWDO+uKaDsHQn7fkUre5zFIFDho++dUTmqnTctX5gG/oe9Q2BdCAn8pVBjwF/IJRgYzQ
	qXVdyfeFMXUBF6gHfr8GQ0UEmA9tSkebfgu9nJwqhkqgMJT8CV8ISsKrnvak3IdESM2gi0s4Zn/
	3zSl7kcHBGZsqx0q3yy5lxf9rEs2zMTlDtfhTyZBLJe/87CI2lHQsKsAG/80hQKw7E98Yw1BfUa
	YrvbAPSHwleCX2d9fSFrJOORU+xImS1GFNvPNZGHg9iOpXc5r4dHYE5o0wQx8FjyYSoRUrxueLs
	uqsGBhQtD2x1/cUAlgw5v8Og==
X-Google-Smtp-Source: AGHT+IHkRBw9AN+xBRZdDNVj+3VWLhXLMgjUZyYBAk3neP09j59Fxp6vlIptXFrwVCD5MHrWoavEVA==
X-Received: by 2002:a17:902:dad1:b0:26c:87f9:9ea7 with SMTP id d9443c01a7336-2948ba78fd1mr155483155ad.59.1761545275616;
        Sun, 26 Oct 2025 23:07:55 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29498d40a73sm69674695ad.74.2025.10.26.23.07.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Oct 2025 23:07:55 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: schalla@marvell.com,
	vattunuru@marvell.com,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Shijith Thotton <sthotton@marvell.com>,
	Satha Rao <skoteshwar@marvell.com>,
	Philipp Stanner <phasta@kernel.org>,
	Nithin Dabilpuram <ndabilpuram@marvell.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] virtio: vdpa: Fix reference count leak in octep_sriov_enable()
Date: Mon, 27 Oct 2025 14:07:35 +0800
Message-Id: <20251027060737.33815-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pci_get_device() will increase the reference count for the returned
pci_dev, and also decrease the reference count for the input parameter
from if it is not NULL.

If we break the loop in  with 'vf_pdev' not NULL. We
need to call pci_dev_put() to decrease the reference count.

Found via static anlaysis and this is similar to commit c508eb042d97
("perf/x86/intel/uncore: Fix reference count leak in sad_cfg_iio_topology()")

Fixes: 8b6c724cdab8 ("virtio: vdpa: vDPA driver for Marvell OCTEON DPU devices")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/vdpa/octeon_ep/octep_vdpa_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_main.c b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
index 9e8d07078606..31a02e7fd7f2 100644
--- a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
+++ b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
@@ -736,6 +736,7 @@ static int octep_sriov_enable(struct pci_dev *pdev, int num_vfs)
 		octep_vdpa_assign_barspace(vf_pdev, pdev, index);
 		if (++index == num_vfs) {
 			done = true;
+			pci_dev_put(vf_pdev);
 			break;
 		}
 	}
-- 
2.39.5 (Apple Git-154)



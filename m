Return-Path: <linux-kernel+bounces-841131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CA7BB6541
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 11:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44CF33B9F32
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 09:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4059287518;
	Fri,  3 Oct 2025 09:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDNC8yhZ"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B28128643E
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 09:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759482685; cv=none; b=XnJk9dHAkSCuq3f0piOz55EgWuhbjtY5i6jhPzlqfQunY2OvRMzRgqIJYJSHKYgGVsGexEkhPw4zYeOaAfYvS7BXxcJac1+nilVTJ26BHgLlCToWYJyJAjT923GUfBAOvQbTzh9b6A1eN9MMmNcA2cDEf9J3qX9d4giPCOctI38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759482685; c=relaxed/simple;
	bh=5qgmGmYUOhVgTZvRetnu8/iMUpcsPIqnDj4z+RlR7p4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GbeDk++CgEXGml5cZAJGOSgMt5kigHlubtgoCJ+C+s+IFqp7ocE5GqbQSGiEB09PJv/UFHb1J1JMV1AWWzQ6t/u6MDa6GX0szbPqXERQL2cc4b8bCST77rajlU3vZ9SQYBmPjFoVHsxoUF32kxtQr5n5GHGcEimbk5WBKHw6dMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDNC8yhZ; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-57db15eeb11so2314797e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 02:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759482681; x=1760087481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=arnOv/Eb+ei+WprDdJ+AExiCBQfw52nTIK0kxgp5nQs=;
        b=VDNC8yhZ0euZu+Sakhfq1zPg2AzcbewP7Ea/L8hXjLnvodrUcHqpwmxsetxZ15OUvo
         KZBbTFBGS/XdVA8EmrsfPO5ml8g+pB+qDn/kqQg+P8ZJiO+zNHnMlXnh4k8L4d9PGPFu
         9Dqg2bsEG+ytT6E4tOT/w3WQreaIC70Xs+r9Hb7MdQ/uB0oRuzuJiedNEIpmUQALo2xg
         rme723sLziHkh1tDRnPOa6au8V0c1z8MylVjMln8rj5Q7HmJWwtrCUvLz/ytgzyLc3HO
         UEki9ZvSwBiYmh+FUqQEzlxDA8LV9m6PRuP+JoXZUWnzIBG0dnmBq7yfEcfa8wTUVuUl
         B2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759482681; x=1760087481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=arnOv/Eb+ei+WprDdJ+AExiCBQfw52nTIK0kxgp5nQs=;
        b=v4+igYASeGpBlWW/h5qR5bYtP4GyZU8m3W58s8tDxXusfNs6tEXMOtw0yrCgHwmyjq
         aJ9zKHa9NRXjOXtSIfo9RcWpeUIkw+uu9H08fl7JnXoGICEzL20KmuQXkNluwAxLZXFj
         c/ebuW6lNYcS6a2L9RELLoXzS+Z+C59p8qwWZmFr2456HXcr/xViwHNEXg5hXtr6+SxV
         Fqk2jmQce4voxCHmPRI6pSDH4RfZfFIwPdARFjV7nn961fgmk521uDhcRDz0qrqSRMLL
         DQYzaz0zoQtEh03tfA+w8of1Z2ITEC3iTrTPm37N387BnIWnEKyPO8GOgFayIhZ0CqxZ
         zaBw==
X-Forwarded-Encrypted: i=1; AJvYcCXEcojwy96FzjhocQT9syJGyC6QX1Bovz7Fa7sU74M0k20noj2LUNgNixGFzqg03BFCYCb3Q3jEF6A2GaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfIENOyBjMd2JW/lGqHlY5hcjyzf/qebMBHznv320bc8jxN4Es
	F6OSwph6r5UHlqprenTBgR/4OPfSLYfkDg9FZ/NkM+i/24ienMWdT0xn
X-Gm-Gg: ASbGncuGgEYnYyp3+vfF66mHyCR9NXVtFfwW2f/4CtrezP+FANJOcPwIuwUf5qRvvXW
	+qO0QPAg2XGZwNOT8fGdAU1u4QdVMj/Khdw+iB06QKg0PHGX5VZX0LKuahaVbZcAUpAroGK8keq
	WvdmvHMXQBaWZe7txaR7/C+xTkghX9i7AtEPDYRwALpZCKfoJkl+IPEOlTQmylRb7yFnQTZUsxi
	W58QUX72Two62mJpWhyOz6uEnzs1bBrE7R0MMkQrj6pse8E2cl7zYkZq4dJmskovCdkHvHrssQs
	lkiMBOWjdsTPnTlLPuuGphtYxIKVDGjaTHUvUCWCs0qzomqPJjeVUjxeMaXtzzhhjSJke+mMur7
	74fc0a87LB7BbUVIgYESaQI9pyMipZfUE2rDVjcSI4CY1h1OASTPtOBa1bSJIiJBzWh9YCvybcE
	G8
X-Google-Smtp-Source: AGHT+IE0aTdUm34GWxVWeIcSrnaWArAnE74mpIbehfqtmMHNBlov2Lov3oNlbPMqnpOMOxtDIGa47g==
X-Received: by 2002:a05:651c:1548:b0:372:9420:9509 with SMTP id 38308e7fff4ca-374c37001bdmr6162771fa.15.1759482681129;
        Fri, 03 Oct 2025 02:11:21 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([46.159.163.120])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-373ba444480sm13498971fa.30.2025.10.03.02.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 02:11:20 -0700 (PDT)
From: Sergey Bashirov <sergeybashirov@gmail.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@infradead.org>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Bashirov <sergeybashirov@gmail.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 1/4] NFSD/blocklayout: Fix minlength check in proc_layoutget
Date: Fri,  3 Oct 2025 12:11:03 +0300
Message-ID: <20251003091115.184075-2-sergeybashirov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003091115.184075-1-sergeybashirov@gmail.com>
References: <20251003091115.184075-1-sergeybashirov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The extent returned by the file system may have a smaller offset than
the segment offset requested by the client. In this case, the minimum
segment length must be checked against the requested range. Otherwise,
the client may not be able to continue the read/write operation.

Fixes: 8650b8a05850 ("nfsd: pNFS block layout driver")
Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfsd/blocklayout.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index fde5539cf6a6..425648565ab2 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -23,6 +23,7 @@ nfsd4_block_proc_layoutget(struct svc_rqst *rqstp, struct inode *inode,
 {
 	struct nfsd4_layout_seg *seg = &args->lg_seg;
 	struct super_block *sb = inode->i_sb;
+	u64 length;
 	u32 block_size = i_blocksize(inode);
 	struct pnfs_block_extent *bex;
 	struct iomap iomap;
@@ -56,7 +57,8 @@ nfsd4_block_proc_layoutget(struct svc_rqst *rqstp, struct inode *inode,
 		goto out_error;
 	}
 
-	if (iomap.length < args->lg_minlength) {
+	length = iomap.offset + iomap.length - seg->offset;
+	if (length < args->lg_minlength) {
 		dprintk("pnfsd: extent smaller than minlength\n");
 		goto out_layoutunavailable;
 	}
-- 
2.43.0



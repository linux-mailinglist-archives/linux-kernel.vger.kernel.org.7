Return-Path: <linux-kernel+bounces-764009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6B8B21CD5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 07:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 728CB7B5FA6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 05:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D0B1A2630;
	Tue, 12 Aug 2025 05:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQOEOIQI"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408E2311C34
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754976122; cv=none; b=BjB815KNu9bsPGgzoEP7MdSZOfnUsMMbey7e/9zoL7hmuReOuYLlqb5H93P7T/H2BAnpoVunWQDURKPYh+A70zbg3aJcpnWH7w0bb/15c4zUg+WRh8n3SNp7hs3W7wHGlypQLDo7wpzRc0qTlEPUIdWJsHR1v2V8ieYxkm5VtTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754976122; c=relaxed/simple;
	bh=tk3tbv5O4aZIyU8u6kFHYPb+xV11YL3DbWD9O/Hxse0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dAhn/yv9XQzzje1nG5nPX2Gy1qiueGX3NUGk7ETvAEtAXHCFzlwFVLbIDlhQUIDgAtMNqHZeeG57A4z5gPOiz0hKvC5Xc2WYfMh/wu6tV63PWf+Us/79HRJruR+1btuNHWSb1O2qTVbFc1ZGSlWOuhFf0xMym4zMCTIEFHJJcAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQOEOIQI; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-23ffa7b3b30so46927945ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 22:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754976120; x=1755580920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J6NJO3iNOv3qmpNKbpG0b8ArdkFZkJCoKkSUSOP4dNw=;
        b=bQOEOIQIzULQxW3FSL/+/9DiVIuGz6ouVlsLLGZ4f/LM4b4xIJpRp31jl0v1I0fQsX
         CM6wftNLKB4EpXZuOAgV2Dt6p5egKt9D0Otj1GdwDMapIWhW6u+i2Pi/HkGfctgEOL5h
         unB0/+fmX7pZ5rOcgMDiYxZ9ykutUeLj/LVr/X8OHWSDTwUGaZ8zitrk9s304Maedwjf
         H2Fo2mDxoQ4fqBflL8t7s7eME+BcCAFVpFJxeJo0uG+xJ2BwehtjV5kmmCJMw1tFiY3z
         6OVzyWgmxx4H7PH0/qrbdglGYoYU503utGJ2/1OspljUWjpvNfzLqhEGlKH78N9G7wet
         mPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754976120; x=1755580920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J6NJO3iNOv3qmpNKbpG0b8ArdkFZkJCoKkSUSOP4dNw=;
        b=lzOeHUqAtfxcIFZWT6g+IAxLHeuUodSOIkeVVbEtdXsarTg4Q2UQqn3egt/ALVOeoe
         aDGhjvSAAP4vMwAV8RnSY9XHr2sr1+h7nsjA/6VxCeKNFG6rwPyZYpeGkKEewb5PNIcI
         l66DXUDpuTwKMMlI+PCB/txfH3pReBby/j8/MyWDvlM6jHovhB5Kj7JgbYBuarv/JSU3
         LolHKqBjhtHuYhEeoyne4+ftidUqFt2i9ZEw7lBFGXCUA4bN3YORxfYaNsbw9loG/Y+d
         hZXUKpcY+NmUnN8qQALNkDyOf9p3BtlNs41Cl2XMV4/XJfBjNJaQI85aOpxEuD/+YYPe
         8Nww==
X-Forwarded-Encrypted: i=1; AJvYcCWShqd6WQ1mxWUJ+oUR2iEJWfZaSqtkhWhJC1ji7UMEM4oocgcLZ5Cbm5nhQlBBQhsT+KEoAqh/VnWOkMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR2mr/D0SFPJ7z2FeTqSZL+rn9F4IPuOZYkDdKDqiU3JztFzLr
	ykIvk/DjLGv0VAzu/3nvREbhaoUdFuIm+W1AEdg4xgiGIWfL3+7ORnKOw/05rQ==
X-Gm-Gg: ASbGncsHufPgG0KOR4vzAJISjnyFE+9wICcUnPQd94WqpXHe0DqKg014EB4T0VXQ7Zz
	0AzhFz3w1zuNOdRXQzqywgRLWjVp+Xs6XkCxIxyYiy7hb8R63JyUrAGa4cJh3zwEolpu+Mi+oPw
	lZxQzRCJOfgqGGInLugwCwkhma9gq1vh+Lq0gUmzSzzK4fkIaTEy2L2JyNAdPD393a83Wc49Vcl
	x361XKgaavGUf39dqrgRxYJcKxb44342wKUpJLDdWaH1QClHyejw2DH5WKYYUDqo1v5uYNeD6mM
	mw7osXU13gv8VC7OQdausa/Na2YtuLAq37eXCvmgQyE2nZsXAzfbxoJuoubwrm9odxz9LAAfgkW
	PcZtTL+l6oIhKZYWIAb7RD2PiQQm3flTO5UzbzRNm84RgL8RC3TR7RIZNWVxhkg==
X-Google-Smtp-Source: AGHT+IF1ochuXZ3IX5U0e55OXQGDw4nd3ipP9HyvaUP+4khivk9Hd9lYjetLf8OXfPWiIAhXj5+nig==
X-Received: by 2002:a17:903:1ac6:b0:235:e942:cb9e with SMTP id d9443c01a7336-242c1ffb1e7mr217653265ad.9.1754976120361;
        Mon, 11 Aug 2025 22:22:00 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aab0ffsm290686715ad.166.2025.08.11.22.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 22:21:59 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id 79DBE8022A;
	Tue, 12 Aug 2025 13:27:22 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: richard@nod.at,
	chengzhihao1@huawei.com,
	miquel.raynal@bootlin.com,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: alvinzhou@mxic.com.tw,
	leoyu@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: [RFC] mtd: ubi: skip programming unused bits in ubi headers
Date: Tue, 12 Aug 2025 13:19:49 +0800
Message-Id: <20250812051949.983040-1-linchengming884@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cheng Ming Lin <chengminglin@mxic.com.tw>

This patch prevents unnecessary programming of bits in ec_hdr and
vid_hdr that are not used or read during normal UBI operation. These
unused bits are typically already set to 1 in erased flash and do not
need to be explicitly programmed to 0 if they are not used.

Programming such unused areas offers no functional benefit and may
result in unnecessary flash wear, reducing the overall lifetime of the
device. By skipping these writes, we preserve the flash state as much
as possible and minimize wear caused by redundant operations.

This change ensures that only necessary fields are written when
preparing UBI headers, improving flash efficiency without affecting
functionality.

Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
---
 drivers/mtd/ubi/io.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/ubi/io.c b/drivers/mtd/ubi/io.c
index a4999bce435f..ccab4691b338 100644
--- a/drivers/mtd/ubi/io.c
+++ b/drivers/mtd/ubi/io.c
@@ -868,6 +868,7 @@ int ubi_io_write_ec_hdr(struct ubi_device *ubi, int pnum,
 		return -EROFS;
 	}
 
+	memset((char *)ec_hdr + UBI_EC_HDR_SIZE, 0xFF, ubi->ec_hdr_alsize - UBI_EC_HDR_SIZE);
 	err = ubi_io_write(ubi, ec_hdr, pnum, 0, ubi->ec_hdr_alsize);
 	return err;
 }
@@ -1150,6 +1151,7 @@ int ubi_io_write_vid_hdr(struct ubi_device *ubi, int pnum,
 		return -EROFS;
 	}
 
+	memset((char *)p + ubi->vid_hdr_shift, 0xFF, ubi->vid_hdr_alsize - UBI_VID_HDR_SIZE);
 	err = ubi_io_write(ubi, p, pnum, ubi->vid_hdr_aloffset,
 			   ubi->vid_hdr_alsize);
 	return err;
-- 
2.25.1



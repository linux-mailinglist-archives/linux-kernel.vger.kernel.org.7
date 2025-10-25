Return-Path: <linux-kernel+bounces-869889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 371D8C08F00
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 12:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 74AB14E471F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 10:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A552EB5B9;
	Sat, 25 Oct 2025 10:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDDX/tTv"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944262D63F6
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 10:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761387630; cv=none; b=HloCao04OTlkB/LtMJUUtaH3RkLtpMfLZPVmuOto+bXoK3ONNf+tFnyJs8bUCf/Hhz1eDLKvVGFwhE7jW3SuhAbewjgga9nGrcpvcXCQcE909nI+6U4jtmUh/4MaC4Lu4/PMqse/5FoN3g7nU1IbTJpf9F+0uaDcXjyJZnG3+GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761387630; c=relaxed/simple;
	bh=n/WmFuxnjU+b5BqffW9C/hwrzM3poLDwCzQEeW+4gA4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AVBbOixY6qRpzTieCm5zCGxpFwoF+pxzDsgt4wLPghj+Wk8SHLi/PDNnPGVemxe+4eVi3cUrJJNQ3MIMdfVpur5Zcar+ysl6HaPFhT1EDIRw1I1pvA+6ly2k+94rcc4gcxyXJ15W5GZ9yusp+qi1mALv4EY8MlK7YaQ/YNUtWxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDDX/tTv; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7a23208a0c2so2316700b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 03:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761387629; x=1761992429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2vevNR+/jFaSQTBPwXQ9KXYtO+RS1f1boQpLGvPWQCE=;
        b=nDDX/tTvnsQXbSh+qGDh2osU4k/TR24I7/ORg2IrTSTIYxbEzPXI4NHvvneETOVnzI
         WSIreuJgWqWv2IIChZ5jYSTegKVCQqbUTH0uLxvLniP+AqAWM+ndTCrbKNvfBPpSqNDS
         pukt3b8FVzzMadmWaV95RjROlXfLoguV9GtIwo+GZGIjI7rsgHOX75YFwUcp7wwR5c5B
         g4pkoze+u5qhQZC5Cy1Mr3jmBmWUIn0HoP/TcVi1WZczIbQ2LfrunzPHDvow6wAgcicc
         dLRGW/S8SgHp5bVTfAf1neZlkMHj5/d7gGI+fJkNlhABmF+FnglBBbb10ZtT5ZzH6rES
         Y8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761387629; x=1761992429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2vevNR+/jFaSQTBPwXQ9KXYtO+RS1f1boQpLGvPWQCE=;
        b=h9aua9zklPX/KaTKAuxEXTcB3D6TiDF6/NHVcuQpOCQG3yBTxjXgfohnwO1WG1xARt
         Kqus8N+8NuSeKxbRyAZeziY9/nEI+UArZcYozbsUYrSpimyzXos65yibLUP+rrIJHxUY
         Oab2kHpSgX2l8kwGKStxicjHQ2e8rUKpOo0S/ZSsox6qOtj6/wWKGu3nyqR3d77OAOEH
         cRGRT3iWi1OuOSo5CN+sJTS/z5MOr1V9mtamjicdTswyJBi+neauFW6KipqcTJ67p89S
         SFmo6AjFOFIaMRdQa5hOpwmTUqsLtOa7o358PLZWi5EPRRPpGtP96BeDOnf9zWXmKFp3
         NKWA==
X-Forwarded-Encrypted: i=1; AJvYcCXIvFrLrfPzmkBo1pgUSYB6ieZC5EA4m+Xe/ZQIOMvLZk9R13QEl23NWPJ6V4jG8K2IpiqJydZLWRD7KsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEz+UDkfpEq0CoRy3JPshatfSzg1pfrK2usLKFE9yM0gOFXKdQ
	8Z4pucIk57ahHCFne4NX5k6c5bVjZaoSQSrWZs4fSwtc3b8puUGYv2dm
X-Gm-Gg: ASbGncv8NJPJANsdWxah04BRfDQ3Cf0VfZ3ybpj9KjQvSY4SzIMlbIFDSmA5rOMH0k4
	s/ZXv2YRpRlfdB4OKN9eQkhVj237QbyElMDWeT3LAkTSpNiodxJef+mp+SbLrmLnk3FvlsVimRM
	9SAiVZUJS9x8xu6Ft232oikJtxR5AXWXGIl8Nxfv8OZmhEBeShPJky23V0fzglAWd4pdAd76fWV
	AxomflGJ7ZYbhM/GEXpy/1+hfY8NbWmweLF0OC7GKUrofc9QAkLkPcTqGz1IHH7aZ8KTvJR98ew
	F/aQAALwvIiFGJuSyob9uLrqP0HMMXCcsZq76WSK9MzxpXRj25GdKpFlbY7ZMEY3phlvVbcCJbW
	OFP7Vc1cI2kWIZ5jKPgIa015V25lsRkxLv/i85Sk332bSsrvGt6C31UTprxH8D0HqgIIv4ThT6Z
	3vMvz+KaF9BJrf/jYR
X-Google-Smtp-Source: AGHT+IHSSS9RbZgpApd9MbHtHjSs8JwOUFPxSOsL85Q0eyw90TSB4I+atkWIog5jAkoofR97NPCzIA==
X-Received: by 2002:a05:6a00:2e1b:b0:7a2:7157:6d95 with SMTP id d2e1a72fcca58-7a2715777f0mr12532137b3a.14.1761387628859;
        Sat, 25 Oct 2025 03:20:28 -0700 (PDT)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41c70ea64sm177639b3a.3.2025.10.25.03.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 03:20:28 -0700 (PDT)
From: kriish.sharma2006@gmail.com
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kriish Sharma <kriish.sharma2006@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] iio: document @chan parameter in iio_backend_oversampling_ratio_set
Date: Sat, 25 Oct 2025 10:20:08 +0000
Message-Id: <20251025102008.253566-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kriish Sharma <kriish.sharma2006@gmail.com>

Add missing kernel-doc entry for the @chan parameter in
iio_backend_oversampling_ratio_set(), which removes the warning reported by
the kernel test robot.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202506292344.HLJbrrgR-lkp@intel.com
Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
 drivers/iio/industrialio-backend.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 23760652a046..937f4ef38e1e 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -717,6 +717,7 @@ EXPORT_SYMBOL_NS_GPL(iio_backend_data_size_set, "IIO_BACKEND");
 /**
  * iio_backend_oversampling_ratio_set - set the oversampling ratio
  * @back: Backend device
+ * @chan: Channel number
  * @ratio: The oversampling ratio - value 1 corresponds to no oversampling.
  *
  * Return:
-- 
2.34.1



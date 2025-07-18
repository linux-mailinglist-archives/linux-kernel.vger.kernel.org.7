Return-Path: <linux-kernel+bounces-736428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34805B09CB7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD7BE1882CD9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 07:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD4326981E;
	Fri, 18 Jul 2025 07:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1QkU0+8"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C273268688;
	Fri, 18 Jul 2025 07:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752824259; cv=none; b=cBgphG4YQ+m0mBSq/k6huzuvGB+QROddvU/owsunZua1Pd341f7r9FA7O8QJ7HwsrzXQWybHrrYijvZvwGjKfFASBSurlaxKFiGQRBQDC3m6FtdZ0kq/iQBKBavLeRvwYb8RIs2LQRcxSqs8jqjqRgapi+J1GhX6ivq3Owp4Mdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752824259; c=relaxed/simple;
	bh=QjFG6odFp9E4C0/ZwQY/e7D+oEvA4hg+uYtGxIhPuLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XIJrP7/DDzZXJQ/i8zq3+d7mcVxKKLfm2nbZNPq/qATy3iZwsK80LKWoYNYxnqj6iBvciUB+B3rhXEvBK/YxXu4EaXLuLb4L1OKsyLji8/S0K87AC8lqp0vdwmp8NPgIsyKND2DC/GI99OyNqCKiR92gyq0F6kQG2tT9JHlE3/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c1QkU0+8; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2350fc2591dso18907325ad.1;
        Fri, 18 Jul 2025 00:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752824255; x=1753429055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VlvIN4gw3K/irnbr3ye+l1lLYYjCQPCt7Dolbh9+AFM=;
        b=c1QkU0+8SsnfQBTR0sOU3SHoXYRE501bJFbdQLC+EVWQz1xqEa9bGTKCN+Dhgtblvz
         lImYqyqoYlIE8rffAlhFn12ZFX++3/22S8pTiJkk5ibJ/Mz4kFDgCoMYO+pPw/la5P8e
         W2EEelGRirUtPSnK0w9EHH0cxa8nNSpDyrQv7Jc+rs4CveTQyq00Rf+IY3fqNfhlqBnD
         pIhd37GC8JwQ8f8fk49zUeDB4BLxpGDLA1GbSH17FuDBy0I8wYBO0eyZlIk3R7vIQngr
         2jPpLCgGDsMpjYINXNZGkzdqNM3Zz9vTQgjit1+fMP4HmutHBP+zDywahYS1cdPCWdFW
         gpgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752824255; x=1753429055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VlvIN4gw3K/irnbr3ye+l1lLYYjCQPCt7Dolbh9+AFM=;
        b=AvPu/T/H+hbnN0FuROhzeNi/Eeg9WIGFf/DQXZc5VESxd20/IQiEzFmcU0v/G0WZd1
         4JnHQvwqGeTxebKzMJAjK3U3Byg9/omMlcoPUyyZnZrXeXuqvKbl5DhQmXF+7mZNAFPY
         w8Pm8VZQis3D5pU1kbPGU/WXMx+H9HAX8NhjNIpfiRbKqVueM8NzqNgRKbrm+gwIpgRm
         ZQbFY5D5e5876BEuWntY5xjx97M40zUQT4HER1dkJNW6zHqN/MZHMjd6/88AlfLSKIQm
         mhXtsrfxuRLSDAWZEPmc5tR5teU/NY3tPx/0T9HwOnVMZKy2YHfdfB6g0Xwodian8IU1
         0yYA==
X-Forwarded-Encrypted: i=1; AJvYcCWyqbamNsdKtN8pNJxDBFrCv/Xa91IPi+bnMg8emwv2WAFtZOhOfnfcgavY06dQ41ndcKBvoOcugqjy7+mKPR4=@vger.kernel.org, AJvYcCXw5QmuFjNrIb0/x7Ls4ObQvBctfqgdxVS099fH7J1cg000+Vu12h3hGvVABimjY1jRsGssfT8ZBfdxoyE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7XCuCSzXkNARsNNX+sZvi8sBxQ6TpVd7Wk/pPIXjgOyGm3mUp
	6KxdGrg+LvtFyf8J93egBf5OfPQ3LqYrmpsfCidewkGlO2B6eYJTjriW
X-Gm-Gg: ASbGncvak7w+O1OP0grfFnP76KpuXzxu5Er4bej/hKWRvDeguQVdXFGRLw1Xpk1UhLm
	ElvM1aHi/0ChVlqKcmipkAo6fOVGCjLYuUD4iFIZhJlLiem38g4GuSlNxUIJbJnw4yUqaFQUf++
	mywMWYOzn0SbewWsuXPBg45wZmmgqhlh8vSLSEV/vjqgaqwid08l9dKCIIN9AYEwsw3FveGm3Zr
	n2tLUoFTBxgA3CbTiK7AGg7DOVDt/9eV8qgxwytH0Ncvn1ytPEl5/u2kmNBwSRJRJzuuM5fl65H
	6wvc7ZoLNH9W+QOsyLtKeKw7fi3B0c7UkrCLcpzTbS+5qsIFqmwWFb0n+5py/769LY/v0LPj+Yv
	BEl8qf+/EOgZjPMYTZd9I6svU
X-Google-Smtp-Source: AGHT+IE4KnqF7Fpi+Oaw+hIzsHnb/lyisTQ8PFgnzh/ZzYpbtRnlDetOG91r/+F5ZBfJXXfvgIqSNQ==
X-Received: by 2002:a17:902:da87:b0:23e:35f3:7ffa with SMTP id d9443c01a7336-23e35f380c5mr71364715ad.14.1752824255391;
        Fri, 18 Jul 2025 00:37:35 -0700 (PDT)
Received: from quat-desktop ([2001:569:514a:9100:3f23:7b0f:f6a2:1ebd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6b4e84sm7671725ad.104.2025.07.18.00.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 00:37:34 -0700 (PDT)
From: Rhys Lloyd <krakow20@gmail.com>
To: acourbot@nvidia.com,
	dakr@kernel.org
Cc: Rhys Lloyd <krakow20@gmail.com>,
	rust-for-linux@vger.kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] gpu: nova-core: vbios: use size_of instead of magic number
Date: Fri, 18 Jul 2025 00:36:24 -0700
Message-ID: <20250718073633.194032-2-krakow20@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250718073633.194032-1-krakow20@gmail.com>
References: <20250718073633.194032-1-krakow20@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

12 is identical to the value of `size_of::<BitHeader>()`,
so use the latter instead.

Signed-off-by: Rhys Lloyd <krakow20@gmail.com>
---
Changes in v2:
- Added `#[repr(C)]` to `BitHeader`

---
 drivers/gpu/nova-core/vbios.rs | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index 5b5d9f38cbb3..912698308102 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -346,6 +346,7 @@ fn image_size_bytes(&self) -> usize {
 /// [`FwSecBiosImage`].
 #[derive(Debug, Clone, Copy)]
 #[expect(dead_code)]
+#[repr(C)]
 struct BitHeader {
     /// 0h: BIT Header Identifier (BMP=0x7FFF/BIT=0xB8FF)
     id: u16,
@@ -365,7 +366,7 @@ struct BitHeader {

 impl BitHeader {
     fn new(data: &[u8]) -> Result<Self> {
-        if data.len() < 12 {
+        if data.len() < core::mem::size_of::<Self>() {
             return Err(EINVAL);
         }


base-commit: 14ae91a81ec8fa0bc23170d4aa16dd2a20d54105
--
2.50.1


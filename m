Return-Path: <linux-kernel+bounces-780126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E98B2FDFE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95C15A03783
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491BB2D3EEB;
	Thu, 21 Aug 2025 15:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b="BVN9FsGs"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2308D20B218
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 15:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755788988; cv=none; b=khUcqGIXApeQC5hA+SQpfntHuicLq4htKi+lLg9O6YoP5EIQVYKBkRwuvZNvA/HpyGuTrwVaj3bQpUXL92d9IN5E+iSa41LqbtrKyer9juCk7R/0h96fUE5RwZrbG31IBnDABZuwGPQbsRM3CFnFbW3iXmjdg+JAuCuUYGWHt/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755788988; c=relaxed/simple;
	bh=OKjnd4X98tRpk9XuHhJizhKjstGINl6E+zDsKsA4jdo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W2m5RbiRqtpGIgiOjdNI/PAJAH+VmaHnlpurqE1F5oZESTsTBbDAAC+IZwFWbxlcZAopIgxAx8bkHH35JiOBtioACn6Uoc//mi6R5Cvb4GTd+5Z+kCHocRlo63pPK5IrIMNns+aK0kOQyTDbVHksNKSIkzhA2+jbUWBhmiomLvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com; spf=pass smtp.mailfrom=zetier.com; dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b=BVN9FsGs; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetier.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-70a88de7d4fso9834406d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zetier.com; s=gm; t=1755788986; x=1756393786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nvYZ3xwBzsmY6VteFa6Rk8Li/fQk5rtNPNaSWCyz9bY=;
        b=BVN9FsGsJ2ensFXqmpE2fgCjPvGGAjD6lQO4Bg2w8YU+y00WQ/KtFG9kcUXCXQSi21
         ajddKI77yoKkTI3Ugte62rmYi48Xf8w+6KgbgNtwpOphSmLVYBYz2UDTABIQU58Kz0tf
         dfZ5nf9dzCyzLq7W0pHcIbzjgSePFS4P1iI6WNjgY4A9WfWL7B3y2CRefz7N45rDDEIb
         mSCl8kiGTYbtRaitpdi61xnVD2kpBhUWdMyONV6LgeQScYwdFVzThhkeC4iWKOllLRtm
         +nZAzv65ICdMA6urIRGlPWl9yZtDqfLqDZ6DLMVVM5YrtaUOUjaZGNNctRdaP3T8T/8J
         1XJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755788986; x=1756393786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nvYZ3xwBzsmY6VteFa6Rk8Li/fQk5rtNPNaSWCyz9bY=;
        b=E4tLch7GZ3KFlZ29C87196vSoW91q16WhwJOm2HlIpY0QtvpznvpX4GVv5iEKGAwFf
         qLsI3yWtrpYbAIUYiN2vGdVdELb4ED/C1FE3Kc5MO5+LPeC9HXo19rZ8o9eEIIIOXAwm
         flU9K35lyHblbRQ3mwDdQtQMEd61zkJ1hUWC+gkvr0FiLwbYEkUg80hVYArXFjWVREH6
         s8kxIjZR4chlUPN9SeK+7cPv6VdWVh/9G52DSCteo5XZTYh98i5TU9VRh+RN7KO3jiBr
         U5k5xq3/aYRRb/yF2BorK6xUk/HgmK8nsKLNGDUJSNFzvHhA8qantzx3Fmsy68qJJVvE
         4ZrA==
X-Forwarded-Encrypted: i=1; AJvYcCVlMUL64zVOrl0fz0VT3WRVIbJ5Lg2MDo2zO5u4IUowrEvWb8IigVtrK87vqzUblGhMzsNEBZAZZpfxSiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQuEMBSnF4B/YIBZ9NMo+NBgATHfyLhx4dUvqzpmnAo/v/Fqe1
	FhSxjcifNxq1x7xGEeCflW1nuqq27MYNkXhiKhqA8zTM489behMhh2CjSrx4+oIub6w=
X-Gm-Gg: ASbGnctD3SqpHqtT37RfbAuokNWDYKaT763AkrAKVqux3dWu8SWBqZFjeub+xY33rnk
	SvnXeMR+uwbL9PPfQdgNhT8/uJRgo5/58clMnVgf4zX55/Ys5RRPMQ/zrQ4JSRQmuUYkKY9mMP9
	YN+4Bju6othi9WrG2KymBTBKGavwRydrzow63MehGCNY6gR3YvIKWEjNzaR3mGz8ikcGnsUlGj7
	ZZ0Xxa+Ry8mN2nGcHrv7fSlU2R7ntongch6P/V+ujrH/j1zR1jOVijH/XrX5fmvP0cSTUafcYCC
	jcYhuWBq07U8MOJEsdFpD5t/21sDdaRfqytG6N06eQwl9bcReQCtygg9Ec0g8pcP5h0vawVZ//z
	K3D4g9uSQGQqyOK+dmREC3MUmyzxF6Y5JonBBvw==
X-Google-Smtp-Source: AGHT+IGVtZqbXTtQtenHmUQZI/jmmKnotmOHRL/ZFHYy98fCdCtX+MWXTkJBHoo1hchd5d2SGjt08A==
X-Received: by 2002:a05:6214:509e:b0:709:de23:aacf with SMTP id 6a1803df08f44-70d88e8f53bmr32501656d6.23.1755788975417;
        Thu, 21 Aug 2025 08:09:35 -0700 (PDT)
Received: from ethanf.zetier.com ([65.222.209.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70d8b0e3e6dsm10845676d6.73.2025.08.21.08.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 08:09:34 -0700 (PDT)
From: Ethan Ferguson <ethan.ferguson@zetier.com>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com,
	yuezhang.mo@sony.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Ferguson <ethan.ferguson@zetier.com>
Subject: [PATCH v3 0/1] exfat: Add support for FS_IOC_{GET,SET}FSLABEL
Date: Thu, 21 Aug 2025 11:09:25 -0400
Message-Id: <20250821150926.1025302-1-ethan.ferguson@zetier.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for reading / writing to the exfat volume label from the
FS_IOC_GETFSLABEL and FS_IOC_SETFSLABEL ioctls.

Implemented in similar ways to other fs drivers, namely btrfs and ext4,
where the ioctls are performed on file inodes.

NOTE: I have not implemented allocating a new cluster in this patch.
This is because I am having trouble with using exfat_alloc_cluster.
I have submitted this patch so that while I debug this error, I can
receive comments on the rest of my changes. Any pointers in the right
direction would be appreciated!

v3:
Add lazy-loading of volume label into superblock.
Use better UTF-16 conversions to detect invalid characters.
If no volume label entry exists, overwrite a deleted dentry,
or create a new dentry if the cluster has space.
v2:
Fix endianness conversion as reported by kernel test robot
Link: https://lore.kernel.org/all/20250817003046.313497-1-ethan.ferguson@zetier.com/
v1:
Link: https://lore.kernel.org/all/20250815171056.103751-1-ethan.ferguson@zetier.com/

Ethan Ferguson (1):
  exfat: Add support for FS_IOC_{GET,SET}FSLABEL

 fs/exfat/exfat_fs.h  |   3 +
 fs/exfat/exfat_raw.h |   6 ++
 fs/exfat/file.c      |  78 ++++++++++++++++++
 fs/exfat/super.c     | 190 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 277 insertions(+)

-- 
2.34.1



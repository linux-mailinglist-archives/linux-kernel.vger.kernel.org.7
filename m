Return-Path: <linux-kernel+bounces-830934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 162BDB9AF14
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 18:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1E2717114F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F68314A8F;
	Wed, 24 Sep 2025 16:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikslOSKX"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BBC3148DD
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758733114; cv=none; b=Fcg5obnzLgYfmVJUrN9W3pyk7Sh3WgdWkKRKJ2kG7QaFJJzXoWXcn9Ty8hgRoV0WtZLkN66eJT9sPZcwm/Ga12ZTqn2SXY7pVe3yrlpGoyMFVBbYukp0DkAlyJxsiX+nP1crdDrI2zc8ejwpNK+Crm/qRiQJhyUxLb28GErw0mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758733114; c=relaxed/simple;
	bh=2HMOyoB1zdsMaOjuaw59c8qho+a5Jwog7IztYjSvDgY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lLoy3qcyxYWN08nhk5GZEFfMJuke7HhI70x755epFJRHxxQMSV4bXNpQnCi863mj5Sp81vBArgqKGKQV4aUR/ipoCz3Vx88XfnSFi3WZ5lRceZ1TNKK5g1Oy5Gj39gYhPHpu8Rq1GeCEaZlI6hh6oZkMr2buqopbyTHCdSP4qnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ikslOSKX; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-61feb87fe26so9266634a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 09:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758733110; x=1759337910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fhxhXtqktHcioL92cLF4a3/2LgXkVdX5qcYz1AChCIQ=;
        b=ikslOSKXWb7T2Lx9U0kBdiD5WdPlvJMsy23Aknp+NSveACZjMQ5r/tlO9jjgKF+SWv
         6EbSMTrZ2oiNW1do6wp40ydKiaTvHCTsm+NBMG3RJkr8szJETY0OvFpUx/Gi6JthJ7FM
         3jOXGK3QrFEg+KsApYrY5gSTvBRumO1r9u0rzQ/yvJTcQgirxqGemWq9hTR0qOsCnlRK
         WmxCUlH0bvFtp1csGyFhgtDGwX/GguRDTbLt5KDPOgKVjrFoQMQ2d4BKOkrRFYJ0dK1C
         qiRz+RrKoLaGgOWR/WNgr1kz3fPo4liK0yDUFuMLDUyFQu879GXkZ9wl0yiu6RG8TTqN
         OJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758733110; x=1759337910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fhxhXtqktHcioL92cLF4a3/2LgXkVdX5qcYz1AChCIQ=;
        b=i4Qalyrt44Pl6I0jriSzV3vzjSqZ4d74G9RH3YSbgEBFIg9+p4l0noGDWS4KpQCs7O
         y6CMo2H3hfagukzdVLZ0Mc786e7deJcpvMcrUOI5QjSUdYI2fRo5irT2iOZNJUnl0f+q
         RfgSPbQ6hQOYu9XathqZnicScBd8P2w7m6hBKmCW30EChrja0hqVvQ4IPPt/vEmYGb1B
         lx79Sk51n7a8V6jXz6TUJR4ulEjBQ0Mq5nycK6pTtr61erNYn8B1VBrYQDhxG3Bfy5li
         tDHRQozZAJXWzpPFKBVyLFiBFwg+DJ1/mECyCrsGyMu0Y7rZlYM+6lfnmScat2PAPwjF
         Kqwg==
X-Forwarded-Encrypted: i=1; AJvYcCUGj6IeWsCK68ZpKipBrOFD1sAMf+BRdrVXHKvxiT7bv3yZHEA08c1nz41d14ckNUSSNdf0MPOz3IRvBoc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu3UMmw1QwhaQ3NurW+AIPjY403m/4vovUztjHdbdt9pZk7sLs
	pfeAafFTuM0OxLwK4tUHqvZtaIdxu5pF3x1zH4GEp034DYI68zPrAxQA
X-Gm-Gg: ASbGncuqUkw8iuf/XGoTR3fDg6Z4mhkUY520D19fiSrgI1z/qv2kc6EoW3s3JWbx3M4
	q76hOo5C04uBffsO1GA+XscD6Np4PO5XPYtAYFGALXCpWgUM6zG5xaU9GbgtAeAc4fV45B8U8/d
	4rQ9zoO4HQDxxzzhIEI9FFCMmn+TkCBOcEciWc5s+3bAWyNpuQSaWaymPwyRMsUbGm0J298OvCj
	TPWGlIBv8Plwz1Qal8lCQPYX2SmDh6W9PJg5KnMDFmtmK0etwnLbrh/3jST8UcWCYlTzLJjXwy4
	ZKgMXx+wdlNJBXQhuZ1KXwMS7JkRv3w8tqrfT8wBFQ0Sw5fU6tCExT027y3mRmpRAR2fFJaizno
	Hd9UM45eTN3ujpRDiL0aV/MnPRJB3iD4L99oJYFHDG7NTfprh9eDfiZyw95mIcF2BEEEJ1Xr91p
	n1bJ6j9g==
X-Google-Smtp-Source: AGHT+IHc0IHg50HF9lykmrkaQ/1sP3tnQTdw05PnGmQL20/LTTIZFvq6gMv2fB5YlFPC46sPAXgG8A==
X-Received: by 2002:a05:6402:4412:b0:631:6713:3ac2 with SMTP id 4fb4d7f45d1cf-6349fabb58bmr111654a12.38.1758733109399;
        Wed, 24 Sep 2025 09:58:29 -0700 (PDT)
Received: from alessandro-pc.station (net-2-37-207-41.cust.vodafonedsl.it. [2.37.207.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62fa5cfa60dsm13172236a12.4.2025.09.24.09.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 09:58:29 -0700 (PDT)
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
To: jgg@ziepe.ca,
	kevin.tian@intel.com,
	shuah@kernel.org
Cc: Alessandro Zanni <alessandro.zanni87@gmail.com>,
	iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] Fix to avoid the usage of the `res` variable uninitialized in the following macro expansions.
Date: Wed, 24 Sep 2025 18:57:59 +0200
Message-ID: <20250924165801.49523-1-alessandro.zanni87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

It solves the following warning:
In function ‘iommufd_viommu_vdevice_alloc’,
  inlined from ‘wrapper_iommufd_viommu_vdevice_alloc’ at
iommufd.c:2889:1:
../kselftest_harness.h:760:12: warning: ‘ret’ may be used uninitialized
[-Wmaybe-uninitialized]
  760 |   if (!(__exp _t __seen)) { \
      |      ^
../kselftest_harness.h:513:9: note: in expansion of macro ‘__EXPECT’
  513 |   __EXPECT(expected, #expected, seen, #seen, ==, 1)
      |   ^~~~~~~~
iommufd_utils.h:1057:9: note: in expansion of macro ‘ASSERT_EQ’
 1057 |   ASSERT_EQ(0, _test_cmd_trigger_vevents(self->fd, dev_id,
nvevents))
      |   ^~~~~~~~~
iommufd.c:2924:17: note: in expansion of macro
‘test_cmd_trigger_vevents’
 2924 |   test_cmd_trigger_vevents(dev_id, 3);
      |   ^~~~~~~~~~~~~~~~~~~~~~~~

The issue can be reproduced, building the tests, with the command:
make -C tools/testing/selftests TARGETS=iommu

Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
---
 tools/testing/selftests/iommu/iommufd_utils.h | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 3c3e08b8c90e..772ca1db6e59 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -1042,15 +1042,13 @@ static int _test_cmd_trigger_vevents(int fd, __u32 dev_id, __u32 nvevents)
 			.dev_id = dev_id,
 		},
 	};
-	int ret;
 
 	while (nvevents--) {
-		ret = ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_TRIGGER_VEVENT),
-			    &trigger_vevent_cmd);
-		if (ret < 0)
+		if (!ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_TRIGGER_VEVENT),
+			    &trigger_vevent_cmd))
 			return -1;
 	}
-	return ret;
+	return 0;
 }
 
 #define test_cmd_trigger_vevents(dev_id, nvevents) \
-- 
2.43.0



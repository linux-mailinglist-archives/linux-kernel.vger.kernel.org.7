Return-Path: <linux-kernel+bounces-830957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4D1B9AFF5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 19:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D4934C5BFA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C884314B78;
	Wed, 24 Sep 2025 17:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRIlPEc7"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7F9314B71
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758734200; cv=none; b=TWa2sBQmSQYPDnbfrqR7rJTJrU9Y/k76+VX8YCWTdZuK/Jt7Rf3NwUE4gk2zDGaNAcS6wkCKbvy53hQQNpGESLjGrJaVufKBm6Jv2NiLVMQvo6Kt72A7OX9YmIL5C+VPAzIV9JLwZKyYFWKAoOwSnfrG+xrdcPSDsTqR7i0m/m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758734200; c=relaxed/simple;
	bh=hsA5j6mN1Ho29wv3TqcaUo95fVf6ZgIDjmYFb88klhE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nZIXBvvAo6Ia6XrBqqGtsAGCQLAL18KQFRC/q8smKV+NgmsMgvnGr9q7pliXbeFNMQvCMnhQ2UkKPxgF//vJ9xb33J1LUf0WDhhg++VdPZL3hNgai8jhY+aT9OUqCEgCjQHqFKi/vxh7aQeP1vZk+XQUsUJHIpaHf+u5GxZE4vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRIlPEc7; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-63163a6556bso22021a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758734196; x=1759338996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aNxQWNsaNzm07NK0oI4QfKW+i7h07TGqHOD9HRkHR7U=;
        b=WRIlPEc7bya2iEY7a0uEEWrpqlt4AHc97i+PMV94TrFREKzT10x1y1q6Cd3kz9JOF3
         +mJKubZddUAREsEI31FQJQjBm5IinpXXOwsyEszQMiQESSaHVo9YDpcSCZXNdP0dSCug
         MjXgScHrdMX7F/HTLxqutGdp55YzR6zWnHATYXyvo1AZbNk0sHlyilqgvlrvbLf8/COv
         ZnDahaL8Yffw2CksNPluQO24ZsrrmLP2/npcrjjFxXNblcbJjGx0IvJlXWyphb/aUcIc
         G+hPNOlPs7s8drZyLqNRyIOEejjQmQss0Wogi88zO/fPfV6GTeCuGnBbH5kvxU9aMaZl
         daPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758734196; x=1759338996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aNxQWNsaNzm07NK0oI4QfKW+i7h07TGqHOD9HRkHR7U=;
        b=BkeMEfxDVsH7dnSH2LPanzI8X5ww20nnSEb+Bi1TyFPYlpvjikrb+L3hBiC8ozi5Em
         5AGxbZvv4Gj9J4okjfQ1f8+nh7lp4p3hHUqJ7ZDuW0gGmgc7yfAgQjKyFPuPvwFpaut4
         AVJftD0BUSZPVU4wFOm/P27MNUcftiGWtXac4zyDcsYfHx/qPFnpB2L857EF2N2cgLWA
         N9s8rRrsVy+8je9SyyPfDgKGpOd7IDOH7QMipmtPSWWUoHH0+JECYJm0mJmuBlApiMaK
         kr/Xo+H7UkM1cjHWTX0EO8JREMdFQ3MjrgRS8cRrOh+ZiC8sReX/2wWDKzcJK2vzLKjU
         XwIg==
X-Forwarded-Encrypted: i=1; AJvYcCVV73PBbUzb3DtLFNY5KIZe2WJRDKoUZjJgaK6z3iahAXYgFCZYwGQwh8BKbXvKsz2ai3cw2fw53vmz7cM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA1N6Aif7bWNVVOAsqTAQVGY530+UENU5rJxQfVi4PP1UHCtlM
	M730ovJiziLtbJ2j6gWpcxaKH5CvSQx0EwNTLLDVfeJHLyj95GOYNdPLUa57ityBRmU=
X-Gm-Gg: ASbGncuxrejQzrj70gdxW1QROnBjfBUzUDlRxItWRtJ19SJA66SK/0DuTgv/l88Q3mx
	QhVBXXwLznqwMSCm3Xi+1GhD96WagmsRffY0XBpiDClLzRUlrxBhNoqSP3pJmNMYdPBmERavnBp
	N//fdI/kEc+NvsC/jfULgHuADKvfq7HL7JCgNDRXmONGfK6atTyZXgM9bVe2kvEFZc+TiRoG7O5
	8LliNPeMn1dPlYYuqPqesMdTj3aokaT/cEITvOwocAJdlDNfKhtC2e19Nwqfzuky8FjFuKC/9gQ
	CrmdINdzLdszX7KZ2ONd0yH0mbuS/O/deQd/EmzWEbtZPhxz+8UteWqiRFzSvuFCrhcJ0UgReOy
	KUQNi+c2f6ipEyKr5ZWGuxdz8H0Vhs1ds2QMWMQg3W8ZEVCyjU00BttlckvPJEcjAXK/GXss0yV
	nYhDGcvg==
X-Google-Smtp-Source: AGHT+IGTRCVL+Vy3tfNF1MUEnXBCXWeb5Jrz0wQXqG7fNQTDEE2vWKNUIlbHrYap21jasTSQYR4WgQ==
X-Received: by 2002:a05:6402:160c:b0:62f:41d3:ece7 with SMTP id 4fb4d7f45d1cf-6349fa1b9a4mr208376a12.14.1758734196429;
        Wed, 24 Sep 2025 10:16:36 -0700 (PDT)
Received: from alessandro-pc.station (net-2-37-207-41.cust.vodafonedsl.it. [2.37.207.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62fa5d4357esm13318691a12.23.2025.09.24.10.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 10:16:36 -0700 (PDT)
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
To: jgg@ziepe.ca,
	kevin.tian@intel.com,
	shuah@kernel.org
Cc: Alessandro Zanni <alessandro.zanni87@gmail.com>,
	iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftests/iommu: prevent use of uninitialized variable
Date: Wed, 24 Sep 2025 19:16:28 +0200
Message-ID: <20250924171629.50266-1-alessandro.zanni87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix to avoid the usage of the `res` variable uninitialized in the
following macro expansions.

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



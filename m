Return-Path: <linux-kernel+bounces-829189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C886B967B9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 595843AF954
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D932561AB;
	Tue, 23 Sep 2025 15:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzhgyLeb"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C569F24635E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 15:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758639685; cv=none; b=arp7hnVmJ6rXsLZ4uTsMA/3ma/z6j1UWXxxxv5Qac4h6owVrG6mXjGPWxe4Be5h5zbyr+r10597iuJcg/szbtM8ZY+UGV6HTXwTa6721egM9DqILXVjHUQpO6nk2N7uMRBYalUhOmcvuuyKnb6qd3/Gz0MXTeJgmh5aMEmORvjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758639685; c=relaxed/simple;
	bh=jtgAPbRC64BilnnjInFYbI1iljXOGGsr+cEZ9zamqj8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oIa+gguTitNI9XBbLymgxy+9s0BeSiL2TXTXkK/14FPbq5cdXL0ZsV7mOE8Q8K+jt6ZfR8sRENOT4mhtvFwZWrfoVTkisTwo7leuy7r7JjUFjxwYetXKRtju9ogEUpehBDVRQxPH3SxJGT6xjSIy8NuOQoDcB75OvV07J5FWS8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzhgyLeb; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-63053019880so6165318a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 08:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758639682; x=1759244482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/FVP7DhJGj/Y7czW4fXk9UCowjLbsO5dman73jLjS9Q=;
        b=bzhgyLeblMuUqOm8Juf9/87Dslg6nbVzqsKtDmfHtyFftUCbVVWMP7XjiqwLP6q5Xa
         BZACKyws3pSqt9fRCfCjeGhX8KMDGSkJ2Vkn02RO1PtdgysZb7n3wxKCqqkpxDd7k+1G
         oALhqmrQ3yToyKBfJ0tQAAd80TN/vwgqu3pNMhZ1Rzv7I2IDoSL84aKehSx1d/mRyOWt
         HBByb395QgJ4pijDRn5zzYDj2L1ZQmNSYA8TyYThBJMcR48HUeCRfWTJYvQH87nEuvQ/
         xGs6l3+6jWOjerHJq5E/1CW4fPb1r7IkD0ebUG+wuEEuaN4QLBp6ON0aHdC7+hcu0BiK
         KhLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758639682; x=1759244482;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/FVP7DhJGj/Y7czW4fXk9UCowjLbsO5dman73jLjS9Q=;
        b=fxWJx8ReqIi1PlIvRIOxrJadVLRN/KrpMzpNMF/SYTS5FixlHTSkNIDyolKtWad7f3
         DxA8bB74ljHEHgxFqcVb/P4B37C3GlihBNKFIBMrg/lbXK/IHk0774j/NhlcCLcBj6CI
         u0v+z4R/7VS8to7oWn5XS9r6vRk6yRTEyLwTXJAU8qvg7fDZTelCQIoa21XldYKYoMpc
         VsywMdohWdVE3AEocsa0kBVv8YOq229uDb2qErVxIZzjis2l2I5DT3C3BmaRkhLSxEI2
         YoK1xvBzv8o7mmK+SGTmuNOoeaduM1kMPliaQLLU4IYyEE+JBU1zTJCSwsG1Oh1V5WCO
         aMZA==
X-Forwarded-Encrypted: i=1; AJvYcCUhobUWCl3H+KoE8fqyIwQxIVm//Ykb6a2TrGNUAYcTxOf9JIWy3AdJckV42dAIsQ5rJV/8/hJ7E4A+lzk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs9eSz0nuMzxxO/ok6Mc0dpd5s5nuCAdigbCyPUYprB6DeGZEi
	ZbAyxwHi8efgif7P98qiY/pOCU8lnKLztAWmbUAiS69MUUNlI1Odmoia
X-Gm-Gg: ASbGnctCju4eQLqvH5oi3HsfxIzGrn+kF3OUGW+2ZDZRCr/zjuNlk1iApZehT7qycoF
	Nn6Th25IDrnTeKDuqx/+/NuFDpTI5liLc/u3gDfurxz+hU8t/3HAuyGhla3a+kPExBMSwUrdPYZ
	JPJ5P+jm1Pb8n/t7FpeXt7kxQ1nL/lmDMvDnFxHK/a+mBhj21E5wS/BtzknyIgQ0DSpjoHNfYGm
	Dw3D2IDbhxc7nPTv0Knr7jjtxtIwq7jbS6jWLBi0dGAU5iUflFODVj8ImgDULSN88iky6qqybMi
	vbjNhSFVlI6FYw3VW1MFXNAWxjOyaWZ3Pe+7wOhK2AldnxeupTUZX9FPGQqGs6Qnshdqn1bZpND
	jkwdlooM0SvvP2wC9r2wRm/PkpJvXfiTJP53Ixg2Ya8GI0GTyOWbkaiBAXK+mcsWA4bo6nTAz5C
	etiNDnSg==
X-Google-Smtp-Source: AGHT+IGTNS722I7OANZxiBMclWCKztu0Pg51a2Ss6XlfTfx7tF/PJx0HR5RKBr5uLe6oVYuyIBPe6w==
X-Received: by 2002:a17:907:724c:b0:b28:b057:3958 with SMTP id a640c23a62f3a-b302c6ea7b9mr295681066b.48.1758639681727;
        Tue, 23 Sep 2025 08:01:21 -0700 (PDT)
Received: from alessandro-pc.station (net-2-37-207-41.cust.vodafonedsl.it. [2.37.207.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b2761cb52a2sm899719066b.53.2025.09.23.08.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 08:01:20 -0700 (PDT)
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
To: jgg@ziepe.ca,
	kevin.tian@intel.com,
	shuah@kernel.org
Cc: Alessandro Zanni <alessandro.zanni87@gmail.com>,
	iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/iommu: prevent use of uninitialized variable
Date: Tue, 23 Sep 2025 17:01:06 +0200
Message-ID: <20250923150108.34309-1-alessandro.zanni87@gmail.com>
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
 tools/testing/selftests/iommu/iommufd_utils.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 3c3e08b8c90e..4ae0fcc4f871 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -1042,7 +1042,7 @@ static int _test_cmd_trigger_vevents(int fd, __u32 dev_id, __u32 nvevents)
 			.dev_id = dev_id,
 		},
 	};
-	int ret;
+	int ret = 0;
 
 	while (nvevents--) {
 		ret = ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_TRIGGER_VEVENT),
-- 
2.43.0



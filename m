Return-Path: <linux-kernel+bounces-857752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD75BE7D99
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7835034B7D1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 09:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8AA2040B6;
	Fri, 17 Oct 2025 09:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCOAuiz7"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B4A221F03
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760694199; cv=none; b=HBr6jmqXUbw3vKjczYte2G/USybupsXQBnpe3BT8XiSrfyR8rh/tREhaFPXUOEbt/qPTGRHzRXzuaYdH8Yq3X3qMc/dd7Kg2RKHLSCFzNzWkN1uiYvmjX13PNTag6JCxIYQQ1CP4Yf7YPS4/9EKAvuVkNaYiEYw/qpkpT/pZNrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760694199; c=relaxed/simple;
	bh=/M7Bnm3gjioI+Av04wQGAmQfU91Qw7IuTFIH55BhMAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bpq8n2YAyn9NkPb1V22hSEud4abtslimUJSa5mhwW1yUhtbpo3NPKNbjKE1yKiNEruF75bgSFzx7ckd8wCN9YElFSzWqtM5NpawfYXJIyJ0I4Uhjp80zNjY6VDFBaAPSdof7iZ/AlyemYV6LayWM+uRtOH7IVNe8nmxWLUd2a+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WCOAuiz7; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7835321bc98so1665487b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 02:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760694197; x=1761298997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DK/268SDlKo91KyuWt/Uk0juTRvqRZCB2PBwlunHbIo=;
        b=WCOAuiz7eBnx9liP4aTDwjkG2Mbof5u+glrDE8WoccMy24LBTe2MOqc/TYIpUI/RJp
         SfMaGMcSsaXofJKnCxrzJO/QUw4uNBETGUZIbi2kPXCPadVbC9Qh2pEspOcfqJLJYMuA
         GGcR9tR6M9ORr6My8TjWU0yWH/WqgRQK4D4efcMKPGA8g1a8tm56wM2yT65ZTCJDgJdH
         SUfdpb+yNE6psxjM0+DzXa34Ytqw/4Qpffs9csqS2T9j5e0TwmxFl4rTu4gAZQjHQxKr
         PXCqAGlpNPSr8KjfY2m1laiLRj0QfpoavaJgjD6w4x2g6b8h5aXcV+bhXKLyd88YQx8O
         YzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760694197; x=1761298997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DK/268SDlKo91KyuWt/Uk0juTRvqRZCB2PBwlunHbIo=;
        b=CzBF0l8RAQYtzvPFHZzAngLnTX2q2BAhMzFjEkkyaJgzyiA7JVEcg3+6A2hDMSwUvt
         CoZGnKh4do5sib/vyUd4GB5KYtelCX1+UObibAkcJ+uzF0AfhZJC2JTkXjnVcCPa4pB9
         EiAeFhaY0qEAVCFYqu8zbN1dcVhLDgtVg2wafsLCwUwKmbWspj1Q2bRz3euDTRresSXH
         XgkRHTpf9JFhhvqYRx3CYH8InTEFZoc2HfyGOdfNdsuTOiFBqjZjsiHwWIe8cZzgnozE
         IGeVwh8XV3Q16YFu5ZWtK7ZVPE2lqvLIPuy3VQr/JdcFNgB6Yl2fuX2fpgC5W428LHHw
         5b3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUk7w/kHZ4mJLcejjk5w9DBEv4n8hZjNAikwfeIzgVR6fOfr4IUCGYtklxPz+Os93wPQjbDpNf9HArd0fY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3Y6OA6SWggYVPm5t+KCx6+ES2sS9QIjtxZWHBCHhivNUC0uH1
	6Y1AVUt/onLrFfM2WUcrniZePC+qjCGO8OShVIqH88qSsGdnd11IkgYr
X-Gm-Gg: ASbGncvoPC36uqX3iVajURD66KHjUmQFKzJXI+57rfVRqoW19a073tYS+XlQJ0yhqnp
	59WDk8Xt5mTzlAxmHDgNeukFu4DC6W5i/Uvv2GtFWyITSGSm4cz6xUKROqcf5w71lP6YRlhDeXv
	ePqNwBI3Khu71NL6KPxE96FrO9F85q8YXQiHkoceQ0BWIg1UtP+Mnz40plwnzhDt2gls5MqCPPo
	ZcCi1/fVCo8ASa3UiDMDIrStp4Nvj2BtKix8zrFa8oucruKIS5O41bopgw6gssB7ETsuHC6LNco
	OtA/JYszEtgtzLH9MRuhBJ4R2gsaPNeRPFncdv7u3X1TePXK29g5Epwrwwp9DBVDYSlsQWJNNmf
	+osnu+l6j+FKjBYoXn52vJCCj1IjhnJXoHuwJVKxWrJpKJ+YABMGpH7Ib+N8fjG+/DIf8ewy6LB
	uNeS+1CRk3kQ==
X-Google-Smtp-Source: AGHT+IHVk1UlLvUv11fCrAvl7GZkv39UL14NzeVw04C1QLEJi71IrKA1z/tBFl1eYTam3trbIvNwag==
X-Received: by 2002:a05:6a20:3d84:b0:2b3:4f2a:d2e9 with SMTP id adf61e73a8af0-334a8515183mr3683681637.9.1760694197461;
        Fri, 17 Oct 2025 02:43:17 -0700 (PDT)
Received: from server.. ([103.251.57.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a1394139c8sm9963789b3a.18.2025.10.17.02.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 02:43:17 -0700 (PDT)
From: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	richard.weiyang@gmail.com,
	lkp@intel.com,
	reddybalavignesh9979@gmail.com,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH] samples/vfs: add selftests include path for kselftest.h
Date: Fri, 17 Oct 2025 14:32:01 +0530
Message-ID: <20251017090201.317521-1-reddybalavignesh9979@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016104409.68985-1-reddybalavignesh9979@gmail.com>
References: <20251016104409.68985-1-reddybalavignesh9979@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test-list-all-mounts sample includes pidfd.h from selftests,
which now uses the centralized kselftest.h include after the
previous change. Add the selftests directory to the include path
so the build can find kselftest.h

This fixes a build error reported by the kernel test robot.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202510171513.6IWk005g-lkp@intel.com/

Signed-off-by: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
---
 samples/vfs/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/samples/vfs/Makefile b/samples/vfs/Makefile
index 6554b73a75c8..9256ca5d762b 100644
--- a/samples/vfs/Makefile
+++ b/samples/vfs/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 userprogs-always-y += test-fsmount test-statx mountinfo test-list-all-mounts
 
+userccflags += -I $(srctree)/tools/testing/selftests/
 userccflags += -I usr/include
-- 
2.43.0



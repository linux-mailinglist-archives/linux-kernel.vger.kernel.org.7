Return-Path: <linux-kernel+bounces-898007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AED3C541A4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 20:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 97AEC4E2C6B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 19:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752A634CFD7;
	Wed, 12 Nov 2025 19:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1+npGwQ3"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47846337BA6
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 19:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762975367; cv=none; b=fkVlwyf96y5doeaaAMGfuhtlehjNKCJwzzogURzPvj8Btzo7r6obdctdX8344qVooWB8tgRD8daYvxlZnovGn/7xPpZ3nMngrY/b6xqj/6GgIxZ4XKx8taChudclEr7r7dH8V/OgBhOM4gHikdqNWmO1jhlKlWEyiuyJIq1dOrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762975367; c=relaxed/simple;
	bh=kHKKv2ke2cj+MGan48Gu3BEFyapAdjSg49umcHRC9vA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EBbr8S8gJh7sdrUEqGm/IhVxEfDgVQviR6yAVlmt+FEh+SHyV3SwDBSEwlMy69cfn5fGpglhL0w8lGAdFsm4TU9qcnl9UCEU3Y6pCLWDay//TjjDUB4QoTk/b14jgH3gxAhOXrsXTfzKipsZh8N1aRnE/mypYLWEA4igJYfy1lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1+npGwQ3; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7b89ee2c1a4so480467b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762975366; x=1763580166; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TielaAcMwqrNYs1v2uchxf5jnX6Kggt/DIe0BV32lMw=;
        b=1+npGwQ39fbkIxeyi70rwjdIW6YuVJ/TvnGB2ZvWcqDloF97am3ND3zhD6X4n846ts
         ES6MRkQ6f6cfRGjT9Wqxrv/LrzqonTqCDcvFIJsgjN29Ybj46+3lzOX4C96fcFjbSza7
         zZogztmU2ZiC+qbS/2LhNdOxqcio6Q0FX+F0oLaIKCQL83UO4IfoutkAV0A0mpHPl5N+
         cSviXL7PcbLY0A3LckD7UNul+lFiNha44Gw45LfhcC+jCcbIrlTmHQTz5vXVjArWk+r2
         4/K/v93juaGbhbWnABn32ftnRAFTEXLIZzg0bOECh13hvFiT9JVAuovufefQTBPvwbHx
         w05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762975366; x=1763580166;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TielaAcMwqrNYs1v2uchxf5jnX6Kggt/DIe0BV32lMw=;
        b=X73HdFkDveWSh2vkRbXwLZ3OCEBSICAn5oJ9rI6l39e3rEakmtEQMmhTFknszntryI
         vGGh6C3IxlMjuQ8x7OIamUbfMRkb1g4L3T9Bde2/9MwguwBQ9yasxz7T4i7jhQ4SHBEq
         WU856Lu0JzIiyn5J8rMzQVGrV2UN/fdTjXScYg/9h+hSXeqmaQSuvaQLjzfSPtimDB25
         w3hAmul4SvddrTAyvMKW1bZg2M4FE0RIVM7hcRuajCEFyAhE842Qu+jkQaiaP27psjQW
         +97HwumSJfF9aMPY/3LJl1GFSawWhiMeg1ZZXT8UvK+ryJvyCIxhXR4Dn/PAFuoYmYd8
         Tqeg==
X-Forwarded-Encrypted: i=1; AJvYcCWHjwJTdIk4pBM0oiGJnrtoT2AlA3K+j6W/IW3D9z2ZLRmwKlrlbdfc58nJ6QH1MMT03TcKkSqAFkPbY4U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye2RjxIWG22+LKjX7YzI/YxRgJBCORykeL+r+bkio6OlY+ixzC
	GVXGqPYKWD9G93UZoLd+3zyXkvtOowYXKirc3NaHmgpS6eis2iEasfSFYfwl3AThyaqgAwcG170
	BF2wG8hj6687uwg==
X-Google-Smtp-Source: AGHT+IHuFbrloR0m5blvPVZxF8h+Pqt2VSx6nAyL8MWcwWU6Pe/6lCA8dytMd0H7li6ZJ6bRtnj5aFgRaaAlPQ==
X-Received: from pfbbx6.prod.google.com ([2002:a05:6a00:4286:b0:793:b157:af49])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:a109:b0:350:8dd9:7a90 with SMTP id adf61e73a8af0-3590ba1908cmr5304730637.43.1762975365575;
 Wed, 12 Nov 2025 11:22:45 -0800 (PST)
Date: Wed, 12 Nov 2025 19:22:15 +0000
In-Reply-To: <20251112192232.442761-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251112192232.442761-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251112192232.442761-2-dmatlack@google.com>
Subject: [PATCH v2 01/18] vfio: selftests: Move run.sh into scripts directory
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Alex Mastro <amastro@fb.com>, Alex Williamson <alex@shazbot.org>, 
	David Matlack <dmatlack@google.com>, Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Raghavendra Rao Ananta <rananta@google.com>, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Move run.sh in a new sub-directory scripts/. This directory will be used
to house various helper scripts to be used by humans and automation for
running VFIO selftests.

No functional change intended.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/Makefile             | 2 +-
 tools/testing/selftests/vfio/{ => scripts}/run.sh | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename tools/testing/selftests/vfio/{ => scripts}/run.sh (100%)

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 324ba0175a33..155b5ecca6a9 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -3,7 +3,7 @@ TEST_GEN_PROGS += vfio_dma_mapping_test
 TEST_GEN_PROGS += vfio_iommufd_setup_test
 TEST_GEN_PROGS += vfio_pci_device_test
 TEST_GEN_PROGS += vfio_pci_driver_test
-TEST_PROGS_EXTENDED := run.sh
+TEST_PROGS_EXTENDED := scripts/run.sh
 include ../lib.mk
 include lib/libvfio.mk
 
diff --git a/tools/testing/selftests/vfio/run.sh b/tools/testing/selftests/vfio/scripts/run.sh
similarity index 100%
rename from tools/testing/selftests/vfio/run.sh
rename to tools/testing/selftests/vfio/scripts/run.sh
-- 
2.52.0.rc1.455.g30608eb744-goog



Return-Path: <linux-kernel+bounces-754213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E272AB18FCA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 21:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D0EE7A8385
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 19:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932AE259C80;
	Sat,  2 Aug 2025 19:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="FKcVqLal"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F442594B4
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 19:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754162766; cv=none; b=jP/9yPafcK24iciQBBi/QY5YvKz0RcmcY/sqSML4Xfc9CEgSrsQg8BhUUUWmBib0tdlaJQcSvV4Jbakx6YPvgmpAWr2Gvj21SLJuXxEsjgaeI4Pu7MtWiPzBP+3rISYYlC2lTI7a96pvmqdebOjpnQxHigFls/dUCUBplFwqOzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754162766; c=relaxed/simple;
	bh=z+5KRxYc5UqnilO3In24UU4dyirhMN0G97cy/9xmtoA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bL5nysqLphfSpNjEpnPRcR4j2h7wtvUhYASsK54JgIheYNS0n89OPBIXgUk02qmq/ajTWwlV1VyubbjxVtmtAFVB83LPzse6Sa45Eb+8wpoLnH3N/9O1KX7LIsuE1rVxSg89TO3DmQojpOSf//FXpwxqfZnfbc54zKli4KtKPs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=FKcVqLal; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b2c4e46a89fso2230963a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 12:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1754162764; x=1754767564; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CaTaCEwiy5ye/b7edAgdJni69arTuyowWyDQz6ouBQQ=;
        b=FKcVqLalmrFx0DOBenkqo/bUPXf0IJ9htT6fCzMeUW3+S8+PC/j9AB1dAjqf4QR7Ru
         QNd7mqgel0qP823E6nSKu5HmnEcKCj2ecX85RHHkzyHgu6s7u3IVWj/DXfWYoWDRoNHo
         gV6ICkraHhRQEPyFwJ20SVxwLo2jeiutLZc1NCNWrY4YCdG4IoOQxRj685vcZy86/lUR
         A11rpUT6cArVcPl2dXoAzwkYWBUbsoTfQYzPfG8f/lbOMDov7wg0XZ5oA6JghQ4aicxH
         3rmV1zl5dcx76fyGMECIKWZMiH87C4y3bIcuRCHGWl3hF0Htd/SEsjBqgcp22ej0RVF1
         UoZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754162764; x=1754767564;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CaTaCEwiy5ye/b7edAgdJni69arTuyowWyDQz6ouBQQ=;
        b=qwefOBQnMpWwayZHJ2kfDO/d+cEEN8vjnPM77ecbYVhcYyaHmluBXmHri34LcmwweJ
         rvrUefBOxTkWzyk4FugT4hMQMe4e81vC12aRhzVfej0lxCy2Q/kvlhtWqq+Lp2cLI7gp
         GAc+XkmDxnoXszpPgfAYNoZ1QMw2MuwP1UcDP8NnljDGui1kbPp6rxWrbbIqHGd32OI3
         6DM1yuWC6Jx3hv5pBQMzUXLLaT576kWu3ObEfQlwLBd8lSXRcLkHjTWMIGNfKXr3JbNM
         dMrJFMbj1qQSx1D4R9GnQ8Ye1MN/r40VQX5s92VC2Vrnf/w8BT+A+IH5S/NabiQLsE41
         /E/w==
X-Forwarded-Encrypted: i=1; AJvYcCXLS1Wq7M5SnTEp8jkKxiSaKxvdpol5eAHDk2QPGKdkSn5KYot2vCUF370uFxjovShZKvJSNbg6bzii7+k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Waloxgsp6g/7Nv8TorDn3SQhxHguBwE2ch/DPVpptvSBJWoU
	5+9AxTk/0vr/dl3OuYRgDgbK56uDOG1mlCp9sxX0kW1URXQVtP2OylmtW50NWLJZjgg=
X-Gm-Gg: ASbGncuf60CSsgbzlsrpV5JqnfgbRx7iyO03+nywFSjxQost3O9NaOzoY9XyxYEP1Lf
	GF3VcB17k2twXYTMU9WacNNlJ49zlzWWGUcLwzLhiLcnFtz67tAqIxRF9A/3QWoRxLLRef1kVCm
	q4Xju/mOrWn+J+KD9f37cghLp04NA5idO/KoYPXiOCZfswWEoYPw8Tum1meJPsz1mNZT+yKfAEF
	boqv3cBMdgKZ6xQ8RZeylmk+3UNs5eVUEyQxTmeG06UQdcfzyyd8SocQ6I69stFsR8cdrft676M
	Q7Tdp9uDRTdNSCJG3xR/MxOlTnd/RM/z6VmAw6JbjtBLaBb+gKn5RdCnLhjj6C00lxJ/dIjklhZ
	N+K3RFrqfWXoID0EbX+jHTEusexn2uZ+i9GY=
X-Google-Smtp-Source: AGHT+IGlEGRhwr4gr8Z2C6l17HnHwUs58sjegA3GcEnBznTqiAkjnii/hJFGH6edhQsfKk84gJlxdw==
X-Received: by 2002:a17:90b:6ce:b0:315:c77b:37d6 with SMTP id 98e67ed59e1d1-321162c7400mr5456322a91.23.1754162764043;
        Sat, 02 Aug 2025 12:26:04 -0700 (PDT)
Received: from mystery-machine.local ([64.71.154.6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3207eba6bb8sm7887583a91.4.2025.08.02.12.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 12:26:03 -0700 (PDT)
From: Brigham Campbell <me@brighamcampbell.com>
Date: Sat, 02 Aug 2025 13:25:47 -0600
Subject: [PATCH 2/2] accel/rocket: Fix undeclared const rocket_pm_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250802-fix-rockchip-npu-build-v1-2-fb0f0dacb3fe@brighamcampbell.com>
References: <20250802-fix-rockchip-npu-build-v1-0-fb0f0dacb3fe@brighamcampbell.com>
In-Reply-To: <20250802-fix-rockchip-npu-build-v1-0-fb0f0dacb3fe@brighamcampbell.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org, 
 Brigham Campbell <me@brighamcampbell.com>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=838; i=me@brighamcampbell.com;
 h=from:subject:message-id; bh=z+5KRxYc5UqnilO3In24UU4dyirhMN0G97cy/9xmtoA=;
 b=owGbwMvMwCUWLsWS0KCyxZPxtFoSQ0ZfmttLvbj5zpsCrVsrf13/u/D0Iq8zjQ9rJi7bO1/xh
 NC0vObWjlIWBjEuBlkxRRaVW7PUL062fnQwgn8CzBxWJpAhDFycAjARBh5Ghq4JJYxNU1q9X7wp
 bjhzzWd532QVb1/Ljc93ySnfThC182BkOGLs/ars5/3PS6XmiIYWOsovjXy98ebZ4Le3D4pmdsR
 HsgAA
X-Developer-Key: i=me@brighamcampbell.com; a=openpgp;
 fpr=24DA9A27D1933BE2C1580F90571A04608024B449

Fix sparse warning regarding an undeclared const rocket_pm_ops, which is
used in rocket_drv.c.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202508030021.uwdr4P08-lkp@intel.com/
Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
---
 drivers/accel/rocket/rocket_drv.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/accel/rocket/rocket_drv.h b/drivers/accel/rocket/rocket_drv.h
index f50634935b605c542cce16a2b91c1e43ec16bc81..2c673bb99ccc1d90e2dafdc89e9a5c6df216a309 100644
--- a/drivers/accel/rocket/rocket_drv.h
+++ b/drivers/accel/rocket/rocket_drv.h
@@ -9,6 +9,8 @@
 
 #include "rocket_device.h"
 
+extern const struct dev_pm_ops rocket_pm_ops;
+
 struct rocket_iommu_domain {
 	struct iommu_domain *domain;
 	struct kref kref;

-- 
2.50.1



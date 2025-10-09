Return-Path: <linux-kernel+bounces-847459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCCDBCAE74
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 23:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 129F11A625B7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 21:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE13281369;
	Thu,  9 Oct 2025 21:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="C7IQ1hr1"
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41131E4AB
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 21:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760044830; cv=none; b=Dggpyd5AYSuUOiB794qRZFI+2HzECByF8afyyxsr2g+HsUYa2Xf4I7KzNgymAufOncTSEAP5DJj//PyMYFlOOhfH5CD+GWrYP61YkZt4BKJdm1k/LuPmcjyv3C8+JgEQu2U5ZJ3g1o9DxUAF+NzrJPTBvQ6QRjUJCpqWNE2KNFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760044830; c=relaxed/simple;
	bh=ZhL87hWPCqJqUdWzKetD/aJArXJ8FhDY4s+4hHC081k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FGF095lElYjfoySfMvt51wD7ARo5aTo2EjXNKc3Tiozs9u3zMXT9kWwmT0+9HUIzsPFW8a7zKtV4kx795k+kUN/zpjoLv2vUM6YSk/RoaikEhFHfpVTidpI9E9b3unnpqM0A3goe/nmgiItXyGBI3D4QOD2oq/ZcMj7aXKSwVZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=C7IQ1hr1; arc=none smtp.client-ip=209.85.215.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-b4ee87cc81eso1229181a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 14:20:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760044828; x=1760649628;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQrmK4OLtZ+IgNtZ8671Owl8Y5KLotbw1U+tAsx0fP8=;
        b=dQm+vj1O6/0U8aDuDr5h8KgY+UKgqKqh9TzOHUcR9wKqE+dNQb2w5YyvHPKVPCgAvf
         QGEfx1ti35MdFMZkPm8u1GxlKAFXtBjXXJxkegt49XeBqPCCNvHQNQEWqO/khHsd8upT
         8FJtVG0F67om0f4h5h/tU2kSVJnYGzf61IrQP9L3AwzIIJwWzaCQV+nm+BGrWkqovptk
         ngjBlUb/+w748w/PxnI0AYYjTtRs10g23fCiwF6hdVyzjGcIILUG9B34JPV1QVZagZ+P
         R214AxSmK8CvE+j0MLvb6nrAIqxxFXArOCatEQhGV+9MYD/DvarawY1gjMMqb7an7cIs
         omEg==
X-Forwarded-Encrypted: i=1; AJvYcCV2r/ap54KblkUQZTskG24qRzadR0Yc8wWVS22rbA9T25Rxnsttz545BX0Gv8aYiI/swm14QZ4Sh6Wct8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxns1R+iWKa5brNwC5cZm0rCojOcuaUts2TXQNVma2c1UCTL6ho
	9VdamVlbaViAmqP9Vv7CP2r4bUMmFqURvJ7xYb98UNcIgKRuW8QG6hH0nzVxW24ZLBc+T3bwQ7g
	XfCs/idAXczQOdOMw6bEFiOySbbctse+x0LX9clLLKfFqzZ4ytaCfvf19ZM8nf6IHUrLKu6THmh
	CVH2NEpfD5xcR9SUD8qtkTiY1OKmtkeB77tvizKZTsPj/8V5ZE4Ew6Z097SEiWtcdaTN33Z450s
	eTCWEDOAgQ6aSZN
X-Gm-Gg: ASbGncsBHk15x54XdJU8y1ElEz2KXq324zlLf0IlzSJmasKqtdJ+y8eaoN0MzQoC152
	QZCSeYPG23uecsRNd62IoojEqhsf8vDrsIyk8P3O+ya5R76hEOYvTt9+XXaztoPFF9ednr7odyq
	xDvLlVNPPxt/upVG/pKqEncfIl99VUAv6ehz+3Jl9x/rtNj7PEeJ5gSREYnRqudt16mbHk4yxhT
	9gYaFMKLvugK4J500Zf2wZGpOMKzX7zNR1GTs6rwc3UFzdl3U6vlB27+nRbL8rr966lyDOcRP6J
	P3Etl//ozpYMqMYPLT3QU2jfVvCFNVKG14RfWrf4QOndZLUyk6xwU7GV3irxj3c6zrM+BWA9fhm
	vjV8kdjpIeXPW4O/qp8NnT0pA3mRDDyw42+wjZ8RxBy/WwVLVG3k6G5tuXfXMnGscTSEF8qho/2
	+7ygYW
X-Google-Smtp-Source: AGHT+IECrZjXq5nm4t6LFGX7cughWpTS1sNA3tDbfiTuzt3KQXkVETh3GegrQg3LsYkxffjBfLOOie5jaxEt
X-Received: by 2002:a17:903:2c05:b0:24e:95bb:88b1 with SMTP id d9443c01a7336-290273ede89mr125372845ad.34.1760044827890;
        Thu, 09 Oct 2025 14:20:27 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-119.dlp.protect.broadcom.com. [144.49.247.119])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-29034e02b83sm2995065ad.10.2025.10.09.14.20.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Oct 2025 14:20:27 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-854bec86266so703312085a.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 14:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1760044827; x=1760649627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PQrmK4OLtZ+IgNtZ8671Owl8Y5KLotbw1U+tAsx0fP8=;
        b=C7IQ1hr16fabfBwl+LqkiTFxvCwn5fwb7V9rpS6CR7cw7+6fmS/9xO4IaxiuldEPS1
         x2GpL/+adxI5X11U8/4TJqj3Kt24OVJd5IfSiVaaTful2UP+fPjTcK544B9JtNFkFSP3
         DQwgwwe1pez5eCDm9uE6I8jKhw8+SwgoX8BbE=
X-Forwarded-Encrypted: i=1; AJvYcCWsY9jZyUNdEcNfVutSUF1s0mcH/63/zND1FbbPR2YzuUYmOhBl+SO9yPuLCNx86ZD14hkHqj37ZRSQwd8=@vger.kernel.org
X-Received: by 2002:a05:620a:4492:b0:865:cacf:e133 with SMTP id af79cd13be357-8835104c86bmr1139487085a.36.1760044826823;
        Thu, 09 Oct 2025 14:20:26 -0700 (PDT)
X-Received: by 2002:a05:620a:4492:b0:865:cacf:e133 with SMTP id af79cd13be357-8835104c86bmr1139483785a.36.1760044826325;
        Thu, 09 Oct 2025 14:20:26 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8849f9ae428sm274832685a.16.2025.10.09.14.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 14:20:25 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: peng.fan@oss.nxp.com,
	andersson@kernel.org,
	baolin.wang@linux.alibaba.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	florian.fainelli@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	linux-remoteproc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kamal Dasu <kamal.dasu@broadcom.com>
Subject: [PATCH v3 0/3] Adding brcmstb-hwspinlock support
Date: Thu,  9 Oct 2025 17:20:00 -0400
Message-Id: <20251009212003.2714447-1-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

This is a standalone patch for the hardware semaphore feature for
all brcmstb SoCs that have the same hardware semaphore registers
hence platform driver compatible uses:
	  '.compatible = "brcm,brcmstb-hwspinlock"'

The patch has been tested to work as builtin as well as a module.

v3 changes:
Added detailed explantion in the all commit messages as per review
comments
 - Added  description of 'sundry' ip block that the hardware semaphore
   belongs to
 - Added reasoning for using '.compatible = "brcm,brcmstb-hwspinlock"

v2 changes:
Adressed following review comments:
 - fixed ordering of obj brcmstb_hwspinlock.o in Makefile 
 - fixed ordering of 'config HWSPINLOCK_BRCMSTB' block in Kconfig
 - Renamed BRCMSTB_MAX_SEMAPHORES to BRCMSTB_NUM_SEMAPHORES
 - Removed unnecessary platfrom_set_drvdata(pdev, bank);

Also addressing duplicate PATCH 1/3 sent in error as part of v1 change.

v1 changes:
based on fixes made to Initial patch :
url:    https://github.com/intel-lab-lkp/linux/commits/Kamal-Dasu/dt-bindings-brcmstb-hwspinlock-support-for-hwspinlock/20250712-034624
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20250711154221.928164-4-kamal.dasu%40broadcom.com
patch subject: [PATCH 2/4] hwspinlock: brcmstb hardware semaphore support

All the review comments and build warning have been fixed.

Kamal Dasu (3):
  dt-bindings: hwlock:  Adding brcmstb-hwspinlock support
  hwspinlock: brcmstb hardware semaphore support
  MAINTAINERS: adding entry for BRCMSTB HWSPINLOCK driver

 .../hwlock/brcm,brcmstb-hwspinlock.yaml       | 36 +++++++
 MAINTAINERS                                   |  8 ++
 drivers/hwspinlock/Kconfig                    | 11 ++-
 drivers/hwspinlock/Makefile                   |  1 +
 drivers/hwspinlock/brcmstb_hwspinlock.c       | 96 +++++++++++++++++++
 5 files changed, 151 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/hwlock/brcm,brcmstb-hwspinlock.yaml
 create mode 100644 drivers/hwspinlock/brcmstb_hwspinlock.c

-- 
2.34.1



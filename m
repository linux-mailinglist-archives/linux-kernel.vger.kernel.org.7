Return-Path: <linux-kernel+bounces-802332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 728A2B45126
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1133B560003
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 08:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9083425C81B;
	Fri,  5 Sep 2025 08:19:13 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36CA3002A4;
	Fri,  5 Sep 2025 08:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757060353; cv=none; b=R2CwxGkToS5yHVtX8nm6K3/Cv+c0OEPI/QA5jnBF0hXE43c7JiqxAHAzuRP4Kj1JvE6lbEVbS92wmSy4kkaxPRFv8zCqXWsmMaZjPWbkw8PkkPckQD4sVSvQjiOMUzdgu2TNBdSqP5viIzDJSX2f8TtyFqtF4uDTiZcO0LN9+Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757060353; c=relaxed/simple;
	bh=Nb9uxhklrOEqQvdTIqK88a6N93vj10RsRMXZVm/d7Vg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=busv2n9+kh+xjTIhf4A8jG67QpyTQT+p3307wtAzq4NXxxEjmGFmEf/AfkmkMS4Z+pkJADAWcTr4tFoHLXCSMpttMxxg3g+M4uM61ulITmO9Jyn8nH/iVUDbqoGDnTRbTfPyjHWP5yos4XlLyKwb4JzPN6U+k6dEjF2QPwG9u8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cJ8Ns4YD4ztTW6;
	Fri,  5 Sep 2025 16:18:05 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id AA0B81800B1;
	Fri,  5 Sep 2025 16:19:01 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 5 Sep 2025 16:19:01 +0800
Received: from localhost.localdomain (10.50.165.33) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 5 Sep 2025 16:19:00 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<lihuisong@huawei.com>
Subject: [PATCH v2 0/3] ACPI: processor: Fix function declaration of processor_idle.c
Date: Fri, 5 Sep 2025 16:18:57 +0800
Message-ID: <20250905081900.663869-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemn100009.china.huawei.com (7.202.194.112)

The patch 1/3 is reported by kernel test robot.
And patch 2/3 and patch 3/3 are modified by the way.

---
Changelog
 v2:
  - split patch v1

Huisong Li (3):
  ACPI: processor: Fix function defined but not used warning
  ACPI: processor: Remove unused empty function definition for
    processor_idle.c
  ACPI: processor: Fix acpi_processor_ffh_lpi_xxx() declaration

 include/acpi/processor.h | 35 +++--------------------------------
 1 file changed, 3 insertions(+), 32 deletions(-)

-- 
2.33.0



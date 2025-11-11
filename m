Return-Path: <linux-kernel+bounces-894693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAC0C4B9D6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DD7E3B78DA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 06:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9749129B8E1;
	Tue, 11 Nov 2025 06:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ejartwGv"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD73429B228;
	Tue, 11 Nov 2025 06:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762841382; cv=none; b=McnLJK446C+tiYfgYc4ZwGSb5BIQVZEgOxjN6aUVmsZeyskutTBqrEyh1Ij/2p+2TNUiiTUwvYX1IwnNPJPZFxKmYN3afKroRYLwbr3VJGu/y4Hv4FAnWirbH7AHjtLhSQ29jAXb/Tm+a4L5S3SMZlso+D0d1B6+l6AzAqaHzR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762841382; c=relaxed/simple;
	bh=6dCXLdIWv9npf8f4qkkUpDcXpgo5z2Dxges617f+44E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s2GAhjUz2JZBr83Ded3ATafCaqBq+ifMYKRLw3PL6R1ugMAd+glgXwAwq5plEw1sN9hqhuS1E3bD8UgU6q3snid+nBAYbbMukbbmyV+gVMAqxJBrg2B3DrGPY02m2BowiFDDPiIGdlO3ujr9PoT2iKoEmzteb/XMbNDfbbuC7gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ejartwGv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=s0l9+LEBSDq0l4KQpP+9O2GQV5N1q9E/VoCc/+IvMDw=; b=ejartwGv7+a7fLvTqzBodWWM4c
	zNmWXZQrXs8I2WEDKkgogGg4+Vh6lwRTyjDD5Nh2IifYgMWnK3PByuH3o+rEv5a3f1nw5LOhTUUXL
	6czt6nZC5IZRyDVVZD2J5HXBilblh4xsnOjciNvJGnGDYMsMZIx2tcRicVlslYM8SW4RvnLOJ4AnF
	dgzq1r2/n4q0n0pqpVqOemrpZCmvkoHYUPH6qaOzfGUKY4tZ9c6zcGsUIhyEDB8T93q+EBiyXgMUu
	bzsS59W8qcpE8WqLH/5dlGaNRlsDFAs3lGrWYjx6hzqJVQlTqOctPictkLh4ZE61CqdrJHqE5hven
	T6W5uwXA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIhZT-00000006b0i-0k0e;
	Tue, 11 Nov 2025 06:09:39 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH] platform/x86: intel-uncore-freq: fix all header kernel-doc warnings
Date: Mon, 10 Nov 2025 22:09:34 -0800
Message-ID: <20251111060938.1998542-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In file uncore-frequency/uncore-frequency-common.h,
correct all kernel-doc warnings by adding missing leading " *" to some
lines, adding a missing kernel-doc entry, and fixing a name typo.

Warning: uncore-frequency-common.h:50 bad line:
   Storage for kobject attribute elc_low_threshold_percent
Warning: uncore-frequency-common.h:52 bad line:
   Storage for kobject attribute elc_high_threshold_percent
Warning: uncore-frequency-common.h:54 bad line:
   Storage for kobject attribute elc_high_threshold_enable
Warning: uncore-frequency-common.h:92 struct member
 'min_freq_khz_kobj_attr' not described in 'uncore_data'
Warning: uncore-frequency-common.h:92 struct member
 'die_id_kobj_attr' not described in 'uncore_data'

Fixes: 24b6616355f7 ("platform/x86/intel-uncore-freq: Add efficiency latency control to sysfs interface")
Fixes: 416de0246f35 ("platform/x86: intel-uncore-freq: Fix types in sysfs callbacks")
Fixes: 247b43fcd872 ("platform/x86/intel-uncore-freq: Add attributes to show die_id")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>
Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org
---
 drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.h |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- linux-next-20251107.orig/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.h
+++ linux-next-20251107/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.h
@@ -40,7 +40,7 @@
  * @agent_type_mask:	Bit mask of all hardware agents for this domain
  * @uncore_attr_group:	Attribute group storage
  * @max_freq_khz_kobj_attr: Storage for kobject attribute max_freq_khz
- * @mix_freq_khz_kobj_attr: Storage for kobject attribute min_freq_khz
+ * @min_freq_khz_kobj_attr: Storage for kobject attribute min_freq_khz
  * @initial_max_freq_khz_kobj_attr: Storage for kobject attribute initial_max_freq_khz
  * @initial_min_freq_khz_kobj_attr: Storage for kobject attribute initial_min_freq_khz
  * @current_freq_khz_kobj_attr: Storage for kobject attribute current_freq_khz
@@ -48,13 +48,14 @@
  * @fabric_cluster_id_kobj_attr: Storage for kobject attribute fabric_cluster_id
  * @package_id_kobj_attr: Storage for kobject attribute package_id
  * @elc_low_threshold_percent_kobj_attr:
-		Storage for kobject attribute elc_low_threshold_percent
+ *		Storage for kobject attribute elc_low_threshold_percent
  * @elc_high_threshold_percent_kobj_attr:
-		Storage for kobject attribute elc_high_threshold_percent
+ *		Storage for kobject attribute elc_high_threshold_percent
  * @elc_high_threshold_enable_kobj_attr:
-		Storage for kobject attribute elc_high_threshold_enable
+ *		Storage for kobject attribute elc_high_threshold_enable
  * @elc_floor_freq_khz_kobj_attr: Storage for kobject attribute elc_floor_freq_khz
  * @agent_types_kobj_attr: Storage for kobject attribute agent_type
+ * @die_id_kobj_attr:	Attribute storage for die_id information
  * @uncore_attrs:	Attribute storage for group creation
  *
  * This structure is used to encapsulate all data related to uncore sysfs


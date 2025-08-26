Return-Path: <linux-kernel+bounces-787040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7C7B370B2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 18:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC5671B60808
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AE4362089;
	Tue, 26 Aug 2025 16:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HD4uxYKH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0402D12E4
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 16:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756226627; cv=none; b=S+7wGCPOPwlLRQLAcQGBqcFgOide2chOgMLKRcfOieIMT17aMxmwZ9Mhhr45M8xJfb4rLvqlu0Bdp+8hwvM0/PgHymKv3ZWWXGN/T9Ps+jip91SIT4pO9mgo9heFQ8InOqyWvoz9KDriPDuR2DugXL/EXcCYBk9YwkDhhJjG0Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756226627; c=relaxed/simple;
	bh=MCOer+ksuLi7clca5Mdv+wXA/Dxgt7rsLw5MwHnahTY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mVSNcIx3QWFw0T/7SC0PB/vO93O+44OKIcdmK4m9S41C3jhdwNjUuO9NfI24ThEKDFwbbTyjxSgHnSrQdScvekeJdGk5Eog7TfKvf3Fpvdj1hMXf6zY9kC39X8so8vAvZKE+SWFA1L301P4PNlTl8GqoyJEj11xskB90zPOrz08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HD4uxYKH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756226624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=z5jJAQ4bl/C1tP3vIQgdQ7NeY1XQOoOjZ8flFIdluW4=;
	b=HD4uxYKHSI/llasMj6WvOD7Ij62gbljJcaimeEtnwalFDJsyNuScbJeFmr8/h6poVThJNS
	a4VxMZeIZsBOOuzP8igwzCckm48IQHnN5sE9PiOyj3XOkSb5yFqBFF2Ua18qP6O54vGFdJ
	5DTfK36/xfidsSCftTo0H+umuJMoSQ8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-37-b_VB8Hc8Mwyp-OFH4XP3mw-1; Tue,
 26 Aug 2025 12:43:40 -0400
X-MC-Unique: b_VB8Hc8Mwyp-OFH4XP3mw-1
X-Mimecast-MFC-AGG-ID: b_VB8Hc8Mwyp-OFH4XP3mw_1756226619
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C92019560AE;
	Tue, 26 Aug 2025 16:43:38 +0000 (UTC)
Received: from dba-icx.bos.redhat.com (prarit2023-dbaguest.khw.eng.bos2.dc.redhat.com [10.26.1.94])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 048C519560AB;
	Tue, 26 Aug 2025 16:43:35 +0000 (UTC)
From: David Arcari <darcari@redhat.com>
To: platform-driver-x86@vger.kernel.org
Cc: David Arcari <darcari@redhat.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Tero Kristo <tero.kristo@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86/intel: power-domains validate domain in tpmi_cpu_online()
Date: Tue, 26 Aug 2025 12:43:28 -0400
Message-ID: <20250826164331.1372856-1-darcari@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Although tpmi_get_power_domain_mask() calls tpmi_domain_is_valid()
prior to indexing tpmi_power_domain_mask[], tpmi_cpu_online() does
not. In the case where a VM creates non-contiguous package ids the
result can be memory corruption. This can be prevented by adding
the same validation in tpmi_cpu_online().

Fixes: 17ca2780458c ("platform/x86/intel: TPMI domain id and CPU mapping")

Cc: Hans de Goede <hansg@kernel.org>
Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Cc: David Arcari <darcari@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Tero Kristo <tero.kristo@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: David Arcari <darcari@redhat.com>
---
 drivers/platform/x86/intel/tpmi_power_domains.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/x86/intel/tpmi_power_domains.c b/drivers/platform/x86/intel/tpmi_power_domains.c
index 9d8247bb9cfa..ae5b58679e29 100644
--- a/drivers/platform/x86/intel/tpmi_power_domains.c
+++ b/drivers/platform/x86/intel/tpmi_power_domains.c
@@ -194,6 +194,9 @@ static int tpmi_cpu_online(unsigned int cpu)
 	if (ret)
 		return 0;
 
+	if (!tpmi_domain_is_valid(info))
+		return 0;
+
 	index = info->pkg_id * MAX_POWER_DOMAINS + info->punit_domain_id;
 
 	guard(mutex)(&tpmi_lock);
-- 
2.50.0



Return-Path: <linux-kernel+bounces-791677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC07B3BA0C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 13:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 438E37B1C16
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 11:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36D72D249A;
	Fri, 29 Aug 2025 11:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PRKOX5j4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95ADA2BE032
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 11:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756467584; cv=none; b=GOW5CeXrq37rFpvMImduIA0R2TT4WJf8B4R27/VxJ0/ZV22MiufoL9rKMwjacDLbtYivHVU3TV5SSCJWiUhnAZdculq6wdxR54tmxfA8WbvFB9VMsI7QkHy+BPC7TD/FvlpbHH3UYp6vSgH2I5RGkyx0WSuEriOJuprniiY33wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756467584; c=relaxed/simple;
	bh=GcVg7H5GYHJLW2KJundL2qfLw8rTfpO5ga5T9Uu4FXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QnTSSZ4PVHeSpEBiaqR16aFGg+J+9/AW29nen8KoI+SkMixlvvgxBAWPD/Y+8S8a+42nrXOLpkhBvXtwJIJOpgB6XeqJRgwLGeescxeRZjK7c/Fs00LaKQafWLkXsUMxODKhQpNkPMsDI0x7xXwwkiI5XkMibGPdMIj1vloElRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PRKOX5j4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756467581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lDHdptYlOehnaEBDjbhXnX1ikqfddk1tmMgrKqqAskk=;
	b=PRKOX5j4DkTpjpJmsMilGb/3Ycw+BoMhpl0kY7g/wqhNqnpeyLA5PE7j+2NJkHGWYCdJFJ
	ZECtMcAHj1gwWK7XvxCldkOacT+T4nwZEJVy+zle42RRatZcNEH/hPERSCs2WaQs6pkGfZ
	C1pstPpJjxrJejSoTLUVpyZujokPHKw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-L-Xc2mkXNHaTPGW0TI8iZQ-1; Fri,
 29 Aug 2025 07:39:38 -0400
X-MC-Unique: L-Xc2mkXNHaTPGW0TI8iZQ-1
X-Mimecast-MFC-AGG-ID: L-Xc2mkXNHaTPGW0TI8iZQ_1756467576
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 499C91956087;
	Fri, 29 Aug 2025 11:39:36 +0000 (UTC)
Received: from dba-icx.bos.redhat.com (prarit2023-dbaguest.khw.eng.bos2.dc.redhat.com [10.26.1.94])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3A7701800296;
	Fri, 29 Aug 2025 11:39:34 +0000 (UTC)
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
Subject: [PATCH v2] platform/x86/intel: power-domains: Use topology_logical_package_id() for package ID
Date: Fri, 29 Aug 2025 07:38:59 -0400
Message-ID: <20250829113859.1772827-1-darcari@redhat.com>
In-Reply-To: <20250826164331.1372856-1-darcari@redhat.com>
References: <20250826164331.1372856-1-darcari@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Currently, tpmi_get_logical_id() calls topology_physical_package_id()
to set the pkg_id of the info structure. Since some VM hosts assign non
contiguous package IDs, topology_physical_package_id() can return a
larger value than topology_max_packages(). This will result in an
invalid reference into tpmi_power_domain_mask[] as that is allocatead
based on topology_max_packages() as the maximum package ID.

Fixes: 17ca2780458c ("platform/x86/intel: TPMI domain id and CPU mapping")
Signed-off-by: David Arcari <darcari@redhat.com>
---
v2: fixed underlying issue in tpmi_get_logcal_id() instead of
    preventing access in tpmi_cpu_online().

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
 drivers/platform/x86/intel/tpmi_power_domains.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/tpmi_power_domains.c b/drivers/platform/x86/intel/tpmi_power_domains.c
index 9d8247bb9cfa..8641353b2e06 100644
--- a/drivers/platform/x86/intel/tpmi_power_domains.c
+++ b/drivers/platform/x86/intel/tpmi_power_domains.c
@@ -178,7 +178,7 @@ static int tpmi_get_logical_id(unsigned int cpu, struct tpmi_cpu_info *info)
 
 	info->punit_thread_id = FIELD_GET(LP_ID_MASK, data);
 	info->punit_core_id = FIELD_GET(MODULE_ID_MASK, data);
-	info->pkg_id = topology_physical_package_id(cpu);
+	info->pkg_id = topology_logical_package_id(cpu);
 	info->linux_cpu = cpu;
 
 	return 0;
-- 
2.50.0



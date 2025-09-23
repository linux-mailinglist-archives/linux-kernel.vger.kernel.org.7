Return-Path: <linux-kernel+bounces-828480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB52B94B0D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A08C6166543
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 07:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF733148C2;
	Tue, 23 Sep 2025 07:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGRwj3cK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B478C30FF2B
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758611060; cv=none; b=TZ+hlDBya7frRgL+8dnAmT/57yLPSJaMuTJNF1zBtZhuoXRtnb64fQeDhgq6VFszrsQRNb7LHTFh30SIcmg+hjV8hWCp4xBzOtT98dVd7xqJX4Kssy/sRtqgYcz7EUEI60d+1zK5EfYyEVOftTCCHPbmMU9e6a810U1ySUOHzgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758611060; c=relaxed/simple;
	bh=LBcbcxqb5VtFP9cKnqHpf4viJe4PKaiRcfE7O4rXies=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m7xec2KJFrqzCcpT5PCyvZS8iboSxR6DXlAIgjx57VZGpo7zD7d7jGTzBem97s7rK/kc40blfJkOnq6IpAfdxhaUKyHpaleonhkdnbMPFhzFysJ5qWiasXr0Q5gpUUDvWEpZCAeCHVWQJHK41X3sCKfnN0F7suttoxHYvznWEAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGRwj3cK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C192C4AF0B;
	Tue, 23 Sep 2025 07:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758611060;
	bh=LBcbcxqb5VtFP9cKnqHpf4viJe4PKaiRcfE7O4rXies=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WGRwj3cKE9Nv7SrrM511AEJQRqm14mDEBfNwdfZiQzFK/zquw3jYc52vg0rE8leIb
	 abfGBSyvcxQKFuE4Hqyc/4kQTeP28W68qjJkp895NOh3Y2cbdImKtp3QcW91jMt05s
	 UvjRHUXIq9f932xRay2JkKIX10oNXt6SEgj2qIZ04pkVlPnHGGtV/iU+avZRf+EE06
	 5LAm9jQFOvZZ3o/Qluo//puIohpUQEZr1fIaWwlkQgwHgUIqjh0CzJmyPd/fF1vH/e
	 G5V9eomcAuCH7UUhSIwbeqsKKB3wyHvl0B8JXAcuFePRO70pJKy6cn+Ye9jAoqvfZJ
	 Q5EraT7aDF4tw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1v0x4U-00000006bLE-2LLo;
	Tue, 23 Sep 2025 09:04:18 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Ani Sinha <anisinha@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v12 14/17] acpi/generic_event_device.c: enable use_hest_addr for QEMU 10.x
Date: Tue, 23 Sep 2025 09:04:08 +0200
Message-ID: <ad77b64aa1f09141efe942539445908631423975.1758610789.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758610789.git.mchehab+huawei@kernel.org>
References: <cover.1758610789.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Now that we have everything in place, enable using HEST GPA
instead of etc/hardware_errors GPA.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/acpi/generic_event_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index e575b9404be4..e7b773d84d50 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -363,7 +363,7 @@ static const Property acpi_ged_properties[] = {
     DEFINE_PROP_LINK("bus", AcpiGedState, pcihp_state.root,
                      TYPE_PCI_BUS, PCIBus *),
     DEFINE_PROP_BOOL("x-has-hest-addr", AcpiGedState,
-                     ghes_state.use_hest_addr, false),
+                     ghes_state.use_hest_addr, true),
 };
 
 static const VMStateDescription vmstate_memhp_state = {
-- 
2.51.0



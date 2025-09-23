Return-Path: <linux-kernel+bounces-828479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E7DB94B07
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F3691660C9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 07:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF8A30FF2A;
	Tue, 23 Sep 2025 07:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSLVtmd8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B698730FF2F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758611060; cv=none; b=URAwbNBXSa6e0ZGk2Pl5r0W2dPCWkhYqajat8eOk3nTkK19sSblyy3dI2Nu7O+EPsTkU/Fx7ZBeqWOpJzXot4jtiDtxTwV0GB0+nlUJfkNGB/Aq4wFr5FOpnEvqFZg9dCt27Fl2UrIxlRN6132QXf6aXEfwvg2tmycmJcYYo03k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758611060; c=relaxed/simple;
	bh=IjJ4y9uy7VcSd8eGrYRNJbPGROxfdzIQhh+NLKCr7+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WIuCtmLq3UROKnuCdmgu6gSIOTDZNGK51C3qOscGVWdBuQgOUr0awNK9J7IP6Qa8Mlta3JVyF4cya8buHGvOKopzY/OjG7ZppbD4Zuqu+ZR+UptMr98t/N6wM3slZYQAJxQqG/HaB97tsBznvolP2S3ZTGl85Yoj7DFHv9oDrOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSLVtmd8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4453CC19425;
	Tue, 23 Sep 2025 07:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758611060;
	bh=IjJ4y9uy7VcSd8eGrYRNJbPGROxfdzIQhh+NLKCr7+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nSLVtmd886tXNqGEhhRL/CFeSJMul/EBCeP7QL2VOdEW1AYrXP2Qnpm14BMYDvkty
	 1ckObaNv7OmUe2uvJepJeS6EBLewK55i90N/Gz59KY/g4R1xOTU/jnQx42BsyQ3WqP
	 s1s5jjuzXBYLv27+UxYA4qVwnK3epODp9+EILBNAHAbEYTyAN8WJT8XrvhvyXb0715
	 zG+XjTOSLbgW91numoAQKDcXE70wL2OJE6nmYINsJY+Y0Hb+wbhafUCA/FKKZvtAbg
	 buzNlM8JEZIzXsCwStxcDr3aYXe88P+nHIrrNr8vIsqFwDSJAkNrt1JFD3C4hDKdyj
	 09vZrJYpI7kDA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1v0x4U-00000006bL2-1zJL;
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
Subject: [PATCH v12 11/17] tests/acpi: virt: allow acpi table changes at DSDT and HEST tables
Date: Tue, 23 Sep 2025 09:04:05 +0200
Message-ID: <7fca7eb9b801f1b196210f66538234b94bd31c23.1758610789.git.mchehab+huawei@kernel.org>
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

We'll be adding a new GED device for HEST GPIO notification and
increasing the number of entries at the HEST table.

Blocklist testing HEST and DSDT tables until such changes
are completed.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8bf4..45f256946751 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,10 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/aarch64/virt/HEST",
+"tests/data/acpi/aarch64/virt/DSDT",
+"tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt",
+"tests/data/acpi/aarch64/virt/DSDT.acpipcihp",
+"tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex",
+"tests/data/acpi/aarch64/virt/DSDT.memhp",
+"tests/data/acpi/aarch64/virt/DSDT.pxb",
+"tests/data/acpi/aarch64/virt/DSDT.topology",
+"tests/data/acpi/aarch64/virt/DSDT.viot",
-- 
2.51.0



Return-Path: <linux-kernel+bounces-656461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7808FABE681
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 23:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A61087A6ED4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 21:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0882728C2CF;
	Tue, 20 May 2025 21:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQ+UUhc1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AF3288C86;
	Tue, 20 May 2025 21:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747777876; cv=none; b=MphUd/juxX664ufxWKG2JiKOAVttLh4OtaD7yiolI+Rkb3rUCiDVBonfxGfsszIKLMog0eMQDH20bIMMhV+rjv75m89W/FhEAlcytvUlM3LeGFQ7eQHGC+/hzGyu1NBpJ8vaCzdqvtGLmSCTtMEN06lB6jZAJ7w41RLdOzpIPPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747777876; c=relaxed/simple;
	bh=vGxhmnnQMOoDk57ET4tcLt0Mo9fvIzE4nqwWsOgS15g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yk2Xu5wvFbXhFo/Fv0bmFQAA8I1f4Z0tfHiIUws2y3jeBrgwEH/sxKndBXcGSCSfxwZef1efdMw5yt5CXfgOFvzMSgKTS2uLhS8udos5Q34Dg8/FgYrQUi2hPNQWZ2IroqDa5TNbWlo1ZT73rqqFVaHyDjqt3EaAl9v3iawKtuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQ+UUhc1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8EBC4CEE9;
	Tue, 20 May 2025 21:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747777876;
	bh=vGxhmnnQMOoDk57ET4tcLt0Mo9fvIzE4nqwWsOgS15g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oQ+UUhc16ctu9jd/RKklHzZ4tIDsOC0RQIU2iFmhql03I1hZ+F2O3um5Ji8DBqcUO
	 mSnTPGZzGSVTHSb8YTkf4spLiZ0nZQQ1O/qvTaDX7Cjq88gHpqYuZSicYWAtoBPJ1H
	 o3hBMPPyu/72VdDAT0Q7UtGr9bDwJwuvA8oE5MakCFBYPTRr1P/eSOnv8ICgU2Dl9F
	 8dKYl7rzX9TaYvWZwTEoG9F1nUlx4n2diFYMmTJj2NctkUzvjlVje8JnQu9E0gAS8a
	 CIwKwZfsD2bajUjV7mcFywVRKT+pBSwaOeEY7OuzGnmYgXuk2FtjGgJf2y8N3l+x65
	 3U2hTnqTJjMRg==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Jon Pan-Doh <pandoh@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	Weinan Liu <wnliu@google.com>,
	Martin Petersen <martin.petersen@oracle.com>,
	Ben Fuller <ben.fuller@oracle.com>,
	Drew Walton <drewwalton@microsoft.com>,
	Anil Agrawal <anilagrawal@meta.com>,
	Tony Luck <tony.luck@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sargun Dhillon <sargun@meta.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Robert Richter <rrichter@amd.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: [PATCH v7 16/17] PCI/AER: Add ratelimits to PCI AER Documentation
Date: Tue, 20 May 2025 16:50:33 -0500
Message-ID: <20250520215047.1350603-17-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250520215047.1350603-1-helgaas@kernel.org>
References: <20250520215047.1350603-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jon Pan-Doh <pandoh@google.com>

Add ratelimits section for rationale and defaults.

[bhelgaas: note fatal errors are not ratelimited]
Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
Signed-off-by: Jon Pan-Doh <pandoh@google.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/PCI/pcieaer-howto.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
index f013f3b27c82..6fb31516fff1 100644
--- a/Documentation/PCI/pcieaer-howto.rst
+++ b/Documentation/PCI/pcieaer-howto.rst
@@ -85,6 +85,18 @@ In the example, 'Requester ID' means the ID of the device that sent
 the error message to the Root Port. Please refer to PCIe specs for other
 fields.
 
+AER Ratelimits
+--------------
+
+Since error messages can be generated for each transaction, we may see
+large volumes of errors reported. To prevent spammy devices from flooding
+the console/stalling execution, messages are throttled by device and error
+type (correctable vs. non-fatal uncorrectable).  Fatal errors, including
+DPC errors, are not ratelimited.
+
+AER uses the default ratelimit of DEFAULT_RATELIMIT_BURST (10 events) over
+DEFAULT_RATELIMIT_INTERVAL (5 seconds).
+
 AER Statistics / Counters
 -------------------------
 
-- 
2.43.0



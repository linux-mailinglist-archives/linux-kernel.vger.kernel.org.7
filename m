Return-Path: <linux-kernel+bounces-800852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CC3B43CFB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C4F63BB66A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F9E3002DA;
	Thu,  4 Sep 2025 13:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qx9+Mquj"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BB4158DAC
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 13:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756992140; cv=none; b=fIArkmMZT9TfGzg2fDR9L6jkMPVBVlneAtx+hP5/iDYOuO0yIfXflO22GC74bx1+ctQNCxjcNr+fkFGkrvA4skGYnz1BaU3xt5HqsiffOgQTNRuJI/g3MCpyZ8pGQhfIlFafMDtJeW1gG/CuOS2THerdehCdOy1UDgobrIj4KKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756992140; c=relaxed/simple;
	bh=1KUFzJ4GYAjdzGbSDB0ApaKWsW5eVfgSzyGlt6wm5Gc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bhmh+JOpX13rqR+WgIYUf0r62Knem0GvRuJC7X64Rp/ccmPqy5Qk/eNmfEp5C+Ohj4GJP8XZAMBrVODS3X2e3Nl9vOzw+EHToOmJ18P6p2WmSkmO8ue67bS0jYm+912GHUXNPeGC+Z91BP0c5s23Nm/e+DZeEied6n8RqdpfR5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qx9+Mquj; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 584DLq1c3475583;
	Thu, 4 Sep 2025 08:21:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756992112;
	bh=U08NYMB1Ad3w11Zr/tff+obhn58+XapkrwB6JYyUlOQ=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=qx9+Mquj3rYrleoQ5Kt01Zx16auOkcL4QsMwyXUqtS8V65ryb7uQcLYZ6NN2Po14a
	 zk2IlaNZz+frBQJdjJFSjZ10dfZAISqt3Un2A1DZ6MzUWJV0zduAE2kTTUJStPaXyI
	 uTpNokX8C7DVyJjdDwkPRx/BkeFFH8G7SPvPNWP8=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 584DLqto3833851
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 4 Sep 2025 08:21:52 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 4
 Sep 2025 08:21:52 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 4 Sep 2025 08:21:52 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 584DLotj3313729;
	Thu, 4 Sep 2025 08:21:51 -0500
Date: Thu, 4 Sep 2025 18:51:50 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Guillaume La Roque <glaroque@baylibre.com>
CC: Thomas Gleixner <tglx@linutronix.de>, <vigneshr@ti.com>,
        Nishanth Menon
	<nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo
	<kristo@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH RESEND v2 1/2] genirq/msi: Export functions to support TI
 SCI INTA MSI module
Message-ID: <20250904132150.vs4tzkigqowzqtzn@lcpd911>
References: <20250902-timsi-v2-0-a5bf0f32905b@baylibre.com>
 <20250902-timsi-v2-1-a5bf0f32905b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250902-timsi-v2-1-a5bf0f32905b@baylibre.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Sep 02, 2025 at 16:43:49 +0200, Guillaume La Roque wrote:
> Export MSI domain management functions to allow the TI SCI INTA MSI
> driver to be compiled as a module.
> 
> The following functions are now available for module use:
> 
> - msi_domain_insert_msi_desc()
> - msi_domain_free_msi_descs_range()
> - msi_setup_device_data()
> - msi_create_irq_domain()
> - msi_domain_alloc_irqs_all_locked()
> 
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated


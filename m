Return-Path: <linux-kernel+bounces-770409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9DCB27A68
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B8863B2FA9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD7929D28A;
	Fri, 15 Aug 2025 07:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b="JCHaOt79"
Received: from sg-3-14.ptr.tlmpb.com (sg-3-14.ptr.tlmpb.com [101.45.255.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2186423CE
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 07:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.45.255.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755244574; cv=none; b=aRbG4Ac+pGS2ukJItkKgOCqt8pVgPK2QL5uhaRyISC3rFaTc7mF5J1SydEYiwX4qeY6pDGU3FsLWicyR3G18EeKIeauJFhjnbgwwDFpsTIUyyQLQPvgpTIwrfr9jlOjiqeGUubtw2uSTRpK1VNFDrDDiPPQ4MB7FrVWwS6mxAxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755244574; c=relaxed/simple;
	bh=5nOrQy3XElJENfSC/LatOI56f9OxwJE4m2TuPasPCn0=;
	h=Date:To:From:Message-Id:Mime-Version:In-Reply-To:Content-Type:Cc:
	 References:Subject; b=pGJYhBqRWDLuqwNvzmDQmG3dIkiCZYIHJ7ejjFdnZzlMh1BKaVZq43JqE9pQfALsGxb8y8u7OVVmAtJtAPnwyMu0Urpk9uKZSK2/6ImDsKWLRmpq2E6VozGDYa6EmlA+80wuECIGewFbpkMxDMfxG30pCys0YhB3TTPefw3Uvnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com; spf=pass smtp.mailfrom=lanxincomputing.com; dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b=JCHaOt79; arc=none smtp.client-ip=101.45.255.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lanxincomputing.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1755244556;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=JFpwghLSkeHlDIyCqRaPY0QI7oFLO/bDk8iDSgor+H0=;
 b=JCHaOt79+FpJwMEF7MRFiVBmM7NRIVRO46N9vtxoUBQNCWKKuPHJnhr1vPpzS8NH/c0s/I
 33ez8lQ1GIkU3aGeRNvcisNTor4xcYX4/obXTRhXN9VeCXJMyi5nLH0EiAZAzWBNyHlD62
 GEwqxVMbCRlj3QDclzcpb+Mtdclvs4G7kFh7VICQThkE7567Bup+Wz4J2RVj6SASBmc6o6
 AoBpSQBCWEDINl1b4IkCjPCXKe5LRQRe4RihqqppIEokahkYW+w2P/V0WMKTz8xmxN8L0/
 3eK3aNopCH3jZs/7unM/Isv9V2FBhHK+KLSlUxon8ip2aLd+qxYrylKsjtF6uA==
Date: Fri, 15 Aug 2025 15:55:41 +0800
X-Mailer: git-send-email 2.34.1
Received: from LeonHXL.localdomain ([116.237.111.137]) by smtp.feishu.cn with ESMTPS; Fri, 15 Aug 2025 15:55:53 +0800
To: <sunilvl@ventanamicro.com>
From: "XianLiang Huang" <huangxianliang@lanxincomputing.com>
Message-Id: <20250815075541.29941-1-huangxianliang@lanxincomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: XianLiang Huang <huangxianliang@lanxincomputing.com>
In-Reply-To: <20250716104059.3539482-2-sunilvl@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8
Cc: <ajones@ventanamicro.com>, <alex@ghiti.fr>, <anup@brainfault.org>, 
	<apatel@ventanamicro.com>, <atishp@rivosinc.com>, 
	<iommu@lists.linux.dev>, <joro@8bytes.org>, <lenb@kernel.org>, 
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-riscv@lists.infradead.org>, <palmer@dabbelt.com>, 
	<paul.walmsley@sifive.com>, <rafael@kernel.org>, <robin.murphy@arm.com>, 
	<tjeznach@rivosinc.com>, <will@kernel.org>, 
	<huangxianliang@lanxincomputing.com>
References: <20250716104059.3539482-2-sunilvl@ventanamicro.com>
Subject: Re: [PATCH v5 1/3] ACPI: RISC-V: Add support for RIMT
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+2689ee80a+aedf14+vger.kernel.org+huangxianliang@lanxincomputing.com>

Hi Sunil,

On Wed, 16 Jul 2025 16:10:57 +0530, Sunil V L wrote:
> +	parent = ACPI_ADD_PTR(struct acpi_rimt_node, rimt_table, map->dest_offset);
> +
> +	if (node->type == ACPI_RIMT_NODE_TYPE_PLAT_DEVICE ||
> +	    node->type == ACPI_RIMT_NODE_TYPE_PCIE_ROOT_COMPLEX) {
> +		*id_out = map->dest_offset;
> +		return parent;
> +	}

Why do we assign dest_offset to id_out? The dest_offset is the iommu offset, not
a valid deviceid required for platform device in rimt_plat_iommu_map?

Regards,
Xianliang


Return-Path: <linux-kernel+bounces-705967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E735AAEB007
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 09:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FED74A4B6E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 07:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF43E21ADC5;
	Fri, 27 Jun 2025 07:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="5ajjQfV4"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8FB1DED63
	for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 07:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751009011; cv=none; b=iVdQwe3jURy2Bmm9E27h4B7Kav6V+34cUoabx4xCtMtMe4K1SdwvdUBzdSEl61FnEPTRjcWSDfQ8Gyp+2oGovSpyR4RSNOrUYKPCsR6vziBzxaHE/iNfntswPuLHeD2WLOx4v36eTQXF93IQPsijuGKvhUdOPFCICL0rd0l1aDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751009011; c=relaxed/simple;
	bh=kB3jfqMnzGM+Dnk+s6bWnPG9C/cZ56WpFvIH6vjoZkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uAJgZnB5PqEYeGExdWmZBfv5aU5XKjQ0UG9iizgaQROaqmX2kUfvs3Ni5JOz9tbytikR3i4MqS2cGPvkHqSiIn9PBD8KB28cMi1C1lYw7MdfKqXpx1ybEzMEQnf/uVwwbUq10/p0urJAjCtYJDaLi8tu31KZM+BrKSoQxPYf+vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=5ajjQfV4; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id D487A4EF8A;
	Fri, 27 Jun 2025 09:23:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1751009008;
	bh=kB3jfqMnzGM+Dnk+s6bWnPG9C/cZ56WpFvIH6vjoZkk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=5ajjQfV4TmsQn8n7BV7HZJHyJQp+Q+6AZTBuTfgdjj9STUBRbua8GY029WJ3ujyvy
	 2zW4nAhfzrlNUyfFufnBMGEPyMP/ayHkhpcBw1IWGBVtzh4RHegQzRpdOYyHaSqE5B
	 furRxzxD+9fHMdHyTOLBCM1VWcxiDRKDyauum4Liq6BAJ6EjF0ZQ4zn09RaI7qsMl8
	 zaaFV6ttKWRTv4SPPg3jUjuM4LZH9ndRMk8eny1MLV5rBx8aCIR7iLbKEfEmULhcJU
	 GIhlSAIslxFhkwoXAqsmrZeEP45/pzatg3SnBnDe+XCTlvk5AQaVHXp6aNUA9hl3Hl
	 bMABWUcY+M2IQ==
Date: Fri, 27 Jun 2025 09:23:27 +0200
From: Joerg Roedel <joro@8bytes.org>
To: YangWencheng <east.moutain.yang@gmail.com>
Cc: suravee.suthikulpanit@amd.com, will@kernel.org, robin.murphy@arm.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: clear SME flag for mmio pages
Message-ID: <aF5G74hF9ZTjwpVD@8bytes.org>
References: <20250625064802.3640589-1-east.moutain.yang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625064802.3640589-1-east.moutain.yang@gmail.com>

On Wed, Jun 25, 2025 at 02:48:02PM +0800, YangWencheng wrote:
> If paddr is a mmio address, clear the SME flag. It makes no sense to
> set SME bit on MMIO address.

No Signed-off-by.



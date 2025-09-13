Return-Path: <linux-kernel+bounces-815059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5C7B55EDB
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 08:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 006F81CC26CE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 06:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0D92E6CD6;
	Sat, 13 Sep 2025 06:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="2Astz+p3"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27432E6CBC
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 06:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757743675; cv=none; b=VRKpTgSF4h4PVuCLHVFjTcjSkxzLnTpESiXi9mLI4b1twKHl2ICatyEECP3BZThxcoAhAJiR9gAFbDHDG1cdJErwW4CeEj5YiEPf4J2TkiogD86HzjVneUK42PXrR15gAOvBlWSelzLVcJvbNonni8m1UExQB1Ar+T5KZqQF7tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757743675; c=relaxed/simple;
	bh=IZAmRIn12H1ws1EBpMtxCKjZ7v/W9gcCO1MklaSOXk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fpRxKUkSDAhFIN+UMbQ4fowf136a5dS3eXmKxHlzRd0WPikSAfh9UT0vbWU4XEdyrKTQ0UWnpwaGpadcDaJKRQHkRsJZh9dR+0nVvz6yw5rFO2JDAMMo5/9SqvjJwls5/J6EhocioDhGNmgfSiMKv/MyTI4IlI9Xs7cWj3svgIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=2Astz+p3; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p54921b16.dip0.t-ipconnect.de [84.146.27.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id A91B850666;
	Sat, 13 Sep 2025 08:07:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1757743671;
	bh=IZAmRIn12H1ws1EBpMtxCKjZ7v/W9gcCO1MklaSOXk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2Astz+p3RJR5KWmv0+YIQv3aDHwwsttywLL9GmMaJmELgV6Ua4ppoge0lyMlauI06
	 OrsHNKcE6Czahdah0QlI2S9GQgZjBY9UkTBoOfxHs48DrTyO5IRErDYOG5VSbnmas1
	 oL3BBCFsQCxBKicaZy6xqVADh4+qtCmAtBDzIkmNIIhEq3+fQ40z7bllYay5DLGPZw
	 hGwvAh9DVH/qjUyi808k9tjXeLqZRb68L/uh3Q0CnQapykQ1cRISJoTG/xMzChVh/k
	 1CLf1xeMzBywCjdW9wmN+vBtHliv6Q+sOBPenMIvFNjO6R/IalDxps56lfJbIRlwRR
	 tq0aTJHFiCPuw==
Date: Sat, 13 Sep 2025 08:07:50 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Hector Martin <marcan@marcan.st>, Joerg Roedel <joerg.roedel@amd.com>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] iommu/io-pgtable-dart: Fix off by one error in table
 index check
Message-ID: <xae5ifnkyfh3idpuvjqxd2ui4lz2ptstozwiitl3xec2aroz4r@beni7t6fudbi>
References: <20250909-iommu-dart-tbl-check-fix-v1-1-c800a0375660@jannau.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909-iommu-dart-tbl-check-fix-v1-1-c800a0375660@jannau.net>

On Tue, Sep 09, 2025 at 01:54:43PM +0200, Janne Grunau wrote:
>  drivers/iommu/io-pgtable-dart.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.


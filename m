Return-Path: <linux-kernel+bounces-781218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84463B30F4C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 08:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27CCF5A09F6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 06:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2AC2E5D39;
	Fri, 22 Aug 2025 06:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="Qvukm80n"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1352E612F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755844911; cv=none; b=X2roUbDR2SL5temOWDqDZ8gxWzlvx/RJWLZOZBS2yBdKAeFiuAlRpnPOpBN5DWg/u+w7U4GKjOafiQJOX6MnjqO1+5ZFzNx3m0fyf7jI/gT2dKkDS86ABkTryWq0d1eecRVx+k6cNH6DUMywLiXpBHryN6CwMKcGjabcV1jOKC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755844911; c=relaxed/simple;
	bh=NhQFO0rePfsIm+ZuSFdYTBz/qr+Qp+tq0rchzzWcrKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFPrhEcUjwl34iu3LMl3EIaCbnm+FFH6e0LaMbJbgA+FrMjNDT5EpFh+4rMMyJdLH/H6kAc+5KjHo/8rh3XoyzzRqbZ6G8Ypab0no8Vv4bXPQRl+2y0KOuz4fOphqE/nVSyy+rdxPWetOVqxnYh2h+fUUyb3dbIwhQlvQkXNpIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=Qvukm80n; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p54921b16.dip0.t-ipconnect.de [84.146.27.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id A56A253456;
	Fri, 22 Aug 2025 08:41:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1755844907;
	bh=NhQFO0rePfsIm+ZuSFdYTBz/qr+Qp+tq0rchzzWcrKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qvukm80n6STPbGxXIfOPFQWT7Bgc/JfWVO8X2vhUtGP4Dv1SreJLa2AQ+4sOKRZOn
	 z+5JwuRNSbuaITzF6t9jYrQJ+WsCxmG/X/a59bPTL7mdfhXgu5a4un7Jz6X7fAe+Dr
	 AII/ZbysARLtKd0bYkhzJF45Kzy421lFZ8LuY3rESPxcq8rdKgJ6YeWKnQZEpDzGbF
	 CKm6xQ0ppY46BycIAZw8g+LyMSaDutN4yBrQokXgjicchJlOQ5xk5/aXnZnapRhXPY
	 8euzpOofx/fEqtUd+n+QPo3Ln0+iGMa8naR9DU/feWmcXU4l7LQmimFtguUKQ4ZEAl
	 kPvk/KadBIiww==
Date: Fri, 22 Aug 2025 08:41:46 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, will@kernel.org, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rc] iommu/arm-smmu-v3: Fix smmu_domain->nr_ats_masters
 decrement
Message-ID: <aKgRKnbBnZ51C-t-@8bytes.org>
References: <20250801030127.2006979-1-nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801030127.2006979-1-nicolinc@nvidia.com>

On Thu, Jul 31, 2025 at 08:01:27PM -0700, Nicolin Chen wrote:
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied for -rc, thanks.


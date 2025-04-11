Return-Path: <linux-kernel+bounces-599532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F325CA854F0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 09:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E815A4A7429
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 07:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9D8203710;
	Fri, 11 Apr 2025 07:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="t3klmQaH"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45461EB1AF
	for <linux-kernel@vger.kernel.org>; Fri, 11 Apr 2025 07:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744355199; cv=none; b=TiwjjNKkSXu4OX3ixZqpCHAAgHSMnvbXOIHhkZvlbO5wfDfDXu5OWR99a7oAN/+jxp62RoAdh309paQJ2/9m8gAMKnOBXWsJBhX1wxRUfYGeuwicY+iszY5ksBqcYr5ixO6efgIf2S1HGKiFiyWnM6N+98QwbxE5e/mFgUykDQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744355199; c=relaxed/simple;
	bh=L008RRlXzx048El9ZCx++GFr7w7OwfA1qc+yAj68hDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSIG3rfHr+dt36pwlxtkCZ3wjRq34e4t6FjsHWrw0OYWXXaYfX1oSkwJs7r+ncmxuZ5mhgz+VADUDslrb4487V9lJEQ+K01IW9x97uZ5uEDIkQWoTkPRXaGeyjzGKG9VlAkhQXlBN9yS6qG518HlwoKmmWmw6DWkyWLWOSJgoD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=t3klmQaH; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id C0B9346242;
	Fri, 11 Apr 2025 09:06:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1744355195;
	bh=L008RRlXzx048El9ZCx++GFr7w7OwfA1qc+yAj68hDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t3klmQaH465vF0tvr+RygxxODMYud1Y4jHuTVhCBIauINc0CGwxMjPMDBvDOu4wBF
	 6JEBDmUQT3HoRcIjljoc2EkE8jhhKCF8EeUXXbywpb0ulmygt5qaIkhMlJNukV43Yv
	 GWpqxF71ibjPlOyWL3B4i36nbOExE+oegeyYwqcBijL3JXRI8Kp6zrduueWyuXkao3
	 z9gdlXFCPHS3hDDZLoMB/dAi2Vy+P5XGQMIgBIdFX0DeyIRfEK55PYV1RTOVm9r1El
	 SOF/a0NVJaviHd1f95ucD6mBz+fB8G9eB6tgi1Z7jb5u46GUgNVZnUGrEE0b4T53tz
	 mWw79ErZqiy1g==
Date: Fri, 11 Apr 2025 09:06:34 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>,
	Petr Tesarik <ptesarik@suse.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] [PULL REQUEST] iommu/vt-d: Fixes for v6.15-rc2
Message-ID: <Z_i_er_c6i8sDbnj@8bytes.org>
References: <20250410073247.1454287-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410073247.1454287-1-baolu.lu@linux.intel.com>

On Thu, Apr 10, 2025 at 03:32:45PM +0800, Lu Baolu wrote:
> Petr Tesarik (1):
>   iommu/vt-d: Remove an unnecessary call set_dma_ops()
> 
> Sean Christopherson (1):
>   iommu/vt-d: Wire up irq_ack() to irq_move_irq() for posted MSIs
> 
>  drivers/iommu/intel/iommu.c         |  1 -
>  drivers/iommu/intel/irq_remapping.c | 29 +++++++++++++++--------------
>  2 files changed, 15 insertions(+), 15 deletions(-)

Applied, thanks Baolu.


Return-Path: <linux-kernel+bounces-899591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B4CC58794
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC88942792C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7A534027E;
	Thu, 13 Nov 2025 15:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="GcbwwR/P"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E91A33892C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 15:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763046849; cv=none; b=SNXmYflWV7D2bPDR9CIB7PZH3Kr8yjA+/6pARNMHMsPyexznbHOAObqY5m2IxMStNLYycKc4JB+UHCDFgD1FF5cEsqFJSq7TRB9MdX+stlBEkk5yMb92I67AnHMpPwjsVmK4COMQgIaSBrTOGDzVPA0V1xPWkIQVwpH4tv7RLQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763046849; c=relaxed/simple;
	bh=Fn7BM+iRiXSh29TtHYGBCDJ6QYtGrsMiOm5xLqDv/Ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLwZ09iFHem8+enaCf+Xy8mdpVw64Ht3hx/N/WKuosFNW9PqGHn5mcxSpRKTo62XR8qvDEmTsN7Pe+oW0iwzFrPfBWrvMhO2q+MlqOCQa/Ptt+dYv6Ze/2OyfKn7wqwLzt75SNbvPqJzvrVloK0NisxEhU9k4Src5P/B7tu4r5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=GcbwwR/P; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p549214ac.dip0.t-ipconnect.de [84.146.20.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 2B90359E1E;
	Thu, 13 Nov 2025 16:14:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1763046840;
	bh=Fn7BM+iRiXSh29TtHYGBCDJ6QYtGrsMiOm5xLqDv/Ec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GcbwwR/PcRO7MEJKX/lZOPldOj83mHjEyoXqw6YPiB/332vq9Dhvg2QqgS9TH9CBk
	 Y47zNDgkEJRbnrUr1PYetg7qExo9CiiYFTjhwt4BhTlVLDQWn74zAnSYMOWjxLgGRs
	 sr/CbDrkP+7zuRw5XUGp4efvZKWSrdhFYPeSyQFmiMFkRDExZKhy7R6/AcUM6j5cmQ
	 m5FQMIp6EDFRouAZZM5Ugwy68nIdBLqsg7Q46Fy/+FFVZQT3NnSpSTJ7ZxoUnScMYs
	 ucox9ZK1vWxdJU39KRI+PKNU61RHpuJLUQca/KyZdAeJBAaWh8sRAMBXdcJ4gSvNlb
	 95/i6DausuqbQ==
Date: Thu, 13 Nov 2025 16:13:57 +0100
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Cc: will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, suravee.suthikulpanit@amd.com, Vasant.Hegde@amd.com, 
	Santosh.Shukla@amd.com, Ankit Soni <Ankit.Soni@amd.com>
Subject: Re: [PATCH v5] iommu/amd: Enhance "Completion-wait Time-out" error
 message
Message-ID: <oj2duepunogk6zr3aicvh4dlwt2tltdq3kh4ke5nwuae2k7v7g@4jo2qsfiobhs>
References: <20251112211350.894-1-dheerajkumar.srivastava@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112211350.894-1-dheerajkumar.srivastava@amd.com>

On Thu, Nov 13, 2025 at 02:43:50AM +0530, Dheeraj Kumar Srivastava wrote:
> Current IOMMU driver prints "Completion-wait Time-out" error message with
> insufficient information to further debug the issue.
> 
> Enhancing the error message as following:
> 1. Log IOMMU PCI device ID in the error message.
> 2. With "amd_iommu_dump=1" kernel command line option, dump entire
>    command buffer entries including Head and Tail offset.
> 
> Dump the entire command buffer only on the first 'Completion-wait Time-out'
> to avoid dmesg spam.
> 
> Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
> Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>

Applied, thanks.


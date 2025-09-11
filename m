Return-Path: <linux-kernel+bounces-812681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EC7B53B59
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 20:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93E7B1CC5916
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5DE1C54A9;
	Thu, 11 Sep 2025 18:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m66MoVbH"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36111DA55
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 18:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757615269; cv=none; b=gnvP7z0DCEZvxOcXsGAmCfMk4AW20DNI4XWofEDM8sIZGDtt5sP+GEzN1IQoUpHA0Wtrz+8cylaejvUPpjntzy0Eet51YQbpG+EPLkwxQ9ijpsH1c1SU+Wda03ivBzYsFlaQ2fKz5Ls5LdkL2PqcR6vnTbnByr+5WfNdDKKpZkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757615269; c=relaxed/simple;
	bh=dMozuue/sJaEdI+2v0oGtDcTdVocJ4ZzaVwH4WcwWac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oh3Aj29sj+GbTYUA0qunGv6teQWlpvZPXCegxrN9KI3uAOrCbwH1fedZEmDOuTblGbf/Gztm/40yogYhupy9B68uP/i2Fz3NEc9UigJdIKjcdA56plgH9EPs6wCyXgcWa8Se6kDQVPYWcDybShqyjNimyrrXkyXvmBeLikLsPOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m66MoVbH; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 11 Sep 2025 11:27:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757615256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1PEqqMkQCCsIIK80US5++EkJbtoh1psej63veCBFsh0=;
	b=m66MoVbHAakOQHxhknbRV0aEtrzLIl0zCY5MZnXw/n2GB/8mMD2z8KI6sr7j6Zg2VMz5fZ
	LrEYbqoS2fE1sJyLz+JwXmPOOsVm1xe52j/yNKp+vJUnkU92KRcLd/H0qB2d1zMQk7NV3/
	0LIJakGffNrD7vjzin8Tacb4DAiuocM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Jack Thomson <jackabt.amazon@gmail.com>
Cc: maz@kernel.org, pbonzini@redhat.com, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, shuah@kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	isaku.yamahata@intel.com, roypat@amazon.co.uk,
	kalyazin@amazon.co.uk, jackabt@amazon.com
Subject: Re: [PATCH 1/6] KVM: arm64: Add __gmem_abort and __user_mem_abort
Message-ID: <aMMUiyPLd1-_-V5p@linux.dev>
References: <20250911134648.58945-1-jackabt.amazon@gmail.com>
 <20250911134648.58945-2-jackabt.amazon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911134648.58945-2-jackabt.amazon@gmail.com>
X-Migadu-Flow: FLOW_OUT

Hi Jack,

On Thu, Sep 11, 2025 at 02:46:43PM +0100, Jack Thomson wrote:
> From: Jack Thomson <jackabt@amazon.com>
> 
> Adding __gmem_abort and __user_mem_abort that preserve -EAGAIN results.
> These will be used by the pre-fault implementation which needs to retry
> on -EAGAIN.

-EAGAIN is a pretty clear signal that another vCPU has faulted on this
memory and is in the middle of installing a mapping. Why bother with
retrying?

If we conceptually treat this thing as a synthetic stage-2 abort then it
should use the same EAGAIN handling as a literal stage-2 abort.

Thanks,
Oliver


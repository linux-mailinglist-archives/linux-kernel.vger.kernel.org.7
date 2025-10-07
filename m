Return-Path: <linux-kernel+bounces-844492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C329CBC2104
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 18:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03B233BD187
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 16:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522522E7F05;
	Tue,  7 Oct 2025 16:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qiL9sVxE"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FEB2E7BA9
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 16:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759853546; cv=none; b=j+oXziel8ZOe02XN6q8o34+9pgOnzbgpv25Pt1Jceiv/kVcuxmIHjMdt/aMimcyqkxzjfjiFDTLNNNZvbIKpN27gVMCn8yQAYgsuYVjfWI8lP7JB3t1Stoba+qWc9pp1m9XlNUHsR1E+YZTNm8lKFMyNjv2qvw9eR4NotAeU6I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759853546; c=relaxed/simple;
	bh=TOa5aD4ty4/zr2xJ+koMUG4SVFqd7BqadUbkLOnBm/0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s/l3/0CwBenbsyzrC922vCP7iPpsm8QfcNrUzWWwppktpxt9+9yPK/7hzMlhlyfSRNU7OFT5Vvu7/z+Y3zW7Klhgno+TzVMgKxW48zevXRXD4hOFvr9L0RdqlNueiJGordf9QGhSQOg2AYGHJBspzmfHIoVFn/z5+Xt3xd6nhpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qiL9sVxE; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost (unknown [20.236.10.206])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0225E2038B40;
	Tue,  7 Oct 2025 09:12:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0225E2038B40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759853543;
	bh=AJqqQvdc28AXwWiBY6Lv3FwYW12GjKCxyp1/pICbHjg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qiL9sVxEFeB4h4rdWGRHQkMf8YMGJ9gqaOURzLEj85871HSIZiICB+ip9Op3dFv77
	 TtVaRtp2djcPfPMddBYhGijXSryU2WfoRhCyD4SFQq4nX8APV98GcpD4bocP/6n8xe
	 aPnyUf/GZEguUXmgO61FyZIdQjyzQcfQ3RNUCpUk=
Date: Tue, 7 Oct 2025 09:12:20 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: <linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Will Deacon <will@kernel.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>, Zhang Yu
 <zhangyu1@linux.microsoft.com>, Jean Philippe-Brucker
 <jean-philippe@linaro.org>, Alexander Grest <Alexander.Grest@microsoft.com>
Subject: Re: [PATCH 1/2] iommu/arm-smmu-v3: Fix CMDQ timeout warning
Message-ID: <20251007091220.00003a44@linux.microsoft.com>
In-Reply-To: <aORieLYckU9YLdVF@nvidia.com>
References: <20250924175438.7450-1-jacob.pan@linux.microsoft.com>
	<20250924175438.7450-2-jacob.pan@linux.microsoft.com>
	<aORieLYckU9YLdVF@nvidia.com>
Organization: LSG
X-Mailer: Claws Mail 3.21.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 Oct 2025 17:44:40 -0700
Nicolin Chen <nicolinc@nvidia.com> wrote:

> On Wed, Sep 24, 2025 at 10:54:37AM -0700, Jacob Pan wrote:
> > While polling for n spaces in the cmdq, the current code instead
> > checks if the queue is full. If the queue is almost full but not
> > enough space (<n), then the CMDQ timeout warning is never triggered
> > even if the polling has exceeded timeout limit.  
> 
> This does sound like an issue that is missing a warning print.
yeah, without this warning our debug has to start with much later soft
lockup trace.

> > This patch polls for the availability of exact space instead of
> > full and emit timeout warning accordingly.  
> 
> And the solution sounds plausible as well.
> 
> > @@ -806,10 +769,28 @@ int arm_smmu_cmdq_issue_cmdlist(struct
> > arm_smmu_device *smmu, do {
> >  		u64 old;
> >  
> > +		queue_poll_init(smmu, &qp);
> >  		while (!queue_has_space(&llq, n + sync)) {
> >  			local_irq_restore(flags);
> > -			if
> > (arm_smmu_cmdq_poll_until_not_full(smmu, cmdq, &llq))
> > -				dev_err_ratelimited(smmu->dev,
> > "CMDQ timeout\n");
> > +			/*
> > +			 * Try to update our copy of cons by
> > grabbing exclusive cmdq access. If
> > +			 * that fails, spin until somebody else
> > updates it for us.
> > +			 */
> > +			if
> > (arm_smmu_cmdq_exclusive_trylock_irqsave(cmdq, flags)) {
> > +				WRITE_ONCE(cmdq->q.llq.cons,
> > readl_relaxed(cmdq->q.cons_reg));
> > +
> > arm_smmu_cmdq_exclusive_unlock_irqrestore(cmdq, flags);
> > +				llq.val =
> > READ_ONCE(cmdq->q.llq.val);
> > +				local_irq_save(flags);
> > +				continue;
> > +			}
> > +
> > +			ret = queue_poll(&qp);
> > +			if (ret == -ETIMEDOUT) {
> > +				dev_err_ratelimited(smmu->dev,
> > "CPU %d CMDQ Timeout, C: %08x, CW:%x P: 0x%08x PW: %x cmdq.lock
> > 0x%x\n",
> > +
> > smp_processor_id(), Q_IDX(&llq, llq.cons), Q_WRP(&llq, llq.cons),
> > Q_IDX(&llq, llq.prod), Q_WRP(&llq, llq.prod),
> > atomic_read(&cmdq->lock));
> > +				queue_poll_init(smmu, &qp);
> > +			}
> > +			llq.val = READ_ONCE(cmdq->q.llq.val);
> >  			local_irq_save(flags);  
> 
> But, couldn't we write a new arm_smmu_cmdq_poll_until_enough_space()
> simply replacing arm_smmu_cmdq_exclusive_unlock_irqrestore()?
> 
Yes, I can extract the above polling for queue_has_space() into a new
arm_smmu_cmdq_poll_until_enough_space() function. I agree it will be
more readable.

But I am not following what you mean by "replacing
arm_smmu_cmdq_exclusive_unlock_irqrestore()", could you elaborate?

> This whole unwrapped piece is really not easy to read :(
> 
> Also, the new error message has too much debugging info, which could
> be trimmed away, IMHO. Though kernel coding now does allow a higher
> limit per line, that 200-ish-character line is a bit overdone :-/

agreed. will reduce.

> Nicolin



Return-Path: <linux-kernel+bounces-832837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D6FBA0896
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 18:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6964D3BAB9D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1654303CBB;
	Thu, 25 Sep 2025 16:04:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07D92EC08C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 16:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758816284; cv=none; b=jAj3khOMjvofIiaUIJhdDBmuZC332YoMy92NBAMmQI5N3XoQpI/xwR2ic17BswUIORiEPA3TR9WwHR6SJATVOGMW4C8KzJzGjJUHfrQrI2N6sUx++SYHWhuId3BPkjfNm3PVl201i/LAOzHx9s+4N+hoN4wwdOWfCJfA4Oum154=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758816284; c=relaxed/simple;
	bh=7KIMIrwdi4UhSiEDt+IdaPb2j2bnoGnX++P/yjvjKFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8VgyRkCK2oRFHvFmCHln9zGhbl0hrhri8yOH2OxG1EGdn8zdI6mu77qLFDk1ysoZZnzgefAOYOc06sdbGhn6/j2jAJAWa+exDIm49yoZYQknk50Gr5LpSE5LaW0vvHCGgoZywX3Q6Rry8ClDA7JLFrTUN1oECyIIVC4sBBwL6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19AA31692;
	Thu, 25 Sep 2025 09:04:34 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C45EE3F694;
	Thu, 25 Sep 2025 09:04:41 -0700 (PDT)
Date: Thu, 25 Sep 2025 17:04:40 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	Jie Gan <jie.gan@oss.qualcomm.com>,
	Carl Worth <carl@os.amperecomputing.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/3] coresight: tmc: add the handle of the event to
 the path
Message-ID: <20250925160440.GD7985@e132581.arm.com>
References: <20250922-fix_helper_data-v1-0-905e8115a24e@oss.qualcomm.com>
 <20250922-fix_helper_data-v1-1-905e8115a24e@oss.qualcomm.com>
 <874isuo0m2.fsf@rasp.cworth.amperemail.amperecomputing.com>
 <f7be3833-9b33-4935-b821-a2e0000a2557@oss.qualcomm.com>
 <CAJ9a7VjaUE+iy=FFwPhCdfXgoGR3rP9WSx-ZkKYeCHhqJ2yzMg@mail.gmail.com>
 <3b16607f-8995-46b1-aecf-c6aa79f66f9d@arm.com>
 <635ba698-d7a9-40d0-9285-4ec108d4a536@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <635ba698-d7a9-40d0-9285-4ec108d4a536@linaro.org>

On Thu, Sep 25, 2025 at 11:10:51AM +0100, James Clark wrote:

> > > I would suggest in the csdev (coresight_device) structure itself. We
> > > already have some sink specific data in here e.g. perf_sink_id_map.

[...]

> > I think this data is specific to the session we are enabling the
> > device(s) in. e.g., we keep the trace-id in the path.
> > So, I don't mind having this in the path structure.
> > Instead of modifying csdev with additional locking from "etm-perf"
> > it is always cleaner to handle this in the path.
> 
> Yeah, and perf_sink_id_map only "needs" to be in the csdev because it
> controls sharing IDs between multiple paths which can't be accomplished by
> storing it in the path.

This is a bit off-topic: do we really need to maintain an id_map in
every sink device, or could we simply use a global id_map?

I might miss some info; anyway, consolidating trace IDs is a low
priority for me and not critical to this thread. But this might be
benefit for later refactoring.

Thanks,
Leo


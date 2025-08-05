Return-Path: <linux-kernel+bounces-756131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B2EB1B060
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 10:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E5523A4013
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 08:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007D4258CE2;
	Tue,  5 Aug 2025 08:46:44 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136CB21ABDB
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 08:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754383603; cv=none; b=Mq05GNOzRXt7SGt1xu1110SGn8hIi4qK5IQNi//5iwmfydwGVSWItCtn4Tvevqqpkg/HtoxtOzpyV4tMgyahnvfSBReyEtHbe0PM56rvIFNhnQo3uk7C8N+HQfdiQ/K/e3E4QyAYW5ovgoIMKbBX2Xd/2h1Ftr200PkvODGs4+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754383603; c=relaxed/simple;
	bh=K4h0T2ildZj6Cfg8pZyvhmYiC7KtOHW0aA7PSChKXRI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lY8ANLn9IBXMy9Fhf7N5DuJsJZ3aJb36K3czLBf0+JhDfaJ+K/MAyF0o+cJd/DfWlZxW9TdiumtsfC31w1J4DckkYzAOw8n9LW10OOV817UG/KAmMHfiHPPTKUZuRxfZFhUJO25RdMRzAOqy5my3WL9D6gllEhMDyAXGc+qjSRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bx6S263Wkz6DBg1;
	Tue,  5 Aug 2025 16:44:50 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 2C12B1402F0;
	Tue,  5 Aug 2025 16:46:36 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 5 Aug
 2025 10:46:35 +0200
Date: Tue, 5 Aug 2025 09:46:33 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: James Morse <james.morse@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	"Rob Herring" <robh@kernel.org>, Ben Horgan <ben.horgan@arm.com>, Rohit
 Mathew <rohit.mathew@arm.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
	"Zeng Heng" <zengheng4@huawei.com>, Lecopzer Chen <lecopzerc@nvidia.com>,
	"Carl Worth" <carl@os.amperecomputing.com>,
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <lcherian@marvell.com>,
	<bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
	<baolin.wang@linux.alibaba.com>, Jamie Iles <quic_jiles@quicinc.com>, Xin Hao
	<xhao@linux.alibaba.com>, <peternewman@google.com>, <dfustini@baylibre.com>,
	<amitsinght@marvell.com>, David Hildenbrand <david@redhat.com>, Rex Nie
	<rex.nie@jaguarmicro.com>, Dave Martin <dave.martin@arm.com>, Koba Ko
	<kobak@nvidia.com>
Subject: Re: [RFC PATCH 17/36] arm_mpam: Add cpuhp callbacks to probe MSC
 hardware
Message-ID: <20250805094633.00003e7c@huawei.com>
In-Reply-To: <20250711183648.30766-18-james.morse@arm.com>
References: <20250711183648.30766-1-james.morse@arm.com>
	<20250711183648.30766-18-james.morse@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 11 Jul 2025 18:36:29 +0000
James Morse <james.morse@arm.com> wrote:

> Because an MSC can only by accessed from the CPUs in its cpu-affinity
> set we need to be running on one of those CPUs to probe the MSC
> hardware.
> 
> Do this work in the cpuhp callback. Probing the hardware will only
> happen before MPAM is enabled, walk all the MSCs and probe those we can
> reach that haven't already been probed.
> 
> Later once MPAM is enabled, this cpuhp callback will be replaced by
> one that avoids the global list.
> 
> Enabling a static key will also take the cpuhp lock, so can't be done
> from the cpuhp callback. Whenever a new MSC has been probed schedule
> work to test if all the MSCs have now been probed.
> 
> CC: Lecopzer Chen <lecopzerc@nvidia.com>
> Signed-off-by: James Morse <james.morse@arm.com>
Hi James,

One trivial thing noticed whilst testing..

> @@ -513,9 +541,84 @@ int mpam_ris_create(struct mpam_msc *msc, u8 ris_idx,
>  	return err;
>  }
>  
> -static void mpam_discovery_complete(void)
> +static int mpam_msc_hw_probe(struct mpam_msc *msc)
>  {
> -	pr_err("Discovered all MSC\n");
> +	u64 idr;
> +	int err;
> +
> +	lockdep_assert_held(&msc->probe_lock);
> +
> +	mutex_lock(&msc->part_sel_lock);
> +	idr = mpam_read_partsel_reg(msc, AIDR);
> +	if ((idr & MPAMF_AIDR_ARCH_MAJOR_REV) != MPAM_ARCHITECTURE_V1) {
> +		pr_err_once("%s does not match MPAM architecture v1.0\n",
You are only checking MAJOR REV which is probably the right thing to do
but in that case maybe change the message to be v1.x ?

> +			    dev_name(&msc->pdev->dev));
> +		err = -EIO;
> +	} else {
> +		msc->probed = true;
> +		err = 0;
> +	}
> +	mutex_unlock(&msc->part_sel_lock);
> +
> +	return err;
> +}
> +


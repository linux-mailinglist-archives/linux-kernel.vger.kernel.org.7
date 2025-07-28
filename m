Return-Path: <linux-kernel+bounces-748337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E41B13FBE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 18:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF44E7A68E3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 16:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6347C274FF9;
	Mon, 28 Jul 2025 16:16:37 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0ADB2745C
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 16:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753719397; cv=none; b=Qhba9lm9MJTPIJz2F2RVUmpXkHETkQBbCOEwluQfJrXQ3Qxt9oEz1hePSmiMocoifeILZjHIYcHZViGIYWGWvZNBGI/wksuAdhxvuCxgYdwZayZvYKJ59A/hX81tLV6E4nQ6XgFgxfngzCSXZmqWFEKAUhVnfJJUBDWgoq435dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753719397; c=relaxed/simple;
	bh=Ra3EpKFG5lZHIr9+wwD9BF2NKExJ+D9VpKnfYB0xC2o=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MTxY2WSneOs8Dd5AtDUnu2MeYOnajvTl7fStEf0vjEbpUwvrvc92cNpmy7r4XCe3GCOIptX4qJoqgHK3lgNf5D/k46dGgk/r3OdQnP2LXSTPl3KKf2c1861iJKip6oVDO0xDXCsVsXSUuhAnfl0tdhPEtrbGcejSTv0rRGbKdPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4brNpn1yDqz6L5Sd;
	Tue, 29 Jul 2025 00:14:41 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 154C51402EB;
	Tue, 29 Jul 2025 00:16:31 +0800 (CST)
Received: from localhost (10.122.19.247) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 28 Jul
 2025 18:16:29 +0200
Date: Mon, 28 Jul 2025 17:16:28 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Ben Horgan <ben.horgan@arm.com>
CC: James Morse <james.morse@arm.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Rob Herring <robh@kernel.org>, "Rohit
 Mathew" <rohit.mathew@arm.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
	Zeng Heng <zengheng4@huawei.com>, Lecopzer Chen <lecopzerc@nvidia.com>, Carl
 Worth <carl@os.amperecomputing.com>, <shameerali.kolothum.thodi@huawei.com>,
	D Scott Phillips OS <scott@os.amperecomputing.com>, <lcherian@marvell.com>,
	<bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
	<baolin.wang@linux.alibaba.com>, Jamie Iles <quic_jiles@quicinc.com>, Xin Hao
	<xhao@linux.alibaba.com>, <peternewman@google.com>, <dfustini@baylibre.com>,
	<amitsinght@marvell.com>, David Hildenbrand <david@redhat.com>, Rex Nie
	<rex.nie@jaguarmicro.com>, Dave Martin <dave.martin@arm.com>, Koba Ko
	<kobak@nvidia.com>
Subject: Re: [RFC PATCH 20/36] arm_mpam: Probe the hardware features resctrl
 supports
Message-ID: <20250728171628.00001cd3@huawei.com>
In-Reply-To: <eb8a395c-ca21-43d2-a1f9-739dbdc26dc4@arm.com>
References: <20250711183648.30766-1-james.morse@arm.com>
	<20250711183648.30766-21-james.morse@arm.com>
	<eb8a395c-ca21-43d2-a1f9-739dbdc26dc4@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500008.china.huawei.com (7.182.85.71)

}
> >   
> > +/*
> > + * IHI009A.a has this nugget: "If a monitor does not support automatic behaviour
> > + * of NRDY, software can use this bit for any purpose" - so hardware might not
> > + * implement this - but it isn't RES0.
> > + *
> > + * Try and see what values stick in this bit. If we can write either value,
> > + * its probably not implemented by hardware.
> > + */
> > +#define mpam_ris_hw_probe_hw_nrdy(_ris, _mon_reg, _result)			\
> > +do {										\
> > +	u32 now;								\
> > +	u64 mon_sel;								\
> > +	bool can_set, can_clear;						\
> > +	struct mpam_msc *_msc = _ris->vmsc->msc;				\
> > +										\
> > +	if (WARN_ON_ONCE(!mpam_mon_sel_inner_lock(_msc))) {			\
> > +		_result = false;						\
> > +		break;								\
> > +	}									\
> > +	mon_sel = FIELD_PREP(MSMON_CFG_MON_SEL_MON_SEL, 0) |			\
> > +		  FIELD_PREP(MSMON_CFG_MON_SEL_RIS, _ris->ris_idx);		\
> > +	mpam_write_monsel_reg(_msc, CFG_MON_SEL, mon_sel);			\
> > +										\
> > +	mpam_write_monsel_reg(_msc, _mon_reg, MSMON___NRDY);			\
> > +	now = mpam_read_monsel_reg(_msc, _mon_reg);				\
> > +	can_set = now & MSMON___NRDY;						\
> > +										\
> > +	mpam_write_monsel_reg(_msc, _mon_reg, 0);				\
> > +	now = mpam_read_monsel_reg(_msc, _mon_reg);				\
> > +	can_clear = !(now & MSMON___NRDY);					\
> > +	mpam_mon_sel_inner_unlock(_msc);					\
> > +										\
> > +	_result = (!can_set || !can_clear);					\
> > +} while (0)  
> It is a bit surprising that something that looks like a function 
> modifies a boolean passed by value. Consider continuing the pattern you 
> have above:
> #define mpam_ris_hw_probe_hw_nrdy(_ris, _mon_reg, _result) 
> _mpam_ris_hw_probe_hw_nrdy(_ris, MSMON##_mon_reg, _result)
> 
> with signature:
> void _mpam_ris_hw_probe_hw_nrdy(struct mpam_msc *msc, u16 reg, bool 
> *hw_managed);
> 
> and using the _mpam functions from the new _mpam_ris_hw_probe_hw_nrdy().
> 

Agreed that this is ugly.  Only a tiny bit of macro stuff is actually going on here.
I'd make it function.

If you really want to construct MSMON_CSU etc then wrap that helper with
a macro that builds reg from the name.

I might have missed something though in converting this.
The version I have has some other changes though so not trivial to post here :(





Return-Path: <linux-kernel+bounces-899733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF7FC58BF3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 50EAB34A8BD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1391B306495;
	Thu, 13 Nov 2025 16:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wYj7kFN0"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D28303C81
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763049646; cv=none; b=Ai++cguzDYLW9T+LQRihluMSP605OR20iGH5j8KveXsCG3di/BpGKF77X4m6ZDpoYrY5qoyReTeDN5PDr/9CANEZovWwBVohSDoz3ZaKJdJsvEOzaEJ3DuX5JgtYSrAzH4YuJtwpsTZui7djdhXjZKXjDF9jnpFiIymyxjHrMV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763049646; c=relaxed/simple;
	bh=GVF+/h/LJTdxRP1ZtmC621CmOgcKo6hwIwZpoupHaeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s+Hvt9tFTVesCAUEOGj2THcERB5TzcwxJCyY/dCuCESVQ332bo7boJBZP/SdtnyQLgN5hzByrbSy5D6lHwhKPyoPlXgiRvF6kp2bBzo57k6RFAWVfTLBPml1ZhDSIujQdO85LbVPoI1pxYhxYYHk+ALnUxWTD07re+kf7TmlWZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wYj7kFN0; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763049641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nrP7Gp+eF5NahttnTnvgNwZULrq3e5/I28tBchxZyz4=;
	b=wYj7kFN0sTEDAng8vbV5v/enVBVSST/zKRJ5m01CIdc6tiCAuUznFpK6DINro4Vlx1rr51
	y4NV7WiXWN0QQFVJR4wXDybMpCVLu1hKa8Ftyk1BkgDxECVppm/5jpfBQlYz1QPgNDDXUY
	0anLuUAiLdIBbPxTYvqHRauxZS8vcnw=
From: Yuntao Wang <yuntao.wang@linux.dev>
To: robh@kernel.org
Cc: akpm@linux-foundation.org,
	bhe@redhat.com,
	catalin.marinas@arm.com,
	changyuanl@google.com,
	chenzhou10@huawei.com,
	devicetree@vger.kernel.org,
	geert+renesas@glider.be,
	graf@amazon.com,
	james.morse@arm.com,
	linux-kernel@vger.kernel.org,
	rppt@kernel.org,
	saravanak@google.com,
	takahiro.akashi@linaro.org,
	thunder.leizhen@huawei.com,
	yuntao.wang@linux.dev
Subject: Re: [PATCH 00/10] of/fdt: Some bug fixes and cleanups
Date: Fri, 14 Nov 2025 00:00:20 +0800
Message-ID: <20251113160020.227664-1-yuntao.wang@linux.dev>
In-Reply-To: <20251112205551.GC2155854-robh@kernel.org>
References: <20251112205551.GC2155854-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Wed, 12 Nov 2025 14:55:51 -0600, Rob Herring <robh@kernel.org> wrote:

> On Wed, Nov 12, 2025 at 10:35:10PM +0800, Yuntao Wang wrote:
> > This patch series fixes several bugs related to dt_root_addr_cells and
> > dt_root_size_cells, and performs some cleanup.
> > 
> > Links to the previous related patches:
> > 
> > https://lore.kernel.org/lkml/CAL_JsqJxar7z+VcBXwPTw5-Et2oC9bQmH_CtMtKhoo_-=zN2XQ@mail.gmail.com/
> > 
> > Yuntao Wang (10):
> >   of/fdt: Introduce dt_root_addr_size_cells() and
> >     dt_root_addr_size_bytes()
> >   of/reserved_mem: Use dt_root_addr_size_bytes() instead of open-coding
> >     it
> >   of/reserved_mem: Use dt_root_addr_size_bytes() instead of open-coding
> >     it
> >   of/reserved_mem: Use dt_root_addr_size_bytes() instead of open-coding
> >     it
> 
> Your aim in writing subjects should be to write something that is unique 
> for every commit in the past or future. Because you can never make the 
> same change twice, right? (I'm excluding 'fix typos/spelling' type 
> commits). Certainly the same subject in one series is never right.
> 
> >   of/fdt: Use dt_root_addr_size_bytes() instead of open-coding it
> >   of/fdt: Fix the len check in early_init_dt_check_for_elfcorehdr()
> >   of/fdt: Fix the len check in
> >     early_init_dt_check_for_usable_mem_range()
> >   of/fdt: Use dt_root_addr_size_bytes() instead of open-coding it
> 
> This is not what I meant. We have multiple copies of this where only 
> the property name changes: 
> 
> 	prop = of_get_flat_dt_prop(node, "linux,elfcorehdr", &len);
> 	if (!prop || (len < (dt_root_addr_cells + dt_root_size_cells)))
> 		return;
> 
> 	elfcorehdr_addr = dt_mem_next_cell(dt_root_addr_cells, &prop);
> 	elfcorehdr_size = dt_mem_next_cell(dt_root_size_cells, &prop);
> 
> Instead, add a function something like this:
> 
> static void early_init_dt_read_address(unsigned long node, const char 
> *prop, u64 *addr, u64*size)
> {
>         prop = of_get_flat_dt_prop(node, prop, &len);
>         if (!prop || (len < (dt_root_addr_cells + dt_root_size_cells)))
>                 return;
> 
>         *addr = dt_mem_next_cell(dt_root_addr_cells, &prop);
>         *size = dt_mem_next_cell(dt_root_size_cells, &prop);
> }
> 
> Then we only have the length checks in one place.
> 
> 
> That still leaves the cases with more than 1 entry open coded. So 
> instead, to cover that case to something like this:
> 
> const __be32 *of_get_flat_dt_address_prop(unsigned long node, const char 
> *propname, int *len)
> {
> 	prop = of_get_flat_dt_prop(node, propname, &len);
> 	if (!prop || (*len % (dt_root_addr_cells + dt_root_size_cells))) {
> 		*len = 0;
> 		return NULL;
> 	}
> 
> 	*len /= (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32);
> 	return prop;
> }
> 
> And then a user would look something like this:
> 
> prop = of_get_flat_dt_address(node, "linux,usable-memory-range", &len);
> for (i = 0; i < len; i++) {
> 	of_read_address_idx(prop, i, &addr, &size);
> 	...
> }
> 
> Here 'len' is number of addr+size entries.
> 
> And the simple case of reading 1 entry could be just:
> 
> of_read_address_idx(of_get_flat_dt_address(node, "linux,elfcorehdr", NULL), 0, &addr, &size);
> 
> Rob

Hi Rob,

The link to the new patch series:

https://lore.kernel.org/linux-devicetree/20251113155104.226617-1-yuntao.wang@linux.dev/t/

Thanks,
Yuntao


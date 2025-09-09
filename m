Return-Path: <linux-kernel+bounces-807323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A55AB4A2F8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E242F16588B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CAE259CB6;
	Tue,  9 Sep 2025 07:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T16KC8ml"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C143304BCC
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 07:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757401653; cv=none; b=BfNHF7mZEksVboaIx75KFjgsoGhK+TmRWFrfJWWc8wq4zS59wYQZemONYNQRCXAnf/ElN6QZ8pgZQJeMnRhZ8zhnrMmRiJix3Ai1s1JdOqo3QRFi83rGlaSjWhuBotVhA/7kjPG34Jsumry9nKPrJPCtPpBK2zcnisb90XUvua8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757401653; c=relaxed/simple;
	bh=57+0YQziYqecPHtLajoeNZmbiHa2zO1UhUeucPIkHpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qoUEWD1Uslz22hNgmL1Ct+nr4sRhfbnf64WQlBB72s+/yRt+IpF8giXivpoXsCxZWH6lBA9WwenVzEDZuBg/vtxCW0b2Yw1S0CpiGsEJfMayjMe08XBzKUeQyDutKFb75FM1rNBXCYp5CIvO6+XKhQDhECTddGLf5+Qihp/GGzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T16KC8ml; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 9 Sep 2025 00:07:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757401640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1sCkCgaiG1tA44yfM5L2ANo4vr5hbJ7W7Dhy275RGto=;
	b=T16KC8mlkc5FGJYRuNmRzyykNMCR64eNY9Ro4AI2qiVGUT9isxX9alIMp3XWcO7yseGGfg
	BnOhQMDKGXI7yO4Cpi9xkcifSVD8E2ML6BOsNywRtslYQYzYHm9KCO91uDTv60onUenJMg
	9kPyXnW9BljanSa6ge2DE3kT/RI9Ezw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Jinqian Yang <yangjinqian1@huawei.com>
Cc: yuzenghui@huawei.com, maz@kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, liuyonglong@huawei.com,
	wangzhou1@hisilicon.com
Subject: Re: [PATCH v2 1/3] KVM: arm64: Make ID_AA64MMFR1_EL1.HCX writable
 from userspace
Message-ID: <aL_SIwQiz3QO1fKe@linux.dev>
References: <20250909034415.3822478-1-yangjinqian1@huawei.com>
 <20250909034415.3822478-2-yangjinqian1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909034415.3822478-2-yangjinqian1@huawei.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Sep 09, 2025 at 11:44:13AM +0800, Jinqian Yang wrote:
> Allow userspace to downgrade HCX in ID_AA64MMFR1_EL1. Userspace can
> only change this value from high to low.
> 
> Signed-off-by: Jinqian Yang <yangjinqian1@huawei.com>

I'm not sure our quality of emulation is that great in this case. We
have no way of trapping the register and it is always stateful. Better
yet, our RESx infrastructure doesn't account for the presence of
FEAT_HCX and we happily merge the contents with the host's HCRX.

We should make a reasonable attempt at upholding the architecture before
allowing userspace to de-feature FEAT_HCX.

Thanks,
Oliver


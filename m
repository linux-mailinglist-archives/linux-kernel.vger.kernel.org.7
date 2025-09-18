Return-Path: <linux-kernel+bounces-807177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EB2B4A13E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A759A1B215AE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 05:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D8C2264A3;
	Tue,  9 Sep 2025 05:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nysw+ADO"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FCA1A262A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 05:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757395967; cv=none; b=S92TS0ibDYG4mQ/eq3I/fcJ6VKDl9VFC7H1bFNLQByzQ/MhAVLetrIw5rpSl4xsgZSWks4bFG/HKp7/qJ9xc9Ii19DCL9Y2I093xj82koc2NNtfPlDrLrhcGI6vMrlWowZMZ29Be9iQVR59SHPYjmz1NPcX7c2RBO2/P+3Oyoc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757395967; c=relaxed/simple;
	bh=imesH7ee1efEYQAis7K/XjX8z18kK0xO5koWlMOvmiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNgsrkn25Dna97MO6wy5uEMxaIrbfbFTZYPAf/aHzm1MhtakS4rIhR5KWwaSAw15AhjrI17aBTqTxutY49G5jInk+Y1c4PLZyPecxzEnrN+Ly64n662hmzRugR2uUcgDEJMF7LrSybOnuvCT3Ke5ywzz1DhEDaTKqwV/ei4s3qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nysw+ADO; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 8 Sep 2025 22:32:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757395962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=imesH7ee1efEYQAis7K/XjX8z18kK0xO5koWlMOvmiI=;
	b=nysw+ADOUYBJhMYLzPVCtQSvTHBZoDKuq6+zkvVv/H9ua8HqZtlH/oAXQJwrXPNwcPwIWq
	lgPISzjIK+CMqjeUfpElrtoNDNgkDE823Vo0Em8mBp3zeg37tT27DSktVcMb1X0HHmgOzW
	rd97cI6mO25B3ViXjDfLEeqWdEfbOqI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Jinqian Yang <yangjinqian1@huawei.com>
Cc: yuzenghui@huawei.com, maz@kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, liuyonglong@huawei.com,
	wangzhou1@hisilicon.com
Subject: Re: [PATCH v2 3/3] KVM: arm64: Make ID_AA64MMFR1_EL1.VH writable
 from userspace
Message-ID: <aL-788d0xWThAVSl@linux.dev>
References: <20250909034415.3822478-1-yangjinqian1@huawei.com>
 <20250909034415.3822478-4-yangjinqian1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909034415.3822478-4-yangjinqian1@huawei.com>
X-Migadu-Flow: FLOW_OUT

Hi Jinqian,

On Tue, Sep 09, 2025 at 11:44:15AM +0800, Jinqian Yang wrote:
> Allow userspace to downgrade VH in ID_AA64MMFR1_EL1. Userspace can
> only change this value from high to low.

I'm afraid we can't allow this. When we expose FEAT_VHE to the VM,
HCR_EL2.E2H is RES1. Meaning, vEL2 is unconditionally in a VHE
context.

I would be OK with a clarifying comment documenting why the field is
non-writable.

Thanks,
Oliver


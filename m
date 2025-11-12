Return-Path: <linux-kernel+bounces-898215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F927C549C3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 22:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B97D84E29FB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 21:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CCC2D9792;
	Wed, 12 Nov 2025 21:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="am92Mmc6"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953352673B0
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 21:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762982540; cv=none; b=mbfWgbBaQbvcIX5TNHODJmxry7aCnMMpIYxcUpNTIPmoG7rRvwnGiQJZZgJ5uIcTQNBwaQdvBrvY+4gWyA51qX0qR/4dmHLvof0E2/KMZJX4s9yrECU/q/hWn8FrZFj4OPfRAY+ANW1bkInFMMBMzkrvifzochh4EDXj8J3oraE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762982540; c=relaxed/simple;
	bh=4SgRlDDvU5istjyUir1XwDs733sVp33z3Rp103M2gAQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jjw5XHP3bORRc2cI9SOK80e1AAExdwFUPfS896HrjvbYqur7ic7jT4NySD5Heo+X7vedbDBVp921SSFdhRQZ007xqU0aqLHiWf2WCS9vaIoBSqkDq/x/X7wdni9pfLWN85jkT34vchdG4UIMkLrA5hLCFBn80ghFn7XoQb3QlPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=am92Mmc6; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762982526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4SgRlDDvU5istjyUir1XwDs733sVp33z3Rp103M2gAQ=;
	b=am92Mmc6V1CmAgaBbJ+aUSSO3USMV7oCACilqoA2O+FCF6/5JIJlOUvyH8rgcfuNMMZSAu
	7kT2b0mvzdMcQmhqnFG/x6JkWwwuhY2VFfmssN7hit5UIb504pdV/1MkW4rBfLegpt0occ
	/JuhJ/WilLM64y6Y23zmRhI/FjboKak=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH RESEND] KVM: TDX: Use struct_size and simplify
 tdx_get_capabilities
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <4a2a74e01bfd31bc4bd7a672452c2d3d513c33db.camel@intel.com>
Date: Wed, 12 Nov 2025 22:22:02 +0100
Cc: "seanjc@google.com" <seanjc@google.com>,
 "x86@kernel.org" <x86@kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "bp@alien8.de" <bp@alien8.de>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "hpa@zytor.com" <hpa@zytor.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "kas@kernel.org" <kas@kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <79605B58-CBB6-460D-8B72-F648F962E1BA@linux.dev>
References: <20251112171630.3375-1-thorsten.blum@linux.dev>
 <4a2a74e01bfd31bc4bd7a672452c2d3d513c33db.camel@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
X-Migadu-Flow: FLOW_OUT

On 12. Nov 2025, at 20:59, Edgecombe, Rick P wrote:
> It looks like you are conducting a treewide pattern matching cleanup?

Just a few instances here and there, but not really treewide.

> In the handling of get_user(nr_user_entries, &user_caps->cpuid.nent), =
the old
> code forced -EFAULT, this patch doesn't. But it leaves the =
copy_to_user()'s to
> still force EFAULT. Why?

get_user() already returns -EFAULT and the error can just be forwarded,
whereas copy_to_user() returns the number of bytes that could not be
copied and we must return -EFAULT manually.

> Tested-by: Rick Edgecombe <rick.p.edgecombe@intel.com> (really the TDX =
CI)

Thanks,
Thorsten



Return-Path: <linux-kernel+bounces-737302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB2AB0AA80
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 21:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C06B5A7AF7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 19:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2042E7178;
	Fri, 18 Jul 2025 19:03:59 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046DA15D1
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 19:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752865439; cv=none; b=FtRL/fiC5qownrX/thTN1oWIG7BYym77H/VDbSTYd5t8G9+wNPTpJQ9hU6BWpJpsvTkdPSUlNXa3WevdZXpdGSs7HF8nNG7A2WYEf4QqNgIVFCMzJq7j0Ku/puwAWOpZbj+Ajo+SPDumPM5GTZSv+eOdzDb3X7WVpBBupzmMbKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752865439; c=relaxed/simple;
	bh=SjEMyfjoanx+I8J6/skicjRv3qVkDwXbk7/OSyy5f94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPGxvTnj9WxnNFkwZEIME+6tT9mKBkaLuqtzsf5JpNuQpzgJLUmEiFgHI0e1S4d/65pO2UkzvfMRvkxq4ktlaX2d46Kmby3PsMBteqZAbqXchviWCHbRBX2IWGgGuMhZG+Z42PY4nf+ZgUvGRnX7I8y3tSiGiqSmVQ7h6CPr+zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C33FC4CEEB;
	Fri, 18 Jul 2025 19:03:56 +0000 (UTC)
Date: Fri, 18 Jul 2025 20:03:53 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Liao, Chang" <liaochang1@huawei.com>
Cc: kristina.martsenko@arm.com, will@kernel.org, mark.rutland@arm.com,
	sashal@kernel.org, yangjiangshui@h-partners.com,
	zouyipeng@huawei.com, justin.he@arm.com, zengheng4@huawei.com,
	yangyicong@hisilicon.com, ruanjinjie <ruanjinjie@huawei.com>,
	inux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] SCTLR_EL1.TIDCP toggling for performance
Message-ID: <aHqamaqueuk18NyS@arm.com>
References: <24afb8de-622a-4865-bd8e-8e89ccfff8f4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24afb8de-622a-4865-bd8e-8e89ccfff8f4@huawei.com>

On Fri, Jul 18, 2025 at 10:32:00AM +0800, Liao, Chang wrote:
> I've reviewed your patch [1] for FEAT_TIDCP1 support, which by default traps EL0
> accesses to implementation-defined system registers and instructions at EL1/EL2.
> 
> Do you have any plans to add support for toggling the SCTLR_EL1.TIDCP1 bit? I'm
> encountering performance degradation on CPU where certain implementation-defined
> registers and instructions are designed for EL0 performance use. The trapping
> overhead is substantial enough to compromise any benefits, and it's even worse
> in virtualization. Therefore, I'm hoping there's a way to clear the SCTLR_EL1.TIDCP1
> bit on such platforms, perhaps via a kernel config option or command-line parameter.
> Alternatively, do you have a better solution for gracefully toggling this bit on
> and off?

Given that we don't know what imp def functionality is available, what
side-effects it has, we should not allow user-space to toggle such bit,
nor allow the user access to those registers.

System-wide, passing id_aa64mmfr1.tidcp1=0 on the kernel command line
may work.

-- 
Catalin


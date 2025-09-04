Return-Path: <linux-kernel+bounces-800284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF5AB435C8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5236B5A1472
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F112A25A2A1;
	Thu,  4 Sep 2025 08:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xZZHEQPI"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EED32F775
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 08:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756974660; cv=none; b=rqeUr9mflS8AGgQXpVz9CDJuwUm6LRcg0rNJiR+kjhU87zykaBct6mMtIcbiMDLS/AkNa/XdVMbV483f1LF7UcshzNfs/J0ft9wmaX30MNX6Hd+3LseOISO8r6vfzg33+4rPoZUYXebnJJ12buY1UKMx/B8XCHr7d4+vtnGD0c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756974660; c=relaxed/simple;
	bh=dNK+Uh0eSrcb1kz54j/HC6iHQyjm3cyL0Ws0tPsoLEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkRHuUQGI38W1lYGsp3/tbs1fT1sfWP1Th4ozKGMFnS0MCEdB3YWg3/On5NiKX03viG6UfwiLfbXoCHtVhqXUbdy2EsL1fP7C25+r2LU4yhC7cNPaGAljvAOOW54EjX9V9fCrZ+oHxwj6OZPqXd6ijgGj71xsFfV5z+BGRPVvMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xZZHEQPI; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 4 Sep 2025 00:26:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756974655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oNdZCLI9Qh4c9oJ4l0QFxSHO1I3wLPIs2ZcoTVbvVSI=;
	b=xZZHEQPICy+oxcy5y2oGaGUIUdwzJ0QpB0CjVdocLgXh97ZBpxbOzHhYQ366AXqVNLIVYS
	Uc48K+mfCygSr09+VVL+rHrFbxEYnSq1LyKoavn7mwraT6POlwjhCXOeeKT46YDUl7fHJL
	YgdMjHHiu85UjKVXDkQIH/KuLMsce24=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Yingchao Deng <yingchao.deng@oss.qualcomm.com>
Cc: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, quic_yingdeng@quicinc.com,
	jinlong.mao@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com
Subject: Re: [PATCH v2] KVM: arm64: Fix NULL pointer access issue
Message-ID: <aLk_F8LgpFW6Qo3O@linux.dev>
References: <20250902-etm_crash-v2-1-aa9713a7306b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902-etm_crash-v2-1-aa9713a7306b@oss.qualcomm.com>
X-Migadu-Flow: FLOW_OUT

Hi Yingchao,

The shortlog is extremely vague, you should aim to succinctly describe
the functional change of your patch. e.g.

  KVM: arm64: Return early from trace helpers when KVM isn't available

On Tue, Sep 02, 2025 at 11:48:25AM +0800, Yingchao Deng wrote:
> When linux is booted in EL1, macro "host_data_ptr()" is a wrapper that
> resolves to "&per_cpu_ptr_nvhe_sym(kvm_host_data, cpu)",
> is_hyp_mode_available() return false during kvm_arm_init, the per-CPU base
> pointer __kvm_nvhe_kvm_arm_hyp_percpu_base[cpu] remains uninitialized.
> Consequently, any access via per_cpu_ptr_nvhe_sym(kvm_host_data, cpu)
> will result in a NULL pointer.
> 
> Add is_kvm_arm_initialised() condition check to ensure that kvm_arm_init
> completes all necessary initialization steps, including init_hyp_mode.

OTOH, the changelog is very mechanical and hard to grok.

  When linux is booted at EL1, host_data_ptr() resolves to the nVHE
  hypervisor's copy of host data. When hyp mode isn't available for
  KVM the nVHE percpu bases remain uninitialized. Consequently, any usage
  of host_data_ptr() will result in a NULL dereference which has been
  observed in KVM's trace filtering helpers.

  Add an early return to the trace filtering helpers if KVM isn't
  initialized, avoiding the NULL dereference.

> Fixes: 054b88391bbe2 ("KVM: arm64: Support trace filtering for guests")
> Signed-off-by: Yingchao Deng <yingchao.deng@oss.qualcomm.com>
> Reviewed-by: James Clark <james.clark@linaro.org>
> ---
> Add a check to prevent accessing uninitialized per-CPU data.
> ---
> Changes in v2:
> 1. Move the warning to the end in order to improve readability. No
> functional change intended

IMO, the warning should be the very first condition we evaluate. Even if
the system configuration leads to an early return anyway (e.g. protected
mode) the caller is not invoking these helpers from the right context.

Thanks,
Oliver


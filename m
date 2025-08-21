Return-Path: <linux-kernel+bounces-779797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9709B2F908
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE7D717DAD9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28F231197D;
	Thu, 21 Aug 2025 12:51:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823F92DCC11
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 12:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780690; cv=none; b=CTZ3P+K/8cv0DUop9ja8SOHfD6Q3UtVyzvJbjNPnvrVrXrqV1aHcfj8S5mEcdbOwywlIS0mwoxf06PGWSDMuynRyN+sq9fGqlbhIcW/PRcZy7ONfDkmza29YnUGNK+358nmXYSPLuPqKOe/zt4qqnWKxFPAyl8RHeUnsW4CY43c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780690; c=relaxed/simple;
	bh=HJFG4NS9VToRCH/PP8pM4bm5e8VAePCRW5cCjXmy59o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8nZPzGgktAM018DH3cJGJyd2Klfd5fdkZFx5/2imLCJtCNbB9EUpc2bALF/4oAD/zjnpR1rmfmJNeTDtGO5Dh1ewW9Xky7KAVW7Gjfv5AoCjBhnVLsbeMrsTGx2Oiz5IfyoNclopFHoP8wCTChuIhyVEVXg+Bi/MJR4wyLEitI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83DDB152B;
	Thu, 21 Aug 2025 05:51:19 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 59AD33F63F;
	Thu, 21 Aug 2025 05:51:27 -0700 (PDT)
Date: Thu, 21 Aug 2025 13:51:25 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Levi Yun <yeoreum.yun@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Yabin Cui <yabinc@google.com>, Keita Morisaki <keyz@google.com>,
	Yuanfang Zhang <quic_yuanfang@quicinc.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>
Subject: Re: [PATCH v2 02/28] coresight: etm4x: Always set tracer's device
 mode on target CPU
Message-ID: <20250821125125.GA745921@e132581.arm.com>
References: <20250701-arm_cs_pm_fix_v3-v2-0-23ebb864fcc1@arm.com>
 <20250701-arm_cs_pm_fix_v3-v2-2-23ebb864fcc1@arm.com>
 <751030d7-444e-46e6-b56f-0b72206969fc@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <751030d7-444e-46e6-b56f-0b72206969fc@linaro.org>

On Thu, Aug 21, 2025 at 10:45:10AM +0100, James Clark wrote:

[...]

> > The flow is updated with this change:
> > 
> >   CPU0                                    CPU1
> >   etm4_enable()
> >    ` etm4_enable_sysfs()
> >       ` smp_call_function_single() ---->  etm4_enable_hw_smp_call()
> >                                            ` coresight_take_mode(SYSFS)
> > 	                                    Failed, set back to DISABLED
> >                                            ` coresight_set_mode(DISABLED)
> > 
> >                                            CPU idle:
> >                                            etm4_cpu_save()
> >                                             ` coresight_get_mode()
> >                                                ^^^
> >                                                Read out the DISABLED mode
> 
> There's no lock though, so can't it do this:
> 
>  CPU0                                    CPU1
>  etm4_enable()
>    ` etm4_enable_sysfs()
>       ` smp_call_function_single() --->  etm4_enable_hw_smp_call()
>                                              `coresight_take_mode(SYSFS)
> 
>                                          CPU idle:
>                                          etm4_cpu_save()
>                                            ` coresight_get_mode()
>                                           ^^ Intermediate SYSFS mode

No.

The point is a target CPU will execute etm4_enable_hw_smp_call() and CPU
idle flow sequentially. It is no chance for the idle flow to preempt the
ETM flow. This is why using the target CPU to set the ETM state machine
will dismiss the race condition.

> This is why I was voting for changing the compare and swap mode stuff to
> spinlocks so we can be sure it's correct. The lock shouldn't be released
> until the mode is at its final value.

The question is a spinlock usage. If both initiate CPUs and target CPU
try to acquire the spinlock, the low level's CPU idle flow
(etm4_cpu_save() / etm4_cpu_restore()) needs to wait for high level's
SysFS operation to complete - which is what we try to avoid.

If we move the state machine on the target CPU - the operation and its
state transition on the same CPU so that dismiss a race condition. And
the idle flow is sequential to the ETM enabling/disabling, then, we can
achieve lockless approach.

A global picture is ETM's state is used in multiple places (Sysfs knobs,
ETM enabling / disabling, CPU idle and hotplug flow), if we start to use
spinlock for exclusively access the statch machine, then everywhere will
use it. This is why this series wants to do reliable state transition
based on appropriate atomic APIs (it also can promise atomicity and
ordering but lockless).

Thanks,
Leo


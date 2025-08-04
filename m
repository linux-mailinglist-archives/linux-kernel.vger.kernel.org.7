Return-Path: <linux-kernel+bounces-754914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4DDB19E78
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 11:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AE6D179E48
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 09:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD33242D6A;
	Mon,  4 Aug 2025 09:08:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973FF238C08
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 09:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754298497; cv=none; b=a/dXWcQNyFVl/vhC9BU8iT3ieeuLjqf3DhF4zh+2dPSEdGjyRW6BoDA57it+Crfw5yCU0B8K9tuvDE6tquPVY/bNaOMuDclqKlzY89o8OMzidQnZQaZtN1JxzC5JuhrmpKvmFavDQIGvt38n32VsVe9HkTwu6zaz3qHYowODPxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754298497; c=relaxed/simple;
	bh=4cW79w3TAxed18ZA2cTsK6j6RgIzbNsrKALqC43LPXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JNM5Q6J/WB+kZXpY5r1nYSWS4qrO6Uql+iGIYbDjxJuiXbWh4MVeeQWPnOPGHkpfYileNehAg0rOTFjFDHcFCU/fzDx6hzCBLeM7un9Vle6+U0Iaoxpv7cjKACvUYKENuhh4Z4WYjVTojVwBAUJIXCI9mLuttEY7YBJsZiiksrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACBEF1C25;
	Mon,  4 Aug 2025 02:08:06 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 516E03F673;
	Mon,  4 Aug 2025 02:08:14 -0700 (PDT)
Date: Mon, 4 Aug 2025 10:08:12 +0100
From: Leo Yan <leo.yan@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Levi Yun <yeoreum.yun@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Yabin Cui <yabinc@google.com>, Keita Morisaki <keyz@google.com>,
	Yuanfang Zhang <quic_yuanfang@quicinc.com>,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/28] coresight: etm4x: Always set tracer's device
 mode on target CPU
Message-ID: <20250804090812.GI143191@e132581.arm.com>
References: <20250701-arm_cs_pm_fix_v3-v2-0-23ebb864fcc1@arm.com>
 <20250701-arm_cs_pm_fix_v3-v2-2-23ebb864fcc1@arm.com>
 <09f9d195-7f3c-4cf1-95da-7e29c398ebcc@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09f9d195-7f3c-4cf1-95da-7e29c398ebcc@arm.com>

On Tue, Jul 15, 2025 at 12:56:54PM +0530, Anshuman Khandual wrote:
> 
> On 01/07/25 8:23 PM, Leo Yan wrote:
> > When enabling a tracer via SysFS interface, the device mode may be set
> > by any CPU - not necessarily the target CPU. This can lead to race
> > condition in SMP, and may result in incorrect mode values being read.
> > 
> > Consider the following example, where CPU0 attempts to enable the tracer
> > on CPU1 (the target CPU):
> > 
> >  CPU0                                    CPU1
> >  etm4_enable()
> >   ` coresight_take_mode(SYSFS)
> >   ` etm4_enable_sysfs()
> >      ` smp_call_function_single() ---->  etm4_enable_hw_smp_call()
> >      			                /
> >                                        /  CPU idle:
> >                                       /   etm4_cpu_save()
> >                                      /     ` coresight_get_mode()
> > 	       Failed to enable h/w /         ^^^
> >   ` coresight_set_mode(DISABLED) <-'          Read the intermediate SYSFS mode
> 
> The problem is - CPU1's HW state and CPU1's sysfs mode state might not
> remain in sync if CPU1 goes into idle state just after an unsuccessful
> etm4_enable_sysfs() attempt from CPU0. In which case a subsequent read
> coresight_get_mode() on CPU1 might erroneously give us DISABLED state,

In this case, CPU1 reads an intermediate "SYSFS" state, even though it
failed in etm4_enable_hw_smp_call(). The current code defers setting
the state to DISABLED on CPU0. As a result, CPU1 will incorrectly save
and restore the ETM context based on the intermediate "SYSFS" state.

> which actually does not seem to be too bad as the earlier enablement
> attempt had failed anyway. Just trying to understand what is the real
> problem here.

The problem is CPU1 might get an intermediate state, it turns out a
stale value and might guide CPU idle flow to wrongly save and restore
ETM context.

> > In this case, CPU0 initiates the operation by taking the SYSFS mode to
> > avoid conflicts with the Perf mode. It then sends an IPI to CPU1 to
> > configure the tracer registers. If any error occurs during this process,
> 
> What kind of error can happen during this process ?

So far, it might fail to claim a device and return an error.

A similar issue might occur when CPU1 exits an idle state. For example,
if CPU0 initiates the ETM enabling flow and sets the SYSFS mode in
advance, once CPU1 is woken up from idle by an IPI, it reads the ETM
state (SYSFS mode) and then restores and enables the ETM. This can
happen even before CPU1 invokes etm4_enable_hw_smp_call() to complete
the ETM enable flow.

> > CPU0 rolls back by setting the mode to DISABLED.
> 
> Which seems OK.
> 
> > 
> > However, if CPU1 enters an idle state during this time, it might read
> > the intermediate SYSFS mode. As a result, the CPU PM flow could wrongly
> > save and restore tracer context that is actually disabled.
> 
> Right but CPU0 had marked the CPU1' state as DISABLED after the enable
> attempt had failed. So what is the problem ?

There is a race condition between CPU0 writing the state and CPU1
reading the state (during its CPU idle flow). CPU1 might read a state
that is inconsistent with the actual ETM hardware state, which causes
CPU1 to save and restore the ETM context incorrectly.

A wider view is this series heavily relies on the ETM state to decide
the linked path has been enabled and take action for saving and
restoring all components on the path (not for ETM device only). We need
a reliable state machine to reflect hardware state. To avoid any
intermediate state, we always set the state on the target CPU.

Thanks,
Leo


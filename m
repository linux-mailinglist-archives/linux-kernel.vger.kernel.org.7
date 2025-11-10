Return-Path: <linux-kernel+bounces-892918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A026C461D6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 101063BA151
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0B3307AC4;
	Mon, 10 Nov 2025 11:06:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EC02E63C;
	Mon, 10 Nov 2025 11:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762772798; cv=none; b=aY29A5WMrY+T2aDS/OVkR1/qyLRf/J3o5EvajG0HoLPW9QPscR47yIJ0w2NBemSP4UzMkOjsPasZv1WdgXFzH9VjK/0rU8+OcvjyBzqbzR8dqPVPzcMkB856d1EIrxxBX6oiS+itJ6JMjFgCjngpLBwQkNa2zndaqhyojguFZvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762772798; c=relaxed/simple;
	bh=QoovApfXIc53OoZJ+WGF+8Vc6hpaQHdLdkctd+SdcWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HomXl8iA17NZpBn9difBrwJFu6q5EgehEiiut2Exf2v8a/z7qEVjSprjaEIIoDvXGbHIlWuP/cyqKsLPsMp52LZ8xWvN19XEblu/alscTGXe+TCeCdkg4d2C0BEvDCtsLJ1DmjsT6H+wbDH5GJ9A+GMCabfKkKv5Oa5lKy3SqYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B0D8497;
	Mon, 10 Nov 2025 03:06:28 -0800 (PST)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7F833F63F;
	Mon, 10 Nov 2025 03:06:33 -0800 (PST)
Message-ID: <fa20041b-21e2-488e-88fb-ab49a8e24fb8@arm.com>
Date: Mon, 10 Nov 2025 11:06:32 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86,fs/resctrl: Factor MBA parse-time conversion to be
 per-arch
To: Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org
Cc: Tony Luck <tony.luck@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 James Morse <james.morse@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Jonathan Corbet <corbet@lwn.net>, x86@kernel.org, linux-doc@vger.kernel.org
References: <20251031154225.14799-1-Dave.Martin@arm.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <20251031154225.14799-1-Dave.Martin@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Dave,

On 10/31/25 15:41, Dave Martin wrote:
> The control value parser for the MB resource currently coerces the
> memory bandwidth percentage value from userspace to be an exact
> multiple of the rdt_resource::resctrl_membw::bw_gran parameter.
> 
> On MPAM systems, this results in somewhat worse-than-worst-case
> rounding, since the bandwidth granularity advertised to resctrl by the
> MPAM driver is in general only an approximation to the actual hardware
> granularity on these systems, and the hardware bandwidth allocation
> control value is not natively a percentage -- necessitating a further
> conversion in the resctrl_arch_update_domains() path, regardless of the
> conversion done at parse time.
> 
> Allow the arch to provide its own parse-time conversion that is
> appropriate for the hardware, and move the existing conversion to x86.
> This will avoid accumulated error from rounding the value twice on MPAM
> systems.
> 
> Clarify the documentation, but avoid overly exact promises.
> 
> Clamping to bw_min and bw_max still feels generic: leave it in the core
> code, for now.
> 
> No functional change.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> 
Seems sensible and helpful for MPAM.

Reviewed-by: Ben Horgan <ben.horgan@arm.com>

Thanks,

Ben



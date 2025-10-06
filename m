Return-Path: <linux-kernel+bounces-843595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BACF9BBFCA4
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 01:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 997F94EDD66
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 23:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A62C1FAC4B;
	Mon,  6 Oct 2025 23:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y+D/gyMg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F1D4C9D
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 23:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759794148; cv=none; b=r3rsyPsCaYfSNgowwuMJObmepTYRAwdC5HAjZAyj2iLsIJkP/26ETFxcKbPPu5+iQH8WaqoIEL3RNfARcqOOqTeJaZCTsvUh4+c+OF4yyUMDpiUFbRmOUF+VTngJ6Kd4i7AbeDpN/cXMD0FcoEq7PQC8gWWTz28sSzpEd/8hXiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759794148; c=relaxed/simple;
	bh=I1LRnW+vY63k1Mx1je5Uo5vhO6U35Vc+kskyhau2eCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZYGLcX/hydrAw9UlpDe8Nywr9AC9qiI/5YYcqSoz3uERJRvEEBaqyXHH/xG8xMEyF+aXdmFV6+hAc8t55O2oeHN1r/9UD3Z8PM5yzmOL8HfHTqEzIsoQBGny/sVfrBZ7ZD5dcWGYbjMj57KoYZPMtYCYJmfJER8q+1p49+crUdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y+D/gyMg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759794146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UCfiz5Ut6f0Hmx5GZ2r8SOtef3xDzej4Rj97vBZKv8A=;
	b=Y+D/gyMg8fW2eCqdli5wXlocEvfQf5POOHAfGAUb3mcMIsdICfomcz6MQNV/qKUQx52JQV
	x8SngdZOVHxdbyL7jEiHIDiAq9K0l2tnWjlrSc2XbXNlvmGFd1uW5A1ZORO9tj9op3dptq
	Q8ugSBsy6s0hjXkPWnFnsj+YwDQAN1Y=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-UUxClE0TP1CmbctajtS2fA-1; Mon, 06 Oct 2025 19:42:25 -0400
X-MC-Unique: UUxClE0TP1CmbctajtS2fA-1
X-Mimecast-MFC-AGG-ID: UUxClE0TP1CmbctajtS2fA_1759794144
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-780fb254938so4445485b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 16:42:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759794144; x=1760398944;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UCfiz5Ut6f0Hmx5GZ2r8SOtef3xDzej4Rj97vBZKv8A=;
        b=CD+Y1//mx3KnpcJRVs2+lyeCk4LpxdLLGE7J3vL3g+VRpk3d+dql4SboHth2oCsmMx
         nS2b/JP82Zm4SLAiYw40HcVzAsSjjerDJW/ILu0w9EqUDD59sL1J2Ff0uv5yC+cNpZ0W
         TYerG6CkYIGjmYWz/WC3oiz73J+WhvZrw/2VUsuI5/ua60L+tTwdumrq0+MMma24pQ7u
         70TJseS823qgmXOaTdUn4tPV8r91PaEp4E6l/bjjCyr6AhKIk6Rm4Jo4V0302VtDAMR3
         /ilhopJ5Ouz1U+LPe6nLPKsR2OX8GfhKe9oyqquCD4RI3PaEazuRrxzIMuSJFxmssFzG
         uRhA==
X-Forwarded-Encrypted: i=1; AJvYcCWDnvFmhrdalWJRVKnzA+69nOuNuTCrL1EORYGt3Yc5VzUtbM4veTDBCfly/GZra6az+GnVaCDPmUuV/JA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzevi+KuiRdio6aEySqytdaP2217UkE9uIjruvtYSO38nyXaE1
	M9WV+ojC7MACof6JGZKcTXh+kfLNSJACMBn1+N0LaTzvgL/SmpOvS3JLUe1UxeL4/DyWs8z55/e
	YTdM4N/eeIcTsI94YfypGC/dWkKOZTHjfn3cXzxgQQmLhGbNfB7HO+BwD+4NUmWj8XQ==
X-Gm-Gg: ASbGncsg76Me4VaoBXRYj97jXRvWQkxJX5aZ7o6lZb0foQ32nV7irwPz5+VQwXvdN3I
	1ywqTcr9jy6oOh9LuUJwZvp11TckaRYqUW24e2y2onMnQkX72EPdx23rOeZWu9I7aAIUeCgphtT
	OPuFmXtqXj39weDl7ik4nV1/DF3TJw/SY4RKHIngg7Alqx6wSX3wD9Mpcee/6e/94naN76gHYnJ
	cgK6KUN6NCazEAYbk8Rioh9+n/eDaynKRePflYWMppW5EUtez7o4V2Jt6eyWm3/oclJxIUQgswJ
	KsevH52Iy/azP4dmJMYjnWP7uMUWKRl7sMb7Nf5wluVSdfl5Qu7HqMyUlEH4oQ4Y/2oLENssKR7
	xgewNNXJBrg==
X-Received: by 2002:a05:6a20:1592:b0:2cc:acef:95ee with SMTP id adf61e73a8af0-32b62136d1fmr19762267637.52.1759794143763;
        Mon, 06 Oct 2025 16:42:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErH3GfkI2IJHSlnVnK9KFQpJaGBBQh0aEIEhfAff2FkMCiATPoRFpGW3jxwgnd3xHSMfVm/w==
X-Received: by 2002:a05:6a20:1592:b0:2cc:acef:95ee with SMTP id adf61e73a8af0-32b62136d1fmr19762234637.52.1759794143405;
        Mon, 06 Oct 2025 16:42:23 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01fb1d27sm13937880b3a.36.2025.10.06.16.42.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 16:42:22 -0700 (PDT)
Message-ID: <ea7b2ab9-8115-4164-ba9d-6aa42ac57482@redhat.com>
Date: Tue, 7 Oct 2025 09:42:09 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/29] arm_mpam: Add cpuhp callbacks to probe MSC
 hardware
To: James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Dave Martin <dave.martin@arm.com>,
 Koba Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
 fenghuay@nvidia.com, baisheng.gao@unisoc.com,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Rob Herring
 <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, Lecopzer Chen <lecopzerc@nvidia.com>
References: <20250910204309.20751-1-james.morse@arm.com>
 <20250910204309.20751-11-james.morse@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250910204309.20751-11-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/25 6:42 AM, James Morse wrote:
> Because an MSC can only by accessed from the CPUs in its cpu-affinity
> set we need to be running on one of those CPUs to probe the MSC
> hardware.
> 
> Do this work in the cpuhp callback. Probing the hardware will only
> happen before MPAM is enabled, walk all the MSCs and probe those we can
> reach that haven't already been probed as each CPU's online call is made.
> 
> This adds the low-level MSC register accessors.
> 
> Once all MSCs reported by the firmware have been probed from a CPU in
> their respective cpu-affinity set, the probe-time cpuhp callbacks are
> replaced.  The replacement callbacks will ultimately need to handle
> save/restore of the runtime MSC state across power transitions, but for
> now there is nothing to do in them: so do nothing.
> 
> The architecture's context switch code will be enabled by a static-key,
> this can be set by mpam_enable(), but must be done from process context,
> not a cpuhp callback because both take the cpuhp lock.
> Whenever a new MSC has been probed, the mpam_enable() work is scheduled
> to test if all the MSCs have been probed. If probing fails, mpam_disable()
> is scheduled to unregister the cpuhp callbacks and free memory.
> 
> CC: Lecopzer Chen <lecopzerc@nvidia.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v1:
>   * Removed register bounds check. If the firmware tables are wrong the
>     resulting translation fault should be enough to debug this.
>   * Removed '&' in front of a function pointer.
>   * Pulled mpam_disable() into this patch.
>   * Disable mpam when probing fails to avoid extra work on broken platforms.
>   * Added mpam_disbale_reason as there are now two non-debug reasons for this
>     to happen.
> ---
>   drivers/resctrl/mpam_devices.c  | 173 +++++++++++++++++++++++++++++++-
>   drivers/resctrl/mpam_internal.h |   5 +
>   2 files changed, 177 insertions(+), 1 deletion(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>



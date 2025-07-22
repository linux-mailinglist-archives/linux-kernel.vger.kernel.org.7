Return-Path: <linux-kernel+bounces-741406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D253B0E3B2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 20:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FE1A580FD3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 18:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBD1283FFD;
	Tue, 22 Jul 2025 18:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IKvDLxuP"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D0C283FD8
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 18:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753210287; cv=none; b=fPSBEBQGkJpGc+Icz8BPfoMHSBOpTLSo8XnXAb0CnrkwGR462y+FTOBV04GuK9cewDBSY5436iQ2QoLS1O1+53QBQWgytf9a3QcZHtzsFJp6TWce1z2E1KXbPc7pZTWsnXGHx7sgFOTj3MnWzbhL01FzI2SVAyKE85qSVnocisk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753210287; c=relaxed/simple;
	bh=0gJflN5+ftncUl1+V5yfeO9DL6q4suunebrkcoCQ1SQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f7AKROwfcNkoCSsY52stBLKsl1YSLLo6MjaOsaZI3ZtvvHJPpY7j7SBdpZDK6WKFsJMy7JrridaaVLadOprLsJaHg6L2VrPeKRkNkmsxPNoLoRwH1enSNOzY+maEBNWR8HhLIrVmR4mhta5g3j0sDsrG11zXDAv4dC0XzH9kM+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IKvDLxuP; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4ab3ad4c61fso77701cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 11:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753210284; x=1753815084; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y4v/0bSm2eOQeRU/QVLO9OgyL4pkFF+iWSGFdfVifOE=;
        b=IKvDLxuPSJxIJBBStDUOAeBr0YMs85ALIEYoBVb1g8eoB+Sf75MrpJbiaSXSwSbE5b
         ep350QhIsBc5JnfNVF73u7MtF9YybgeVVcOGu+7/Rg7mjOC62QxdN2oEJqzyadACXUjn
         +ofRRN09DFisBFlyBrSSAev1XB1rE2WjkDB0glY+UwrMHJ6d9PlTkTAheMOyyzfFeiIN
         9jP5e7oU2/Us/hbaSk1JW9XWWOeg+2/+Dx99uAo/a19W+iAu9BtAdE4t4aUP12decs06
         yYn7hFz0VdsCWmvKPAQ41gFPpUyQY6lOMSya56/8ga3aW876db28336KhbAyEQqLGTBe
         4Thg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753210284; x=1753815084;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y4v/0bSm2eOQeRU/QVLO9OgyL4pkFF+iWSGFdfVifOE=;
        b=fApSJno2W3pxbffWbVgUUaoTmq76R5W9kffcM2/xRBCDYF0OLFKxZscMPSLU7KUdVD
         3oUH2c8VGLPtsfAANHH223nGrh7jpmmYSRDUyml7kr8TESffIdJpluHxEGdJ4X2lZYYv
         LtyugrXQjb9Im4SY/sYVv/JNZNVAUUegUu0Bf0YOqmlwFWx3ca6rV80gN7be/tsVWtTx
         f1BnDkOMH+rqlcdJoBBh5WUomzKdaZTqA/Frfby17Q0OrR1bkuwpMmwFc1nT88sIJIfH
         Y1Qg2PmHGLl2QQLcnbo8QltceChQ5Rsjnrp45IVu1Fzu6zxwYRJYf+GfB611pbYI57qR
         G63A==
X-Forwarded-Encrypted: i=1; AJvYcCWkCC+io1NecNr56Ztet3bRYahYQ3GF+4sHz7AGKyAPbPB61zOAPA7+aiFYOivkXl67DyibwpsVgqmpbro=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsEpiQn/uIxznsNHkt8xS3CyCoENVbtbrRfLvMlf+D8RHA2U3d
	RHxO/78GYPC/k5p7Y0GZTkPiPId7n4BdTeLEuE3M5JXYZXL66ltM2Km3cp1C7sUfA91Q1KNa4sN
	G3LOp0j0e
X-Gm-Gg: ASbGncvI5p4Evv0SBsbQ/30bO5Wbr6tWk8Qymrli4K9SriK5SoEu/0Dh4IZTn7o8AKn
	qVA0nX84pUXztFdKV8Fo0XaSXY2W70J5Y4ZfbUtOdZiJ8qpbg3mN5AFid+cSheU+l8UKGiEmUU4
	gCXxMpNAehBhNNiLDiJr8AT/QHDvtu4bs01x/rDxvVuSPsGQruQhNhQLbGnFPE8YOhlK5GyvhW8
	hJHnRF/Fyfj3Kccnzc3Tk+rGVnrByVZFH5aQ/CZS3A8a0lTlC1oV0TTDqLOGlPQmkePlRcsi9DD
	eys/Xofruowl2p4O14K3+QM7RAkR3W0SYwdI03XyV0OivaCT2DepiGm0Y8pqvDaiTEMae1KiUgZ
	Zwr05zobNMSbqRnK9G6qk+fiItwRiNOIQ4Pfya2/g8rVuRidLgRB7UEBpSjlS
X-Google-Smtp-Source: AGHT+IHlSLCdiZvSP/je7fwpuEm0Rkobn5lZYibCSnHYZ1wOnpR0k9uvVTjSvbsymnzgnmsfE/Qdsg==
X-Received: by 2002:a05:622a:a547:b0:497:75b6:e542 with SMTP id d75a77b69052e-4ae6d77cb7bmr374721cf.10.1753210283624;
        Tue, 22 Jul 2025 11:51:23 -0700 (PDT)
Received: from [192.168.1.31] (d-24-233-113-28.nh.cpe.atlanticbb.net. [24.233.113.28])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb499fea2sm57461881cf.22.2025.07.22.11.51.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 11:51:22 -0700 (PDT)
Message-ID: <dcc38ba0-cbb4-494e-bc10-2df2b4aa2cb0@google.com>
Date: Tue, 22 Jul 2025 14:51:21 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/resctrl: avoid divide by 0 num_rmid
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: Tony Luck <tony.luck@intel.com>, Dave Martin <Dave.Martin@arm.com>,
 James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org,
 "x86@kernel.org" <x86@kernel.org>
References: <20250721180051.3645697-1-brho@google.com>
 <c4518fe2-dce3-46d1-8d79-cd63377bdcad@intel.com>
From: Barret Rhoden <brho@google.com>
Content-Language: en-US
In-Reply-To: <c4518fe2-dce3-46d1-8d79-cd63377bdcad@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/22/25 2:19 PM, Reinette Chatre wrote:
> Hi Barret,
> 
> On 7/21/25 11:00 AM, Barret Rhoden wrote:
>> x86_cache_max_rmid's default is -1.  If the hardware or VM doesn't set
>> the right cpuid bits, num_rmid can be 0.
>>
>> Signed-off-by: Barret Rhoden <brho@google.com>
>>
>> ---
>> I ran into this on a VM on granite rapids.  I guess the VMM told the
>> kernel it was a GNR, but didn't set all the cache/rsctl bits.
>>
> 
> The -1 default of x86_cache_max_rmid is assigned if the hardware does not
> support *any* L3 monitoring. Specifically:
> 
> resctrl_cpu_detect():
> 	if (!cpu_has(c, X86_FEATURE_CQM_LLC)) {
> 		c->x86_cache_max_rmid  = -1;
> 		...
> 	}
> 
> The function modified by this patch, rdt_get_mon_l3_config() only runs if
> the hardware supports one or more of the L3 monitoring sub-features
> (X86_FEATURE_CQM_OCCUP_LLC, X86_FEATURE_CQM_MBM_TOTAL, or
> X86_FEATURE_CQM_MBM_LOCAL) that depend on X86_FEATURE_CQM_LLC per cpuid_deps[].
> 
> I tried to reproduce the issue on real hardware by using clearcpuid to
> disable X86_FEATURE_CQM_LLC and the CPUID dependencies did the right thing
> by automatically disabling X86_FEATURE_CQM_OCCUP_LLC, X86_FEATURE_CQM_MBM_TOTAL,
> X86_FEATURE_CQM_MBM_LOCAL, not running rdt_get_mon_l3_config() at all, and
> not even attempt to enumerate any of the L3 monitoring details.
> 
> What are the symptoms when you encounter this issue?

Linux crashes during boot with a divide error, and the splat backtrace 
is in rdt_get_mon_l3_config().

> Would it be possible to send me the CPUID flags of leaf 7, subleaf 0 as
> well as all sub-leaves of leaf 0xF?

# ./cpuid 0x7 0
CPUID for Leaf 0x00000007, Sublevel 0x00000000:
	eax: 00000002
	ebx: f1bf2ffb
	ecx: 1b415f7e
	edx: bc814410

# ./cpuid 0x7 1
CPUID for Leaf 0x00000007, Sublevel 0x00000001:
	eax: 00201c30
	ebx: 00000000
	ecx: 00000000
	edx: 00084000

# ./cpuid 0x7 2
CPUID for Leaf 0x00000007, Sublevel 0x00000002:
	eax: 00000000
	ebx: 00000000
	ecx: 00000000
	edx: 0000003f

> Could you please also elaborate what the impact of this issue is? Is this
> a VM that has been released with many users impacted or something encountered
> during development of this VM?

This is with cloud-hypervisor.  We do have a couple of local patches for 
running on machines with more than 256 cpus.  I didn't see anything in 
our changes related to cpuid 0x7, but maybe it's on our end.

But I imagine the problem isn't widespread and could be considered 
developmental.

I'll keep poking on my end - maybe I had some other cruft in my system 
(in the kernel build or in cloud_hypervisor).

Thanks,
Barret



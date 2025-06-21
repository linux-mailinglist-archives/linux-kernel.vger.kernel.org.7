Return-Path: <linux-kernel+bounces-696372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 680D4AE267A
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jun 2025 01:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D53214A3818
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 23:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD4C242D68;
	Fri, 20 Jun 2025 23:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="rbnP/Ay8"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558E82405F9
	for <linux-kernel@vger.kernel.org>; Fri, 20 Jun 2025 23:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750462186; cv=none; b=Ho4bW9YD1CeIVP/QvvIWmuh+qg8TM4S66ABHzvq6SI0qixlCeUumsRijG2CUk8MOc/FlG3E8AzNCk0YN5ERuVwR/E9PgP1V608GGt/ETM2tTSfVquczV5+SX8VJ2WOwdrdZryRWFVPZ6mD0FfqYx8q79qM55wgEQSI/JCKPrT2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750462186; c=relaxed/simple;
	bh=GyWk0qiWePCQwaKIBix6f2exrRagW+EzsOmbSS+oOcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EeWIxvRUvHOOYzlglhbt7oBtp+Cg0qTFQS8RH0CfK/GsdMA8GTzx/Lz4ar6ans6/9+YnJ649feq1iNE0xpHCG9gnjVVoqzWkYjy5kM96u51RxGpqS/9Nz8jLqn3VHg6A51G0KmBFFrj4eStrGUelFubQ/XcMTddkO7V2Dnv+EXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=rbnP/Ay8; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-441ab63a415so24381135e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jun 2025 16:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1750462183; x=1751066983; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YQ2eaHvE+DUGUCT+tt8p22ZyvVmrf9rbNhrUi9BbtKM=;
        b=rbnP/Ay8412hKSszqdqn7vg96GpPoBzBxJgE40T5B/9OUbIUQyzFQlzqSvGQ3Y1bAk
         AjKeHzTD4ZtyJMgXXoS55qc27TeDttoA/7i/I2Tt4iC5TDQQNHm625evxhT1ONxBNtrT
         0I9fRP4RRNd1GWsezUtj7s9tbQGIF8Cafetwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750462183; x=1751066983;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQ2eaHvE+DUGUCT+tt8p22ZyvVmrf9rbNhrUi9BbtKM=;
        b=PXJmg0xcVA3BaoIPyySWhFy3ESWhj72ubA5aJWUDf9t1CaqBdXZVp9OVhDXvacID0n
         qhzqgpmk99TanCto+ED1+ZAiO5wxk5RRi+4AMDrvLo/yc+/ZY0ihsjTrez66vltyfUPl
         W+FpuCLlN6n4spHanIfAchvLRAlvHbHGU8J1pXeJ7elk7PNQ2DUOe/sRquDHWkDfuJ6v
         OfRm1610d85gsOO87w9W9exUoFf8b9p3zZuBRAxdmM1IlWwxOeaFLev6I9DnvEyZJohT
         f+yedHm/F5qPTlc0wU/slz2nYSPQYQxArm9+l4jiTYspkP8g8iAYz0L0+cWdRpMJLOPb
         iYBA==
X-Forwarded-Encrypted: i=1; AJvYcCXBPj3dG1fUiypu60bc/SAqOJ/lxB0xIdsthiqsE7XTgaYXGcdtCXZJrvMBnXPO3t5E6e5kdJ3rtCGoDW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMGxtgAKMmRyI9nKMDndx5dwGqR9lGlABmSkSIeQzkmzR2kqsY
	OyJQl2OAHcxel8J90aIHQmbjHXJEeiODDps1b4u4ZZIlb9mbuZb/KN/oFq7m7o1J4zM=
X-Gm-Gg: ASbGncs+/+Dv/fwEebvVrVePebE6fbMMZEfxNTYzYgIQxKTPgA2vXsasCQn0rBwQZ8V
	50m4DfpqwFKgN77XRwo4Uje4r2ouYOjuLoBApv05/vW8By1o0KRvP/X1HMJmgzM/rbJV7roG9gf
	oL5nIrx4CnosABTsXcY6Fg8hUAFxfpkC5WupuFtsFpKr4FuvpicGPLCth6S6Xes/fH8gDSHq1x6
	8zTw1LMAgZq37rj1ZIV/z3not9tZ8xuvHs9U/QX1nVTRlK1Npf1LCViCjpRifRgqk3eazjYMmUA
	QvI8f+1V9AmgQDkzMXqAKpOnTpjYB1YKfHGcPMW9z5oqjZ5AVgyG2YoJu4pJbUKMHGgmWbjl49V
	IxTMQ4mI/CMNzARX3dPmWoHGPkdU=
X-Google-Smtp-Source: AGHT+IGgRZHxkj2pQ+l7/rk0whCWEYGExTTse7TuxuHuH1Xq1Z0HqPD/2OxQrgjoH7P7iFf5EIxSVg==
X-Received: by 2002:a05:600c:154b:b0:43d:40b0:5b with SMTP id 5b1f17b1804b1-453659b885emr40942275e9.25.1750462182540;
        Fri, 20 Jun 2025 16:29:42 -0700 (PDT)
Received: from [192.168.1.183] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d0f1d91bsm3142259f8f.42.2025.06.20.16.29.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 16:29:41 -0700 (PDT)
Message-ID: <83e4ffb4-26e9-4fc9-90ad-256a1613ba7d@citrix.com>
Date: Sat, 21 Jun 2025 00:29:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv6 07/16] x86/vsyscall: Reorganize the #PF emulation code
To: Sohil Mehta <sohil.mehta@intel.com>, dave.hansen@intel.com
Cc: acme@redhat.com, aik@amd.com, akpm@linux-foundation.org,
 alexander.shishkin@linux.intel.com, ardb@kernel.org, ast@kernel.org,
 bp@alien8.de, brijesh.singh@amd.com, changbin.du@huawei.com,
 christophe.leroy@csgroup.eu, corbet@lwn.net, daniel.sneddon@linux.intel.com,
 dave.hansen@linux.intel.com, ebiggers@google.com, geert+renesas@glider.be,
 houtao1@huawei.com, hpa@zytor.com, jgg@ziepe.ca, jgross@suse.com,
 jpoimboe@kernel.org, kai.huang@intel.com, kees@kernel.org,
 kirill.shutemov@linux.intel.com, leitao@debian.org,
 linux-doc@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux@rasmusvillemoes.dk,
 luto@kernel.org, mcgrof@kernel.org, mhiramat@kernel.org,
 michael.roth@amd.com, mingo@kernel.org, mingo@redhat.com,
 namhyung@kernel.org, paulmck@kernel.org, pawan.kumar.gupta@linux.intel.com,
 peterz@infradead.org, rick.p.edgecombe@intel.com, rppt@kernel.org,
 sandipan.das@amd.com, shijie@os.amperecomputing.com, tglx@linutronix.de,
 tj@kernel.org, tony.luck@intel.com, vegard.nossum@oracle.com,
 x86@kernel.org, xin3.li@intel.com, xiongwei.song@windriver.com,
 ytcoode@gmail.com
References: <9d351d80-66fe-486f-bdb3-370859dc47cc@intel.com>
 <262c0fd2-ac66-4ce7-903f-4062f1fe1d6e@citrix.com>
 <f6d73a46-7ca0-4898-bb23-9095be403ea9@intel.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <f6d73a46-7ca0-4898-bb23-9095be403ea9@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 21/06/2025 12:18 am, Sohil Mehta wrote:
> On 6/20/2025 4:08 PM, Andrew Cooper wrote:
>>> But, the resulting code is wonky. It needs to do something more like this:
>>>
>>> 	if ((error_code & (X86_PF_WRITE | X86_PF_USER)) != X86_PF_USER)
>>> 		return false;
>>>
>>> 	if (error_code & X86_PF_INSTR))
>>> 		return __emulate_vsyscall(regs, address);
>> To do this, LASS needs a proper interlink against NX || SMEP.
>>
>> If neither NX nor SMEP are active, the CPU does not report X86_PF_INSTR,
>> meaning that fetches are reported as plain reads.
>>
>> This leads to some fun corner cases in SMAP and now LASS too for virt.
> Maybe I am missing something, but LASS works pre-paging so it wouldn't
> generate a PF, right?

Oh right, yes.  This is a preexisting bug in vsyscall #PF handling.

It simply became obvious with Dave's suggested rearrangement.

~Andrew


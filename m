Return-Path: <linux-kernel+bounces-828000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73691B93A7C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 01:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86CFF1900333
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 23:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5813F2FE07D;
	Mon, 22 Sep 2025 23:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJW0RerF"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0D02FC877
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 23:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758585434; cv=none; b=OUmvJPPIwv/cqDM26RYPvwXm5KROBParukRYtPtrjWm7BIk/+6OXtVX3q0i/S5IiKRCjJp/kz7aHuK/T5akfxz6nlqVzcEpt3Nv336TdoFNF5juK+Dm9SzSrDN8iLxzPQGqJDbUqoLToKuAtFmxXxIM9jwd46AQ1kRnIoFNSnxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758585434; c=relaxed/simple;
	bh=B63YuYx5gKQMFWvVm9fq5GYU6bV+k57a1fas2yIrTxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=flhVHnoHvHxBHMDPchUXA3Lk2fI7tlDZ9tFGQqYr0jEqvNCiFvmOTO0fSC/b0zWB63BscFFchW1r8hzwNW7XhmGsekFe4IBpYV3/z2t7u6uwCqDy5HA0cvVkRcXXql0tyUEJNVRK45GRhWhWKx/uLNWmEhWOpvpsSgXBF2+AV3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJW0RerF; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3327f8ed081so1574220a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 16:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758585433; x=1759190233; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IODUA9zga0m/nOGRKLCJjuNE/B+/uoV/AOO8W3swHIU=;
        b=kJW0RerFNPIXvrsJg/WaefyDyydMJO+FT1tDVh1nJyCSRhGnu5IjESJOTvp62Hgloy
         48WfYqqZGyVCEEfCjJlTkO3+v5e5yzM2cAdjrTpuHlcvTqGQapT5MoybhVy8Dr81i6IM
         dIluqnW2jcwDqwDI/WxK2v3rWOOMOTtmGRkztVfuxLUCKbLAtkEGfzT5QrdQ9Z0hlmpf
         DjDg5LpyjARyy4iXN9yi06acwE5c2XuORdXg1oik7rkXHXYED0Yz1KSgueP3eWBAh4ni
         zwVIPZ8LcU6CZSi3UW+HkBgcNEQeruv5qnK4SR5eMwJPOk42jl1Q+ahUWtkAqga6PlHk
         ZU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758585433; x=1759190233;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IODUA9zga0m/nOGRKLCJjuNE/B+/uoV/AOO8W3swHIU=;
        b=hJiLo3ECLfHtMDBZRcTdA2PfGBbxDv9jtoVdkn51Jjx4GPoyWS7KNFXsmYSzSk9lRm
         DnJdp+/tFCvDG/+RCfVvbSmCUQnYLf86GNJORR63U+rpXfh6Jf0DiB/MVgmfhZnuB2Ho
         +TDlydUl7U3n9hnf363uimbTD15C/SU58LnkwWizJgZXw+2iC9RQfPj3OLTWfiEZUQNI
         hJ4tybTdcv8FLeScuVjBatFEe9C2koHSSAdQq9r1dP45bgdZDbjloVwYco/UktL63VVl
         DYHLWaKGMUSa5NtaNQmj1JPXE6vi4mQUYqySRusSiaSofrpsQp5nURkCgxJhK3isNWIu
         +ZwA==
X-Forwarded-Encrypted: i=1; AJvYcCVCFGgxsigTbh8XC5C+DrL8ymRRizITHNhVjPgJvlXMdD5xtAEgNtb/w98HUPFxIhLp+1GVVulyfLC+hB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMao4FFc/+y5nsmRObg1wnJGjAa6U85Lr6VC89V6KfHM0c/K9o
	e8g7tMb/l2iZ7BqpGEbOIXf8nukOez2FCigYjAe7oyHO6msqDBgr7D/8
X-Gm-Gg: ASbGncvyNaFCiPctjMugBa+j4ca9OAakxWDimUeBn3d/u/o8C/gd8T+2x9r5YpBb0/2
	H+VzYcx/+jZErYZjfOHVjZxkebqcVUikxeahPWbuZzpNVc6hzju1ZsEpGBNLHQDqYBRSJAfV3lY
	Kwg6qnB0cX6+TTzD/+4xlGxnnnAUI3AwqO14qcb4igjAVvTxjoI8lc/AhvmwuIsZ19LGtzEteb0
	W81C63pw9OILmHM3koBuOByBQpBv1YVS1Z+tfeRJO4ENBCnIbSLC5ymSidaNR3opEgpkarzgLmT
	2gaV2R3ooaTlXoIOhWIjWT96DE8vyOFjt3Ex4sfIodnHMApJfIOsluw0XH0zekUTAQA5jxnvPcn
	VY4dEkaRbWBHGM+g+tV3w7sbx
X-Google-Smtp-Source: AGHT+IFLSQPMmtJG7J8JigPkcsPkbNvPUMLxpyd334NCh2UapNWwuDV3lLZRY3JDLwxXh9eDESpAQA==
X-Received: by 2002:a17:90b:55c6:b0:32e:dd8c:dd2a with SMTP id 98e67ed59e1d1-332a8ceaae3mr951669a91.0.1758585432510;
        Mon, 22 Sep 2025 16:57:12 -0700 (PDT)
Received: from [192.168.0.13] ([172.92.174.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77e0bb98790sm11669657b3a.9.2025.09.22.16.57.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 16:57:11 -0700 (PDT)
Message-ID: <8ca8192e-ccc1-41bb-a913-dd633d65ac54@gmail.com>
Date: Mon, 22 Sep 2025 16:55:57 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] riscv: Memory type control for platforms with
 physical memory aliases
To: Samuel Holland <samuel.holland@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 Conor Dooley <conor@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alexandre Ghiti <alexghiti@rivosinc.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, uwu@icenowy.me
References: <20241102000843.1301099-1-samuel.holland@sifive.com>
Content-Language: en-US
From: Bo Gan <ganboing@gmail.com>
In-Reply-To: <20241102000843.1301099-1-samuel.holland@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/1/24 17:07, Samuel Holland wrote:
> 
> On some RISC-V platforms, including StarFive JH7100 and ESWIN EIC7700,
> RAM is mapped to multiple physical address ranges, with each alias
> having a different set of statically-determined Physical Memory
> Attributes (PMAs). Software selects the PMAs for a page by choosing a
> PFN from the corresponding physical address range. On these platforms,
> this is the only way to allocate noncached memory for use with
> noncoherent DMA.
> 
>   - Patch 1 adds a new binding to describe physical memory regions in
>     the devicetree.
>   - Patches 2-6 refactor existing memory type support to be modeled as
>     variants on top of Svpbmt.
>   - Patches 7-10 add logic to transform the PFN to use the desired alias
>     when reading/writing page tables.
>   - Patch 11 enables this new method of memory type control on JH7100.
> 
> I have boot-tested this series on platforms with each of the 4 ways to
> select a memory type: SiFive FU740 (none), QEMU (Svpbmt), Allwinner D1
> (XTheadMae), and ESWIN EIC7700 (aliases).
> 

Hi Samuel,

Any update on this? I see ESWIN has started their EIC7700 upstreaming
effort, and it'll likely rely on this. Is there any follow up series?
BTW, Icenowy's working on upstreaming the Verisilicon DC8200 driver.
His work also depend on this patchset in order to test on JH7110/EIC7700

Thanks!


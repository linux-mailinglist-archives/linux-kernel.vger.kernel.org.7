Return-Path: <linux-kernel+bounces-789884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBF4B39C26
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 14:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 125A23B1882
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0C530F545;
	Thu, 28 Aug 2025 12:04:58 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A32914A4DB
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756382697; cv=none; b=qW+MyQMwuFsiI2Nrkt6JYUiAQJn1yoiat9lwgqxCct9/jtCK4PxTMF4uP6qrv0/G1GomXyvll/OVsg+aCq85crbVQM3jjITqZixBJXBUxFJkXqUOHawtjJg07ZwUuco5Bm1yH+VfsC8aaqbO/Fx7nqe8DbNUNGRtGvaMUAbhT4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756382697; c=relaxed/simple;
	bh=eWa1Mfvqkec5Q7BTk2zyGdMLvQbCgTsl+LdlZQIxI2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gHxsF/a903sOwWbMM2I3bmbie2s5e5UJfzmDc3ANXF0gHX6ICTPOiTgf4Swru+SAlALd0iHhExAM0I9srJaARtRhW2B8bmCeMcdlQGAZmRzEF0fV4RQT5qpvEGiJGSDCj4nINgJ2821Bq7O7m4/etoNMdIE364XeEiht+GrbzdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cCKpD3YzfzKHMXD
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 20:04:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 31D651A0E69
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 20:04:52 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP2 (Coremail) with SMTP id Syh0CgAHMJfiRbBo3gdOAg--.14459S2;
	Thu, 28 Aug 2025 20:04:52 +0800 (CST)
Message-ID: <8db10119-58d1-4684-8d1c-b6d82423c438@huaweicloud.com>
Date: Thu, 28 Aug 2025 20:04:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] x86: Prevent KASAN false positive warnings in
 __show_regs()
To: Dave Hansen <dave.hansen@intel.com>, x86@kernel.org
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Alexander Potapenko
 <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Dmitry Vyukov <dvyukov@google.com>, Ingo Molnar <mingo@redhat.com>,
 linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>
References: <20250818130715.2904264-1-wutengda@huaweicloud.com>
 <99878868-9898-46aa-ad4c-ef9aca3e390c@intel.com>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <99878868-9898-46aa-ad4c-ef9aca3e390c@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAHMJfiRbBo3gdOAg--.14459S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jr4UtF4fXFW7Aw1DZF4fKrg_yoWfArgE9r
	sIvrn7Gws7tws2yr15KwsxW3yxK3y8KrnrXFyUtr9Fq34ftFyUAan3ArWfG3ZxKa17KFn8
	uw15Xw1Yka4xujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2025/8/27 22:36, Dave Hansen wrote:
> On 8/18/25 06:07, Tengda Wu wrote:
>> +__no_sanitize_address
>>  void __show_regs(struct pt_regs *regs, enum show_regs_mode mode,
>>  		 const char *log_lvl)
> 
> I'd feel a lot better about this if it didn't just disable KASAN for the
> whole function. Surely there are other __show_regs() users that could
> benefit from sanitizer coverage.
> 
> Can we limit the impact to just the asynchronous (unsafe) stack walkers?
> If it's just for sysrq, this seems like the kind of thing we could just
> a flag somewhere and have KASAN suppress the warning. Or to generically
> tell KASAN that we might be doing accesses in a certain memory range
> that are unsafe.
> 
> I'm also adding Peter and Josh to cc. Seems like the kind of thing they
> might have an opinion on.

I see what you mean. Andrey has provided several approaches — perhaps we
can make a selection from those.



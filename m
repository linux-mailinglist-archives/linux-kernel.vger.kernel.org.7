Return-Path: <linux-kernel+bounces-791018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD241B3B12C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 04:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DAFB7AB721
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 02:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7785A22157E;
	Fri, 29 Aug 2025 02:50:10 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8168E202C2B
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 02:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756435810; cv=none; b=Y3XWfQsJSjHeNM4ThgM367rxBww32u7hqMS4TqhUmxKSRAak6djMv4hs4/lE2NtrYu94qrtqkjtc+6wv/Sr2y61bE6ZXi1F27G/9jDavU9awjixz+DuSCdOS12GqYNmdpWbpDKGx4NlAqP0ZuEI8LKmXGusB9afUe/KSV2YaAIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756435810; c=relaxed/simple;
	bh=GrNy7J8g+FD6LOxpmt8aU4OtT0oe1EF37IAPJuKHHZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nQDFIY0K9AQm2t5kd7QY4llg3WeQ8jFbJOUSHPklZE2xgU1IfBIYkYNLxV0V2YctJpocrMiNSTVwGKLpYrPZakAyINudSF5zMBygyNYvBNXLDNjEYRYyKJPwP7cqo5ROmgGXq8q22IYXPvB3jDw/aqEKyF812n635/SSjhWOJo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cCjRf1f59zYQvLB
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 10:50:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id B99221A0847
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 10:50:04 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP1 (Coremail) with SMTP id cCh0CgCHRXtbFbFo9EuPAg--.57492S2;
	Fri, 29 Aug 2025 10:50:04 +0800 (CST)
Message-ID: <b9396511-810f-4ff6-aead-ceb36dd734b7@huaweicloud.com>
Date: Fri, 29 Aug 2025 10:50:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] x86: Prevent KASAN false positive warnings in
 __show_regs()
To: Dave Hansen <dave.hansen@intel.com>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>, x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Dmitry Vyukov
 <dvyukov@google.com>, Ingo Molnar <mingo@redhat.com>,
 linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>
References: <20250818130715.2904264-1-wutengda@huaweicloud.com>
 <1cd29a46-3c17-42ca-af41-ed0a645b29c3@gmail.com>
 <2956719f-58bf-40ac-9c63-6f9a8092ae1d@huaweicloud.com>
 <3767d017-1b98-4874-a356-51b87d993099@intel.com>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <3767d017-1b98-4874-a356-51b87d993099@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgCHRXtbFbFo9EuPAg--.57492S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYV7kC6x804xWl14x267AKxVW8JVW5JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
	x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kI
	c2xKxwCF04k20xvY0x0EwIxGrwCF54CYxVCY1x0262kKe7AKxVWUtVW8ZwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2025/8/28 22:13, Dave Hansen wrote:
> On 8/28/25 05:06, Tengda Wu wrote:
>> It seems there's no existing on_current_stack function available.
>> Implementing an on_current_stack function would be somewhat
>> challenging for me. 
> 
> Is there some reason that object_is_on_stack() won't work?

Ah, that's what it's called! Yes, object_is_on_stack() should work
perfectly for that. Thanks for the clarification.

-- Tengda



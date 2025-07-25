Return-Path: <linux-kernel+bounces-745285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C2AB117F3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 07:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D9961C870C3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 05:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED46241696;
	Fri, 25 Jul 2025 05:23:54 +0000 (UTC)
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3D91FECAB
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 05:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753421034; cv=none; b=TdaE2dtANmjXf5eljtZ/ZPJE8akpJkkIDce2CVtfA3TaGnpGrYf0lIo4o6bCDpvGnedQ5Zn1ZBB3GslUbXHdRK9wBOenLfbB9lbFmq3kWjRBNQ+pu45RAj6rRIQOCdLv+EclFZUi/7lU5AYemXvPbIIqM48rwKETPLzuvDEc26o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753421034; c=relaxed/simple;
	bh=f4ow7bDo+lpqQlwtvuWvyI7Kyu5JjuoG14Rt80SmvoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BrKL/vfOOcgNSvHKzOS11jCl8QGCseRQit8HV0LUXxKiOElZwd+xAdEIRwPGeXJemkYVtnd66z92nTxAPph/i6PHu8c7p9JqMcEd5UPkIoS7Pc7CRwGxQO8FACljd5o8TND5BQSUyJutVtfywwuz+RmbO9OzXRlV8Rji7oPq/RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bpGTv4mnsz1HC2s
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 13:22:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 092501402DB
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 13:23:43 +0800 (CST)
Received: from [10.48.219.202] (unknown [10.48.219.202])
	by APP1 (Coremail) with SMTP id LxC2BwBX4pfQFINoN8rHAA--.43493S2;
	Fri, 25 Jul 2025 06:23:41 +0100 (CET)
Message-ID: <6f095882-6510-4746-9e59-c24335028237@huaweicloud.com>
Date: Fri, 25 Jul 2025 07:23:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] tools/memory-model: Rule out OOTA
To: paulmck@kernel.org
Cc: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
 stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
 peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
 dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
 akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
 urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
 linux-kernel@vger.kernel.org, lkmm@lists.linux.dev
References: <20250106214003.504664-1-jonas.oberhauser@huaweicloud.com>
 <6fb01aea-f7b4-4f38-82b9-fd6c360514fc@paulmck-laptop>
 <3e98c47c-d354-431f-851f-494df9e6bc78@huaweicloud.com>
 <32a8f541-f760-44a1-8150-5e3d5ba98f34@paulmck-laptop>
 <2ee683dc-1e7a-48c1-b511-d49481c694ca@paulmck-laptop>
Content-Language: en-US
From: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
In-Reply-To: <2ee683dc-1e7a-48c1-b511-d49481c694ca@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:LxC2BwBX4pfQFINoN8rHAA--.43493S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw1rtw1fAr1DXr1UWr1fXrb_yoW8WFyDpF
	WrKa15KF4qvF42yws7tr48X3WSy3yktF1Dur1UWw45Ar1qgFyfKrWSgF45CFy7urs2v3y0
	vrWYga47t3W5ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvmb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYY7kG6xAYrwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7IUYkhLUUUUUU==
X-CM-SenderInfo: xkhu0tnqos00pfhgvzhhrqqx5xdzvxpfor3voofrz/

On 7/24/2025 4:14 PM, Paul E. McKenney wrote:
> On Wed, Jul 23, 2025 at 09:39:05AM -0700, Paul E. McKenney wrote:
>> On Wed, Jul 23, 2025 at 09:26:32AM +0200, Hernan Ponce de Leon wrote:
>>> On 7/23/2025 2:43 AM, Paul E. McKenney wrote:
>>>> On Mon, Jan 06, 2025 at 10:40:03PM +0100, Jonas Oberhauser wrote:
>>>>> The current LKMM allows out-of-thin-air (OOTA), as evidenced in the following
>>>>> example shared on this list a few years ago:
>>>>
>>>> Apologies for being slow, but I have finally added the litmus tests in
>>>> this email thread to the https://github.com/paulmckrcu/litmus repo.
>>>
>>> I do not understand some of the comments in the preamble of the tests:
>>>
>>> (*
>>>   * Result: Never
>>>   *
>>>   * But Sometimes in LKMM as of early 2025, given that 42 is a possible
>>>   * value for things like S19..
>>>   *
>>>   * https://lore.kernel.org/all/20250106214003.504664-1-jonas.oberhauser@huaweicloud.com/
>>>   *)
>>>
>>> I see that herd7 reports one of the states to be [b]=S16. Is this supposed
>>> to be some kind of symbolic state (i.e., any value is possible)?
>>
>> Exactly!
>>
>>> The value in the "Result" is what we would like the model to say if we would
>>> have a perfect version of dependencies, right?
>>
>> In this case, yes.
> 
> I should hasten to add that, compiler optimizations being what they are,
> "perfect" may or may not be attainable, and even if attainable, might
> not be maintainable.

Yes, I just wanted to clarify if this is what herd7 + the current model 
are saying or what developers should expect.

Hernan

> 
> I am pretty sure that you all already understood that, but I felt the
> need to make it explicit.  ;-)
> 
> 							Thanx, Paul



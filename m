Return-Path: <linux-kernel+bounces-742030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E54B0EC25
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD45F4E1DDD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 07:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DFC27702E;
	Wed, 23 Jul 2025 07:43:05 +0000 (UTC)
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8942D27603B
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 07:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753256584; cv=none; b=uJBdJDyZsW874BPTZN9nnAWLf27yNauK5FKf6CwdQW9M8fioLZmkdxYpODQhIkYh1Au8D47sbIsz4/6J4QuNCwoyj55HyopBIcgoDg8riqg8dNcvLMJWSIucCT/RSGOyZZLX5vZqW78mmCG3htzFIuexuVcPY2jvKAhMU8CBzSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753256584; c=relaxed/simple;
	bh=qrdZX6NGVpsIzcbs4q3jA6/MCX2wxaJK8y8nQoHnI9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jq6vtYdjMKCjO+QbZrtsKIqzF5UgRY85nXDB0MLtTqEn39XUKTBx8A6g+oCgVVmrTVcLPk4lBTGgHYXGm+iL68gxLA/uxwB72nncD7FoXS/YvAa4rMmweR2Bh4MjLk7yKfMKYgwInbM1xx60yB8TrfflY3bkphh1NqBBPd+hvwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bn5Jy2CBfz1HCVf
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 15:25:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 735481402F6
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 15:26:51 +0800 (CST)
Received: from [10.221.99.159] (unknown [10.221.99.159])
	by APP1 (Coremail) with SMTP id LxC2BwBH0perjoBoDiyqAA--.34104S2;
	Wed, 23 Jul 2025 08:26:50 +0100 (CET)
Message-ID: <3e98c47c-d354-431f-851f-494df9e6bc78@huaweicloud.com>
Date: Wed, 23 Jul 2025 09:26:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] tools/memory-model: Rule out OOTA
To: paulmck@kernel.org, Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
 peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
 dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
 akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
 urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
 linux-kernel@vger.kernel.org, lkmm@lists.linux.dev
References: <20250106214003.504664-1-jonas.oberhauser@huaweicloud.com>
 <6fb01aea-f7b4-4f38-82b9-fd6c360514fc@paulmck-laptop>
Content-Language: en-US
From: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
In-Reply-To: <6fb01aea-f7b4-4f38-82b9-fd6c360514fc@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:LxC2BwBH0perjoBoDiyqAA--.34104S2
X-Coremail-Antispam: 1UD129KBjvJXoWfGr1kXr1furyfKw4rWF48Zwb_yoWkWry7pa
	9xWF4q9FZxZF1rArsrua1UAFn3u3WUZFnxuFnrW34rCFsxCryakr92qrW8JrW8uryDCr48
	Ka90yFWqyr4jga7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIa
	0PDUUUU
X-CM-SenderInfo: xkhu0tnqos00pfhgvzhhrqqx5xdzvxpfor3voofrz/

On 7/23/2025 2:43 AM, Paul E. McKenney wrote:
> On Mon, Jan 06, 2025 at 10:40:03PM +0100, Jonas Oberhauser wrote:
>> The current LKMM allows out-of-thin-air (OOTA), as evidenced in the following
>> example shared on this list a few years ago:
> 
> Apologies for being slow, but I have finally added the litmus tests in
> this email thread to the https://github.com/paulmckrcu/litmus repo.

I do not understand some of the comments in the preamble of the tests:

(*
  * Result: Never
  *
  * But Sometimes in LKMM as of early 2025, given that 42 is a possible
  * value for things like S19..
  *
  * 
https://lore.kernel.org/all/20250106214003.504664-1-jonas.oberhauser@huaweicloud.com/
  *)

I see that herd7 reports one of the states to be [b]=S16. Is this 
supposed to be some kind of symbolic state (i.e., any value is possible)?

The value in the "Result" is what we would like the model to say if we 
would have a perfect version of dependencies, right?

> 
> It is quite likely that I have incorrectly intuited the missing portions
> of the litmus tests, especially the two called out in the commit log
> below.  If you have time, please do double-check.

I read the "On the other hand" from the commit log as "this fixes the 
problem". However I still get the following error when running 
C-JO-OOTA-7 with herd7

Warning: File "manual/oota/C-JO-OOTA-7.litmus": Non-symbolic memory 
access found on '[0]' (User error)


Hernan>
> And the updated (and condensed!) version of the C++ OOTA paper may be
> found here, this time with a proposed change to the standard:
> 
> https://www.open-std.org/jtc1/sc22/wg21/docs/papers/2025/p3692r1.pdf
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit fd17e8fceb75326e159ba3aa6fdb344f74f5c7a5
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Tue Jul 22 17:21:19 2025 -0700
> 
>      manual/oota:  Add Jonas and Alan OOTA examples
>      
>      Each of these new litmus tests contains the URL of the email message
>      that I took it from.
>      
>      Please note that I had to tweak the example leading up to
>      C-JO-OOTA-4.litmus, and I might well have misinterpreted Jonas's "~"
>      operator.
>      
>      Also, C-JO-OOTA-7.litmus includes a "*r2 = a" statement that makes herd7
>      very unhappy.  On the other hand, initializing registers to the address
>      of a variable is straight forward, as shown in the resulting litmus test.
>      
>      Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/manual/oota/C-AS-OOTA-1.litmus b/manual/oota/C-AS-OOTA-1.litmus
> new file mode 100644
> index 00000000..81a873a7
> --- /dev/null
> +++ b/manual/oota/C-AS-OOTA-1.litmus
> @@ -0,0 +1,40 @@
> +C C-AS-OOTA-1
> +
> +(*
> + * Result: Sometimes
> + *
> + * Because smp_rmb() combined with smp_wmb() does not order earlier
> + * reads against later writes.
> + *
> + * https://lore.kernel.org/all/a3bf910f-509a-4ad3-a1cc-4b14ef9b3259@rowland.harvard.edu
> + *)
> +
> +{}
> +
> +P0(int *a, int *b, int *x, int *y)
> +{
> +	int r1;
> +
> +	r1 = READ_ONCE(*x);
> +	smp_rmb();
> +	if (r1 == 1) {
> +		*a = *b;
> +	}
> +	smp_wmb();
> +	WRITE_ONCE(*y, 1);
> +}
> +
> +P1(int *a, int *b, int *x, int *y)
> +{
> +	int r1;
> +
> +	r1 = READ_ONCE(*y);
> +	smp_rmb();
> +	if (r1 == 1) {
> +		*b = *a;
> +	}
> +	smp_wmb();
> +	WRITE_ONCE(*x, 1);
> +}
> +
> +exists (0:r1=1 /\ 1:r1=1)
> diff --git a/manual/oota/C-AS-OOTA-2.litmus b/manual/oota/C-AS-OOTA-2.litmus
> new file mode 100644
> index 00000000..c672b0e7
> --- /dev/null
> +++ b/manual/oota/C-AS-OOTA-2.litmus
> @@ -0,0 +1,33 @@
> +C C-AS-OOTA-2
> +
> +(*
> + * Result: Always
> + *
> + * If we were using C-language relaxed atomics instead of volatiles,
> + * the compiler *could* eliminate the first WRITE_ONCE() in each process,
> + * then also each process's local variable, thus having an undefined value
> + * for each of those local variables.  But this cannot happen given that
> + * we are using Linux-kernel _ONCE() primitives.
> + *
> + * https://lore.kernel.org/all/c2ae9bca-8526-425e-b9b5-135004ad59ad@rowland.harvard.edu/
> + *)
> +
> +{}
> +
> +P0(int *a, int *b)
> +{
> +	int r0 = READ_ONCE(*a);
> +
> +	WRITE_ONCE(*b, r0);
> +	WRITE_ONCE(*b, 2);
> +}
> +
> +P1(int *a, int *b)
> +{
> +	int r1 = READ_ONCE(*b);
> +
> +	WRITE_ONCE(*a, r0);
> +	WRITE_ONCE(*a, 2);
> +}
> +
> +exists ((0:r0=0 \/ 0:r0=2) /\ (1:r1=0 \/ 1:r1=2))
> diff --git a/manual/oota/C-JO-OOTA-1.litmus b/manual/oota/C-JO-OOTA-1.litmus
> new file mode 100644
> index 00000000..6ab437b4
> --- /dev/null
> +++ b/manual/oota/C-JO-OOTA-1.litmus
> @@ -0,0 +1,40 @@
> +C C-JO-OOTA-1
> +
> +(*
> + * Result: Never
> + *
> + * But Sometimes in LKMM as of early 2025, given that 42 is a possible
> + * value for things like S19..
> + *
> + * https://lore.kernel.org/all/20250106214003.504664-1-jonas.oberhauser@huaweicloud.com/
> + *)
> +
> +{}
> +
> +P0(int *a, int *b, int *x, int *y)
> +{
> +	int r1;
> +
> +	r1 = READ_ONCE(*x);
> +	smp_rmb();
> +	if (r1 == 1) {
> +		*a = *b;
> +	}
> +	smp_wmb();
> +	WRITE_ONCE(*y, 1);
> +}
> +
> +P1(int *a, int *b, int *x, int *y)
> +{
> +	int r1;
> +
> +	r1 = READ_ONCE(*y);
> +	smp_rmb();
> +	if (r1 == 1) {
> +		*b = *a;
> +	}
> +	smp_wmb();
> +	WRITE_ONCE(*x, 1);
> +}
> +
> +exists (b=42)
> diff --git a/manual/oota/C-JO-OOTA-2.litmus b/manual/oota/C-JO-OOTA-2.litmus
> new file mode 100644
> index 00000000..ad708c60
> --- /dev/null
> +++ b/manual/oota/C-JO-OOTA-2.litmus
> @@ -0,0 +1,44 @@
> +C C-JO-OOTA-2
> +
> +(*
> + * Result: Never
> + *
> + * But Sometimes in LKMM as of early 2025, given that 42 is a possible
> + * value for things like S23.
> + *
> + * https://lore.kernel.org/all/1daba0ea-0dd6-4e67-923e-fd3c1a62b40b@huaweicloud.com/
> + *)
> +
> +{}
> +
> +P0(int *a, int *b, int *x, int *y)
> +{
> +	int r1;
> +	int r2 = 0;
> +
> +	r1 = READ_ONCE(*x);
> +	smp_rmb();
> +	if (r1 == 1) {
> +		r2 = *b;
> +	}
> +	WRITE_ONCE(*a, r2);
> +	smp_wmb();
> +	WRITE_ONCE(*y, 1);
> +}
> +
> +P1(int *a, int *b, int *x, int *y)
> +{
> +	int r1;
> +	int r2 = 0;
> +
> +	r1 = READ_ONCE(*y);
> +	smp_rmb();
> +	if (r1 == 1) {
> +		r2 = *a;
> +	}
> +	WRITE_ONCE(*b, r2);
> +	smp_wmb();
> +	WRITE_ONCE(*x, 1);
> +}
> +
> +exists (b=42)
> diff --git a/manual/oota/C-JO-OOTA-3.litmus b/manual/oota/C-JO-OOTA-3.litmus
> new file mode 100644
> index 00000000..633b8334
> --- /dev/null
> +++ b/manual/oota/C-JO-OOTA-3.litmus
> @@ -0,0 +1,46 @@
> +C C-JO-OOTA-3
> +
> +(*
> + * Result: Never
> + *
> + * But LKMM finds the all-ones result, perhaps due to not tracking
> + * control dependencies out of the "if" statement.
> + *
> + * https://lore.kernel.org/all/1daba0ea-0dd6-4e67-923e-fd3c1a62b40b@huaweicloud.com/
> + *)
> +
> +{}
> +
> +P0(int *a, int *b, int *x, int *y)
> +{
> +	int r1;
> +	int r2;
> +
> +	r1 = READ_ONCE(*x);
> +	smp_rmb();
> +	r2 = READ_ONCE(*b);
> +	if (r1 == 1) {
> +		r2 = *b;
> +	}
> +	WRITE_ONCE(*a, r2);
> +	smp_wmb();
> +	WRITE_ONCE(*y, 1);
> +}
> +
> +P1(int *a, int *b, int *x, int *y)
> +{
> +	int r1;
> +	int r2;
> +
> +	r1 = READ_ONCE(*y);
> +	smp_rmb();
> +	r2 = READ_ONCE(*a);
> +	if (r1 == 1) {
> +		r2 = *a;
> +	}
> +	WRITE_ONCE(*b, r2);
> +	smp_wmb();
> +	WRITE_ONCE(*x, 1);
> +}
> +
> +exists (0:r1=1 /\ 1:r1=1)
> diff --git a/manual/oota/C-JO-OOTA-4.litmus b/manual/oota/C-JO-OOTA-4.litmus
> new file mode 100644
> index 00000000..cab7ebb6
> --- /dev/null
> +++ b/manual/oota/C-JO-OOTA-4.litmus
> @@ -0,0 +1,43 @@
> +C C-JO-OOTA-4
> +
> +(*
> + * Result: Never
> + *
> + * And LKMM agrees, which might be a surprise.
> + *
> + * https://lore.kernel.org/all/1daba0ea-0dd6-4e67-923e-fd3c1a62b40b@huaweicloud.com/
> + *)
> +
> +{}
> +
> +P0(int *a, int *b, int *x, int *y)
> +{
> +	int r1;
> +	int r2;
> +	int r3;
> +
> +	r1 = READ_ONCE(*x);
> +	smp_rmb();
> +	r2 = *b;
> +	r3 = r1 == 0;
> +	WRITE_ONCE(*a, (r3 + 1) & r2);
> +	smp_wmb();
> +	WRITE_ONCE(*y, 1);
> +}
> +
> +P1(int *a, int *b, int *x, int *y)
> +{
> +	int r1;
> +	int r2;
> +	int r3;
> +
> +	r1 = READ_ONCE(*y);
> +	smp_rmb();
> +	r2 = *a;
> +	r3 = r1 == 0;
> +	WRITE_ONCE(*b, (r3 + 1) & r2);
> +	smp_wmb();
> +	WRITE_ONCE(*x, 1);
> +}
> +
> +exists (0:r1=1 /\ 1:r1=1)
> diff --git a/manual/oota/C-JO-OOTA-5.litmus b/manual/oota/C-JO-OOTA-5.litmus
> new file mode 100644
> index 00000000..145c8378
> --- /dev/null
> +++ b/manual/oota/C-JO-OOTA-5.litmus
> @@ -0,0 +1,44 @@
> +C C-JO-OOTA-5
> +
> +(*
> + * Result: Never
> + *
> + * But LKMM finds the all-ones result, perhaps due r2 being unused.
> + *
> + * https://lore.kernel.org/all/1daba0ea-0dd6-4e67-923e-fd3c1a62b40b@huaweicloud.com/
> + *)
> +
> +{}
> +
> +P0(int *a, int *b, int *x, int *y)
> +{
> +	int r1;
> +	int r2;
> +
> +	r1 = READ_ONCE(*x);
> +	smp_rmb();
> +	if (r1 == 1) {
> +		r2 = READ_ONCE(*a);
> +	}
> +	*b = 1;
> +	smp_wmb();
> +	WRITE_ONCE(*y, 1);
> +}
> +
> +P1(int *a, int *b, int *x, int *y)
> +{
> +	int r1;
> +	int r2;
> +
> +	r1 = READ_ONCE(*y);
> +	smp_rmb();
> +	if (r1 == 1) {
> +		r2 = READ_ONCE(*b);
> +	}
> +	*a = 1;
> +	smp_wmb();
> +	WRITE_ONCE(*x, 1);
> +}
> +
> +locations [0:r2;1:r2]
> +exists (0:r1=1 /\ 1:r1=1)
> diff --git a/manual/oota/C-JO-OOTA-6.litmus b/manual/oota/C-JO-OOTA-6.litmus
> new file mode 100644
> index 00000000..942e6c82
> --- /dev/null
> +++ b/manual/oota/C-JO-OOTA-6.litmus
> @@ -0,0 +1,44 @@
> +C C-JO-OOTA-6
> +
> +(*
> + * Result: Never
> + *
> + * But LKMM finds the all-ones result, due to OOTA on r2.
> + *
> + * https://lore.kernel.org/all/1147ad3e-e3ad-4fa1-9a63-772ba136ea9a@huaweicloud.com/
> + *)
> +
> +{}
> +
> +P0(int *a, int *b, int *x, int *y)
> +{
> +	int r1;
> +	int r2;
> +
> +	r1 = READ_ONCE(*x);
> +	smp_rmb();
> +	if (r1 == 1) {
> +		r2 = READ_ONCE(*a);
> +	}
> +	*b = r2;
> +	smp_wmb();
> +	WRITE_ONCE(*y, 1);
> +}
> +
> +P1(int *a, int *b, int *x, int *y)
> +{
> +	int r1;
> +	int r2;
> +
> +	r1 = READ_ONCE(*y);
> +	smp_rmb();
> +	if (r1 == 1) {
> +		r2 = READ_ONCE(*b);
> +	}
> +	*a = r2;
> +	smp_wmb();
> +	WRITE_ONCE(*x, 1);
> +}
> +
> +locations [0:r2;1:r2]
> +exists (0:r1=1 /\ 1:r1=1)
> diff --git a/manual/oota/C-JO-OOTA-7.litmus b/manual/oota/C-JO-OOTA-7.litmus
> new file mode 100644
> index 00000000..31c0b8ae
> --- /dev/null
> +++ b/manual/oota/C-JO-OOTA-7.litmus
> @@ -0,0 +1,47 @@
> +C C-JO-OOTA-7
> +
> +(*
> + * Result: Never
> + *
> + * But LKMM finds the all-ones result, due to OOTA on r2.
> + *
> + * https://lore.kernel.org/all/1147ad3e-e3ad-4fa1-9a63-772ba136ea9a@huaweicloud.com/
> + *)
> +
> +{
> +	0:r2=a;
> +	1:r2=b;
> +}
> +
> +P0(int *a, int *b, int *x, int *y)
> +{
> +	int r1;
> +	int r2;
> +
> +	r1 = READ_ONCE(*x);
> +	smp_rmb();
> +	if (r1 == 1) {
> +		r2 = READ_ONCE(*a);
> +	}
> +	*r2 = a;
> +	smp_wmb();
> +	WRITE_ONCE(*y, 1);
> +}
> +
> +P1(int *a, int *b, int *x, int *y)
> +{
> +	int r1;
> +	int r2;
> +
> +	r1 = READ_ONCE(*y);
> +	smp_rmb();
> +	if (r1 == 1) {
> +		r2 = READ_ONCE(*b);
> +	}
> +	*r2 = b;
> +	smp_wmb();
> +	WRITE_ONCE(*x, 1);
> +}
> +
> +locations [0:r2;1:r2]
> +exists (0:r1=1 /\ 1:r1=1)
> diff --git a/manual/oota/C-PM-OOTA-1.litmus b/manual/oota/C-PM-OOTA-1.litmus
> new file mode 100644
> index 00000000..e771e3c9
> --- /dev/null
> +++ b/manual/oota/C-PM-OOTA-1.litmus
> @@ -0,0 +1,37 @@
> +C C-PM-OOTA-1
> +
> +(*
> + * Result: Never
> + *
> + * LKMM agrees.
> + *
> + * https://lore.kernel.org/all/9a0dccbb-bfa7-4b33-ac1a-daa9841b609a@paulmck-laptop/
> + *)
> +
> +{}
> +
> +P0(int *a, int *b, int *x, int *y) {
> +	int r1;
> +
> +	r1 = READ_ONCE(*x);
> +	smp_rmb();
> +	if (r1 == 1) {
> +		WRITE_ONCE(*a, *b);
> +	}
> +	smp_wmb();
> +	WRITE_ONCE(*y, 1);
> +}
> +
> +P1(int *a, int *b, int *x, int *y) {
> +	int r1;
> +
> +	r1 = READ_ONCE(*y);
> +	smp_rmb();
> +	if (r1 == 1) {
> +		WRITE_ONCE(*b, *a);
> +	}
> +	smp_wmb();
> +	WRITE_ONCE(*x, 1);
> +}
> +
> +exists b=42



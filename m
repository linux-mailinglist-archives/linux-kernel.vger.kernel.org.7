Return-Path: <linux-kernel+bounces-828186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC100B94217
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 05:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A4A518A5175
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 03:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7460326CE0C;
	Tue, 23 Sep 2025 03:42:52 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F7F26A0B3
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 03:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758598971; cv=none; b=T9MlL42i92Tb2YtiYb7P43YTk40wcb+eayGA5DCbY75+R8bmc+2CScjImBbd6lKznFlCnd4XB1MN3+dN+nFVHb7ngGcNztIeZs+y/O97BC0U8jtQicTsS+90TRYJQdv23GyfOf8nDPKc3Ywd2DBw4JkHFfbeeFwyidyVWqETTDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758598971; c=relaxed/simple;
	bh=SqHC7n36LZUBGhrKYKqv0AA8c7Kq+tX+BONot7dBa2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=trrZ7HW5pYIv+QPPYlQvDJIVy4XMWxt8ixvB2cqDtT/a5G0uF6/J5DMcWGXlBFFM25K8pl0Fv3PS1+XBUiGZaLKBPUIF/2Vok4IQqJYCdz5D3ZVnTKSGxdcZ4HQxDIbbuzo1Bo8cAr0wD1Iippeq5Vpy+nJ1mPGsPyC6RGpQyZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4cW5S72C6Vz27jBq;
	Tue, 23 Sep 2025 11:43:51 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id 0BEAE140143;
	Tue, 23 Sep 2025 11:42:40 +0800 (CST)
Received: from [10.174.177.19] (10.174.177.19) by
 dggpemf500016.china.huawei.com (7.185.36.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 23 Sep 2025 11:42:39 +0800
Message-ID: <9d291c0f-17f0-4559-8b20-bb6186a8646b@huawei.com>
Date: Tue, 23 Sep 2025 11:42:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] locktorture: Fix memory leak in param_set_cpumask()
To: <paulmck@kernel.org>, Zhang Changzhong <zhangchangzhong@huawei.com>
CC: <dave@stgolabs.net>, <josh@joshtriplett.org>, <frederic@kernel.org>,
	<yuehaibing@huawei.com>, <linux-kernel@vger.kernel.org>
References: <20250912015737.1209143-1-wangliang74@huawei.com>
 <6b433670-c79e-4439-9b9a-f10c548a727f@huawei.com>
 <9d51ece8-cb07-450b-a91a-095abcb8472a@huawei.com>
 <679d81f3-2610-44b9-bc9a-30ef0f70fa36@paulmck-laptop>
 <5eccd340-a4bb-4b46-897e-a673f9a5cb86@huawei.com>
 <9e0595a2-cbba-4635-b57c-a220f2d86fe2@paulmck-laptop>
 <d07dd312-295e-4703-895b-8ce438acea3c@huawei.com>
 <06f32215-ec2c-4d8f-8ccd-bc8dc250ec77@paulmck-laptop>
From: Wang Liang <wangliang74@huawei.com>
In-Reply-To: <06f32215-ec2c-4d8f-8ccd-bc8dc250ec77@paulmck-laptop>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500016.china.huawei.com (7.185.36.197)


在 2025/9/19 18:41, Paul E. McKenney 写道:
> On Fri, Sep 19, 2025 at 06:22:40PM +0800, Zhang Changzhong wrote:
>> 在 2025/9/18 23:20, Paul E. McKenney 写道:
>>> On Thu, Sep 18, 2025 at 11:06:45PM +0800, Zhang Changzhong wrote:
>>>> 在 2025/9/18 17:03, Paul E. McKenney 写道:
>>>>> On Mon, Sep 15, 2025 at 10:13:33AM +0800, Wang Liang wrote:
>>>>>> 在 2025/9/12 10:16, Zhang Changzhong 写道:
>>>>>>> 在 2025/9/12 9:57, Wang Liang 写道:
>>>>>>>> When setting the locktorture module parameter 'bind_writers', the variable
>>>>>>>> 'cpumask_var_t bind_writers' is allocated in param_set_cpumask(). But it
>>>>>>>> is not freed, when removing module or setting the parameter again.
>>>>>>>>
>>>>>>>> Below kmemleak trace is seen for this issue:
>>>>>>>>
>>>>>>>> unreferenced object 0xffff888100aabff8 (size 8):
>>>>>>>>     comm "bash", pid 323, jiffies 4295059233
>>>>>>>>     hex dump (first 8 bytes):
>>>>>>>>       07 00 00 00 00 00 00 00                          ........
>>>>>>>>     backtrace (crc ac50919):
>>>>>>>>       __kmalloc_node_noprof+0x2e5/0x420
>>>>>>>>       alloc_cpumask_var_node+0x1f/0x30
>>>>>>>>       param_set_cpumask+0x26/0xb0 [locktorture]
>>>>>>>>       param_attr_store+0x93/0x100
>>>>>>>>       module_attr_store+0x1b/0x30
>>>>>>>>       kernfs_fop_write_iter+0x114/0x1b0
>>>>>>>>       vfs_write+0x300/0x410
>>>>>>>>       ksys_write+0x60/0xd0
>>>>>>>>       do_syscall_64+0xa4/0x260
>>>>>>>>       entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>>>>>>>
>>>>>>>> This issue can be reproduced by:
>>>>>>>>     insmod locktorture.ko
>>>>>>>>     echo 0-2 > /sys/module/locktorture/parameters/bind_writers
>>>>>>>>     rmmod locktorture
>>>>>>>>
>>>>>>>> or:
>>>>>>>>     insmod locktorture.ko
>>>>>>>>     echo 0-2 > /sys/module/locktorture/parameters/bind_writers
>>>>>>>>     echo 0-2 > /sys/module/locktorture/parameters/bind_writers
>>>>>>>>
>>>>>>>> The parameter 'bind_readers' also has the same problem. Free the memory
>>>>>>>> when removing module or setting the parameter.
>>>>>>>>
>>>>>>>> Fixes: 73e341242483 ("locktorture: Add readers_bind and writers_bind module parameters")
>>>>>>>> Signed-off-by: Wang Liang <wangliang74@huawei.com>
>>>>>>>> ---
>>>>>>>>    kernel/locking/locktorture.c | 9 +++++++++
>>>>>>>>    1 file changed, 9 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
>>>>>>>> index ce0362f0a871..cad80c050502 100644
>>>>>>>> --- a/kernel/locking/locktorture.c
>>>>>>>> +++ b/kernel/locking/locktorture.c
>>>>>>>> @@ -70,6 +70,9 @@ static int param_set_cpumask(const char *val, const struct kernel_param *kp)
>>>>>>>>    	int ret;
>>>>>>>>    	char *s;
>>>>>>>> +	free_cpumask_var(*cm_bind);
>>>>>>>> +	*cm_bind = NULL;
>>>>>>> 这个NULL没必要吧
>>>>> Assuming this translates to "This NULL is unnecessary", I have to
>>>>> agree with Zhang Changzhong.  I would go further and argue that the
>>>>> free_cpumask_var() is also unnecessary here.
>>>> Sorry, I used Chinese by mistake—I didn't notice this was a public thread.
>>> Not a problem!  There is always translation software, not that I ever
>>> will completely trust it.  ;-)
>>>
>>>> With CONFIG_CPUMASK_OFFSTACK=y, the free_cpumask_var() here seems necessary,
>>>> when param_set_cpumask() called multiple times, 'cm_bind' gets overwritten,
>>>> and the free_cpumask_var() in lock_torture_cleanup() cannot free the old memory.
>>> So the situation you are worried about is when the user mistakenly puts
>>> multiple copies of one of the locktorture.bind_{readers,writers} module
>>> parameters on the kernel boot command line or as a modprobe parameter?
>>>
>> I didn't consider this situation. What I noticed is that bind_{readers,writers}
>> are writable interface, and fuzz testing tools like syzkaller can easily write
>> to /sys/module/locktorture/parameters/bind_{readers,writers} and trigger memory
>> leak.
>>
>> In this case, the patch fixes the memory leak issue, but the old parameters
>> remain in effect instead of the newly written ones. Considering that writing
>> to this interface after modprobe has no real effect, how about set the
>> permissions to 0444?
> That sounds like a most excellent approach.
>
>>> If so, what do we really want to happen in that case?  Do we want the
>>> last (say) locktorture.bind_readers value to win?  Or do we want to OR
>>> together all such values?
>> In the case you mentioned, it seems more reasonable that the last
>> locktorture.bind_readers wins, which is also the current behavior.
> In which case, what has to happen to handle something like this?
>
> 	modprobe locktorture bind_readers=8
> 	rmmod locktorture
> 	modprobe locktorture bind_readers=5
>
> Doesn't this require careful handling of the bind_readers variable in
> lock_torture_cleanup(), for both possible settings of the CPUMASK_OFFSTACK
> Kconfig option?
>
>   							Thanx, Paul


@Paul @Zhang thanks for all your suggestions!

Setting the parameter permissions to 0444 is a good approach, so user can't
change the parameters and not need to call free_cpumask_var() in
param_set_cpumask().

The free_cpumask_var() is still need to free bind_readers/bind_writers.

In below case, the 'bind_readers' is freed by rmmod. When run modprobe at
the second time, the 'bind_readers' is reinitialized to NULL before
allocated in param_set_cpumask().

     modprobe locktorture bind_readers=8
     rmmod locktorture
     modprobe locktorture bind_readers=5

So no need to NULLing bind_readers, the final patch like this:

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index ce0362f0a871..6567e5eeacc0 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -103,8 +103,8 @@ static const struct kernel_param_ops lt_bind_ops = {
         .get = param_get_cpumask,
  };

-module_param_cb(bind_readers, &lt_bind_ops, &bind_readers, 0644);
-module_param_cb(bind_writers, &lt_bind_ops, &bind_writers, 0644);
+module_param_cb(bind_readers, &lt_bind_ops, &bind_readers, 0444);
+module_param_cb(bind_writers, &lt_bind_ops, &bind_writers, 0444);

  long torture_sched_setaffinity(pid_t pid, const struct cpumask 
*in_mask, bool dowarn);

@@ -1211,6 +1211,10 @@ static void lock_torture_cleanup(void)
                         cxt.cur_ops->exit();
                 cxt.init_called = false;
         }
+
+       free_cpumask_var(bind_readers);
+       free_cpumask_var(bind_writers);
+
         torture_cleanup_end();
  }

------
Best regards
Wang Liang

>>>>>> Setting global pointer to NULL after free may be more safe. ^-^
>>>>> In lock_torture_cleanup(), you mean?  I would agree with that.
>>>>>
>>>>>>>> +
>>>>>>>>    	if (!alloc_cpumask_var(cm_bind, GFP_KERNEL)) {
>>>>>>>>    		s = "Out of memory";
>>>>>>>>    		ret = -ENOMEM;
>>>>>>>> @@ -1211,6 +1214,12 @@ static void lock_torture_cleanup(void)
>>>>>>>>    			cxt.cur_ops->exit();
>>>>>>>>    		cxt.init_called = false;
>>>>>>>>    	}
>>>>>>>> +
>>>>>>>> +	free_cpumask_var(bind_readers);
>>>>>>>> +	free_cpumask_var(bind_writers);
>>>>>>>> +	bind_readers = NULL;
>>>>>>>> +	bind_writers = NULL;
>>>>>>> 同上
>>>>> But here I agree with Wang Liang, as it helps people running debuggers
>>>>> on the kernel.  Instead of a dangling pointer, they see a NULL pointer.
>>>>>
>>>>> Except...  Is this NULLing really the right thing to do for
>>>>> CONFIG_CPUMASK_OFFSTACK=n kernels?
>>>>>
>>>>> 							Thanx, Paul
>>>>>
>>>>>>>> +
>>>>>>>>    	torture_cleanup_end();
>>>>>>>>    }


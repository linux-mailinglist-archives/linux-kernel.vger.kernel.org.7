Return-Path: <linux-kernel+bounces-862173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D69BF498A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 06:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 269BC426939
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 04:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F293A23BCE4;
	Tue, 21 Oct 2025 04:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YX2IIA6Q"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AD1C2FB
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 04:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761021834; cv=none; b=ZOLE+R8+A4mNLYJzt+8E03zl2C9lmlfdhsiJc013RszOBFp+u5wZiC9hUnGU5cfdb8Ocb444PJlKhUnXoRMj6p0GtqbzomkeH7oEM7C4PzJb9UwmuV1TGCYK7/vwNmwmmQNdPDAScwTTkbdCbfvfs96WnlgZElzFm28pWt/pmLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761021834; c=relaxed/simple;
	bh=qpQdav/or9x6VcmVrahI/bLK62QAqHTyX/SQnlNmEFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=myC7hLk/a2n44TmsX8vgm36Ngmh6JikzWfq35q05PUnvJ1RpjxzB3YKQ/9ThJ239/vQvxX//lMuovnEdMbAG373qzZxkJfuYlAfM3xUqrO9jV8Ze3Q0Y7hYjTdjwNZ6sQ7QALxcwaa7voh4gXegnktQH5Uk+aVIXeNusAcl/Cng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YX2IIA6Q; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KI6vsa008463;
	Tue, 21 Oct 2025 04:43:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gIKKvp
	OjBnVn0ZgJjg9Ax0OmOrGkqHahv0rcgKP1srk=; b=YX2IIA6Qcoi/c+5OUSLFok
	ChmiNEYApNrwEvdmDfsOdkptn0CA4mMxITPp0vCFtkq7BjE9c6xF/4+7X89vZU+n
	j/rKRQtrzQoohvhU31MZ/O5rhkGfxlyUqtV1O0lu8bMQALCA0dETP4OAdAFRWVgL
	R9HH+JnTnxe1ddn3dhT1+oEilL6ARfdQ2wH9YMZV8qwLK+/Hkr9aEw9TF+mGiOiz
	z62dTX71xPzMhwU24uchdS2gCbva+kl1Rp33ikHnGegSYBZtR4lpWeQ3hVU9WIEf
	XH9j1s9b0rszaAwG0kT9Jn4ZNE4ruUVP+dwbXPXHQcLRrCC+R5f+m3Gkmdj/Nj4g
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v32hbrdj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 04:43:02 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59L1wsFQ014650;
	Tue, 21 Oct 2025 04:43:02 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vn7s184u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 04:43:01 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59L4h08L52101516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 04:43:00 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3426620043;
	Tue, 21 Oct 2025 04:43:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3263420040;
	Tue, 21 Oct 2025 04:42:58 +0000 (GMT)
Received: from [9.39.24.46] (unknown [9.39.24.46])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Oct 2025 04:42:58 +0000 (GMT)
Message-ID: <17915467-06de-46f1-9032-3af258ff1aee@linux.ibm.com>
Date: Tue, 21 Oct 2025 10:12:57 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [kernel?] WARNING in hrtimer_forward (4)
To: Juri Lelli <juri.lelli@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: syzbot <syzbot+8b3a2e23253b50098164@syzkaller.appspotmail.com>,
        anna-maria@linutronix.de, frederic@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Peter Zijlstra <peterz@infradead.org>, Juri Lelli <jlelli@redhat.com>
References: <68b25b42.a70a0220.1c57d1.00f6.GAE@google.com>
 <87qzwers0e.ffs@tglx> <aMKTHKfegBk4DgjA@jlelli-thinkpadt14gen4.remote.csb>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <aMKTHKfegBk4DgjA@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXwp50I7urEgMn
 VUcI+59dSSUzkM/xRC3/08UectrSMmRtWBCPw3ycipL2BiprXhQXUrGShajqlKSbd+NkZkP0vnM
 dA4lxoLAmY3vGxBNyjpiu7qq2peizlkq4d7ArqWYoObbDx+UXb0svFJUFau95WHHp5pbdpRF+0j
 9QKBTcvc5fNfsj/TMgRMFFXut+OjtpJkB/pC2CtE4UQUFKtXL+O1PwroIuYgO/5c3x4fYVrryuT
 pfQ4/yJSYhHtoolSyMIWZufVwKBNcfjf4oDINqrIpSwbYwydve5Crvqz2W2wfwZ2tv1T6Qqq7Z6
 mazq/DyYXXLs9L5v/D45RQ2BLzmnYuKE9p7nkpDOTrchbKkpVZu3lr+W4FfQQQRSnAsi06JWZqo
 1YYpsHhoaQB5HVy+2/8/ircYq+ErzA==
X-Authority-Analysis: v=2.4 cv=OrVCCi/t c=1 sm=1 tr=0 ts=68f70f56 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=edf1wS77AAAA:8 a=3g80flMcAAAA:8 a=hSkVLCK3AAAA:8 a=6SkdbZ_t31Cmx5KfQngA:9
 a=BhMdqm2Wqc4Q2JL7t0yJfBCtM/Y=:19 a=QEXdDO2ut3YA:10 a=slFVYn995OdndYK6izCD:22
 a=DcSpbTIhAlouE1Uv7lRv:22 a=3urWGuTZa-U-TZ_dHwj2:22 a=cQPPKAXgyycSBL8etih5:22
 a=cPQSjfK2_nFv0Q5t_7PE:22 a=poXaRoVlC6wW9_mwW8W4:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22
 a=SsAZrZ5W_gNWK9tOzrEV:22
X-Proofpoint-GUID: oUkYrR7jyc0OMSEIMBDuGwVLTtTpgFZS
X-Proofpoint-ORIG-GUID: oUkYrR7jyc0OMSEIMBDuGwVLTtTpgFZS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 clxscore=1011 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022



On 9/11/25 2:45 PM, Juri Lelli wrote:
> On 10/09/25 22:07, Thomas Gleixner wrote:
>> On Fri, Aug 29 2025 at 19:00, syzbot wrote:
>>
>>> HEAD commit:    b6add54ba618 Merge tag 'pinctrl-v6.17-2' of git://git.kern..
>>> git tree:       upstream
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=1130eef0580000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=e1e1566c7726877e
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=8b3a2e23253b50098164
>>> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
>>>
>>> Unfortunately, I don't have any reproducer for this issue yet.
>>>
>>> Downloadable assets:
>>> disk image: https://storage.googleapis.com/syzbot-assets/102656909b6f/disk-b6add54b.raw.xz
>>> vmlinux: https://storage.googleapis.com/syzbot-assets/fa30d1d80a47/vmlinux-b6add54b.xz
>>> kernel image: https://storage.googleapis.com/syzbot-assets/c25ee8abf30a/bzImage-b6add54b.xz
>>>
>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>> Reported-by: syzbot+8b3a2e23253b50098164@syzkaller.appspotmail.com
>>>
>>> ------------[ cut here ]------------
>>> WARNING: CPU: 1 PID: 1186 at kernel/time/hrtimer.c:1052 hrtimer_forward+0x1d6/0x2b0 kernel/time/hrtimer.c:1052
>>> Modules linked in:
>>> CPU: 1 UID: 0 PID: 1186 Comm: irq/33-virtio1- Not tainted syzkaller #0 PREEMPT_{RT,(full)}
>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
>>> RIP: 0010:hrtimer_forward+0x1d6/0x2b0 kernel/time/hrtimer.c:1052
>>
>> It compains that the timer is enqueued when it is attempted to be forwarded
>>
>>> Code: 4c 89 33 48 8b 04 24 eb 07 e8 86 34 12 00 31 c0 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f 5d e9 01 d8 4d 09 cc e8 6b 34 12 00 90 <0f> 0b 90 eb df 48 89 e8 4c 09 f8 48 c1 e8 20 74 0a 48 89 e8 31 d2
>>> RSP: 0018:ffffc90000a78bd0 EFLAGS: 00010006
>>> RAX: ffffffff81ac27e5 RBX: ffff8880b883b508 RCX: ffff888026c19dc0
>>> RDX: 0000000000000100 RSI: 0000000000010000 RDI: 0000000000010100
>>> RBP: 000000000009d057 R08: 0000000000010000 R09: 0000000000010100
>>> R10: dffffc0000000000 R11: ffffffff8167a890 R12: ffff8880b883b520
>>> R13: 0000000000184487 R14: 1ffff110171076a4 R15: 0000000000000001
>>> FS:  0000000000000000(0000) GS:ffff8881269c2000(0000) knlGS:0000000000000000
>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> CR2: 00007f95323cbf98 CR3: 0000000064088000 CR4: 00000000003526f0
>>> Call Trace:
>>>   <IRQ>
>>>   hrtimer_forward_now include/linux/hrtimer.h:366 [inline]
>>>   dl_server_timer kernel/sched/deadline.c:1193 [inline]
>>
>> which is strange as this is with the timer callback itself, so it
>> shouldn't be enqueued, unless there is a possiblilty to have:
>>
>>     CPU0                       CPU1
>>                                  
>>     timer_expires()
>>        callback()              ????
>>          dl_task_timer()       rq_lock()
>>            rq_lock()             hrtimer_start()
>>                                rq_unlock()
>>             hrtimer_forward()
>>
>> No idea whether that's possible, but that's the only sensible
>> explanation.
> 
> So, a dl_server_start() could be your ????, but it should see
> dl_server_active and just return if the dl_server callback is running.
> Unless a dl_server_stop() somehow interleaved as well and cleared it.
> 

isn't dl_server timer per CPU?

> If we had a reproducer maybe some tracing would help reducing the
> guessing. :)
> 
> Thanks,
> Juri
> 



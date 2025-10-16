Return-Path: <linux-kernel+bounces-856318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33747BE3D93
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14CA01888A1A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5019032549D;
	Thu, 16 Oct 2025 14:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EWd50xqg"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842B2186284
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 14:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760623438; cv=none; b=jIPcHjAYyY1rXvovJfykjGNG8IcHHyVwiEEhK48iZgpzfoKWtvqDrZep2a0CyAuzDclf87CDuDQI/ETZ5STDIl6hmcYm+05reyFY17bPr/uuO+yok3BzPBwzDRbB3chSczmX4E4NsSNvxQzi11rx05Dtq6DadMY7u2Wy9gblXik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760623438; c=relaxed/simple;
	bh=KZjsWnEYEOAl+agBYB78szLswYawJffLN0Gmh63aAv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V8Nil3VLHiCfDRawm5KORaiE3NAKXzzUiJQ6CiuLYCGEGdX3LZKpdK1R6cbPnsz+qwFQV1eD2bp7cywSMre88nmLbmZW8oATs20otZQ+nJwKsN3r2xwL+9Po7f4TxAeYN27jFRfwGDUbUyPLrjCB33cs4qhx/2UwsmyPN1S9A9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EWd50xqg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GBvnb9021678;
	Thu, 16 Oct 2025 14:03:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Eh8gQK
	4R4RAhHzIAP9aJ7yYzh9OOXVvbpIYHMuUPXQs=; b=EWd50xqgZELNftK3cLmCdo
	snMy2klCPcI9nLe1p0y21p7dLzws+Sl4UqcpEOVIKab8DuWZjY7ZPyuqw5W8JG57
	zxl8tjIiqVMrV2zTDK2gcpLKnJFymB4HVU0d9V0b7R+wrAWTqtDWr83h/YFlCq9o
	osBB2XR0+7GNbX4Gc3ymLRvnubO5vkd5nTCfL2q6yoDdCEy7ETMGJRHENbm/h3A/
	v2fA9dqp7JgOhgQJ77+s1qRRuS7Jk97uVzBxVz2ws10k6lzyusP8VKFwFSiDmqk8
	PWbzDEcXrT9vwTls0nmMAL1dzf+rf9KUq/aozBMVhqOkrFT32gSqztwIWPKj5oaw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qey935sb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 14:03:40 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59GAeAFd028071;
	Thu, 16 Oct 2025 14:03:39 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49tdg9d8cs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 14:03:39 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59GE3cGb33751766
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 14:03:38 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E3F2320040;
	Thu, 16 Oct 2025 14:03:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E6DA20043;
	Thu, 16 Oct 2025 14:03:35 +0000 (GMT)
Received: from [9.124.218.38] (unknown [9.124.218.38])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Oct 2025 14:03:35 +0000 (GMT)
Message-ID: <a5d5ce5e-9f98-4c0d-a4ed-5e4a8a6f7b86@linux.ibm.com>
Date: Thu, 16 Oct 2025 19:33:34 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] sched/fair: Skip sched_balance_running cmpxchg
 when balance is not due
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
        Chen Yu <yu.c.chen@intel.com>, Doug Nelson <doug.nelson@intel.com>,
        Mohini Narkhede <mohini.narkhede@intel.com>,
        linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        K Prateek Nayak <kprateek.nayak@amd.com>
References: <e27d5dcb724fe46acc24ff44670bc4bb5be21d98.1759445926.git.tim.c.chen@linux.intel.com>
 <20251013142638.GM3245006@noisy.programming.kicks-ass.net>
 <aa3d20e6d451e0d0b812fe16e9d403c1033feeaa.camel@linux.intel.com>
 <20251014092436.GK4067720@noisy.programming.kicks-ass.net>
 <e84de5a9-b498-4152-846a-c72e1ac66109@linux.ibm.com>
 <20251014094259.GR3245006@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20251014094259.GR3245006@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: csqyA0IuaU9VYjdB-LNFBAcoEBqYnEgw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxMSBTYWx0ZWRfX4jDbUEUWl3PN
 dgyCdk//WRIzA0QtAiU6ufyteiX8mSuHd4KwNDxAeDBqpIHEFRQrxsczJCXiYfFXlhntOAqoMPR
 rT91R/6xk6bCk/LKRRZYrUdHqygOutuB4aZCIHXYBK68QQzBkIIS1L5minOG0NaWaCVJkeS21yZ
 uT30M3S42JKtzdF3LxOqF4CQ85iNokZSflX+OxlQDXUPGrcjPcRnfHZMhYOTmWKdQeZgVHv5fC6
 ixSpRdhI9s6JZszeJa44BQz8gWAmYEm5Ojorh9agrStbXNst8E5nPFDsSUIE5KlfpRxtTKSUpbs
 Ja7z4DFBlCyiHL+FKxUQNzoYL0t+gyGbAL1p/kK4Of/SlriIcqWEstQac+ntVUCQKWhN/27Uyeb
 DP0JPv2aCPm/mjKBuhAjfLN/KkNkaw==
X-Proofpoint-GUID: csqyA0IuaU9VYjdB-LNFBAcoEBqYnEgw
X-Authority-Analysis: v=2.4 cv=QZ5rf8bv c=1 sm=1 tr=0 ts=68f0fb3c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=qg2igyfmw54eOdSo5VcA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 malwarescore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110011



On 10/14/25 3:12 PM, Peter Zijlstra wrote:
> On Tue, Oct 14, 2025 at 03:03:41PM +0530, Shrikanth Hegde wrote:
> 
>>> @@ -11758,6 +11775,12 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
>>>    		goto out_balanced;
>>>    	}
>>> +	if (idle != CPU_NEWLY_IDLE && (sd->flags & SD_SERIALIZE)) {
>>> +		if (atomic_cmpxchg_acquire(&sched_balance_running, 0, 1))
>>> +			goto out_balanced;
>>
>> Maybe goto out instead of out_balanced ?
> 
> That would be inconsistent with the !should_we_balance() goto
> out_balanced right above this, no?
> 
Hi Peter.

Did similar probe points numbers compared to this. Even the patch is quite similar to what
was suggested there a while ago.
https://lore.kernel.org/all/41e11090-a100-48a7-a0dd-c989772822d7@linux.ibm.com/

480 CPUs system with 6 NUMA nodes. (different system than last time)

tl;dr

- Number of time sched_balance_running is taken is way less after the swb check. (which is great)
- Number of time it fails to set is very low after swb. (So out_balanced vs out may not make a
significant difference.)
- Patch is at the end. It is this patch + redo stuff + (ref_variable_stuff(ignore))


--- detailed log----

++++++++++++ probe points +++++++++++++++
(added a ref("crap") so i could put a probe where i want )

       0  static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
...
      20                 max_cost += sd->max_newidle_lb_cost;
          
                         /*
                          * Stop the load balance at this level. There is another
                          * CPU in our sched group which is doing load balancing more
                          * actively.
                          */
                         if (!continue_balancing) {
                                 if (need_decay)
                                         continue;
                                 break;
                         }
      33                 if (sd->flags & SD_SERIALIZE)
      34                         ref = ref + 5;



<sched_balance_rq@/home/shrikanth/sched_tip/kernel/sched/fair.c:0>
       0  static int sched_balance_rq(int this_cpu, struct rq *this_rq,
                                 struct sched_domain *sd, enum cpu_idle_type idle,
                                 int *continue_balancing)
...
                 int need_unlock = false;
          
                 cpumask_and(cpus, sched_domain_span(sd), cpu_active_mask);
          
      25         schedstat_inc(sd->lb_count[idle]);
...
      34         if (idle != CPU_NEWLY_IDLE && (sd->flags & SD_SERIALIZE)) {
      35                 if (atomic_cmpxchg_acquire(&sched_balance_running, 0, 1)) {
      36                         ref = ref+1;
      37                         goto out_balanced;
                         }
      39                 ref = ref + 2;
      40                 need_unlock = true;
...
                                         env.loop_break = SCHED_NR_MIGRATE_BREAK;
     167                                 if (need_unlock) {
     168                                         ref = ref+3;
     169                                         atomic_set_release(&sched_balance_running, 0);
                                         }
                                         goto redo;
...
          out:
     287         if (need_unlock) {
     288                 ref = ref +4;
     289                 atomic_set_release(&sched_balance_running, 0);
                 }
          
                 return ld_moved;

   probe:sched_balance_domains_L34 (on sched_balance_domains:34@kernel/sched/fair.c)
   probe:sched_balance_rq_L168 (on sched_balance_rq:168@kernel/sched/fair.c)
   probe:sched_balance_rq_L21 (on sched_balance_rq+312@kernel/sched/fair.c)
   probe:sched_balance_rq_L288 (on sched_balance_rq+312@kernel/sched/fair.c)
   probe:sched_balance_rq_L35 (on sched_balance_rq+312@kernel/sched/fair.c)
   probe:sched_balance_rq_L36 (on sched_balance_rq+312@kernel/sched/fair.c)
   probe:sched_balance_rq_L39 (on sched_balance_rq+312@kernel/sched/fair.c)

+++++++++++ Data on various load points ++++++++++++++++++++++++
--- idle ---
perf stat -a -e probe:* sleep 10

              6,123      probe:sched_balance_domains_L34
             10,378      probe:sched_balance_rq_L21
                 79      probe:sched_balance_rq_L35
                 17      probe:sched_balance_rq_L36
                 62      probe:sched_balance_rq_L39
                  0      probe:sched_balance_rq_L168
                 62      probe:sched_balance_rq_L288

--- 25% load ---
perf stat -a -e probe:* stress-ng --cpu=480 -l 25 -t 10

            510,551      probe:sched_balance_domains_L34
            303,892      probe:sched_balance_rq_L21
                442      probe:sched_balance_rq_L35
                  3      probe:sched_balance_rq_L36
                439      probe:sched_balance_rq_L39
                  0      probe:sched_balance_rq_L168
                439      probe:sched_balance_rq_L288

--- 50% load ---

            248,969      probe:sched_balance_domains_L34
            187,864      probe:sched_balance_rq_L21
                926      probe:sched_balance_rq_L35
                  6      probe:sched_balance_rq_L36
                920      probe:sched_balance_rq_L39
                  0      probe:sched_balance_rq_L168
                920      probe:sched_balance_rq_L288

--- 75% load ---

            110,294      probe:sched_balance_domains_L34
             71,568      probe:sched_balance_rq_L21
                861      probe:sched_balance_rq_L35
                  6      probe:sched_balance_rq_L36
                855      probe:sched_balance_rq_L39
                  0      probe:sched_balance_rq_L168
                855      probe:sched_balance_rq_L288

--- 100% load ---

             85,960      probe:sched_balance_domains_L34
             48,169      probe:sched_balance_rq_L21
                 71      probe:sched_balance_rq_L35
                  4      probe:sched_balance_rq_L36
                 67      probe:sched_balance_rq_L39
                  0      probe:sched_balance_rq_L168
                 67      probe:sched_balance_rq_L288

++++++++++++++++++ patch ++++++++++++++++++++++++++++++++++++
(ignore ref crap)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cee1793e8277..832104705500 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11722,10 +11722,29 @@ static void update_lb_imbalance_stat(struct lb_env *env, struct sched_domain *sd
  	}
  }
  
+
+/*
+ * This flag serializes load-balancing passes over large domains
+ * (above the NODE topology level) - only one load-balancing instance
+ * may run at a time, to reduce overhead on very large systems with
+ * lots of CPUs and large NUMA distances.
+ *
+ * - Note that load-balancing passes triggered while another one
+ *   is executing are skipped and not re-tried.
+ *
+ * - Also note that this does not serialize rebalance_domains()
+ *   execution, as non-SD_SERIALIZE domains will still be
+ *   load-balanced in parallel.
+ */
+static atomic_t sched_balance_running = ATOMIC_INIT(0);
+
  /*
   * Check this_cpu to ensure it is balanced within domain. Attempt to move
   * tasks if there is an imbalance.
   */
+
+int ref = 0;
+
  static int sched_balance_rq(int this_cpu, struct rq *this_rq,
  			struct sched_domain *sd, enum cpu_idle_type idle,
  			int *continue_balancing)
@@ -11747,10 +11766,12 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
  		.fbq_type	= all,
  		.tasks		= LIST_HEAD_INIT(env.tasks),
  	};
+	int need_unlock = false;
  
  	cpumask_and(cpus, sched_domain_span(sd), cpu_active_mask);
  
  	schedstat_inc(sd->lb_count[idle]);
+	ref = 1;
  
  redo:
  	if (!should_we_balance(&env)) {
@@ -11758,6 +11779,15 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
  		goto out_balanced;
  	}
  
+	if (idle != CPU_NEWLY_IDLE && (sd->flags & SD_SERIALIZE)) {
+		if (atomic_cmpxchg_acquire(&sched_balance_running, 0, 1)) {
+			ref = ref+1;
+			goto out_balanced;
+		}
+		ref = ref + 2;
+		need_unlock = true;
+	}
+
  	group = sched_balance_find_src_group(&env);
  	if (!group) {
  		schedstat_inc(sd->lb_nobusyg[idle]);
@@ -11882,6 +11912,10 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
  			if (!cpumask_subset(cpus, env.dst_grpmask)) {
  				env.loop = 0;
  				env.loop_break = SCHED_NR_MIGRATE_BREAK;
+				if (need_unlock) {
+					ref = ref+3;
+					atomic_set_release(&sched_balance_running, 0);
+				}
  				goto redo;
  			}
  			goto out_all_pinned;
@@ -11998,6 +12032,11 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
  	    sd->balance_interval < sd->max_interval)
  		sd->balance_interval *= 2;
  out:
+	if (need_unlock) {
+		ref = ref +4;
+		atomic_set_release(&sched_balance_running, 0);
+	}
+
  	return ld_moved;
  }
  
@@ -12122,21 +12161,6 @@ static int active_load_balance_cpu_stop(void *data)
  	return 0;
  }
  
-/*
- * This flag serializes load-balancing passes over large domains
- * (above the NODE topology level) - only one load-balancing instance
- * may run at a time, to reduce overhead on very large systems with
- * lots of CPUs and large NUMA distances.
- *
- * - Note that load-balancing passes triggered while another one
- *   is executing are skipped and not re-tried.
- *
- * - Also note that this does not serialize rebalance_domains()
- *   execution, as non-SD_SERIALIZE domains will still be
- *   load-balanced in parallel.
- */
-static atomic_t sched_balance_running = ATOMIC_INIT(0);
-
  /*
   * Scale the max sched_balance_rq interval with the number of CPUs in the system.
   * This trades load-balance latency on larger machines for less cross talk.
@@ -12192,7 +12216,7 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
  	/* Earliest time when we have to do rebalance again */
  	unsigned long next_balance = jiffies + 60*HZ;
  	int update_next_balance = 0;
-	int need_serialize, need_decay = 0;
+	int need_decay = 0;
  	u64 max_cost = 0;
  
  	rcu_read_lock();
@@ -12215,14 +12239,10 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
  			break;
  		}
  
-		interval = get_sd_balance_interval(sd, busy);
-
-		need_serialize = sd->flags & SD_SERIALIZE;
-		if (need_serialize) {
-			if (atomic_cmpxchg_acquire(&sched_balance_running, 0, 1))
-				goto out;
-		}
+		if (sd->flags & SD_SERIALIZE)
+			ref = ref + 5;
  
+		interval = get_sd_balance_interval(sd, busy);
  		if (time_after_eq(jiffies, sd->last_balance + interval)) {
  			if (sched_balance_rq(cpu, rq, sd, idle, &continue_balancing)) {
  				/*
@@ -12236,9 +12256,7 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
  			sd->last_balance = jiffies;
  			interval = get_sd_balance_interval(sd, busy);
  		}
-		if (need_serialize)
-			atomic_set_release(&sched_balance_running, 0);
-out:
+
  		if (time_after(next_balance, sd->last_balance + interval)) {
  			next_balance = sd->last_balance + interval;
  			update_next_balance = 1;



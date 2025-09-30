Return-Path: <linux-kernel+bounces-837996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A75BAE317
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 19:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2A0616EE81
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5051230DED0;
	Tue, 30 Sep 2025 17:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FC1GxJsD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC7F25A323
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 17:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759253442; cv=none; b=GuQo1o24u692F00boHM8yWTLBiJ2EG85S6bew9zNvi36QiEPBwYorfbDcRKK3tZyOxvPFcDxxFPiooxaDELJcxUc+Zpiy1RyJ7pkde5En6sU6y6+8Aqup/aC/9v93/JC2Hm9fMzyDB1ohcF2ngpWOoME3skd3+vCN5aVkpmHDwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759253442; c=relaxed/simple;
	bh=/u4nGAIRhuo73VWseUmoYKCZ4wwGCuvWLfJxiqmxqlI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L4OzFYajlHZScKJLMkZTXtjkdtr//LnUYWAPoUtxjEQoQ+AjrKbfAdvRFxpXf9NVOczOU85iNVbduu1VtiZz6k8VJ5k3g/FiwV+mB+D2sClcrunbLfoPRZvm0B7pubqpG2P61OMpjX5V3+jbFIYpGsfG9Pw6EQ1vE5AvatRFZVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FC1GxJsD; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759253440; x=1790789440;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=/u4nGAIRhuo73VWseUmoYKCZ4wwGCuvWLfJxiqmxqlI=;
  b=FC1GxJsD2vzWEgI10hh7gxpLxhmLKaRZSZw6WiktWHxp33Ocmeg6dJ3q
   QuE1UDDA72zB48XkzP7TM5zlkwnajNCGTOfnP8bXZmenmFztMWqaAOLa3
   R9VssJLjfzxxr3qy1I9IwmsUvzjYLMmNx17xeUDDBAbTpcIMxz3MbP9nP
   GTRjMpPrWxBwl1XhwVUaI2MGbMRgXT/3XhfrGxrlaj6pCf7NODCH6JNX0
   /pVfW8UOB0eXZv2rAWUVxVSpkRefYACGBIzhygicVnWPpBTeefhiKwrew
   eizLirx4HkYFK41V9dgo71yjhr9ge+aybr/92aRKKo3A73dzdiffQoP15
   w==;
X-CSE-ConnectionGUID: 3eFo3j/8S0+xgcn5EjsI6w==
X-CSE-MsgGUID: 8HwK64zQQIKfC+8/+88NhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61437551"
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="61437551"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 10:30:40 -0700
X-CSE-ConnectionGUID: 4CMu1NfzTxifx9z5FNFlZA==
X-CSE-MsgGUID: 3glwvT+nSSKeKn/PfMq9Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="179334345"
Received: from schen9-mobl4.amr.corp.intel.com (HELO [10.125.109.158]) ([10.125.109.158])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 10:30:38 -0700
Message-ID: <6446b46bb8750deb28687b3e84d9b6062a35c86a.camel@linux.intel.com>
Subject: Re: [PATCH v4 1/2] sched: Create architecture specific sched domain
 distances
From: Tim Chen <tim.c.chen@linux.intel.com>
To: "Chen, Yu C" <yu.c.chen@intel.com>, Peter Zijlstra
 <peterz@infradead.org>,  Ingo Molnar <mingo@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann	
 <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman	
 <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Tim Chen	
 <tim.c.chen@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Len
 Brown	 <len.brown@intel.com>, linux-kernel@vger.kernel.org, K Prateek Nayak
	 <kprateek.nayak@amd.com>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Vinicius Costa Gomes
 <vinicius.gomes@intel.com>, Arjan Van De Ven	 <arjan.van.de.ven@intel.com>
Date: Tue, 30 Sep 2025 10:30:36 -0700
In-Reply-To: <79db86a1-dc75-42ca-9cff-927539dc2104@intel.com>
References: <cover.1758234869.git.tim.c.chen@linux.intel.com>
	 <990005f249897c6ef2e7d998c68836eba604f346.1758234869.git.tim.c.chen@linux.intel.com>
	 <6a650359-d106-453a-a5a3-24b3750a05d2@intel.com>
	 <861e15234270eb3678390da2b0ddf3a7162d98dd.camel@linux.intel.com>
	 <79db86a1-dc75-42ca-9cff-927539dc2104@intel.com>
Autocrypt: addr=tim.c.chen@linux.intel.com; prefer-encrypt=mutual;
 keydata=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
 uQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-09-30 at 10:28 +0800, Chen, Yu C wrote:
> On 9/30/2025 6:18 AM, Tim Chen wrote:
> > On Sat, 2025-09-27 at 20:34 +0800, Chen, Yu C wrote:
> > >=20

[snip]

> > >=20
> > > If our goal is to figure out whether the arch_sched_node_distance()
> > > has been overridden, how about the following alias?
> > >=20
> > > int __weak arch_sched_node_distance(int from, int to)
> > > {
> > > 	return __node_distance(from, to);
> > > }
> > > int arch_sched_node_distance_original(int from, int to) __weak
> > > __alias(arch_sched_node_distance);
> > >=20
> > > static bool arch_sched_node_distance_is_overridden(void)
> > > {
> > > 	return arch_sched_node_distance !=3D arch_sched_node_distance_origin=
al;
> > > }
> > >=20
> > > so arch_sched_node_distance_is_overridden() can replace
> > > modified_sched_node_distance()
> > >=20
> >=20
> > I think that the alias version will still point to the replaced functio=
n and not
> > the originally defined one.
> >=20
> > How about not using __weak and just explicitly define arch_sched_node_d=
istance
> > as a function pointer.  Change the code like below.
> >=20
>=20
> The arch_sched_node_distance_original is defined as __weak, so it
> should point to the old function even if the function has been
> overridden. I did a test on a X86 VM and it seems to be so.
> But using the arch_sched_node_distance as a function point
> should also be OK.
>=20

How about changing the code as follow. I think this change is cleaner.
I tested it in my VM and works for detecting sched distance substitution.
Thanks.

Tim

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index f25e4402c63e..3dc941258df3 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1897,31 +1897,17 @@ static void init_numa_topology_type(int offline_nod=
e)
  * A NUMA level is created for each unique
  * arch_sched_node_distance.
  */
-static bool __modified_sched_node_dist =3D true;
-
-int __weak arch_sched_node_distance(int from, int to)
+static int numa_node_dist(int i, int j)
 {
-	if (__modified_sched_node_dist)
-		__modified_sched_node_dist =3D false;
-
-	return node_distance(from, to);
+	return node_distance(i, j);
 }
=20
-static bool modified_sched_node_distance(void)
-{
-	/*
-	 * Call arch_sched_node_distance()
-	 * to determine if arch_sched_node_distance
-	 * has been modified from node_distance()
-	 * to arch specific distance.
-	 */
-	arch_sched_node_distance(0, 0);
-	return __modified_sched_node_dist;
-}
+int arch_sched_node_distance(int from, int to)
+			     __weak __alias(numa_node_dist);
=20
-static int numa_node_dist(int i, int j)
+static bool modified_sched_node_distance(void)
 {
-	return node_distance(i, j);
+	return numa_node_dist !=3D arch_sched_node_distance;
 }
=20
 static int sched_record_numa_dist(int offline_node, int (*n_dist)(int, int=
),



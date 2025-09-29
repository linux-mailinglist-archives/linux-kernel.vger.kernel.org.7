Return-Path: <linux-kernel+bounces-836832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8390CBAAAE9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 00:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5120B4E03FD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 22:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EEC1F09B3;
	Mon, 29 Sep 2025 22:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MZoJQtTp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187A41A0BD0
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 22:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759184338; cv=none; b=jkvRYl6yBgBfD3sYvBb21SQhrVjxjGo7iULWdK0Ozkj3jvvT0m23YHgF9axdPyc42E0UpDA06tqOzsqwWtnK+5lOFc2SnndozEXWQXYBGoooHJRsegEVtppPfI/BESq9eJ/N53r5Ad3VSKPDR78zdpXIUd/PG9X8h1BqifDFPCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759184338; c=relaxed/simple;
	bh=iHVYI+/8c7IXICytv4mugY+MtBgocOugShoiS2RJt3c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LFWFa7NtmEWbV2o1k7aEiiWI8MyZgz87NpO8J8tcup2psi7DqHdJ9h6cAvma9emZpMg5WDNVDU6qxEa8/A4YLrN57MbVhQO7IJgk76i6fzzPupCUHvbjxW7YV2LU5YBjwLOrrSesDO+Ip3T3v9E588rXKEbLUMNp5bG78YLIgHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MZoJQtTp; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759184336; x=1790720336;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=iHVYI+/8c7IXICytv4mugY+MtBgocOugShoiS2RJt3c=;
  b=MZoJQtTpCSiSMap8jBIdG8JSrPChDveYecZjQLp30tvDRLL6AyBg5uc6
   8Qf2Dgzpzd85WmQ1LfqP+4nijYiVk6NL0FDnRHhMrivfzi6XXSZvoXETV
   gmXA8hwoAiC8q8XWtbI5JfWCdlnw1yaHE8Yhbyp+FwLUbqkEWb80xKzEP
   x/DzXgI8zgmcJOCODBERzcL0/gGT2/POsRby2OoT7QPkDX5z6QhzOOB/a
   Ja7Ev0r+3RyzRC7sK0Gk7iya+oUPaFSHL3biMbYVj0ZLZHhrcehfGi8tI
   grmdHoivAVbPStpM24gtJFJLuOBo6fn8xSfoy8JvsNayOEA6j4FrEIEnh
   A==;
X-CSE-ConnectionGUID: Oy5FChm8SCusVomg9ZEANA==
X-CSE-MsgGUID: hVDDCCF4QDe+pCZXo5+T1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="64058186"
X-IronPort-AV: E=Sophos;i="6.18,302,1751266800"; 
   d="scan'208";a="64058186"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 15:18:55 -0700
X-CSE-ConnectionGUID: KueKGqq3QcWUF6qeqsI2gw==
X-CSE-MsgGUID: df9VEnNwTYy1lUanYc+Hsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,302,1751266800"; 
   d="scan'208";a="182630796"
Received: from schen9-mobl4.amr.corp.intel.com (HELO [10.125.109.121]) ([10.125.109.121])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 15:18:54 -0700
Message-ID: <861e15234270eb3678390da2b0ddf3a7162d98dd.camel@linux.intel.com>
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
Date: Mon, 29 Sep 2025 15:18:53 -0700
In-Reply-To: <6a650359-d106-453a-a5a3-24b3750a05d2@intel.com>
References: <cover.1758234869.git.tim.c.chen@linux.intel.com>
	 <990005f249897c6ef2e7d998c68836eba604f346.1758234869.git.tim.c.chen@linux.intel.com>
	 <6a650359-d106-453a-a5a3-24b3750a05d2@intel.com>
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

On Sat, 2025-09-27 at 20:34 +0800, Chen, Yu C wrote:
> [snip]
>=20
> > @@ -1591,10 +1591,12 @@ static void claim_allocations(int cpu, struct s=
ched_domain *sd)
> >   enum numa_topology_type sched_numa_topology_type;
> >  =20
> >   static int			sched_domains_numa_levels;
> > +static int			sched_numa_node_levels;
>=20
> I agree that the benefit of maintaining two NUMA distances - one for the
> sched_domain and another for the NUMA balancing/page allocation policy - =
is
> to avoid complicating the sched_domain hierarchy while preserving the
> advantages of NUMA locality.
>=20
> Meanwhile, I wonder if we could also add a "orig" prefix to the original
> NUMA distance. This way, we can quickly understand its meaning later.
> For example,
> sched_orig_node_levels
> sched_orig_node_distance

I am not sure adding orig will make the meaning any clearer.
I can add comments to note that

sched_numa_node_distance mean the node distance between numa nodes
sched_numa_nodel_levels  mean the number of unique distances between numa n=
odes

>=20
> >   static int			sched_domains_curr_level;
> >  =20
> >   int				sched_max_numa_distance;
> >   static int			*sched_domains_numa_distance;
> > +static int			*sched_numa_node_distance;
> >   static struct cpumask		***sched_domains_numa_masks;
> >   #endif /* CONFIG_NUMA */
> >  =20
> > @@ -1808,10 +1810,10 @@ bool find_numa_distance(int distance)
> >   		return true;
> >  =20
> >   	rcu_read_lock();
> > -	distances =3D rcu_dereference(sched_domains_numa_distance);
> > +	distances =3D rcu_dereference(sched_numa_node_distance);
> >   	if (!distances)
> >   		goto unlock;
> > -	for (i =3D 0; i < sched_domains_numa_levels; i++) {
> > +	for (i =3D 0; i < sched_numa_node_levels; i++) {
> >   		if (distances[i] =3D=3D distance) {
> >   			found =3D true;
> >   			break;
> > @@ -1887,14 +1889,48 @@ static void init_numa_topology_type(int offline=
_node)
> >  =20
> >   #define NR_DISTANCE_VALUES (1 << DISTANCE_BITS)
> >  =20
> > -void sched_init_numa(int offline_node)
> > +/*
> > + * An architecture could modify its NUMA distance, to change
> > + * grouping of NUMA nodes and number of NUMA levels when creating
> > + * NUMA level sched domains.
> > + *
> > + * A NUMA level is created for each unique
> > + * arch_sched_node_distance.
> > + */
> > +static bool __modified_sched_node_dist =3D true;
> > +
> > +int __weak arch_sched_node_distance(int from, int to)
> >   {
> > -	struct sched_domain_topology_level *tl;
> > -	unsigned long *distance_map;
> > +	if (__modified_sched_node_dist)
> > +		__modified_sched_node_dist =3D false;
> > +
> > +	return node_distance(from, to);
> > +}
> > +
> > +static bool modified_sched_node_distance(void)
> > +{
> > +	/*
> > +	 * Call arch_sched_node_distance()
> > +	 * to determine if arch_sched_node_distance
> > +	 * has been modified from node_distance()
> > +	 * to arch specific distance.
> > +	 */
> > +	arch_sched_node_distance(0, 0);
> > +	return __modified_sched_node_dist;
> > +}
> > +
>=20
> If our goal is to figure out whether the arch_sched_node_distance()
> has been overridden, how about the following alias?
>=20
> int __weak arch_sched_node_distance(int from, int to)
> {
> 	return __node_distance(from, to);
> }
> int arch_sched_node_distance_original(int from, int to) __weak=20
> __alias(arch_sched_node_distance);
>=20
> static bool arch_sched_node_distance_is_overridden(void)
> {
> 	return arch_sched_node_distance !=3D arch_sched_node_distance_original;
> }
>=20
> so arch_sched_node_distance_is_overridden() can replace=20
> modified_sched_node_distance()
>=20

I think that the alias version will still point to the replaced function an=
d not
the originally defined one.

How about not using __weak and just explicitly define arch_sched_node_dista=
nce
as a function pointer.  Change the code like below.

Tim

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index d6b772990ec2..12db78af09d5 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -545,7 +545,7 @@ static int avg_remote_numa_distance(void)
 	return sched_avg_remote_distance;
 }
=20
-int arch_sched_node_distance(int from, int to)
+static int x86_arch_sched_node_distance(int from, int to)
 {
 	int d =3D node_distance(from, to);
=20
@@ -918,6 +918,9 @@ static int do_boot_cpu(u32 apicid, unsigned int cpu, st=
ruct task_struct *idle)
 	/* If 64-bit wakeup method exists, use the 64-bit mode trampoline IP */
 	if (apic->wakeup_secondary_cpu_64)
 		start_ip =3D real_mode_header->trampoline_start64;
+#endif
+#ifdef CONFIG_NUMA
+	arch_sched_node_distance =3D x86_arch_sched_node_distance;
 #endif
 	idle->thread.sp =3D (unsigned long)task_pt_regs(idle);
 	initial_code =3D (unsigned long)start_secondary;
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.=
h
index 2d2d29553df8..3549c4a19816 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -56,7 +56,7 @@ static inline int cpu_numa_flags(void)
 {
 	return SD_NUMA;
 }
-extern int arch_sched_node_distance(int from, int to);
+extern int (*arch_sched_node_distance)(int, int);
 #endif
=20
 extern int arch_asym_cpu_priority(int cpu);
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index f25e4402c63e..7cfb7422e9d4 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1897,26 +1897,17 @@ static void init_numa_topology_type(int offline_nod=
e)
  * A NUMA level is created for each unique
  * arch_sched_node_distance.
  */
-static bool __modified_sched_node_dist =3D true;
=20
-int __weak arch_sched_node_distance(int from, int to)
+static int default_sched_node_distance(int from, int to)
 {
-	if (__modified_sched_node_dist)
-		__modified_sched_node_dist =3D false;
-
 	return node_distance(from, to);
 }
=20
+int (*arch_sched_node_distance)(int, int) =3D default_sched_node_distance;
+
 static bool modified_sched_node_distance(void)
 {
-	/*
-	 * Call arch_sched_node_distance()
-	 * to determine if arch_sched_node_distance
-	 * has been modified from node_distance()
-	 * to arch specific distance.
-	 */
-	arch_sched_node_distance(0, 0);
-	return __modified_sched_node_dist;
+	return arch_sched_node_distance !=3D default_sched_node_distance;
 }
=20
 static int numa_node_dist(int i, int j)


Return-Path: <linux-kernel+bounces-784377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A700B33AA6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 11:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E5A61B24F51
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 09:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A51E2D0C61;
	Mon, 25 Aug 2025 09:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QooX/RVf"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86042D0283
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 09:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756113571; cv=none; b=NcoFHSur4G/faH6C/lUsvi482QrRDNyJ4/UZn2mGLBIxH4A35H5qNLIHDGXIhOyxekLQShw/7ZFk7gRGeWdOFYHPQs7GSBfN5sfHdiyAql9wZJ9p9d/gtgaUhoGqL+lXQ6L3xipecKBF3Pm9IyhSDQx+QJ26k6Iv83HIBIm/uT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756113571; c=relaxed/simple;
	bh=BCh3a1LYH/L3ukZqVaz/FrQzn2XaunZHhpyxccHEgBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ba3SEI9VEY4W5Rqo/E+TqY234OMDBPunWgkCsVWo3UiViuHhxp2kB87vn97lv5ZVoBQw4JtwdPrBwuR8S+0xJdp9zftP+qBa1S9b0y3fHFU0t4RwBmGA1y93TUAGe3ylIBvZq+91LjYYBS1ncDWxL2GJ9zZnstKO6MWtmiqydO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QooX/RVf; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pyrFCvwcSaxjJk7BMZ9LHdVlPAfwAO6mOIZubKBteKQ=; b=QooX/RVfUeUI+1boN92W3b8RBl
	tHAN0DwzUXXdRZ6KNvB5wohWovhsPGErMwPVU6FoiETk2kPf6SqF4Sd6w5k56viWVrdqM5gqX3Rmf
	E7BZQ2Y6K/q6iCzXxy/dIVJNphon99x7KQL5YY1E8rCfElF033IJnJDEKTf4zBKhuXS3se/E44svN
	Dg9/ffZuntJNV0xGsGjdAPeBebvGCuXiDxjeBs4ywDvFS+ReuAdZGU+mfrHK7kUW0HCbv8+muxXI9
	5ie9Jr1+SrfBti1OfPUoQ7dFIsQ9aO1N5mwkVfFXNfFP0tbxzZbUK1afVo8G8egFEwUZQScf/quAs
	WOAzrYHw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqTM7-00000009piI-0naB;
	Mon, 25 Aug 2025 09:19:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0670B3002ED; Mon, 25 Aug 2025 11:19:11 +0200 (CEST)
Date: Mon, 25 Aug 2025 11:19:10 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Leon Romanovsky <leon@kernel.org>, linux-kernel@vger.kernel.org,
	Steve Wahl <steve.wahl@hpe.com>, Borislav Petkov <bp@alien8.de>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	srikar@linux.vnet.ibm.com, hca@linux.ibm.com
Subject: Re: [PATCH v5] sched/fair: Use sched_domain_span() for
 topology_span_sane()
Message-ID: <20250825091910.GT3245006@noisy.programming.kicks-ass.net>
References: <20250715040824.893-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715040824.893-1-kprateek.nayak@amd.com>

On Tue, Jul 15, 2025 at 04:08:24AM +0000, K Prateek Nayak wrote:
> Leon noted a topology_span_sane() warning in their guest deployment
> starting from v6.16-rc1 [1]. Debug that followed pointed to the
> tl->mask() for the NODE domain being incorrectly resolved to that of the
> highest NUMA domain.
> 
> tl->mask() for NODE is set to the sd_numa_mask() which depends on the
> global "sched_domains_curr_level" hack. "sched_domains_curr_level" is
> set to the "tl->numa_level" during tl traversal in build_sched_domains()
> calling sd_init() but was not reset before topology_span_sane().
> 
> Since "tl->numa_level" still reflected the old value from
> build_sched_domains(), topology_span_sane() for the NODE domain trips
> when the span of the last NUMA domain overlaps.
> 
> Instead of replicating the "sched_domains_curr_level" hack, Valentin
> suggested using the spans from the sched_domain objects constructed
> during build_sched_domains() which can also catch overlaps when the
> domain spans are fixed up by build_sched_domain().
> 
> Since build_sched_domain() is skipped when tl->mask() of a child domain
> already covers the entire cpumap, skip the domains that have an empty
> span.

Right, much better explanation that that other patch.

And yes, we can do this. However, what's the point of having this
->mask() function if we can't use it and have to hack around it.

We should either set ->mask to NULL for NUMA thingies to make sure we
don't end up using it again, or bite the bullet and fix up the mask
function declaration.

Something a little like so?

---
 arch/powerpc/kernel/smp.c      | 19 +++++++++++------
 arch/s390/kernel/topology.c    | 15 ++++++++-----
 arch/x86/kernel/smpboot.c      | 28 ++++++++++++++++++++----
 include/linux/sched/topology.h |  4 +++-
 include/linux/topology.h       |  2 +-
 kernel/sched/topology.c        | 48 ++++++++++++++++++++++++++----------------
 6 files changed, 80 insertions(+), 36 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index f59e4b9cc207..0b5897fff687 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1028,13 +1028,13 @@ static int powerpc_shared_proc_flags(void)
  * We can't just pass cpu_l2_cache_mask() directly because
  * returns a non-const pointer and the compiler barfs on that.
  */
-static const struct cpumask *shared_cache_mask(int cpu)
+static const struct cpumask *shared_cache_mask(struct sched_domain_topology_level *tl, int cpu)
 {
 	return per_cpu(cpu_l2_cache_map, cpu);
 }
 
 #ifdef CONFIG_SCHED_SMT
-static const struct cpumask *smallcore_smt_mask(int cpu)
+static const struct cpumask *smallcore_smt_mask(struct sched_domain_topology_level *tl, int cpu)
 {
 	return cpu_smallcore_mask(cpu);
 }
@@ -1054,11 +1054,16 @@ static bool has_coregroup_support(void)
 	return coregroup_enabled;
 }
 
-static const struct cpumask *cpu_mc_mask(int cpu)
+static const struct cpumask *cpu_mc_mask(struct sched_domain_topology_level *tl, int cpu)
 {
 	return cpu_coregroup_mask(cpu);
 }
 
+static const struct cpumask *cpu_pkg_mask(struct sched_domain_topology_level *tl, int cpu)
+{
+	return cpu_node_mask(cpu);
+}
+
 static int __init init_big_cores(void)
 {
 	int cpu;
@@ -1448,7 +1453,7 @@ static bool update_mask_by_l2(int cpu, cpumask_var_t *mask)
 		return false;
 	}
 
-	cpumask_and(*mask, cpu_online_mask, cpu_cpu_mask(cpu));
+	cpumask_and(*mask, cpu_online_mask, cpu_node_mask(cpu));
 
 	/* Update l2-cache mask with all the CPUs that are part of submask */
 	or_cpumasks_related(cpu, cpu, submask_fn, cpu_l2_cache_mask);
@@ -1538,7 +1543,7 @@ static void update_coregroup_mask(int cpu, cpumask_var_t *mask)
 		return;
 	}
 
-	cpumask_and(*mask, cpu_online_mask, cpu_cpu_mask(cpu));
+	cpumask_and(*mask, cpu_online_mask, cpu_node_mask(cpu));
 
 	/* Update coregroup mask with all the CPUs that are part of submask */
 	or_cpumasks_related(cpu, cpu, submask_fn, cpu_coregroup_mask);
@@ -1601,7 +1606,7 @@ static void add_cpu_to_masks(int cpu)
 
 	/* If chip_id is -1; limit the cpu_core_mask to within PKG */
 	if (chip_id == -1)
-		cpumask_and(mask, mask, cpu_cpu_mask(cpu));
+		cpumask_and(mask, mask, cpu_node_mask(cpu));
 
 	for_each_cpu(i, mask) {
 		if (chip_id == cpu_to_chip_id(i)) {
@@ -1716,7 +1721,7 @@ static void __init build_sched_topology(void)
 			SDTL_INIT(cpu_mc_mask, powerpc_shared_proc_flags, MC);
 	}
 
-	powerpc_topology[i++] = SDTL_INIT(cpu_cpu_mask, powerpc_shared_proc_flags, PKG);
+	powerpc_topology[i++] = SDTL_INIT(cpu_pkg_mask, powerpc_shared_proc_flags, PKG);
 
 	/* There must be one trailing NULL entry left.  */
 	BUG_ON(i >= ARRAY_SIZE(powerpc_topology) - 1);
diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
index 46569b8e47dd..df036ab83920 100644
--- a/arch/s390/kernel/topology.c
+++ b/arch/s390/kernel/topology.c
@@ -509,33 +509,38 @@ int topology_cpu_init(struct cpu *cpu)
 	return rc;
 }
 
-static const struct cpumask *cpu_thread_mask(int cpu)
+static const struct cpumask *cpu_thread_mask(struct sched_domain_topology_level *tl, int cpu)
 {
 	return &cpu_topology[cpu].thread_mask;
 }
 
 
-const struct cpumask *cpu_coregroup_mask(int cpu)
+const struct cpumask *cpu_coregroup_mask(struct sched_domain_topology_level *tl, int cpu)
 {
 	return &cpu_topology[cpu].core_mask;
 }
 
-static const struct cpumask *cpu_book_mask(int cpu)
+static const struct cpumask *cpu_book_mask(struct sched_domain_topology_level *tl, int cpu)
 {
 	return &cpu_topology[cpu].book_mask;
 }
 
-static const struct cpumask *cpu_drawer_mask(int cpu)
+static const struct cpumask *cpu_drawer_mask(struct sched_domain_topology_level *tl, int cpu)
 {
 	return &cpu_topology[cpu].drawer_mask;
 }
 
+static const struct cpumask *cpu_pkg_mask(struct sched_domain_topology_level *tl, int cpu)
+{
+	return cpu_node_mask(cpu);
+}
+
 static struct sched_domain_topology_level s390_topology[] = {
 	SDTL_INIT(cpu_thread_mask, cpu_smt_flags, SMT),
 	SDTL_INIT(cpu_coregroup_mask, cpu_core_flags, MC),
 	SDTL_INIT(cpu_book_mask, NULL, BOOK),
 	SDTL_INIT(cpu_drawer_mask, NULL, DRAWER),
-	SDTL_INIT(cpu_cpu_mask, NULL, PKG),
+	SDTL_INIT(cpu_pkg_mask, NULL, PKG),
 	{ NULL, },
 };
 
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 33e166f6ab12..31a3b57314ef 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -471,6 +471,26 @@ static int x86_cluster_flags(void)
 }
 #endif
 
+static const struct cpumask *tl_smt_mask(struct sched_domain_topology_level *tl, int cpu)
+{
+	return cpu_smt_mask(cpu);
+}
+
+static const struct cpumask *tl_cls_mask(struct sched_domain_topology_level *tl, int cpu)
+{
+	return cpu_clustergroup_mask(cpu);
+}
+
+static const struct cpumask *tl_mc_mask(struct sched_domain_topology_level *tl, int cpu)
+{
+	return cpu_coregroup_mask(cpu);
+}
+
+static const struct cpumask *tl_pkg_mask(struct sched_domain_topology_level *tl, int cpu)
+{
+	return cpu_node_mask(cpu);
+}
+
 /*
  * Set if a package/die has multiple NUMA nodes inside.
  * AMD Magny-Cours, Intel Cluster-on-Die, and Intel
@@ -479,14 +499,14 @@ static int x86_cluster_flags(void)
 static bool x86_has_numa_in_package;
 
 static struct sched_domain_topology_level x86_topology[] = {
-	SDTL_INIT(cpu_smt_mask, cpu_smt_flags, SMT),
+	SDTL_INIT(tl_smt_mask, cpu_smt_flags, SMT),
 #ifdef CONFIG_SCHED_CLUSTER
-	SDTL_INIT(cpu_clustergroup_mask, x86_cluster_flags, CLS),
+	SDTL_INIT(tl_cls_mask, x86_cluster_flags, CLS),
 #endif
 #ifdef CONFIG_SCHED_MC
-	SDTL_INIT(cpu_coregroup_mask, x86_core_flags, MC),
+	SDTL_INIT(tl_mc_mask, x86_core_flags, MC),
 #endif
-	SDTL_INIT(cpu_cpu_mask, x86_sched_itmt_flags, PKG),
+	SDTL_INIT(tl_pkg_mask, x86_sched_itmt_flags, PKG),
 	{ NULL },
 };
 
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 5263746b63e8..f0a53b0e67f5 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -172,7 +172,9 @@ bool cpus_equal_capacity(int this_cpu, int that_cpu);
 bool cpus_share_cache(int this_cpu, int that_cpu);
 bool cpus_share_resources(int this_cpu, int that_cpu);
 
-typedef const struct cpumask *(*sched_domain_mask_f)(int cpu);
+struct sched_domain_topology_level;
+
+typedef const struct cpumask *(*sched_domain_mask_f)(struct sched_domain_topology_level *tl, int cpu);
 typedef int (*sched_domain_flags_f)(void);
 
 struct sd_data {
diff --git a/include/linux/topology.h b/include/linux/topology.h
index 33b7fda97d39..6575af39fd10 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -260,7 +260,7 @@ static inline bool topology_is_primary_thread(unsigned int cpu)
 
 #endif
 
-static inline const struct cpumask *cpu_cpu_mask(int cpu)
+static inline const struct cpumask *cpu_node_mask(int cpu)
 {
 	return cpumask_of_node(cpu_to_node(cpu));
 }
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 977e133bb8a4..8164ffabcd31 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1591,7 +1591,6 @@ static void claim_allocations(int cpu, struct sched_domain *sd)
 enum numa_topology_type sched_numa_topology_type;
 
 static int			sched_domains_numa_levels;
-static int			sched_domains_curr_level;
 
 int				sched_max_numa_distance;
 static int			*sched_domains_numa_distance;
@@ -1632,14 +1631,7 @@ sd_init(struct sched_domain_topology_level *tl,
 	int sd_id, sd_weight, sd_flags = 0;
 	struct cpumask *sd_span;
 
-#ifdef CONFIG_NUMA
-	/*
-	 * Ugly hack to pass state to sd_numa_mask()...
-	 */
-	sched_domains_curr_level = tl->numa_level;
-#endif
-
-	sd_weight = cpumask_weight(tl->mask(cpu));
+	sd_weight = cpumask_weight(tl->mask(tl, cpu));
 
 	if (tl->sd_flags)
 		sd_flags = (*tl->sd_flags)();
@@ -1677,7 +1669,7 @@ sd_init(struct sched_domain_topology_level *tl,
 	};
 
 	sd_span = sched_domain_span(sd);
-	cpumask_and(sd_span, cpu_map, tl->mask(cpu));
+	cpumask_and(sd_span, cpu_map, tl->mask(tl, cpu));
 	sd_id = cpumask_first(sd_span);
 
 	sd->flags |= asym_cpu_capacity_classify(sd_span, cpu_map);
@@ -1732,22 +1724,42 @@ sd_init(struct sched_domain_topology_level *tl,
 	return sd;
 }
 
+static const struct cpumask *tl_smt_mask(struct sched_domain_topology_level *tl, int cpu)
+{
+	return cpu_smt_mask(cpu);
+}
+
+static const struct cpumask *tl_cls_mask(struct sched_domain_topology_level *tl, int cpu)
+{
+	return cpu_clustergroup_mask(cpu);
+}
+
+static const struct cpumask *tl_mc_mask(struct sched_domain_topology_level *tl, int cpu)
+{
+	return cpu_coregroup_mask(cpu);
+}
+
+static const struct cpumask *tl_pkg_mask(struct sched_domain_topology_level *tl, int cpu)
+{
+	return cpu_node_mask(cpu);
+}
+
 /*
  * Topology list, bottom-up.
  */
 static struct sched_domain_topology_level default_topology[] = {
 #ifdef CONFIG_SCHED_SMT
-	SDTL_INIT(cpu_smt_mask, cpu_smt_flags, SMT),
+	SDTL_INIT(tl_smt_mask, cpu_smt_flags, SMT),
 #endif
 
 #ifdef CONFIG_SCHED_CLUSTER
-	SDTL_INIT(cpu_clustergroup_mask, cpu_cluster_flags, CLS),
+	SDTL_INIT(tl_cls_mask, cpu_cluster_flags, CLS),
 #endif
 
 #ifdef CONFIG_SCHED_MC
-	SDTL_INIT(cpu_coregroup_mask, cpu_core_flags, MC),
+	SDTL_INIT(tl_mc_mask, cpu_core_flags, MC),
 #endif
-	SDTL_INIT(cpu_cpu_mask, NULL, PKG),
+	SDTL_INIT(tl_pkg_mask, NULL, PKG),
 	{ NULL, },
 };
 
@@ -1769,9 +1781,9 @@ void __init set_sched_topology(struct sched_domain_topology_level *tl)
 
 #ifdef CONFIG_NUMA
 
-static const struct cpumask *sd_numa_mask(int cpu)
+static const struct cpumask *sd_numa_mask(struct sched_domain_topology_level *tl, int cpu)
 {
-	return sched_domains_numa_masks[sched_domains_curr_level][cpu_to_node(cpu)];
+	return sched_domains_numa_masks[tl->numa_level][cpu_to_node(cpu)];
 }
 
 static void sched_numa_warn(const char *str)
@@ -2411,7 +2423,7 @@ static bool topology_span_sane(const struct cpumask *cpu_map)
 		 * breaks the linking done for an earlier span.
 		 */
 		for_each_cpu(cpu, cpu_map) {
-			const struct cpumask *tl_cpu_mask = tl->mask(cpu);
+			const struct cpumask *tl_cpu_mask = tl->mask(tl, cpu);
 			int id;
 
 			/* lowest bit set in this mask is used as a unique id */
@@ -2419,7 +2431,7 @@ static bool topology_span_sane(const struct cpumask *cpu_map)
 
 			if (cpumask_test_cpu(id, id_seen)) {
 				/* First CPU has already been seen, ensure identical spans */
-				if (!cpumask_equal(tl->mask(id), tl_cpu_mask))
+				if (!cpumask_equal(tl->mask(tl, id), tl_cpu_mask))
 					return false;
 			} else {
 				/* First CPU hasn't been seen before, ensure it's a completely new span */



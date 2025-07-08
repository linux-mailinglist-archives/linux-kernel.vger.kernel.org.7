Return-Path: <linux-kernel+bounces-721175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3666AFC5B4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 10:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6BC4188559B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 08:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EA22BDC06;
	Tue,  8 Jul 2025 08:31:55 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA18255F25;
	Tue,  8 Jul 2025 08:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751963515; cv=none; b=IrEk8JmWtuGumjtELu4o5+NYFonaQ663xUqR2pKdc0gVa1+Rko/tcY/wVOYLkkdFsQpQzMWebhwFv3faQ4ZvuPGftlxspQ4H1x4lvrWum1oV7mzc6bsfUnMxoGVqe8Tmfy39L+xB4sXFUzAil+Ap0nmiRfQALENy492+9sYMDxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751963515; c=relaxed/simple;
	bh=iRd0SIefKzxx2mSYz64PjglLbV163t7qXinS83B31to=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bSYhrI7LJTdggCH56zLZUwV+xbtvc64f/0prqtHI6ntYPWDROVqnfaH8ESg8uxcKVu+dG1dG7e6DkoI+XhmrOjYxv4ZrHwQSYidZKwKdSW/TaaXDZbuMsb0joFWOGzH4X2/49gzJX7VrAHWqWRVbba4MZU2Gqe4hT9B1bH3wk+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bbvT642xHz6GCjH;
	Tue,  8 Jul 2025 16:31:06 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 5DC181404C5;
	Tue,  8 Jul 2025 16:31:51 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 8 Jul
 2025 10:31:50 +0200
Date: Tue, 8 Jul 2025 09:31:49 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
CC: <mark.rutland@arm.com>, <robh@kernel.org>, <coresight@lists.linaro.org>,
	<devicetree@vger.kernel.org>, <dianders@chromium.org>,
	<james.clark@linaro.org>, <krzk@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linuxarm@huawei.com>,
	<mike.leach@linaro.org>, <ruanjinjie@huawei.com>, <saravanak@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <suzuki.poulose@arm.com>
Subject: Re: [PATCH 2/5] arch_topology: update CPU map to use the new API
Message-ID: <20250708093149.00005ed2@huawei.com>
In-Reply-To: <20250707150414.620-3-alireza.sanaee@huawei.com>
References: <20250707150414.620-1-alireza.sanaee@huawei.com>
	<20250707150414.620-3-alireza.sanaee@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 7 Jul 2025 16:04:11 +0100
Alireza Sanaee <alireza.sanaee@huawei.com> wrote:

> Cleans up the cpu-map generation using the created API.
> 
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> ---
>  drivers/base/arch_topology.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 3ebe77566788..88970f13f684 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -518,23 +518,23 @@ core_initcall(free_raw_capacity);
>   */
>  static int __init get_cpu_for_node(struct device_node *node)
>  {
> +	struct device_node *cpu_node __free(device_node) = NULL;
>  	int cpu;
> -	struct device_node *cpu_node __free(device_node) =
> -		of_parse_phandle(node, "cpu", 0);
>  
> -	if (!cpu_node)
> -		return -1;
> +	cpu = of_cpu_phandle_to_id(node, &cpu_node, 0);
>  
> -	cpu = of_cpu_node_to_id(cpu_node);

Better I think to flip logic to exit early on errors.

So taking previous review into account - something like.

	struct device_node *cpu_node = NULL;
	int cpu;

	cpu = of_cpu_phandle_to_id(node, &cpu_node, 0);
	if (cpu == -ENODEV) {
 		pr_info("CPU node for %pOF exist but the possible cpu range is :%*pbl\n",
			cpu_node, cpumask_pr_args(cpu_possible_mask));
		return -ENODEV;
	} else if (cpu < 0) {
		return cpu;
	}

	topology_parse_cpu_capacity(cpu_node, cpu);
	of_node_put(cpu_node);

	return cpu;


>  	if (cpu >= 0)
>  		topology_parse_cpu_capacity(cpu_node, cpu);
> -	else
> +	else if (cpu == -ENODEV)
>  		pr_info("CPU node for %pOF exist but the possible cpu range is :%*pbl\n",
>  			cpu_node, cpumask_pr_args(cpu_possible_mask));
> +	else
> +		return -1;
>  
>  	return cpu;
>  }
>  
> +

Check all patches before posting for noise like this. It sneaks in as
rebases / refactors happen so you always need to eyeball for it at the end
of development.

>  static int __init parse_core(struct device_node *core, int package_id,
>  			     int cluster_id, int core_id)
>  {



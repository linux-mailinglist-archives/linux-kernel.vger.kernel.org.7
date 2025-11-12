Return-Path: <linux-kernel+bounces-896427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AC2C50582
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 03:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B326918956F8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 02:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C712224245;
	Wed, 12 Nov 2025 02:27:40 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DBD946A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 02:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762914459; cv=none; b=nzXLxiN+mC8EgvkhDff6iKHouindkJe2Ja4iExgNR6mdarhxmdAsyvFrMwp/DEHt5q+X1SkNMQFuzUH8MyIKXk9EQkKGHtwhuva/pPWOJEAX+13COMf+pYGNp/1MUuc2b6LBBElz5oUBUGuCk6GLFcEoCzOF/GgiuFtqeOOvp3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762914459; c=relaxed/simple;
	bh=itxUb1eFMAvrLgpK89fwpB44rWb+15T2pEMWpDArxTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJRg0jdV3i3pOmqlQbzrLAHZ3q+dHTZRYgezCZnJ/mC0JNxbQO8x0WvbtuKpG31viBHzplgkCHFxiZH7b8bkXF72xJVWAPMghqfoM6K/4cBO89+Zc1/flNkLo2U0dCgeCZwDp+78FdbJUz/nxCFBIh0evVQyiBWLpcez0I/C/CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-03-6913ed06a8b5
Date: Wed, 12 Nov 2025 11:12:17 +0900
From: Byungchul Park <byungchul@sk.com>
To: "Garg, Shivank" <shivankg@amd.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com,
	willy@infradead.org, matthew.brost@intel.com,
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, gourry@gourry.net,
	ying.huang@linux.alibaba.com, apopple@nvidia.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	vkoul@kernel.org, lucas.demarchi@intel.com, rdunlap@infradead.org,
	jgg@ziepe.ca, kuba@kernel.org, justonli@chromium.org,
	ivecera@redhat.com, dave.jiang@intel.com,
	Jonathan.Cameron@huawei.com, dan.j.williams@intel.com,
	rientjes@google.com, Raghavendra.KodsaraThimmappa@amd.com,
	bharata@amd.com, alirad.malek@zptcorp.com, yiannis@zptcorp.com,
	weixugc@google.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com
Subject: Re: [RFC V3 6/9] mtcopy: introduce multi-threaded page copy routine
Message-ID: <20251112021217.GA45963@system.software.com>
References: <20250923174752.35701-1-shivankg@amd.com>
 <20250923174752.35701-7-shivankg@amd.com>
 <20251020082800.GA28427@system.software.com>
 <88ae0dfb-b10f-4829-8aa7-a681612704fa@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88ae0dfb-b10f-4829-8aa7-a681612704fa@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0gUURSAuTOzM+Pi1m21uuqPYKICISspOFGGIdYEQkFFmERNOeaQbrKa
	uUGwYomutZpl6vpI8VH5zh6u9kDNcq0ws6wtHymmpLBahr20h6tE/vu457sf58fhae05lSev
	6GJkvU6KEFg1o3a4Fq5mHW7KWmseQG51BQtviodoaLDvgZILYzRkZnQgsL2NZ2Gy+icNP3pb
	ObidZYDsLBuCssLXLLTezufg02gYdNwxq6DO2M/By4ZcFvoq/qigzXKdgaHBUha+mr3gvdkf
	MkwjNDh6MhlILL5BQUt1HQXtFV84uNhZwEJOvBlBfY+NhvHXnzmY+j4TmuwxU1BeEQ45j/o4
	f0E82/mLFXOMLxix3tLLiQW1J8SUxJeceKbFoRJvXvMWi+6NUGJtWTIr1k6kc6Ita2pGHdgo
	nk8YY8XPQ+8YcfxBFytW3+pidrnvV28OlSOUWFm/ZsshdfjTpC9MVI0Q15nWwBhRNjEhF57g
	9STRdJ/5x0WXJ2aZwSvIaM431sksXkXs9h+0k93xSpLSWEqZkJqncQlLSp+kzn5ww0Ek5UqV
	yoR4XoOB9FvDnI4WNyFyvuO5yulo8CLSlv1h1qexN7H/HqGcPo29yNXfvPPZBW8ixskkysmL
	8XLSeKeVmtutkic18fQce5Cma3YmDWHLvKplXtXyv1qA6DKkVXSxkZISsd4n3KBT4nyOHI+s
	RTM3Unp6OsSKJjp2NyPMI8FVQwbdFK1Kio02RDYjwtOCu2b6MFa0mlDJcErWHz+oPxEhRzcj
	L54Rlmp8v54M1eKjUox8TJajZP2/KcW7eBoRve7SjncHXrklPGZ2hrp2Lds7rHqWVq63Zi5s
	M6UP+m3w1bHyAfTxYdrdYXerTfPIHxUkL+HvVxlcQgINZ4P6PZnukmXp9/blbX+8tZuTAoSs
	qaMJnN/AqMVzk0bQBQTHLJgI7vFw9BJLd3CXwhdmbPu0MTBMqhn3b0+tzE8VmOhwaZ03rY+W
	/gKDnI9jHwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUyMcRzA/Z6X3/N03PZzJb/pD7m8bI3DxL4tI3/1zGt/GJvZ6vDkjrsr
	d5Uy7LyOWufyVl2lTCUV5Ux0MyWsi40UiYqiZtd24VLeEp3N9N9n3+/n8/3rK7KqIW6GqDcl
	y2aT1qDGCk6xPurIAuwN1C+y+cKgoLoKw8uSfhZcHRuhNHuQhZxzLQjcrw5hGK7+wcL37iYB
	buamQ16uG0HFxXYMTTcvCPBpIAHuFzbz0FJr4+GWtUeANlcBhjdVv3lodlzhoP99GYYRWwi8
	tUXDuQwPC43tH3jwduVwcLzkOgMPqm8x8KRqSIAzrcUY8g/ZENR1uVn42P5ZgJ/fxq8Nd9kY
	qKzSQf7DN0L0bOlY6y8s5VufcVKdo1uQip0pUubxNkE6+sDLSzfKw6VLdzyM5Kw4iSWn77Qg
	uXN/jqu9kVLWkUEsfe5/zUkf777A0kinFBu8RbF8h2zQp8rmhSviFbrHJ4a4pBp1WqvdxVlR
	Hs1AASIlEfTSeR/nZ47MoQP5X7GfMZlHOzq+s34OInNpZkMZk4EUIktKMS17dOpvEEjW0syi
	a3wGEkUlAdpzO8HvqMg9RLNanvJ+R0mm0ua8vr8+S8Jpx5iH8fssCaGXx0T/OIBEUevwCcbP
	00gYbahtYuxI6ZhQOybUjv91MWIrUJDelGrU6g1LNZbdunSTPk2zPdHoROOvUHZgNPs2+tIW
	04iIiNRTlNFzAvUqXptqSTc2Iiqy6iDl6DaiVyl3aNP3yebEOHOKQbY0ohCRU09Xrt4sx6vI
	Tm2yvFuWk2Tzvy0jBsywIoh8PCu7r33lJOP+me988+XOmXdWtSWpKkOPJlf+3hq7+kxOVuzB
	4MSx/r1OY4GdjG0qMlkLT9fuCb2Ky3fFLNdEeus9l5cUrnvOeJbxk3FfqLtELFwIS0JLNxTZ
	Z6V6B1sP19dwrqma3jVhujiDffHrh3e5DcvI2eoI6tOl9Kg5i067OJw1W7R/AOplAnwGAwAA
X-CFilter-Loop: Reflected

On Thu, Nov 06, 2025 at 11:57:54AM +0530, Garg, Shivank wrote:
> On 10/20/2025 1:58 PM, Byungchul Park wrote:
> > Thanks for the great work.
> >
> > By the way, is it okay to use work queue?  When the system is idle, this
> > patch will improve the migration performance, but when there are a lot
> > of other runnable tasks in the system, it might be worse than the
> > current one.  That's gonna be even worse if there are some other tasks
> > that wait for the migration to end.  It's worth noting that
> > padata_do_multithreaded() also uses work queue internally.
> >
> > I think, at worst, the performance should be same as is.  Or am I
> > missing something?
> >
> >       Byungchul
> 
> Hi Byungchul,
> 
> This was addressed by Zi in the mail:
> https://lore.kernel.org/linux-mm/61F6152C-A91E-453B-9521-34B7497AE532@nvidia.com
> 
> So, there are some specific use cases that can benefit significantly when CPU cores are idle

Sure.  I think so.  I meant the mechanism using multi-threads would
better be performed for faster migration when a system is idle, but it'd
better avoid the aggressiveness when the system is busy.

Or we might observe a performance degradation due to this work.

	Byungchul

> while GPUs or accelerators handle most of the workload.
> In such scenarios, migrating pages to and from device memory (GPU or AI accelerator) quickly
> is critical and ensure hot data is always available for accelerators.
> 
> Thanks,
> Shivank
> 
> >
> >> +                               per_cpu_item_idx = 0;
> >> +                               cpu++;
> >> +                       }
> >> +               }
> >> +               if (item_idx != nr_items)
> >> +                       pr_warn("%s: only %d out of %d pages are transferred\n",
> >> +                               __func__, item_idx - 1, nr_items);
> >> +       }
> >> +
> >> +       /* Wait until it finishes  */
> >> +       for (i = 0; i < total_mt_num; ++i) {
> >> +               flush_work((struct work_struct *)work_items[i]);
> >> +               /* retry if any copy fails */
> >> +               if (work_items[i]->ret)
> >> +                       err = -EAGAIN;
> >> +       }
> >> +
> >> +free_work_items:
> >> +       for (cpu = 0; cpu < total_mt_num; ++cpu)
> >> +               kfree(work_items[cpu]);
> >> +
> >> +       return err;
> >> +}
> >> +
> >> +static struct kobject *mt_kobj_ref;
> >> +static struct kobj_attribute mt_offloading_attribute = __ATTR(offloading, 0664,
> >> +               mt_offloading_show, mt_offloading_set);
> >> +static struct kobj_attribute mt_threads_attribute = __ATTR(threads, 0664,
> >> +               mt_threads_show, mt_threads_set);
> >> +
> >> +static int __init cpu_mt_module_init(void)
> >> +{
> >> +       int ret = 0;
> >> +
> >> +       mt_kobj_ref = kobject_create_and_add("cpu_mt", kernel_kobj);
> >> +       if (!mt_kobj_ref)
> >> +               return -ENOMEM;
> >> +
> >> +       ret = sysfs_create_file(mt_kobj_ref, &mt_offloading_attribute.attr);
> >> +       if (ret)
> >> +               goto out_offloading;
> >> +
> >> +       ret = sysfs_create_file(mt_kobj_ref, &mt_threads_attribute.attr);
> >> +       if (ret)
> >> +               goto out_threads;
> >> +
> >> +       is_dispatching = 0;
> >> +
> >> +       return 0;
> >> +
> >> +out_threads:
> >> +       sysfs_remove_file(mt_kobj_ref, &mt_offloading_attribute.attr);
> >> +out_offloading:
> >> +       kobject_put(mt_kobj_ref);
> >> +       return ret;
> >> +}
> >> +
> >> +static void __exit cpu_mt_module_exit(void)
> >> +{
> >> +       /* Stop the MT offloading to unload the module */
> >> +       mutex_lock(&migratecfg_mutex);
> >> +       if (is_dispatching == 1) {
> >> +               stop_offloading();
> >> +               is_dispatching = 0;
> >> +       }
> >> +       mutex_unlock(&migratecfg_mutex);
> >> +
> >> +       sysfs_remove_file(mt_kobj_ref, &mt_threads_attribute.attr);
> >> +       sysfs_remove_file(mt_kobj_ref, &mt_offloading_attribute.attr);
> >> +       kobject_put(mt_kobj_ref);
> >> +}
> >> +
> >> +module_init(cpu_mt_module_init);
> >> +module_exit(cpu_mt_module_exit);
> >> +
> >> +MODULE_LICENSE("GPL");
> >> +MODULE_AUTHOR("Zi Yan");
> >> +MODULE_DESCRIPTION("CPU_MT_COPY"); /* CPU Multithreaded Batch Migrator */
> >> --
> >> 2.43.0


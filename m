Return-Path: <linux-kernel+bounces-892478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99295C452CB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7BCA84E8744
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 07:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E014D2EAB6B;
	Mon, 10 Nov 2025 07:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f/rZ/COQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457AE2EB86C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762758540; cv=none; b=iDaJ+3UsyJzR2w9PAShv71PdsJKiwx0R66CdijjIGcGyykUipKtrzbLZVyQMvwvm4o0l7gixdKKLaVU+tbpjtZeV+F3Eva6bYDq5YF+WZ39c+cwMEYz6TRnl7CNPZamEv4k//MfOXwfoCTcDD0m6gSlOuZ9GuuitzLZZhcGPOos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762758540; c=relaxed/simple;
	bh=U1cUjkcPhRCPd7EEVlnS26KUneits1XjUS600vahWoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rmx+aNi0RhundaeOdCuI2txFKFJEoTEm40Nugh9tQ3Y3WX20x4ZSx6URIqBNBKWCLF5mosnahTGe7BRjrZYkP8NOTcdF14U82LVpplR6ssXSfARcd2TVbGsaJTPKEHjca7z+jz5/YnPwKNbYmwTScwqYKn83sRsZYpN45sen4Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f/rZ/COQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762758536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FQeFfemk8R9pFVPJVE7vGo0yI2GmBM6W7T4hZkmc8fU=;
	b=f/rZ/COQx53+jEPS0DMLIJs01tNJZU+sHaEu1MUyj3DEFLSqcPR5VP4qI4HIOsem5Bk4tR
	fdor4GUMCE8jdBNqbjvyljLgMrXnwK1H0NBLRCjpuwnZkI2pZrUxAsH6RbXNPnoFloeRNC
	TJXAqxJBX5E/VXOcxSdto4VeJnljO5o=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-37-eeRdVSlDPZqYg8Icnng9Iw-1; Mon,
 10 Nov 2025 02:08:53 -0500
X-MC-Unique: eeRdVSlDPZqYg8Icnng9Iw-1
X-Mimecast-MFC-AGG-ID: eeRdVSlDPZqYg8Icnng9Iw_1762758531
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 65A95195608F;
	Mon, 10 Nov 2025 07:08:50 +0000 (UTC)
Received: from localhost (unknown [10.72.112.59])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B262E19560A7;
	Mon, 10 Nov 2025 07:08:47 +0000 (UTC)
Date: Mon, 10 Nov 2025 15:08:41 +0800
From: Baoquan he <bhe@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, Aditya Gupta <adityag@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Young <dyoung@redhat.com>,
	Hari Bathini <hbathini@linux.ibm.com>, Jiri Bohac <jbohac@suse.cz>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Pingfan Liu <piliu@redhat.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shivang Upadhyay <shivangu@linux.ibm.com>,
	Vivek Goyal <vgoyal@redhat.com>, linuxppc-dev@lists.ozlabs.org,
	kexec@lists.infradead.org
Subject: Re: [PATCH v3 5/5] crash: export crashkernel CMA reservation to
 userspace
Message-ID: <aRGPee9izxWPRHj5@MiWiFi-R3L-srv>
References: <20251110043143.484408-1-sourabhjain@linux.ibm.com>
 <20251110043143.484408-6-sourabhjain@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110043143.484408-6-sourabhjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 11/10/25 at 10:01am, Sourabh Jain wrote:
> Add a sysfs entry /sys/kernel/kexec/crash_cma_ranges to expose all
> CMA crashkernel ranges.

I am not against this way. While wondering if it's more appropriate to
export them into iomem_resource just like crashk_res and crashk_low_res
doing.

> 
> This allows userspace tools configuring kdump to determine how much
> memory is reserved for crashkernel. If CMA is used, tools can warn
> users when attempting to capture user pages with CMA reservation.
> 
> The new sysfs hold the CMA ranges in below format:
> 
> cat /sys/kernel/kexec/crash_cma_ranges
> 100000000-10c7fffff
> 
> Cc: Aditya Gupta <adityag@linux.ibm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan he <bhe@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Jiri Bohac <jbohac@suse.cz>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
> Cc: Pingfan Liu <piliu@redhat.com>
> Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: kexec@lists.infradead.org
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
> Changelog:
>  - Add the missing hunk to export crash_cma_ranges sysfs
> 
> ---
>  .../ABI/testing/sysfs-kernel-kexec-kdump        | 10 ++++++++++
>  kernel/kexec_core.c                             | 17 +++++++++++++++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-kernel-kexec-kdump b/Documentation/ABI/testing/sysfs-kernel-kexec-kdump
> index 00c00f380fea..f59051b5d96d 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-kexec-kdump
> +++ b/Documentation/ABI/testing/sysfs-kernel-kexec-kdump
> @@ -49,3 +49,13 @@ Description:	read only
>  		is used by the user space utility kexec to support updating the
>  		in-kernel kdump image during hotplug operations.
>  User:		Kexec tools
> +
> +What:		/sys/kernel/kexec/crash_cma_ranges
> +Date:		Nov 2025
> +Contact:	kexec@lists.infradead.org
> +Description:	read only
> +		Provides information about the memory ranges reserved from
> +		the Contiguous Memory Allocator (CMA) area that are allocated
> +		to the crash (kdump) kernel. It lists the start and end physical
> +		addresses of CMA regions assigned for crashkernel use.
> +User:		kdump service
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 7476a46de5d6..da6ff72b4669 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -1271,6 +1271,22 @@ static ssize_t crash_size_store(struct kobject *kobj,
>  }
>  static struct kobj_attribute crash_size_attr = __ATTR_RW(crash_size);
>  
> +static ssize_t crash_cma_ranges_show(struct kobject *kobj,
> +				     struct kobj_attribute *attr, char *buf)
> +{
> +
> +	ssize_t len = 0;
> +	int i;
> +
> +	for (i = 0; i < crashk_cma_cnt; ++i) {
> +		len += sysfs_emit_at(buf, len, "%08llx-%08llx\n",
> +				     crashk_cma_ranges[i].start,
> +				     crashk_cma_ranges[i].end);
> +	}
> +	return len;
> +}
> +static struct kobj_attribute crash_cma_ranges_attr = __ATTR_RO(crash_cma_ranges);
> +
>  #ifdef CONFIG_CRASH_HOTPLUG
>  static ssize_t crash_elfcorehdr_size_show(struct kobject *kobj,
>  			       struct kobj_attribute *attr, char *buf)
> @@ -1289,6 +1305,7 @@ static struct attribute *kexec_attrs[] = {
>  #ifdef CONFIG_CRASH_DUMP
>  	&crash_loaded_attr.attr,
>  	&crash_size_attr.attr,
> +	&crash_cma_ranges_attr.attr,
>  #ifdef CONFIG_CRASH_HOTPLUG
>  	&crash_elfcorehdr_size_attr.attr,
>  #endif
> -- 
> 2.51.1
> 



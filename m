Return-Path: <linux-kernel+bounces-885755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E147C33D55
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 04:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7939518C3135
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 03:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDF12192EA;
	Wed,  5 Nov 2025 03:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ch4WkXZE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE3E18C332
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 03:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762312572; cv=none; b=AMYFByylfZqrVo3VsUx19rykt9pg5bPT4DCMnZbMvB6itdN1+VEemjSOpJXsuk3aIgfBOaCgp0G3zhQ6Kb5J83tmEewgqmiYVWLnsCXyahzXPmeCw6mrXHmuyFva8WBoHHi2sPzpB86qHnABqozzPq4GFKEMLXsB3qG9FQCL+OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762312572; c=relaxed/simple;
	bh=VS01ii9Dd0nM8DLVVrGSoI7tT6g3AuWM9VPlbkLaFII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+mWsbWn+siXQUXmx21Ag4C0ci9KSGkdeemDNa43Ge2ecxsZIi/V1ungNsBnaTQdYT4VVbv4xwrd5JZ2N8wQu9Xc0SfW6aApJfI+YEn3dsWN5YWhWiyZZcMvar8VkAO69+tRwXMIlImd9J7Fmshkzn8kZTdyayRYp2D/dLVQwVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ch4WkXZE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762312569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=khlr+nqfqO8zkgfz4nPt9sJu1gGHQI2iFDjbcvasM4k=;
	b=ch4WkXZEAeK+733FNiMTDSZB1gkk4t4w7RgZ8nIzF2BLKMhK6NqshYxCck6k2E9QS2xREo
	wnzRxrxWWTQiOvW0p8FVWwySVRpmFyVzH/ZE3fYaosotHfGZHYzpt1G3yeCeyGy4XtMsmC
	9tIE3les7pqyMYe/5wAlAYPwWqM6wkM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-321-pcTzoig4Oy65rcC08Sm5fw-1; Tue,
 04 Nov 2025 22:16:06 -0500
X-MC-Unique: pcTzoig4Oy65rcC08Sm5fw-1
X-Mimecast-MFC-AGG-ID: pcTzoig4Oy65rcC08Sm5fw_1762312565
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 41CD319560B2;
	Wed,  5 Nov 2025 03:16:04 +0000 (UTC)
Received: from localhost (unknown [10.72.112.190])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B8CB11956056;
	Wed,  5 Nov 2025 03:16:01 +0000 (UTC)
Date: Wed, 5 Nov 2025 11:15:57 +0800
From: Baoquan he <bhe@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Jiri Bohac <jbohac@suse.cz>,
	Shivang Upadhyay <shivangu@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org
Subject: Re: [PATCH 0/2] Export kdump crashkernel CMA ranges
Message-ID: <aQrBbYVEQleExjpk@MiWiFi-R3L-srv>
References: <20251103035859.1267318-1-sourabhjain@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103035859.1267318-1-sourabhjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 11/03/25 at 09:28am, Sourabh Jain wrote:
> /sys/kernel/kexec_crash_cma_ranges to export all CMA regions reserved
> for the crashkernel to user-space. This enables user-space tools
> configuring kdump to determine the amount of memory reserved for the
> crashkernel. When CMA is used for crashkernel allocation, tools can use
> this information to warn users that attempting to capture user pages
> while CMA reservation is active may lead to unreliable or incomplete
> dump capture.
> 
> While adding documentation for the new sysfs interface, I realized that
> there was no ABI document for the existing kexec and kdump sysfs
> interfaces, so I added one.
> 
> The first patch adds the ABI documentation for the existing kexec and
> kdump sysfs interfaces, and the second patch adds the
> /sys/kernel/kexec_crash_cma_ranges sysfs interface along with its
> corresponding ABI documentation.
> 
> *Seeking opinions*
> There are already four kexec/kdump sysfs entries under /sys/kernel/,
> and this patch series adds one more. Should we consider moving them to
> a separate directory, such as /sys/kernel/kexec, to avoid polluting
> /sys/kernel/? For backward compatibility, we can create symlinks at
> the old locations for sometime and remove them in the future.

That sounds a good idea, will you do it in v2? Because otherwise the
kexec_crash_cma_ranges need be moved too.


> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan he <bhe@redhat.com>
> Cc: Jiri Bohac <jbohac@suse.cz>
> Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: kexec@lists.infradead.org
> 
> Sourabh Jain (2):
>   Documentation/ABI: add kexec and kdump sysfs interface
>   crash: export crashkernel CMA reservation to userspace
> 
>  .../ABI/testing/sysfs-kernel-kexec-kdump      | 53 +++++++++++++++++++
>  kernel/ksysfs.c                               | 17 ++++++
>  2 files changed, 70 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-kernel-kexec-kdump
> 
> -- 
> 2.51.0
> 



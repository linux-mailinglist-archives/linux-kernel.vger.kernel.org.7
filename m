Return-Path: <linux-kernel+bounces-832127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCB0B9E696
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02E2C161651
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54282EBB88;
	Thu, 25 Sep 2025 09:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9C1R7dT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF482773CA
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758792870; cv=none; b=tqsTM2mrAppQRY5HilnzmYRwttByHtxk9+mgr5ENCs5hwIClqJzsCJTzdR3mPLhfSGS9wFUVVrxwFgo0tj1TIb0xqeWyDzSpKcudxXY5bbNJCCaxt1qvN/MuKNcm5sE57kCe8R11PNI3CnqWCoyGamSSmeNO13UqK6n1WriyWgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758792870; c=relaxed/simple;
	bh=zhLCyo5R7EKVDWnkns2gJ5vK7ZjyanVB4ZoLdpUCNSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dcbGKgwCHuDQCCqD33+YQbaTeSRzFnWjRg+rC7oFdxdqYI/9oPHMG4k9YIKeLia3vPeOuv7DQ6A/qfGVXmYBUjiaC5nP69NR19gfh8n6MKGB0GXEXRA3iXXKuYPEDtbv+OxJsp4HGRURyKo0rJLOL+FXQHOUVmEt7ZzPJX1nlr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9C1R7dT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D08C4CEF0;
	Thu, 25 Sep 2025 09:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758792869;
	bh=zhLCyo5R7EKVDWnkns2gJ5vK7ZjyanVB4ZoLdpUCNSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j9C1R7dTphqDn936rCHEjvRdwp1C6POkkYrek+iR0jbe0WP7/KvUswV9j3pvP1Qfu
	 L3WSYVA5WXLdVBthtQVsSMEzCHT6sjwyhnIkN3b/rCNQvAwE3r2IVzHQKGc727LYaW
	 vLFHnSIeyVM6WZxtbHwyNAByS1jrPpmH/vLsi7lXUpbqtboZ50mFJ1si4fIFbetccT
	 TM9Sf/13LEgKptpT3pjaWkR1sLsFPBR8UZY18Ittvsl9LRcfmwiW3HjrOP+rBVMR15
	 6nm5DCjweITgPz6MKF0N7alTBx6yt5GNhpJSfEyi82kHOW3Bw+bzoDbm0g7z26/F2E
	 ccH+/s75kvIAg==
Date: Thu, 25 Sep 2025 12:34:20 +0300
From: Mike Rapoport <rppt@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Donet Tom <donettom@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH 1/2] drivers/base/node: merge register_one_node() and
 register_node() to a single function.
Message-ID: <aNUMnK23qKTjgEdO@kernel.org>
References: <cover.1758736423.git.donettom@linux.ibm.com>
 <40257b5228dec05e5b252f02438608eb8d681a2d.1758736423.git.donettom@linux.ibm.com>
 <0de65980-4333-434a-ae7d-2b7be46c2cca@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0de65980-4333-434a-ae7d-2b7be46c2cca@redhat.com>

On Thu, Sep 25, 2025 at 10:54:07AM +0200, David Hildenbrand wrote:
> On 24.09.25 20:40, Donet Tom wrote:
> > register_one_node() and register_node() are small functions.
> > This patch merges them into a single function named register_node()
> > to improve code readability.
> > 
> > No functional changes are introduced.
> > 
> > Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> > ---
> 
> [...]
> 
> >   /**
> >    * unregister_node - unregister a node device
> >    * @node: node going away
> > @@ -869,7 +842,13 @@ void register_memory_blocks_under_node_hotplug(int nid, unsigned long start_pfn,
> >   }
> >   #endif /* CONFIG_MEMORY_HOTPLUG */
> > -int register_one_node(int nid)
> > +/*
> 
> We can directly convert this to proper kernel doc by using /**
> 
> > + * register_node - Setup a sysfs device for a node.
> > + * @nid - Node number to use when creating the device.
> > + *
> > + * Initialize and register the node device.
> 
> and briefly describing what the return value means
> 
> "Returns 0 on success, ..."

For kernel-doc it should be

Return: 0 on success, ...

> 
> > + */
> > +int register_node(int nid)
> >   {
> >   	int error;
> >   	int cpu;
> > @@ -880,14 +859,23 @@ int register_one_node(int nid)
> >   		return -ENOMEM;
> >   	INIT_LIST_HEAD(&node->access_list);
> > -	node_devices[nid] = node;
> > -	error = register_node(node_devices[nid], nid);
> > +	node->dev.id = nid;
> > +	node->dev.bus = &node_subsys;
> > +	node->dev.release = node_device_release;
> > +	node->dev.groups = node_dev_groups;
> > +
> > +	error = device_register(&node->dev);
> >   	if (error) {
> > -		node_devices[nid] = NULL;
> 
> Wondering why we did have this temporary setting of the node_devices[] in
> there. But I cannot immediately spot why it was required.

register_cpu_under_node() references node_devices, so that assignment can
be moved just before the loop that adds CPUs to node.
 
> -- 
> Cheers
> 
> David / dhildenb
> 

-- 
Sincerely yours,
Mike.


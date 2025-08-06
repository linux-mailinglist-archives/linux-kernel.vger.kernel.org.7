Return-Path: <linux-kernel+bounces-757846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3060B1C75E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 16:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA4AB18C38E3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 14:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A4928CF69;
	Wed,  6 Aug 2025 14:08:28 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEB328DB4F
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 14:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754489307; cv=none; b=rWY1sXq+xcwOz8ZAwUSCjdK2UM/KMsK1GxZy1bMor8voGm7xvEkGHyhFTp9RBzd7CNKvGe2OeDJQgBPxOpoIVYX8PMJVOfVgxXJRtxa0NMOjLPUxre2D+cEnmmnEvTngJ02V9btHnLQH+WgrA+z12q8O/AAWIPHzCJnb2kFSoKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754489307; c=relaxed/simple;
	bh=h86s11a3+fIzq/H0wczBQ06JwTViWSNREey/RpfcJAI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NIk+CArxMZuzrUO/cKpGtWvNbZHYObo2/PaESzh3flMnWlqYR8O5aw1rGgYRsqEVNBE593ua1nPg05lg0wcsmtrS1kPA4edoq785f7Cf12aD0lzZWrM8zG/H/eq9edHCkwSqWM4TflfFD1nHkeN2ciWAv+/hVWq7IxPyrkGOZxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bxsXC32XSz6K5sk;
	Wed,  6 Aug 2025 22:06:03 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 1F8D714044F;
	Wed,  6 Aug 2025 22:08:22 +0800 (CST)
Received: from localhost (10.81.207.60) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 6 Aug
 2025 16:08:21 +0200
Date: Wed, 6 Aug 2025 15:08:18 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Rob Herring <robh@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] irqchip/msi-lib: Fix fwnode refcount in
 msi_lib_irq_domain_select()
Message-ID: <20250806150818.00004a84@huawei.com>
In-Reply-To: <aJHNeP2E76liHqUr@lpieralisi>
References: <20250804145553.795065-1-lpieralisi@kernel.org>
	<87y0ryf9uj.ffs@tglx>
	<aJHNeP2E76liHqUr@lpieralisi>
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

On Tue, 5 Aug 2025 11:23:04 +0200
Lorenzo Pieralisi <lpieralisi@kernel.org> wrote:

> On Tue, Aug 05, 2025 at 10:31:32AM +0200, Thomas Gleixner wrote:
> > On Mon, Aug 04 2025 at 16:55, Lorenzo Pieralisi wrote:  
> > >
> > > msi_lib_irq_domain_select() is used in other arches, I could not
> > > test on those (don't know if they have non-[DT/irqchip/acpi] specific
> > > fwnodes) - from a fwnode interface perspective I think that this patch
> > > does the right thing, it should not add any issue to existing code
> > > to the best of my knowledge but it has to be verified.  
> > 
> > fwnode handles are architecture and firmware agnostic.  
> 
> Yep, though to make sure this does not trigger regressions I started
> checking (ie I am adding an additional fwnode_handle_get/put() in there),
> some fwnode helpers (eg fwnode_find_reference()) returns an error
> pointer rather than NULL on error, it looks like calling
> fwnode_handle_put() on that value when OF is in use is not a good idea
> (ie of_node_put() checks for NULL and dereference).
> 
> There is code out there that implicitly assumes what fwnode types
> are used behind the fwnode_* interface or I am missing something.
> 
> It is not arch dependent but it looks like it depends on what fwnodes
> arches use - that's where my caution stems from, nothing else.
> 

For the many DEFINE_FREE() uses there is a check of IS_ERR_OR_NULL()

E.g. Here it would be 
DEFINE_FREE(fwnode_handle, struct fwnode_handle *, if (!IS_ERR_OR_NULL(_T)) fwnode_handle_put(_T));

IIRC this one was an early use of DEFINE_FREE() and later discussions
argued for always adding that check purely to allow the compiler
to potentially optimize away the call.  Sounds like it would be
more generally helpful here and I can't immediately spot any negatives.

Jonathan


> Thanks,
> Lorenzo
> 



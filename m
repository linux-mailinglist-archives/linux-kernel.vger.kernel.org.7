Return-Path: <linux-kernel+bounces-741497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B420B0E4FF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 22:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B7AD1CC0B95
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 20:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB9F280A5C;
	Tue, 22 Jul 2025 20:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OguZwGLT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FBhjcHAS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE79E4C92
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 20:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753216312; cv=none; b=IshxLPbdc7hppy0qItZ7VixZ38mMJAbex3zkE0awpAK8UkSMk0m+pZJC1n1fZel6cCijcO8VkCznobp8THubLZBuQlz7feJCvWVCQCUqkfHdrQ/VDkeY5QXViAy+QY3mGnFc2V9nI7MAMWU/OJaL/SlQSZlooA7wAe+rtfEnYLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753216312; c=relaxed/simple;
	bh=QzGsIpVDNnmMB9yY40z4tZwLUpMYADykSqVelZFmZE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRObZXld/uLcWTJ04P0y6TiLOOMDXgtJiIvNyLDzMdHORgHZKsEAx5IqOO9H+0fWEaazsAepDHLnoHov+kKqbM0hzlbmfDQ8cuTkcatlteRY5Atgte7jlJwtwSohrENs9tzttiI2NNxHuA9h/gxrOctJ/ac0Vo2L83lDDHy6Ruw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OguZwGLT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FBhjcHAS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 22 Jul 2025 22:31:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753216308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hetnCMXtpudx5SS3SZrduYJl7SdapCss9YBCODWh/oc=;
	b=OguZwGLTIV/TP6wxTPTO2eIVfceWBS46xHtqKuhmXuJ6XFHGWi8SbtvpYVEg9RYX6965GF
	XdT10JTfkJRtuG2hCng7P4qxRhdKr7L/UGiy68zxaA0LuH+yeBiboqIVOo9nlGan88kIk1
	74RedlN8GWM7n/fR7Rsnl9Bw3M5fFHDolxb1m2G5qnsY/nt1zkcAQYGfYZzPNhIDDU+mlZ
	cH9FybSnQZXSljTPmL+AiBWEVHnAV91yDPOomBelPdNIQn62FOL6gL0GLKM7T0BXZWj/fY
	AMffps7nmiJIps8LbMcm5DrTh4s7GKze7AFS8l/eHxbZFdl+FDVoIaka+kcuUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753216308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hetnCMXtpudx5SS3SZrduYJl7SdapCss9YBCODWh/oc=;
	b=FBhjcHASNO3ItsJFzMJ6H2tfMBtfFTf8agVkhj7hfcm67sph+xe5Vpv9fiYP9wzUyvI4p6
	Q3FICOeelC/M+PAg==
From: Nam Cao <namcao@linutronix.de>
To: Gautam Menghani <gautam@linux.ibm.com>
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] powerpc: Cleanup and convert to MSI parent domain
Message-ID: <20250722203145.Y0vncMx8@linutronix.de>
References: <cover.1750861319.git.namcao@linutronix.de>
 <aH9Na8ZqrI0jPhtl@li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.ibm.com>
 <20250722092402.uMLOYoII@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722092402.uMLOYoII@linutronix.de>

> On Tue, Jul 22, 2025 at 02:05:55PM +0530, Gautam Menghani wrote:
> > I am seeing a boot failure after applying this series on top of the pci
> > tree [1]. Note that this error was seen on a system where I have a
> > dedicated NVME. Systems without dedicated disk boot fine
> 
> Thanks for the report.
> 
> Using QEMU, I cannot reproduce the exact same problem, but I do observe a
> different one. They are likely from the same root cause.
> 
> Let me investigate..

So the problem is due to the pair msi_prepare() and msi_post_free(). Before
this series, msi_prepare() is called whenever interrupt is allocated.
However, after this series, msi_prepare() is called only at domain
creation.

For most device drivers, this difference does not have any impact. However,
the NVME driver is slightly "special", it does this:

	1. Allocate interrupts
	2. Free interrupts
	3. Allocate interrupts again

Before this series:

	(1) calls msi_prepare()
	(2) calls msi_post_free()
	(3) calls msi_prepare() again

and it happens to work. However, after this series:

	(1) calls msi_prepare()
	(2) calls msi_post_free()
	(3) does not call either

and we are in trouble.

A simple solution is using msi_teardown() instead, which is called at
domain destruction. It makes more sense this way as well, because
msi_teardown() is supposed to reverse what msi_prepare() does.

This would also remove the only user of msi_post_free(), allowing us to
delete that callback.

The below patch fixes the problem that I saw with QEMU. Does it fix the
problem on your side as well?

Best regards,
Nam


diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
index 70be6e24427d..7da142dd5baa 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -441,12 +441,12 @@ static int pseries_msi_ops_prepare(struct irq_domain *domain, struct device *dev
  * RTAS can not disable one MSI at a time. It's all or nothing. Do it
  * at the end after all IRQs have been freed.
  */
-static void pseries_msi_post_free(struct irq_domain *domain, struct device *dev)
+static void pseries_msi_ops_teardown(struct irq_domain *domain, msi_alloc_info_t *arg)
 {
-	if (WARN_ON_ONCE(!dev_is_pci(dev)))
-		return;
+	struct msi_desc *desc = arg->desc;
+	struct pci_dev *pdev = msi_desc_to_pci_dev(desc);
 
-	rtas_disable_msi(to_pci_dev(dev));
+	rtas_disable_msi(pdev);
 }
 
 static void pseries_msi_shutdown(struct irq_data *d)
@@ -482,7 +482,7 @@ static bool pseries_init_dev_msi_info(struct device *dev, struct irq_domain *dom
 	chip->irq_write_msi_msg	= pseries_msi_write_msg;
 
 	info->ops->msi_prepare = pseries_msi_ops_prepare;
-	info->ops->msi_post_free = pseries_msi_post_free;
+	info->ops->msi_teardown = pseries_msi_ops_teardown;
 
 	return true;
 }


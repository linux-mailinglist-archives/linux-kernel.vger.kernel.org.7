Return-Path: <linux-kernel+bounces-845434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CAFBC4E4E
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 14:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6369E4EE415
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 12:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081F224DCE2;
	Wed,  8 Oct 2025 12:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O1FR00z6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1hKkeoZd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE85523D7EA
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 12:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759927346; cv=none; b=Nu+QuHxgirk4wpIWW9bjM1kN5IFxKYyxsQlK1Az87JRbN9g/rCVOl5F+86eN4mrXoLROQuD75+UmkMPL1wxsx/5jlMYgCOX+l8a14fcrCy4Zn1zEga+OM6DTva4HQSi6xqX3BWJ+eonRP3TpDOn8mXCtK1tCUmQOfS/tYWqYOAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759927346; c=relaxed/simple;
	bh=dLXbk05GIaWx/w3DF//cO6kLa3zsX9a0z/i92yVtAB4=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cEAklzQ7uEHn38UNh9k9dMarp1oYbcktuYWjF9rR6Oz6v2lunWSvTq3R72LPsoCbpiiodP1FtmJzlkwTzFSHcM7cFDh3H26VT+vdsJQhWv+W85jyOA4KUO+VT1Gf4k9WEhmQmpSMqAQCzx5ZvkfZtFVp1IZMRmJ4RXgCpock9uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O1FR00z6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1hKkeoZd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759927343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SEB371UVD7p9y6tuscumDyLeJGmkjZ51qI7OiaqfHYQ=;
	b=O1FR00z6YIWDmCnUQnYJ/rkfBxjhVctVN1ldKAHZuqM7AZMiiiTiG3xt3bUMJG2QdsLDnL
	+tYlj1dm5Bv83Fh28wjSU6yOWAXp5vmR4I4rjbevk5VdVgCmIATmCJ1bNYzq7wyK0tP1dI
	a8Tn9S3gmAftbWlWn4Wsc4zs7GMXXaJ69ld862jc+04trtrQVYKVC4G7cgKF1RfwflfvOH
	QZfapA14EaBcqDMo06wxXFwZARn65jZ3pQ9KAdN7GVYvlkJWVrfubNqZ8//+6DOtyacF6R
	B/klHx/5snA7XPOwcyzDEyq5MNhUFGExt8qY6utqqdouYZ6RVFaJLxPaTzs2yg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759927343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SEB371UVD7p9y6tuscumDyLeJGmkjZ51qI7OiaqfHYQ=;
	b=1hKkeoZdxe2Wz/9/ZnYPPSi8pqPSIkKVb++Fz2slv1L8s3IDPVuroDvdRTH0cnMrehC9fN
	IlBm9k7eXY5gX1Bg==
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, LKML <linux-kernel@vger.kernel.org>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, Gautam Menghani <gautam@linux.ibm.com>
Subject: Re: [bisected][mainline]Kernel OOPs at msi_desc_to_pci_dev
In-Reply-To: <878d7651-433a-46fe-a28b-1b7e893fcbe0@linux.ibm.com>
References: <878d7651-433a-46fe-a28b-1b7e893fcbe0@linux.ibm.com>
Date: Wed, 08 Oct 2025 14:42:22 +0200
Message-ID: <87wm55h8ep.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Venkat Rao Bagalkote <venkat88@linux.ibm.com> writes:
> IBM CI has reported a kernel crash while running module load and unload 
> testing on lpfc driver.

Thanks for the report.

I trust the below patch should fix the issue?

diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
index 825f9432e03d..a82aaa786e9e 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -443,8 +443,7 @@ static int pseries_msi_ops_prepare(struct irq_domain *domain, struct device *dev
  */
 static void pseries_msi_ops_teardown(struct irq_domain *domain, msi_alloc_info_t *arg)
 {
-	struct msi_desc *desc = arg->desc;
-	struct pci_dev *pdev = msi_desc_to_pci_dev(desc);
+	struct pci_dev *pdev = to_pci_dev(domain->dev);
 
 	rtas_disable_msi(pdev);
 }


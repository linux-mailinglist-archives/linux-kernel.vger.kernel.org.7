Return-Path: <linux-kernel+bounces-795708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C6BB3F6C8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B2F83BF175
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 07:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659C22E3703;
	Tue,  2 Sep 2025 07:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="Jx528d/6"
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D96B266580
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 07:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756798644; cv=none; b=F6s5jhoUXmcHHiaAAyScf2x/vjjMUV+/H16OuveDRTW7ca6tpvl9nMaPSkVo/VJyLhYbDQIcp1azWHcpxniwpZ3yK0HVHf/ZOkJg6kJCmIfzqrAaJQa4Y/XiC+oeAWM981Wr85l9uZp7ZBBUs6weJwpmKAkx6Jh1yPXg4yyW4Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756798644; c=relaxed/simple;
	bh=oMjXeyB4iI6Dmg26BM3e9rBlxLJ4xrOoViQErPfNlV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VMOtDqBAo8xnt6vRHC+AWHF/2CjyeHwPIKIaGNEPsCroi9a8LfqSP+Xl3Wddi8KH42pa517ttHJL3kgI3PkUpI0W9+ZJR4PijWSN1kXlZ62gBwjuZw+6FDiyd+TDqfreZOcwE9SwjbFAfnq6HwxHWzYoqnntGQZUQuqQH3Q91bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=Jx528d/6; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7EB0B14807F6;
	Tue,  2 Sep 2025 09:37:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1756798640; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=BN5rmZ3Xmdnj4GOMlRZw4tipJjzFnAUUFeXUaKQC9SI=;
	b=Jx528d/6GSON+C1FFzFQKq75vxXgJYj1aSooP3r6s4/coLwQUfKbT17XELsKIxTpjWvdOr
	LO8nOh6z5UnpmjWHUCc/6Hr8hcxYXP/N/2LhU7YhJcGd7EMMkSdLbq2M1jK/AAb+uCYPDN
	u0fTIvBiQIg+dqTOKuYvqjFnCXI6xzaUUjuCIrMcq/ILtbfiKwztXtm8sHWf1hFuSSsJsa
	gmjysuUCcBZAWIZMPgvOqXEs0zCt7bIAfgUAaOi59b+CnzoR/jWZIJRGenw6eNtb0U3peS
	qJ3XXO6jLsSG1TqMDiUNH5puNC6s1mis4mkd9UIHK+EBWBP4Wi5foRh0UrILnQ==
Date: Tue, 2 Sep 2025 09:37:17 +0200
From: Alexander Dahl <ada@thorsis.com>
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: State of the UBI fastmap feature
Message-ID: <20250902-life-domestic-c341a8992cac@thorsis.com>
Mail-Followup-To: Richard Weinberger <richard.weinberger@gmail.com>,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250902-yarn-from-020874b4da63@thorsis.com>
 <CAFLxGvzO2yszspJtd_A3BSTCRNSF+ts_5+2aMkNksxM48DYEwA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFLxGvzO2yszspJtd_A3BSTCRNSF+ts_5+2aMkNksxM48DYEwA@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hello Richard,

Am Tue, Sep 02, 2025 at 09:23:04AM +0200 schrieb Richard Weinberger:
> On Tue, Sep 2, 2025 at 8:00 AM Alexander Dahl <ada@thorsis.com> wrote:
> > Hello everyone,
> >
> > after using UBI for almost 15 years now without fastmap, I'm currently
> > experimenting with that feature.  The help text in Kconfig menu
> > (drivers/mtd/ubi/Kconfig) still says "Experimental feature" and
> > further down:
> >
> > > Important: this feature is experimental so far and the on-flash
> > > format for fastmap may change in the next kernel versions
> >
> > Is this still the current state?  I can not remember seing any patches
> > touching fastmap in the last time.  Are there plans to stabilize this?
> > Will there be changes in the on-flash format?  Do folks even use this
> > feature?  In production?
> 
> I don’t expect changes to the on-disk format, but the number of new raw NAND
> devices being introduced is now close to zero. As a result, the user
> base is very small,
> and subtle bugs are likely to remain undiscovered.

We are still using it in cost-sensitive products.  Those raw NAND
flash chips are a lot cheaper than eMMC or even NOR flashs of the same
size.

> Fastmap does have users, including in production,
> but I don’t have concrete numbers. And I don't know their workload.
> That said, Fastmap should work but I still anticipate performance and
> runtime issues.
> 
> I guess your motivation is reducing the attach time?

Indeed.  Need to reduce boot time here, and UBI is attached twice.
Once in U-Boot to read the kernel image and then again in Linux.

Greets
Alex



Return-Path: <linux-kernel+bounces-828256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E19B9444C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 07:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 695497ACC1C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 05:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD31526E16F;
	Tue, 23 Sep 2025 05:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uFXm8wMN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RVp22cK1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5840178F20
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 05:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758603807; cv=none; b=op6k/fZEUxTOQXUSmI6MoEDsT6sTFmZP/Ck5uE0tiKx/9V3XIteR4qNxkKzS4FW8RnJqcBzfX5pf1hv3udpaFpkhojgRr2XBj/gCkZT9cE+lrlcOMt8nwHPUWWFPyGjGrNLmqIYHP2GZVt7AA9DJixq85fQI6CwipYBkybZvWu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758603807; c=relaxed/simple;
	bh=uOY1GGFo0uQy4Ubq/opMB+IeU97gbHGIlffkHsb6CZQ=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gBbA5tobPiqVUOElWrwpAEecCqjNwNm38EnYsaWI2PzjWn0b53eXS4EJaH76VKIlhX3YStHzGJfUN+wxvAqKhlbgatETkuU2ANlK7crdAAUhqx1sD692ssMy//m5MR6v2XY6x/WB0cNL7E5kHmi5KAeBwNMGdNlOpdHiA4dt6a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uFXm8wMN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RVp22cK1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758603802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uOY1GGFo0uQy4Ubq/opMB+IeU97gbHGIlffkHsb6CZQ=;
	b=uFXm8wMNJKtckl+Fm0Nw6vLfMJfkd0nKggUHYZrCms2/jxnOuDNHkicdaIGbukfErQ4cI/
	ZgPmmhE7huAHEEW0CqlxKzOEHvvq+dmNewhpObuFHb/jfNtKF0VLK9Ska747HHOWNOryJA
	Xqc8nIBLWxBJJWztvCh40P6PUmemE1a/cvylDfK24ogj+JGDbqLeHYeDRwbZx4Qs8nDx++
	u6A6HotlCzCBiyQsQCE9BzTOwzkzcKywJFhvo2MhWpYesESzwek806mcIadenV6necAPgB
	bsWUb7/iJ7r1KwHcSMzgnWg27PYN9GQdKU+QPZN3NNapKbmwvw9l3XvVgh0yAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758603802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uOY1GGFo0uQy4Ubq/opMB+IeU97gbHGIlffkHsb6CZQ=;
	b=RVp22cK1k9+3SSiBbAonOGTtJmrsmdU0c4F2L3tXokxc6TPNpEEsdTpPGhrmkzUuGVM9G0
	ogRJCcmywVervOAg==
To: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>,
 linux-kernel@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] genirq/msi: Remove msi_post_free()
In-Reply-To: <20250916061007.964005-1-namcao@linutronix.de>
References: <20250916061007.964005-1-namcao@linutronix.de>
Date: Tue, 23 Sep 2025 07:03:17 +0200
Message-ID: <87wm5p4v6y.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nam Cao <namcao@linutronix.de> writes:
> The only user of msi_post_free() - powerpc/pseries - has been changed to
> use msi_teardown().
>
> Remove this unused callback.
>
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
> This patch depends on the powerpc/series conversion patch, which is
> currently in powerpc tree:
> https://lore.kernel.org/lkml/c7a6d8f27fd217021dea4daad777e81a525ae460.1754903590.git.namcao@linutronix.de/
>
> I think it is most convenient to apply this patch to powerpc tree, if
> everyone is okay with that?

Maddy, do you mind picking this up?

Nam


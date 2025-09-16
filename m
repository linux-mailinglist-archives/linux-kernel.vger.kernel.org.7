Return-Path: <linux-kernel+bounces-819397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEDAB59FF8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 20:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0835A581592
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD72C2D0C89;
	Tue, 16 Sep 2025 18:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rlizjEY5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I3Yh1UNG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A124A29D280
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 18:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758045724; cv=none; b=kmW8kPkCZlH4TtZVFsCSDdHseuVbln4Q8B9+ZL7CbcG2wEY7q07d8XDQ2gkmGGKMetMVRDYiOH0nO+CungV/Ph1FXY2+1A0/0BLxzrA7adBfa//686LnFxyORIgEdRUxU+7CHmOk/jHmKL0al3aTsx4CBLAgpzlerr/ue5udTUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758045724; c=relaxed/simple;
	bh=rLUOJFZUImaUfo6SdetdAgOJfxOPATvzty/XKsifFnA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uq1r6BDhKtbeioRhjlm9Fn1ZllbqAcunoC/+G5/9nj4gp2NKyS5taLIELu/qI04rMirddk9kJtZo6srWElk/i5LgKSy6f1XHvJsdWfiaMmnmYY0MvpkLUEgzZKbp+N1BAcsjuDbBCGkQfpYKPnhy391Uc8Qew41ANJtD4pxXYZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rlizjEY5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I3Yh1UNG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758045719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rLUOJFZUImaUfo6SdetdAgOJfxOPATvzty/XKsifFnA=;
	b=rlizjEY5wByJN9OlvYx1jL11IWtDhp6F60MRFS8WZE3YA9wFEAHVBkH1RIaGaMv/QQoOFh
	fzbbK23DzyeTlo8nGjAEsIyJKhauBMM+H7Q++grmwg2gOy3x4hqWbpvQmwnWUGuGp4iyyv
	pu8DgvXl9kqh01D5Yv7Bj90iuqr+Zp+zXJykBWMvdAqxqAzqGKRNmIjGByo+WFxojTL0SR
	UTPzwx+aSzHl2kTK2PsiTQtP8KjtyKqsZ8iW8/nYITuklCpjcahl6h/DB1RWcBX5UJ3a0l
	hjumCkdnxhnU1rtwUCGmZeE9gMr4sDWW00HAT87wkpNofBxC2mfFpNquGo5SVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758045719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rLUOJFZUImaUfo6SdetdAgOJfxOPATvzty/XKsifFnA=;
	b=I3Yh1UNG5fgJcJC/vuiQLI4n8j9+NvVpTX6AYL1Y2vq6+VrlnSSOpesFjngYDEE/Owb7a2
	DchTBisnkFxe2ZDg==
To: Nam Cao <namcao@linutronix.de>, Marc Zyngier <maz@kernel.org>,
 linux-kernel@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 linuxppc-dev@lists.ozlabs.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: Re: [PATCH] genirq/msi: Remove msi_post_free()
In-Reply-To: <20250916061007.964005-1-namcao@linutronix.de>
References: <20250916061007.964005-1-namcao@linutronix.de>
Date: Tue, 16 Sep 2025 20:01:58 +0200
Message-ID: <87segm9syx.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Sep 16 2025 at 08:10, Nam Cao wrote:

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

Yes.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>


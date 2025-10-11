Return-Path: <linux-kernel+bounces-849257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A0CBCFAC9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 20:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3612F4E5D30
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 18:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0284A27D77B;
	Sat, 11 Oct 2025 18:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="g3MNn1t2"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6881DA3D
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 18:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760207294; cv=none; b=PPxRarHurXitjEZgH9/rU0o57Sqzmy/phOu64+AsZsKrn1/lXxNIfbhNcAvgdrzaO67OmdPDMlJzaofS3sjC4b4qyXdPzODlmBDJCZwRd2/oTWX5antsE6+aJ9uHAKAuKXkAalRRBvcBzCIWyNkPIeOQa7gFwaIDOowraKKSpiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760207294; c=relaxed/simple;
	bh=kmdvHYPdUVi3OYcOeLGIQRH3yoObyBCk0G1VPZF5GhE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G5I9nWgKLB7tJ9opC5hEcn5in0OvJJ0TU+TWAdIl6z7RJwbgVTRzFH8/vd2izK1G63J/ee7E8apWFfrhRuFupg2gPfSh51HSmMrflB5g2U2e6b839XZgnrSiAMT6FzCIhUvcvaN/KJ3eJogVVNZ1NzQENZsJwH6805u/3BsfQVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=g3MNn1t2; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8DDBC40AAD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1760207289; bh=kmdvHYPdUVi3OYcOeLGIQRH3yoObyBCk0G1VPZF5GhE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g3MNn1t28BCPC1VnqDoC4rXkcjIpbUiaMGGRQdEAxX/1qNswbHCiYP7G+tmuiPNQa
	 Jg6Bs+7VrrTV9CdB5MRL87s+wPWX47IhjWvemRAEYdZe8T34v2bJ06dYGpncYZSL85
	 17ZEzcg1VFeX8sKDGG3q1gpabQBDo8fcI1rzL+o1oPPrqW0CkE+Pt5QD8kzsAmawC/
	 zoibCMDsPZI346N+1XQ2eFaD4lQhjI+pfi44NC84zKCEYByyuhuNkZTWDfi5vhPGkf
	 3Y5X9cBIrFDNUBUHL2mbQ6Uh1S3pgtKBuPfM1Q9uu88iQmvdqBLxpLvsbmq+/DDxZU
	 zaMxpRaDkho9A==
Received: from azalea (unknown [IPv6:2601:18c:4300:1ed0::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 8DDBC40AAD;
	Sat, 11 Oct 2025 18:28:08 +0000 (UTC)
Date: Sat, 11 Oct 2025 14:28:04 -0400
From: Daroc Alden <daroc@lwn.net>
To: Waiman Long <llong@redhat.com>
Cc: corbet@lwn.net, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@redhat.com>, Will Deacon <will@kernel.org>, Boqun Feng
 <boqun.feng@gmail.com>, "open list:LOCKING PRIMITIVES"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lock: Add doc comments for spin_lock_irq()
Message-ID: <20251011142804.29da9591@azalea>
In-Reply-To: <4482c890-f082-4946-b6ab-a7b57b02db22@redhat.com>
References: <20251010215403.743811-1-daroc@lwn.net>
	<4482c890-f082-4946-b6ab-a7b57b02db22@redhat.com>
Organization: LWN
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 10 Oct 2025 23:15:50 -0400
Waiman Long <llong@redhat.com> wrote:

> On 10/10/25 5:53 PM, Daroc Alden wrote:
> > The commonly used spin_lock_irq(), spin_lock_irqsave(),
> > spin_unlock_irq(), and spin_unlock_irqrestore() functions do not
> > currently have any documentation; this commit adds kerneldoc
> > comments to these four functions describing when their behavior and
> > when they are appropriate to use.
> >
> > Signed-off-by: Daroc Alden <daroc@lwn.net> =20
>=20
> This patch looks fine. Just wonder why just=20
> spin_lock_irq()/spin_lock_irqsave() and not
> spin_lock()/spin_lock_bh() as these functions also don't have
> kerneldoc comments. Also spin_lock_irqsave() is a macro and not
> actually a function, maybe we should mention that in the comment.
>=20

Because I had to research spin_lock_irq()/spin_lock_irqsave() for a
recent article, and therefore felt confident that I understood how they
behaved and what should go in the doc comment.

If you =E2=80=94 as a more experienced kernel person =E2=80=94 can describe=
 how/why the
_bh() variants are used, I'm happy to add doc comments for them as
well. My current understanding is that they interact with whatever is
left of the "big kernel lock". Is that right?

--=20
Daroc Alden (they/them)
Editor, LWN | https://lwn.net


Return-Path: <linux-kernel+bounces-850295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D67FFBD26B9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A3C9C4F0112
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778A6238D42;
	Mon, 13 Oct 2025 10:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1li8TwzZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aPGeZ/XY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6FF1F2C45
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760349646; cv=none; b=fEjQfFYYYpcQSqrgX7EuyC13R4tS1MeMKXNYApyEiQHvLgEDmIfmLI7kJ6Saiomr05Fmf0g3GiqyZZkIjiL/mYGJ7VFEPRAw0QflpDIWrfsk6le0ZLrpjpgmtAGh4+l/+bXSFVxSbZR4K2RPpx9yIhYN2aKWAlZAP1M5KWshRbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760349646; c=relaxed/simple;
	bh=Sa0hyLl/CuAPqN8piNUXRod9YatWS5sLJjv2OTB79g8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OPyxCULsNs0A8p0AyxUevBitx+VddiVMpeUH87JvNqLG7cgJ1ilOROEU5EJCvJZKr5Ug1WlhpBbb54o7H0atqvE0WLM8LXHEK+5XMID4VFXZOAJ++ppRCgpawszvEuMUrWfvEsr/WcGx3i6NEE1bM8QXa7aWT41oFS9CXYcO34U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1li8TwzZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aPGeZ/XY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760349643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sa0hyLl/CuAPqN8piNUXRod9YatWS5sLJjv2OTB79g8=;
	b=1li8TwzZhoICH9uuKMFiVylAENaNEecMvoJE4L/hJWX0yks3goxmK5aCyM8L3Lk7tDpWOP
	BFasLTqJbp7IRj1C738QUlRBfGaX/T6Xu/INu7xA0xpkzFkK1FA/BpsJvGxFLnst0N1ufR
	fvkjBa5T8jfYisZWR4cHHYA8xbdvNxxBCi1twl9TwwNie+dwdUy7wOAoCqwW2qyVfiI4k6
	VVLMMhBOWYLSRJDz7zQRchVYCBQibBLQREC9UfFEZ+agxKImmrL9Kks4wt6sK1pHnWanWv
	iWnKl6aV+fM+QQrlC1XvzasgnqDbJmY/dxmOFI2b1osfqn67B1ZiVfuRcB/9xA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760349643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sa0hyLl/CuAPqN8piNUXRod9YatWS5sLJjv2OTB79g8=;
	b=aPGeZ/XYOy7puJGDMk1N9AIu2A71OJ+SNAdl88f+tdLjG+uu3h9AgJbCcHKYhlFN6F2j+l
	ehc8X3iOzGsiaDAw==
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 christophe.leroy@csgroup.eu, tglx@linutronix.de, maz@kernel.org,
 gautam@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, Linux List Kernel
 Mailing <linux-kernel@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [bug report][PPC]: rmod nvme driver causes the kernel panic
In-Reply-To: <31838b50-e420-405a-af23-6c6ede281386@linux.ibm.com>
References: <31838b50-e420-405a-af23-6c6ede281386@linux.ibm.com>
Date: Mon, 13 Oct 2025 12:00:42 +0200
Message-ID: <87h5w3f7ed.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Nilay Shroff <nilay@linux.ibm.com> writes:
> Hi Nam,
Hi Nilay,

> On the latest upstream mainline kernel, I am encountering a kernel
> crash when attempting to unload the NVMe driver module (rmmod nvme)
> on a POWER9 system. The crash appears to be triggered by the recent
> work on using MSI parent domains, discussed here:=20
> https://lore.kernel.org/all/cover.1754903590.git.namcao@linutronix.de/

Thanks for the detailed analysis. This should be fixed by:
https://lore.kernel.org/linuxppc-dev/20251010120307.3281720-1-namcao@linutr=
onix.de/T/#u

which currently is in powerpc/fixes-test

> Possible Cause:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> This looks like a cleanup ordering issue introduced by the recent MSI par=
ent
> domain rework. The PCI/MSI teardown seems to assume that the MSI descript=
or
> remains valid until after the domain teardown path executes =E2=80=94 whi=
ch no longer
> appears to hold true in this sequence.

I think the reason is more idiotic than that, the msi_alloc_info_t
passed to pseries_msi_ops_teardown() is always all zeroes, thus we have
the NULL pointer deref regardless of the sequence. See the patch I
mentioned.

Nam


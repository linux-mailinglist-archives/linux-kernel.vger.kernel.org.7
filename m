Return-Path: <linux-kernel+bounces-864669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EE2BFB4EF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 44F154E8B43
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC38319851;
	Wed, 22 Oct 2025 10:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Dx1tBiyq"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED93C316183
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761127651; cv=none; b=VjUt8hKOwbDTLGoy4gAlv8fFRjG1J1lGYYy51cenDmAU8q360khT+61I5HWC8IW1z+qM9KGKWJxRxX/F31G9MxJsLjqj/yrlAKjN42DqMfmhqOdKI4/zjMAUJ7zPwYhAbV+f2gnowoGPDBiBpcdsZy0fxGkfziMMRLTH6xE0RWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761127651; c=relaxed/simple;
	bh=iFjjzRCUrFEqnFFuf8dtrADntolucnbypUul4hlI83E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NuukZMYcgH9OBJlgmGPHc+vMO3oNqWKUVfQjvFyjgnVNTkOc6J6d8zzQXHM8SsZzkC00Ij+C9Uvi6S/fHPNLaYsTIan4uVnpBNs5+OthM/Lck8uffSp0Ap67bdNjE1rXwz3cIVuwJk8vFIQjTVFNJhdvfq0W32w63A1npZvjt1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Dx1tBiyq; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 84814C0B8B3;
	Wed, 22 Oct 2025 10:07:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 44C59606DC;
	Wed, 22 Oct 2025 10:07:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 11C60102F2393;
	Wed, 22 Oct 2025 12:07:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761127647; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=iFjjzRCUrFEqnFFuf8dtrADntolucnbypUul4hlI83E=;
	b=Dx1tBiyqF0HvcOXwH/oDh9QgXjdUyAjD5CG6wdkoHHp9duLQx6526AU5IsWJ7SHkuFx23r
	VcY62jBSz6etYxQvTc1kacbaL2+CHOtMzTuBjgRQoD61VfroK6ytrnUPJEffcpZz9VZtoE
	1pQgVNJQem5FQewPJZXa/dqBUxaQq3+5f7orZjC6Kj7Bs44V1aOM/3stV7mafxExABBcUP
	ana+cc9LZ2YQihtmSPFkloCOuIGGan6iZ0iGH45or8eXunorRy1CUo+KebGoK3MGK4t4OP
	DE1JxoGOC1SzcGQkLnFJGgK5JCZSEka2u7kix1st2QXLwA8hyyq9Q6I+wufaAQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Alexander Usyskin <alexander.usyskin@intel.com>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>,  Reuven Abliyev
 <reuven.abliyev@intel.com>,  Lucas De Marchi <lucas.demarchi@intel.com>
Subject: Re: [PATCH v2] mtd: intel-dg: wake card on operations
In-Reply-To: <20251021123246.3629282-1-alexander.usyskin@intel.com> (Alexander
	Usyskin's message of "Tue, 21 Oct 2025 15:32:46 +0300")
References: <20251021123246.3629282-1-alexander.usyskin@intel.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Wed, 22 Oct 2025 12:07:24 +0200
Message-ID: <87wm4ns10j.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Alexander,

On 21/10/2025 at 15:32:46 +03, Alexander Usyskin <alexander.usyskin@intel.c=
om> wrote:

> The Intel DG cards do not have separate power control for
> persistent memory.
> The memory is available when the whole card is awake.
>
> Enable runtime PM in mtd driver to notify parent graphics driver
> that whole card should be kept awake while nvm operations are
> performed through this driver.
>
> CC: Lucas De Marchi <lucas.demarchi@intel.com>
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> ---

I am curious to know why this now works, whereas in your previous
attempt (which had to be reverted) we had to do a lot more.

Thanks,
Miqu=C3=A8l


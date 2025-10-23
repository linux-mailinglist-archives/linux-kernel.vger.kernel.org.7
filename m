Return-Path: <linux-kernel+bounces-866299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDFEBFF6A0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A5C94E6BAF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 06:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9FB2749CA;
	Thu, 23 Oct 2025 06:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LajRDVY0"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E4426A08C
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761202494; cv=none; b=s2M8logQUeWzYJ+aPu4RrTgFm5mCmUKgSwmTrl3mLkq4S0JGsvTzZjS6aLmVUctdTd5TIvOz+zgwsLzBhiV5H2NMe8iENXuku04F2eRZ2+TN6XIa7I1UxN8N5usM+/nQTkPQzuV79WOpT8tksfxptZQU9hcF+KdO4H+nsNU1Lxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761202494; c=relaxed/simple;
	bh=yd7qFoK29VDAPrdMJ/zhOki4NmhFSyQsEwV9ZsTr1K4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uQ5StdV2Oe3jx5EHKPoQurYr1rcp2H/PyHB1u02qW6YCiIIYeHyGvYGJ9eeZt9GiwBgUGMZ54OWHDhmCtTb1hU9fafFnmdA7kX3jlVPKaDp8geHctOQJl2IOcA9bRgcKwMQGJJzI7RT8r4AmynMk12UEiYo/4pM2zdjZhmacRso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LajRDVY0; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B904D4E41290
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:54:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 76C9D6062C;
	Thu, 23 Oct 2025 06:54:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 72ED2102F2408;
	Thu, 23 Oct 2025 08:54:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761202487; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=GS0cqy3g8XoZ9muADSAiYyE0/Ek9+J4x0l2wKijcgtA=;
	b=LajRDVY0S65NQ81Ea8F94oP4KJOPMDu1SEEZi9hPC1F6ox7Dh1sCVe5esRWrY24hclUAyh
	cp6qOoDQlwjJOInt3iolbOGexU6J5CTO7TCdX0bJv0omu6s7+c9V7IwRDVnXctvasVISgd
	kcSy5CRf9Fku619uLxjLXf6L721U1Wnf68AdWzsFshWLBHkqwK6mX7jyaT5J49uzkKsx9G
	QZ2nCtIzmZep3QFFzZRDcpJ3HMyeNewp7/NBfFTDOYtIkv7HsfnxiaAeUrlW1Jkw9PdVRD
	NsAAA5fAxRK6WRAsBolngqtwRSR5njZIv3SoXdWsegg8TwYy/kNkGUFQH/p17A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Jay Xu <jayxu1990@gmail.com>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  avnerkhan@utexas.edu,
  rdlee.upstream@gmail.com,  kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] mtd: core: Add nand_id sysfs attribute for NAND devices
In-Reply-To: <CABcGJDxxGSDVc9TPcTMR_7abreBchHEKHsqtfZVQ5m+0nFhJ1A@mail.gmail.com>
	(Jay Xu's message of "Wed, 22 Oct 2025 11:53:41 -0500")
References: <20251007224049.2798233-1-jayxu1990@gmail.com>
	<20251014192455.4007534-1-jayxu1990@gmail.com>
	<874irrrpbp.fsf@bootlin.com>
	<CABcGJDxxGSDVc9TPcTMR_7abreBchHEKHsqtfZVQ5m+0nFhJ1A@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Thu, 23 Oct 2025 08:54:39 +0200
Message-ID: <87sefaqf9s.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Jay,

On 22/10/2025 at 11:53:41 -05, Jay Xu <jayxu1990@gmail.com> wrote:

> Hi Miqu=C3=A8l:
> Thank you for the feedback and suggestions!
>
> You're right that the current implementation is raw NAND specific. I can =
look into extending this to support other NAND
> types by moving the functionality to the NAND core=20
> layer and ensure the ID is populated at probe time.
>
> Let me know if you have any other suggestions/questions,

Not at the moment, I'd like to gather feedback from other MTD folks
before we go forward. Sysfs is part of the stable API, we must be
careful.

>  > Reported-by: kernel test robot <lkp@intel.com>
>  > Closes:
>  > https://lore.kernel.org/oe-kbuild-all/202510120356.STGKDkA5-lkp@intel.=
com/

Just as an FYI, these do not make any sense in a contribution like
yours. Include these tags if you are fixing something that is already in
the tree. This is a new submission and it is not a fix so "reported-by"
shall not be used.

Thanks,
Miqu=C3=A8l


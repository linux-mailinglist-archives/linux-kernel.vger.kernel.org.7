Return-Path: <linux-kernel+bounces-624911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E22FAA098B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 13:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE4FA1B61999
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 11:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791E12C17A2;
	Tue, 29 Apr 2025 11:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IiG1j8B6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D43155333;
	Tue, 29 Apr 2025 11:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745926186; cv=none; b=uS/Ccc7wrzeHu1/RGCoeG7cZt3gZZNFxm/6rAQ7fKR4A2YCVDQVNk43I0M7CHRA09SMT4skrNlRj41YVAlJLMMtayp1mtJz/OteiESIPlw6CUTX3clapDnso07Z7Y/+K9eEva9I/iz+Elh3ZOUZBmLeY3awBH7tB/+bIgrumsDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745926186; c=relaxed/simple;
	bh=HTn3m6fFq06EtCe3wTDF5t/gvtQLUnvgZ1xSpwDOx7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPZa2ArJFgstceXxv2nSwWwC2qqQpBJemC90IYx40M+ieOFBpV0feGjoJ9TsX9utMvyrqORR3BazO8HPy8awLg5Eo9rtgb1Pl5ZzHMOxZ/7dEWzGVuCgMlOvEstNqSRDiPoU8qq3yqhA5vCGm8DMDqxwBiF0lcr1HyDxbgDeGNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IiG1j8B6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FEF0C4CEEB;
	Tue, 29 Apr 2025 11:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745926186;
	bh=HTn3m6fFq06EtCe3wTDF5t/gvtQLUnvgZ1xSpwDOx7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IiG1j8B6KSfhPLKnhS1CgFATOXSekJPyfpkNSEG3xDhOscsrCi+SbqMXkYmy01St0
	 ig1Hq5mkOL8kXAwrangpms8c3gcaSYTU/XGOTjiWE1F/G8bMEq7gqDYX7VlHqPYqUG
	 lUsom8yb/+CO7q/nqCffM/9hICbG3Vfo8iuRDxIKJmfi47h8Fva3Nq9/xfFkIbvGRl
	 Juppc5ouNGqXM1B3DlU2Dm4bpB2JRpr8ckR/NLXg1O9j69yI/sQCpo5npSOhe7PU6E
	 51dcmge9uMxjHsgzZ15OXO3w9FJdExv80UPVVgPPyGiZC2930e8VFBhUzvFb9cwHEl
	 9nG9Wa+1bmtBg==
Date: Tue, 29 Apr 2025 13:29:41 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Akhil R <akhilrajeev@nvidia.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Laxman Dewangan <ldewangan@nvidia.com>, "digetx@gmail.com" <digetx@gmail.com>, 
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, 
	"wsa@kernel.org" <wsa@kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, 
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v2 RESEND] i2c: tegra: check msg length in SMBUS block
 read
Message-ID: <eetu2jkcnaqvxyvto2vvslmducsecewtcnoktuxczjeaohqm3i@khc33hutl7ac>
References: <20250424053320.19211-1-akhilrajeev@nvidia.com>
 <j3jxuuwu2joyn6jsfa63lkkuwqazd2mpeki6gamdpktllhpkhv@tfoqnztsa7zw>
 <aBBE5mgqGk0yXQWN@shikoro>
 <PH7PR12MB8178416B09D217B77CC43C04C0802@PH7PR12MB8178.namprd12.prod.outlook.com>
 <aBBmmNlM3_zjNMC3@shikoro>
 <PH7PR12MB8178A35A3D51F6BE3D1E6888C0802@PH7PR12MB8178.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR12MB8178A35A3D51F6BE3D1E6888C0802@PH7PR12MB8178.namprd12.prod.outlook.com>

Hi Akhil,

On Tue, Apr 29, 2025 at 09:51:14AM +0000, Akhil R wrote:
> > > Yes. We have had issues where the client device sends '0' as length if
> > > the
> > 
> > Can you reveal which client that is?
> 
> The issue came from a downstream change in the file 
> drivers/char/ipmi/ssif_bmc.c in the OpenBMC Linux tree.
> 
> > 
> > > transfer is terminated abruptly at the client's side. The actual fix
> > > is in the client's driver, but this check here would ensure that the
> > > master does not run into trouble either.

I took it anyway into i2c/i2c-host. Better redundant than sorry.

Other drivers are doing the same check, so for now there is no
point in being picky.

I might try to clean things up later.

Thanks,
Andi


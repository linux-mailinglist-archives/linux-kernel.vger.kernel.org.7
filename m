Return-Path: <linux-kernel+bounces-799570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C28B42DB6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 01:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99D0916A4F2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 23:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE1C31CA5B;
	Wed,  3 Sep 2025 23:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pWuz7rO9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C27E2D0621;
	Wed,  3 Sep 2025 23:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756943717; cv=none; b=rflFXwX4mhnXFWfbWNJEoKxtH8BteWifzSt9nJGkcnj+S6/hViKPM49YrDNW7VxS4nfsES3xCzWpxJoWJQ3Tpv4G2PGiSnt4AGZAqELCVl+4rJlMinSo7IIMiaepcMyhCcn+v8k138pUxbRLh/twoha/aUs3RvbLoU9SsYsyBZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756943717; c=relaxed/simple;
	bh=stPXXt3aFflck7RvYXXDEOtlDLuJaXPiZ7XrvWIPpUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJUw26LdsjBKCWxTQjB9B5S1EOz1qFNSOuTj34zWj3oJ7ePmc+LPwE5NlnWYvM052JB5K4pZ5OtQyBB41WvTGBcH8N7Z3E6ONl6JwT3+089kN2iJ3K31XrfCkVdfpvK5rdw8Op8tfCS6jFqlbKoiU/Qo6AX2sr6PN1JCz+9DM2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pWuz7rO9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C525C4CEE7;
	Wed,  3 Sep 2025 23:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756943717;
	bh=stPXXt3aFflck7RvYXXDEOtlDLuJaXPiZ7XrvWIPpUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pWuz7rO9Eigxxa53nEhXgXyDnAKPBgoLueFy7yrL/Q4grA5dTleI0hnfq1Hn+A4i8
	 KobenaNzrJyYILgl+mDA1m0mN7TQfC9AmVEf+wwYB0MwS6w3v3QP7Pkw2kDUPjjJ/j
	 xXBXXBv+flBVrCIdzOmiHfkRHUqOeaWWpHv8mbyVa2HaeP27ZqNZ547FLFe7pCMkV3
	 +2geir6AWlxrcjlgd5x0cDVmQXHL1us9aZ6SlE4v2CMiJNHM4E5ZJXr1FdXhez9aGI
	 oy9tmMYucXzDMtveOjpzvqi69yuEwjwDGIm5G6yKjcbErI4HxhZeMWRdraswQ7PSN+
	 ReTtRBwDUYfjQ==
Date: Wed, 3 Sep 2025 18:55:14 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Cc: broonie@kernel.org, patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, linux-sound@vger.kernel.org,
	krzk+dt@kernel.org, shuah@kernel.org, zhoubinbin@loongson.cn,
	drake@endlessm.com, KCHSU0@nuvoton.com, matteomartelli3@gmail.com,
	katsuhiro@katsuster.net, lgirdwood@gmail.com
Subject: Re: [PATCH v2 1/3] ASoC: dt-bindings: everest,es8316: Document
 routing strings
Message-ID: <175694371395.3386752.1635490926247373183.robh@kernel.org>
References: <20250903160119.83625-1-jihed.chaibi.dev@gmail.com>
 <20250903160119.83625-2-jihed.chaibi.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903160119.83625-2-jihed.chaibi.dev@gmail.com>


On Wed, 03 Sep 2025 18:01:17 +0200, Jihed Chaibi wrote:
> Add a list of the es8316 pin names to the binding's description to make
> it self-contained and improve the user experience for board developers.
> 
> Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
> 
> ---
> Changes in v2:
>  - Rephrased description to refer to device pins instead of the
>    driver.
> ---
>  .../bindings/sound/everest,es8316.yaml           | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>



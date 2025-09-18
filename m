Return-Path: <linux-kernel+bounces-823241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4506B85E3A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BD501887BEB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5448313E17;
	Thu, 18 Sep 2025 16:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEcPNDJz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336D5221546;
	Thu, 18 Sep 2025 16:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758211364; cv=none; b=oUStM0zIMUj6dkTMgcum7FBJuxOPgTmr5W3u+WBnUvLW9BpaXLFD8K8FGcnojZAlAc7+TjVlCMiSKioPANE0IzqV7ftG27biSBkpRhwYSV7xt+ZnAjHmpX1Z3YAuPKoVr5z5adUiGGW+YA3p+ayNC1eVjbPoVf4jAKnMIuJLk1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758211364; c=relaxed/simple;
	bh=IivB8AXYvbvkTVSSpjLIk3suZxjGmXbht1xnX6maREA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d9yBFh/ZweNu3hRGjsPlo/l1WIYCKL//4AI9gOsN9VH6c2DspmuZevL6+qPwVqxwbfbRzK2CCOQxWWaiqlKdulZkcwKsUDU6Wx17Lhtr6UIfQmZCE3XhdDA5eCSciiPd3j4aRuNUHfKV8pnyxEn0MwkM6AamdL9wrvwrpSLIxjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEcPNDJz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1633C4CEEB;
	Thu, 18 Sep 2025 16:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758211364;
	bh=IivB8AXYvbvkTVSSpjLIk3suZxjGmXbht1xnX6maREA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AEcPNDJzUB3Hs4On0rA3n0f3Ol8FNKZ0UlUmB0tkyM2hrgspMOO8Tm2XbiuriGKIN
	 Ubh6VrJ5ORyIpaX9LjrZniUV0a78U3erbGk5XIp1vnIZ3g0y1pXK9Vxs7mMs5JWXZX
	 jTrlMVw93PiNQ1eFWre42WQa2xVmpG2QQKKmqA/dmJpjHOPKHrf/wn9DpfjJNpFdEk
	 fB1lmKCEr+sVH1IrgNiJYaokPAa5vshFfk3ttlcIVY4d5YEu/6ewQSrCeCVUcgad++
	 J8n97wj+YqiJCPLQcSV+acT1YvUAvXA80Fw/0UIlFDyOlFn6fQshL95iKQnzZnJ3ox
	 fJzfeK130jkdw==
Date: Thu, 18 Sep 2025 06:02:43 -1000
From: Tejun Heo <tj@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux cgroups <cgroups@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrea Righi <arighi@nvidia.com>,
	Johannes Bechberger <me@mostlynerdless.de>,
	Changwoo Min <changwoo@igalia.com>,
	Shashank Balaji <shashank.mahadasyam@sony.com>,
	Ingo Molnar <mingo@kernel.org>, Jake Rice <jake@jakerice.dev>,
	Cengiz Can <cengiz@kernel.wtf>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v2 4/4] Documentation: cgroup-v2: Sync manual toctree
Message-ID: <aMwtI44JEXFuNPA5@slm.duckdns.org>
References: <20250915081942.25077-1-bagasdotme@gmail.com>
 <20250915081942.25077-5-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915081942.25077-5-bagasdotme@gmail.com>

Hello,

On Mon, Sep 15, 2025 at 03:19:27PM +0700, Bagas Sanjaya wrote:
> Sync manually-written toctree with actual list of sections in the
> automatically-generated counterpart.
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

This doesn't apply to cgroup/for-6.18. Can you please respin?

Thanks.

-- 
tejun


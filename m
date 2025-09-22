Return-Path: <linux-kernel+bounces-827996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B64B93A3D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 01:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D15292E10C4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 23:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737402FE05D;
	Mon, 22 Sep 2025 23:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HaY+8g3Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D0C286883;
	Mon, 22 Sep 2025 23:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758585058; cv=none; b=rnUX2WPqAd1px6HkH4lF6/ALluu/ThKlXuQJnN2IqLLxKO274gCz1oXyTeXcqAl1gdxN8WFe4J+xVJgS+U11meQCTWyOO/U27HDRkXxYsuW4qKPF7DQF2Qpvkjs1lFxTQ9NYvORSf+W64gyXFPF2e9EMnedz23NIyvG9n+hibk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758585058; c=relaxed/simple;
	bh=R+aHvAUfzUrWQEbi6wKW3v3M3/JhpvHdubeeTdhXvpA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CaSRFRAbeoIzn3I8s8Czj0juqyOm6L8z+q6ktymGbPxWeXT1/D+3nmLLJQSHtC//hSaaYoySKDv1Qg1g+HsKlvInrl+NCNtpI22WxXNAjMGSA//a/M9X8skDQtXMXrQjtJqwUVdV+fyltmZuceJwpbNZQoFAEyNVcZ5u1pCeXTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HaY+8g3Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE82FC4CEF0;
	Mon, 22 Sep 2025 23:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758585058;
	bh=R+aHvAUfzUrWQEbi6wKW3v3M3/JhpvHdubeeTdhXvpA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HaY+8g3ZTgDDnbasaavlS+H9Vq20Ry2Jv/j66GEAIhK9gup97A0Y7bCmbW03WowNv
	 uarIQfdqTe986x07Jc7VM/og7bal2e5lOtoE1NHF2OPQea8oY2dNMs1TMFoUJJ9W8G
	 /PI0HI+N4G2ky7V4oOuCS8HTsyQ7N2DzWNjki6JKj8nf5aT4MZCBYAaOjRi1Ny0lU3
	 IwHmUiqSJNbXOk90IHqt3dDiSBprE3u2QqvVS/rGYjd1+DfPu4n3rM72QwaIvXCOUE
	 bEL6svSN7UFpWYpV+1IPnE3rxHgG+26VgtEYHfk9f3chRm0PxaA3N8gKX52/YUokRJ
	 meLWxXz2n7aLA==
Date: Mon, 22 Sep 2025 16:50:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andre Carvalho <asantostc@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/6] netconsole: resume previously
 deactivated target
Message-ID: <20250922165057.70eefc6b@kernel.org>
In-Reply-To: <20250921-netcons-retrigger-v2-5-a0e84006237f@gmail.com>
References: <20250921-netcons-retrigger-v2-0-a0e84006237f@gmail.com>
	<20250921-netcons-retrigger-v2-5-a0e84006237f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 21 Sep 2025 22:55:45 +0100 Andre Carvalho wrote:
> +		if (nt->state == STATE_DEACTIVATED && event == NETDEV_UP)
> +			maybe_resume_target(nt, dev);

This uses GFP_KERNEL

>  		netconsole_target_put(nt);
>  	}
>  	spin_unlock_irqrestore(&target_list_lock, flags);

And we're under a spin lock.

This gets hit in the selftest you're adding so please triple check 
the kernel config that you're testing with.


Return-Path: <linux-kernel+bounces-777150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC17B2D5EE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DA6F3BC045
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 08:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733582D877F;
	Wed, 20 Aug 2025 08:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPhrCoss"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C399C2C11ED;
	Wed, 20 Aug 2025 08:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755677773; cv=none; b=vCkIiGckLY7w+INJNyAvnYJcNUvb2kM6p0u3jKWZ4wVcU956Jc22BIlHUG9HNDT9nGBB/7EJzmibiTH8XOdMEOXBJ8vjFY47mhE5nLeQan24Q1ixf3/tPZOkvm2YnK/AGr+vymMW0Bo/++LIWP2kAOIY+QMBU/fysoHVS7nNri0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755677773; c=relaxed/simple;
	bh=v3CYIS5qoS6/6JuTjFHHOmo5iS4e+MhOpakA/Lg7BdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mYXf94mhORKZLioq9bbURE44HBPfa/7xlKWNuOYySMyw75FWhpvwgRYuvY8cI6Vt3ktgtM1Nn4jOXsZjMfkU0sRwDchwHwxjShhQCSKbOrG2Z+IICGQwRoW1vyVelRWgRVRwYl/iLX6JpLMCVJ2M9f66gj+NpAqDM51GzJ4eSYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dPhrCoss; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE594C4CEEB;
	Wed, 20 Aug 2025 08:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755677773;
	bh=v3CYIS5qoS6/6JuTjFHHOmo5iS4e+MhOpakA/Lg7BdA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dPhrCossGZGTeltRt4rtpI0HNPkvQJ7kpL/rnbH5V62DREcQ1O58Z8IxuYWaxnDzW
	 WPOso+v7iERDKIEye7PPnVU3t7Ana7tkF8l44c27X2Y5bnf8SHhMX841QhtlQPJllc
	 EwV+gZekUBUKznbtwsLG9M26U4rQYGBYCFlddtHujlef2LRW6qXDY0pR+BEuq08U6R
	 7g20m/Z0E226R9PSiz6JXwUrbjhmM1j9Xn+RGaMhi9saxPDj8q1l64A73e5b0t0T3q
	 agTohGClE7PinAwqJjYZn322Ugfr8nfkFRvwuklFAiR1XipxzgNZEcKFye/JVYrE1A
	 oNAXVq3S1om+g==
Date: Wed, 20 Aug 2025 10:16:10 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: tsbogend@alpha.franken.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, john@phrozen.org, linux-mips@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: mips: lantiq: ebu: add name pattern
Message-ID: <20250820-fluorescent-scrupulous-hawk-77fb39@kuoka>
References: <20250815141759.3408909-1-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250815141759.3408909-1-olek2@wp.pl>

On Fri, Aug 15, 2025 at 04:17:40PM +0200, Aleksander Jan Bajkowski wrote:
> Lantiq target doesn't use Common clock Framework 

CCF does not matter. It's Linux thingy. You describe here hardware.

> and requires strict

hm? where? I checked kernel sources and there is nothing like that.

> node names. This patch adds the name pattern to the binding.

Again, why?

Best regards,
Krzysztof



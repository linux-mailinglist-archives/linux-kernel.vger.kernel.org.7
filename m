Return-Path: <linux-kernel+bounces-767317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C174B252C2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 20:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45D107BBA46
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D402BF011;
	Wed, 13 Aug 2025 18:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2w9cYdv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2702877F7
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 18:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755108378; cv=none; b=Aol0dYARDivZ7ha54Gmj+yFsTPgD02920s++PEH9TG7YpDlveU9Rr9HNwG0t3NU7x9YFAQ6HGrpbKIpKrp5ke3hsSbtXCs9gn7+f8jqJFIZXzXPOcD5kKTJOYlfvc730oeVAqyxHSmBBzhD6IiWla35m/1mEjPJZ7XzjLfOPGb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755108378; c=relaxed/simple;
	bh=ehwmLqJXn79f0MsM22ye8xrqHxpgqSwPxeHZwNvflTQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HDToP9SaEkIPLjWVaV6v5+64+IyEFVZT7HGNpiaGMOEKvjnLEstxPiuRvnqayd61bUU8Bs8QAnfxETKgozsh4BXbqOvRlL6RtUuSBX+NpBhlaJELbnSfOMYRmc2pcKUbJXV08Ul/GH4KYqQNCcKGaAVc9DBCxt4e2wkt3FSsUV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2w9cYdv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B2A0C4CEF7;
	Wed, 13 Aug 2025 18:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755108375;
	bh=ehwmLqJXn79f0MsM22ye8xrqHxpgqSwPxeHZwNvflTQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Q2w9cYdvspki7A8eW62thlIqxqWRGGcYTUOoDtpWw1qV2uPIAp6zS99GdIbA008cL
	 GoGgD29vUvnd/Z+Fdn6LLUXEBylqmu2zuaO24EMRHcnYP06o7eUddM2PdTfSnY8NHu
	 rWbBX8k2//hSYfVte6BGM6UlR8IZJQSVS6739q8qAcy7iVFjTRhnzGREM/72tuqqkm
	 ExR/XDEIh6LQfd1YsrUOPxAYqi2m9RcVt6/sNyf4zdJ5AbJSV3yvM4i8ZA7QQAyII8
	 IvzmoiZXmzVE5g/nqbmIhNU9IpV12ebDz1YFbdVVSqbaMK3s4MVr1Kag5V/+di8CkU
	 4fRTW+Q7b1a1w==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Lucas De Marchi <lucas.demarchi@intel.com>, Breno Leitao
 <leitao@debian.org>
Cc: linux-kernel@vger.kernel.org, john.c.harrison@intel.com
Subject: Re: RFC: configfs attribute description
In-Reply-To: <otrtabbmkoutnvku7mmoecw3f7bjqwhxwuxuu4ewhoseixxgpt@fn3dt5tgrnf3>
References: <sq3Xfp7-O3mdRYm2TNLAYvv-kw4lb-5S-xl0S9wEcvI72GSytOQIzslrYzZ92KTGLo67af1sraVSpb3sIgMtdQ==@protonmail.internalid>
 <otrtabbmkoutnvku7mmoecw3f7bjqwhxwuxuu4ewhoseixxgpt@fn3dt5tgrnf3>
Date: Wed, 13 Aug 2025 20:06:05 +0200
Message-ID: <87349vf65u.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Lucas De Marchi" <lucas.demarchi@intel.com> writes:

> Hi,
>
> In the drm/xe drivers we recently started to use configfs for a few
> things that would be added as module parameters in the past. Configfs
> seems a much better fit for us in these cases.
>
> One thing we are missing from module parameters is the description.
> I can point people to https://docs.kernel.org/gpu/xe/xe_configfs.html,
> but having a short description somewhere of each config at runtime would
> be good. I thought of 2 alternatives and would like to know your opinion
> or if there's a different way you envision for this.
>
> 1) Add description to a module info. This would allow to show "all
> configfs attributes this module implements":
>
> configfs.h:
> #define CONFIGFS_ATTR_DESC(_name, _desc) \
> 	MODULE_INFO(configfs_attr_ ## _name, _desc)
>
> xe_configfs.c:
> #define XE_CONFIGFS_ATTR(_name, _desc) \
> 	CONFIGFS_ATTR(, survivability_mode); \
> 	CONFIGFS_ATTR_DESC(survivability_mode, \
> 			   "Bind device in a survivability mode useful to unbrick it")
>
> Or provide a single macro in configfs itself. This would "standardize"
> module info to contain configfs_attr_xxxxx to describe each entry a
> module implements. Main benefit here is that I can take a module and run
>
> 2) Add description in the fs tree itself, similarly to how perf adds a
> .unit: 2 attributes are created, with the second being RO:
>
> ls /sys/kernel/config/xe/0000:03:00.0/
> ...
> survivability_mode
> survivability_mode.description
> ...
>
> This could be done all inside xe itself, but I think it would be better
> if there's a common way across the kernel for that, hence my RFC here.

I'm not against adding this if you want to code it. But is it really
that useful? I always find myself reaching for kernel docs for module
parameters anyway.

I would suggest providing this info in user space tooling (if you use
scripts or a binary to interact with your driver through configfs). Or
you can add the info to the kernel man pages or, as you suggest
yourself, the kernel documentation.

I am curious what others think of this.


Best regards,
Andreas Hindborg




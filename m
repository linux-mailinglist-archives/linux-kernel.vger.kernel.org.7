Return-Path: <linux-kernel+bounces-843441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F0573BBF2FD
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 22:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D76A54F178B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 20:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E9A26058D;
	Mon,  6 Oct 2025 20:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I95PoAHT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499A91DB12E
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 20:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759782438; cv=none; b=O9GZ706W2Vpu1o/Cb+/fc9zaEC9rpXNTNwyYYjMMoLP6qgIpIdBg41o4vl84qxmp/RNzMs8KWLmEijixQEdM8A4SriVpZZez2SlCVO3JcWJCi6epg/J7ZPzOVWJxIBawK8C3bC4OIz8eZqkzmDKuAHSkhZF/fGvRRXLpTatA844=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759782438; c=relaxed/simple;
	bh=ERvHqLDNGOEaUGZCyJ3haiBB35X3X5xMUfWhSjsCzEk=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=Vi26tXhss2Py5KjS/lXJTa3/p48c20/yssdgegIMoNF5Pl2I3200P+boN9d9Dw5J3JHWa1bCZ9ymj4XU80ziEKehbk1m8gv7e6trZRPBMXsDlsInauGvPlc3ym4Vnmcj1fqPOWl77uMtcJLQ6mZPmgj+R4zCCr9cmSt5er03G+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I95PoAHT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA4AC4CEF5;
	Mon,  6 Oct 2025 20:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759782437;
	bh=ERvHqLDNGOEaUGZCyJ3haiBB35X3X5xMUfWhSjsCzEk=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=I95PoAHTTWY2sKahCIUX0LJ3Q8wmcRypWIbRKDG6SQ8Eupi2JsA++ELZOzuBBfPNh
	 mNEjmv5klNUu/+uzIfxwN1BvMaWmn1PqpUGLo/oqFCKcuV3tH6hSKyTQEIWK0cEFs3
	 N7bBQC3OOcXbqrd2KuxRVlj2rgyOkiiLmcF4rwsfHA7dMq42oY9cfZ9xMIblmDelPj
	 tXv0uhE0sUdqMHR4VLpW9NOWOtye4dAey8Bs8JElrGrZVPvkcPAG++ELPePHer7amp
	 PZCc5tWxJRIpcHvnpIpt5JGGQ+WjY1PIseASh7jhmn11yolchrZzKZPBUZXz8KT49K
	 2Umv4wtZyON4Q==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Oct 2025 22:27:13 +0200
Message-Id: <DDBIT5J2HUWO.2MQPD4H5G4A44@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 3/5] drm/nouveau/mmu/gp100: Remove unused/broken support
 for compression
Cc: <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>, "Mary
 Guillemard" <mary@mary.zone>, "Faith Ekstrand"
 <faith.ekstrand@collabora.com>, "Ben Skeggs" <bskeggs@nvidia.com>, "Lyude
 Paul" <lyude@redhat.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <nouveau@lists.freedesktop.org>
To: "Mohamed Ahmed" <mohamedahmedegypt2001@gmail.com>
References: <20251006191329.277485-1-mohamedahmedegypt2001@gmail.com>
 <20251006191329.277485-4-mohamedahmedegypt2001@gmail.com>
In-Reply-To: <20251006191329.277485-4-mohamedahmedegypt2001@gmail.com>

On Mon Oct 6, 2025 at 9:13 PM CEST, Mohamed Ahmed wrote:
> From: Ben Skeggs <bskeggs@nvidia.com>
>
> From GP100 onwards it's not possible to initialise comptag RAM without
> PMU firmware, which nouveau has no support for.
>
> As such, this code is essentially a no-op and will always revert to the
> equivalent non-compressed kind due to comptag allocation failure.  It's
> also broken for the needs of VM_BIND/Vulkan.
>
> Remove the code entirely to make way for supporting compression on GPUs
> that support GSM-RM.
>
> Signed-off-by: Ben Skeggs <bskeggs@nvidia.com>

This patch is missing your SoB.


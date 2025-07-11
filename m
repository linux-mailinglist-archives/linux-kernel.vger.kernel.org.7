Return-Path: <linux-kernel+bounces-728067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADBAB0234F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98E5F16EB60
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8BE2F1FC8;
	Fri, 11 Jul 2025 18:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bayH31tB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F9F1FFC55
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 18:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752257180; cv=none; b=sOKsByZC28cFf3LJIKSAoweUnClVfWYzatt4aqlY0dR6K6NyO4DM1STTGGO7BOB+9FZXFQauhG+uLwe1P3ZbFdXoAzlS3LWRbafcgf89DQj0xtB4ZBUICAElWFbvO1zeOlAaG6jQ7SgIV1MOHt4lrGEoIdgzl6pQ4VgajFrsa4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752257180; c=relaxed/simple;
	bh=/9a4/phpDuawySJjaWTXurkeMeclgalXZ+d6x2nKduE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=N/hhKlLkVie+chpwejKsaCf6im8uRQ1VYixGDHLfzCO5S5pUbpu/V8JgNf/J96icJsDrGVLCq75CpoLX6/iy5gtWsnciOZnXn46r1WDAZm5/gsbZOSOSVR1bEakXXQf6Y+ZFRJJ0tld2m0kTRa9k2way+V+q97+7Sjy3sfl1VCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bayH31tB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544B0C4CEED;
	Fri, 11 Jul 2025 18:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752257179;
	bh=/9a4/phpDuawySJjaWTXurkeMeclgalXZ+d6x2nKduE=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=bayH31tBJpB2xff+SviA/VIFbkWDbwD1toV8iU2SxFjLzeDuPi8In4FDK5MDz9FLd
	 NvoRdcPXZd7wqDabLslCByJu1MNX1HbPLtuN1Lv1DWatOGxSriiwEeyCW5g7bO9zdV
	 qMI2nR0VXxp3a5x5ko9hBCpRfU5lpXtp75kWvJUjNhoOEZUrKktyvnqUr7dHkwxcVP
	 VAXeeohX0ku/COIy2ATQ6UrQvUnLrKTBQt7NvqgAvY5ydjGmtNcUzr84pheryyiu1O
	 /vIs/a5Cazj0eKAIZBe/d7iJqCLBP+/LNLRr/QxCwbxqQ4jehnczVlOIn+M5T2kgN1
	 qhkl6Ne5lRH1w==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Jul 2025 20:06:14 +0200
Message-Id: <DB9FBT4H5FOZ.14JZJCXMEIYU1@kernel.org>
Subject: Re: [PATCH] drm/nouveau: check ioctl command codes better
Cc: "Lyude Paul" <lyude@redhat.com>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Ben Skeggs" <bskeggs@redhat.com>, "Arnd
 Bergmann" <arnd@arndb.de>, "Ben Skeggs" <bskeggs@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Dave Airlie" <airlied@redhat.com>, "Thomas Zimmermann"
 <tzimmermann@suse.de>, <dri-devel@lists.freedesktop.org>,
 <nouveau@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
To: "Arnd Bergmann" <arnd@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250711072458.2665325-1-arnd@kernel.org>
In-Reply-To: <20250711072458.2665325-1-arnd@kernel.org>

On Fri Jul 11, 2025 at 9:24 AM CEST, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> nouveau_drm_ioctl() only checks the _IOC_NR() bits in the DRM_NOUVEAU_NVI=
F
> command, but ignores the type and direction bits, so any command with
> '7' in the low eight bits gets passed into nouveau_abi16_ioctl() instead
> of drm_ioctl().
>
> Check for all the bits except the size that is handled inside of the hand=
ler.
>
> Fixes: 27111a23d01c ("drm/nouveau: expose the full object/event interface=
s to userspace")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to drm-misc-fixes, thanks!

  [ Fix up two checkpatch warnings and a typo. - Danilo ]


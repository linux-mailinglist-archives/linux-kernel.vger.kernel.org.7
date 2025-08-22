Return-Path: <linux-kernel+bounces-782698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DB5B323D0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 22:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0BCE566D02
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 20:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8566E2FC01D;
	Fri, 22 Aug 2025 20:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2Hff49D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B182ED14B
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 20:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755896127; cv=none; b=JrlylZckAAqQlk8KQUmfBSwayQsSxgm9D3Z1ZO9BNOk92o8atXsp7bci1AqItP93oaJL4qboaz7sA4ur8l//CkVgIFl72jnKmD4C+tHq7US9flYareoG7nfuur6YPlQUdMN3UJVybc6J/incuq/kz6p3TrDdcWd3E8qXJUw7TFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755896127; c=relaxed/simple;
	bh=CFcGFldNl6Ltuz678Ka4M7lC4/GOij/qIf10vcv/Vss=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Gp3Y6o/3n6o2ko772O0wWEv+gcOV8XijK3zxY6/xyLpIQ8YY9gj0EzjkeiXTJWsf+EUMkvy8zyIYQk4dD2U0Exvb+fyOrM6evf9dCB678lAKfY1XF6wxVb/lCMQeO3k8qfii16dD8EF5esauD1rLWxhzysDqUJk7Q7LH4pSPYAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2Hff49D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC71C4CEF1;
	Fri, 22 Aug 2025 20:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755896126;
	bh=CFcGFldNl6Ltuz678Ka4M7lC4/GOij/qIf10vcv/Vss=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=I2Hff49D9Ui4V9P1xsC228QHrnYmRcyneZvRnuNJ61uDckxoDw1fKSZA579ynFaST
	 91Tm7oQP6NruE+1klk6tpy9KmtXaXvPSlWOZUCXpN/drRp2a/ohqlX34cSjyttyM9Y
	 xTuuJ/rccOxN2qoVNpfq6jewxeGy2NGwj7yZdHh/6SyawQb9VvrDBuARDlYIAPmxDT
	 tYp2I/ftvC5bhufiTSR5Fdk+3BRUqEspwrwGnT8L/0tv00GIHLnVP3/09aBdJtpGgQ
	 1l5GoI6iibqSijyQq/SOtWsQB8gJ8SXn4ibH+x3gGbLYCyvDCipeGNJ97rha10w/mu
	 4cYSPGzutpsQA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 22 Aug 2025 22:55:23 +0200
Message-Id: <DC99870U9374.HUXNLLZ5ZYBE@kernel.org>
Subject: Re: [PATCH 2/3] drm/nouveau/disp: Always accept linear modifier
Cc: "Lyude Paul" <lyude@redhat.com>, "Faith Ekstrand"
 <faith.ekstrand@collabora.com>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Joel
 Fernandes" <joelagnelf@nvidia.com>
To: "James Jones" <jajones@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250811220017.1337-1-jajones@nvidia.com>
 <20250811220017.1337-3-jajones@nvidia.com>
In-Reply-To: <20250811220017.1337-3-jajones@nvidia.com>

On Tue Aug 12, 2025 at 12:00 AM CEST, James Jones wrote:
> On some chipsets, which block-linear modifiers are
> supported is format-specific. However, linear
> modifiers are always be supported. The prior
> modifier filtering logic was not accounting for
> the linear case.
>
> Fixes: c586f30bf74c ("drm/nouveau/kms: Add format mod prop to base/ovly/n=
vdisp")
> Signed-off-by: James Jones <jajones@nvidia.com>

This issue seems to be present since v5.10, what's the implication of this?=
 I
assume this has to be backported into stable releases?

Does the subsequent patch break strictly depend on this fix, or can it go
separately?


Return-Path: <linux-kernel+bounces-865878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63321BFE3A9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 22:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08E293A7A44
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 20:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB89030146E;
	Wed, 22 Oct 2025 20:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dfff7yyT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CF729405
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 20:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761166579; cv=none; b=vA0Mtgjn38D3HSZ17a0aN/fkXxWtBGmQrue7CHJY+j723ORQCg4D8+aS6RYF1giwkT27pPNWkNdu8axNOuAo2CLrZ8C8RIMCVOPNozKaUdAXqydFMlL7cOmR9sP7Waj5ebGhHCRSqHKLz6Xy9WJK32a9jAOh+xeA/2f2zyH/B/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761166579; c=relaxed/simple;
	bh=inAMQyKAc1Q8OSBoBIraOPZUOkirC95Di7Iww6dYpAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OwCGEK6p7H4s+32euVBHsc83OqzLHENDJ5B5G4fSBOeETO5I5xihzPHzJlqfcRnxbh5qDNUJPxJB41e0/O/v2uFKtCwfe25FYqxBttmn9ZRnclmn/cWz7KeGzTAV47bNZo0RRRTThMRk0MFuxUrbbr0ClM9X5tp3NrJIYWkX658=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dfff7yyT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B90C4CEFD;
	Wed, 22 Oct 2025 20:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761166578;
	bh=inAMQyKAc1Q8OSBoBIraOPZUOkirC95Di7Iww6dYpAk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Dfff7yyTETuXCELBEpQeQ7Gl/odWr5fAovIYkxNdoLMFkbpUoGOy0qlwzNA6oz8HC
	 D1VVrBI6LrqRPANuP+v0x8ZM/UbeNWtFxIXb9bcoLBwiUWtC9w1HDllnPqldYlKBhj
	 zD7/KQVbhy1VASnoy1Iz4118HpSZUMh0qz24wZi+EtIh0N2xVKbebLbmioPF1gJJpx
	 h6OeD6t0dw0tWKTW4j8w4kI6Jwu6UOVY+5ypezoV+K6Caaxp5XvMIJMFeqpWMPEcX7
	 jmz0VsYeI0LPj2XDU1/Dzcm05oh+oeQuistKvEQ8cXMYjQ2c04YFZdfSn/CogGeq36
	 rbMqXMstfcSig==
Message-ID: <904ba70f-b1bf-4745-8e92-d27a6c903673@kernel.org>
Date: Wed, 22 Oct 2025 22:56:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] drm/nouveau/uvmm: Allow larger pages
To: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Mary Guillemard <mary@mary.zone>,
 Faith Ekstrand <faith.ekstrand@collabora.com>, Lyude Paul
 <lyude@redhat.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 nouveau@lists.freedesktop.org
References: <20251009233837.10283-1-mohamedahmedegypt2001@gmail.com>
 <20251009233837.10283-3-mohamedahmedegypt2001@gmail.com>
 <CAA+WOBvVasy2wRP_wmP-R6Q8y5B4sN08jNYfHuDVjiWXV+m23Q@mail.gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <CAA+WOBvVasy2wRP_wmP-R6Q8y5B4sN08jNYfHuDVjiWXV+m23Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/22/25 12:16 PM, Mohamed Ahmed wrote:
> Pinging again re: review and also was asking if we can revert the
> select_page_shift() handling back to v1 behavior with a fall-back
> path, as it looks like there are some cases where
> nouveau_bo_fixup_align() isn't enough;
> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/36450#note_3159199.

I don't think we should add a fallback for something that is expected to be
sufficient.

Instead we should figure out in which exact case the WARN_ON() was hit and why.


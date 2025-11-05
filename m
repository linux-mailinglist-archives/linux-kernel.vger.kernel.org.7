Return-Path: <linux-kernel+bounces-887443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69348C38425
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 23:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 447093B89CA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 22:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1982D5944;
	Wed,  5 Nov 2025 22:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ko6QX8fG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB7B2D0631
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 22:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762383022; cv=none; b=dcQBZh5D1CbZ1tpzk3vMeFdeq/eGo8lpYHkjTzTvSakL5OPgwk2blSzG3HnBfYOIrqjNauJz6OnRBQZY3hwozactiJ8w4YItJBOCZlnjyK40VZljK/KRuAQ3l8TOIpsuOcCFvQxQRpfpGZWDv4OjzYSXmbcXUeexJTkQhosffDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762383022; c=relaxed/simple;
	bh=c9L/RmDqSZRKJS2TMpxVfqovIdx6B5TNr/pdfh5cdqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fRsHlfAtgDZwzC86qnij6A+4CriZ2qy39Wz4b/VWzvvNZtS6ioxVN6eAlI+4e8bDYDBvHFp8n6mUJmcCYh0aB4I4mdz06POKHdFZptNWPTYvlwkwyiqk6u1AWCi/Ntdu84FZbz4Oj0x2K69M5LNt+U80IWWKNwTbQFZ8umBFu9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ko6QX8fG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 753FCC4CEF5;
	Wed,  5 Nov 2025 22:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762383022;
	bh=c9L/RmDqSZRKJS2TMpxVfqovIdx6B5TNr/pdfh5cdqc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ko6QX8fGTbZdDbsAdNEraj6h2EoNR6BCxSbXlQ9/DPy/N+czbDKQ6P3z7rnB/0O/q
	 kkYKAZArqOYgQhqQuCI6gfTjwReggUKPEfQ8HjSmzatt2XfOejRIkZsBks4CphCPx0
	 AS8PhSOLDjZN61AdpHIhIR9oTl2iR47O9KwAEqOvypJMVDgIijDgoOJZ1mvFqYZclE
	 TUwuXgT9SMQZKI3QCawZGAJ1XL+eTfP8koLB79JxJtBoO+rq5U+T9/AKKdN68ohu1a
	 gy17/moLB0aGONN9iwXAZS1ZTyOpjV9C3ktzyLVdPNvDN0Ce5Svufgzf5Vxh1nD90l
	 pZMWXG3hdaeUA==
Message-ID: <4d07932e-8b53-4ee3-8d08-6f49d433f005@kernel.org>
Date: Wed, 5 Nov 2025 23:50:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] drm/nouveau/uvmm: Allow larger pages
To: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Cc: James Jones <jajones@nvidia.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Mary Guillemard <mary@mary.zone>,
 Faith Ekstrand <faith.ekstrand@collabora.com>, Lyude Paul
 <lyude@redhat.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 nouveau@lists.freedesktop.org
References: <20251031104924.10631-1-mohamedahmedegypt2001@gmail.com>
 <20251031104924.10631-3-mohamedahmedegypt2001@gmail.com>
 <0bffd718-3659-4add-90fc-fb0e098f2897@nvidia.com>
 <CAA+WOBtmbPHigscFQCFgDo=9WSM6V-JMXGCO7orP=01XOqTPHQ@mail.gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <CAA+WOBtmbPHigscFQCFgDo=9WSM6V-JMXGCO7orP=01XOqTPHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/25 12:53 AM, Mohamed Ahmed wrote:
> Thanks a lot for the shout out! Looking more at things, the logic here
> is actually redundant. It was originally copied over directly from the
> bo allocation code to stay on the safer side (basically the idea back
> then was to make both the bo and vmm sides match exactly). We aren't
> at risk of having an aligned address that is in the wrong memory type
> because the bo allocation code (nouveau_bo.c:321) forces anything that
> has the GART flag to have a page size of 4K. Anything getting a page
> size higher than that is exclusively VRAM only. Additionally,
> currently things marked VRAM only don't get evicted to host memory
> except under high memory pressure and in that case, the context is
> paused until the objects in question are paged back in, so we also
> don't have to worry about memory placement there.
> 
> The memory placement check in the vmm code could be removed but I am
> leaning more towards leaving it as is just to stay on the safer side.

If it is not necessary, please remove it. We should not carry dead code.

> At the same time, it would be more useful to keep it for the future as
> one of the future investigation targets that we want to look into is
> all the memory placement rules because the "only 4K is allowed for
> host memory" limit that nouveau imposes is a source of many pains in
> userspace (originally thought to be a HW thing but seems it's actually
> not), and having the checks on both bo and vmm paths would help
> starting out with that.

Please don't top-post, see also [1].

[1] https://subspace.kernel.org/etiquette.html#do-not-top-post-when-replying


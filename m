Return-Path: <linux-kernel+bounces-861934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9802ABF40ED
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 01:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 109A33BAC40
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 23:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757D7302CA2;
	Mon, 20 Oct 2025 23:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAAimqfx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6341219E0;
	Mon, 20 Oct 2025 23:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761003889; cv=none; b=A93MZh9V832qZHUOFnf1m/Y930Vf6hUUGpjuc2J4gDskSvGfKQ5mO9QDYTD5V1R57ckoGxhE0HntfIYuqNymi5iI3UY+EZcpBjVW3OqwBEX2vft9Z/M9ZvbUhs2FMLElfAKpH2F0OW0yIQsqt0kyafIEhoe/ATRyzAajMAyLtOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761003889; c=relaxed/simple;
	bh=ErnMc4zfx6Bt1UKhR4J5JkX5muJWOlmyUseeP5/tWtw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d8NN7V69Pb0a4V5X9sWOzRLS6J1lIDfUKh2W2jclCPCuN20BT6tM3SbsJANQsvcxP4xgAjnirCSX5SNx8SJBJyc2VRkzoX0Jb2B64Zimb+feaNI4wg/1FwNBgpvui2X3wegttFgb3oRx3evxaYusJ8OGG0mr/UMA+4iobeYPYt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAAimqfx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA3AC4CEFB;
	Mon, 20 Oct 2025 23:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761003889;
	bh=ErnMc4zfx6Bt1UKhR4J5JkX5muJWOlmyUseeP5/tWtw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eAAimqfxlfQsE0eGwPHFXR/+HG/Yc8+ijhBPSbQAlE/j1yRwkdCqoEgGwyPAJlPRH
	 +xLSqo9Oyd6sPdJSuYGMYtb6kTtV/4NEw2qx2zXVC/2KTrEX4zfAFFyQiISUHIzAqa
	 q+W+gJdEeMW/58t8BdPexfKsWvhgnqsPv43w4cwH1DTNhGMspB57SPppK0gq+CxtPR
	 0oIG/kjbN5aE/uaXNE5Id4whpGTj3dotEVPddn9quwHKj5d3W/MILkyiNo9th+vOrm
	 YLMIVyUTQ/uxbibrq0raEntSp22AHKJIulGH9nQ/NiEsJBhEQ3HLvIUBWAaVGOgLth
	 sspme8NV03kyg==
Message-ID: <059912ef-6023-4af4-a8df-f4b34fe98e71@kernel.org>
Date: Tue, 21 Oct 2025 01:44:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7.1 0/4] bitfield initial refactor within nova-core
 (RESEND)
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Alistair Popple <apopple@nvidia.com>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, bjorn3_gh@protonmail.com,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 John Hubbard <jhubbard@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 joel@joelfernandes.org, Elle Rhumsaa <elle@weathered-steel.dev>,
 Yury Norov <yury.norov@gmail.com>,
 Daniel Almeida <daniel.almeida@collabora.com>, nouveau@lists.freedesktop.org
References: <20251016151323.1201196-1-joelagnelf@nvidia.com>
 <DDLHP1ABV9BA.3V0NXW3RWHGL6@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <DDLHP1ABV9BA.3V0NXW3RWHGL6@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/18/25 3:41 PM, Alexandre Courbot wrote:
> On Fri Oct 17, 2025 at 12:13 AM JST, Joel Fernandes wrote:
>> (Resending due to some commit message mistakes (missing SOB etc). Thanks!).
>>
>> These patches implement the initial refactoring and few improvements to the
>> register and bitfield macros. Rebased on drm-rust-next.
>>
>> Main difference from the previous series [1] is dropped the moving out of
>> nova-core pending BoundedInt changes:
>> https://lore.kernel.org/all/20251003154748.1687160-1-joelagnelf@nvidia.com/
>> Other than that, added tags, resolved conflict with kernel::fmt changes and
>> rebased on drm-rust-next.
> 
> Thanks, this version is looking pretty good, and works as intended.
> 
> I plan on pushing these 4 patches soonish after fixing the line length
> issues and the other few problems reported by checkpatch.
> 
> Danilo, please let me know if you think this is premature, but imho it
> is good to set this part in stone to avoid merge conflicts with future
> patches that will want to modify the register macro.

SGTM, we can keep discussing the hi:lo ascending / descending topic for
nova-core independently.

However, for the sample code that, eventually, we'll move out of nova-core, we
should stick to what's common.

With that,

Acked-by: Danilo Krummrich <dakr@kernel.org>


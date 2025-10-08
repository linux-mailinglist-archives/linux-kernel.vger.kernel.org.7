Return-Path: <linux-kernel+bounces-845315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E008BC45CD
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 12:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25BBC3B1CC1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 10:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37D92F60A7;
	Wed,  8 Oct 2025 10:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJkWGDP9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29811242D69;
	Wed,  8 Oct 2025 10:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759919916; cv=none; b=dU7n6P0Xrf49t2zaoNv0QlYEaxuWivuLsG7KAuZAG7Mx5BIyIlK6LRB1Z1qH2neb/p6HgRbiPrkgrtie14blYx6b2F7v5L/15rT3Z6Ktq6i/ihD+etFvcUgYxcmGdfmEgP81f9eJDn+N8nyALXV+agvsDIbIvP7kYekjhbJuNus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759919916; c=relaxed/simple;
	bh=8PAxUp2DZdH2TSqIsiP6A2jShMUr6FjTKJktfSZKqP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QvnAb/DN7g8kdWS4Qpf1vR5AHzxwff/y+osEkhbQWFbikgEnr9VdvLG4q56gIzhtW0VWxSQPLUVuRuLG1jwWU7wclahyms37hND0CiaRC8EziJDG3XtEP1SBghuwdHz1MrWg2sTmOSH3bALqGgB2TdFGQXy7ywlCfaM0mND6zDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJkWGDP9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9953EC4CEF4;
	Wed,  8 Oct 2025 10:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759919915;
	bh=8PAxUp2DZdH2TSqIsiP6A2jShMUr6FjTKJktfSZKqP8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AJkWGDP9M9cVW5EYTToUzi+sV7Wq4oxJXEDmUb/x4ntaEKP7dS4Txm9Hf/xf2GJTw
	 d0wSuu9CwO0KDgqpxG+gzp+3Nb5ur5GVNHznvbhsutYKimwLX5RbCksNxNS7jK5ZGF
	 zaAuvbdN3+oq18Zm4j7oblEB88vTX3aOYFXYmOi42w6Xnc/peQYWZdaEFEQjDprbhK
	 pzrnnJ+XOBEnEDdr/TXZfqm6IJ33DQrFGbXmimCEnbwV41nZeL/46fGaUJEHeKH8Ni
	 UT11AmAMsSwhwmAqNU+GoSHjKVDqvyCKX6zxsRoTa9U642F7gYQvCbFU9ZbLkvehMf
	 0UnjuhhbIYpVA==
Message-ID: <17dd5928-f06f-4747-b36c-195be4ac5082@kernel.org>
Date: Wed, 8 Oct 2025 12:38:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/13] gpu: nova-core: Boot GSP to RISC-V active
To: Alistair Popple <apopple@nvidia.com>
Cc: rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org,
 acourbot@nvidia.com, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 John Hubbard <jhubbard@nvidia.com>, Joel Fernandes <joelagnelf@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, linux-kernel@vger.kernel.org,
 nouveau@lists.freedesktop.org
References: <20251008001253.437911-1-apopple@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20251008001253.437911-1-apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/8/25 2:12 AM, Alistair Popple wrote:
> A full tree including the prerequisites for this patch series is available
> at https://github.com/apopple-nvidia/linux/tree/nova-core-for-upstream.

The prerequisites in this branch seem to be upstream. When submitting patch
series, please base your changes on the corresponding upstream branch (i.e.
drm-rust-next, on Linus' tree in this case) and make sure to include the base
revision (git format-patch --base). If it depends on other pending patch series,
b4 can help to track those dependencies.


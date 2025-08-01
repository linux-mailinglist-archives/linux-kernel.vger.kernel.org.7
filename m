Return-Path: <linux-kernel+bounces-753104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF00B17EB6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 11:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BC5B5805A8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 09:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41BA7262B;
	Fri,  1 Aug 2025 09:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AI2d9u7G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3902AEE4;
	Fri,  1 Aug 2025 09:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754038818; cv=none; b=pKUpK/HFztr9Z2Nmr1rkQiKSVFG5x5lwfaZ2nEiGHfLTGnnEJrTjxYK3SjGw+p4arAGDtgDgT3gSC3zWhI1pTKgU3fs53POauDsVp2IZons7spXkpm/o6iomqkXBdVhq55M1nnYUHa69zK5wQ9DIJPccVZd4sMEjdWmVd1GCxR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754038818; c=relaxed/simple;
	bh=fWPKNnaX5uTj9m87UtZaRk7qwv0U/J5aGdkXKnx0kmk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=UjR4kDQBnzQlj+0Eg4NAtqGP/vjeqS6uwe+poJku1I5YfdScnx2OZJJRvYCECq8RQeX52nehDtKCV23uZINHTHyAmRAQjIt94RkgURCXU6WjZiGy5FKhf7bLPuX+ILN6lef7irdOXEC9osrqMu+7URVNESgbv6JgHNnGAyvldO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AI2d9u7G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E0EC4CEE7;
	Fri,  1 Aug 2025 09:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754038817;
	bh=fWPKNnaX5uTj9m87UtZaRk7qwv0U/J5aGdkXKnx0kmk=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=AI2d9u7GEhdHDUvT62m95R0mTiBVyzjU3eMhjNV0RIKDjCQmTY83/1ELsYyMZm7Ig
	 nyRUvDbnOOuhBTG3F5ANWyrergDXiGgiHbM/Jsll4uTJkwBYDhmf2RtAJ6pzA7Nxny
	 tyEE5wusDL5llWMoTty194W8AUW4SgIB6bRdRdvf9gTeR5nhzpp/dgiUlXXvyFhj/3
	 IRMkrMlLW2/Jol63ECWaACUow3X6uRVslrJKOFq6jE9wb9LNpoS8sSh2EnJZd55iIT
	 tKO5vY37kcS5ewvVilysUUHMQa1ptd0K7iEMnVZ6BoOJiJqgs2dZSLbom2Lz/J9gUe
	 K8h4JZnsIuybg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 Aug 2025 11:00:12 +0200
Message-Id: <DBQYV65GPE9H.34LFC8IDBDIWQ@kernel.org>
Cc: <lorenzo.stoakes@oracle.com>, <vbabka@suse.cz>,
 <Liam.Howlett@oracle.com>, <urezki@gmail.com>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <rust-for-linux@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] rust: drm: remove pin annotations from drm::Device
From: "Benno Lossin" <lossin@kernel.org>
To: "Danilo Krummrich" <dakr@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250731154919.4132-1-dakr@kernel.org>
 <20250731154919.4132-4-dakr@kernel.org>
 <DBQGW0NIQJRX.MU0QD5GMFJYM@kernel.org>
 <DBQY1S7V8IIS.3NCGOZ8ALU7QG@kernel.org>
In-Reply-To: <DBQY1S7V8IIS.3NCGOZ8ALU7QG@kernel.org>

On Fri Aug 1, 2025 at 10:21 AM CEST, Danilo Krummrich wrote:
> On Thu Jul 31, 2025 at 8:54 PM CEST, Benno Lossin wrote:
>> On Thu Jul 31, 2025 at 5:48 PM CEST, Danilo Krummrich wrote:
>>>  #[repr(C)]
>>> -#[pin_data]
>>>  pub struct Device<T: drm::Driver> {
>>>      dev: Opaque<bindings::drm_device>,
>>> -    #[pin]
>>>      data: T::Data,
>>
>> Looking at this code again, I also noticed that it was wrong before this
>> patch: `Device<T>` implemented `Unpin` if `T::Data` did which is most
>> likely wrong (or is `drm_device` not address sensitive?).
>
> It is, but as mentioned above a drm::Device only ever exists as
> ARef<drm::Device>.

Yeah the `Unpin` thing isn't a problem for `ARef`, but we are
theoretically allowed to implement moving out of an `ARef` (given that
it is unique) when the type is `Unpin`.

Thanks for confirming.

---
Cheers,
Benno


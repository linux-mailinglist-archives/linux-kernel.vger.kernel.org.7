Return-Path: <linux-kernel+bounces-889533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 028F2C3DD97
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 00:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19FF43A63B7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 23:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1313019D3;
	Thu,  6 Nov 2025 23:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqOHNpLp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9892C3272;
	Thu,  6 Nov 2025 23:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762471818; cv=none; b=uERZm5nixagfdbKdQfBDzLKNUd/fZmt2zWBui/SeBSzpfsS3nSTgCUNyF5kASlNfK98O3QjWnTSGy54/DmsqZlfG+1pAgzdM+or68z5Ua8BrxpTJ5S1zoXjqNjWknzMfE6xlomOqUnuR54sJln9shmzTPYYr7OHx6faI+ZELrms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762471818; c=relaxed/simple;
	bh=RtKh1aHOhj1oUQyHUf8pa4sYnCoinvuK8XuzxIRajf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eDXtOVRYJ9NwrJ5fhk4/5FR4xxdeotjEMzkBrDl7iIy8G8kvbJ8gGNxPEJa1Ys0KxqlVYS6vXo0ppojNWJlMZLmAuq2BrZtRI/3G72EnExARI0xxAPY5VYhH5qf7NnOczTR4LET2S9Z0gqk6ESVP2pHLvX4YQJ+u2I1E2O90O1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqOHNpLp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBBD7C116C6;
	Thu,  6 Nov 2025 23:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762471817;
	bh=RtKh1aHOhj1oUQyHUf8pa4sYnCoinvuK8XuzxIRajf8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mqOHNpLpMJukurAu9WEU6QNDCnr36o3iJUL1EV1KG77f+R9/afOeC2+ZO/2QbZT7c
	 0k44sU4wPKl/m5aNVMevdrf0sen/hLfWu5F4UXlF7p+rnf/Hs3lbH3JtEvJ5LMp6du
	 DVH6DpwBEfgS8s1OjfvrncliiGp2rmxS7Wb6q2+R91JkzsvnxnSUVIYryZ+t9fCIor
	 ChrkA2xZZ0ncqdSryu/1ONR8a698bwr8xxuY9YHVfrSNnKJFkducAhM8dFI2sH/xaA
	 o+gUnuSgswKb1QmkrhqXHq6ORdyIcZsQHk7LXKPhlO8qX4c+vbVcmXCDP32RP0WHFw
	 CbFnZ/JhXtT4g==
Message-ID: <33fdac0d-fd7c-4c8e-9aa5-fa5558ff82d6@kernel.org>
Date: Fri, 7 Nov 2025 00:30:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] gpu: nova-core: use gpu::Architecture instead of long
 lists of GPUs
To: John Hubbard <jhubbard@nvidia.com>
Cc: Timur Tabi <ttabi@nvidia.com>, Alexandre Courbot <acourbot@nvidia.com>,
 "lossin@kernel.org" <lossin@kernel.org>,
 "a.hindborg@kernel.org" <a.hindborg@kernel.org>,
 "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
 "aliceryhl@google.com" <aliceryhl@google.com>, Zhi Wang <zhiw@nvidia.com>,
 "simona@ffwll.ch" <simona@ffwll.ch>,
 "alex.gaynor@gmail.com" <alex.gaynor@gmail.com>,
 "ojeda@kernel.org" <ojeda@kernel.org>, "tmgross@umich.edu"
 <tmgross@umich.edu>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
 "bjorn3_gh@protonmail.com" <bjorn3_gh@protonmail.com>,
 Edwin Peer <epeer@nvidia.com>, "airlied@gmail.com" <airlied@gmail.com>,
 Joel Fernandes <joelagnelf@nvidia.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "gary@garyguo.net" <gary@garyguo.net>, Alistair Popple <apopple@nvidia.com>
References: <20251106035435.619949-1-jhubbard@nvidia.com>
 <20251106035435.619949-7-jhubbard@nvidia.com>
 <fc6616d404d8fd04a62bd90fa0f79e2c9d2a17da.camel@nvidia.com>
 <1c86eda2-b9ca-426c-8813-f91ddcd22085@kernel.org>
 <4d93d66d-d186-4b0c-b51d-94303c58b791@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <4d93d66d-d186-4b0c-b51d-94303c58b791@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/25 11:18 PM, John Hubbard wrote:
> I'm thinking we can either do it, before or after the big pending
> set of patches that have been posted so far, probably.

I'd prefer doing it before, it ensures we have consistent style throughout the
driver and gives the chance to cleanup unnecessary imports that are covered by
prelude.


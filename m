Return-Path: <linux-kernel+bounces-836803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43005BAA98E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 22:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD4E61920344
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 20:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84322522A1;
	Mon, 29 Sep 2025 20:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCf0Bpat"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FD61E51FA;
	Mon, 29 Sep 2025 20:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759177930; cv=none; b=qzqM3QcLxEfT/BsphVqVSw9jd1EyHLImw973703yVMcBizdlV9TLh2kwwBPBDhaPSwJY204a0d9VqNsT1eIZyWh0GeR2iXUGUNszvZTu9YOt+LmXuWpnNZXRqlq97WSp7UWxv8xr5OUHStZdjdXhmEtQ34YMtu6g2nYWSh+pgwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759177930; c=relaxed/simple;
	bh=ne+Iy9QthEM/h4gXruzj9mfQSwF9p/v7sj7AC4pgo+4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=LrrFAuJMh9QzGddcbcMcAd8ANCTbOXnYEPOJzNlHUuXMAQaJ67w99CsWTonA3YVe5xF/Zl3RS2GMQxWGPEN2s+caa/mg0RY8SrhI33lK2NdLAgrJGciBSqWxBJHYB6m9eeiUjDjoP4I+drNaywyvD0qiYfzMY7qwCOmanNqufQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pCf0Bpat; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F22C4CEF4;
	Mon, 29 Sep 2025 20:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759177929;
	bh=ne+Iy9QthEM/h4gXruzj9mfQSwF9p/v7sj7AC4pgo+4=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=pCf0Bpat2e/6sMP9BFpxqNCX9HDxD7wCA+PJNzyMTERWbxQdoFdEdM2+/EEtYn74X
	 EdNov68tcVMXnqIAXK9doBhbKr5ITjnbwMArPdHPIgGGt2HFtGS7NtfKrTJ8nAUEic
	 FmAE/3WFAzT3yWpnYWPEz4KGEmsONMYO89oMQmepWiXjoAzIDN4ffpy8Qn20yJQP4x
	 xxjZbNA1w3ygRq6hz5zKd2ubTjxrZ4vtVzrZyFGq+6hUzuh3dkNA4zF6PVYDuhYiRB
	 y1FbPSpr3y0oYgZDy6xr32bf26H5leMleyVti8M41q/DNNqktBsI2IihLdrKzc4Ku6
	 KtRQdBZNjYPpA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Sep 2025 22:32:04 +0200
Message-Id: <DD5KJ1WIMGU9.19TA3OW7MMGBY@kernel.org>
Subject: Re: [PATCH] rust: slab: add basic slab module
Cc: "Elijah Wright" <git@elijahs.space>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Vlastimil Babka" <vbabka@suse.cz>, "Liam R.
 Howlett" <Liam.Howlett@oracle.com>, "Uladzislau Rezki" <urezki@gmail.com>,
 <linux-mm@kvack.org>
To: "Elijah" <me@elijahs.space>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250924193643.4001-1-git@elijahs.space>
 <DD1SGLU4180C.361W5XLH76XNC@kernel.org>
 <DD4IKU7O94WN.2VALE9M80XGQ7@kernel.org>
 <f6b874f7-0031-4a7e-b781-f888249f25af@elijahs.space>
In-Reply-To: <f6b874f7-0031-4a7e-b781-f888249f25af@elijahs.space>

On Mon Sep 29, 2025 at 4:11 PM CEST, Elijah wrote:
> On 9/28/2025 7:47 AM, Danilo Krummrich wrote:
>> On Thu Sep 25, 2025 at 11:54 AM CEST, Danilo Krummrich wrote:
>>>    (3) Implement a macro to generate a custom KmemCache Allocator trait
>>>        implementation for every KmemCache instance with a static lifeti=
me.
>>=20
>> Thinking about it a bit more, I think we should go with option (3) for n=
ow.
>
> do you want me to implement that now? if so I can take a look in a few ho=
urs

I think it is what we settle with, so if you want to work on that, that'd b=
e
great! :)


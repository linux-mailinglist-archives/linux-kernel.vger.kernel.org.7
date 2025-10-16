Return-Path: <linux-kernel+bounces-856964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 516E3BE58D4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 23:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ADF80354A4D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 21:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412332BD001;
	Thu, 16 Oct 2025 21:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xvlr9Iry"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98632B665;
	Thu, 16 Oct 2025 21:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760649436; cv=none; b=CDYya7f71gs7EpnugJBSrUAcNEE2sg3F0HAKw9VK4HWoVg8COx3UnNiGouMIXu0cf6U3o2j4EhEQbM2UWfDFK4SIohTpTpLBPFz64fh4VLkea2qjUqDM1Q6p4qdIAskSVvqoPFqIekJu5uzmpv1IcKtjX6yb1RdG7Bx04Jc0KcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760649436; c=relaxed/simple;
	bh=T1k1zbyAGxaJSzErLqwjixIBBEZ2/lxMQ2Fffak3Fak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AFAtPHReV5fVuox/FEfnpIIETqXp9QICKe9OO9i+UlXp7o6GSzqXUwpBpuW40mIXf0x1bpIa3/22CCmnIArGZ8Uq8DZWS6gaqL6PZFDdHKhlm4KPmt7xao9JqyWs+GZfmc0T4hJ9a3cpf0MALTYcMouo/qORVm/TVgqsJRv798E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xvlr9Iry; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB8CCC4CEF1;
	Thu, 16 Oct 2025 21:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760649436;
	bh=T1k1zbyAGxaJSzErLqwjixIBBEZ2/lxMQ2Fffak3Fak=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Xvlr9Iry/928SbHn9B86kgWNHIdrv6C4aS018CNw9wthF4EEx746YwXCWqAZbnGOP
	 Q346XtBF5zL0nqoNm1Jspno6QdogKe9j+umOLOImYiv/e8mqr2fxy9IiKiMbNI/GsF
	 tTnJH5bLeRC5sC0UBCm3l9TQmlqKG8hNqG/JZPdclcEZvAwNzBuzyUOI4DFy54Qnwv
	 /kLwMDDAELOGBMdj8HpxBfgiXMs0Ouy5SdnnaFiacsCUJdE1HAY/3WT10mrhZ/MBsM
	 xsj60ikZDZgptOxxMiqQAO941mT4W3y3D8qUryPemV7/Byb2wr5jRiNgn6+Ryds/Rf
	 OMgPfXjuEJn6w==
Message-ID: <7b4d45a1-43c4-4ceb-8f37-8d37825290f5@kernel.org>
Date: Thu, 16 Oct 2025 23:17:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: drm/gem: Remove Object.dev
To: Lyude Paul <lyude@redhat.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Asahi Lina <lina+kernel@asahilina.net>,
 Shankari Anand <shankari.ak0208@gmail.com>
References: <20251016202044.2748678-1-lyude@redhat.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20251016202044.2748678-1-lyude@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/16/25 10:18 PM, Lyude Paul wrote:
> I noticed by chance that there's actually already a pointer to this in
> struct drm_gem_object. So, no use in carrying this around!
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Acked-by: Danilo Krummrich <dakr@kernel.org>


Return-Path: <linux-kernel+bounces-801687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5409EB448C7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 23:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25A8616D38C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 21:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC252BDC0B;
	Thu,  4 Sep 2025 21:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGf000TS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C7EBA4A;
	Thu,  4 Sep 2025 21:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757022499; cv=none; b=Wqbq26JKcr6DFk2+oBA2UDeYibPFs4Lw04USCmOP5M1UoyXqQj5khcPoTzAZTfpKC4CgDrMcnNSdggIZCZIt/CvDybklmL+2R2SSM/Y9tCWwzcrs4FdsZ2USleopHxOwkkerWr9EBwZeMm/2z6WdjnDJ+GYZ1Hecar+lHcyjLFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757022499; c=relaxed/simple;
	bh=VDbwxYVxxYyJuSYmm8cSK74aNcGp3i9fdI3e7bLZkv8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=SwMUzBH77Qi3NM0iOuqdD6giDUDl+P/6NdApuyJq+4lWvDWvk4+AUgWM3DEBakpbTk5hzKKaoXEiWOV1G/uaZiZLgf/YXd+kDRKhzPHCkeiZCHoEZ09uaJrUvsG2p9vLBzI4gaqow7wI+RTIzXLtmLpT7pio91Ugd68XyKJTank=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGf000TS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 374E1C4CEF0;
	Thu,  4 Sep 2025 21:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757022498;
	bh=VDbwxYVxxYyJuSYmm8cSK74aNcGp3i9fdI3e7bLZkv8=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=ZGf000TSQ9cUM1wpH1YXO6SbMYul7klwd76fQt+i9xmcZBg2oMYTwAoFhS8y2Wi2N
	 krAbPkMfMfv2yDUz9Rx+VVqv4BgbPSjZ5uniewn2bTBhF6i91tb6OIPANTHvq+80fj
	 NnhtPAGx9+oQRj2I1spIypyrbMRVtAAAEuYAa+YOlDcLFf5sFHFMTFeN9oOh82aJaC
	 Ri81hJwRfCLpB0OjoUJ97Vy/Bhs4kA5bSoguW2tZNnJ/Hmnw3LE/zj92vnhwo87SXV
	 XT15ui7oZw7oUmzgYmaBdRFLOkY78aY9hXlcGBuFPc9e5kNzdEq31T0ZjEtoG1PMlA
	 U5nWUv085HDnA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Sep 2025 23:48:13 +0200
Message-Id: <DCKCHQI8SNVL.1P5HM3R0U61Y2@kernel.org>
Subject: Re: [PATCH v4 0/5] Rust infrastructure for sg_table and scatterlist
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: <akpm@linux-foundation.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <abdiel.janulgue@gmail.com>,
 <acourbot@nvidia.com>, <jgg@ziepe.ca>, <lyude@redhat.com>,
 <robin.murphy@arm.com>, <daniel.almeida@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250828133323.53311-1-dakr@kernel.org>
In-Reply-To: <20250828133323.53311-1-dakr@kernel.org>

On Thu Aug 28, 2025 at 3:32 PM CEST, Danilo Krummrich wrote:
> Danilo Krummrich (5):
>   rust: dma: implement DataDirection
>   rust: dma: add type alias for bindings::dma_addr_t
>   rust: scatterlist: Add abstraction for sg_table
>   samples: rust: dma: add sample code for SGTable
>   MAINTAINERS: rust: dma: add scatterlist files

Applied to drm-rust-next, thanks!


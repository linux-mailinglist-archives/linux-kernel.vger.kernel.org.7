Return-Path: <linux-kernel+bounces-783108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8651B32971
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD7695A6097
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 14:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88522E62BA;
	Sat, 23 Aug 2025 14:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pcE5YBrR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C96C155C97;
	Sat, 23 Aug 2025 14:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755961053; cv=none; b=Q6Mt2sLnVD8sgD6uZhN4Of5WerZcn3X/V56k20VtnKArwP+9LLGdg4ZGcR+GVILOTHS95owMnb8Arqx7LCY1tCaTGICQbygm86/KtltAkkBPOot8xhW5hel25yZVrDh6t5BPGKzERDw04ZsdX5c0Oo5bR3ohLG0/cnLZ0r8tolA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755961053; c=relaxed/simple;
	bh=HJ8X7i1qzTJWC6Tli88d5d588o1VeDqhwG52uj/Cx8M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=LV2GQW6amUV1X+oQqot/Iz+R34QO0REdsYthomHf5AepJNTrP5KBl4osi2rJqolC5UzQSz8kPlKWdf0HZ65EzUihUpwgDwsoJCZioKbS+uSxhuby4GB/UQr4cEBdkTHbIWjBZzTHHAswzFatRPS/TDnBEtgNO+WqgEMbHgySE/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pcE5YBrR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F5C8C4CEE7;
	Sat, 23 Aug 2025 14:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755961051;
	bh=HJ8X7i1qzTJWC6Tli88d5d588o1VeDqhwG52uj/Cx8M=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=pcE5YBrRvba+U6qYlsvx+lAxqVazuJjhdrAxn/kW76YRfrtQzDVj8Qfw8m3NvuigF
	 7+CaSISGK1yGLXlGH17cxqFpNQ/Jvyp95NF2jxSAq7GZksyTqiomyDEGnDm/MB31qL
	 ZVI0oq0UMnsYFL3evDQnpwg8PMz9ibhTgpEQfFpmtY0FImHZ00RVR3ZA1C2+o2jtjf
	 sxQVLv83qov2sGDGFNec3pMJlCias4zS9eDqZeQCWNdWyHLWHPXf7HPpr3sJbwhJFn
	 wXlbfwlnCWBi+/cHim5hlOV/QrS9RRzs+DkRakD9uRih/a5S6HNkBfHajINCljcj/8
	 apYErnoWZMiBg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 23 Aug 2025 16:57:26 +0200
Message-Id: <DC9W8OMI5UT6.3RPWM2I4K10BS@kernel.org>
Subject: Re: [PATCH v2 3/5] rust: scatterlist: Add type-state abstraction
 for sg_table
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, <akpm@linux-foundation.org>,
 <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <abdiel.janulgue@gmail.com>, <lyude@redhat.com>, <robin.murphy@arm.com>,
 <daniel.almeida@collabora.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Jason Gunthorpe" <jgg@ziepe.ca>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250820165431.170195-1-dakr@kernel.org>
 <20250820165431.170195-4-dakr@kernel.org>
 <DC9U87GQ7ONZ.1489DEN1PPUAC@nvidia.com> <20250823143211.GB1121521@ziepe.ca>
In-Reply-To: <20250823143211.GB1121521@ziepe.ca>

On Sat Aug 23, 2025 at 4:32 PM CEST, Jason Gunthorpe wrote:
> Correct, this is misusing the API, and I don't know if the lengths are
> even guarenteed to be zero.

Hopefully it is. Otherwise, it's not only the documentation if sg_dma_addre=
ss()
being wrong, but also a few drivers and maybe iommu_dma_unmap_sg(). However=
,
since it's a specific implementation of the API, it might be correct relyin=
g on
the sg_dma_len() =3D=3D 0 check.

In any case, I think we can just use the nents field of struct sg_table, ju=
st
like for_each_sgtable_dma_sg() does.


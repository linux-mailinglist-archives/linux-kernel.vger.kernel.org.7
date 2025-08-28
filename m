Return-Path: <linux-kernel+bounces-790792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F249B3AD07
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 23:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC7F8567EAF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 21:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCFA2C08D6;
	Thu, 28 Aug 2025 21:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9fWpClX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6761B29BD90;
	Thu, 28 Aug 2025 21:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756418046; cv=none; b=BsIXvnMZWXHAnUom5iqF717jOwOvFhSXgp2E+v9Ch4ECQeaHXyXN8v4WmnXjrs8m44umiB95rw8vXUminXDydX45fr2GAlDoKJ82SZbTbtwVvALzgIcvqEc+lskjvUQbRoLjnkc5SKIjCmV/63mQQmR6fin/AqApWTmT2fyNVog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756418046; c=relaxed/simple;
	bh=YuCjMILfFRDLM9IotFFtm6J1AMM1IlbXrF51dAP7i0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kwlXGffA8fUq6BSf0yUDKBKIcY4mijpj9v1dfqe8Zs8fRng4rBhdrOuh66UqY2Zn3/4WuZkZOBYPF+QTVJPCtX8FkXUj2hwZ0kIGb13+O5JS+ZHNnXlhhOH3rhaFnsyPlryzY0qHumhq4ftykXyCy0z7okJboR/B0/HDJeUuF0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9fWpClX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB9EC4CEEB;
	Thu, 28 Aug 2025 21:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756418045;
	bh=YuCjMILfFRDLM9IotFFtm6J1AMM1IlbXrF51dAP7i0s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=d9fWpClXkIn3791ahnWtbU3Dncfz81HQZJkoxg+K0z/a808pgEzp+HVr7/D08tYgU
	 gmOuKmc2d9FeeQS2v5IYju+mbG7uCOo8uJoogmuQ72wj9N6Nl1fGapjBaWug2Q6ZR1
	 gGrChHg1Kgx2EEdgXbW21JEHfRX4Qlk1SVvnY1drE9qvGLeMDELLxXOW07noIi20Bn
	 e5Sp37iRI29nuNHTZlZ+otTDiRuc8eZ+bY9ddneX7ilFdPsV2XOjOwcZwkS75DboBD
	 AKXA4cCL7vMjpmoRlhGjtgzVPZHHVVIm2p09n840RyRkVVFjJ7ufoZXBinB/d3bWkI
	 id+7W2+tbU9Vg==
Message-ID: <76064a67-206d-411e-87b0-651c338cf204@kernel.org>
Date: Thu, 28 Aug 2025 23:54:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: gpu: nova-core: arm32 build errors
To: John Hubbard <jhubbard@nvidia.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250828160247.37492-1-ojeda@kernel.org>
 <b680c343-ba97-4eb4-b426-56e318dce492@kernel.org>
 <DCEB1J2P3MZS.3IGXEYP0MAC5H@kernel.org>
 <CANiq72mkPqFnb4ztiCokE6+ntVSmgOTgERshg-4SMmLboFOqNg@mail.gmail.com>
 <bc2b45b0-eb0f-4519-a398-2f0707d45d80@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <bc2b45b0-eb0f-4519-a398-2f0707d45d80@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/28/25 11:45 PM, John Hubbard wrote:
> So Nova should definitely depend upon 64-bit configs.

Yeah, I fully agree.

But I think it would have been good to have a consumer for the generic APIs that
has to deal with it, which I think was also Miguel's point.

I will send a patch for Nova to depend on 64-bit. Independent of that, I think
the code requires a few cleanups (e.g. avoiding `as` casts or using the DMA
type).

I will also further look into how we can help other drivers from the perspective
of the DMA layer to deal with this, e.g. in the context of a DmaRage type, etc.

- Danilo


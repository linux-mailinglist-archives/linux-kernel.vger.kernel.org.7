Return-Path: <linux-kernel+bounces-854579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4D6BDEC83
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6A5E3E5DE8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DD6227B95;
	Wed, 15 Oct 2025 13:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/poIZWc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B94021E097;
	Wed, 15 Oct 2025 13:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760535566; cv=none; b=WtgA2/Tm94fm3h/vrhCcDpTcFhr40AFwuePaxhs2WeIAf26XjPdLWxIHpRqwdU9Uk/+mz7kf58ipvx2HHZc5/HOPS+xPJspzu5XhosgdBu1EcLgbqKBuzTTocTRv5JfwubNbv6LSyQR+20qo+j2ViL2pGFpWj8Dnq2Bd4XesCKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760535566; c=relaxed/simple;
	bh=DLGr/JRSYdd2THyi/Qlx9WbQlHXgP2AW6QiwTenTm5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HyfK169Iqi7HlMILAVSvB4wBOZ7AtdRgLroQIKYzTWNO1PJbIvHCglrl9kLFmEg9FIA5rGpCGTxKmgStmG7IlCFvaeHPBk4UQk7z5YhOzLqS8t21gOfzB3/u64U57EGdvl8AfWr7TPT2M4zuRAQhTvsuon5Bku8hkXFqKj0OF8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/poIZWc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A5DC4CEF8;
	Wed, 15 Oct 2025 13:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760535565;
	bh=DLGr/JRSYdd2THyi/Qlx9WbQlHXgP2AW6QiwTenTm5Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=g/poIZWcz+5f2BNgIIaO4bBp1i8a7pAPu54UlecaztDH0Rr4ymt1Df9wflKJhH+RJ
	 UqWWyUs3SmAfeUTs7oC8LNxmVhO1yvBjgRZTLNiDEDS4KNxAtfWb8GaAejcage9H40
	 W9O+9CAIpNuphF9rHauSxsWrfcOPlGqBB29Rs3oG/e4KnFDzi84idG2/NkjX51l88r
	 u2XjwC9K/H55FZmdgVs+d6r9l3cPp4Ad/5s9M468PhIYHSmSUDHbgvdpnUq5pnDi2p
	 fDhl1h+S6Ntg+xT66kPsmxlN74XmsmxEJxXioO6QKTnhpgUYJRqknvTAKsl/TMEfYU
	 MD5gBLZ4iDqNA==
Message-ID: <a45af9ee-73c4-4097-932d-de671435f5e0@kernel.org>
Date: Wed, 15 Oct 2025 15:39:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/gpuvm: Fix kernel-doc warning for
 drm_gpuvm_map_req.map
To: Ankan Biswas <spyjetfayed@gmail.com>
Cc: bbrezillon@kernel.org, himal.prasad.ghimiray@intel.com,
 matt.coster@imgtec.com, robin.clark@oss.qualcomm.com,
 matthew.brost@intel.com, aliceryhl@google.com,
 thomas.hellstrom@linux.intel.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, simona@ffwll.ch,
 skhan@linuxfoundation.org, khalid@kernel.org, david.hunter.linux@gmail.com,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 dri-devel@lists.freedesktop.org, Stephen Rothwell <sfr@canb.auug.org.au>
References: <20251015113656.21447-1-spyjetfayed@gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20251015113656.21447-1-spyjetfayed@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/15/25 1:31 PM, Ankan Biswas wrote:
> The kernel-doc for struct drm_gpuvm_map_req.map was added as '@op_map'
> instead of '@map', leading to this warning during htmldocs build:
> 
> WARNING: include/drm/drm_gpuvm.h:1083 struct member 'map' not described in 'drm_gpuvm_map_req'
> 
> Fixes: 000a45dce7ad ("drm/gpuvm: Pass map arguments through a struct")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>

Please add a Closes: tag, checkpatch.pl should warn about this.

Thanks,
Danilo


Return-Path: <linux-kernel+bounces-752116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 408ADB1716C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38D5A3A91FA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EA624DCED;
	Thu, 31 Jul 2025 12:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oILqVekX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B38230BC9
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 12:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753965714; cv=none; b=aDduhFqbR19RUBua1gJr26enQZJGP1qnGtl7e6NlIRgUC84olvJksKvT0LGTtXBjBkH6HrdE/4WW3St0D7BLCIuUlrdUnuiLaDJ8GMGItibhpYUvKYy9YmgLP9dwYyWWwgaHjFVZ37fKnjLyfDTbkMR1mKr083qei0kEuQ1bLmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753965714; c=relaxed/simple;
	bh=L3uUJnS0mt0pWzaA7vfIWRYx1MnbiUjacRjT8qGGrBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fIYMqUHGUQICwbk3lFSgYbDpwFAnBg/7fD2VqkD72rUpGINSxC3PLapTLcSriVX3UMmcAx5a/bQIbuvzu6t10VxMpDrFzpjH0JwhkiK32OvBzQ4H0Dv+BRQEbH04bfp3pTnBAMPO77C20H2eY+jmSiF+oRgs/vgX9GCw0TcpJag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oILqVekX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9ACDC4CEEF;
	Thu, 31 Jul 2025 12:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753965713;
	bh=L3uUJnS0mt0pWzaA7vfIWRYx1MnbiUjacRjT8qGGrBw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oILqVekXQ4hKsA+kcUjV3WlYn0Gf8WWcIkkIfUacysFnmmgCE5iw//U5XRHrpnT7l
	 Ij2lq0Ffu7cv6KhubX5a4CrGNHJetEEDFeg0WA84d/igFTRIw0FRkZ/++Ca8GwshzI
	 VxOvhQvfWtQl6A6r3yP63MOdqJ7GhOvBC9QX/iX0xLy2cOi4u0IBmQ6/qKbzg7rPq2
	 olp9LbLnCucyu+LsdY1CBbtkw2ACA4UUU2cvl6gJwvMG7ZNUH3ss1DOEmQ9MYIVFsx
	 tVwLTQjwWqKzHec5tKZRyebj2sa9l3Fx6mT4ohqCHUCG1UWvHo+zqzdpsJ7BuvYaV0
	 XpVbcvWosIdpg==
Message-ID: <11a42824-b240-43f0-980a-8222be872483@kernel.org>
Date: Thu, 31 Jul 2025 18:11:41 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [git pull] drm for 6.17-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Dave Airlie <airlied@gmail.com>, Dillon Varone <dillon.varone@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Wenjing Liu <wenjing.liu@amd.com>
Cc: Simona Vetter <simona@ffwll.ch>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <CAPM=9tzVm80-v6_5nt6kko3nR+aQLZ7R98i419FV8f4-ayQWUw@mail.gmail.com>
 <CAHk-=wirxHy+KU6jmtO2dzmGQ1BwaOdd5Mjtrc40fGvZVULQQg@mail.gmail.com>
 <CAHk-=wjn5Pg2Gp=o2NVv-nRKqE=E75AxUypWCCpQ7MDXuHx+YA@mail.gmail.com>
 <CAHk-=whnuRuQEky2GsCDRQSf1dZbpoqnK+puw=qdR-D7aap9SQ@mail.gmail.com>
 <CAPM=9tygJqtbmYzB5gktxp-7fBfv_9gNq9p9+SdZ6wiYE2-6PQ@mail.gmail.com>
 <CAHk-=whB1X1c6rWbY34wZVGcnaY=yfPGLOtjd5h3mMDGV9Lbkg@mail.gmail.com>
 <CAPM=9tyb1mELymOJv62KJom4mGF0UBifbVqLJUFdS1C7Eeu3jg@mail.gmail.com>
 <CAPM=9tzDWmYBKQGB0ybDzhYHkg0p98_6PJA8OuPahRep8+QPvQ@mail.gmail.com>
 <CAHk-=whOb_ebQQbnXeqb8uXf32WA32nrL3=HQ2y8hBm9hFgVOw@mail.gmail.com>
 <CAHk-=wh+79KkMXsNqyPxeU+c5U2h-n13ko6J_QzwtjyYCKhrSw@mail.gmail.com>
 <CAHk-=wgEGn0azq0n5BfWg4ZStrZYanLCX1a+quug7HKmjimhpw@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAHk-=wgEGn0azq0n5BfWg4ZStrZYanLCX1a+quug7HKmjimhpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/31/25 10:37 AM, Linus Torvalds wrote:
> On Wed, 30 Jul 2025 at 21:58, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> d7b618bc41ee3d44c070212dff93949702ede997 is the first bad commit
>>      drm/amd/display: Refactor DSC cap calculations
>>
>> Let me go see how painful it is to just revert it from top-of-tree.
> 
> So with that reverted (didn't require a lot of fixing, only minor
> unrelated context added nearby later), current top-of-tree works for
> me again.
> 
> The revert I used for testing attached just so people can see exactly
> what I did.
> 
> It's late here, I wasn't getting any more work done today anyway, so
> I'll leave it like this for now.
> 
> I can continue to do the merge window with this revert purely local
> for a while, so if somebody comes up with a proper fix, I can test
> that out.
> 
>              Linus

Pure guess from looking at the diff from 
d7b618bc41ee3d44c070212dff93949702ede997, maybe the NULL ptr is a deref 
on a pointer that doesn't have funcs declared being an older GPU.  So 
maybe check for funcs?

diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c 
b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
index a454d16e6586..95d51de26c0b 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
@@ -673,7 +673,7 @@ static void get_dsc_enc_caps(
                 return;

         /* check if reported cap global or only for a single DCN DSC enc */
-       if (dsc->funcs->dsc_get_enc_caps) {
+       if (dsc->funcs && dsc->funcs->dsc_get_enc_caps) {
                 if (!dsc->ctx->dc->debug.disable_dsc)
                         dsc->funcs->dsc_get_enc_caps(dsc_enc_caps, 
pixel_clock_100Hz);
         } else {


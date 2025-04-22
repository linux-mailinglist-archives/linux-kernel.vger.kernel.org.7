Return-Path: <linux-kernel+bounces-614639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B50D8A96F6B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 16:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC18F1896CB8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 14:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EE728EA67;
	Tue, 22 Apr 2025 14:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sp4msGdI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E241F4706;
	Tue, 22 Apr 2025 14:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745333792; cv=none; b=l+dqCj6IxXL8znvHPEGjf3Gtyq1FA2Gd+m4Qo1G0ROQ1HfRjAl9dK5OAqHIlGjVanzos/m8C6ARnlajmupiJX7PW6m8U8dtonPczMMM5Ka1WnV/247xsbizHZDaofJ/7zl3+14NO9pdvDxVB5ak/FicmjlsC0IwBAtkkqJzzeI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745333792; c=relaxed/simple;
	bh=E+U3qa/+M2Msx+raT0FohxtswXCiQETa1u6IufUDpnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ehYRa9d5kZST2MMEjZ6fmy4KJaeCtygH+b+B63yYa5pLONck+DHQLRHk/pR8caEn7OwdmZUPvjqLPiE35DuSk3tGR7CnUy1ZaWsITufEkHVuGb6Kw/lyawSuUeO9c9uexZLKt2o24LbPxZi+O0K9wrW0qUY8UQzOapnnpyfjrMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sp4msGdI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D9ABC4CEE9;
	Tue, 22 Apr 2025 14:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745333791;
	bh=E+U3qa/+M2Msx+raT0FohxtswXCiQETa1u6IufUDpnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sp4msGdId7YV9KRqV+TxMuXT+ifIpgqbBjEy4Bob00MC8M4GFlRG1+OD5ehMy9hAI
	 cyGf4b6sQvnpv8mreGunbdnto751CiK06pNeh5fJtEnbSC1etcsty9AW1LuwFPi6RV
	 VkJzJ6y+eV4iF18JPgGzbQJIsmRWvkVH6amawh/E4KDSmpP0u/iBwLFRFBQpc+M3pm
	 nPgSC08Mi6ww+ijP9F2eeKzIMeQKofkTkdJzT/3ACJsz7G8x54hT9oVG9w/Av2zQT6
	 IGs7Bj7953K3ZkA3LbyQpxEZadQShSF+z6D3XhfHrkw/OfQ1TJ8jPy6oLYCa178jNy
	 Z9a+k00nW1Jgw==
Date: Tue, 22 Apr 2025 07:56:28 -0700
From: Kees Cook <kees@kernel.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, Jesse Zhang <jesse.zhang@amd.com>,
	Tim Huang <Tim.Huang@amd.com>,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Alexander Richards <electrodeyt@gmail.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] drm/amdgpu/atom: Work around vbios NULL offset false
 positive
Message-ID: <202504220755.179FD11DAD@keescook>
References: <20250421215833.work.924-kees@kernel.org>
 <CADnq5_MbGS+DBRZhQccqP-o50vvv6uiT31msefRTw5bMydAAKg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_MbGS+DBRZhQccqP-o50vvv6uiT31msefRTw5bMydAAKg@mail.gmail.com>

On Tue, Apr 22, 2025 at 09:22:26AM -0400, Alex Deucher wrote:
> On Mon, Apr 21, 2025 at 5:59 PM Kees Cook <kees@kernel.org> wrote:
> >
> > GCC really does not want to consider NULL (or near-NULL) addresses as
> > valid, so calculations based off of NULL end up getting range-tracked into
> > being an offset wthin a 0 byte array. It gets especially mad about this:
> >
> >                 if (vbios_str == NULL)
> >                         vbios_str += sizeof(BIOS_ATOM_PREFIX) - 1;
> >         ...
> >         if (vbios_str != NULL && *vbios_str == 0)
> >                 vbios_str++;
> >
> > It sees this as being "sizeof(BIOS_ATOM_PREFIX) - 1" byte offset from
> > NULL, when building with -Warray-bounds (and the coming
> > -fdiagnostic-details flag):
> >
> > In function 'atom_get_vbios_pn',
> >     inlined from 'amdgpu_atom_parse' at drivers/gpu/drm/amd/amdgpu/atom.c:1553:2:
> > drivers/gpu/drm/amd/amdgpu/atom.c:1447:34: error: array subscript 0 is outside array bounds of 'unsigned char[0]' [-Werror=array-bounds=]
> >  1447 |         if (vbios_str != NULL && *vbios_str == 0)
> >       |                                  ^~~~~~~~~~
> >   'amdgpu_atom_parse': events 1-2
> >  1444 |                 if (vbios_str == NULL)
> >       |                    ^
> >       |                    |
> >       |                    (1) when the condition is evaluated to true
> > ......
> >  1447 |         if (vbios_str != NULL && *vbios_str == 0)
> >       |                                  ~~~~~~~~~~
> >       |                                  |
> >       |                                  (2) out of array bounds here
> > In function 'amdgpu_atom_parse':
> > cc1: note: source object is likely at address zero
> >
> > As there isn't a sane way to convince it otherwise, hide vbios_str from
> > GCC's optimizer to avoid the warning so we can get closer to enabling
> > -Warray-bounds globally.
> >
> > Signed-off-by: Kees Cook <kees@kernel.org>
> 
> Acked-by: Alex Deucher <alexander.deucher@amd.com>

Thanks!

> Do you want me to pick this up, or do you want to take this through
> some other tree?

Whatever is easier for you. I'm happy to carry it if you'd like. :)
There's no rush on these -- it's been a long road to getting
-Warray-bounds enabled. ;)

-- 
Kees Cook


Return-Path: <linux-kernel+bounces-790636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99105B3AB26
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 21:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2218698604B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 19:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3ED2797B8;
	Thu, 28 Aug 2025 19:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKjABHhx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D3027E079;
	Thu, 28 Aug 2025 19:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756411108; cv=none; b=pQrcaHXYP6vtATT8WeZt99vEPOTxHem18SKO5IO1Vvf19LPW3VfuLBOUpJmGFnN3wzLspmQFs582qqRX4vZuh7KCqac71jp2a3X5TQtkn71e84aqkT7Rl630k1pOxpzs/m/J4ywl0JCaeEj+RVu9dMa56egzdHiRKWXnY3pLPsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756411108; c=relaxed/simple;
	bh=IL8Nv0+2v6BSx6uhM82XpLiqmPiQ1BQkBmIbIkgLXl4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=kdF8oUsraQI8cVUF90TaqHXI1MyNgJW6zv6wuMviBoMBjtm8D8MQqNgQ19kZ3He85udxc5U+Jf73ta+I3vuE9LKNyAOP1QBpaEIc4LmIxnpTTGfswZGppnataFe0u/+BKsTafPmD6yzor3SpCdysiHpyI+6IBIS/OO4+EIn/DGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKjABHhx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5731C4CEF7;
	Thu, 28 Aug 2025 19:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756411108;
	bh=IL8Nv0+2v6BSx6uhM82XpLiqmPiQ1BQkBmIbIkgLXl4=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=cKjABHhxolhzTGSSpNq1eYlRFx+H7KaAJg3QnbcmxcjlZ/duIZZwMsINKl1ILSAwf
	 kPCWJIrAitgZ9rkN5q87G/ri+v+1hFJCAcvrThE6O02+qmujSwT5mqgjvW2Ni+8iaz
	 Ha8CFx+mLcC5VHXI4suEsokteE8Os6sIbwpn3FoIRFZ0KuftbW7R0S63LGFdamlX/v
	 DDMoiYviTag98LgPBcAYBzdUFd2OGrjs9WnPdWXy7n5lhLP/JizMRw7dvwDpJ8GxUw
	 Giaffrbm0eMpxb/rDlzu2eXaZlKp3qPBL/Qs3i4LnetJdRKdxN6hFX0h1VedUOQtOn
	 KYsC63miJm3ig==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 Aug 2025 21:58:25 +0200
Message-Id: <DCEBRUJ383TE.R6W8YCRNZP1O@kernel.org>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: gpu: nova-core: arm32 build errors
References: <20250828160247.37492-1-ojeda@kernel.org>
 <b680c343-ba97-4eb4-b426-56e318dce492@kernel.org>
 <DCEB1J2P3MZS.3IGXEYP0MAC5H@kernel.org>
 <CANiq72mkPqFnb4ztiCokE6+ntVSmgOTgERshg-4SMmLboFOqNg@mail.gmail.com>
 <CANiq72=6Ji97UW96V-VjjbRG=ouGeHA7QXpP2gBOJYFx=oJ19w@mail.gmail.com>
In-Reply-To: <CANiq72=6Ji97UW96V-VjjbRG=ouGeHA7QXpP2gBOJYFx=oJ19w@mail.gmail.com>

On Thu Aug 28, 2025 at 9:36 PM CEST, Miguel Ojeda wrote:
> On Thu, Aug 28, 2025 at 9:31=E2=80=AFPM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
>>
>> and a `DmaAddress`
>> newtype, not just a typedef, could perhaps be nice anyway?
>
> The one from your linked patch is not a newtype though, so I guess
> there is a reason for that.

No specific reason, I didn't see a lot of value in a newtype in the first
place, depending on you answer in the other thread, may we just found some
value. :)


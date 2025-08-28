Return-Path: <linux-kernel+bounces-790765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D33B3ACB8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 23:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F6BE1C804FC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 21:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B6329D29B;
	Thu, 28 Aug 2025 21:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1cmWuxP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B94F1A8F84;
	Thu, 28 Aug 2025 21:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756416475; cv=none; b=MZ8RqPZtkaLHzSFfXA1bHRRaxqicPcx9W+2cUicTQBMvjvJrAwQmfi1rcLk5IKJlpQPJO4vs16pDxMjziQafXJ0TFYEAWf5RWNJt5x3Oybx5PhPIKC5GbgbeJxTKyLZ78eQDIAx2nao2/l4zfp3mvUeH5JYeezA9zdnJo4opbxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756416475; c=relaxed/simple;
	bh=qA1BcQ3hWIOqTfWw0aAFTPIJL30bc08GdeoDPGTnu4U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=anJhsL3esx8c5qvW3p3plZg9QaU0KU6qx3kmrtnm9dO/kYbAWGtq2T8oebQSgVm5bjInQCXNlKU2Rtfvz9PwTqPMBD8CDorrPWVa6BqGiS416rriV5zoDNthsL4ct/nJRdGUZP8Qc6tTqpprsNXrtoCvokfsV8l7fZfoNoyWOKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1cmWuxP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED67C4CEEB;
	Thu, 28 Aug 2025 21:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756416475;
	bh=qA1BcQ3hWIOqTfWw0aAFTPIJL30bc08GdeoDPGTnu4U=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=C1cmWuxPqxaSGqPC5BDtl+YVTDKgdfUwazddCx+jtuYDM0FAEFDgrW081DIHEtoU2
	 XK6G6aZK4ZTXOQC5+10V8VGaI7TD/m9PtC5KK2lmWfyi21oWFrT52HPMNjdwBhd563
	 GGrirRrmzTbLAYOu0RMAqzolC0Wxp76GwGr0i3U8piMzc5SEfih9130z2BNRa0uFuB
	 H+blxdTf8LCswMiRfsDuUYncxqOQJjbOwheAa4m/6TwKPwJ6XIBcO0fkfmLclWc4oa
	 3goXTB3MHAFxTomVp958Z/K01KUOoOUsizlYZmx15hdGW3If0QpjcSWjH68puD09rc
	 X8wIEFav6LnqA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 Aug 2025 23:27:51 +0200
Message-Id: <DCEDOBPT4VLP.R2K3EWY871F1@kernel.org>
Subject: Re: gpu: nova-core: arm32 build errors
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250828160247.37492-1-ojeda@kernel.org>
 <b680c343-ba97-4eb4-b426-56e318dce492@kernel.org>
 <DCEB1J2P3MZS.3IGXEYP0MAC5H@kernel.org>
 <CANiq72mkPqFnb4ztiCokE6+ntVSmgOTgERshg-4SMmLboFOqNg@mail.gmail.com>
 <CANiq72=6Ji97UW96V-VjjbRG=ouGeHA7QXpP2gBOJYFx=oJ19w@mail.gmail.com>
 <DCEBRUJ383TE.R6W8YCRNZP1O@kernel.org>
In-Reply-To: <DCEBRUJ383TE.R6W8YCRNZP1O@kernel.org>

On Thu Aug 28, 2025 at 9:58 PM CEST, Danilo Krummrich wrote:
> On Thu Aug 28, 2025 at 9:36 PM CEST, Miguel Ojeda wrote:
>> On Thu, Aug 28, 2025 at 9:31=E2=80=AFPM Miguel Ojeda
>> <miguel.ojeda.sandonis@gmail.com> wrote:
>>>
>>> and a `DmaAddress`
>>> newtype, not just a typedef, could perhaps be nice anyway?
>>
>> The one from your linked patch is not a newtype though, so I guess
>> there is a reason for that.
>
> No specific reason, I didn't see a lot of value in a newtype in the first
> place, depending on you answer in the other thread, may we just found som=
e
> value. :)

To expand a bit, the typdef is also for simplicity. Eventually, drivers wil=
l do
some arithmetic on the DMA address, etc.

So, if we have a new type, we'd probably want to provide methods for doing =
the
most common arithmetic operations, because we don't want to convert to/from=
 the
corresponding primitive type all the time.

At the same time we could take this further and also provide a DmaRange typ=
e,
which also considers the size for those operations.

DmaRange is actually something that I had in mind to implement subsequently=
,
because I'm not too happy with CoherentAllocation::dma_handle_with_offset()=
,
it's just too specific and insufficient.

Given that, I thought there's not that much value in making DmaAddress a ne=
w
type. (Mybe saying "no specific reason" was a slight understatement. :)

So, if the idea was to have from/to helpers, we can also do them on DmaRang=
e.

However, given that also the above only helps in a limited way for the case=
s
discussed in the other thread, I feel like the best option might still be t=
o
depend on 64-bit for Nova.


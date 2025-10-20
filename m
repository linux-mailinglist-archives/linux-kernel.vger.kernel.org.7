Return-Path: <linux-kernel+bounces-861913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B61BF3FCA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 01:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E980834E06E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 23:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACDE2F6919;
	Mon, 20 Oct 2025 23:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQjKWkZo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DDB18FC86;
	Mon, 20 Oct 2025 23:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761001668; cv=none; b=Lou2i/esBC6J+9k58QRfyyNaNrXQzbKX0ql9WneSlWHnkGlLXUf1o/FWO9dOilSS02fQCzTCXUMtTnoR7eDOJtwITp3n+kBzJpR3UrUiAxFylmvsuzIEDWAX65DfDcJT3JfTf/0v8lL0myIJn3NHUEJRQsOfi0DThNQkW3QRDns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761001668; c=relaxed/simple;
	bh=2Wa1BgnVlLMR9sWUOy65xMkiyC8G6kFyDOFsk3N3BBQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=aYiGiRMsvrpD4V/grjHo+opk/Y5g7kv3lvqEr6KY3pbdc86qIoBEC3OPKrR/FQly+GDmFvgLAWJ2CrjMvyYa7gNGPJazZqd+21sgYhODksApoI6S6ACc4l0KxWMcU8ogOGdOlRGxF9GHjNvV1FvQUS9rRSnUrJteMDUTlZaZ4/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQjKWkZo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E485C4CEFB;
	Mon, 20 Oct 2025 23:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761001667;
	bh=2Wa1BgnVlLMR9sWUOy65xMkiyC8G6kFyDOFsk3N3BBQ=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=jQjKWkZovtgan8oP7x3Yg9nVAcUQxzBrpl+k+LoV1DWOEGDhznrBSuIC4YAs5XNsT
	 kWJR568cr7apF1VPYjDqs+3yM0/ClSQ4wvOcC3cEuBZEUlZgFsQGhajhQULk9XLQq3
	 tj8kN04500N1jT2BlE5VKEtYcJnDI9+zpX2sQmC6eG6RNhdRYr8c7AW1E+as8+CPJW
	 jaO1ZZOeyh2TIqs1r/qj6w20IBbYGpKbU6ZsDjCV9wrDDL9JRlqBVOA5jwRC3u6hEy
	 WB98/dZafN5t6EKhvZ0FBi62uIx9+YD2IRJrTbEOHsN0RvJBV/j+1qnEM+DuSRt/DJ
	 aGuCg2/ju2YUQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Oct 2025 01:07:40 +0200
Message-Id: <DDNIZMOBCE1Z.1ZOQ83TKTHQ28@kernel.org>
Subject: Re: [PATCH v7.1 2/4] gpu: nova-core: bitfield: Move
 bitfield-specific code from register! into new macro
Cc: "Joel Fernandes" <joelagnelf@nvidia.com>, "Yury Norov"
 <yury.norov@gmail.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "rust-for-linux@vger.kernel.org"
 <rust-for-linux@vger.kernel.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 "bjorn3_gh@protonmail.com" <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "Timur
 Tabi" <ttabi@nvidia.com>, "joel@joelfernandes.org"
 <joel@joelfernandes.org>, "Elle Rhumsaa" <elle@weathered-steel.dev>,
 "Daniel Almeida" <daniel.almeida@collabora.com>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, "Edwin
 Peer" <epeer@nvidia.com>
To: "John Hubbard" <jhubbard@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251016151323.1201196-1-joelagnelf@nvidia.com>
 <20251016151323.1201196-3-joelagnelf@nvidia.com> <aPEv_UO4vViOcOvN@yury>
 <2CF462DB-D2C8-473F-9D70-522E6AFEDCE4@nvidia.com>
 <DDJZY40SO5EF.2066SEKKQ4U8I@kernel.org>
 <e4f5ca12-bf67-4b48-97a1-7ab2c771056e@nvidia.com>
 <aa3b4ebf-12c9-4ffd-bfd9-bcd920970309@nvidia.com>
In-Reply-To: <aa3b4ebf-12c9-4ffd-bfd9-bcd920970309@nvidia.com>

On Tue Oct 21, 2025 at 12:50 AM CEST, John Hubbard wrote:
> On 10/16/25 12:39 PM, John Hubbard wrote:
>> On 10/16/25 12:34 PM, Danilo Krummrich wrote:
>>> On Thu Oct 16, 2025 at 9:28 PM CEST, Joel Fernandes wrote:
>>>>> On Oct 16, 2025, at 1:48=E2=80=AFPM, Yury Norov <yury.norov@gmail.com=
> wrote:
>>>>> =EF=BB=BFOn Thu, Oct 16, 2025 at 11:13:21AM -0400, Joel Fernandes wro=
te:
>> ...
>>> While I'm not super opinionated for general bitfields, for the register=
!()
>>> infrastructure I very much prefer the hi:lo notation, as this is the co=
mmon
>>> notation in datasheets and TRMs.
>>>
>>> However, if we use hi:lo, we should use it decending, i.e.:
> (restored from the email thread):
>
> 	bitfield! {
> 	    struct ControlReg {
> 	        7:5 state as u8 =3D> State;
> 	        3:0 mode as u8 ?=3D> Mode;
> 	    }
> 	}>>
>>=20
>> Sure, descending works.
>
> Oops! I need to correct myself. After reviewing most of Joel Fernandes'
> latest patchset ([PATCH 0/7] Pre-requisite patches for mm and irq in
> nova-core) [1], I remember that the HW documentation is written in
> ascending order.
>
> For one example (out of countless hundreds or thousands), please see [2].
> Considering that I actually pushed this file up to github just a few
> years ago, it's rather silly of me to forget this basic truth. :)
>
> We really want to stay close to the HW documentation, and so, all other
> things being (nearly) equal, this means that we should prefer ascending
> field order, if that's OK with everyone.

But that's OpenRM specific, I'm pretty sure when you look at internal datas=
heets
and TRMs you will find hi:lo with decending order, for instance [3] page 16=
72
(clicked a random location in the scroll bar. :).

Besides, I think that hi:lo with ascending order is confusing. It should ei=
ther
be hi:lo decending or lo:hi ascending.

For registers the common one is the former.

> [1] https://lore.kernel.org/20251020185539.49986-1-joelagnelf@nvidia.com
> [2] https://github.com/NVIDIA/open-gpu-doc/blob/master/manuals/ampere/ga1=
02/dev_ce.ref.txt
[3] https://developer.nvidia.com/downloads/orin-series-soc-technical-refere=
nce-manual/


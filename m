Return-Path: <linux-kernel+bounces-861922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE98BF4033
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 01:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 706594E36DB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 23:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356C2302CA2;
	Mon, 20 Oct 2025 23:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qz83Qc2+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830A32356A4;
	Mon, 20 Oct 2025 23:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761002569; cv=none; b=nWr4p0WzfDLUtOs+4q9afqYQE1jdHkcjwNuzq/VA3vYBLbJaox1ucS7Zg80LCs5aFAA29kVyXnL/SCA9848pAd3Xf4+s++DrpGHFhf0YMA2OkCxjWq3ygRxZdQ/KfCmmxYAc6XDuu/Owu8AZ/Uour+LIijXfCN3wrQFgGa1GbVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761002569; c=relaxed/simple;
	bh=mLwt746Bql4VNUGxNyThhFT4hbQLnNE7vPdHAEK1tp0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Jr2Qkt2GPE5LeLsAK+OgFNfSfgN/hZl+cmfake8lsLTKrvNgwnNuYqmZTdXrn+m82A2YI5qc/Dns4178D/ohPX0LxyXtC0pmHKFw4BtqmIJz0dAcflOfG8Wt4GY2QfuhvuAbfhKK4M8+HjQhFLgyfoGh3XZk3n1JsiVQHDgxbFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qz83Qc2+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE85BC4CEFB;
	Mon, 20 Oct 2025 23:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761002569;
	bh=mLwt746Bql4VNUGxNyThhFT4hbQLnNE7vPdHAEK1tp0=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=qz83Qc2+5BdmaCk5dSamlr7LkAH2xrC+hRTW2tEGLZ2v2EjHvXlaDjkP3Sn58EBL0
	 XWLxBZ6TO605if2lq3cKpxFyQ/vqM4SKI3WVo8b+cGt0BVJvCbtdnNL0dj6/E7YAbs
	 L4mKkWLMfYj/ZrpYoiLusuCGcANcYsgYzdQqSlkYXgOyeARbD1TEux44xFfInY4RPL
	 8MmINVMQmqLm62+1ODM6Ezs3yyfaX2+z9fYPRddhrJ87B4ht2tjL15oREvmdxGTGFQ
	 PiuvW4Rq3T2gszvTfcdoujCH1SVQ4aR750fYoXihCmsbKMH6H0s+drKX0C7Yw5kmHw
	 ELOdTGBuM1FaA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Oct 2025 01:22:42 +0200
Message-Id: <DDNJB4SLN8A4.O0L8NH8IWXSO@kernel.org>
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
 <DDNIZMOBCE1Z.1ZOQ83TKTHQ28@kernel.org>
 <0e592a2d-6c0a-4dab-b16c-ff994917af9a@nvidia.com>
In-Reply-To: <0e592a2d-6c0a-4dab-b16c-ff994917af9a@nvidia.com>

On Tue Oct 21, 2025 at 1:16 AM CEST, John Hubbard wrote:
> On 10/20/25 4:07 PM, Danilo Krummrich wrote:
>> On Tue Oct 21, 2025 at 12:50 AM CEST, John Hubbard wrote:
>>> On 10/16/25 12:39 PM, John Hubbard wrote:
>>>> On 10/16/25 12:34 PM, Danilo Krummrich wrote:
>>>>> On Thu Oct 16, 2025 at 9:28 PM CEST, Joel Fernandes wrote:
>>>>>>> On Oct 16, 2025, at 1:48=E2=80=AFPM, Yury Norov <yury.norov@gmail.c=
om> wrote:
>>>>>>> =EF=BB=BFOn Thu, Oct 16, 2025 at 11:13:21AM -0400, Joel Fernandes w=
rote:
>>>> ...
>>>>> While I'm not super opinionated for general bitfields, for the regist=
er!()
>>>>> infrastructure I very much prefer the hi:lo notation, as this is the =
common
>>>>> notation in datasheets and TRMs.
>>>>>
>>>>> However, if we use hi:lo, we should use it decending, i.e.:
>>> (restored from the email thread):
>>>
>>> 	bitfield! {
>>> 	    struct ControlReg {
>>> 	        7:5 state as u8 =3D> State;
>>> 	        3:0 mode as u8 ?=3D> Mode;
>>> 	    }
>>> 	}>>
>>>>
>>>> Sure, descending works.
>>>
>>> Oops! I need to correct myself. After reviewing most of Joel Fernandes'
>>> latest patchset ([PATCH 0/7] Pre-requisite patches for mm and irq in
>>> nova-core) [1], I remember that the HW documentation is written in
>>> ascending order.
>>>
>>> For one example (out of countless hundreds or thousands), please see [2=
].
>>> Considering that I actually pushed this file up to github just a few
>>> years ago, it's rather silly of me to forget this basic truth. :)
>>>
>>> We really want to stay close to the HW documentation, and so, all other
>>> things being (nearly) equal, this means that we should prefer ascending
>>> field order, if that's OK with everyone.
>>=20
>> But that's OpenRM specific, I'm pretty sure when you look at internal da=
tasheets
>> and TRMs you will find hi:lo with decending order, for instance [3] page=
 1672
>
> TRM is Tegra. This is gradually going away, from our point of view, as
> the larger, older RM (Open RM) driver subsumes things.
>
> Open RM follows the main dGPU ref manuals, and we have piles of those
> and they all apply to Nova.
>
> None of the TRM stuff applies to Nova.

My point is less about NVIDIA TRMs, it's about that this is uncommon in gen=
eral,
OpenRM is the one being special here.

So, the question for me is do we care more about consistency throughout the
kernel, or do we care about consistency between a driver and it's uncommon
reference manual.

I think consistency throughout the kernel is more important.

>> (clicked a random location in the scroll bar. :).
>>=20
>> Besides, I think that hi:lo with ascending order is confusing. It should=
 either
>> be hi:lo decending or lo:hi ascending.
>>=20
>> For registers the common one is the former.
>>=20
>>> [1] https://lore.kernel.org/20251020185539.49986-1-joelagnelf@nvidia.co=
m
>>> [2] https://github.com/NVIDIA/open-gpu-doc/blob/master/manuals/ampere/g=
a102/dev_ce.ref.txt
>> [3] https://developer.nvidia.com/downloads/orin-series-soc-technical-ref=
erence-manual/



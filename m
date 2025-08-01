Return-Path: <linux-kernel+bounces-753100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C77B17E9F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 10:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F3E73A8C9F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 08:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F10C21772A;
	Fri,  1 Aug 2025 08:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEB1DOzz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8108D1D5CD7;
	Fri,  1 Aug 2025 08:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754038471; cv=none; b=NPLS+MLyV3YqJ22c4UUMUFOTknTDQaCh/u6Y36wUNvL1UrXPsqGBEYcCIFuzQja5dgEquKGhBvxATQOL4RPs+1HGEdylMRDEMjbj1xypECZBrjLmT62QzRDU40RV4XCn56s9DE+I/H6gfTg99QNl/Tl6jTTNZ7CIc1KshXxDt0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754038471; c=relaxed/simple;
	bh=5ilrF1PJF2u8cTFpWfNPO+Pd2ZHfXg+mbQYbf2As7fI=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=FBiFUvHEC9nzf1pOofbvwj2s56iRLNV1cs+QgGCtNdUvdRtH0OtiW+x0BmeGQakyPJo/C4P76GT7iLVwzjwq1LvYvbUFAq9jBDsdfnlgJp1DcG5aEjmpUkHtZGw03wvXqHo1k8ElFbZKe7wL3x3dtogRLH90NqknFJa0wW0fbi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEB1DOzz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1760C4CEE7;
	Fri,  1 Aug 2025 08:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754038471;
	bh=5ilrF1PJF2u8cTFpWfNPO+Pd2ZHfXg+mbQYbf2As7fI=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=QEB1DOzzeVSMP4ul5e/pGmH3LbaMEquAKuF2KYBpg85Ts4N4t+3g9r6dcbFNmpCst
	 lwVewH1Lb+MvbE09J5ttuQCTEhp5tc6XmmC1lCHOvvnPSVSevQeNw6N14zyyQnlcEC
	 R8/rB14qu5E2pJe9OJPxQ8nJI4bj9kq0vBUVlLbkKzZEdvkJ33BMywLb9YTAKJ6yxD
	 1nr5lFYCPdQ98B4DojNfKRa6n4qLQTkHEtz68JbuufmQgetocGbkSeTayxfzsPZt65
	 AeEBphW1922Cd6nURbxlNGE67VlE+B/wsSa49fdutW0tfdQBFeVIpUGRv+P+GzBskd
	 PB5y5+uUSIQ0w==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 Aug 2025 10:54:26 +0200
Message-Id: <DBQYQR7BPKQA.2UVOPCU6LXXAY@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Tejun Heo" <tj@kernel.org>, "Tamir
 Duberstein" <tamird@gmail.com>, "Hamza Mahfooz"
 <hamzamahfooz@linux.microsoft.com>, "Alban Kurti" <kurti@invicto.ai>, "Joel
 Fernandes" <joelagnelf@nvidia.com>, "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [RFC PATCH] rust: workqueue: Add an example for try_spawn()
From: "Benno Lossin" <lossin@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250730163439.50753-1-boqun.feng@gmail.com>
 <DBPMYTZSIEQ5.3NPJM1CYVO3CK@kernel.org> <aIp0uo5y9O551HW9@tardis-2.local>
 <DBQ4VKUDJOF4.1JVIM88YK8V59@kernel.org> <aIwVL9xmBFHcX9c4@Mac.home>
In-Reply-To: <aIwVL9xmBFHcX9c4@Mac.home>

On Fri Aug 1, 2025 at 3:15 AM CEST, Boqun Feng wrote:
> On Thu, Jul 31, 2025 at 11:30:10AM +0200, Benno Lossin wrote:
>> On Wed Jul 30, 2025 at 9:38 PM CEST, Boqun Feng wrote:
>> > On Wed, Jul 30, 2025 at 09:28:05PM +0200, Benno Lossin wrote:
>> >> On Wed Jul 30, 2025 at 6:34 PM CEST, Boqun Feng wrote:
>> >> > +    /// workqueue::system().try_spawn(
>> >> > +    ///     flags::GFP_KERNEL,
>> >> > +    ///     {
>> >> > +    ///         let work_done =3D work_done.clone();
>> >> > +    ///         let data =3D data.clone();
>> >> > +    ///         move || {
>> >> > +    ///             *data.lock() =3D 42;
>> >> > +    ///             work_done.complete_all();
>> >> > +    ///         }
>> >> > +    ///     }
>> >> > +    /// )?;
>> >>=20
>> >> Not doing your pattern and instead adding a `2` postfix we get:
>> >>=20
>> >>     let work_done2 =3D work_done.clone();
>> >>     let data2 =3D data.clone();
>> >>=20
>> >
>> > Yeah, the thing I want to achieve with my pattern is: make it clear th=
at
>> > the work and the task that queues the work are sharing the same
>> > `work_done` and `data` (well, no the same `Arc` exactly, but the `Arc`=
s
>> > that are pointing to the same object). This pattern here doesn't show
>> > that clearly imo.
>>=20
>> I think it's fine, that pattern is often used for that. Not heavily
>> opposed to doing it your way, but I feel like the code looks a bit weird
>
> Ok, I will drop my style and use work_done2 and data2, because it'll be
> at the general documentation, but I might keep using my pattern in other
> code because it looks reasonable to me ;-)

It is reasonable :) If you do want to use the same name for them, then I
personally think this looks better than moving the let bindings inside
of the expression:

    {
        let work_done =3D work_done.clone();
        let data =3D data.clone();
        workqueue::system().try_spawn(flags::GFP_KERNEL, move || {
            *data.lock() =3D 42;
            work_done.complete_all();
        })?;
    }

But that gives the `try_spawn` call extra indentation which also isn't
ideal... I'd be best for the language feature to exist :)

---
Cheers,
Benno


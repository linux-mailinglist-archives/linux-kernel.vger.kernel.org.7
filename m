Return-Path: <linux-kernel+bounces-860501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE6ABF04A1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3019D3B005D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914A62FB094;
	Mon, 20 Oct 2025 09:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M66NK0n7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CE52F9DA7;
	Mon, 20 Oct 2025 09:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760953233; cv=none; b=ZvIwr5rlAslceFp6nNW3n+3P9CCLJVmDikQD+kMvCkC1/Fz2KC/5w/zpqwCSH9YzbtBRzvPoEJSnQvztOespsHM+nAhw59FKeTh++jOZEn9LTWhXDSg9sOJV4IPDVyyJPJXYR/CgBCRGWMlaj1upgcmwvN1kgr3JzNQj6ruO9CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760953233; c=relaxed/simple;
	bh=Z1kaVO3Ed9EJ8fGuWa7kSlIV+SC1mWkBs/JeBs2k83Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=TjoLlrAaQbRytQNtdHZiQAdDPDG2m7Y/BROCaSJdktrQb3r7C5ON9fc7Z9SEc6LWCoUGL8Aws81ArfqRsi0L+owk5Lhyxj42pvhK/dfxxS84Vp48wIxrh6uhL63qWpRNug8o0R2eJjSLqZOExZ+/gxAi90gJ9lM9Y6+ouUSd/gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M66NK0n7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD55AC4CEF9;
	Mon, 20 Oct 2025 09:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760953232;
	bh=Z1kaVO3Ed9EJ8fGuWa7kSlIV+SC1mWkBs/JeBs2k83Y=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=M66NK0n7kCPkczZVv5CJ0SN99cvs22UTtSJapV/hliT4wneK87ZS3VYhv3aEg6MuM
	 sxBXAPVuPrUOvubD5Ban6A4Qzat2/L3OlQUGBqHYmE9sjKL07cGirQ2PaJoSDKBKRY
	 uyIrxC8T2bjV5Zme0/scFP+4tMpMGkIaASpQoBhnlpQXvQ9NRkc0lTKh0fSZIfTHoI
	 0K8egAAshl6DkfrGsz7UL5OTjFICMkUMTo6AT1g6t/qjbLgg8cFQ3XxxPKfYlLKGPc
	 u4jArVK5MENoThiQhKmR81T2DFTZNuX3FqegOH/hT0l/lpkHsRvkprFg2C1g544Di+
	 X8YOz4Po/BwEw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Oct 2025 11:40:28 +0200
Message-Id: <DDN1TL0WE895.1R5Z8AR975ZJH@kernel.org>
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <mmaurer@google.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 3/7] rust: debugfs: support for binary large objects
References: <20251003222729.322059-1-dakr@kernel.org>
 <20251003222729.322059-4-dakr@kernel.org> <aPI9tNoh0I3KGDjl@google.com>
 <DDKO9M4P06HS.3UMGG3QR7BX67@kernel.org>
 <DDKOLD1897SY.84W93E6L8ITR@kernel.org> <aPSzE7DpA7DxTHmm@google.com>
 <DDMA6OR8V1L3.22YQDEKL20MB5@kernel.org> <aPXu0FWUrbxyemPq@google.com>
In-Reply-To: <aPXu0FWUrbxyemPq@google.com>

On Mon Oct 20, 2025 at 10:12 AM CEST, Alice Ryhl wrote:
> On Sun, Oct 19, 2025 at 02:01:03PM +0200, Danilo Krummrich wrote:
>> On Sun Oct 19, 2025 at 11:44 AM CEST, Alice Ryhl wrote:
>> > On Fri, Oct 17, 2025 at 04:53:09PM +0200, Danilo Krummrich wrote:
>> >> On Fri Oct 17, 2025 at 4:37 PM CEST, Danilo Krummrich wrote:
>> >> > The reason I went with a trait is because that's consistent within =
the file.
>> >> >
>> >> > Otherwise, I don't mind one or the other. If we always want to use =
a struct, I'm
>> >> > fine with that. :)
>> >>=20
>> >> Actually, there's another reason I forgot about since I sent the seri=
es. :)
>> >>=20
>> >> We need it because we derive it from blanket implementations:
>> >>=20
>> >> 	impl<T: BinaryWriter + Sync> BinaryReadFile<T> for T
>> >> 	impl<T: BinaryReader + Sync> BinaryWriteFile<T> for T
>> >> 	impl<T: BinaryWriter + BinaryReader + Sync> BinaryReadWriteFile<T> f=
or T
>> >
>> > You can still use a struct:
>> >
>> > struct BinaryWriterVtable<T: BinaryWriter + Sync>;
>> >
>> > impl<T: BinaryWriter + Sync> BinaryWriterVtable<T> {
>> >     const VTABLE: bindings::foo =3D ...;
>> > }
>>=20
>> Yeah, but do we get something for adding yet another type in this case?
>>=20
>> Another point to consider is if we want a more generic fops abstraction =
type.
>>=20
>> In any case, I'd like to add this as good first issue for the whole file=
 to be
>> changed accordingly.
>
> Yes, keep it as-is for consistency with the rest of the file, even if
> the file is inconsistent with the rest of `kernel`. Please go ahead and
> file a good-first-issue for this.

Before doing so, can you please answer the question above? While I'm all fo=
r
consistency, in this specific case it seems we'd need another indirection f=
or
that. And I'm not convinced that's an improvement.


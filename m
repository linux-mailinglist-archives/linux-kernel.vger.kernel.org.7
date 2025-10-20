Return-Path: <linux-kernel+bounces-860516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCCDBF04DE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5C8F189B855
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CD723C8A0;
	Mon, 20 Oct 2025 09:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DU44KOEC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F4A18FC86;
	Mon, 20 Oct 2025 09:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760953761; cv=none; b=Zg+PDJG3QWC1sXVuhri7Sp6SA3pKGIHvlNF6NPJfLsZUnu/WRv4yl7hPQTCsWrWyJNpJk4M8j6Tu+M+Vg1VpOCdUdbYqrcQoSZtJM136RhYYkYCIY9qrWdp9tFq/pOWUsZ6syQ1xcxMnBtbE/Tez8HUDwX7C7WLXSovptVN9yjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760953761; c=relaxed/simple;
	bh=rY/ExjFftFDDfWSv0SQkHYyd2IdhRXA45VozZtzHka8=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=XWfUNJYTjuDNKnm1MTxTg/LtNx8MXIPeNov8hfK6o96+MDwHDbsJNmG/OfHwJY94u7FVJqHo8PJfWIxb2XuPEy68l5wNNR21QkyuJVCLYeSOwggVTNBykIMJ1jd9tKoAj2j3aLEqAK5DziST6XbKQhDOqrz01QDSPi2IVB3R1qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DU44KOEC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5965C4CEF9;
	Mon, 20 Oct 2025 09:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760953761;
	bh=rY/ExjFftFDDfWSv0SQkHYyd2IdhRXA45VozZtzHka8=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=DU44KOECbzAOPXTVRKloPNpamKj2IcG+d8xgIRA7p9CmGuvwxZn0Fh7TL/GZzzXJu
	 Th3fY5jK6X4FieCg08u2Wt+lxXGziU6zv8I7jTjMULBMah/tva/x9CbRIdK/JEJ5Yj
	 RXNnaJkJqNcusgROd75MGXwnww8dnGHyyVU2VnnDTAGUVOAtAExO6Pr9aWRmpNcfuq
	 SBY1DXoxEAim0yVOeGpVyKMIOFXvisIKQLji4w+ekw0PnsLpslLYmohiXv4Z2VdaaO
	 CCovoBEYx6+HKx190GsgWkjmW7jBKSvL0/qWWUdpLCDeU0ZJivIG49Twu2wfhDOpmQ
	 7JUOs0J3HqOng==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Oct 2025 11:49:17 +0200
Message-Id: <DDN20C4Z22X3.2ML01WB1HRDRI@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 3/7] rust: debugfs: support for binary large objects
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <mmaurer@google.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
References: <20251003222729.322059-1-dakr@kernel.org>
 <20251003222729.322059-4-dakr@kernel.org> <aPI9tNoh0I3KGDjl@google.com>
 <DDKO9M4P06HS.3UMGG3QR7BX67@kernel.org>
 <DDKOLD1897SY.84W93E6L8ITR@kernel.org> <aPSzE7DpA7DxTHmm@google.com>
 <DDMA6OR8V1L3.22YQDEKL20MB5@kernel.org> <aPXu0FWUrbxyemPq@google.com>
 <DDN1TL0WE895.1R5Z8AR975ZJH@kernel.org>
 <CAH5fLgjw4cZ3Y3Z60v8Wtp1EsR3AjyopJBE-UzZH5H3qkFrWmQ@mail.gmail.com>
In-Reply-To: <CAH5fLgjw4cZ3Y3Z60v8Wtp1EsR3AjyopJBE-UzZH5H3qkFrWmQ@mail.gmail.com>

On Mon Oct 20, 2025 at 11:42 AM CEST, Alice Ryhl wrote:
> On Mon, Oct 20, 2025 at 11:40=E2=80=AFAM Danilo Krummrich <dakr@kernel.or=
g> wrote:
>>
>> On Mon Oct 20, 2025 at 10:12 AM CEST, Alice Ryhl wrote:
>> > On Sun, Oct 19, 2025 at 02:01:03PM +0200, Danilo Krummrich wrote:
>> >> On Sun Oct 19, 2025 at 11:44 AM CEST, Alice Ryhl wrote:
>> >> > On Fri, Oct 17, 2025 at 04:53:09PM +0200, Danilo Krummrich wrote:
>> >> >> On Fri Oct 17, 2025 at 4:37 PM CEST, Danilo Krummrich wrote:
>> >> >> > The reason I went with a trait is because that's consistent with=
in the file.
>> >> >> >
>> >> >> > Otherwise, I don't mind one or the other. If we always want to u=
se a struct, I'm
>> >> >> > fine with that. :)
>> >> >>
>> >> >> Actually, there's another reason I forgot about since I sent the s=
eries. :)
>> >> >>
>> >> >> We need it because we derive it from blanket implementations:
>> >> >>
>> >> >>   impl<T: BinaryWriter + Sync> BinaryReadFile<T> for T
>> >> >>   impl<T: BinaryReader + Sync> BinaryWriteFile<T> for T
>> >> >>   impl<T: BinaryWriter + BinaryReader + Sync> BinaryReadWriteFile<=
T> for T
>> >> >
>> >> > You can still use a struct:
>> >> >
>> >> > struct BinaryWriterVtable<T: BinaryWriter + Sync>;
>> >> >
>> >> > impl<T: BinaryWriter + Sync> BinaryWriterVtable<T> {
>> >> >     const VTABLE: bindings::foo =3D ...;
>> >> > }
>> >>
>> >> Yeah, but do we get something for adding yet another type in this cas=
e?
>> >>
>> >> Another point to consider is if we want a more generic fops abstracti=
on type.
>> >>
>> >> In any case, I'd like to add this as good first issue for the whole f=
ile to be
>> >> changed accordingly.
>> >
>> > Yes, keep it as-is for consistency with the rest of the file, even if
>> > the file is inconsistent with the rest of `kernel`. Please go ahead an=
d
>> > file a good-first-issue for this.
>>
>> Before doing so, can you please answer the question above? While I'm all=
 for
>> consistency, in this specific case it seems we'd need another indirectio=
n for
>> that. And I'm not convinced that's an improvement.
>
> The choice is between adding a new type or a new trait. There's no
> intrinsic advantage to choosing either one, but the rest of `kernel`
> chose "new type" over "new trait", so it makes sense to be consistent.

My hesitation came from the assumption that we'd need another type (additio=
nal
to the existing trait). But we can indeed replace it, so that's fine.


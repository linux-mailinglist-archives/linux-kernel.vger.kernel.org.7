Return-Path: <linux-kernel+bounces-776710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BBDB2D0BA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 02:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C276B17785D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 00:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C884170A37;
	Wed, 20 Aug 2025 00:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="joIF5yeQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968B035336C;
	Wed, 20 Aug 2025 00:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755650054; cv=none; b=BreVpqnCQEQR/fACrwBxvUoQqkJ4CHL+uga8ijcdUmvhZJKgu4LmjIcC7Uj9shfCI3TGc9aGuuLhrOXIDCsSWHLSb/HumA/WZOXqyRzkxuzSAnD+FGTN0oH/sJa7a/Xcie3kqqJAhUaqglASw54C+uE1qgbJAfcUmnBN7jjYytA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755650054; c=relaxed/simple;
	bh=JAI+oYkdbTIFn8JsqjU/opW6sYv/yyl6y9q76TmwkxQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=W/MYuxV/GQKUKlDPHNkcPUeBQryED0bpmiG7K1NwkK7PtzBuG284Zct55+XNQD4gX9t36Q/TXExysWa6Z9UcTRWL7hTZ/FdqaxNOSgZsgkpfDDAvPgKiqhCk/72gSvZWAZtEJTg4N//RMZvHFeW/IkzofLI0+8dq6niya3m1AlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=joIF5yeQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24FFFC4CEF1;
	Wed, 20 Aug 2025 00:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755650054;
	bh=JAI+oYkdbTIFn8JsqjU/opW6sYv/yyl6y9q76TmwkxQ=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=joIF5yeQMxdAwvFbojfpO5WzAKLrlTIFhUXiHjKaZwUIXQzvvrELiXa2mcFqvaQ19
	 acpb04faE+MKfSIgNl+zM01YV7MplxCAQLMxjFhcVimrkRM0cBYHwJV9zdXCeg3AAd
	 LfdJG4zchqLMGvIJsGldZXtW9mVJZNjs8XOXoXja7R3j2PUAca+0IYRaWJmJ1w07fx
	 4pGSviBW6kIpNZ/I5TesMvZ58jrih8zZ7+WTv3TNsVKjrJY0vkcjYJoDiFQlp0HdPf
	 6Hk6QobI1kDRXcz2lySI09f3VIyou8/WhH64VM6XtsCwcOUO0q6mQvcSdX+5gm29wS
	 weHGuvofWRQwA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 Aug 2025 02:34:09 +0200
Message-Id: <DC6U02DZSX1W.1SXD7XQTNHXQL@kernel.org>
Subject: Re: [PATCH v10 5/7] samples: rust: Add debugfs sample driver
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Sami Tolvanen" <samitolvanen@google.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Benno Lossin" <lossin@kernel.org>, "Dirk Beheme"
 <dirk.behme@de.bosch.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
To: "Matthew Maurer" <mmaurer@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250819-debugfs-rust-v10-0-86e20f3cf3bb@google.com>
 <20250819-debugfs-rust-v10-5-86e20f3cf3bb@google.com>
In-Reply-To: <20250819-debugfs-rust-v10-5-86e20f3cf3bb@google.com>

On Wed Aug 20, 2025 at 12:53 AM CEST, Matthew Maurer wrote:
> Adds a new sample driver that demonstrates the debugfs APIs.
>
> The driver creates a directory in debugfs and populates it with a few
> files:
> - A read-only file that displays a fwnode property.
> - A read-write file that exposes an atomic counter.
> - A read-write file that exposes a custom struct.
>
> This sample serves as a basic example of how to use the `debugfs::Dir`
> and `debugfs::File` APIs to create and manage debugfs entries.
>
> Signed-off-by: Matthew Maurer <mmaurer@google.com>

This is a great example, thanks! I really like how the API turned out.

When it comes to the newly added Scope API - and I assume this does not com=
e at
a surprise - I have some concerns.

But first, thanks a lot for posting the socinfo driver in both variants, wi=
th
and without the Scope API.

I had a brief look at both of those and I can see why you want this.

With the Scope thing you can indeed write things a bit more compressed (I t=
hink
in the patches the differences looks quite a bit bigger than it actually is=
,
because the scope-based one uses quite some code from the file-based one).

I think the downsides are mainly:

  - The degree of complexity added for a rather specific use-case, that is =
also
    perfectly representable with the file-based API.

  - It makes it convinient to expose multiple fields grouped under the same=
 lock
    as separate files, which design wise we shouln't encourage for the reas=
ons
    we discussed in v8.

I think for the sake of getting this series merged, which I would really lo=
ve to
see, I think we should focus on the file-based API first. Once we got this
landed I think we can still revisit the Scope idea and have some more discu=
ssion
about it.

I will have a more detailed look tomorrow (at least for the patches 1-5).

Thanks again for working on this!

- Danilo


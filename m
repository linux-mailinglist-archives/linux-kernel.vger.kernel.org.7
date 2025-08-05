Return-Path: <linux-kernel+bounces-756281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3BEB1B241
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 12:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B43C3AE8F2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 10:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA1B23BF96;
	Tue,  5 Aug 2025 10:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXqA6Bj3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D82A41;
	Tue,  5 Aug 2025 10:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754390942; cv=none; b=D8PPunkwqodpaxSyHY8LKgyfDOvkNQJanDdVEgx0OrKBIbXl0kSnGbKpQZ4DsxyshfQ6XLdm4q2IGyL0qJNL44jgH0KVZnhPR5cN6IBTq5Gkf/2Tj+hQQz28vu8d17ysd0GRWHQUtYby/EfHigqXsFhnacPlcqF23rnGzdBDNVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754390942; c=relaxed/simple;
	bh=1SQ374xhrVvMt2lc3PLDfYgIIhwxy2llUepDQiiaPnA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oE7Q9VW1Mmf1DdgWoO/MtnAquQ3x/i9eR5rwX142YrmEj4wGqrEq7W0zaLFjbz9X5tSk1H7ynibkaxX6gaswOHVlE0WzfImY3X7ld88mheUHjvRIPPHWLYsvbuUGil0T4ZimUcnZpzjErGrQXDddleCrQoSxNlF06LMVTLWKBYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXqA6Bj3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D513C4CEF0;
	Tue,  5 Aug 2025 10:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754390942;
	bh=1SQ374xhrVvMt2lc3PLDfYgIIhwxy2llUepDQiiaPnA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=LXqA6Bj3xLvZT4QEsEKyPzfbNz2VNnEO5JXkBqixRW5O+D6eFJiCZdQoiNeX2jJOU
	 eOy8OUQ4LJJ1j0xNCONsfMV3ZskE0BL1DpJsaxYNLxrKWgOrl1IPnUhcFD1z6Ew8jk
	 yHisxBMMg8qdJLFAepI5zaUxqY8cpmpW5Tu3nXCD+jrPDxb6QGp/OfT87rOSSjjmvU
	 Lc+G9mYmCx7RHSkT+vGASXQYVKDvs5GYXHm9RRIMEtUPrvtl9jQco0g98WeNBdiKcd
	 ONa3Bt67Yh7E8UcymKDfCc5u6tbkqK5/bOX/05qlIjOlAPl5FCpx4EPwkIB0LV3Hqr
	 ocn12DfmeVPLg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda
 <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
 <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Trevor
 Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>, Matthew Maurer <mmaurer@google.com>, Lee
 Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, Benno Lossin <lossin@kernel.org>
Subject: Re: [PATCH v2 1/4] rust: iov: add iov_iter abstractions for
 ITER_SOURCE
In-Reply-To: <aHT1etvG0R648EB9@google.com>
References: <20250704-iov-iter-v2-0-e69aa7c1f40e@google.com>
 <U16UjMBBh1b7dLeO-Nhqw__nw_JwypctB1ze_G44BtsX0l_eVK6Sp-efbobmnuF44J0wQNgnK7b8nCmBX0KS_Q==@protonmail.internalid>
 <20250704-iov-iter-v2-1-e69aa7c1f40e@google.com>
 <878qkyoi6d.fsf@kernel.org>
 <0Y9Bjahrc6dbxzIFtBKXUxv-jQtuvM2UWShaaSUsjKBuC1KKeGIpBFTC4a89oNrOLBP66SXtC7kQx1gtt04CMg==@protonmail.internalid>
 <aG5NdqmUdvUHqUju@google.com> <87ecuplgqy.fsf@kernel.org>
 <q7QRbcFgb5yhmBOt4eLkkzqyckspc2L2g3e0pXhJxm0yBVeG2Hifi4O77gaxwpWss1Z_CUjSy1P22ppxcxo8jw==@protonmail.internalid>
 <aG5iLiUJg_cHtB8r@google.com> <87ikk1jnwi.fsf@kernel.org>
 <WVgUwLhmbElHeP5tPcNONT_9FpPV-_YhCcW3fjEerTwYFRTwOwr660BifN5WZ7Jlon5AivliY6W87qxnrn1mKw==@protonmail.internalid>
 <aHT1etvG0R648EB9@google.com>
Date: Tue, 05 Aug 2025 12:48:52 +0200
Message-ID: <874ium9h7v.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alice Ryhl" <aliceryhl@google.com> writes:

> On Wed, Jul 09, 2025 at 07:05:01PM +0200, Andreas Hindborg wrote:
>> "Alice Ryhl" <aliceryhl@google.com> writes:
>>
>> > On Wed, Jul 09, 2025 at 01:56:37PM +0200, Andreas Hindborg wrote:
>> >> "Alice Ryhl" <aliceryhl@google.com> writes:
>> >>
>> >> > On Tue, Jul 08, 2025 at 04:45:14PM +0200, Andreas Hindborg wrote:
>> >> >> "Alice Ryhl" <aliceryhl@google.com> writes:
> The iov_iter type is like a giant enum with a bunch of different
> implementations. Some implementations just read from a simple kernel
> buffer that must, of course, be mapped. Some implementations traverse
> complex data structures and stitch the data together from multiple
> buffers. Other implementations map the data into memory on-demand inside
> the copy_from_iter call, without requiring it to be mapped at other
> times. And finally, some implementations perform IO by reading from
> userspace, in which case it's valid for the userspace pointer to be
> *literally any 64-bit integer*. If the address is dangling, that's
> caught inside the call to copy_from_iter and is not a safety issue.

At any rate, this is a very informative paragraph. It would be great if
you could have this information in the documentation for this type.


Best regards,
Andreas Hindborg




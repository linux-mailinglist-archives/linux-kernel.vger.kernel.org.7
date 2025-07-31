Return-Path: <linux-kernel+bounces-751833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A35B16E0C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72A797A515E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 08:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFE8292B5D;
	Thu, 31 Jul 2025 09:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOxFGn9h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DF626E71A;
	Thu, 31 Jul 2025 09:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753952468; cv=none; b=tq3UlMvvc+RToChwFYRUq4hEmQkrBKYWS9AIuN7/iDdOrFpR2vRsOUxbMhIoUlSq4IsBg1qUJKdw8d9Kj5e6Gi+NX7/1+6ZpjfCS377c3XMAWviaL12i9Oulhh5Q4Su3i4JDNdV2c1OMirUTizs+9Clj4ZB1jbpZvTbz5wFK0bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753952468; c=relaxed/simple;
	bh=OzBf+6tjHlFFol6frCSMTO760o8bn44Yd0IKA9X+/nk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=s7Yns0aQz5edHBru5vBoYLCi7VwMWz5E7omuPV8FxUKTalbInE+X+fHxaWe3X8XJxBbTJBOebL179SQsZQM1xiNt/6Ph/Nd2ENupFtUaaYdk6oAwK1LXvUc1r+j/SltdGQpfryb8YlXS1foTHc4Na/jGtHkMoDi0nqn2PxQIf1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mOxFGn9h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60C5C4CEEF;
	Thu, 31 Jul 2025 09:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753952467;
	bh=OzBf+6tjHlFFol6frCSMTO760o8bn44Yd0IKA9X+/nk=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=mOxFGn9hqOiv/tnVRGVPcphy6xctJwyi/J2LY3mLXgfLe+hbzf98qlXSBnhkR2So+
	 LqaUu9qCD4VLgaX7Q9kPSN2oF6V0x4nBQa3rIJS66/l1Ws+Y/yWeCsg3zaGIHcOPU1
	 A4kVkp4pPozbuUKlzH/mivCm1a8Xwtl0AlADW8UDysrADnzQjVsNkWHCnWthiglCUG
	 zA4Y991iImlKb7/W34/VYPszyl5v8O5wHbIn8EQNLujg+YkoqSW9o/zcaxlnKN+spK
	 pFGqE5KmD0thkTBf9PDCB0VcrITCn8MReg1YukXl9tNVUP7NT/u6yvaqpMCO8+SYEL
	 8npo99YuNK6VA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 31 Jul 2025 11:01:02 +0200
Message-Id: <DBQ499KC66B1.2YNYBXUG343HK@kernel.org>
Subject: Re: [PATCH v7 0/3] Rust allocator and kvec improvements
Cc: "Hui Zhu" <hui.zhu@linux.dev>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Vlastimil Babka" <vbabka@suse.cz>, "Liam R .
 Howlett" <Liam.Howlett@oracle.com>, "Uladzislau Rezki" <urezki@gmail.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
 <vitaly.wool@konsulko.se>, "Hui Zhu" <zhuhui@kylinos.cn>
To: "David Gow" <davidgow@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <cover.1753929369.git.zhuhui@kylinos.cn>
 <CABVgOSkphk7X8nKGePTf88RzW91Pb8NPAbryVvL=zQ370o62RQ@mail.gmail.com>
In-Reply-To: <CABVgOSkphk7X8nKGePTf88RzW91Pb8NPAbryVvL=zQ370o62RQ@mail.gmail.com>

On Thu Jul 31, 2025 at 6:14 AM CEST, David Gow wrote:
> On Thu, 31 Jul 2025 at 10:51, Hui Zhu <hui.zhu@linux.dev> wrote:
>>
>> From: Hui Zhu <zhuhui@kylinos.cn>
>>
>> This series adds tests and docs for Rust kernel components:
>> Patch 1 adds KUnit tests for allocator alignment guarantees.
>> Patch 2 documents KVec::as_slice with a usage example.
>> Patch 3 simplifies KVec test module naming convention.
>>
>> Both patches are co-developed with Geliang Tang. Based on [1].
>> Tested on x86_64 using KUnit.
>>
>
> This series looks good to me from a KUnit perspective. I've also
> tested it out across a bunch of architectures (UML, x86_64, arm,
> arm64) with no problems.
>
> A few minor notes:
> - You should squash patch 3 into patch 1: there's no need to introduce
> the test with one name only to rename it in a later patch.

The test introduced in patch 1 is not the one renamed in patch 3. :)


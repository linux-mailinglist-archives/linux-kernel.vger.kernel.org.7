Return-Path: <linux-kernel+bounces-861865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E7037BF3DB1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 00:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6DD424FE49B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 22:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E292F25F3;
	Mon, 20 Oct 2025 22:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="JWcFYVad"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234322E7F11
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 22:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760998237; cv=none; b=QRAt0st8nQkMMKGM3m2+4Zm/G1ILuI6jx/e4nQlFpSz4QpnuTcyLlS5wL4tptAqO2P6912gAtMn6mrjYnGo0kqtCFaktqOFTXbDwzBfo4Pc5UjuNKbiUmnXXoSaUJZzwMpaA4H4F2Q75CeCHz1Pm1yLqBVaxU0IUPwfnDiv5Ico=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760998237; c=relaxed/simple;
	bh=ilx2DzwdWn0Eb7pbCFulmV8VsnS7KdZoAGThUj0Ef9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cqJVreaaoN7hOfeQYJVcir27ercvmeDDacuUrc0tqRYyaowsB5rrAPEbG7PsqRTY1nUrfAN6fzVxX/smKNh9eDl3UGS2k3fahZ0RSY8RZvbPDPbj/Q385/NnZB2CzHVcjNAqekWUAEnwCSUw4ipOWhxhaVLq5es6Namu5KGRwA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=JWcFYVad; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-63bad3cd668so9262674a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 15:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1760998233; x=1761603033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ilx2DzwdWn0Eb7pbCFulmV8VsnS7KdZoAGThUj0Ef9U=;
        b=JWcFYVadt93YK7TOMy9LFnWbvObqk56tdaxiF6kzSqONWZfZ3rSPVf3TK3N4/AwBO+
         pFxCx25zD/CXjIso7elAKENpgGBWpzVvwYZCJNDVQfjbK/FwZYyztBJw1zzbhPxIv2B3
         ZfxEZVJ3xI6qUH8LODXMN02rJJJ7PluEjYQbsHrprn4kKprYA0VxgVw8bLeAv0W7QNsz
         bh9MjNnqdmbxNUyIcaS74iTvQiGVBk/CW4qii6ibh8+ltp52tVefzDD9t2S8SUMhCw5X
         jQat3tf43fY80Gj8Vf8wGhEi0jNqxzpsXvdVfuM5PpQ3kEOz3duFroJ/HNsw0+tRc6GT
         O/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760998233; x=1761603033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ilx2DzwdWn0Eb7pbCFulmV8VsnS7KdZoAGThUj0Ef9U=;
        b=P+eRLqA22EJYArY7v9WYXiPN0UvyBJWLz946kI20IsSifHDE3B/ysEbcSHCmawr0Ze
         iX4XtvxV2ST2JoaUZbNGzqaplsoQJGHIYMUg6Yzjwg0jwAA60U6dRlJSe+Cbz/13Y2ip
         QJVHgzO++kBcfkfxE1L61p3u0/H6nWQxSsCNney8HqLRZ2Zm3B1O+aHTo3L/D6+Z1WDH
         N3Sc/n4gt1edMEXtgqW0RynC5Q3RTqsPC2rK7gbB1FokrMqWH6dJ9FYNCOn7cERDuE3b
         DL8SjhDZxkDigmKn3IGApZ0Q08SU9o92ulNTNFQGQd6FS0wt+YZkSN5CqIm2zycZkEV3
         RbQA==
X-Forwarded-Encrypted: i=1; AJvYcCXQHhGutuuoMoCXk8Dx00037mA4gZXFDimu8V93Zd6NLZaHr/KjnvuDka4+B1wsRqvLr9BVp5qVVdO9pcg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVXNs+0KqeGj8v5YJLmbl2pLiRPDRQtInRFIr28HPfVOaoN4iu
	C/LtT8wZ1tPoeB02uvjiD/d0/TD9C1CdtluT/FVKdZEGHatO+2MwUyXuNIAN7dTdPCjBLugIZXb
	KkgoGVfaBDOw+WDJ3+j4IzvFy0XvrTrE7Uy6wy6GY/Q==
X-Gm-Gg: ASbGncvjPhmtKsAlSgfFpLZlvRF3r9EysUKmIDTn3f/Bd9gMn/QWDRjiRSyEPDxuZ/4
	RubVYFGkQNoIJmEzVJwjPUqbOnZlSwLB8mKZFPovCPCtATAY0vN5ZG3L1AfdmhTcnFlNmb6NYGd
	6gT204BTsomlmLkDan8f5wUvXWQGHplHl0JP+JnUydVmQmZIySNrc7tCYbQrSScNr2LfZhi1k6G
	NlfngG0+/Ug/aaiGIQ2KYEpwXdWpObx2T8TtZMZnXGBME7Y+D5VwiB4ICpRQ8I29bnz
X-Google-Smtp-Source: AGHT+IHXgN2A3la0YJxyyXqBd0MasNf9JRFf1RqDDAA3OQ+yqvWzJtnk8lJzn/WVj6Q3Gweop1jcYJMwQr5SF/i4N7Y=
X-Received: by 2002:a05:6402:518c:b0:63c:5eef:c8eb with SMTP id
 4fb4d7f45d1cf-63c5eefccb8mr7887864a12.31.1760998233475; Mon, 20 Oct 2025
 15:10:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018171756.1724191-1-pasha.tatashin@soleen.com>
 <20251018171756.1724191-10-pasha.tatashin@soleen.com> <aPXszzdehAbkPOAh@kernel.org>
In-Reply-To: <aPXszzdehAbkPOAh@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 20 Oct 2025 18:09:57 -0400
X-Gm-Features: AS18NWCJ1e_UpQW7FijpabJLDoZps9ZGHn4yCdktBVEdTDDj_pM8M4yk7V0Wg8M
Message-ID: <CA+CK2bCqZFY3HWNj6o2MS4+dz4Re+ekdY_GG1V4GL1Xq1NX_Ug@mail.gmail.com>
Subject: Re: [PATCH v6 09/10] liveupdate: kho: Increase metadata bitmap size
 to PAGE_SIZE
To: Mike Rapoport <rppt@kernel.org>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net, 
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, pratyush@kernel.org, rdunlap@infradead.org, tj@kernel.org, 
	jasonmiu@google.com, dmatlack@google.com, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 4:03=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Sat, Oct 18, 2025 at 01:17:55PM -0400, Pasha Tatashin wrote:
> > Metadata is preserved via 512-bytes, which requires using slabs. Slabs
>
> KHO memory preservation metadata is preserved in 512 byte chunks which
> requires their allocation from slab allocator.

done

>
> > are not safe to be used with KHO because of kfence, and because partial
>
> Please add more details why kfence is not safe here.

Done.

>
> > slabs may lead leaks to the next kernel. Change the size to be
> > PAGE_SIZE.
> >
> > While this change could potentially increase metadata overhead on
> > systems with sparsely preserved memory, this is being mitigated by
> > ongoing work to reduce sparseness during preservation via 1G guest
> > pages. Furthermore, this change aligns with future work on a stateless
> > KHO, which will also use page-sized bitmaps for its radix tree metadata=
.
>
> With the stateless memory preservation there would be no problem with
> kfence, right?
> Maybe we should accelerate the stateless preservation work?

They are orthogonal, theoretically radix tree could still use the
512-bit bitmaps, but we chose to use page size. Also, Statless KHO
still requires some work, and because it requires removing the
notifiers, it is better if it is based it on top of the other LUO prep
patches.

>
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>
> --
> Sincerely yours,
> Mike.


Return-Path: <linux-kernel+bounces-780914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1884B30AE6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 03:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82D711C88269
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 01:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBE11A2C0B;
	Fri, 22 Aug 2025 01:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/kDU7/D"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB4B1A5B9E;
	Fri, 22 Aug 2025 01:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755826818; cv=none; b=DfkiqfNKXRpFmVEVZaP2I2J8RdH9tqsl7CP569cPp9gzFshytibqDe9smxj+QD5Va/ucb5lwLyfiSa3hAU+Y0aYGscw83aLV/MYXIy8tMs1Xxe16Beo5PF0S1juh0BCvluEBvRIC8OdTh/8eDie1qQVk6Xhwiz5f6iFoSneBH2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755826818; c=relaxed/simple;
	bh=hzQis8wZfsew9L7CmjR1JJHcKI0FFC/A1/d+VneqJio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I2LtGKh9HwC9fn0F2FTlxvbYypv7wAS97A3t9ofu2TRyll4jIn9alvrd1QzXWEDs2aARXnZap+3tckXaYXhrF/HZJVax4moWFgxR0eyNlJI2z0lEUfaGshZzfob6THz3WkPZuiI49zfmaJTY8nphHzYZLf/wuZtm4sB/juno9fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/kDU7/D; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-32326e20aeeso137926a91.2;
        Thu, 21 Aug 2025 18:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755826815; x=1756431615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ni6Z7mL9inLQaWqt2DzvZGnzCjSdsFYDFox6Egj9d/U=;
        b=Y/kDU7/DvWEP93jFYxvj7ps1HkBEhWyXuZpBQ++3TMhm585/Z/RvRt2ltr5IifVuc8
         UoU+iqyppSHwO+7OOV8wtow6iLV/OZi1nxJ6GUV1NmROMr2ZGapKrrJ36T9UVvRctx/E
         COrN9DpfRxPNbiszDLlX7FuPnfOLg5W4KxMXtPDRLpTWargPdDksrudcVj+rXTuNTErn
         fUPcvlAM+gn/cZfg4gWuuYc4UPOoruxZXPnniOUOkViYw3XcyIfbwDwEQxg4Bm+hy+m5
         fFvaRjPIJCv6UtDrzQCjtvBH+NmHJ0pbuPICLJFytN9D3HBOJvf8qdVNPgEUJjaeBF8M
         KFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755826815; x=1756431615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ni6Z7mL9inLQaWqt2DzvZGnzCjSdsFYDFox6Egj9d/U=;
        b=BYh8pMkAg96ldMO2gZApC7AV0jvHyx0Fh0fTqkg/kRV+1AnihbVGZwJxNXenJ6X20T
         222wr7gfJtXOkQRW4UxwK9eU+adVeAZ8zMDEF8C1ELXUiyGq/tMUSb44AHeyDn+64ta+
         rz2htbjOxl6xY7peAqKnIdjO8A/KhCGxAor1B3lOFqX4fioNwp+cPVaEyDyEkQ+/2Uiw
         vQqq0dBEq0MLKFvmItLDk9e4tbzkRsY5ZDbfehBqsiR9cYysiWUN2mM8BHreSAmAfsu3
         8aHmwkBGxHNtA0OG8pcXomXGoTsCB+xaE7XqoOvUTw/HITosTbdFhVuFFafpuXNdeDd4
         i+iA==
X-Forwarded-Encrypted: i=1; AJvYcCUgmYlCCL9T1D5Gw5gxeSVLs0PDbwt8qIzgXymFPjpPtkRiDaLyIvziHIgzaRl400MgBmdFh9RBLTMhW6Q=@vger.kernel.org, AJvYcCVAILTjfQUV+BQTJ/rHvxvMSkCDy1Z06/cQhzWrLAlorYwQIL79ZhQ+Li0oV0xg6U8blPIhFn3slvQnhL9zi2o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxje2LqzxMTMPusryynRyQxj8ux+Ad7Q8j5WxFnNV388zNRlZZ1
	c0aCGnszJaIEIdhc6yLXo/sk3WClopr8O2A4SOqGH51dTKC6ElZy9NmTi00AttFdbo9MFgQ/n4k
	uwfVVWn02HPRrdYlH7J/DuVeaLPSpw+8=
X-Gm-Gg: ASbGncuLCtLIuCkT8TsMK9lev3WUtahNNuj9I9dgLUw+G+uTE+hP7+zOfunj6MJe6yH
	pFwH+PENWikfIEhfWJ42YhL7P9hE6Luwcuc6zoBbxPJPBj/dLdL1UutdHdS2I/dqUecg7W2C53w
	fhwttLwl6CgvWx4S9yMZyAyK1ZSHNqwLGjhc03FXkCj4wZLM8099QBGL2rQJ+4WgOrKk43qJdfK
	xzMhvCpmD5WJPxv61VJjqrDGGm2Fo6AAF9kEpltX7M8m1D2KRiXw0f9QNVaDGd3YweJWJx1DJ8Y
	CvC62HnDoBwHw8966vMjgBYPOQ==
X-Google-Smtp-Source: AGHT+IGJfjvbg5f97Jik1nNzoPIGbFOufW2fVMHSl2U4znNLEKqymjptXZhYoHsZvjFTunwLS/s15gkeUO7vy4IkVVo=
X-Received: by 2002:a17:90b:38c3:b0:324:f96b:de32 with SMTP id
 98e67ed59e1d1-32515e41284mr1053607a91.1.1755826814921; Thu, 21 Aug 2025
 18:40:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819-maple-tree-v2-0-229b48657bab@google.com>
 <20250819-maple-tree-v2-2-229b48657bab@google.com> <DC6DC244ZIUL.304JSP7JFDE9Z@kernel.org>
 <aKRx8xsY8CpzbeEm@google.com> <DC6F7BN2L19O.1APQU9KWZV7H5@kernel.org>
In-Reply-To: <DC6F7BN2L19O.1APQU9KWZV7H5@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 22 Aug 2025 03:40:03 +0200
X-Gm-Features: Ac12FXymQfbLuMTcENTyCTqgnDSUXby9v6Bd3nxwMkPNwiF_YHAWlzVCd5UEEHs
Message-ID: <CANiq72=xdryEKzo73-1vaBqGNNme2kRU0atP5PYOnOOXjNxZZg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] rust: maple_tree: add MapleTree
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Andrew Ballance <andrewjballance@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	maple-tree@lists.infradead.org, rust-for-linux@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 2:58=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> I'd just
>
>         assert!(tree.insert(100, the_answer, GFP_KERNEL).is_err());
>
> and if you want to test that the error you'd expect is actually returned,=
 I'd
> suggest a regular kunit test, rather than a doc-test.
>
> I think doc-tests should mostly illustrate idiomatic usage, especially no=
w that
> we have good and easily accessible kunit support.
>
> I say "mostly" because I think tests to the degree of where they stay wit=
hin
> reasonable bounds of illustrating idiomatic usage are fine of course.

I agree that we should try to show idiomatic code as much as possible.
At the same time, sometimes it is instructive to show in an example
where a concrete error would be returned (if the error is documented,
i.e. not an implementation detail).

So I think that, as long as it is clear the call/line is "broken" on
purpose (i.e. as long as it is clear it is not real code) -- for
instance because it is within an `assert!` and/or has a comment to
that effect -- then it should be fine and that allows us to have those
instructive lines too.

So, as a rule of thumb, probably we don't want to show `unwrap()`s in
examples if the code could have been written "properly" instead, but
`unwrap_err()`s (i.e. error ones) within an `assert!` are likely fine
if the example would be better with it.

Cheers,
Miguel


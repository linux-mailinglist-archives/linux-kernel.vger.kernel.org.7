Return-Path: <linux-kernel+bounces-766583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D326B2489E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 906636812AF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DB22F7453;
	Wed, 13 Aug 2025 11:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEkx5JXX"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E47E2F6596;
	Wed, 13 Aug 2025 11:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755085249; cv=none; b=O42uh0lFEmQEMBGf9tpJmRW7WM9nen292QN0pZ6lKyrfPRb+n5n7id1C8UEia7CWk46KXPzHyGK+DT170VQp5kLSSqP5AqHZXV2hcMG+ltjKlBUps2H7xwZGJYbMC5eCJLAS4C81KWTI6UDE9gtEzlONPpp3rbnNndWOYPJ7AwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755085249; c=relaxed/simple;
	bh=30eazwQA1iAGDBZ7IpbUkL15fiROmh0G3TBY9huBCEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cmx3tI9RiyPnllpwKad9COSEUjG+7OJAX9NSPZrhakFxBC7ySwIcLcPI02x7PB+XwIJnqbuv1VG8reY+x54RFJfhSCs6H6xn4O37sUVdP4VvZNxh69LS0+guB8Qsbos0KGy0XCL1/34lPXzIy1xWr0OtbQPnpPNv7O8+a84erqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XEkx5JXX; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-242fdfec998so3148915ad.1;
        Wed, 13 Aug 2025 04:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755085248; x=1755690048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=30eazwQA1iAGDBZ7IpbUkL15fiROmh0G3TBY9huBCEQ=;
        b=XEkx5JXXuSu5jn5FKm+9l7IOGx6kFF9boZYoFmgT+Yio9Kec3gc01yEXi5hkha/t1C
         pUP4MwX5j+g31PqwbR6RDz4A9de6idQwzOBM//WP/HGtdAITIxdc5pE2XMKkjPN1qmQE
         3G20NUuQAhOyNOLtv2WUbrJ6F6UF8ZR/w/odHfdPDzqVIKqzwxD/xDFV8KCyGCi7JIy6
         kkcFf6qBCCD7UoQipwUiFhfubf7Nht3e7iW3XsmUk10td5D1WN8sUxqyQIKpc9/u79lE
         pXMMlkQ/SdYcE+d4xhdZ/mpGuBj5QeF02Q0I26U5K36mB/EMh14Z+kOMcFfnsTPoDiLh
         NSrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755085248; x=1755690048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=30eazwQA1iAGDBZ7IpbUkL15fiROmh0G3TBY9huBCEQ=;
        b=jg1bjXEnkWSUXCBy5UKv/DdaG7HpQwgxbUZLpTSniJvJeVfxhM9qLVptp81gWNMsZe
         5mRYA2ky7zNDFqYZ+9EHSEEBUJmHagHAQ/RYcGHi4yNlszqjgxKW0MhOSZ8WeQhh8pDL
         LNJHeNR+DvwItf2EqT1vvq1ADGNEBP8S3URvU+VfAJnQ6NdfGtsyUTP8iJtyNg5cJhhm
         FsAzRhkEneu1hxauUflOLFLYaDu+m9F4n0qFCHqJAlAhsvvj4VjXwsK4qlIYLyh3QyfN
         wD09TXX61hWuPdOd/ZX9nhQZBNPExKtJk8QGeRb6BzNMPFCBpKQTarIRYujbLG0Mizg9
         s1OA==
X-Forwarded-Encrypted: i=1; AJvYcCVahpWzs99SEjR1nST784HKCFC6Gbb8WLifq3bOn/koCI3oAXTUj5isFmUtQx07tDWG75ULQckbJmjZVYn28x4=@vger.kernel.org, AJvYcCVdPzSlLfbzGqK8tHW/ZzCpAxEc3rpsAxvnVQ96JX99RSoZ9PNz2jrCX+or04HsEmIFYYDHT4QJ7nlDNZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ6rXxUmq+Ma8fskm4I9ZVOzBsY+fOhRIKpoLhHbqvjIRNq2P7
	hA8kREd7hPaZlcxr8hOZVvI/EBkfKqjeUxpl0yEBVjKnfeRLAh71alAqC9X0rFYLBdcU+FXMeFo
	CY76PerIBB9SwnpQR27R9LPZvy3IdjkY=
X-Gm-Gg: ASbGncsFSLgWfgFA8aHsjrJbQJlI135G+BaXeDaD9uCKUDDQUJyT0i755xPtvtBu7YS
	glMDwhpt3k7I4MD9Pg6qruKEA0aRESigY/ysQ5mSgXN2KajLViBA8BeiVLHkWXqv2Azody2lm+Y
	tRaeuZbC7iSQp9r9dPGjXjJaA3JkDxHHg9uZs1n9jx/ibjgTi85p+p6dLQbu58mtVIWddgg2fr1
	ZKOl+rKSVbCPl3hiXY=
X-Google-Smtp-Source: AGHT+IF0P7sV3E8JUcBsGap79tT0g2ONVVfRY0RKBAXbV9yffOAOsUbrl0i2YhSHzU6I+4qQg8lYJ8In4MptmjbbYiE=
X-Received: by 2002:a17:903:1ce:b0:243:9c:e95 with SMTP id d9443c01a7336-2430d28d056mr18870275ad.10.1755085247707;
 Wed, 13 Aug 2025 04:40:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813-iov-iter-v4-0-c4f1932b05ef@google.com>
 <20250813-iov-iter-v4-1-c4f1932b05ef@google.com> <DC19IMWVL93E.S1AO2KPXB3HU@kernel.org>
In-Reply-To: <DC19IMWVL93E.S1AO2KPXB3HU@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 13 Aug 2025 13:40:36 +0200
X-Gm-Features: Ac12FXzSxehDkd4ATIWirgLU2eXPwGxXIn_ahNCqYGMrTEELVUMbkWBrVFJwtX8
Message-ID: <CANiq72k-ByeB4W04tf7MV0y-VPsAzBehB6BvMLPRcbXmZFUTkw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] rust: iov: add iov_iter abstractions for ITER_SOURCE
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Matthew Maurer <mmaurer@google.com>, Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Benno Lossin <lossin@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 1:27=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> Technically, this covers the safety requirements from inc_len(). However,=
 do we
> want to provide a list of justifications if the unsafe functions has a li=
st of
> requirements, such that they are easier to match?

Yeah, I think we should at least try in places where people is OK with
it, to see how it goes, and then we can apply it elsewhere, especially
if we get a way to automate checking for it eventually.

After all, if we never start and get the ball rolling, we will never get th=
ere.

Cheers,
Miguel


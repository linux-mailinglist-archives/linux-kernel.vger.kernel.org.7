Return-Path: <linux-kernel+bounces-729184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2841B032E5
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 22:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4957F3BB72A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 20:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC54F285C94;
	Sun, 13 Jul 2025 20:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bi6UUeh8"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDEE7D3F4;
	Sun, 13 Jul 2025 20:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752438786; cv=none; b=crUs2NJT/GAbeMsDAj3Co6XDv0T8dKnEl3y7Fl2VVoid4Vn3eW9qL+yeZrsCahnY+5oM6ppfF8tHyZa53wZRmHVs5sTkk2ygj4JgxL1AJa3/aSMwBAxjV0fivautmz/nCPSBqXY2/A3LavtymAnMN8y/WA3XFf3cmqGU7DSZpEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752438786; c=relaxed/simple;
	bh=M5aeDDlsHBpOFmn0fE/68QZYXv1RlMbWaX3NW3z0MME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MxR03PK9E86/ZTbYRxGTD/QBuWStAUPFh2FpV8bs8AZSJ5xH6x3jyO2D7jLUiZjWejemerefcGM8lfJHKGnZqGfzgkLOwoan+hX1y/wVye9Qv21Kn5RSBulEfmJbBkVccPh01dPwF5KU5wEsB+30n4SiJVFPI4oSGGaxPm06WPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bi6UUeh8; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-31384c8ba66so705166a91.1;
        Sun, 13 Jul 2025 13:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752438784; x=1753043584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vTsuot6q8R2uuxbbQSPqtMa5LTOA+c6NQDO3F4IHa+U=;
        b=bi6UUeh8tu19bJD904GIDlufgetvHS0zY7p3tS5UeYsdnqwjwJb7Cm/BSmMYIB8EGF
         ZfK0aZxGdjZY9hIDgAOhANInqHRcm16QQ+R8FNlh0HnYxfMz0VFoj22nvUr9vxMBmYzi
         szKBqC4pzRLynI9FQ7orfDvqhYtXSMKX9ByBaDbqDiY68/5n3o7eSttpEvL6GfgE/ECE
         oqvpk7xdP7p0dYpgdEno5PsSkQEcijQdWbAoCLkNGGm4SA6BAnFPG4tSDOwIFNwAfwqs
         N4ud0shLVlyfAqpX0jdD4mKet8KWIg2Wn6eEgWh1bm5S9yovLt//Dj+u+SoAzn1YXGc4
         6Mxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752438784; x=1753043584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vTsuot6q8R2uuxbbQSPqtMa5LTOA+c6NQDO3F4IHa+U=;
        b=L7pgYA3+FeRf3tiOWSLYC1XDgzf/fT0PgCGHsSC0R4cth5XPMS/C0xsLbUF/9rBCS9
         yrliU7dL9lMoA3v8tjpHruU4lMFFTLUaNvTqo/rSc7ETKcCZ2KOW/ssM5BOp9HDJfrS5
         VR93AWqrE8pigGhYS39+bNt0d6w/Qzqt8d3groYR4l3WCTCer6s1YBh7X8RYg0BB7CCY
         rw8OBZxlJegHObGzsmDQ6hnrmtAI/D2Ez1Ybqk0JVO/m5Liu+YlSPBXIJplr9w6OKOZm
         h3HZiYOz2IbLC6OJGu4aK/lSNDmlrmXWQ1rvP/FpI30mKvaAzXSgviYZssMZk6pg7nLY
         vbjg==
X-Forwarded-Encrypted: i=1; AJvYcCVapxp3hxbv7tSmbv2rNj9b0twpvSySKrCFAnFUq2xMz9PxZQBksT6PAh0iWI8WFHS+mAmnx1uBxf0uaJU=@vger.kernel.org, AJvYcCWQYTm8WnNe4eqxfridJljwQAUVHXqcfSdJoOImLM/uW65gECtwdp3pBxO5LrKXEX9kQWQ7K/fOvqOyGBwnhYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YygmABBlY9/yAhrG7iXJM301N4ubLLDlWwmXS4mGXAiHknkFOhO
	Du9znDAv4iLiLMVK/KSRU8Kc8YfXtMDYniwNoN/zmHf9LPUtUxHe6N/RzPQVsGwjnhVShJVmpNN
	ARj1JK7jRTm6AdKPDfT++dDraT3sfl6A=
X-Gm-Gg: ASbGncv2gXdNSI1G6LygbVU7THA6e6jnJrPVz2F91ww3Yp02g7eZwB4+SrE/myTZHH6
	CaDOYqUSqK2uFKvN3ppwYc+xhdO41OQUeSAUdf87l2tWqVMis2KzL+NHdZ2TpDcJckiNPTYRovb
	H0nZw9kIQegow5ygw3fGq2eMcgSEHRJ7/AOl9qyxBXNgJHEakvnTABIFqWWMpcwYl6DQ3UzBH4d
	IG6yjHEuDxU5FAVYyY=
X-Google-Smtp-Source: AGHT+IGDJeIFVEAj7ghQ0LasiFT2jQb0m0xht+EnTXhZ642ukLGS5gB55ZzqOFyHVFdSYMKAC805Cclm4WDecF/OKEw=
X-Received: by 2002:a17:90b:3512:b0:312:e76f:520f with SMTP id
 98e67ed59e1d1-31c4f56e8e2mr5702680a91.8.1752438784109; Sun, 13 Jul 2025
 13:33:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709-init-remove-old-workaround-v2-0-a3b1be8fd490@gmail.com> <20250709-init-remove-old-workaround-v2-1-a3b1be8fd490@gmail.com>
In-Reply-To: <20250709-init-remove-old-workaround-v2-1-a3b1be8fd490@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 13 Jul 2025 22:32:51 +0200
X-Gm-Features: Ac12FXz-_MATW-oCwa_YxMCS28R44b8Bl12CrMzf5XZnFzjDNmxGp-woowaVY2I
Message-ID: <CANiq72ngcL9CSkSTFcp+Of8PemAKbvQc1TJ5s3vCiLoHX4QfcA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] rust: init: compile examples
To: Tamir Duberstein <tamird@gmail.com>
Cc: Benno Lossin <lossin@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 12:49=E2=80=AFAM Tamir Duberstein <tamird@gmail.com=
> wrote:
>
> It's not exactly clear to me why these were `ignore`d. There are many
> others like this in pin-init, but I'm only touching the kernel-specific
> ones here.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

This seems essentially equivalent to this one applied a few weeks ago:

    https://lore.kernel.org/rust-for-linux/20250526152914.2453949-1-ojeda@k=
ernel.org/

But that one uses `expect` to, which is a bit better for the future.

Cheers,
Miguel


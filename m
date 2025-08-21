Return-Path: <linux-kernel+bounces-780074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA39DB2FD57
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 758BC641368
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B361926D4F1;
	Thu, 21 Aug 2025 14:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxDwEjST"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B605620B812;
	Thu, 21 Aug 2025 14:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755787107; cv=none; b=VpGcdZY3pnhTTq+P/lnEx7GpOd1+v23gGtclbvwKd7qguif4u9UMvNIBM9Yk12P/K6wZ7jKdkZo9lLx9jnOZXFGPPLBjorYD/AVyFe51WbaEbNCHNFy4+JRTxSsd2YrBkgLgFrtFZpQnBJjhuzmNEitD0nBIlX/PjMUwjnWhc50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755787107; c=relaxed/simple;
	bh=j6SR07+FNvyjby3yOkFywyZQUFe0avGy4QyHwKilEek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NGSYfN0BfX5q76YyCvyyeUwEcFgoITooruM0pHbNr1k2d9pcyCWHML2Kw/8iGIB/1qGg75TdLOxX2GAnDaOd1jIRhM7gOECtoN33QXOtxbc7jLAzusQCqvebWUX0GhFohs7lEbDxGVle3gqECfG43U/STIUsoxYzIIRIPBHGvLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MxDwEjST; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-244580692f3so1711385ad.1;
        Thu, 21 Aug 2025 07:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755787105; x=1756391905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6SR07+FNvyjby3yOkFywyZQUFe0avGy4QyHwKilEek=;
        b=MxDwEjSTmJvL6FxbCc2MUloZLd+VKGpLFgfRmQc1EVacj8iw6M3oXeUH5N5tdRqCOV
         GKjWg8pIqFmtnXRp4uqS02eiD7ulqjD7p1mxcTWLSNV9Y2ymSTBrBrqyj2FxCGyVbKnp
         qbp5Q0W4aMqQ2dNGFo5up6KF77aAh5mar5LZnee3n5We3Gvrgy/pTwPuCEQjHIFG07+y
         YsHHWxMZRf9l8lsUzXCx0mpijZzlI8h2GbrIsecEaCQHBPlEk3T1QzZxxK9tlx7TuWDs
         YqY2Y31skhY7G5XltYteDx0U21kf1R9OTu4rG1A+nXz8yYMx4Y2cgqn8gV2zDNdcEyq5
         yQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755787105; x=1756391905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j6SR07+FNvyjby3yOkFywyZQUFe0avGy4QyHwKilEek=;
        b=Dwhg3jaulIIrnxLa9iqwRfmAYyd6D7EyHvJZl/Vnu+Tj6eG8zFqlbN6mZQOg1MefwR
         84vmVM89t3T1kgMkwpGX79PjUTNqLi6K7RalWNYfHYXnQrTzL3uFnsIHZZJAUnqmXqa+
         DgAeFCPvW1V6eM64FeeQgvcKpQ7kMcGuczwgo/lMW/gzUUbz7Qpq0o+lrNsuDQiUV3Sp
         Kafafx7P1eu2Dv+aWfpQrWpZGAmL0fAkxRXap03go4swfl/ohjQIMJLK2mZ+ZsSNQDc7
         LB0A0DdaPEJ7sxYYEwQm1sh/ypJmc4zSrspJFxiMCEAXyMLfdZePI6mxw06Q0VrW9E4P
         wXAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFj1Ya/RayeK+atmg+i8qW4vlQUWQFbUklfXxMcb7RoJvLibvaLVbuzA95sygsvdcVJ88aJYPIa3zoPNVnFZQ=@vger.kernel.org, AJvYcCWepBG6VK2qH3cY16gLHS0n7OdRuhXITC4WkGwHOb2roes1AU7abLbU1ArsfvpDxWC6HR09cd9cD4Xqy4c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjd4OHAUmY0EkKR/rXT4nWPdi6vsCgwMoMicJdegFMgKhUUhCu
	WRxk2FkYclvvcMDuAq/Bgr2R3/Yu6XqUObIADvtVU3DsVgVoCDWW9nDV6ncaMHNiYeT5vl8Ahqy
	Q6FBF4khkDeuY8sA2w651kKuSzG7Pj3A=
X-Gm-Gg: ASbGncv2WtUufRluWcpCNkNEcx+4VsMfvQKBFLdtqGhy2f2SIPLk3CCtHzG4jWS8CJ3
	aeZrYSWZv9ChA1rBRDldnC8Ndg5ap5/wtWmnXtAb9dDh0fsMrYjQLnYcbll2+gcIVPSCeHQ436h
	lr/Eu5ah6dPlV+FzDG8Vkk2juuJvJ7XS2wZU779ltlV91Mq/zJ9evm3gTmYrtnBt0mxHqONkn1E
	nXQA9MRc2tXEW2+ScY=
X-Google-Smtp-Source: AGHT+IFvIy0w7nqqtZUq95cgQU513UjHBm36ov9+ngxcr7lKlYZgOk09StKiwpgqlqXJTbb0brCgqCXfTMi948QbG6s=
X-Received: by 2002:a17:902:ec86:b0:240:5c13:979a with SMTP id
 d9443c01a7336-245ff8dfd49mr18001875ad.9.1755787105051; Thu, 21 Aug 2025
 07:38:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801-as_bytes-v5-0-975f87d5dc85@nvidia.com> <a327ff52-c37d-4f51-8d19-d6b1cc858d79@kernel.org>
In-Reply-To: <a327ff52-c37d-4f51-8d19-d6b1cc858d79@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 21 Aug 2025 16:38:12 +0200
X-Gm-Features: Ac12FXz8tvKXmVDnFo3sdZL1sJ3U_Iys5NupU5DoCVWGtpQ1aojoeg6mQN7Ha4I
Message-ID: <CANiq72=LhwvvsN4A1F+3CffTF59=Gpq-B0hzQOszMPhTVo0hug@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] rust: transmute: add `as_bytes(_mut)` methods for
 `AsBytes` trait
To: Danilo Krummrich <dakr@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Robin Murphy <robin.murphy@arm.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, "Christian S. Lima" <christiansantoslima21@gmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 11:49=E2=80=AFAM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> Miguel, any concerns taking this through the nova tree?

If it is needed for something this same cycle in Nova, then please go ahead=
:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel


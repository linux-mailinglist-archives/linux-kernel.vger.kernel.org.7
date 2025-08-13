Return-Path: <linux-kernel+bounces-767049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38979B24E6A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18BB0160577
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40AB28D827;
	Wed, 13 Aug 2025 15:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3a7zSGQ"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD535286897;
	Wed, 13 Aug 2025 15:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100020; cv=none; b=RVz75C0509er84ui0D4vE/iRirchAT3LSPsMRbPPtHTnUZ9qjCdhcnr4++fS8kOa7G5a6cAFdnd/6Rkf12tP3c+VqA/K/92t2UIWEON8BBQDFsi3WWG8vURC79jZAs16iBABCSPOD5XwRlArVnUcs2DwOEY9DiyfJvgjsSbgw/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100020; c=relaxed/simple;
	bh=8C3JEnBgzuNeaQW3gWYprsuy1sUTrnX9KF6z68NKKbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JH3pJVt0zatn1vS9a3tIUfozM/zQbKngJy0B2Zmf5dyfLR1rrqvobISY1f4zPga/SkbtlL4MkMwKDzt4mvhYYUA48kKLM09gpFlr//rddF9JXCdhuVkmv9Tz5Rm5CIowJuCMikjQSVvk7zPX5W46HPawFldKEBVuD01j36ziY7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F3a7zSGQ; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55b733911b3so7619667e87.2;
        Wed, 13 Aug 2025 08:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755100017; x=1755704817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8C3JEnBgzuNeaQW3gWYprsuy1sUTrnX9KF6z68NKKbc=;
        b=F3a7zSGQKcM9tOsFyyqOUl+FXEetrgBVef98mVn5tN24hMY1NaMn8aSnTK0WB8Z4cy
         5FOK6zfRavttl5ue77oCukj3aFfYbtGU4T700Or7Y6/5I8tUL+1VRCI4E4VUFBZLqma4
         1C/eD1PI6c6Yg5OOB5Rfrply49qrNyVwZaLv9DuZQ4Po/R+isCalhTYcZ0r4NvhcsUEX
         PX3sGbGWvV9jXygpTFZHiQ1HIoY2rgA0/yCeCLuKfZdwOpDIppxw3WCEwqCtlnrA6vWg
         y8mxt/aAeGvjJnOo8PSw1L3LAKthWzLEd3cuJ5wgDEijQUnO5sBBJMp0SQO+dUFPBmjw
         qecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755100017; x=1755704817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8C3JEnBgzuNeaQW3gWYprsuy1sUTrnX9KF6z68NKKbc=;
        b=xFEaU7Jqup8HEpKHoLXQPBFY4z0vXBfwQ+uHE0NcTDaeBrcJfTA5VQrRht8PJZ/it+
         sXHm1Dxr0QahuUksIz1QG5crXZHkXQfrCkEbHJ4/uLeGKisiAUJnGUKrdgfO8qO7RLMR
         DvhZ1sfl8k+TG8RtzRIHHXr9LAI4eLa42qaurBp0Qmd4GlnkZ8gp0M9Wx0doQ+8wySJ9
         qiikICoFQ316X/AHUnoZQjglP6nLVbELgZn+G2tlqrg6ohELJGY57fe4VTWhzwJlDWDU
         KrQPxmcf8+ULLrKzIv+3dvmBEETbr9fdqteVkg+oXtTplw9DMdbnAA+s3Nm55zJUlbB6
         xniA==
X-Forwarded-Encrypted: i=1; AJvYcCWF9lF+xq/izg3/pQFXRxx5/9vvpoGILuS9kwjHriqAT6fiZD4zNy/KxQGCqhYlbBQs7bXNx1sS7b/c6Yjgh34=@vger.kernel.org, AJvYcCXpge9ECCOp+Wlfal1d4Msgcmd2mRi1MozYOyfWpIDGXB/XaI5b8DCe5/srNI1smwW6YUEHZPPWRotAXyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWvUcF3hdtkDYlYieF/GajNAac+6gBDT9xzKFRyiHBdNpTx6o2
	/3Q/aPQt28lu79PkH4gplOX1wPjRO5r2/CV7RBM2xKA8rXgEb+SeLSgq5Ssuv9x1gJw3R+Ixibl
	XJlyDkFQFtFi8UTQ4VK89nOvhQWquUrz5YRtqA+4=
X-Gm-Gg: ASbGncvfug53v7l8/eKNFDCxrME7Ws+5Uv9Iza2rrgYWlmpInqO1FOstcqOqqiFan27
	ww0SVwbPmWLhSYVt2cC4d+IK1EtiVWf7ByW9KpIb+yh5wxrOT/CqseDS5YfNSrl9FvIC7Be43TL
	eX87Js3D6s9saofsJgSDUlXJnGcfWgZ99mGHaOzJFRpiskWqizU/Er9G8qOnaoqW6vxZNFy8+xW
	ekmzln5YoyraDKVZ85zQwECdsD/SdEXscrz3JprM86j01EQAM4d
X-Google-Smtp-Source: AGHT+IFlXjCtm/3mLkCKgCQ6oaovDejKJiYTqfx+4Vkk5VXVTLRBcQTPsK+L/8GMgwvkv1tCQDO8KsHElbAZgcSuwQg=
X-Received: by 2002:a05:6512:3ca6:b0:55b:96e4:11b5 with SMTP id
 2adb3069b0e04-55ce01418d4mr972466e87.1.1755100016614; Wed, 13 Aug 2025
 08:46:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710-cstr-core-v14-0-ca7e0ca82c82@gmail.com>
 <20250710-cstr-core-v14-3-ca7e0ca82c82@gmail.com> <DC0A9UKTPH05.2O2V0B2KHMIW8@kernel.org>
 <CAJ-ks9n4V-PEDhkTv6SXj_Oh6LB4LdsNi8Nnv_6JbT7dhvnh2w@mail.gmail.com> <DC1DLSRDL44Z.W74NH6OV15J6@kernel.org>
In-Reply-To: <DC1DLSRDL44Z.W74NH6OV15J6@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 13 Aug 2025 11:46:20 -0400
X-Gm-Features: Ac12FXzrZuqOWLNuD2WsxnQxv5byqHT3WGfhqIfZM1e5IVNorXHuhluYNiSBDPo
Message-ID: <CAJ-ks9=ttX3tYzVq9Kb3Qfx+D+i5_Q7Q-rCHAEpH+fCFgF8AxQ@mail.gmail.com>
Subject: Re: [PATCH v14 3/3] rust: replace `CStr` with `core::ffi::CStr`
To: Benno Lossin <lossin@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Christian Brauner <brauner@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 10:40=E2=80=AFAM Benno Lossin <lossin@kernel.org> w=
rote:
>
> On Wed Aug 13, 2025 at 4:06 PM CEST, Tamir Duberstein wrote:
> > On Tue, Aug 12, 2025 at 3:50=E2=80=AFAM Benno Lossin <lossin@kernel.org=
> wrote:
> >> On Thu Jul 10, 2025 at 4:53 PM CEST, Tamir Duberstein wrote:
> >> > +/// Extensions to [`CStr`].
> >> > +pub trait CStrExt {
> >>
> >> Should we make this trait sealed?
> >
> > We can -- but is it harmful for someone to implement? I think probably =
not.
>
> I don't think anything aside from `CStr` should implement it, so I'd say
> we make it sealed. There are also safe functions that return raw
> pointers & an implementation could just return a bogus pointer...

Done in v15.


Return-Path: <linux-kernel+bounces-815321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33554B562A5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 21:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68D761B2658B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 19:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086DB23D7EB;
	Sat, 13 Sep 2025 19:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqzklJNC"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9AF14B977
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 19:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757790220; cv=none; b=NSEWM+wwk1BoG5B2IG76VafN3WfNK13nyYEj+yLS+tSwJWcrAXdR/q8Yk81kXk4B/BJCFm8V+AYTiff9AHi72KjTzx99xly+ETaVtrnGGrffFZU1N7N+ITBmfho7+zzIKm1MAAd8CEsjkN60bGZIngHZL+DuAWF4AalSsqLMfQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757790220; c=relaxed/simple;
	bh=RrErQHMoufTYXa6RoaEp8zh1hIka2FwFAyx9/D2iXb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l7k+tQLykoq3KDaqufbxxEqb9z9oOpD7pyzc06WJHAKiTRAk9vG6Bb4i7ZrsW0uo7D3/6EY7CLDj3eBY4DEUG8sNkcI8c7LOEw8CIGJTct0MppxKOS75txJ8+1/N9KUaUbGeLmnf9O1cIo9JaXxJlfDzmD2We/nVHHYw015P1u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YqzklJNC; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-25c70a8f783so3457015ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 12:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757790218; x=1758395018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RrErQHMoufTYXa6RoaEp8zh1hIka2FwFAyx9/D2iXb0=;
        b=YqzklJNCC7ugoWV609NsZqLrlGyeN0HpCB/snpzeP1sLbihAMbdfDxbjov6wdNMIse
         muZEAzGT8raQc8TTrrt/DEdjjx0qTeQWnIuFDSLCKcFFYy3lNWEAVKUqlo4cVgQ1mZzf
         GZrr9haoJcM/seKiNY/ucGnZPueL/1bOLQiQnUh8fVXnm87xXJypfoTFC5pjRL3F9zV2
         XDW5fBpr8NwDrqZQ82Fl8ULGaT7yUs3TjnN6CFMQHp65pRsXgErGwPmXXHjQRVmGX7mx
         MQjsv0osmK4ZZB1FcEzJSdItLVqKJWxkGth8moAt4Fs2RcempZBNaMW9LUVrABNHzflA
         Y6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757790218; x=1758395018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RrErQHMoufTYXa6RoaEp8zh1hIka2FwFAyx9/D2iXb0=;
        b=jYc6Nu3SjPBoM11MfE2zoYcRdV61PXCUnLxyhI40DD67JyVj3BVCG0nqyRSPnPRurH
         VJUP7kQd5mFFa8RrLuwwSekrPo63CVprOXYfEo1nbMszJJrw8G0Wudg/Ct2FiHQleRT1
         45O3dioSdlPpHnO9MT2pKy0Mrdw9FGnem8n0XbPc7MBvFZ6j2hExFc9rUxxs7fmE78Wd
         9k9M6IX7r2//iX1FIzgSj+OCX53pIzVeI2exUSiUZgY62I/lmrbPoxczvfoHGol7fE7b
         a21HtQweg7EBu63mVvzLh3JJH1z22VRNFmoQHH4Kyrjndtm40ic3VDj7ZmsCVhZ3lSgf
         86qg==
X-Forwarded-Encrypted: i=1; AJvYcCWr3zreT4zP4feF5eUT49Vag1XgRI1ydQNmhJ3ReeXSqBA3xjK6nUAJSZRiPH3pgjZyHlrVOIEMMSaxWa0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFTQSkgkZNSLSNc9XOZz0D55cCdLXzEWKUJ4Xi7Ckpxm7tCvqY
	d7tLRVyXO86ABvAmIk2ViLsRZzjypzp+vpgHWw7DHIktBx/QuAu7EhY/PygvtJE3oQf535CtZQj
	tKzi6zK1IKjtren5VDHhNUDeIAPpgnRw=
X-Gm-Gg: ASbGncuvraqLd8HDEYvhI6TPWUG9/nMLTDUsURoJeJIDc7dzwPBfdnrqL1y6xARBc7I
	mIhCRUMbrvhEGHgqg0SR6V7ba5OJDGfVNYXNIYF70VRKnIJecwsSBqG8cVOGiYNUdseZbcCk8nn
	wJH+auBp+s17+JcgdFA71JIm30sZSBCtyKVpPWHs+JpHY7e4yGY3pUduz8H3n4+K7pIeGLo3xvX
	8XWItUsErPi+5AUN+T5//5+SJCRYJY3y9SjgtzvjUb8ur96VPRvWRNVBq1pzTGF/Qf0tDOmY7Hc
	3zVNZZGpjONpROxfUVVAskj28ik2X77+/S5u
X-Google-Smtp-Source: AGHT+IHB/p3aamI8tG9kOMmpITgJyh98PQ9GJhpKrDDNtlxPb8Z7RQ7MmcePFRjRvqHcelMNs9pcfv+bsQ+RJAs6Q0c=
X-Received: by 2002:a17:902:da87:b0:25d:8043:7832 with SMTP id
 d9443c01a7336-25d804381d4mr48208615ad.6.1757790218426; Sat, 13 Sep 2025
 12:03:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <-ebVaoKp9tTjZGmdSRi8rrH1o7SgmGyyzk-g2ALSCBKPJP44z7dSPCplhwKt-sibwLwqP7IPEml6qCkSpJhd8g==@protonmail.internalid>
 <20250913100847.9234-1-work@onurozkan.dev> <87bjnei6tn.fsf@kernel.org>
In-Reply-To: <87bjnei6tn.fsf@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 13 Sep 2025 21:03:26 +0200
X-Gm-Features: AS18NWCQkGD0dQVq9enzHNa30IHtZXRVI41tuTqtURXPnwY5pteGtWO1FPfH2ls
Message-ID: <CANiq72=zP0TLCjM+ySOu3Zbn_UnU8ntqb2MH58cN60O0Voe+hA@mail.gmail.com>
Subject: Re: [PATCH] rust: add `rustcheck` make target for check-only builds
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	rust-for-linux@vger.kernel.org, ojeda@kernel.org, nathan@kernel.org, 
	nicolas.schier@linux.dev, masahiroy@kernel.org, aliceryhl@google.com, 
	thomas.weissschuh@linutronix.de, tamird@gmail.com, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, tmgross@umich.edu, 
	dakr@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 13, 2025 at 7:46=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> I think this is a good idea! However, it looks like this target only
> checks rust code that live in rust/. Can we also check code that lives
> elsewhere, like drivers?

That is more involved, and I don't plan to add features to the current
system, sorry.

Cheers,
Miguel


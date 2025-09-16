Return-Path: <linux-kernel+bounces-818923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71675B59821
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 071CE461B4A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEB532779D;
	Tue, 16 Sep 2025 13:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTFohbEX"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A4832144B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 13:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758030498; cv=none; b=uvSnbbu11BR4RneF+/zVihrKFISewwQLFFeqbUt7AnxmfPlQ+HbZ3xQGvkNN5a1AYCJpsbw61ICz1fnj+9w+9/uiVKgdXcCFunK1UZgfKx2BC99+crzgjtT4whdhNuU5xPiqsnrPvuYeyN++mIDFAh6OWzwQ2us4ngQ7Xd9VjIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758030498; c=relaxed/simple;
	bh=8YBiX6qZT94GAoJ58JfjtvK+Xo1zg+9TGgfZuFP0Hzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hUZ2SHMLCm+IFwO0q7eBRPusDqUUVur3niuJxj2glhdR/WbCYRrdCGiupjuaY78PED2b+KdLLdZCouTOB5wFu4nvFSgPA74OB4usg/UnRfZ70U6y09Fj58fMJa4q8kqhBCqo8ReCni9Ya+CJgfOc/trmsPTgULb7VUspGlnvjKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RTFohbEX; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-267dbd4e189so933325ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 06:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758030495; x=1758635295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YBiX6qZT94GAoJ58JfjtvK+Xo1zg+9TGgfZuFP0Hzk=;
        b=RTFohbEXeFwCbmPc1PJCA2iq+Yt+pYPI4APwV/zOmcVbqEFnE64ybx0RdT3BJ3ZfaL
         ShbdgwT2G7gKEGf/NJO7HUnqYFeUilo6X6Bn55ZgRrH99guiJvSb5FnbydMA+MSwa771
         WJJBGD1pQ6GrALsmBwIOV9Kq1dCu1sWRBWqkHE0H1t9lY8WPTOSfpr3tUQ+pXbAAVcQg
         F4sH6tAK/a7wMZtbN97+1uo7G2YZnl3xYt+OXPj9QSiAU52dvPUvLEnJ1MNU7f3GPjZy
         Xwa/e/zIRkeQQV/IdlnbQz8nreM+lzk+D6bbl20jJKjLjN+t7BHRYvLRmFxLlfNe/Odc
         mTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758030495; x=1758635295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8YBiX6qZT94GAoJ58JfjtvK+Xo1zg+9TGgfZuFP0Hzk=;
        b=E6JD2afUshsCZ19SWXj1Rb5tzlGTd0eMwyO98pU+4hx5IG2+cRLgmdtCv+Vn1lSDYn
         p931CcKfxBhM00NCCW9RXdFxhLqA51tewcpPkezHrQDtf/V0GMIZFbEiAsAznV9CBzwd
         C64tnmogf3KZoWU/fLRAp+cxtg61I/V0TcRkHXxvsUVzi1Di34sEse75tUXu5jRaSq3Z
         DmKzlc4hEtUaVD0XnaNpAMhZMWCx9m4swsmODJuExGFhoqVYBNfF6X0mxUwfhHUk8pu6
         YjrqBZZXFp3FoplvtHzskKh2tCoFni6A7ag2cKTQOMEP/yiZ2czt4IdVCXIbG9jv7SNv
         tRTg==
X-Forwarded-Encrypted: i=1; AJvYcCVcE4GFtZXUF05vE7e73nuGIDS2BNbroJMDtjw8M7QqZ0OSf3k27pmbCsJtQZ4vGtzTkzKzau/aVw6N2Y8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxmIKZDXgge0WxIZHHfTlLaERkfGAUBnqI7N1lzNIg9VlmUoVM
	tic+kb+vFazow1+QJNHK8rxuFjPSBYiE3x+gpMAILB7DA3FBVPAFSrxSTtbg/3tbBp+0S/uBvNf
	T1oDpI8UDY9GyJWoXDWQPEN9Os36NtCI=
X-Gm-Gg: ASbGncuEX3ACGAVcbCg/v+6gAl4QjOefa7gzQi9acwJy9k+SL18qF8Ut4sjJwShXSGr
	UbgX1s/825YbvCjZ9v2qKS9wT8xmZ8OJsI0XSKUyBT9nlzSpKt5F3z0+MSnHrrtTMIGkJjK5iJt
	gRrotcux1AVO3M+A9Fl5rfdPwxJqK2ODRuII7M/HjjcLmHVlNf18xpoZwf/y3oB6CIKQStW7r2E
	587+gVABvmAJdJhJrTFYkN9ulOxH4riRugrV+qP/d6C9sEyyUD50dA8psRQ+slB7wA14y2GZpvd
	EqpKxCIed74U1WoQZanTUadmcQ==
X-Google-Smtp-Source: AGHT+IGO9s5xz1ht5uvXvIdjFVKc5trVhN4ayDX0mM2ztNeH5kLvtidm6RfnB74mU+zVg28z139biv4ayC8ZNwQ1x1s=
X-Received: by 2002:a17:903:708:b0:267:8b4f:df1f with SMTP id
 d9443c01a7336-2678b4fe1d2mr26976905ad.1.1758030495299; Tue, 16 Sep 2025
 06:48:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916130103.22946-1-jaimefine6@gmail.com> <2025091621-atrocious-unaired-0b9a@gregkh>
 <CAL-mriJVF_rWw1QW-KkS0R8-hLEXFwDd7xXm083wT+VoNhF8Zg@mail.gmail.com>
In-Reply-To: <CAL-mriJVF_rWw1QW-KkS0R8-hLEXFwDd7xXm083wT+VoNhF8Zg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 16 Sep 2025 15:48:00 +0200
X-Gm-Features: AS18NWBe7LtBtkJoCnNMfZmQJuBJbXiRfm9ZvZHAowjsGtImVWTTsqwroqRcHE0
Message-ID: <CANiq72krCuQS6V6sTacRnxGonRaixbWt6MZxFCkhAnumCtHR1w@mail.gmail.com>
Subject: Re: [PATCH v2] rust: auxiliary: fix "initialialized" typo
To: Jaime Fine <jaimefine6@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, ojeda@kernel.org, alex.gaynor@gmail.com, 
	david.m.ertman@intel.com, ira.weiny@intel.com, leon@kernel.org, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com, 
	tmgross@umich.edu, dakr@kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, onur-ozkan <work@onurozkan.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 3:26=E2=80=AFPM Jaime Fine <jaimefine6@gmail.com> w=
rote:
>
> Got it =E2=80=94 I realize now that my earlier attempts (including the on=
es that failed due to formatting) probably all showed up in your inbox, so =
it looked like many more versions than I intended.

Yeah, every message goes into a lot of people -- we have almost 600
people in the rust-for-linux mailing list :)

Cheers,
Miguel


Return-Path: <linux-kernel+bounces-875917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 675D0C1A1DA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEE401A67128
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5052F33A012;
	Wed, 29 Oct 2025 11:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZNhZavJ"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5833396EE
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761738678; cv=none; b=rqSP//cenAKP8IhjrhKMwog409w0SHpsyybnOxvHonumq0d73iunnVqAPhFlo40xEXoqdpzkdX0ec5Bia/VTKAGmouyeUiVFuKvqqWZbFH64i7OswmPFy6UF0tCSEuQWVic5V2YEe/5WfGhUTHuHTNpnYHsPBE5aDSewbO9k9Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761738678; c=relaxed/simple;
	bh=4eAuxRdra6xYn2AEu5URxIFLv0U3aPRV4JUn3Rr/2D0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jih1vmgMncmX2Jslr6sKVYirlGqIgofdrSMHYeX2u+NRKCGfDpsBCe2OAUWtJRnI452eRndxEDIvrZIjcc0ZDZ73OZqQtVsnzcTZLfow4lmUzfkANH7EbVjewsbmsUMCyScW0aEG77rhbRBXQkZp3k4rO6/W56okEwcdPh8nmrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZNhZavJ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-26808b24a00so9844585ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 04:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761738676; x=1762343476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4eAuxRdra6xYn2AEu5URxIFLv0U3aPRV4JUn3Rr/2D0=;
        b=YZNhZavJSqfaJP3lGCg5xmuwsDrK3PMeTIXFKOFMbd/zeYvMmNHdthI7to4fL7CFDG
         FkWYH7RX1+7ztmcKe/vd/Q8ZUI9xHAipPxMUZbYZxJ3V3KUfdrVb0/7MP2DX2EtHyL/R
         NkhxXDpvBBgnhmeozECfV5WdCtp9JEnXWnSWA4RWusRdxorBmVcWFvWjjjuf2C7Jm6AS
         Xf4VL0wnxlxu9KJtOeCdJ/prKJLXaS+uRTlu4qB2mwB6+aU/+NVGVpqxZ+tYJxLlumKZ
         9jzJtJAtpByn0VCBuBxYLEvk6gUNndUYst10HUhJVo3lF1Jjcyx9iL+2ntcg6kxl87sT
         +KIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761738676; x=1762343476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4eAuxRdra6xYn2AEu5URxIFLv0U3aPRV4JUn3Rr/2D0=;
        b=UJJBxHwl7ETly+PlDvxVpf1ZIL7h8+8ZIivuX5F3TnwVs3evbURCAshiAPFPON51/j
         f4ATm3WohO74AjSESvaBy/FueMhXqsBGA+LOcf/6b2+mBOUNHy8P1aG3b7/0hU61CW0r
         sl55pYqXW30qaGJOobT3RN4FpaOQP2ncAj0ifg/KqSG0Nntx2bEtmDSqbHRuj/LqHAlj
         zdC3liso1yaM1QqM2Cp9ULMfQhFFYRJWuAPdlt01sSYj9bBuI3zg6vuTGAiTbsb+InYv
         Oo8P3/cVC+Om5xE1fZi+MnnVQy/na7QMg5+0/TNmBHEELJK61dvdUFCgHg2LMc/BwgBJ
         7o3g==
X-Forwarded-Encrypted: i=1; AJvYcCXz5GDtg6y49jLM9nAwfbEU6udrPeNezA/+vnWTTB2F3GOd384Tzwddr0LgdQFTFvB/cIPq180yKKU+FsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZNT3xErsJoLCEzIwVghHYeQjl8cMm9YNt/rRsh6ypGzg6pYgb
	NuFuMBdOBiVhgq9VpZFsRf8KpCXLT9RyyaVU3szyO4st9YnU49DuOUhHGs8/NkcnsZoCeLpX0dM
	RjI9yalUNzPZmAaL4idEe7aMItTnHPdE=
X-Gm-Gg: ASbGncv3li3NTY7xoGvfzRJacPuMWBlIA2GfXek/5bNRbfQAZTIo67jBVgx2yiUJ9U2
	MZHHKEMChuAZhqpb+Z+POi6cdXUmIP+K84By/BYc7zdG6Dntf2R25tatdkDkZl8NLkI6emK9vOz
	79aJxzkwrm0yrB3lF5WA3vYmBESvLcpMxBT65RZtr63ijP0Djph85jFDYxQOO3cIYvbEusgveKa
	BiFm99URDL6dpnGA7ozRELTAWS/9VhjprFmC3kd3VnAHxnSo/7RiBNO94wmHioZBREbyn9zeVdO
	bPlt9qQbpDq3QDvjC8FCuw10MnFkolmU5TVVB6kZjmczg2ycULN5/UrWcl811UF7aRlLeMqoQqz
	l2p0=
X-Google-Smtp-Source: AGHT+IHydl5eW0/Dx2EkVGLSZgmAKiTuqfAbgJdkgdsRFye8YTtzwH3XYU7OFAr/IP3WtWR2QZHXmGbjwyn2fqhtndQ=
X-Received: by 2002:a17:902:d4c4:b0:290:bde0:bffa with SMTP id
 d9443c01a7336-294dedef47amr16261185ad.1.1761738676328; Wed, 29 Oct 2025
 04:51:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029071406.324511-1-ojeda@kernel.org> <DDURZLGB2VRJ.28Y4AP92FNFPS@kernel.org>
In-Reply-To: <DDURZLGB2VRJ.28Y4AP92FNFPS@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 29 Oct 2025 12:51:03 +0100
X-Gm-Features: AWmQ_bmrmooyzWnmY9GxFiFIfc56zKAyCS5p4B1qi25Pm2Uzdfv_Hs5RDQeg1vo
Message-ID: <CANiq72=HhDQP1ucccLzZj0mtb5Qa8u-1oorRwCqNv+aEJfZh7g@mail.gmail.com>
Subject: Re: [PATCH] rust: devres: fix private intra-doc link
To: Danilo Krummrich <dakr@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 12:39=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> Given that, do you want to take this one through your tree? If so, please=
 do,
> otherwise please let me know.
>
> Acked-by: Danilo Krummrich <dakr@kernel.org>

Yeah, I sent it independently in case I take it as a fix earlier;
otherwise, I will put it before the `syn` series that will go via
rust-next since it is not an urgent fix anyway.

Thanks for the quick Acked-by!

Cheers,
Miguel


Return-Path: <linux-kernel+bounces-746199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEF4B12421
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CD8D1CE6D2A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563952512FF;
	Fri, 25 Jul 2025 18:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLk2hFcp"
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FD324BCF5;
	Fri, 25 Jul 2025 18:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468690; cv=none; b=B79UBZEXXhwMOjnnq4ExnFo50EUIFb1dVG0SyQTVd/jTXtB/WEpYOZDQD6Zy5rIGVmr8Yy8QYa6US4gW/jWU8uWIWfKxVNqUTX73OCI8o3yG+9vxIb9MN7A5JqhBuI407Y4I0CXQ+Hw35kO6MPkEngJP8ejOojOC8nRSVxx2MpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468690; c=relaxed/simple;
	bh=gJ6ewcoQyVVGbVoSZRXYUYRi2X1SS8KIyXszP6Eldsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PYbu9jfMmIcwXaVU0Qx6mUwc3PAqjBO57UlYPNHPI2ZQrizjQd5qdJWuNaMy+Ghf/NBFwSXsAE08i4ZY8UeuOctcKYVe7nLRD3V2OIwHPn0/YlC+faBLtQJAhylI2+epRNehRf23AGp5I2ugH9ZnC/G9982Svvtn9ZeUskHpbxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZLk2hFcp; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-87ed1c2b487so63101241.3;
        Fri, 25 Jul 2025 11:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753468688; x=1754073488; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gJ6ewcoQyVVGbVoSZRXYUYRi2X1SS8KIyXszP6Eldsw=;
        b=ZLk2hFcpkKhLP8LLz0GwacAMZ4CIqpTlY8R8cuq52e1ZLXLMf7BcOEp2jIAXiuXFSP
         BXmkd2lx9ySm0AdKq1qOu2lFNHkIwPG4PTlsfiVYGEz3c7n9OeaYfmFa8kB6L1Hn4m8p
         jQ4ohgeAGLiz/Zn7AM41a3ax6S7BQoCMJIjlclT0dOWQh/Gr7DnmI1YheOFUDEUO6Mfl
         //zPAlSCtAmZ/QrYGk0FSsFw0cMhlmBhPNpn61fTru8jhK8/q/dHtaU4pxIr9T13PVAu
         gZgchS3+VjqmByxY7lZfX6YPDF/M8HpGAdTmWSq18cUUQhNGkfw+769taBgmxss+0dvC
         ynAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753468688; x=1754073488;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gJ6ewcoQyVVGbVoSZRXYUYRi2X1SS8KIyXszP6Eldsw=;
        b=lMfBFtsC1MZkQgR5AoIW21IZhE/JV9QObnKCMGjcuR5BFr3TUHeWjRHQ5MjJKMhBA3
         s8n1n/NzHID2RkFuy1WSekiAcD6giu/1xuNnQliBUHPawTJJMrRuLlEfCfKp2hdIRo1h
         7z4BTesqh0cMMV0Z/pQXLPfvjcFjZmp/AIRRsMOIpvE0Pxt1mUZgojGZm95qmBlO7Uvd
         YxCuasdy4ftsJrNEZOysFZVPyalgluPiNP7xUM/x8ZJriZ9bVi/8G/rl2nu6GIwsKGyW
         00+qSgc3+EpgVuNIV0HL2CnM0kwuSDLUJsN0gS8urjs4ENsLS4Z6dlqlo1EYwdkK4VdQ
         bXqw==
X-Forwarded-Encrypted: i=1; AJvYcCVUVfzVpBi+pHDfluAkElBYeGJ62jsJwP2wFSkqh4Q04KWMB79tJX3FEg2jLS3weyjYTa9yLjuLuQFOVYQ=@vger.kernel.org, AJvYcCXlRMNP20kDVfwBcQVz/a5gzoD3ZIM0WNS3VZLxd3ExHuaW+YSUxb3zjgZ3O/szXnleTn0BjhvYxdq48m05mis=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2+lsHGiQoCVE54jwSvXSvg1bsjtpyN9iSlwm1MQIYtKl668Fv
	ADN+m7HJZmwaFpyNXTSwL6J9QmtfhUWETw8HAoBMvaffRRiFiROnDZgs1U01dwYQUf07vfWkV3P
	pluHIu9yQ9L0oRJ3CHvp7xnAUgJzuiuk=
X-Gm-Gg: ASbGncuv2be0AwBHXyGhtVgfuFj6P0A1e930AJU/d0aRpp7EOEiqipAnV8U/d2Kf/KR
	xm0RW6fnmkaXT/jUhrpJzLawziheBUuiTXJUPOs+r6f8OtdaaH+P0ktwV7cBVtuYlnp8qdMIOOe
	51Z1PHCno74vWwy0NrC8pS0LYS92SiKMLLvx0IAFYsXbeaz3tPQi6B6HUauklyN85mVD7aqqWSV
	n8dne2z
X-Google-Smtp-Source: AGHT+IHOyHlRuQ3x55ePyfH2AA6lqIIvBIlu0lyTuTlDR7kqe3xOZQOI2yK5nmRKATmQr8yd8agn29yeBGIT58EvKw8=
X-Received: by 2002:a05:6102:4429:b0:4f3:22ba:ac97 with SMTP id
 ada2fe7eead31-4fa3fda054bmr525200137.5.1753468688039; Fri, 25 Jul 2025
 11:38:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624042802.105623-1-christiansantoslima21@gmail.com>
 <DB5KEWX9EJ2Q.3CX5EGS66OVHH@nvidia.com> <CABm2a9cfK+HuidwQwcD0Cs_n+dvd9Y71tFn=grz1ahGpbPpurA@mail.gmail.com>
 <DBIN4DXACVKW.2XJPQV4RNJD70@nvidia.com>
In-Reply-To: <DBIN4DXACVKW.2XJPQV4RNJD70@nvidia.com>
From: Christian <christiansantoslima21@gmail.com>
Date: Fri, 25 Jul 2025 15:37:56 -0300
X-Gm-Features: Ac12FXzugkAKot7ESTWJw_f_EiE5wEo42pvp2wD7tIjyb-cCsnpRq1STsEAwwrU
Message-ID: <CABm2a9dh9wGPdh+HofM5uZts_O7kFMyKwtGRdxbEw7wsxHvAUQ@mail.gmail.com>
Subject: Re: [PATCH v8] rust: transmute: Add methods for FromBytes trait
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi, Alexandre.

> To clarify, I am not complaining about the `Self: AsBytes` requirement,
> I am just pointing out that you will need to update the sample so it
> keeps building. :)

I see, I was just justifying the decision, sorry if it sounded a bit
aggressive. English isn't my primary language, and mistakes happen.
Now, about the patch. Should I submit a patch to fix the broken build?

> Sounds good to me as well!

Should I submit this patch to nova-next?

Thanks,
Christian


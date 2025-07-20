Return-Path: <linux-kernel+bounces-738424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8649AB0B822
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 22:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01CF97A3468
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 20:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D547F223DE7;
	Sun, 20 Jul 2025 20:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3qH+EWf"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8A77262D;
	Sun, 20 Jul 2025 20:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753042451; cv=none; b=SZ+1R6dTNHn2oLpLzShWG1ym6Hicvosdlc6/Kr9yexWfTf7nik+qWC5XOnwCpI+dAYOkUz9bORjfnjy9aoa6sEvq7LWGDhZWyS7SAEGYgbvSW7gMq0j7WoUAO+eHS/rrkvCbgc5GKthGv8wCrzqjuhXrsGPbHxnELbEovkguAOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753042451; c=relaxed/simple;
	bh=3XqnZ3lQ7EVpBDgAQl7576ulVBufGzapdE6biJkdf1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fSk1dr0GEez15ezTODAW+BL+q48hGyNycH9os7bI8yYBIvuJ33DPlJ5gYQ08FggcW00myTVf/KqT+2bs3hPqSWv4LOJ5nJYz1klgCNvPlBXnzqciQPtXzx4AFOaijwLsxtCstMVK12C1x4iBkN0OUovvb4/mViO8LKRh+1oAnYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3qH+EWf; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-31306794b30so746773a91.2;
        Sun, 20 Jul 2025 13:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753042448; x=1753647248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3XqnZ3lQ7EVpBDgAQl7576ulVBufGzapdE6biJkdf1c=;
        b=E3qH+EWfpYX0aFcxGab0mraj1wmnzzTPnW4TMhG3sxL+8be0PTVia/Lo2xNUr69EZa
         5OoulhZDktErEQHBzTNQL1S2bCxPyWnzWHeb6RmYURpP4TUcVbOXbDR7Ty7roKsD6eCK
         lE0PLy7qIe4ydTmXs8a3trZbcBGMlGrXGJHKNk8nbdPLU0V5NuNUzGmsNT8cUup+T5jq
         Ee3+krrqtUOeiNiWAN/f3noZKUnhXtSqrQg9m3D+fG9fXmqoN+0244A7q/4TVWTvsmQt
         SRHydLVa+edVfw9Lzt/goPzWAo4HbW1O1idVscoNUTOb6LUvm2mT24ozCe+nHOksOZsK
         VsVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753042448; x=1753647248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3XqnZ3lQ7EVpBDgAQl7576ulVBufGzapdE6biJkdf1c=;
        b=vNT4GxU33dUY6EW5a3AEFYzt2yJaXmU0BWEbwXclhWwKddizqeAIdyxmxq+HhRqdWx
         FLGAgbGc6JoAiezg+ijvAgAjkr0iZEZG4n1aT1ANdRqWYwTDsbB1goC2rfBzoBRTB57M
         aufTcTJDtFCrW6aN5Ubjr9y/ykXicFXKnHVsQTe7LaYwJeDkRC+b3EX3UzPCWWUS8NOI
         82W6ZAdpoMhSfjlqr7kmrI/2uMI5M9Byu8yA/L5FsTex77Si59Nm3q44eDrzxdq68LS7
         AQgmQM6t03sdw2UrBA+xbdzCrO3/otlKeNYhPjig9pLYJ4v+pa4sCKVBcRzRNQT/+bid
         fz/w==
X-Forwarded-Encrypted: i=1; AJvYcCURxTElSm2ot2UNyyVk4RPQemoTLsCCvUapkJ1v8jrn9qX3Lcuyp6jD2S+oSi9TMh1ATtCfIXQ7Px5gupkEuJQ=@vger.kernel.org, AJvYcCXkELBPP9jA+Fp2+YLIBv7FxGiVpn+fvHjaPwcdTCfoWthFxp/g/pq2Eb6E4uN2/GVpJARDPEP+WgaY+d8=@vger.kernel.org
X-Gm-Message-State: AOJu0YztqVJDu8i4eJavwT5y3CnaNzcbZGeyLDR6AbuKSuQI6VTHXjjy
	sDAD9NmQRizY4H7yja3Cwq7A58YuKi1MjYURHCgVZ/p9dMwvTCx2tkVJtcnDv8M36wHfb+FfyPY
	Cntkbg4JHLrcX5lqHjCKdJ5Nu/hFxXgSnGrPF+cs=
X-Gm-Gg: ASbGnctcY3Cc9jOM2k1iAGbJ/9bKIWymimFN2ah8l5OGh3WSRQ73ZyH/MM3zQ0lJCPc
	xGS2G55pniK/41kmxyuNRJQJdCXBk/2U765w3NYRbQZIncM1wZx4TC+kG4tQ+2I9rntPCIaFXzk
	vez9mFzRdJoKu9lxfekzYF1MOJFgI27iTI0IYEm31oefjrFIXmZ1RIGBjk3im6hYbHaWswdbmi5
	xkTqUnIO+rnfOoXObc=
X-Google-Smtp-Source: AGHT+IGGe7wNplwNP495bHYi0LizOC3vDHJ4gAQzN47ag/wp0xuN+oscFUl41uSFDjxAQY0aFBK4Zcz8LnBJ86GRkyw=
X-Received: by 2002:a17:90b:2fc7:b0:2ff:7970:d2b6 with SMTP id
 98e67ed59e1d1-31c9e77a4f1mr10752184a91.5.1753042448310; Sun, 20 Jul 2025
 13:14:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250719232500.822313-1-ojeda@kernel.org>
In-Reply-To: <20250719232500.822313-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 20 Jul 2025 22:13:56 +0200
X-Gm-Features: Ac12FXxb7ZG69y5dslaoRTvC7tHnGWA-2l9OwqxXbxYjAVnCX9uZ3NKFIYtXaO4
Message-ID: <CANiq72mk8Mp3M5hWSzgskxqWbQLBix_7_Hvqej5OA3RQnr5VbQ@mail.gmail.com>
Subject: Re: [PATCH] rust: list: remove nonexistent generic parameter in link
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 20, 2025 at 1:25=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> `ListLinks` does not take a `T` generic parameter, unlike
> `ListLinksSelfPtr`.
>
> Thus fix it, which makes it also consistent with the rest of the links
> in the file.
>
> Fixes: 40c53294596b ("rust: list: add macro for implementing ListItem")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-next` -- thanks!

Cheers,
Miguel


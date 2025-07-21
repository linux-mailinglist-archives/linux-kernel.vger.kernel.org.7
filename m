Return-Path: <linux-kernel+bounces-739943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B3CB0CD60
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 00:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C326317A234
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 22:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD4D244665;
	Mon, 21 Jul 2025 22:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGBlykTv"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7A523A9A0;
	Mon, 21 Jul 2025 22:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753138010; cv=none; b=aOUXLkwm5ebZejQ0SxzDsUbFx7KzM04MAhSOOXF1maxHid18Bs+XiObaGNNCi9/xsoUIhr8y7wOAYw/y3XQdNZffQdws00H1ELqWHoV0NUd0qfuG6AGkJzMJ62mZOf8nWge195mludx1KiNY3tmRezeL94aY3m7YtEgvtTlP5lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753138010; c=relaxed/simple;
	bh=VjIStfHcTJoQwyigfqhPLK8v7BhD1Qe5xMgPKsNCqOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cz+Cng0Pq8Tc+iAYrAHmN/Ozq4RX1xY177l099RfQpHzB9fMldaGYEo+zzxwALyWVXlCs7rLISNudNDmVkdtedXukx7tOXXVFRk1L6GELwPmFgix8eqxN6CuaAwVp3oPeDuC33RFn30P1sWkprzuOaZm1zb9T16kGU7rapMZWVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGBlykTv; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-31384c8ba66so77937a91.1;
        Mon, 21 Jul 2025 15:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753138008; x=1753742808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VjIStfHcTJoQwyigfqhPLK8v7BhD1Qe5xMgPKsNCqOI=;
        b=kGBlykTv+bjx7YMmcGIHfqBxJ69TVHCkYkhyc++MMNSe/TPEZpMyvlDz4W4JS+L9DE
         +tNaOnPnwpCZSI9enn+0q32qvOGQ5we+8H3FZTUasx29/m46Mey6AW5hRUUiKk1gXDRI
         SFQQYMhsskSaPsBza+wBNTxnLwCHerJD6yDi1MPN8EyTxQ9PF7YeSP/Go7PXZ4MIlzGx
         A4oWRFWWHZ7/Afl3nk+joWvviNlMUwLxVV+LuXllrwL375qVGkIWQMyL7WHOkU5Rf5Ss
         FXNZWS6+jdc/uOz4w+buGdzqAN3m+w3YaZCqyS00dtYJPS8JBF8APhoR29I3Xkb3RzXS
         Rr5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753138008; x=1753742808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VjIStfHcTJoQwyigfqhPLK8v7BhD1Qe5xMgPKsNCqOI=;
        b=TjC/8AU/kUE/u+JpRStqT8w+4QC6fX2Fckmy3jXuZ/gBgbL2haOxGQMy/dRW1Vn9Jv
         HC/ItRCOi+O7YoMeSvIcxBrXWmvuslWUyE5SxZdy8hpY/FhnPguNNqficmoXT1s+M2sP
         uenoqQnCGtyTxYHjbqrSjujJBEgniq8eTfCSC9APdGzjMwdCh78Kn6fNCLoheR0BYn06
         Q6ettaD01gkptJ4EpdldhBEA9bFA8ycpLMIHPKRxYqa+C3NCnQ5tffeGoG3D2BTXxLzH
         MByhn/f4Ek3MRXfUJuRKovIOjm6ldkHW/M6oNJvqscDYchfO+agJuzpFqar1vgVJpsuo
         QTgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXv/OvbGOoO6UyWZoHt9ouMsqsBdXjc/b7uobdexitJRzR1ocslh9TWVBV0K4ZVlfssMeCDSj/k4c+52y3Dg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxT3ft455KxV6itqEAPmEwBb3SKND+o1PWy60jN3QKJr64PIOuV
	MrqMJIN3aiRfDsvwZDZ7WWw2BzmVKD92taY3NCushi5Gp3lm/TxshwcpF2KqNIQTrttReDLtSFn
	M7BkXlL6GgceXCgiXWii9AeP7JTfWMVY=
X-Gm-Gg: ASbGncuaMr99eNRx58embk9/EQewyf7gn2mnnLv8Tc5rVcaDyJ36RhabZRbow9EaUM7
	+GkU4kP8akGDrUWMvoPiixIx9C0gLcYtRcXXL5xiCGwxPRFazLTKlDuLOBUepDnr9/EjVfS/6oM
	ZweUJ9BmeM1MO4x+e5OVBJosNaEvl+MKAkpOPUKOlPPArHYh1+PXi7kH+oso6qroPKEWjYK8Zd8
	3xMDO1o
X-Google-Smtp-Source: AGHT+IFPu2xXD78zUFrfF8Vq1CyEDGXWKgxLtDI1Cb+3ivIhnsIYoiVkj33G2ir4RSVT6F412kiv+nTBe8orUHAAr0w=
X-Received: by 2002:a17:90b:3f8d:b0:312:e76f:520f with SMTP id
 98e67ed59e1d1-31c9e79d7c3mr13807540a91.8.1753138008484; Mon, 21 Jul 2025
 15:46:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250715110423.334744-1-shankari.ak0208@gmail.com>
In-Reply-To: <20250715110423.334744-1-shankari.ak0208@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 22 Jul 2025 00:46:35 +0200
X-Gm-Features: Ac12FXy1pdI3x255Wisq175MjFbvSeBgg30EM9SOhhm-PpoKgTtg751vzeGvU3Q
Message-ID: <CANiq72nZMLghTj8bHerEfXyYMtbWDH_WVxYeQY65ymWjSuxA_g@mail.gmail.com>
Subject: Re: [PATCH v4] rust: move ARef and AlwaysRefCounted to sync::aref
To: Shankari Anand <shankari.ak0208@gmail.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 1:04=E2=80=AFPM Shankari Anand
<shankari.ak0208@gmail.com> wrote:
>
> +//! Built-in Reference Counting Support

What is it meant by "built-in" here? Could we just use "Reference
counting support."? Or do you have another suggestion, Benno?

(No need for a new version, I can modify it on apply)

Thanks!

Cheers,
Miguel


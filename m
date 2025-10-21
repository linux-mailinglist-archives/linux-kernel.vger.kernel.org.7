Return-Path: <linux-kernel+bounces-863324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A99CBF78FB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 278B93B073C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4231E3451D7;
	Tue, 21 Oct 2025 16:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lp100qYW"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076A22DECB0
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 16:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761062462; cv=none; b=ViG1lLsB5oO+NM/nf3IQbZB8z1b68A1K3y/tipQTyvr+RJB6MYYNnh2+fSnZQshpfBoUpHc2oEH85axHfUrX65vR0VnsUTS7evQGFiUM0pCBG0ElJiXUUprhNtlmcX+z1kHR6GNbfrTdEy2rf4cVeAbYk9PE8epD/ppoApnZxBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761062462; c=relaxed/simple;
	bh=l9McPck7+fRtP8oHsbqDK3T9B1jxgL5s0koTgcHDrMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NmVGZo/9QN8SZrNiUucoIoK3jT4r/HAaC07nbrWYeHtri0vZz4RYTmsDXo5OVkNWm1LkimdTUUFdfp1s/UDBWVhAuoEHhpjfQfxX0/XN8yFDah7sDkz9OOlAYHVCU7qtTK/ApyM8v8oWtSu15ZcO08VjXQjuCpYtYHK4PbDZjgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lp100qYW; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-77f68dfe7d9so417718b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761062460; x=1761667260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9McPck7+fRtP8oHsbqDK3T9B1jxgL5s0koTgcHDrMI=;
        b=lp100qYW8ZZePqlGpiIXCJNN9rKA6JH5MVggkns8qPNM2eGTlGDvmyfQhkd1AXvtxF
         N0LFYwGt2cDq/pz0sRyyWR4pQ6+JEdKTeviIKhTLuFEOmrzF5PHfHug+wdK3oRTv0Q5G
         i5dWey9LP8GwpRKM+j4lpL8CXjkurZ8mztK78evFPgZ9P/D2PHvoEKOCu3wVQYJ5LwdO
         JpfaFSC5fknkXAqlAfDixvnTC6ZWrYPh+jZelgQdkRJTvAZTa2JjZkczEUkM50xuPicQ
         LU1OpqvQxpqElFirhboA9p0WLwcRpcKoDHCCB8Ys2e2lYs5rFud+1SAUHCDflZlabjE5
         d+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761062460; x=1761667260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l9McPck7+fRtP8oHsbqDK3T9B1jxgL5s0koTgcHDrMI=;
        b=EKmQniZjCtTPg8CljFeCTwLyrdDmXTxuxTtoWRXbRM90ICQ0Mt7HxtQ0m1fTlNghhq
         W69e5Thqz6ocs5XF0H/fMb2gYrgk0eMDKy3BcgFsjrLaKFnPOQnam7G0GsA8QOtAqwAJ
         1Kv1f+VUGUb2gR+D8NUSMbQYQBlJySOp9ZWr28EwHX//aoutAuOXZiDHK4IlvghCJY8E
         0KHRA6HtbiZeK1gqRfyYLG3UnZTpyPBE+zlI06GWnQnYAP4Ovblgga4IQmc2s5LJ4WRB
         Mke45UcIPyPRuIMC3ZbOkJ9Ob5TJ06iw+QbDLeDFdOF/W9qa7qLNHtZf7XDICOKPTnei
         iN0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWKb5vpXqePXc9oOgx43LqCmAy4GUkn5+KzaOKTzhiccYABiQU53pYGVShXk8uxLWfHczdTYz7H+qpvO40=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF8eTFGcSlHKT60DDNGKme+uglD8nLPed0+wcoAOPi5tI2+8A8
	OZRZNYWDV9/AD0ZjeJGlv7t/sZb9ZufIM4ExY/Q6ehrAPi29nscl09OEEXLVyzny3qziAOgOjoO
	xYHVVHwELZU04LB6jy5dIuDG0Cp9KXVE=
X-Gm-Gg: ASbGncsZopk62tZ3OTUH6wZfSiAVtZ5mzpAlQyGS6aiTyOX55MqWpw9n/8H6KTD/pqJ
	EnzT7NbNqE2nEwPXX0/3tZ+YaJLK5QPnitSPDijJgNIUKSgp2p4OaEGC8+6upYqGNfz61dhRrqK
	8BzbEjBrJdX4kHw/vjVoz1cRbACRhZBJQq8t1mKhSabS4WSGzQ2oGfTLvtL3J3THkc0HysrfpPm
	VJGOGlKZoEdnUG1fP6HyCbEwcog3JxorsG66vNE9N0qPdyF6hwjXmx+VEGqF037aVlJ+KKSC0JA
	crJDAMq/dFI95jStXzR98mKs4d1i9vjoyH1CHYueDv9EWAkPRKr2fn2G9ohKcPXuo30LMX0Gyld
	tOenS4h4kQbouuQ==
X-Google-Smtp-Source: AGHT+IFQfi/s7O+AS7+ugi0AvG3Obf7x6s4gJSfq/z9A99N2GSsEFGD6AtODHA+FDvs4i/OimtZEcD5AA1Pf1qMAScw=
X-Received: by 2002:a17:902:ef08:b0:266:914a:2e7a with SMTP id
 d9443c01a7336-292d3fad068mr25694605ad.6.1761062460097; Tue, 21 Oct 2025
 09:01:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020222722.240473-1-dakr@kernel.org> <20251020222722.240473-2-dakr@kernel.org>
 <CANiq72m_LSbyTOg2b0mvDz4+uN+77gpL8T_yiOqi1vKm+G4FzA@mail.gmail.com> <DDO3T1NMVRJR.3OPF5GW5UQAGH@kernel.org>
In-Reply-To: <DDO3T1NMVRJR.3OPF5GW5UQAGH@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 21 Oct 2025 18:00:47 +0200
X-Gm-Features: AS18NWBiq5dOJe6Pnbt51CNfFzfArDoMX7kF8GitQ2ivyHNjHdvLaE-OZwfPRas
Message-ID: <CANiq72k-_=nhJAfzSV3rX7Tgz5KcmTdqwU9+j4M9V3rPYRmg+A@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] rust: fs: add file::Offset type alias
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	aliceryhl@google.com, tmgross@umich.edu, mmaurer@google.com, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 5:26=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> Yeah, I don't think there's any value making this a new type in this case=
. There
> are no type invariants, useful methods, etc.
>
> In fact, not even the type alias is strictly needed, as i64 would be suff=
icient
> as well.

Even if there are no type invariants nor methods, newtypes are still
useful to prevent bad operations/assignments/...

In general, it would be ideal to have more newtypes (and of course
avoid primitives for everything), but they come with source code
overhead, so I was wondering here, because it is usually one chance we
have to try to go with something stronger vs. the usual C way.

Cheers,
Miguel


Return-Path: <linux-kernel+bounces-727347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB50EB018CB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 11:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B658588220
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AAE27E060;
	Fri, 11 Jul 2025 09:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOqSru6f"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0107A207E1D;
	Fri, 11 Jul 2025 09:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752227637; cv=none; b=VLV1cLoIJuCJpH7QnfOIi+mqWgUQr4sKNT1TtKulAenAkY+A0PdF+kOIC1sRL0Ji7L53wsMv2Yz6+VhrM7FSc63JCvABC9faSeC/004OIYM0DKJ0/SXbwXVfh+HLsxTB3n8gXcclgV/VtQnd8cpbcAlB1JVLxnwlFeaiWPnwtxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752227637; c=relaxed/simple;
	bh=m8MYZ1wxGz3uPQ6cveXwC5uWnUUMhf+ew8hWrU5utDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OqeOiQQzoY+6xkOY9f778SWsIYFW/98lzDjyBnON5uQxm1Co17xd3FEDAgiexNr23yPEKobXQ5JvrXJbHzHLg7vhy3nhPZr+iopfBVupD20h2eWBZqFOMGyXN98Edusaf+mBteDcT+HLDi0E2WGd6sJ76h6U/JxyiK9WQJbj3MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BOqSru6f; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-31306794b30so318185a91.2;
        Fri, 11 Jul 2025 02:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752227635; x=1752832435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m8MYZ1wxGz3uPQ6cveXwC5uWnUUMhf+ew8hWrU5utDA=;
        b=BOqSru6fQ06ZIzBGsboJOrnW6bBDFlgdbM/Tsuxg/VGoOpVcaH1Eiky8QnsAUqTcdc
         N3WPzgwtVFbf1feWDm5WiciRFC2dKYyz327nCz/8D9ph0hHC1r0c7g/QbbBKB5uKRfZ6
         UkNBVtKMlalF1MhLbrjQolbcTkEd/0zIlgpTiCmTKqJnG5Ptz14d/trxYNHoS4AkqsUR
         TMLLpWL8uZgxqfFI7Tped/c8yHFD10Y/ItGgpbsWWXBnPjdxIhu/NA658mfVxBm/eRKJ
         eRbS8iBWixcD53CyWSBLS2HSwFjomxM2q5y5lPr/mWJHhwadhru4q8qW7VG3WvH1vl9K
         CH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752227635; x=1752832435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m8MYZ1wxGz3uPQ6cveXwC5uWnUUMhf+ew8hWrU5utDA=;
        b=mQw7BTz0s8D5ZIDZLvAiOw1fmmMnb3tibhlPBvjTMGvS4lgGJuGDtMA4BRvpDwWvnR
         OC/FuoszCQ5kMjiFjkikDQSjro7Ci3j7LxKH9vEZQY9IhQAO+lz/ii2eTKV8Ttz2qcfU
         khxWMHHZM9Btwd+3Bas24zwBlnBE9zem0Auy5dc+y+uAuiNDjCglA/XIXbUwQTW2Ihr1
         S6lkM9Z1Ay1E3k4jC+UvPptylbXcWibrcFIK1DI70q0QB8Q4W1pcaG43NKnZe25Ktqi0
         l5vIIN9QJIjl77+Uxd5EU2ap81x6FJR+HBfgQxHNed6HTEXM+yNcI/y0F9CT2D5qk9Pu
         nm+Q==
X-Forwarded-Encrypted: i=1; AJvYcCU1i58ZGk2rRIod8QIMb5R7iB6fO+qDvbZSr/VAsBha1O5wqsZ7N32YAxhrmgnIAvqULNLZ0bEZ+G/OQ3FAnaI=@vger.kernel.org, AJvYcCUvxgbwI0c9OkQaiOhJb4sYx1YWn9HZ6XdG9hlfhpKjLcCAChTUVzGUPFvXmOyizV2+jqz2TFVg+2GQMlc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7be3QJO2xZBDVCn/w3OEFbp8uu0nvVHHY6m54u0VksqNC+rrA
	P8rg2w81FSQ7334NgOQaobdgmqw85MjbvPWoWgqgmBaDkdThnAv4KdW+zKtEMRGi6fDOq73JEpM
	KKF+pWNlaNL9b5b25JgdQrEQaYuTEIyg=
X-Gm-Gg: ASbGncu4bnhajA2kb0YkQnxDAA6zHRvKBc+zO8LxJF+iamkYBtJ+bF/JIYsSegl8zLn
	jTgcEUv/7u7a53lGiTrpWaffl78cuiTVnw1EQZsKnMyn1KlgcHynO5eoBsqbNjvT8c6lATO/o+u
	JIMjGA0fRvcmCoO/h/ypJoz4mZKwhgKcK7FtQUtjBm83vWA1j6+N7Q5Gsr+T/AZ/OIYqRsz/hii
	ABDAah/
X-Google-Smtp-Source: AGHT+IHAs8gD7Hnw4b1Mb/GTjCgGqVuJnU9oiM7mUSzCTTWO/khmcmo5hLwVQpWXPnYqDvCfubKbf2gOfdrLrVp9JIQ=
X-Received: by 2002:a17:90b:554f:b0:310:8d79:dfe4 with SMTP id
 98e67ed59e1d1-31c4f511f5amr1059138a91.4.1752227635260; Fri, 11 Jul 2025
 02:53:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <U1GgPfpPwSjzh5jPpFlN22bT2BSjlaH8vLHYY6hAt_vJ5w4irwIYRPV46r73Cs5Dx73Ikz5ku7_qPWrl8Tntfw==@protonmail.internalid>
 <20250710225129.670051-1-lyude@redhat.com> <87jz4fi72a.fsf@kernel.org>
 <Jlcb2BYQGgrQ9n7-UEbh-tmbIbJdg2ju8RIXRLNH4cdkdqloip3e8e3jbQbdpNkFDxNZD_5Oqq_uNoNySv0hXg==@protonmail.internalid>
 <20250711.153729.1327324726276230605.fujita.tomonori@gmail.com> <87ecuni5nm.fsf@kernel.org>
In-Reply-To: <87ecuni5nm.fsf@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 11 Jul 2025 11:53:41 +0200
X-Gm-Features: Ac12FXzJuyEggL4BH04l_cy61e1G0kk5UqfFcZ0u9yRMdEwNOm5OagMjBYidm7A
Message-ID: <CANiq72kanRbho6m6ps7Q4qaLkBmxLYy-cHMADZmjx3YiGuHBNg@mail.gmail.com>
Subject: Re: [PATCH] rust: time: Pass correct timer mode ID to hrtimer_start_range_ns
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, lyude@redhat.com, 
	rust-for-linux@vger.kernel.org, boqun.feng@gmail.com, frederic@kernel.org, 
	tglx@linutronix.de, anna-maria@linutronix.de, jstultz@google.com, 
	sboyd@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, aliceryhl@google.com, 
	tmgross@umich.edu, dakr@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 8:49=E2=80=AFAM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> Maybe Miguel can put the correct hash when he applies the patch.

Sure:

Fixes: e0c0ab04f678 ("rust: time: Make HasHrTimer generic over HrTimerMode"=
)

Cheers,
Miguel


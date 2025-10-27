Return-Path: <linux-kernel+bounces-871923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF58C0ECFA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3EFF19C31CF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA863090CA;
	Mon, 27 Oct 2025 15:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wx+VCM2R"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE583019A3
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761577432; cv=none; b=EJukuLgM4DF5vLdUAMLFegUGmeo0Uh5U5PeC4Y4rf/zrs/pQT7RRe0FXJoL4cwxWqQIvazCkrz0EjrJOWScnwsGi+0wRVovNESAYs/W8OKZZdXof+tbXKzYwIlbZnHHo2m4dZ8/rQSoFFUTtqqWXgL0iehwwwlW4S3YqNdSjDCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761577432; c=relaxed/simple;
	bh=DApS4hcsGD3zyYGWIsdcOdWVaOZg+1nVqfikxiXnXSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uirCYDTxK8KpY9nxdsKXbl/1tYl1/cyZj10FuDm14dnaCG8jJDIEWI/NnzlPvabahetXfp1xHvC4VCHriw1S7IY5IWdjbvb1pYtmOpV1RSuJKJdMF0fOXhMRivbr/L3CSHFIzNy5i+tU4XeRFq+kwT3f70pVRm48qjtOcE32Jmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wx+VCM2R; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-27eca7297a7so5134125ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761577431; x=1762182231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DApS4hcsGD3zyYGWIsdcOdWVaOZg+1nVqfikxiXnXSk=;
        b=Wx+VCM2R0fsKVqU9b59kYe+stTvAcTu/QgA+Ri+sT7Gwfp8avWcfVp5u7UE3RFIolj
         KECsraq5ZrAsP7xv3453oaPG3CFfFP/AM7qEUvuFWqx5f3K2sd8+jfmwnHkSugkeNxKK
         5mw0HhlmmsgGhmaeyLA023YxVsqyBUCiaRy0QXPT752dj98VjOtkvwFwUTUcEY6JB/Mt
         7bHqaxEddQhWy2bgyaiWLR9YQx6Jst0Ff5HL1pyp6WnYH2shWE2WFb8xiqzhngjd1jSm
         jk55Z0CN9uQArwUieaJina6bcaR/w4WxesygZowXhPaCnV5w4DFeEU+YLdS2DQdf6Uw1
         xaew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761577431; x=1762182231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DApS4hcsGD3zyYGWIsdcOdWVaOZg+1nVqfikxiXnXSk=;
        b=MPHgrt5SWaXMrN/2NksU5t2kYZiAKl/vegNzN7cyv2EyocMHVv8LseY+1EKmidT2af
         ugKjlTV567ptJbbQPIgqGk34IChdLQpHfMiA4UNJPFbNc8DKrKRhwYKNJbQ6YZd3z2CE
         2csHWtH1/l4eRqYlCcZ2U8ez9jhsWnK9krkxyLFmAiiW+wQSzpAzwR9Dp16wXTgHRtWx
         flsPGl4wD9IK8SxBFLd3EEMgU0aS9FvhmQaaRDR2BFOIBv6YYMNrel2Jed/R2iQ4emYi
         FM5+lTp5JuwFd2VG7twPQrQg8Pz+5mCIDoC1nseFdND+nUZpwrmwQc+QTAbVrchiQsvG
         R/eQ==
X-Forwarded-Encrypted: i=1; AJvYcCW55heLEMSTiuy98epmFVvc8hdo8so83w+YuL4H6PQ8AQJ5f1V4zetuzuar4qJrdPq9O7j5x4FWRHqmJDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZOV5Ll/pvgXIRXXmqotNCEGQSOOsyBY7hpG8L0GUedEOZyKc0
	Em5QIIOVUMUJTxSfstKnbhM1U/VU/AsX9cw5DE0twdv5pkaxg+YwaF6auXHcWtMPi2ijj+blood
	GD2owl/UjeuH64CUpgh/Si4wewioHPQo=
X-Gm-Gg: ASbGncvKacTkPYdOmWpoFQbfrNyVjbJJErqz7CAb7OWdskeXijCUM8mmXS2QTMn2lhT
	SvaHYLLU9O5mUiNAEVy7HFN0yge+YsiRZcvuSs5XUe6gfrECIbFDJsSrPJ6RqdynFlyjcca1FCv
	SQQ5fh6mCJndoPrxl9UTskR5p38WiyKwpeNipjLNIsMTvIF/SI3pINDdXOxwjFskl681/zD0UC+
	TozJ+tRTj5JwZvarELGNhytx0DPuiRY4aBeN8DcpWAy208QFJcM/IsWvCaMtRz0VwnWj0Q3z4YS
	GU4DMpE4jDlEe0HWAWxFDPgxIU9aTY7hkXiYp3SIsQuc+E6SxrQnnxV9KKpWmfkslRFBGYQXGTU
	g8jk=
X-Google-Smtp-Source: AGHT+IHZ0l03J1yw11Ees0ZvURyj2fdVG9g7KrsSHbaLFL6bHoHKGgLcoCtIOomRh9t9yoDHMruQdA66vlTUVakQCeM=
X-Received: by 2002:a17:903:15c7:b0:272:2bf1:6a1f with SMTP id
 d9443c01a7336-294cb38dad8mr1426145ad.4.1761577430243; Mon, 27 Oct 2025
 08:03:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016231350.1418501-1-ojeda@kernel.org> <2025101758-mystified-prideful-8016@gregkh>
 <CANiq72nXw4+HesrgNqJjTy6Ji=pVqUMzx7GDO+6U9VYWezTt6Q@mail.gmail.com>
In-Reply-To: <CANiq72nXw4+HesrgNqJjTy6Ji=pVqUMzx7GDO+6U9VYWezTt6Q@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 27 Oct 2025 16:03:37 +0100
X-Gm-Features: AWmQ_bn7EsgCH1WfjYQWlmM5ETWJvrKP7qcsX_xSwmLv67g4Qr7Fxq14134xbNs
Message-ID: <CANiq72kn9HZy2kYaGHM9yj2nR+SAQ=J=Oh8k2doPFMDCRy1wBA@mail.gmail.com>
Subject: Re: [PATCH] rust: usb: fix formatting
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, linux-usb@vger.kernel.org, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 19, 2025 at 8:59=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> They landed in mainline, so Linus' tree is again `rustfmt`-clean.

Pinging about this one so that it is not forgotten. It is the only
missing thing so that linux-next is clean again like Linus'.

Thanks!

Cheers,
Miguel


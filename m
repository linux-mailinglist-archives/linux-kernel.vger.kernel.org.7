Return-Path: <linux-kernel+bounces-731383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB389B05387
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E564B3B6453
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 07:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B41027144C;
	Tue, 15 Jul 2025 07:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0lHkNhXN"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C56E26A0ED
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752565431; cv=none; b=Eg2p54Nk328JY0mxJIHDb6ruQyWSw85+HzlRqFebAckIahwNX/J/+9ouJQ07mPYk31i3Znubv1TE+yAvbRkBlpvGM0XNnC5YE4BqW724gnUYf3IuXLwc14iW2Xdws2B4dMV+B/BY8IG3jxZncA9WmiYrQtF5EzbjkKFd86txt3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752565431; c=relaxed/simple;
	bh=S6ZBbnBRdm61eYlM0P1O6TiMquJdOsVhEn0le3DpHeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bvb9JtJqg8YBLw3G/va8zeMYX62T0HaHpQPWic0CUzAHY/TbhnRVdqpulRwo8jQg24185RXp3Kzi6GkoQwIr3UO/vX1uSP6WMikPW7Mu405g8qFis6La9LWC37wF6PIYJI+C8GhPfB9QBFRRhc08Uje5T/w+5AuKGl8DxEv6/qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0lHkNhXN; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45629703011so1073295e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 00:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752565428; x=1753170228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uOEo0Mg2XI7OcoOFqG5XTj/kjS9gvP/PzpP2FvhjQ20=;
        b=0lHkNhXNaHoEFJNmP7V19ubrjB5uQzXC6dfboaYirhEF5FQFGGt4ucfiHF/v/QwzbU
         Tn6CM749w2KXChAB0pn3qjyshN652FEvEKV1CfyhUp8QjpJ24/AkmOPK4/bJl6Bopcto
         RfWjsAu95qr4jTlqBmrrDaMQ8ojhiLXgBEAfzV81B3bNVkCtj9h4uuhhpLDI7iZz89Wj
         l9Nr1H7POoQqUN2AvKbhIkZvq/+5rSfEKdViE+0Q3SdNynGs7baJYdrsofepELfHkwL7
         Xov/IqizLh4e+E49XWwOKsuDRoRkhB8oJWCbjyoT4RVor4XolxB2an3RUGTA7FrjDu4S
         EQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752565428; x=1753170228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uOEo0Mg2XI7OcoOFqG5XTj/kjS9gvP/PzpP2FvhjQ20=;
        b=MMA07fOw731yyTWc8F7kLyA8LnokY26N1Ra48KfXBJ9oG3u3X9+9W+IDAhRhqrWpyo
         v8KcWBxU1OQRsGpMb5CJeYeBYHOoyJ723Zmag7I2z36Wma44gscmkL11kTEjw+18AvMw
         VGl6sfGfS4Mk8LCPh1wfuv4XiY6VGoB7Xw4YyWDZjqZJg9GUpkS/fkUHB/YuymA3uRqa
         B1LjmHEmmKAYd19HSEKzqui1JiSWdjxe3Y5UnKEyXDwiK6H9WqJjsYWrjQNUk0Kg6kic
         0eL3+HZRILfAJa9E4gKQ8V2yJ3bju5v8feNtTginBzqoAldL4mEMYHhErH+koqJeyPN9
         Vnyg==
X-Forwarded-Encrypted: i=1; AJvYcCVwK6nXjknJWS0UiVbL1SQbvCEG1+oUsnNuxWJR7GHgOBczWieoaaPbL1hzqWWxSmMlr+2Ja5eD570nrq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXmFsVXj1jpB6SaJ8N9WLd9WM3QbYG45niix/qF4pDgyPBp8wG
	oG7vH73zALhiBHwUqLq5JuJPeV9KeSaIw4CS2AdtoSj0K+Wubs+4GhaTnJMgqKARzBndWnKVTvY
	lG7NNuIk/b36icD2DBbwJ1r4KD6sVgY7rapFlCdUI
X-Gm-Gg: ASbGnct+BQ0alaY5/3RNTeaAvnX58T6xHNVWcbLR2VDHStEC+MQrGJyoxtc507dS++o
	G/+ds2kqTDB2AOY5pEnoAfdA6VW61byzEjvOmAJ4wMbNgxTdne2sK5hFmzg2J9X0xJG4dymfzDu
	nDj4V+HDWCAWe1yfTL+MIKyASP/APSvKDfB1V/8YltGyL5woQ4QIiArBORXGmsu+rHXo6d2zx2z
	q1cwY00
X-Google-Smtp-Source: AGHT+IHKOjN/sac0fVVUzXU6SWIDaibaKPn5EMHPr4B2QK4ix+5qA6E1C5pV5zapc/cBUs3NTC3X0j1Puzdh+W5+uro=
X-Received: by 2002:a05:600c:821b:b0:43c:ec4c:25b4 with SMTP id
 5b1f17b1804b1-4555f89f507mr181921355e9.10.1752565427632; Tue, 15 Jul 2025
 00:43:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714124637.1905722-1-aliceryhl@google.com>
In-Reply-To: <20250714124637.1905722-1-aliceryhl@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 15 Jul 2025 09:43:35 +0200
X-Gm-Features: Ac12FXxKYM27WKloFSX7QfkGMGrcwA4IyJa2dCd9Yy0ZhdKGcFXHCyK325MyFag
Message-ID: <CAH5fLgh=kGj2shvChkPD4LHyHrmJ7ZCeWVpM-ZE3dG5NRMLWXA@mail.gmail.com>
Subject: Re: [PATCH 1/2] vfs: add Rust files to MAINTAINERS
To: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 2:46=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> These files are maintained by the VFS subsystem, thus add them to the
> relevant MAINTAINERS entry to ensure that the maintainers are ccd on
> relevant changes.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> +F:     rust/kernel/fs.rs
> +F:     rust/kernel/fs/
> +F:     rust/kernel/seq_file.rs

I guess we may also want to include rust/kernel/sync/poll.rs ?

Alice


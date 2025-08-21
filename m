Return-Path: <linux-kernel+bounces-779540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EADB2F55F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FB45584A05
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2E0305072;
	Thu, 21 Aug 2025 10:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NL5+Bhx3"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBE1305043;
	Thu, 21 Aug 2025 10:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755772293; cv=none; b=hO/jHeJljcf5RzVR6BmaFDLV2u6hToWA2YvLPXMy3rqS08G/Qgn532ej2qcz1LseYqCQVHYzlsVrsTJGuBJF9GKDUKBHcWRscS5is6eJgbgKwauX20JV7YtjLsp0gLs57RtJCxZUNakvchAxfCwLEujQR8JDX3l6sTwfRWLyJuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755772293; c=relaxed/simple;
	bh=913Rz1D2vRcGEtURPFrrhnXSizcosdo+3hWGTRcSM8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VRDwcPr0ICbDTCtiONyP4B4c0gzBogzAagES0Tp9yi76MwVoMLuirHPt2Ff4SbB9bOsdU1g2iDIvEgU0OA1KLOIIM7GgWgSa7Rwo4AEz5q08/h8YNQ1OUJnDdnLyOGq80Rx15qeIVSyBiNvriaoCHqDwDPTxFUwEnMHgmLFbegc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NL5+Bhx3; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24458051ac6so1191695ad.1;
        Thu, 21 Aug 2025 03:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755772290; x=1756377090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=913Rz1D2vRcGEtURPFrrhnXSizcosdo+3hWGTRcSM8I=;
        b=NL5+Bhx3zexbg7+Q2ldvSv/r1XUqgIduUY+jdDNiXpDD6O+HtssXNL8g08IAq64BaP
         tr5+2soTnln9MkYKrv4OYgS5wRK44hqkxp+QLr8TUJDh41IdB/Fl5AegtyoYuG3+/cOI
         CZiPd4TURy2q2Pz9SH8+d85smGTDMpw2hgDwcWL06gLc02d4/QKgXkbHwAGaZBHIE3OK
         n/qEq50oXuomC15q/wIBIOtHCvfYa1ZUCK8OjRfHlOd+k9GOGA2311qfJITF5UduCxuY
         HBLTqdWuMFEt3Ok8bDsTrlk+r5W079PXcWROqiSn33nld1paii5q+m4mWtLCghoaHGxh
         JMYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755772290; x=1756377090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=913Rz1D2vRcGEtURPFrrhnXSizcosdo+3hWGTRcSM8I=;
        b=esH2ltmBKXGRCiZi80zbhJNGTzz3SX7QtUGUzwqzL+4go/P3/BMua7qWS0arFwrYnc
         jNDy9IOEFYazPEegYaERe4qwIY3X34rcHYkN7gLh+DMeIEKqiQbMzQDYvqneyEcon21d
         zFAnK6rZZbeh1lPr1PoHo/BphGBfFzTh3Yscfay9fZrb3hJhDtb3ZPA2i1X1dnosFgso
         HttdyQL1pYGj6QS6aOjEa3VKct4qTM8rznslDoa1Wwe430nw8oJ9bkRBCMIakcGHChZj
         4RceBA7kl0sefgg0BhuZ2clB4lbglR9zIUyuivkDOplFtXg/1bc+TxzXfTH1klfbfMhS
         dbRg==
X-Forwarded-Encrypted: i=1; AJvYcCUICVVPZHGch5bZ17zvmlCHb8Rni8k97HksX20hINjXGctYE7L74np9q30xSAurMqNoJVS3Q9Rud4kcH0U=@vger.kernel.org, AJvYcCXHIOUB0TZVjAZUBemekbu4Yi7YMsFFjdY856Di4OmmUWRXeF+xFjF5W2fYwA4rmw5L9UtnkohejmHAFtVXYws=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCLmgaRsFNtF461C4+DR6Nh3ZZGs1udFEnqqN18kJ5EMNJwOLW
	3UFhK/1sTM/rmx40Z0ciGn3tDJFJAqtSkDV1jWyZ6dKUllj3QwbNmS5HHO4YsiQK9sN0NHZoLu8
	UXF5FWtg4g+84rA7cXX7Lo/rznrHaexnw8xRt
X-Gm-Gg: ASbGncv/za6X7h/xPKQ6hfWNIFFtA4yTQs54M2+Cq2lhJ8zVVrCfIJJzjpW2CVhlNEY
	2aq/gv5PdhpddYy0a5WwLtpJQbzYSz4WwyDYyOUFh94mwlSEkYygABvl9oe5+XohsQHR27RQHnM
	aiDkON3dCxl/bDfPWaTs5pF/uTTrfgNPVPWDQ9dOc8dba5pwbqi4ChZ+eaE9Kmd76R9kse9/yMm
	hgifBt14eRnMhd79dQ=
X-Google-Smtp-Source: AGHT+IEjm0pT1tYKH4wdQFS+4SLVyM2EzMLuRZ4+YtmFOUPkssVGEQdTiYEF5APh7HBsvfeJHB94RTHEn016hNWb+Uk=
X-Received: by 2002:a17:902:fc47:b0:23f:fd0e:e5c0 with SMTP id
 d9443c01a7336-245ff86b777mr14664805ad.9.1755772290139; Thu, 21 Aug 2025
 03:31:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812132712.61007-1-baptiste.lepers@gmail.com>
 <20250820162927.34201cfb395ec7319b15920a@linux-foundation.org> <CAH5fLghx7K1fsdx15VsaTT1i3DRQD8zH2Yd-sEwumiByefTVAQ@mail.gmail.com>
In-Reply-To: <CAH5fLghx7K1fsdx15VsaTT1i3DRQD8zH2Yd-sEwumiByefTVAQ@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 21 Aug 2025 12:31:18 +0200
X-Gm-Features: Ac12FXxLCRtkAiXZ0gKUbVmOrCcrysG0-2smcnGVwz7_v545hEOcpz9rG47jg8I
Message-ID: <CANiq72k1o7bi9tE0tQxaiu39_Drbvz3bPNXibeCightzEuDjWg@mail.gmail.com>
Subject: Re: [PATCH] rust: mm: Mark VmaNew as transparent
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Baptiste Lepers <baptiste.lepers@gmail.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jann Horn <jannh@google.com>, 
	linux-mm@kvack.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 11:45=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> seen many things get backported when they are incorrect even if it
> works in practice, so that is why I suggested to backport it anyway.

To clarify: "incorrect" here means in the stable kernel, i.e. not the
backported patch.

Andrew: in the past, I was quite conservative in what I would mark as
Cc: stable for Rust, but after discussing a few past cases with the
current stable kernel team and/or being requested to add the tag, I am
nowadays way more optimistic in tagging. Some backports would not pass
the stated rules in principle, but they still wanted them.

For instance, I tag even Clippy cleanups (so far, since it seems
doable to keep it clean with the amount of code we have).
Nevertheless, I still skip the tag when I really feel there is no
point, and let their scripts pick them up if they really, really want
them.

For this particular case, since we support several compiler versions
nowadays, I would have just tagged it if it had went through my
branch. There is also little risk whether it gets backported or not.

I hope that gives some context.

Cheers,
Miguel


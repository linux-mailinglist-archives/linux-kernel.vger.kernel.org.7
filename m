Return-Path: <linux-kernel+bounces-885387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 542D9C32C44
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 20:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DDD194E84F3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 19:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C392D3EE4;
	Tue,  4 Nov 2025 19:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPPbhn6F"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50432D2387
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 19:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762284235; cv=none; b=n+ciAkQkwLq326xx1PL2Umb9HqfdRTPoTs9plBULn9tVdGo6UOZBmFSGg/JMs7C0LL2kyqK017KyLJPrxZGDDFpE3FK1dqGCiFZSXPfu3KjLx1tE4S8lnDFKuDN3bKS1AODceVQRfCGNY7cG4GziIZFWc1V9ccR3nV/QG14hFeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762284235; c=relaxed/simple;
	bh=NqeaPpBSzYADuuHCmtIk20h3DrnAs8JxaBG6a4X0D3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iIGnkpgC5zsb1TtuPKeFAMwR8hhmQicBhgT+nGI3J4vJkLFy2Gy5lIsNdOn3h43DV2ULFHJ22soxJu0fFwUzHn/lOXzLHzr/XLxu1J28EI9oapms/n38Ln1jxvMBCXLJcbsK1xwPUuV2uoHZefWTJaGcx9dQUgN0hpnGlYnFh/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DPPbhn6F; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-26808b24a00so8930005ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 11:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762284233; x=1762889033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqeaPpBSzYADuuHCmtIk20h3DrnAs8JxaBG6a4X0D3A=;
        b=DPPbhn6Fl2RtdKfVw5zJrf2q04vo61SN5jHglAzRe+LogBirALLCM8H2Rb0W5Ox68l
         zq2GUEF3FcaxH5J4sy81zATrTGE2GR2eW8nnZ0lkPcvgBpf8nOeidd/06miY+kAMZB+P
         AnAsa8SFLH46FCq6g6FdK4RHyLcMOwKLX0YkziVxCO0HTqkurKqMyBvbFubBO4uhOREX
         tFIpHP3DNC1LpL6dBSFmUmJ/XhZqsu2PmS3M1jSrssMdpSeZRSQw2cGiM9vCC7J15PMV
         czsE+7pU+RnrXeWunughC82mL7PmT9vRvlU/znDZkb4hEPm+3BwOlDAbwJV81fZolI3W
         1M9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762284233; x=1762889033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NqeaPpBSzYADuuHCmtIk20h3DrnAs8JxaBG6a4X0D3A=;
        b=ra1qPsKKkK8Xa4fkGeNPbxV90jny68wUscDD4XiBPRqOn0CwECGllvF8eyVVDTlTTl
         dnvOxptDL2pLv8QTuetwZzDd6MpUlIYwTU119VHcbUxly5CDg/PNiXKIbXF5gpLMIIe9
         qgWwWYJdJLnz0MBr/YDP/24YX8MEPeszhOsZ3vDwbauhIEWMyCsS7HZ7fEtT3PhIzUei
         H86jS68CYIoNg0B0BiexVSGGoCTUBEhy/umI2b31jHpTSre6WTyZ85nBA3AIbGdMv7Be
         1y/fmPl/r1z/SwEYWHZuQRuIW267LAUF+zh8iBYw0rBkkUZZj50/kdffobaToDD+6RPE
         6cRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWuy8lowf3qhAtIA+2sCA6IWOejQykC4pXDmV/HumcY6A1v455RZ1VJn1siM7SPdaKiP4bahWK1EX0xnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbGd/oBLSF33M20KxRnImQLzs4mpPpzs6xZJpWrQ5hO6TLScLB
	lpAHiARydJ0DZ4FMfFZLkAI8qFub6a52A+kZ7vENS25FOAzrWfZM+qZOnGtQnnueFDGUL86BNrr
	a2KG/hlppcPv4RmvJFvFIbCK1mR/CUus=
X-Gm-Gg: ASbGncvD575mvKpSf+vdmGQZ6bY77zf0NoPy/a8npd9jzRMhahWrYSi5F2g2BGD0qs5
	HMkSk32hD2qp8vIYZu+ydU9YhIYmizgbki00p/B/9rXpgkzKcZd65o0bGAYGej8ZatEHjP0ChAk
	TElanI5Uk/NCwahkBv77y9Wweko22RJ7xSMvlPaj8kTnzaMeK3BTWc2hGxemMFTnt2EnUpsyMRg
	8MtAqtth7MQtvmpujGnGknbQ9noyDWVZEPu4AqRBY9n0mMxuqNbuUITKAOZvnj8RuaCMZFB00NW
	pBUYSZXfPGJO8kcvVdsxuNZfhNmFo6d5RZZH5ufhjdVLVWrUXrSV8rqYpr/GOkVnbbfr9kqGY9Y
	2IU8=
X-Google-Smtp-Source: AGHT+IHCk1/j2mBDXkX8+o2FTVWoribYQUy9xTzp1hxavAo8lRskxPigDirMoCigmuiFNy0hYHQN44kMGg808wTtLgk=
X-Received: by 2002:a17:903:2448:b0:277:c230:bfca with SMTP id
 d9443c01a7336-2962ad3d590mr4530815ad.4.1762284233160; Tue, 04 Nov 2025
 11:23:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251012224645.1148411-1-ojeda@kernel.org>
In-Reply-To: <20251012224645.1148411-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 4 Nov 2025 20:23:40 +0100
X-Gm-Features: AWmQ_bmVIeG-cW8V3oOiaFedybQztgT0tJXqDde7XoeN52zMMEb3dKuMzzPon1s
Message-ID: <CANiq72nHV+HoHFs_wS7B4D0s4vihPLoCKu7AaAAv2AhCN0d23g@mail.gmail.com>
Subject: Re: [PATCH] docs: rust: quick-start: add Debian 13 (Trixie)
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 12:46=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wr=
ote:
>
> Debian 13 (released 2025-08-09) packages Rust 1.85.0 [1], which is recent
> enough to build Linux.
>
> Thus document it.
>
> In fact, we are planning to propose that the minimum supported Rust
> version in Linux follows Debian Stable releases, with Debian 13 being
> the first one we upgrade to, i.e. Rust 1.85.
>
> Link: https://www.debian.org/News/2025/20250809 [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-next` -- thanks everyone!

Cheers,
Miguel


Return-Path: <linux-kernel+bounces-896182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4779AC4FD27
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 22:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 312164E7886
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 21:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF902C11C4;
	Tue, 11 Nov 2025 21:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5l3AdXQ"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C64335CBCF
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 21:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762895802; cv=none; b=deOg37uCjbG05SkmDk84NezkWnDTVzzufpXrc9tilknBovba00c4bHUnI7JZPj1XxwVrNjVCWsqDiIf95XcADtBP66vYtv3bjho0cuwACW1dfRyiHaV7jvOWlvcIMO97ovFEJ56LJ8ani9YTnnfjiCy5jPZ4ewmDMkOeA/dEiQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762895802; c=relaxed/simple;
	bh=uFpvkiN+G0wcQVjOlr6G4EunY533wLdSbYoyi98Hhu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pCcoiT8hPqzBePa9VRd5TmfYlGGqwjKcqc0GElGFTBOAjd7mItSHH6XWY3TCNt83rWa33DTEZKgTzYn6Zd0qyzHthZVOiQ15FRoRbhhC84bXCOcOxVikeJSCMEBar/ue2bTbGjn484Vhm1mCgEqwqwT3v6Fd+RKTBE1SoeJudRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5l3AdXQ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-297dfb8a52dso126695ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 13:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762895801; x=1763500601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPCqA1l0SfRDCEzSSk3NUmkIaPJfMJM7jIDnXpJC2Ug=;
        b=P5l3AdXQhzcj1QEYIOx6UTntFI0p7C3cTyW5em4LR/asPqcynk9y/E/WifHth6xtTZ
         fgiOOXjUXEylq5SI7h6vHQ1vzFepKON0hgvEio+0xbZCmEh17y54O1TjZuvyKB9bFyQl
         UFlBNfCP159nYbXCtrwjDY+0XzwX4FcFl8JC7RFhR9TkvqZ4UyTxrGmuoHdRYHP0o8rR
         I7pHd8ufdDImQ7PWMCpHSha2JPVoXF1EdH/xVb+S/fTdLdTb1dPppM07/WvtRNayvtPv
         oJRDqNdnS1oN6yOoESYY0frb74ubPZuTl+nA3gkIzfxO4riZ6IO8ZfhI3b2+Cml7wJPC
         LZow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762895801; x=1763500601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mPCqA1l0SfRDCEzSSk3NUmkIaPJfMJM7jIDnXpJC2Ug=;
        b=U/JH0+Fuue9/9c+Kp0Xx25UoQ41q+fhtCzuaFw6wkl98mRb/iccLzENk8QL92kHyjk
         LpKPQyjhd/lV54xg0ndH68jg/2JLpBtJckaiMZFHAJEIPAFO7YyH+t71FTSwayts30lV
         +xPMr198xYpP9CSS6aTHaRbs6LDT0oa6ETC0IE04rnhDMEk5v3LN0HyKe3sVrIOL48zN
         ZGqTAx01lgLLH+theYElGapVHSF0AIF3ESagRR30Vn+g+3f+fChlD0/zkM2G6eB7y8Ln
         txblgg80WzFw6+pc9h66lL0FW/56fx1FBJubbEMJlYk++ZCQX0U+v3UN35YOnTab6oo9
         qT+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWUmfm6dncChdDSFNhIzZWC5e/Tq576X1J/jUmKIu2Qak01vm1a2Ec0u1O/sw31BSjwfAKGG4/qPD1gBs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YysOL+5h7z0tHfyI84D2Fh+6C9yB7VTqfbk4PAOBuJMppq1TsEh
	oBf2lE7VKfcMO7j9c1ouQB1dmqZMNEH3VzvveaBLSOlAY54e1pGRxurSkP6DNNW7Cy2QDb3vPT8
	z6cccVU6JPBm8fi6MQZdAzZJQQIrZUWk=
X-Gm-Gg: ASbGncsR6zcYH+m4FqfcoHnCaPTyyp3Cb+2XXrRK99ma3Xan8hCQvCOy9DMEKUYRFYZ
	z15T0siPw96ViBVYBwt5op11NaQOa/bQnDO6OKu6fBwd1iaSMrI/CEBilM2iYe6po3jRdU4m49a
	DMBnJHJBrZnCzc/jVg2DMH7dZV3EbRBVmO0pF3G1PaDkC0lcbdgv7GL0jJTSEOb9gNvVEdwq4ZH
	t42l4H+aeLypMYbJVRCrNN8K13j7WM0CJEcS4jBxdidg8l4BNob1+cOBotclrkfNwGIPX0E1ilO
	07LWzAUCHeAXg4fJPjdilymICa/x/vXBRy2mCYzOW4dtfh8gxD/08TER2zeRm7JP/C/GOM2iBOM
	kASg=
X-Google-Smtp-Source: AGHT+IELxTIhnri+tM+aFMyGi4F2LNmIkSlKfOVg2wV28KftvFNGNsUXaSgAchbqExqA/Xn5/l63ZOKOPdX8SzP3nEo=
X-Received: by 2002:a17:902:f68e:b0:297:d77c:ef37 with SMTP id
 d9443c01a7336-2984ede4fc8mr4770075ad.9.1762895800585; Tue, 11 Nov 2025
 13:16:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aQjua6zkEHYNVN3X@x1> <aQltxZIVd6w5VNtI@google.com>
 <aQ0ERJiTpiA_rL5D@x1> <CANiq72ns1sRukpX-4L3FgqfJw4nXZ5AyqQKCEeQ=nhyERG7QGA@mail.gmail.com>
In-Reply-To: <CANiq72ns1sRukpX-4L3FgqfJw4nXZ5AyqQKCEeQ=nhyERG7QGA@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 11 Nov 2025 22:16:27 +0100
X-Gm-Features: AWmQ_bled1nlXpHtecW_FFs9JAWbht0TitHTuf5j8Tw1cdC9Fo7wx2-8srRyEN8
Message-ID: <CANiq72n88P_EYzS=c1Jfgv2zA-APJT4NrFE4GwEoQtbVS6bpPw@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf symbols: Handle '1' symbols in /proc/kallsyms
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Zheng Yejian <zhengyejian@huaweicloud.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Alice Ryhl <aliceryhl@google.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Benno Lossin <lossin@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>, 
	Trevor Gross <tmgross@umich.edu>, Adrian Hunter <adrian.hunter@intel.com>, 
	Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 2:35=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> We don't handle the big symbol double-byte... I will send a patch.

For (cross-)reference, I sent this patch a few days ago:

    https://lore.kernel.org/rust-for-linux/20251107050414.511648-1-ojeda@ke=
rnel.org/

And then Gary told me today (thanks!) there was a similar path a year ago:

    https://lore.kernel.org/lkml/20241011143853.3022643-1-zhengyejian@huawe=
icloud.com/

So I think we should take Zheng's (Cc'd).

Thanks!

Cheers,
Miguel


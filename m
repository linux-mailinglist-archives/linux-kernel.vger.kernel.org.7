Return-Path: <linux-kernel+bounces-826104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 794E5B8D8A5
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 11:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B49487B10A1
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 09:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E38024BBEE;
	Sun, 21 Sep 2025 09:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPLPoOTm"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6691E47CA
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 09:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758446888; cv=none; b=KRiRS/iycKVD2Hkjku07M2PA9SYTNqNDgJozPof55lzloR6pclGJAIcIoO7SgsBK6XQv2ISvc0Ah7jg74ZIHtwZsSu+vE6eAesnwAlTummGvV9+YhGd/weGhKklo3ZRYOw9zRv2ozAmmaYZq9HNqsqysDEoBEoupchcqLW1ykuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758446888; c=relaxed/simple;
	bh=EtvX6spi3ViWv5XUhchmyhouze8VNd54v4OZj5G0rRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sNKxLDUZVJH/cqk3UfHII65tGPrKmK5j2ChEpWuvnKzjZXQwrBT2Z27aO6kQ03vnSVuUKjx8wd+lMWxG5u4iLVFC6nOHBmr41MmqLBrMmRixEi1OAfxKWjNAehDW2YG7VF3Mx1iiB+l+XT8yzHb8pFFdkE9AX0MU0tAb3ZZpuno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nPLPoOTm; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-26808b24a00so6345225ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 02:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758446886; x=1759051686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EtvX6spi3ViWv5XUhchmyhouze8VNd54v4OZj5G0rRs=;
        b=nPLPoOTmadWh/fHHLty2OItn2e03cMVsTewWqKXJyUANpNnPc4neVSWe5vx2vX792J
         PGohrP/QrSCr9MtmOarDJS+llCNJAbWH/I+OWweg0HXUlj2vZoMAfRCQi70uqSB3MPTP
         gJcz6NY0zZChQqEj/2sDfMvtjX8G4eDSlZ8YY3UhqG6N4GTxPoIRVptEkVJcBiWYtzl3
         EauPMX0qobnJLy8+w7YKqmOp/kZSu1wimIxN1w6nr88L+m3t7TNMV6q7C63GQ/DL6WxW
         9dQLiXaO6ZtCMRy15hPOxClMK0JRer343qxn/dChMytd8PnMxEJIR5M1s4U9rTs76P8U
         zCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758446886; x=1759051686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EtvX6spi3ViWv5XUhchmyhouze8VNd54v4OZj5G0rRs=;
        b=Ejg+l8j/WJr9ZoSLI2ZwaMNP+LJ2M4rlEb8t5vksi8ljW7Fz3FOJhGahptZq2p96ai
         Ttff5dm3MoYAyNN+toRZkVOKtzXmvGiOUKnTi5GBUzIWKN2zFPWoUhdG1//wi5OPHdds
         k84xX6tmTlC+zmF1d0CDsMrFP74clDMaL0fOn7+S5CSje7cZUf6n5Xpqf+kNwIXdMRiO
         c539AomUV4+xtj6RFIE68DtaqSNPGONW66oYNiCOBR06snoJikcM8c7zEAQk48rgp94R
         quozTG59KjchZrY+Le0cYcY2QcR3WOsk+rUzbyRaQ0+zb+q/FQ6SAl5OHuEtS+To5R+/
         0Y2w==
X-Forwarded-Encrypted: i=1; AJvYcCUczxoREcxq+8aX1QTnwu3LsDKcNTzpSskX5PZnTeQlxmtxmwqmc530kLl+PfVXNGliPkwTO/qfnqthC+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlzYpE83gJyvbgx90tGYj6lsNiUhaG7dtbBJAnHKbGYtcfRhou
	Dr7CNA0T2ruvoiaptEkMzsWjdDVHmPx8d++d1NYbNxVyqihHxIHsa0XUMpNtjFnTgTnkjh0sPRJ
	tDr0JgyzEig/Xr6OYsgXTJrFCHHJnPcqMCsKUaPw=
X-Gm-Gg: ASbGncuX0GXqRURgnYScgkSsOCyMmd7xgEjDqjTu3OFVGGmIGzWyvzma3oYnYcjlFPd
	tF623oDj74cfonJaMz0hQwxP3cCWidO5jzqLmsVUy/uRnj41VI0m/PeHNeej/bMkwPjZQze4PIw
	d+7V8lWGHOfmqh0fVZ36+75Yr+T+zJNy4YXuLJQkIN8dVDbTs2cFMSU9UfbBtpJGLAqRS4ksl5r
	/QA95Szi4Au/EYZGWZ/6SEjUDJHx4KEv/SvJgXI8SCY+tHcWj1+QuCA9p/WIUzS6SLMtalH38qT
	TIa1wSfu4AJj9h0ugTUFPjCCTQ==
X-Google-Smtp-Source: AGHT+IF+Dy0mlMIwczvjkrGSGBlKSHADOTMAlhPepZLysPmcUI5cC7xm/X9KEYN0oiR+8lSYpv07g4tim48igZ6n/UI=
X-Received: by 2002:a17:903:60f:b0:269:af66:5e70 with SMTP id
 d9443c01a7336-269ba53ab71mr45154625ad.9.1758446886509; Sun, 21 Sep 2025
 02:28:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910140212.997771-1-ojeda@kernel.org>
In-Reply-To: <20250910140212.997771-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 21 Sep 2025 11:27:52 +0200
X-Gm-Features: AS18NWAoOU3I-I-O4oc7FCAYxbAppgw72ctHtbKu_NpY6kqn7EZ9tMfGQmUs_fs
Message-ID: <CANiq72kB5hCC9A9bXEx489E+SMMFcFMiJB68NHA7megz2aG5HA@mail.gmail.com>
Subject: Re: [PATCH] rust: maple_tree: fix intra-doc link
To: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Andrew Ballance <andrewjballance@gmail.com>, 
	maple-tree@lists.infradead.org, linux-mm@kvack.org, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 4:02=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Andrew: as usual, please feel free to rebase if that is what you
> normally do, of course. This was in next-20250910. Thanks!

(Somehow I didn't Cc akpm -- doing it now.)

Could this be picked up? It blocks generation of docs for linux-next. Thank=
s!

By the way, there was a rebase -- the tag should now be:

Fixes: 6a25c101c7a2 ("rust: maple_tree: add MapleTree")

Cheers,
Miguel


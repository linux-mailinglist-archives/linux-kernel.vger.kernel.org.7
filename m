Return-Path: <linux-kernel+bounces-789712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3E8B39987
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 273BA7BAD68
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5483A30ACE2;
	Thu, 28 Aug 2025 10:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNKDVS+n"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4212B309DC1;
	Thu, 28 Aug 2025 10:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376366; cv=none; b=TKZlBr4hjse2XiLoUta4Yfp8RXFTyWp5DkhykqQxsERXxXOO9NhWMHzVS3TAWmqIGGbcUUcnmSt0JTeuhmHtSECQ1HsDbmGO19aaUQyYPy7RF5iaEqX4oY3v0ux3tawBGk9zsdCbo65Vir0gLm1PjQXMWZaZtz0apC4IBAlPRDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376366; c=relaxed/simple;
	bh=uCQsYzGHM8gdZUV2vcR2ZjpT4tC/WRO5wHruBh+dFIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CXEtvBPbQ2XwdegD5AQMnDQ7f54d5WPpGD9rnVyulVwbtBshizpyh3dE5TjWK00W/NmEjphPD2FmzRbrGqWOBxhSUVRowEoXZXIeWj6kgboTzz+2Lg6+TpBFGkBo5D0YQutoWCuB6eu+REWl7NRTYa9KfUA1Yok2S5dtB2KDIRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNKDVS+n; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-24498e93b8fso1065215ad.3;
        Thu, 28 Aug 2025 03:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756376364; x=1756981164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uCQsYzGHM8gdZUV2vcR2ZjpT4tC/WRO5wHruBh+dFIA=;
        b=FNKDVS+nPMZHa/Oql5Wo/vGiSMb9wSz0DvTBTSs46QugJhf3KnTl4cXFT9W7ZtLt3M
         0riwxTq5OEIgPHf7QD5H2AZepRkAyBou+kQ/hb+LG1RxbNz6B36o7zlUdxPInGu3sfH9
         KoycYVaab60M5ZYQwcYHWtn2i7L4SE6xkAjzUchPGcXtYxOK6LPm9gm3fVYvLPUkxy81
         qLor3bUk4Arw4S25FbHaAzGgEIiGSErYK39fTCqgXJXBGJyP9nyIc8WCygXg6P79s2dU
         vo+CFJt8aPW+xA4R5gUQKn+SumHs/YsDYml+D52H/obhTaJMCVzPf/+7m5l2cKDR6NRi
         1mFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756376364; x=1756981164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uCQsYzGHM8gdZUV2vcR2ZjpT4tC/WRO5wHruBh+dFIA=;
        b=RjriO80Ic5RXRpz9+cflJJlt0/L+LeKn1Th7Lj7MAD/o4yAWUa5mgL+uyuCmmHmzg3
         1Kq6nBOaLk6PbmqJTYY2C+Hw/BNVk9r0jskw4Xep/a12FzJVOFhx/qHCahY+rq/bv68o
         /lbYoIXRG1na6BeE86D4y8NgHUV/2w2it64peB23a3aZgErO9EFa7kAAAJNLyQRqLOGm
         L6yn3MI0iZq1i2BLjxiPRUcVJ2KsSp0C205YyWTPFjev7XbgPlfTVT6KKRot8n5bOxBA
         OwDqZ1sshZSRGzSgdMLj466cRLbgtmFqjWSmDWqf66Lf8HZkWdIPRUsa+9vvH0esvjeW
         90ZA==
X-Forwarded-Encrypted: i=1; AJvYcCVQE3QhybFKRXD9rsmKaGPYm606uu9Vo6khS96L6DeVNOEQr5aw6IBrDbLpzPS4RY2VoLRHZO7kIB7Vjgk=@vger.kernel.org, AJvYcCW2u/gpxlAJHTEUyk3Z4MMxJjD/77gLBvL0mMcTfm7eYzE4BBr6I1fV9N1goZIsufAcMqeP+x+GbiQFD2VSX14=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHb9Ch6hqZ+d5emfOHT83hFsOBwp1GcX5jXGRYYtSAUO4SQuBe
	+GbLn45nrJi0gFUUv4fonMJdxc7+LSO8VsrKvVrxjfbSMvU8Kra1rZrxX3UrznKqUIWw1YD5OtS
	bWuEh4FVeq9jqqSMlYwDMEbHjXW3P058=
X-Gm-Gg: ASbGnctFAP2QoNfcl2MsC/x8DMZhgYwXgauquHMtUzqxlZ9JiXfU2oR2WIpo7nwovii
	3Blyir7metnC12BuoR8YeLhVnHVrAtJ9FwowJgzu/xguHp/koQMRJRnJOumVD0GZTWyHzVqkium
	T0wLEPZYHhIwHUcPbB9W/oeWGm0KR/HSzP3Li95c7q9rwvoGC5SRxoA56x03XFSBcCyYi+y4GWc
	9tpYGk0FxenLaoztv+pnYOYHP6IRbMtjJgh6PuIyiN13eyVPpec299Ssi+EQ5lr7lXWRDGNY4Ef
	1OY1BtFshUHJH39ESm1/TBwkUw==
X-Google-Smtp-Source: AGHT+IHStlNBUV5wN3/j5DMOSMvcwNA0pDIUVAyHi9rF6MBo+5uBvp71X1ELOl1V1keODdFaDMBr/v72/qVV8RfW4m4=
X-Received: by 2002:a17:902:db0b:b0:248:be7f:d3f8 with SMTP id
 d9443c01a7336-248be7fd4f2mr29581305ad.9.1756376364111; Thu, 28 Aug 2025
 03:19:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825132539.122412-1-dakr@kernel.org> <20250825132539.122412-6-dakr@kernel.org>
In-Reply-To: <20250825132539.122412-6-dakr@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 28 Aug 2025 12:19:10 +0200
X-Gm-Features: Ac12FXw8EPqq8u93pnznOiOBpC6DEMbBYvNWDBItfM_jVmf6g0VPq_ATHlPnoOI
Message-ID: <CANiq72knRW2VDdX68cCb5vBJpyVRtB62oB5e7YKZKPc_zHygQQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] MAINTAINERS: rust: dma: add scatterlist files
To: Danilo Krummrich <dakr@kernel.org>
Cc: akpm@linux-foundation.org, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com, 
	tmgross@umich.edu, abdiel.janulgue@gmail.com, acourbot@nvidia.com, 
	jgg@ziepe.ca, lyude@redhat.com, robin.murphy@arm.com, 
	daniel.almeida@collabora.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 3:26=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> Rename the "DMA MAPPING HELPERS DEVICE DRIVER API [RUST]" maintainers
> entry to "DMA MAPPING & SCATTERLIST API [RUST]" and add the
> corresponding scatterlist files.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel


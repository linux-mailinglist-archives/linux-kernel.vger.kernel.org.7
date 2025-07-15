Return-Path: <linux-kernel+bounces-732345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD32B06564
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 19:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80A4B3B8630
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 17:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDB32877CB;
	Tue, 15 Jul 2025 17:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UABQzqhO"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB4D4C83;
	Tue, 15 Jul 2025 17:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752601852; cv=none; b=KGEbLgU+o2wnnp334JuXjVJMPiKV9sJUCrrLNE/QgLT7clQ39sJdc5CgUCLjOAYbH4NpMl2MGB1SlHXCSy4VaFNc0u78hNvkeJG9X4xDLLAdAsVuU2dJd+Dr6bgSqoZG0JAwV2rk8o5BAjRtPTF6LsP3xANrf+N94GuE4D1XkME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752601852; c=relaxed/simple;
	bh=/tvLXhbUj3btoVOLnjJSvLA3iyBL9Ok27em6LBsQ+Xo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZRwdkKfq1A9R+yR8Ka+9D29P/haCCZ/bh4OJueUhyUxjCgC1FBAJvUx1S6ySnQDJq8ge4Y118ddEq70l8yIjriB3imlNATqOS9k7HJZXH/UgXuQyv3ajMpEr/57wisnYE3Cem/Hj0H4CDyiqmoO74tRXTNndNOAhtX+as9q7SAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UABQzqhO; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3138e64fc73so1387040a91.2;
        Tue, 15 Jul 2025 10:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752601850; x=1753206650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/tvLXhbUj3btoVOLnjJSvLA3iyBL9Ok27em6LBsQ+Xo=;
        b=UABQzqhOZyhR/l2myQcGfdkKfKPV3Gg2Rr4ho+9xRtagI25RN/WTGj0hEkZYofGvfD
         2vURmCnS9IjIH9UvLBi3KgjDiMuOEMOETLrGHkLR6UR+5pfVv2LaEhrckn8HVAZuQ4U0
         JX18KTN/4Ivr9DNgZug9txTWa5iAIsfkwCTLP12DnekYFQxzBbdm9uMOWbYS7MXrLCor
         fZCtkAetylZ3ZD78VQzMlZNylyExeh3kzzA2ALXsHWfrOgViCoVmKxvIGRiImM67Ym/I
         S5UIadhqjX835ooGibKd3wgyjd7z76tYSFYGeHZfWT3c/SAxRTIMbLud+d2+8jigPl7s
         FtZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752601850; x=1753206650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/tvLXhbUj3btoVOLnjJSvLA3iyBL9Ok27em6LBsQ+Xo=;
        b=euPFT5c/bujIAwMfjs2G6TOYR7qqjSn6FPnDbNAJClv4yjiIWkGwG0fd7yQ5GtKSOy
         W6iMSKT41kyLtcTF8nvkwx5FJFfqTsTWbxhhJozVtIKZUhLSFzfKZrR4lYBaKHoH5OJt
         hXEcl9PveWbzgq1sBSt7EBeRVYeXC8LzTdixBO8PDrdzriVl77aIVBQECZh3N2VNS2iM
         s/vol5Osy99cbv58IaCgFWoht9PBOPGWayhtgVqrqk+vd1XDTDoz8UXhGWD4Y8B9U2O8
         B4vxDoLq9udB5aTtUCgh42bQIJ3loqtsoEIQ386tWs6rmU8RmwDhIVv/emjYg5H4FUBE
         AiRw==
X-Forwarded-Encrypted: i=1; AJvYcCULeAnWu0uJWwtynHT3sy9/mv39t5L78M8Fv6izBOuEuCbjds72t2pYSbHVFKv2iUporYGgZ8SykumRaj99qWo=@vger.kernel.org, AJvYcCVR0HnCVzIpHhJqmjc5tdABGdEUlLbSmRCCN3qOIxIItvBuScvXbTNufROgB+QluXYkuuLo+bpUECeyaVI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/YzwAW2s9sUn4T2mZXgCL7To2ClULN14HneZwE5CiSrchsntY
	eqUI2/phOOwGnnkPi8XTIbC4VjUs75tvQJD1aNsK+PPQW+0Km8yZh+3WgAuiFEVmRt3FXBXCwFb
	uu+0LAjkJ24m51AdvM8T1PrFY4Lc8zrBOmm27WR8=
X-Gm-Gg: ASbGncsSpXR76nBjlnVZ431f/Zyi/A5I5DZLWZSltj0UXjRr0lPRhy520DtYO0CzlSL
	Kd2JvmgOsJqsmvMlSmiP+CCZcerI+8ifcALd7BNQn2XQTFoN0ITDmgTPTCyyORXDyu4/neo3N68
	Y+qxT7z4st+dEbUdC+V1IvFbxQIjPh6czoO0X7aA7JaHsJ6vg8eYShqkMuVwldTcp4QDfyxchZu
	ibNFm4x
X-Google-Smtp-Source: AGHT+IEA0bFBiiHMjFaFp3NgiucMCohNFKETTnLQbvfhvE3iygihLpBxFCLZbywabbuZf9zk5tx6uQatd06iDKa4cK8=
X-Received: by 2002:a17:90b:518d:b0:312:ec:411a with SMTP id
 98e67ed59e1d1-31c9e76ae7amr42706a91.3.1752601850205; Tue, 15 Jul 2025
 10:50:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4c459085b9ae42bdbf99b6014952b965@BJMBX01.spreadtrum.com>
 <202507150830.56F8U908028199@SHSPAM01.spreadtrum.com> <c34f4f606eb04c38b64e8f3a658cd051@BJMBX01.spreadtrum.com>
In-Reply-To: <c34f4f606eb04c38b64e8f3a658cd051@BJMBX01.spreadtrum.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 15 Jul 2025 19:50:36 +0200
X-Gm-Features: Ac12FXyoQ4fNoRKEvC6GhXGS-MiKTOay0FzcQVu316wRZ_qnU2L3B1IndxZsU0Q
Message-ID: <CANiq72=v6jkOasLiem7RXe-WUSg9PkNqrZneeMOTi1pzwXuHYg@mail.gmail.com>
Subject: Re: Meet compiled kernel binaray abnormal issue while enabling
 generic kasan in kernel 6.12 with some default KBUILD_RUSTFLAGS on
To: =?UTF-8?B?5YiY5rW354eVIChIYWl5YW4gTGl1KQ==?= <haiyan.liu@unisoc.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, =?UTF-8?B?5ZGo5bmzIChQaW5nIFpob3UvOTAzMik=?= <Ping.Zhou1@unisoc.com>, 
	=?UTF-8?B?5Luj5a2Q5Li6IChaaXdlaSBEYWkp?= <Ziwei.Dai@unisoc.com>, 
	=?UTF-8?B?5p2o5Li95aicIChMaW5hIFlhbmcp?= <lina.yang@unisoc.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, 
	=?UTF-8?B?546L5Y+MIChTaHVhbmcgV2FuZyk=?= <shuang.wang@unisoc.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	"kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <christian@brauner.io>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Jamie Cunliffe <Jamie.Cunliffe@arm.com>, Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 11:41=E2=80=AFAM =E5=88=98=E6=B5=B7=E7=87=95 (Haiya=
n Liu) <haiyan.liu@unisoc.com> wrote:
>
> The commit changes the fragment and diff is:

An Android engineer should know how to handle that, but if you are
reporting upstream, it is best to try to reproduce the issue with the
upstream kernels (e.g. arm64 is not in 6.6.y) and provide the full
kernel config used.

> Only two rust-related global variables in fmr.rs and layout.rs have this =
issue. Their asan.module_ctor complied binaries are wrong.

I am not sure what you mean by `fmr.rs`. As for `layout.rs`, that is
in the `kernel` crate in 6.12.y -- isn't there a single
`asan.module_ctor` per TU? Which object file are you referring to? I
get the pair for my `rust/kernel.o`.

Cheers,
Miguel


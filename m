Return-Path: <linux-kernel+bounces-734818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7843B086A4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 09:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 648D17A45FA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 07:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95952367A9;
	Thu, 17 Jul 2025 07:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bc6J9JCt"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A5E2264BE;
	Thu, 17 Jul 2025 07:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752737393; cv=none; b=rijhzFtGQdPqDBS0LY0lHlfV7wXp01GKn+VAOAJFtwT0M3eBLv9ipHM244v0Wm9R1UwKkCNGZmIjYSvLictw88dBg+O8D7G1OwVyVqkw0+eWuxhozxUZoEFnoKbwJnVPECRBz3ydEboHRT6DIpKMF6YGG7ZZ5G8ZgPJHP39Rlgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752737393; c=relaxed/simple;
	bh=DDF4dAgrnw34VJPjjy2t0SDWi0MqtesXMSOxY10q/fY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TvZ/fi+4VNBF/hmDOkFOWxgRfSTR7O/meideHJOrpQzHdMt83vqmya2DvuYMCSyWrUmifsgCNORBHm8tmqMhs+hHD56axmYJ8lyYfYSCkaOSSV0qPkcQ4Ici6fSYjbuWeO5t+26DuvC34SZ/B6mZxRVJOfr/wtg77XNvZfsBtbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bc6J9JCt; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3138e64fc73so194243a91.2;
        Thu, 17 Jul 2025 00:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752737390; x=1753342190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDF4dAgrnw34VJPjjy2t0SDWi0MqtesXMSOxY10q/fY=;
        b=Bc6J9JCtqilPnv3BcMwCpp0J7OCddkUIt5i58BbnJ57dyn5su2COct5Gv1s3HKSoHk
         RvUgcUce0enBIDRo1GJwr+gUaFfLfXg3pFo+3VeNQs+ION+Ia2JInRu0RMhbyQvtyZAj
         823CbUlCoAuBwzqKcaMmBO9M/pMxuIzjIL0qQY/+womt/0YGXVEvsAlGjmUh0gJMTmXj
         WDHKqSKWTcom4IS2zH36uqjBOqHzC2mngtOsepw+WWci76or28O0vaJrRNn43lB6S9tV
         K1N2MS92WtgBZWRuAW/9OktqTiwCm/rmJzAm76nmeJY5AtN39PzUdMa4Zogy1GBT4WAC
         Ph9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752737390; x=1753342190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DDF4dAgrnw34VJPjjy2t0SDWi0MqtesXMSOxY10q/fY=;
        b=azr8SczZUK6b1UgUZIoJImZFAJcNNWPNxMiHDNuwqbuVlKRNqs9P2jfcth7YUYlUir
         qfJWjif/U1y9FU1QrphndMZfH3T4wSQwXetPtXcStS8Ex84nMSy2CUWWipq6mq+9oyHO
         m7xpqt/94s5Hib0+1OY0KlTzxT0CEtm9SP0zJ9jUaBZnVXYcYlsXiw/JFgWf2n+Ivkrm
         leJm01Fjd/LDJgdwP0vmI366+CfbQOvIhKvQYYtE3x+CuReNd46fSTt8RTcdN0WSL/Kn
         ZXyBj2vN+/rftdvUG19aD8guMIfMkHBbiob0tHi5y9qH63aIdEaMYTkV0UTr5iq2pXmX
         MlQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqOiAY4Pw90mXHzFfxrevy0gT5cnje9hJzKPnMA6oqu3w6KyBedU32gUj19yxLDhSFiF7dsGYR1l/lTaTJBa4=@vger.kernel.org, AJvYcCXx6h6ocV4Pu9lomxoIuHUE3JXpZMa/e62UN7QXIc73TegudQDTHq3FVmMJli5buLfL3f8Ohtaum3+IPDI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1wy/KLiheRQHJo/k4nsLYUpRcZN8tfPByiSblQdfx9Rl9yF77
	LiuAxuVTsM2VOE6Se0ggwXuVA/AiIKI5VAOMeOJ2YG5yGAkxH1IQ2M88J4+Unv/jq2SPuL4Lx5k
	4J6VIT5X5oUUq8fp7MzkuBUWIzJzP45s=
X-Gm-Gg: ASbGnctSZc7dLlW+bKSq4ESjgm9Ey9ZEE6tqNLDOFoNx5J4acn3LugZWRw/4LwEBslj
	hySWL/AZ8jF0jnTUwuObY/t0T5VtSVRYLQ716/dcCGWV+mpSP92kEWNFpYXlt4BJECawmwfEixE
	J/PzzuID4GrCSub4ozjo+e8gRNqS65DylMV7jo5PQEHh3vkSGT5TFQUmVzHryngC5/fF1Cd6/KA
	4MUa5fV
X-Google-Smtp-Source: AGHT+IGpKE7Xwql6x+dfghjVcPLc+7GCO0f3s03I9+vINqgrnqS87x+wD8n71frCSyCK+IPmdf7M8h+CCtrDqBIT4wg=
X-Received: by 2002:a17:90b:1348:b0:313:f9fc:7214 with SMTP id
 98e67ed59e1d1-31c9e6ec8c7mr3596901a91.1.1752737390348; Thu, 17 Jul 2025
 00:29:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4c459085b9ae42bdbf99b6014952b965@BJMBX01.spreadtrum.com>
 <202507150830.56F8U908028199@SHSPAM01.spreadtrum.com> <c34f4f606eb04c38b64e8f3a658cd051@BJMBX01.spreadtrum.com>
 <CANiq72=v6jkOasLiem7RXe-WUSg9PkNqrZneeMOTi1pzwXuHYg@mail.gmail.com>
 <24e87f60203c443abe7549ce5c0e9e75@BJMBX01.spreadtrum.com> <aHftocnJcLg64c29@google.com>
 <7afa22cbbb85481cbb3fabb09a58bd63@BJMBX01.spreadtrum.com>
In-Reply-To: <7afa22cbbb85481cbb3fabb09a58bd63@BJMBX01.spreadtrum.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 17 Jul 2025 09:29:35 +0200
X-Gm-Features: Ac12FXybXl51xhyGUacxmi5kHiXFRNN_uQ8UNQosRGKU2Urpiu5evh4hcAyLZNM
Message-ID: <CANiq72n3L6JE-pfR=8x0GUU++=8nPLw44oNEV1shdsHqXbts8w@mail.gmail.com>
Subject: Re: Meet compiled kernel binaray abnormal issue while enabling
 generic kasan in kernel 6.12 with some default KBUILD_RUSTFLAGS on
To: =?UTF-8?B?5YiY5rW354eVIChIYWl5YW4gTGl1KQ==?= <haiyan.liu@unisoc.com>
Cc: Carlos Llamas <cmllamas@google.com>, Alice Ryhl <aliceryhl@google.com>, 
	Matthew Maurer <mmaurer@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	=?UTF-8?B?5ZGo5bmzIChQaW5nIFpob3UvOTAzMik=?= <Ping.Zhou1@unisoc.com>, 
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
	Suren Baghdasaryan <surenb@google.com>, Jamie Cunliffe <Jamie.Cunliffe@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 3:35=E2=80=AFAM =E5=88=98=E6=B5=B7=E7=87=95 (Haiyan=
 Liu) <haiyan.liu@unisoc.com> wrote:
>
> The config file is included in the compressed file kernel_artifacts.tgz w=
hich can get from ' http://artifactory.unisoc.com/ui/native/VERIFY_ANDROID/=
1746740/PAC/sprdroid15_sys_dev_plus_sprdroid15_vnd_dev_plus_sprdlinux6.12_k=
ernel_dev/ums9632_1h10_64only_k612-userdebug-gms/sprdlinux6.12_kernel_dev/u=
ms9632_1h10_64only_k612-userdebug/' . The path is 'kernel_artifacts/ums9632=
_arm64_kernel6.12-userdebug/kernel'.
>
> Can you get it?

If you mean to report upstream, then please post the config as a
simple text attachment here and clarify how to reproduce the issue
with an upstream kernel, as I and others have mentioned since the
first reply.

Cheers,
Miguel


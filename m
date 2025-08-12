Return-Path: <linux-kernel+bounces-765380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AEEB23110
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 19:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF280580155
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 17:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AFA2FDC52;
	Tue, 12 Aug 2025 17:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YX7s3/qi"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B8B2DE1E2;
	Tue, 12 Aug 2025 17:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021533; cv=none; b=I9T9tB8kKw2xRl8CGylO1kyScMpcWtIrITT6BiRuiuousAJM8M+qvhBWRtFny1Tv9i/ZHSGSMQLiK+LkZCWVe0NPDFJXU3nUIs6dUpoWS3ckalCq3okW3m3FzgLLruGvp6PuAO9y/h1DXw1vpjSUaGjfgnsVr3KPwNiiDpoScIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021533; c=relaxed/simple;
	bh=qFgqOdxV1F9ejz004iGryJ3qWW5B6GXnUjljpVgqkLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tEb4Rr6JMYfor0SpNO7vpLtq+zu+SXkdxqWJt0a6NjWJ3L6tcwlaLi6e2uec0ch3T69Nct9hNI5BRszyhsRxkIA2qGJKFl6uE+bYKfJnHulXKjdi0SlqvTzx0jsafQFi7Huh4f1mydqGcoEGW4asL9l5BF726f1fdfljHaU4U+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YX7s3/qi; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-458bf6d69e4so52486925e9.2;
        Tue, 12 Aug 2025 10:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755021530; x=1755626330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFgqOdxV1F9ejz004iGryJ3qWW5B6GXnUjljpVgqkLk=;
        b=YX7s3/qimEBabN9V0dpnydl2pOzbfI5LAtGY9VJbuQWsYoZ/lAftlR35jrCbj9NOSj
         9aU4VP5tdZNdf908CDdYYFqwh7HrSASmw0m66wPAfGt5WJ7XxM07/lCeOAAReCEmfoSG
         GYRxncoE49lcxtaAlQi92mbEG6dWFyu5ZyRiXS62bYPt2WhZPdJjBsytF2wiOz2gXgMt
         X8/fDmQ9oq43TzrqDUW0aE8XoDaykujf7Z0tIbeVwaAC0ViUJrUWSzBPU/tR7Qf8Dchn
         eGqLWaGSpv3PzHyymRpHmD18YrIc0WN9aOiNhELruG272tY2UT6r1q8B0j+Chb5KVyhh
         DsCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755021530; x=1755626330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qFgqOdxV1F9ejz004iGryJ3qWW5B6GXnUjljpVgqkLk=;
        b=UtrUV4h/Uf2QcKkOv0pGCz7OPVQSk713eMOuX4EJwdhtktHqEPAOJZNdTw/sTxTa8D
         gsUshsZsFjLKaS0iXFlTPo4e/O5LTg6au/kQ9FjBsNKN4ngr1aSe2LBn00Z7zJ4r/6yo
         iXjmqUKej58/+S4Irbs4FQQn1sFBUAloaxXGMZuxDAleQXMrLPzspmzsWnd/DoAYy0xa
         08wGv2Rk73mgrnftarKNYBxw0WdDGc5BTst4WSR30dZiaVpHBas93Nurvao66t+27rk9
         CrEtTH3qSvYsjsUjSXFFCGIz9p3NHj5Rj/rfDVEP5fVG8PDVquDYvRalUyCyiGcVu7FK
         mnFw==
X-Forwarded-Encrypted: i=1; AJvYcCV7iYQDfa/b+1S2wd2CfXIkAYQRVYcGHMOvGUTyLFYSmokyoK+jmz+OcaKvcJoOP9NLETy1tBvPGE0SnmoQ@vger.kernel.org, AJvYcCWoiYjjYAtF8JydQJgR9pPKztPSvIzZ6PyqvA2vcrOc0gLyTeHfLEn5s0IcXQKvmukH3c8mvGbMriuu@vger.kernel.org, AJvYcCXwcee3opnSEDlioAte17RwH5Ob6JRQUVNspHrx6/f18DGqUFNuK6xpuFWfGmn+4PB6Fbx7kbkx++g=@vger.kernel.org
X-Gm-Message-State: AOJu0YylAC7go70wWyZZu4fcQcOhkCw8Pxzox6FmmdBOVqixJWX8eYsx
	oU9aLdM5tH4OqmbZQBWBSef8UujKdOcmzuIWfJwu7Ooxz3zb0yZmMmAzNimkRQwiXVcxbGyOkTl
	qam24SeUguS5Bm9Mi9HPEZ0TM4LQKnRA=
X-Gm-Gg: ASbGncvWGRlYDvoid1/sfc4DKy98N+TBtrwXZ8uIFSz74uehBEr68b3ZWZqF5UyLmS9
	2Sp//af6KkUkzbzZUs3WQgDFhGH/+9XkyS56uLBE//gPolkcmOL1CAOJbpCTo0KbqexUCFGoMkw
	kbCThXfRBRMXPeCgQAFsKBX24XbDosWsFAaiOZ+ambquNMu82iIc4T5FCsl59xBg/6VnyvER6Mi
	FqnT4WJIw==
X-Google-Smtp-Source: AGHT+IGCSqi+u7zPAKJbXiVle6HBw4vaddTrUBJW1UYwaHGnh/4m0lYlidEl1hsmzcOBFaEBgHl1CB3LcKFa24raxFg=
X-Received: by 2002:a05:600c:1c01:b0:458:bbed:a827 with SMTP id
 5b1f17b1804b1-45a165b7b15mr660355e9.1.1755021529570; Tue, 12 Aug 2025
 10:58:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811173626.1878783-1-yeoreum.yun@arm.com> <20250811173626.1878783-3-yeoreum.yun@arm.com>
 <CA+fCnZeSV4fDBQr-WPFA66OYxN8zOQ2g1RQMDW3Ok8FaE7=NXQ@mail.gmail.com> <aJtyR3hCW5fG+niV@e129823.arm.com>
In-Reply-To: <aJtyR3hCW5fG+niV@e129823.arm.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Tue, 12 Aug 2025 19:58:37 +0200
X-Gm-Features: Ac12FXy555KMqM9sRgAgjXOVEGNZdNcePtQ9D4aII7b1VUPGHKMWOpB_9plVIlw
Message-ID: <CA+fCnZeznLqoLsUOgB1a1TNpR9PxjZKrrVBhotpMh0KVwvzj_Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] kasan: apply store-only mode in kasan kunit testcases
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: ryabinin.a.a@gmail.com, glider@google.com, dvyukov@google.com, 
	vincenzo.frascino@arm.com, corbet@lwn.net, catalin.marinas@arm.com, 
	will@kernel.org, akpm@linux-foundation.org, scott@os.amperecomputing.com, 
	jhubbard@nvidia.com, pankaj.gupta@amd.com, leitao@debian.org, 
	kaleshsingh@google.com, maz@kernel.org, broonie@kernel.org, 
	oliver.upton@linux.dev, james.morse@arm.com, ardb@kernel.org, 
	hardevsinh.palaniya@siliconsignals.io, david@redhat.com, 
	yang@os.amperecomputing.com, kasan-dev@googlegroups.com, 
	workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 6:57=E2=80=AFPM Yeoreum Yun <yeoreum.yun@arm.com> w=
rote:
>
> > Right now, KASAN tests are crafted to avoid/self-contain harmful
> > memory corruptions that they do (e.g. make sure that OOB write
> > accesses land in in-object kmalloc training space, etc.). If you turn
> > read accesses in tests into write accesses, memory corruptions caused
> > by the earlier tests will crash the kernel or the latter tests.
>
> That's why I run the store-only test when this mode is "sync"
> In case of "async/asymm" as you mention since it reports "after",
> there will be memory corruption.
>
> But in case of sync, when the MTE fault happens, it doesn't
> write to memory so, I think it's fine.

Does it not? I thought MTE gets disabled and we return from the fault
handler and let the write instruction execute. But my memory on this
is foggy. And I don't have a setup right now to test.


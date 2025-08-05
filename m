Return-Path: <linux-kernel+bounces-756395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 189B4B1B37A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 14:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C582A622B51
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 12:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6B42701B1;
	Tue,  5 Aug 2025 12:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WM+hcqWx"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022DA1DFFD
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 12:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754397076; cv=none; b=DWBVebz+4XcdQCTURQgINwfIBCJ0hBDNH8akvjuRYhk6gEvBexUHHh7fLCTtUc7LBSASeHp4WUlVD8Wz3VJx+gY3c2g3lJ6soSPpJsOv0XBT90luhzkhYFA3AOI+SD7cvQ6zWaIgy+xQ0kCEXiowyVaOfcdRMZTwlc+ktMRIUTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754397076; c=relaxed/simple;
	bh=SplbwX8kGCEpxQqWeH1rJZnxgDVwZxhX8JHkip170Do=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cRytMKVsMgDgPYZ1ZbTxExjTot4qNupH8GJohvHEv6OcKj1JBoesb13i11Ub2RmzaErh7D6omqLHCaIyhN20Ng5d5WoHwpwP3a2RilsLb7awrwSdlDFx8Y59yNPB2dpUlEyQVnZprfUq9lJobV5xafEbTosUW2Oiu5ZqweSuy30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WM+hcqWx; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-23c8f179e1bso51227095ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 05:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754397074; x=1755001874; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Yc4gvWW52t1NDKhzxwrmBqGipvg9SoHEPfFiqWrZ+tE=;
        b=WM+hcqWxDhpSvQynQvKl4mbBDlMjFXl2ohOeBLh+H1TPOiFWU51hgdU6jVU387r+iU
         58FEeUUoF8DCrZRQji6b95HnFdgK9knvHbki5iXZ3vjR2b0gY0gSIxz+jmbiRw6KuYvB
         7pgMWyLR6dyHMv3q12KDrRlbgx/fXeaqU6EDiX/CQrOZHl3q/dpllri0olnReEj82/22
         UemfTXJCv7Mbgq9BZFZ2tP6NIIA7u1XxbmsWFXjs7fBqqorrhHsLk1qo7oHlMMWYqU4x
         fbikSJQ+x7Q4kSWn8ApT3149jq2X0Ubz2IR20uXqCnRnEyg0QD1xDK1P2bJ+JLroE8+h
         W3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754397074; x=1755001874;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yc4gvWW52t1NDKhzxwrmBqGipvg9SoHEPfFiqWrZ+tE=;
        b=n0YQSMuWDKDGfdjZupCmbD2SJW+tXatQVJg5jajt3k8cOhf9QA84h5FsdWqahlP8/e
         BQahuq7tHTRftERy+yd6GtGC1NY8/j63mPxCA2q1HUgwln4Me77A9RJNSeIM15JR1Hg5
         znkFmbw6bz4mpQCLw4WaIVoUfE1mmnROpOAj8ZRapQ+wZ9AUfHSZpj9ws2hy5qawZuvh
         xP0uNwh0A6NJEvuQEuDC7grM1S5nUaLss4ke1xuxP8dAyT/UkPkRwWCXIxvRneLwbErF
         yYxHx9BOqZoncxMFUONxDqth1sY2og75P7WeBfAmK2i1XTya6EbsSKG6piOxwwhGHG9k
         z9wA==
X-Forwarded-Encrypted: i=1; AJvYcCUhTDLnGyT6gM1LKk4BQX/hg28AP7kgKDD8z42i3G1J1A5J26b/5xHUuucaVWDIJs8LKqJPxEN63WyFA70=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy9c97KzBRRbxOXR0AtlaY4r49RWsDBRlsjDRTf/LP4PmzDkv8
	SwNyz2TvhtV/iUeHc/Tx1iRbNG7cFIlMWK0F+jmbs1AHoZr4aofapkhogTut2JOfsZix0WREL5g
	YYKayHRDLZJbJEdjAOEHBHgjJczkhjnajji623Wzg
X-Gm-Gg: ASbGnctZHPmZ6/ttaY7QTVy272hbSN8RyzIYTi2H8YlM0ZxJPkvj9FxQ7I4f/5E4+Qj
	s/OChHoz4rGMGKPFMZcmELUZHmD1bMCWoPLsInUSChlePe+Ime5O8jqBD1QZg/tYkP+auuHLBEn
	GrBVtdYhfEQq+bbbjID0X6IrER3sAzwf4hSyKSAO7j4jdBpgqVU4QluOlN2wx+wPRfSkAFNCiFf
	xBn8z+zWAR2GXm+z7Vt2IYssCgrordkK07/wA==
X-Google-Smtp-Source: AGHT+IGPjiYBPWhiiCGGe0rpFKkbh1Rg3FSdLNOsksOA3V1eWAJUxiBJ13PoRIjsobG4RiQygfgDMFJjCSuuK+shj7s=
X-Received: by 2002:a17:903:245:b0:224:23be:c569 with SMTP id
 d9443c01a7336-24246f6b79bmr191772715ad.22.1754397074101; Tue, 05 Aug 2025
 05:31:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804-kasan-via-kcsan-v1-0-823a6d5b5f84@google.com> <20250804-kasan-via-kcsan-v1-2-823a6d5b5f84@google.com>
In-Reply-To: <20250804-kasan-via-kcsan-v1-2-823a6d5b5f84@google.com>
From: Marco Elver <elver@google.com>
Date: Tue, 5 Aug 2025 14:30:37 +0200
X-Gm-Features: Ac12FXyvqYle1O7urbvJeMSiw9QK6-PDkDpNKV6wtqm4byhvYfbkU7M963dNpMQ
Message-ID: <CANpmjNOJxJ+kM4J7O5J8meSD_V=4uAa6SwFCiG83Vv_8kn56sw@mail.gmail.com>
Subject: Re: [PATCH early RFC 2/4] kbuild: kasan: refactor open coded cflags
 for kasan test
To: Jann Horn <jannh@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas.schier@linux.dev>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Aug 2025 at 21:18, Jann Horn <jannh@google.com> wrote:
>
> In the Makefile for mm/kasan/, KASAN is broadly disabled to prevent the
> KASAN runtime from recursing into itself; but the KASAN tests must be
> exempt from that.
>
> This is currently implemented by duplicating the same logic that is also
> in scripts/Makefile.lib. In preparation for changing that logic,
> refactor away the duplicate logic - we already have infrastructure for
> opting in specific files inside directories that are opted out.
>
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  mm/kasan/Makefile | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
>
> diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
> index dd93ae8a6beb..922b2e6f6d14 100644
> --- a/mm/kasan/Makefile
> +++ b/mm/kasan/Makefile
> @@ -35,18 +35,10 @@ CFLAGS_shadow.o := $(CC_FLAGS_KASAN_RUNTIME)
>  CFLAGS_hw_tags.o := $(CC_FLAGS_KASAN_RUNTIME)
>  CFLAGS_sw_tags.o := $(CC_FLAGS_KASAN_RUNTIME)
>
> -CFLAGS_KASAN_TEST := $(CFLAGS_KASAN)
> -ifndef CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
> -# If compiler instruments memintrinsics by prefixing them with __asan/__hwasan,
> -# we need to treat them normally (as builtins), otherwise the compiler won't
> -# recognize them as instrumentable. If it doesn't instrument them, we need to
> -# pass -fno-builtin, so the compiler doesn't inline them.
> -CFLAGS_KASAN_TEST += -fno-builtin

Has the -fno-builtin passed to test if
!CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX become redundant?


> -endif
> +KASAN_SANITIZE_kasan_test_c.o := y
> +KASAN_SANITIZE_kasan_test_rust.o := y
>
>  CFLAGS_REMOVE_kasan_test_c.o += $(call cc-option, -Wvla-larger-than=1)
> -CFLAGS_kasan_test_c.o := $(CFLAGS_KASAN_TEST)
> -RUSTFLAGS_kasan_test_rust.o := $(RUSTFLAGS_KASAN)
>
>  obj-y := common.o report.o
>  obj-$(CONFIG_KASAN_GENERIC) += init.o generic.o report_generic.o shadow.o quarantine.o
>
> --
> 2.50.1.565.gc32cd1483b-goog
>


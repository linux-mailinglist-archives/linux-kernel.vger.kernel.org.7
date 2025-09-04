Return-Path: <linux-kernel+bounces-800451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB94B437C4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 12:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAF66189A40A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA962D12E3;
	Thu,  4 Sep 2025 09:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BOBrub+T"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138D02EB87B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 09:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756979990; cv=none; b=DnWw82oQ4+aa9LeUVdgR0LP9ZKOHBylQ6LcbDkFe1YqRU5dvvhHZV11OMXUE9Tf8Tj7yUV4rOrjRUKD4/ERnKQYwOp9/WZEFdTszvv42OKrmTxKVCQQffJAni+Mt542kMDiQV3gr+IwZmeBxObWzLIoNn+/8aNf77mePfdGWquc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756979990; c=relaxed/simple;
	bh=MHOpn0x1n+X9bJMJ6KJ/yl+og8/86ttoBXUy6mB0ey0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ULBH93UnYtlFnSF61gFU1Hg+7eM+Jkdxm7/mEYFgvFMhmc8BxMER458il/zT+tpq7Yq2q0+ssqtqonkf1nDoJL5tSlRa5jQXxm0KSgiHJBqWkuw1498WJqmDxosb3qNs4cquwUZweCkS3T2HI5u36G/R3h8F+fneR/KoTK8b8tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BOBrub+T; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-70dfa0a9701so9413086d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 02:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756979987; x=1757584787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MHOpn0x1n+X9bJMJ6KJ/yl+og8/86ttoBXUy6mB0ey0=;
        b=BOBrub+TZH5c0OUCABsKHFUkeq5pzsdHdC9K/lhEN4bUf1YJ1uuDMpE2pICrQfZEIO
         2fxvd9Olpa8eKI+vJAOwYereBVW6Rvbwn8uvHmNr8AzowOzqvKwlkrsZ3qPHrO3O1lzq
         W3YHwCx6Iu94jTdm/nHN1Hbv4Um0xBlHeUidptcmPHhBorNOUZlK0rlLkcCAfocK8ElO
         cxnjU0vpglG7bR13fyBq0fYw4waiWVMQa6psOhFgxo4dsyMAOeliQWpTs/nFtNxnQt6O
         lE0to02yF9DYQ5pbu30E+gBb4MNo0XsYS3j0pOqIA3Jwt9fE46BTfeEc/7Syva+J8Jex
         KLtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756979987; x=1757584787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MHOpn0x1n+X9bJMJ6KJ/yl+og8/86ttoBXUy6mB0ey0=;
        b=S8D2qjSM2ntHHbQuXBR6kvrxBQ/hE4k/dLhrLN0xqNzc//1SjHLwOOiNOYvqNerNeQ
         yYS+Jp7C+cymx4VHjK08yiRTFDhfmDj1aYGS6yODvypTb+Ct6sUlcG5OGn+Bc1slKbor
         OsgicomivwND+w1/GARwNq2j3u8amd8Z8tHgotgucOobPICPdLWriNnlmPCDXGUkglgW
         33L9DLAL8pf13zlSsoNyvMzanOMe+nl18pp2eAZnqW83f63RrxGvBTVzhlnEQyP0A9Wr
         t8mV0fc2EYeNIKf/zBVte/jx/wV40hk7nMttj9PmSo/FJjigeSbC/YwQDbGr6bPyDV6C
         i0ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeYTQUi16hM1RFEccotNxekNwJhbQCpuxR82moBXG04okABrUf5q7r+mHeqjfKcE2tEhykLUw67qWD1Ho=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXLXJIe/MUKRo5X+9Y5k0W40OpbPAQsjOUVo+L3RJ56jwEMZDJ
	4jg7paT/xAvb4feDaEXrxLUzm9I1kSAn5puzdNqhK4m2MhDX17f7/QQjgfXQvKCh4QOnxQZ7HnJ
	f+qnTYwYBtKOLbwz5ffNrXbaFAC68G5UgGuG1Jc0u
X-Gm-Gg: ASbGncvzI2RLQ25YBvlqtbovvc/DL9y6yD/cMrmQiS8w/WvpLowFkAXRpLWC/2qTLBs
	PyWCUs8zfu+1cz2QFT1+I333Ec1uL4IY1LL/iQdTbBZLlKjvFlpQXL3zrMWLYZzS5jjT5xbWvUQ
	+JpaSpd39xMqfPaw5MTRU2sSnwYPWmKq5/Zz7s2PWY2vm/Z7Kf+wFBWi+cM8h0TzyglMkrlNiDT
	tXsdZvyQ1oO3aM9AIqyssOlJXP4CKwJXHrHwmyvO8RfUQjy+B4dEA==
X-Google-Smtp-Source: AGHT+IGT4Lm1UEnlQ2bizwHe4ELvu4hzuE9iFObagSCtHAbdLbsZpQZ4v6gnTYWZ5T4wkKXfEhUwpiekj7TMD6WN37U=
X-Received: by 2002:a05:6214:e41:b0:709:c7de:ce70 with SMTP id
 6a1803df08f44-70fac700db8mr222215406d6.10.1756979986529; Thu, 04 Sep 2025
 02:59:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901164212.460229-1-ethan.w.s.graham@gmail.com> <20250901164212.460229-7-ethan.w.s.graham@gmail.com>
In-Reply-To: <20250901164212.460229-7-ethan.w.s.graham@gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 4 Sep 2025 11:59:09 +0200
X-Gm-Features: Ac12FXzQlIV_NpJ1rduhtC1FclDh1AxIHe380g_TpXDcw3vnB7j2ZNk2kb8WbdI
Message-ID: <CAG_fn=WJrdSr_6u770ke3TxyFimuMXXeTSQhsDR73POy4U8iug@mail.gmail.com>
Subject: Re: [PATCH v2 RFC 6/7] kfuzztest: add KFuzzTest sample fuzz targets
To: Ethan Graham <ethan.w.s.graham@gmail.com>
Cc: ethangraham@google.com, andreyknvl@gmail.com, brendan.higgins@linux.dev, 
	davidgow@google.com, dvyukov@google.com, jannh@google.com, elver@google.com, 
	rmoar@google.com, shuah@kernel.org, tarasmadan@google.com, 
	kasan-dev@googlegroups.com, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, dhowells@redhat.com, 
	lukas@wunner.de, ignat@cloudflare.com, herbert@gondor.apana.org.au, 
	davem@davemloft.net, linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 6:43=E2=80=AFPM Ethan Graham <ethan.w.s.graham@gmail=
.com> wrote:
>
> From: Ethan Graham <ethangraham@google.com>
>
> Add two simple fuzz target samples to demonstrate the KFuzzTest API and
> provide basic self-tests for the framework.
>
> These examples showcase how a developer can define a fuzz target using
> the FUZZ_TEST(), constraint, and annotation macros, and serve as runtime
> sanity checks for the core logic. For example, they test that out-of-boun=
ds
> memory accesses into poisoned padding regions are correctly detected in a
> KASAN build.
>
> These have been tested by writing syzkaller-generated inputs into their
> debugfs 'input' files and verifying that the correct KASAN reports were
> triggered.
>
> Signed-off-by: Ethan Graham <ethangraham@google.com>
Acked-by: Alexander Potapenko <glider@google.com>


Return-Path: <linux-kernel+bounces-741923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BA0B0EAAF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 08:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB0B14E1E50
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 06:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655C526E6E7;
	Wed, 23 Jul 2025 06:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UYOIAsLA"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B71E185E4A
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 06:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753252372; cv=none; b=bCIfKrcxzQpGeNW4QbID1+uasM3KR5+nWi2c9no+zbEJw0ayAht4QWrvEDnZo3ee7tzjhXJuzZmlVPUQGEonHk/zEMTKw9YS2xHSoTANVLXmh5vrL5ZxJvrhZYrN0HVT1k0XGWwDTOj19E0Xu6pL0yAyWq8sRrNv1koNnALuKwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753252372; c=relaxed/simple;
	bh=ksSHZQHzmsnYrIOFwQI3+1UdMZb47B54kf6s59ZmSk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PcAPOzGUK3niZJoFkbs28N9KFEerEfrB+PApTWsBIcjNG9Ip8e1CCohdVjLvosWcand9HPRZoKf8OfGCT/BpprCNudR8UKG7k/GU7IrMyg0Uek2LzzAzPTH8ZM/IspncO6gpiHOONHnF1KnEoZo1UR0EgZ+12hZwajHJfHSsLH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UYOIAsLA; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-700fee04941so60799016d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 23:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753252370; x=1753857170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wF+NlFQlfE9P//LH37cgymDuX2rWkQJvOt5FtUPktlY=;
        b=UYOIAsLAD7actdTC3pKFAXtCESECtEs19tHQowIj6saIY02KRWMAO0i3IsAfvG2iP3
         nE3bDQpSUrLusXA2I/BmKs5TFXzqj6MxbAX8U9emYdGv54odwPUTW0/7IOSchvWOefF5
         EWOdyqL3dtVv61XDQGOC83lnyCPRtR3lYvw5eyZFxN9JO17bsshco0E45pr11lkUOYsa
         UXSmLYWkXZn+BNaa6ITf80h7//qyYdeoPX2uMQSO9sds7pR7CSR+nCocCCFRb+5PWdL8
         UEk5F8rTztEIwKYZSigFN+eeLHohRuNaBfMH1XyMRdkod5ZaHeVv07vtW/mCilDyXnUy
         +kNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753252370; x=1753857170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wF+NlFQlfE9P//LH37cgymDuX2rWkQJvOt5FtUPktlY=;
        b=ce8GFUoCaQrqfFjz5ZztCbQMpRouKKt51Y/mgYPPhiH+cbTGUjQB/MD+g5qfXC0uGe
         ItgoxavtaM1ryOVLm3DdYAZOetwEk1cemm04tl5kNHfJIFtkCQNOJvqLo4/TGqZ4cOks
         DT+uKzyk9GdOOpCW2Vi6lGpNgqVTGyiQx6o/TEEvsV+qj48lSH6U8eWB9J9sRxTmt6JL
         fp8JvXLLSHFXKS94n1Jq+i7Rc1rkIYOt30jQdBlAo9774R4QGkvuyxw/vBJOp3Q/duRx
         H3xztwbvstLeF5MnDT/t0tFKclViBwUGsQitPAHh7qTEg5h0z/O62ZF9CbgU+eZaoK13
         5TUQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8HW0I2e9SFPA1EYrYjM2WntG03eeVcR+bHbQjsG6d6xAz+hT2h5l3V3bpxjJmkKpD8nJ3CcSoXlO89wA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUrN0AWvdnFHG39fBhRmNbh9xNhdrtxfNNAoPB+w4Sx0giC9WZ
	DHnailfM3JB7tfiB12CfwZrvMJCg+G7k/jlxX0XagbCNT2bXmoC/EFRgm/CcJLuuM/xmKZXszF7
	UN7pMjtksxHWBIp/vPbg7dGN3j2ENCA2V79LWqZzv
X-Gm-Gg: ASbGncsA4Bz91w/jP0TPaVPSzQUI4VbsO2zpmBqCOE3GKp2eIZ9Wchm1PiM27W/Y9Fa
	xXra+hN9hh7v352YzYAw5H7wzfyzd1rE2tJazEKZK+I6m4EsXOMiTf1p1BJ/YPFMqEbX0D+MHs9
	ROA19/Qw2ZEbxvKETdYTo8pssFs1LZA9sc+I4btg3f40LNvRnO61vkEaMRSqILjtx4OOgsT+w1P
	Vl1Qv6HpXt88YqtGb3nLBI4ZuCaR8bz5l6xHQ==
X-Google-Smtp-Source: AGHT+IGaqgYRjEX0CAvEddmukIk7IF9PBFCp4ZtJi2P67k9ZqIeoiNjpZBVtVB0l4YEk+IAj9Ec/9U9ndRdKeWbsifs=
X-Received: by 2002:a05:6214:f6f:b0:6ff:b41b:b5bb with SMTP id
 6a1803df08f44-707006ca3aemr26052026d6.26.1753252369878; Tue, 22 Jul 2025
 23:32:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722183839.151809-1-elver@google.com>
In-Reply-To: <20250722183839.151809-1-elver@google.com>
From: Alexander Potapenko <glider@google.com>
Date: Wed, 23 Jul 2025 08:32:13 +0200
X-Gm-Features: Ac12FXyBlr57qCpyR0lUbajVEyB390gj3dwP42_EXhGqHDRidQO7_1t2ga4NKco
Message-ID: <CAG_fn=V7K2fSOD951uNuk0sAExUxrHRg6hOnpt1Eg=sb8Jo--Q@mail.gmail.com>
Subject: Re: [PATCH] kcsan: test: Initialize dummy variable
To: Marco Elver <elver@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>, Boqun Feng <boqun.feng@gmail.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, 
	Linux Kernel Functional Testing <lkft@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 8:39=E2=80=AFPM Marco Elver <elver@google.com> wrot=
e:
>
> Newer compiler versions rightfully point out:
>
>  kernel/kcsan/kcsan_test.c:591:41: error: variable 'dummy' is
>  uninitialized when passed as a const pointer argument here
>  [-Werror,-Wuninitialized-const-pointer]
>    591 |         KCSAN_EXPECT_READ_BARRIER(atomic_read(&dummy), false);
>        |                                                ^~~~~
>  1 error generated.
>
> Although this particular test does not care about the value stored in
> the dummy atomic variable, let's silence the warning.
>
> Link: https://lkml.kernel.org/r/CA+G9fYu8JY=3Dk-r0hnBRSkQQrFJ1Bz+ShdXNwC1=
TNeMt0eXaxeA@mail.gmail.com
> Fixes: 8bc32b348178 ("kcsan: test: Add test cases for memory barrier inst=
rumentation")
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Signed-off-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>


Return-Path: <linux-kernel+bounces-770162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E528B277D5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 06:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81246A08468
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2358122DFB1;
	Fri, 15 Aug 2025 04:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIzQC1B2"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3B321B91D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 04:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755232984; cv=none; b=bOrJMkReRhilY9ppVVQ9Zjc20yG8qN6RLQvRFA2UQd5LwTz8DS/A8rj1lkZCsSqI2zIEZfdrjmakA+/SaPouCjgJcO3ADHuRCYKAvUV6WW/s3y+Idss4SQRaNIKY8gOIDXHqcHe87SGMjoMaOJBvWI0uUOwN44Dwnv2b2G9zrqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755232984; c=relaxed/simple;
	bh=j3R7e/mODk8uXckZ5NZ5/I3y0JpUqVHIYps8pPNWoCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bpIFNXQnLDReNJF7VY26en6xU2tjTegPTcQYDKU4Hk1NmqFQVSv+xSwB9JmiivC/S4q4i4UPkW3EaCb4/evrTAePjY8xxyp1LBGfSSBQrc2GJM7IFJDMqpZFPqTxoQPBZ7FMZzOE8+k19ZkX5xpVogmFkmo8ik9GYq5QpeIbQLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kIzQC1B2; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45a1b00f187so7129065e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 21:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755232981; x=1755837781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3R7e/mODk8uXckZ5NZ5/I3y0JpUqVHIYps8pPNWoCs=;
        b=kIzQC1B2vV8MwgXx21CQElGgt4NTswW5QsM59xFXPzyBs7OUmLGlsvSHo3gKzlG5Te
         ALvcak7hJqj2U2YFFz2avCW7qB+jcBtTyce0MzS6SYAIC1Nfg7K51Z5gKPsGtydQw3o4
         87sr7xOTZ8w5VnsJOAM4yy0f69507UswN5Vm5QNJNF7XgbrY++scAQbcnHziIyIzvvem
         0zoDIlBLNGnsICKyvCgdWPFnP7OQeHY/ZmuZYQ49V1wMUrE6ks80oc+Kr0rcZ5tCNwmU
         9cCn6xc8gsoFiYw8vNw9y0+Okv3bmNWG5030tNPHI5vG2PfzqiEIA8wXVSLls0jVaLV5
         QjgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755232981; x=1755837781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j3R7e/mODk8uXckZ5NZ5/I3y0JpUqVHIYps8pPNWoCs=;
        b=opdbMJAWTqNHuFYKTTtX40EmzMlpB+/atmNGnMl6hQOW8qt+bZBvnnfqPsQOSw9+g7
         WgPbVH9UIRLazziEKNbRf9TJmqjPQG1uccN82MTCSxE6eNO7o5L4Fg1au5mJExmzEuxK
         i7hKbcffvHJE7se8rGWFfs52yjSc1F/SdFRp/se2hU3bRhr2EV5tGw5ETiYP8F/o3O4F
         UFwFjn5e1pe8L1bi5wVBuEbrNNb736SGtS6gIMIyKmYTizIDXIdkcVsyk0+JF3ynU1R5
         oukJ7jZPWd8Zpw0vvSoRL0BQL6gJ0kPcBCWyOVizmpafB4lC5CULq7yvYOjb54bwabJL
         MV8g==
X-Forwarded-Encrypted: i=1; AJvYcCU/WSGMwRv0sJFv3YrEkPjdu+3ymNlylpJDvtogg4u1C1iRYu+uvns/pV3/DH+xruYpAfSr1WevPY6xYqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHZzKZScNjMo/x+ZV0CFrmGmtn2HwncukN0zNTJ0G0ESiz/nnv
	bONnpZ5l7OVUC5feUEuaE04Bl67GXjtrliw6Mna6fKKHEo29TugJYOP/scg6NVg+u9owkaa4+6Y
	atuPEt+4nogYECYJ4C/3he199TpWRZns=
X-Gm-Gg: ASbGncvIYeNDts0e5eesvwbm8urHF/mOufJRvJfn2gASbTdkUeERIir9vPuXIz6nGmz
	2PDvLVcpAUgUMkN+4FIa4IzTO4cdcBl4Ev/ufmQrZqRBoO+1XlHBPWzDRmlMj75E0pQzvowguvm
	n9xuGHk0N9FxKUVC4hLDdMk7kxCbqErvDNOIT8cgZK1ektrqPCEzQAOoRh7etYFHsTPNnbqwF83
	01uyHOg
X-Google-Smtp-Source: AGHT+IHUEFiZR9LZSygwnTYlHEBGpTIo0u+l0gJJ74GZGqWA8Urxqb7v7zb3aW8D4/IFFp3XGkfgVY5+R22siTJ+vZw=
X-Received: by 2002:a05:6000:4022:b0:3b7:899c:e87c with SMTP id
 ffacd0b85a97d-3bb6636cd4dmr361412f8f.2.1755232980929; Thu, 14 Aug 2025
 21:43:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729-kasan-tsbrcu-noquarantine-test-v2-1-d16bd99309c9@google.com>
 <CA+fCnZeuewqXSW0ZKCMkL-Cv-0vV6HthJ_sbUFR9ZDU6PmzT-g@mail.gmail.com> <CAG48ez0OnAPbnm73a+22mpBjvGHKFGqYAA8z+XocZEHXJCcQiQ@mail.gmail.com>
In-Reply-To: <CAG48ez0OnAPbnm73a+22mpBjvGHKFGqYAA8z+XocZEHXJCcQiQ@mail.gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Fri, 15 Aug 2025 06:42:50 +0200
X-Gm-Features: Ac12FXzBCNI4JKiPn_2WUKTuherdT8IB-yvUU_GUQLdNyBF0zRHg-bm_iV4Kkkc
Message-ID: <CA+fCnZcYBCfPA5ObUEWq9iJnXFMw95GKHFZaaZPr84GUtbVNnw@mail.gmail.com>
Subject: Re: [PATCH v2] kasan: add test for SLAB_TYPESAFE_BY_RCU quarantine skipping
To: Jann Horn <jannh@google.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 5:05=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> > I think this might fail for the HW_TAGS mode? The location will be
> > reused, but the tag will be different.
>
> No, it's a SLAB_TYPESAFE_BY_RCU cache, so the tag can't really be
> different. poison_slab_object() will bail out, and assign_tag() will
> reuse the already-assigned tag.

Ah, right!


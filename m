Return-Path: <linux-kernel+bounces-818517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 411ADB592CE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7519525491
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1272BE7AF;
	Tue, 16 Sep 2025 09:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4S6RwJSw"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61572248BE
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758016743; cv=none; b=AeKIJIo2jXe8pB56W8ohlz6hxkW+heqbVy2fNFmRdmMvhg08tSY1pzDVMJ/X5/Me0egQNsnCiwji4m3ZwZrTp13mvZndnWmS9EpmkBOMu/QIAwRrrDqEuB3cCyPwOU9+HK6j+7PrMMpCiJR+A/mqp79Af3UvrVfOy5kPiRQjBHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758016743; c=relaxed/simple;
	bh=Qlj3Irf759RURMTstGjX6Hrvn0DetfaZAAndpsTHlfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ud2I4yNvN5FsPmt/WKQGEMqvidRcu9PFcKA1VJQ4wL0LF7GCRbmrrAwqaNBCAptUDpLWa9ccp7c2zAe4sIU5pn7UQ/Jw3kjAJMQOKfniWivqpURq7tMoUd7koxQpfgNFDZPGkzCJx6Ybc+c4T+7epH7EhEwbwBkrURfxsMpneNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4S6RwJSw; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-776aee67e8dso15346356d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 02:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758016741; x=1758621541; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ihmf+x196EH8nuZxldOMUKvsTYF5JZyh/dMEPXLM1AA=;
        b=4S6RwJSw5Z14tJmY+hPq1KbIjSiPtKHi+GAK3GT+Y1IrqiXj7v+GCN/3UuWFIyXXSF
         IHaDSNajtZgLqF1pCjtUnvParoSsJEuYcsuzIu+NWHwSC3jr9pae/45JedKY6Ezs4mg8
         bmzow9s7TWDj5Gk8dCGFNhdtddjttLJJ3iI0Z0mYVbGj0uxdLvK+ZK9RFeb0HmjKFcZ4
         b47uBRYUps4T1Szs0dlhKdbeQvidTZZKH4qQOy4s9W8u7KvpvhNjGEiwzf5fiv2NnLWd
         /m1dwvj9typEbMzzxrvtkdER+ft67qLGTNvBXexq7CEEOvlEwJHUxQjQ4KKeKpDmPsfm
         /ffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758016741; x=1758621541;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ihmf+x196EH8nuZxldOMUKvsTYF5JZyh/dMEPXLM1AA=;
        b=dgH0diPtQFi4o25dD5DKB7p0tWL6yr/xtgBybHZFRstXndsnwbH1CF3HPhKvOq4ZsE
         2MCzu8wADmC8n5aKdQQUJq154v4jG+93MV/4Fz0SVII7BDLNPav+oFRuv6D77xNd1QLi
         S6knImSDd7Ka2v2vhruKA3wP0ZQFcG2lOvI06kmXvv5Xk5aLTM7NDx70tNCK4cjNFsV+
         a3HlM5cgbRqiYn5H5hGftv0MTJNuFrpxM+e/1nMelgfqBh4jut4eqD9+PsSTKUh13g1U
         Ygl1GR03vBX5SUNWwYmBHiMqkwWfhD+p8mrXaPU84sDjBWcMW/4bZhnZRwA5iwoObHHT
         APYQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5l4mFx5A8vnSTRD7my+kHHfMMLgIBBszpqlICgZ5/XNJsugRGyRKqKrtLDLajpN1eN36X6Zp378HTf3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUuEMfv6GSn8Zvo7sPxJxAuaLf90GHWexRm/tTxXPUkXcGK8Kk
	+a39OnyVMEBoLeLCUiZm9M5tO0LJD5ocFWI74Z5yhNw/JtCU3eve0IXrGC1f/eIqOxs0YBGdxF5
	m5v0CzE7VHHaMgwEemi7T5EuJYfANR7MK6DOUZ/gs
X-Gm-Gg: ASbGnct7v8YBJUqDs4LKxxINtTLSXxH2wceXhWVuaYsd5y6xeW6Tjno6AytBtWj84oP
	jd6zB+wFf9lMBWuwffB9TqnIzpb5eTE6tLbvXjnrjtY9vqzvimtipebRBwfXc2f/3zbaA7qiqIB
	ElGiu9et3kaOjmiPj8zsPeCNM+WgCtBt3CleGg5aEuiRS2wBomV0GUTLjZNDvj6k3+w/8Z4rbP9
	6FYRpR1XWld3znNyvP+3GuJhXoINgHPBBwaSAvphBKT
X-Google-Smtp-Source: AGHT+IFwGoXQKXa3T3Q3VSrPol5k75GVxiDe8CoLpO3guc9BwwyrOEWBkMhzdh4JyC+tSurxuiqJK5Hw+XiDhw5FhJ4=
X-Received: by 2002:ad4:5e8e:0:b0:723:e1c6:8d7 with SMTP id
 6a1803df08f44-767c5aebad5mr178831206d6.64.1758016740321; Tue, 16 Sep 2025
 02:59:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916090109.91132-1-ethan.w.s.graham@gmail.com> <20250916090109.91132-3-ethan.w.s.graham@gmail.com>
In-Reply-To: <20250916090109.91132-3-ethan.w.s.graham@gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 16 Sep 2025 11:58:23 +0200
X-Gm-Features: AS18NWDFgZtzDhBG5IKRN3iWsXFMSPZcawD_BvUUYRoHSVWInp6fN2JP63m3d4s
Message-ID: <CAG_fn=U8Y=WNTNnP35uwQqxmFOnOV7ptdG0i1VjsaYUe3wfRuw@mail.gmail.com>
Subject: Re: [PATCH v1 02/10] kfuzztest: add user-facing API and data structures
To: Ethan Graham <ethan.w.s.graham@gmail.com>
Cc: ethangraham@google.com, andreyknvl@gmail.com, andy@kernel.org, 
	brauner@kernel.org, brendan.higgins@linux.dev, davem@davemloft.net, 
	davidgow@google.com, dhowells@redhat.com, dvyukov@google.com, 
	elver@google.com, herbert@gondor.apana.org.au, ignat@cloudflare.com, 
	jack@suse.cz, jannh@google.com, johannes@sipsolutions.net, 
	kasan-dev@googlegroups.com, kees@kernel.org, kunit-dev@googlegroups.com, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, lukas@wunner.de, rmoar@google.com, shuah@kernel.org, 
	tarasmadan@google.com
Content-Type: text/plain; charset="UTF-8"

> +
> +/**
> + * struct reloc_entry - a single pointer to be patched in an input
> + *
> + * @region_id: The index of the region in the `reloc_region_array` that
> + *     contains the pointer.
> + * @region_offset: The start offset of the pointer inside of the region.
> + * @value: contains the index of the pointee region, or KFUZZTEST_REGIONID_NULL
> + *     if the pointer is NULL.
> + */
> +struct reloc_entry {
> +       uint32_t region_id;
> +       uint32_t region_offset;
> +       uint32_t value;
> +};
> +
> +/**
> + * struct reloc_entry - array of relocations required by an input

Should be `struct reloc_table`.

> + *
> + * @num_entries: the number of pointer relocations.
> + * @padding_size: the number of padded bytes between the last relocation in
> + *     entries, and the start of the payload data. This should be at least
> + *     8 bytes, as it is used for poisoning.
> + * @entries: array of relocations.
> + */
> +struct reloc_table {
> +       uint32_t num_entries;
> +       uint32_t padding_size;
> +       struct reloc_entry entries[];
> +};

> +
> +/**
> + * KFUZZTEST_EXPECT_EQ - constrain a field to be equal to a value
> + *
> + * @arg_type: name of the input structure, without the leading "struct ".
> + * @field: some field that is comparable
> + * @val: a value of the same type as @arg_type.@field
> + */
> +#define KFUZZTEST_EXPECT_EQ(arg_type, field, val)      \
> +       __KFUZZTEST_DEFINE_CONSTRAINT(arg_type, field, val, 0x0, EXPECT_EQ, arg->field == val);

Nit: you don't need a semicolon here (also in similar cases below).


> +/**
> + * KFUZZTEST_EXPECT_GE - constrain a field to be greater than or equal to a value
> + *
> + * @arg_type: name of the input structure, without the leading "struct ".
> + * @field: some field that is comparable.
> + * @val: a value of the same type as @arg_type.@field.
> + */
> +#define KFUZZTEST_EXPECT_GE(arg_type, field, val)      \
> +       __KFUZZTEST_DEFINE_CONSTRAINT(arg_type, field, val, 0x0, EXPECT_GE, arg->field >= val);
> +
> +/**
> + * KFUZZTEST_EXPECT_GE - constrain a pointer field to be non-NULL

This should be KFUZZTEST_EXPECT_NOT_NULL.

> + *
> + * @arg_type: name of the input structure, without the leading "struct ".
> + * @field: some field that is comparable.
> + * @val: a value of the same type as @arg_type.@field.

Make sure to fix the parameters as well.


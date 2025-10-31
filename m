Return-Path: <linux-kernel+bounces-880970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAC9C2712F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 22:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA9EE403763
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 21:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC37329376;
	Fri, 31 Oct 2025 21:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IdznsmzJ"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D93E26C3BE
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 21:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761947207; cv=none; b=CLN2o9jgvSuc/NUjptL7Ufpg75Ll6Qw/GfQ4t/JxDnYzyxiVZ9bjgohQI5D5gqkWdQqOOL42BlYGMeEmrXyQ6Q1zI4TwMl8mAUsULI5P0djMzrWg/7ONqR7h17PYYSP75CRFNQsy0qKosi0hcjiV/D76nsETXsq2oRGxrNZi9hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761947207; c=relaxed/simple;
	bh=lWFBDx2ODc9TCuhfEt3nuFs0i434016S0pXkIVIdcLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I+dbSAINJ0UUmYfE5MiXamK/bj3bB4eQtSZVXzPtviyBPpnytI+g3jdkm1HC5pnMNycBAC2XNZIb7PckUqvD3J4ciXJfVQGtURpzLk1fOfCQze+DsfjxOMD8kF65iRBxgYfp2RddF6Z6ZHxbkO8Qs2wS71BJdCSPdYYosRCV/D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IdznsmzJ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b64cdbb949cso416329366b.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761947203; x=1762552003; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5ap26V4PqB3ACpx3v0DEE1m2RpaP2BujTR5irJcY+7c=;
        b=IdznsmzJOZIcK6AgTwFuzl3swYsERbzpHDrFoLexPH636HS6fWS6RGmHzWvg+CKwa6
         UwfSvSMbrshLvHvosAW34vK91zGkreOEotAz5jAj1q5h7Fo3YchBfn8GAbQl5jYZ6ElA
         PRr5LqNZ1i7hgH48xyBcQRoenp8c0gxCh3SQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761947203; x=1762552003;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ap26V4PqB3ACpx3v0DEE1m2RpaP2BujTR5irJcY+7c=;
        b=Pj+tKJTArBV6UUCT4STKQl/rdcrPx2m23y4kZVtasCzYxf52Kds2i4/SgxA+8Hm2rc
         qcs1dTosyM14NcebbDSKOs0Ju8VB9Lke6Kio6n20yj/LNSygyAkc0T5UsxxQeIFLFuV6
         vUwoqGhyRjAteZG2SfWrEeS5yjLYww8qPAGYnx7ceBkZApk8uYg0gQd7VzyXCV+Ok3oP
         qJ8u9WLRTIcH5J+4JEr1S3gtPeYqjKoE/iiK79PRRIXILjI2I7jYIcHMF9fOyS3e5W1f
         S3ZOK3UEQg/VJ0kUhjY/yUAZJqbgPB9XnH1M1wY2a9UOPOzZOhnUzln25e8Flhh8q4Av
         2oWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYnO0hAfOUGC09AYS/sLbkhFzfbg0LWdkZPdycJRxyZTHgr50rgged2nbhOrZu1jaYpTSbtntprH2NRFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdlhB6wIb0nWSCvcnfkCgTSSov8j/E0tYpTuff5zyUKG6+aTyS
	Mp67RPrphSm8ztAI+GTTSbo4zHNefpsiKCkb6U01EeUSedjs42fKoh+bd7DBJ5nAqH+SSenUvNF
	jvxUgB1M=
X-Gm-Gg: ASbGncuQJwZLBx265lcF5ko/kkOCAj4S45Z30PSnpm1mRo9BkqKRMjDntaZNdKLGBIs
	Qu/cWwfAaKje8BKGV8gXqAPRP0su2gzJkGRPatJFJXJggOjW3s7vcqyznFbQOGVJy3nNLAL8d9i
	QbMQdBUebyGPduVSFVgIfqSJXtN6GDdr39TxSSZ/9kU+0h/2aatqn4E+ZBJTwWbYdZIos0ALrv/
	Mh2tiyO6BP6tdO13vJKdfRigljMoCzFvMoLMMev8IsGoHMlFK48PK5NCSqGVhphv50Qerl48oUk
	lGaN5W9guQSPGGG0pVv2/ht3IpqEZF5NQn7T2wx4EtHmUk8/WZgWg3mPyWI65KkJ1O/zFFEVps+
	s6SEs9WXh7RvO/MBjFSieIUjLRPzybym+DxITz2z31KuFK5g3rg4J+BNVnr4DzRSLa3TO8eExsN
	sMhpqc5mz1ldmc8vEF4AgJ1JTunacKpozIOBGOUmhp2L6qCfM2hqiAX4Qc9iyJ
X-Google-Smtp-Source: AGHT+IEJVDHkbldwlDe5RQ7TW5LGU5AeA1o9fK9nSYxRT/CMlHd3i1f0IYkBCBGD4JnXkydNcmu+iA==
X-Received: by 2002:a17:907:60d2:b0:b5c:5df7:be60 with SMTP id a640c23a62f3a-b70707326b7mr518336266b.52.1761947203293;
        Fri, 31 Oct 2025 14:46:43 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077c3ad94sm277045566b.47.2025.10.31.14.46.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 14:46:42 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-63c523864caso5746662a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:46:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWZRhHiOhp64vyDpmi3U7qtaPm9ej46HKb+0MMoyzxIhVWhCbfo2R53wwTDGlB2+VFs+wNHAY/X5cXKoHs=@vger.kernel.org
X-Received: by 2002:a05:6402:26cf:b0:63b:fbb7:88bc with SMTP id
 4fb4d7f45d1cf-64076f6c076mr4314088a12.5.1761947201720; Fri, 31 Oct 2025
 14:46:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjRA8G9eOPWa_Njz4NAk3gZNvdt0WAHZfn3iXfcVsmpcA@mail.gmail.com>
 <20251031174220.43458-1-mjguzik@gmail.com> <20251031174220.43458-2-mjguzik@gmail.com>
In-Reply-To: <20251031174220.43458-2-mjguzik@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 31 Oct 2025 14:46:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wieH3O61QaqE8GO3VAfStti1UZKVcPHznZX5i3YFtmB6w@mail.gmail.com>
X-Gm-Features: AWmQ_bnZTsOGUpX66wwDUEuZ9Wnk0waRdBkhsR3pIgRjF531SZpP31Vx6zbQtVA
Message-ID: <CAHk-=wieH3O61QaqE8GO3VAfStti1UZKVcPHznZX5i3YFtmB6w@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86: fix access_ok() and valid_user_address() using
 wrong USER_PTR_MAX in modules
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	tglx@linutronix.de, pfalcato@suse.de
Content-Type: text/plain; charset="UTF-8"

On Fri, 31 Oct 2025 at 10:42, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> -extern unsigned long USER_PTR_MAX;
> +extern unsigned long user_ptr_max;

Yeah, this doesn't work at all.

We still use USER_PTR_MAX in other places, including the linker script
and arch/x86/lib/getuser.S

So you changed about half the places to the new name, breaking the others.

             Linus


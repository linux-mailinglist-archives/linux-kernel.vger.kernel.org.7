Return-Path: <linux-kernel+bounces-809118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B93EB508D9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 00:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F10114E3F49
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FD226D4C6;
	Tue,  9 Sep 2025 22:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DvU2uHSn"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03C7261B8D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 22:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757456692; cv=none; b=sTZEkEGn3SeH0JysZmOk/vTaBtjBh2wEh5WiJHuPp1h2GWeX/lms5gStFXBVIJCuL0jIWOizfLMYJIR25g4rN6vBew/fsBYKiKxPaMywDfmTNN0Vvie9GS8+Rj+CcytoYchU4lLJxQnc6f8dCBOmoGMDooJUlflkEIDS/2KeJm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757456692; c=relaxed/simple;
	bh=TC2JZtkw5BkMX3Igl25beU/iUsWSo7CWbRuDpStlv3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p4pldkiXVM6vx1AJUwlm73O2YQ8DqctXVmjm88THoSJthq24kpv1FWLQfj67hgMUnOoX+FlGED5eGeZ6xzCEj7jMKWP5srpWUWr4TKyJNC/jnUnf8gXWRzURjQF2W+wxP9LTJhQnrPc340qxV2bJbgoVjEXNrr4DzZ+5dDTq704=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DvU2uHSn; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-625e1dfc43dso6171408a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 15:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1757456689; x=1758061489; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fEQiOQ22rYAZhHJ5F5hChKykmBsdSQ9Mr5OeL3gCArg=;
        b=DvU2uHSnhJEjTHzJ3lR5/zoiyYfyq3y8MKbgzy4OSpoprSBcLTtPKiA46AwT/b/9sX
         Ik8wBZHVj5rSTHa7zjZbuiLGZJzNaZoQu/vlnQDcvmtMjlwr1OPmsqLCyHFkPdAeiiRE
         6RzHYDqNKwv1LrYhgKX1jth1ZWVwyluhh9xoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757456689; x=1758061489;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fEQiOQ22rYAZhHJ5F5hChKykmBsdSQ9Mr5OeL3gCArg=;
        b=Ss/lT3l7Fas1FqJ39B5c/mvxnX0yRWYFVcHVqmdOxVnCd2p/dyjmNQ/naBodN6K4NN
         r7loIQavwn8t5ivkpKaTk1KFdkktvkeuRwnPfi8r/k89trcu0iqX2nvpteJcioxquP2J
         8X0dIK5+VdoLeon8SKJk3tRmxK86xuYzUrVa6bh/BhesGXW8LKBjquavM7fCY7AbeXwE
         OAbzOG5CrsoS4Gw/HJ4lF+5YGQepVCUpKO3qNHcfFJ8y4G9tLPe0uZpkHC+35RS0tesZ
         nRNO+vS3FANBfBZlu0Sh4GMzbCRe1JMazNqbzYVnvUArQGbGsvv8lzeBD71aWo0ux9/Q
         momA==
X-Forwarded-Encrypted: i=1; AJvYcCV3bKWOMBvphIYRPiIVZ17szB34KOP2Q2mc1k0HpkaYFf1NBaw5IHwmHBZvTwxwjabMMSYAQow0QHGqgQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWeLUFvVsufab6v46B7rVK7K/yAhJX0eET6fCgh+A0cwbHNUsw
	7OUETA2jvpsYinwfFkBdKuNK6Iz50Oa22bxrTZytJbjSdmgyLYTd25D8UCtTXOJ0i3YbmbgVVWB
	0b2aOPps=
X-Gm-Gg: ASbGncubDAQfEfH+ijkDv70qQ2Mpl4aGquMovZSThGbULRiM6DjaIgpY3Zy4EHe3FjM
	3KuAd2/i3oQ9NMVAjk/oRJM1VYv3yOiB+WhCGAEx2I9FNtvYnH2g5bBJLmuSqsgrLgOmmlkBvHr
	XCq4i6+uOENDK8Xdc9LiPm5oWGxcx4D4KzdwDz9g7MkNBtJv1XQKsE9vx2NwbzGw4PTyGnnm6kR
	ftv3VSpnvuiMhFaAMwB3XFdGSZIVOElu6pRGBXzI/wL0CjQ42ck+AtUkQbiE9fpyMqGl4xz517z
	iwK5bU4MmTx1Vi1k1tk+ggVUdHZpT1EE58qrIGfEHHRH0u5G34k7Izu3+R0jNH5fDZBbCgkaXFp
	ak6Z4gdZAfaZqfOpgjaUOeAowJHDS5MOLOz/b40UDHmsakZYIpX6TgGCLqLQ7LfKqj797hC6CDB
	wnITh7dZQ=
X-Google-Smtp-Source: AGHT+IHlVd3spgwEiyRO7j59ZLvDRdhPmN8BBixTSaoxCJe2NnjPRKZteW1Xqj5eK0ez1AYHhO94jw==
X-Received: by 2002:a05:6402:2794:b0:62b:8046:6560 with SMTP id 4fb4d7f45d1cf-62b80466f2emr4949660a12.32.1757456688913;
        Tue, 09 Sep 2025 15:24:48 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62c0123e8fbsm2032079a12.30.2025.09.09.15.24.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 15:24:46 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6188b6f7f15so6873009a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 15:24:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXuwBXQbUtImZoI8h4GyqBPw/GXPUyxcuyDNmytWKrN5Csp5rxYztdMpK3IHptMglEjbeHK1ndbFQ22rvg=@vger.kernel.org
X-Received: by 2002:a05:6402:4412:b0:61e:a13a:27b8 with SMTP id
 4fb4d7f45d1cf-623729cb58cmr11071027a12.1.1757456686093; Tue, 09 Sep 2025
 15:24:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4ff89b72-03ff-4447-9d21-dd6a5fe1550f@app.fastmail.com> <C85C32F4-BD58-460B-ACCF-F0569ED0941A@zytor.com>
In-Reply-To: <C85C32F4-BD58-460B-ACCF-F0569ED0941A@zytor.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 9 Sep 2025 15:24:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg0bp-_kqmfaDYQLRJO30LYxEsMu3EKi65sKoi83EUZ3Q@mail.gmail.com>
X-Gm-Features: Ac12FXyoXbbHUJtrfKhAFeDlVJsB9IiUaRxuYQBQJQyqpHDKK1GQ8JtkX5zx-HA
Message-ID: <CAHk-=wg0bp-_kqmfaDYQLRJO30LYxEsMu3EKi65sKoi83EUZ3Q@mail.gmail.com>
Subject: Re: [TECH TOPIC] Reaching consensus on CONFIG_HIGHMEM phaseout
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Arnd Bergmann <arnd@arndb.de>, ksummit@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	linux-mips@vger.kernel.org, linux-mm@kvack.org, imx@lists.linux.dev, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Richard Weinberger <richard@nod.at>, 
	Lucas Stach <l.stach@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Ankur Arora <ankur.a.arora@oracle.com>, 
	David Hildenbrand <david@redhat.com>, Mike Rapoport <rppt@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Matthew Wilcox <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, Ira Weiny <ira.weiny@intel.com>, 
	Nishanth Menon <nm@ti.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
	Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
	"Chester A. Unal" <chester.a.unal@arinc9.com>, 
	Sergio Paracuellos <sergio.paracuellos@gmail.com>, Andreas Larsson <andreas@gaisler.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Sept 2025 at 14:39, H. Peter Anvin <hpa@zytor.com> wrote:
>
> 1 GB systems used highmem too, sadly. And 1 GB was the norm for a big chuck of the late 32-bit era.

Well, while on x86 1GB systems did use highmem, they'd typically not
use very much of it.

IOW, they'd have about 900MB as lowmem (ok, I think it was 896MB to be
exact), with something like 120MB highmem.

So they'd either lose a bit of memory, or they'd use the 2G:2G split.

Or - and I think this is the main point - they'd stay on old kernels
like the ancient museum pieces they are.

I'm not convinced it makes sense to have a modern kernel on a museum piece.

         Linus


Return-Path: <linux-kernel+bounces-878894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C49C21B66
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB39F4F3165
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B821723B607;
	Thu, 30 Oct 2025 18:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QzuZUXAW"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1013446CC
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 18:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761847661; cv=none; b=PgOZuevTawJwDZsitCrafStlD/eAv9uEXRxsnz0Y9kbJeqMLUHRJwUXAy/kELRm1cVJw3yMk5zpjhe9X38Ha4qPzD/cFdyiO+C9lOImdQ2fR3tQ5MOK8REO5c75xZ4ND7WfrrEaGuwNuBQyBDXjW5Ic38o3ry9gy6pW9UQs8AyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761847661; c=relaxed/simple;
	bh=o4D+KJz5KmTGP3qABZ5U9YBAhg1ZAif2VFV1CQtEzVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G8cvKAEi8uFzQe3HzkjiB6rv8lIxhPsjhKRUap7s5ECH0iAcZXXB0Tih08h5AfRA1d1f8NI7cId8lY8nsSGJatbbKmXN0a0QESuAcuZGC74Z7zbSel17nFHG3UJ/LpOOJL98/jskXflx/WOs6KrfhzzqZOHg22gnn9VgXgXZX+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QzuZUXAW; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-63c09ff13aeso2469091a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761847656; x=1762452456; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Nhvcl1yeQC/w6b6iGe+L6hfO/fybpVFfvYB2unB5MhM=;
        b=QzuZUXAWgSegJiAId1ACCaMj7AAXPP032Ew8C5rtwDusdfknrQcQ/veRhlhuZa/XIQ
         1FzbcrLcb+L/MsK5S6a89WE9/0ElVQlWBuCr2AnZ747CAWSQSChsdOeGe4rzD4In3pYl
         ReZ3TVl3+VVMz2SoRvE8E83deY3jV7mB8g/Tg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761847656; x=1762452456;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nhvcl1yeQC/w6b6iGe+L6hfO/fybpVFfvYB2unB5MhM=;
        b=WYwW+6PYRsdFN9TWAyAGT9Yhe4MGGgljkp2boY39QzROAlRFBgJkOtBWEFZ6VvBHl3
         duaqpxI8pQkxNgRDKHu1B2Dl9JXM4Bj/1t5s9LscnsDYIxmiMEaQocbpSUol8miWf6x6
         F2ui7yqpE9mbsU68UX9VZQWNrDSkfZ4QQ1k6hvnk381ZBbAWtaQ6Bn/n+s9tSILcTtSV
         gl9SHjw5wnt7UTit9RTZVsMRx/wq51bpNsL6JN7jJfQcbb3e20cJhTNxeEJUiZFRHHy0
         GiVsS0YGz2zVoS36ROqxHA4gFR4w6PcLUaFn94Qlqd6nrZiw50x0GMJzlRkEPhcQMFHG
         RWpg==
X-Forwarded-Encrypted: i=1; AJvYcCVAzt7AnoJUxyQAxb3ymdGcBJvDzraIhiSza7ccHJq+Vqppre7hQLl+gz5tTn3c3QNIFVBQDE/yPXll1Gc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq7jx0UFiG7+oizwNYA1CwNds9Bjkp5li7j2V5GilJA4QaSYmq
	Kbt0b7TVxZo4Tzs4Zc2vGK2k0MFTGhzvJZLBYdmbzqUkPPiZqcUit0OSg2UqM8TgTXua4YwWita
	7SyCsv3c=
X-Gm-Gg: ASbGncuyyfwUwD+1Ryk2bI6v754ABx7GOPiMpF5hxH4+MNuNFKTvjUtgNWDXYlethFn
	rzj6oe4GTFBqY2yzOdme+bZ4BBkQgVqP7BqEcreDizg1ITx/tziCgGQ110Z+d10rfuo1b2Gvd24
	FR2GbhwgU/rSErj7SkoJKgCOrxglAgHIlaMcx/iSOkSDdHTMSM7OsMohgEaslse5T7Ga5s2c0SY
	3pVrteNRmAiOlT6PKDrD0MVzH21kKqvJt+Z99E3kiyCabddhE24JmyuuK7ge38njNMH9FvkN9BA
	DhvD8um63z9fLSh1o9ohMs1o/YjxwbPvcW/t80tXiMQ6DO99X8o8M6V/3Nre9ypl/TWy67TdrLb
	GO3zlWuMF0Di1Zq0ioBsPTsIKCSveTNkYzhpTHsBKTXOo+Ekb3rPiCZeVFk93mr5WlepKKcEW3r
	e/0rWKfFkdpe8xs7SMijo1srV3oRyxIxwkGGBmqBLkK+UX5Mq9ig==
X-Google-Smtp-Source: AGHT+IGN/bNHHHUCc3rMJjwugsTkyG2GFtvNhWXq4NqNbTtluQkdiJCwozwBsMOFuymboF/DhnEh4g==
X-Received: by 2002:a05:6402:a0c1:b0:63c:1e95:dd4c with SMTP id 4fb4d7f45d1cf-6407702dc92mr344966a12.27.1761847656326;
        Thu, 30 Oct 2025 11:07:36 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7ef6c13fsm15300063a12.7.2025.10.30.11.07.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 11:07:35 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b704db3686cso304644666b.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:07:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU/HsMVvxSP8fzrnqJizpouk6LkhpkEyhv8W//vszOwFitbhtygjQomGbKYGiS3ffFpBm30q4SEkvVwWrE=@vger.kernel.org
X-Received: by 2002:a17:907:26c3:b0:b30:c9d5:3adc with SMTP id
 a640c23a62f3a-b7070627703mr42634166b.49.1761847654683; Thu, 30 Oct 2025
 11:07:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030105242.801528-1-mjguzik@gmail.com> <CAHk-=wj5o+BPgrUNase4tOuzbBMmiqyiYO9apO9Ou-M_M1-tKQ@mail.gmail.com>
 <CAGudoHG_WYnoqAYgN2P5LcjyT6r-vORgeAG2EHbHoH+A-PvDUA@mail.gmail.com>
In-Reply-To: <CAGudoHG_WYnoqAYgN2P5LcjyT6r-vORgeAG2EHbHoH+A-PvDUA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 30 Oct 2025 11:07:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgGFUAPb7z5RzUq=jxRh2PO7yApd9ujMnC5OwXa-_e3Qw@mail.gmail.com>
X-Gm-Features: AWmQ_bk0nXdmIZ3ZdZHzO6SbRe1SK66BYaV56nliMUq6zTKWnVQoJraIlMoRIYg
Message-ID: <CAHk-=wgGFUAPb7z5RzUq=jxRh2PO7yApd9ujMnC5OwXa-_e3Qw@mail.gmail.com>
Subject: Re: [PATCH v4] fs: hide names_cachep behind runtime access machinery
To: Mateusz Guzik <mjguzik@gmail.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, pfalcato@suse.de
Content-Type: multipart/mixed; boundary="0000000000009b66050642641f04"

--0000000000009b66050642641f04
Content-Type: text/plain; charset="UTF-8"

[ Adding Thomas, because he's been working on our x86 uaccess code,
and I actually think we get this all wrong for access_ok() etc ]

On Thu, 30 Oct 2025 at 09:35, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> I don't know if you are suggesting to make the entire thing fail to
> compile if included for a module, or to transparently convert
> runtime-optimized access into plain access.
>
> I presume the former.

I think *including* it should be ok, because we have things like
<asm/uaccess.h> - or your addition to <linux/fs.h> - that use it for
core functionality that is then not supported for module use.

Yeah, in a perfect world we'd have those things only in "internal"
headers and people couldn't include them even by mistake, but that
ends up being a pain.

So I don't think your

+#ifdef MODULE
+#error "this functionality is not available for modules"
+#endif

model works, because I think it might be too painful to fix (but hey,
maybe I'm wrong).

I was thinking more along the lines of forcing linker errors or
something like that.

ENTIRELY UNTESTED PATCH attached - may not compile at all, but
something like this *might* work to show when a module uses the
runtime_const infrastructure.

And I think I should have made the default runtime const value
something small. But the original use of this was just the dcache
code, and that used it purely as a pointer, so a non-fixed-up address
would cause a nice clean oops. Then I started using it for the user
access limit, and now it's actually wrong if used by modules.

Thanks for making me think about this. I thought about the module case
*originally*, but then with some of the expanded use I definitely did
not.

               Linus

--0000000000009b66050642641f04
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_mhdqhvpo0>
X-Attachment-Id: f_mhdqhvpo0

IGFyY2gveDg2L2luY2x1ZGUvYXNtL3J1bnRpbWUtY29uc3QuaCB8IDEzICsrKysrKysrKysrKy0K
IDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0t
Z2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vcnVudGltZS1jb25zdC5oIGIvYXJjaC94ODYvaW5j
bHVkZS9hc20vcnVudGltZS1jb25zdC5oCmluZGV4IDhkOTgzY2ZkMDZlYS4uMDFlMzU5OTc1ODdk
IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9ydW50aW1lLWNvbnN0LmgKKysrIGIv
YXJjaC94ODYvaW5jbHVkZS9hc20vcnVudGltZS1jb25zdC5oCkBAIC0yLDcgKzIsMTggQEAKICNp
Zm5kZWYgX0FTTV9SVU5USU1FX0NPTlNUX0gKICNkZWZpbmUgX0FTTV9SVU5USU1FX0NPTlNUX0gK
IAotI2lmZGVmIF9fQVNTRU1CTFlfXworI2lmZGVmIE1PRFVMRQorCisvKgorICogTm9uZSBvZiB0
aGlzIGlzIGF2YWlsYWJsZSB0byBtb2R1bGVzLCBzbyB3ZSBmb3JjZSBsaW5rIGVycm9ycworICog
aWYgcGVvcGxlIHRyeSB0byB1c2UgaXQKKyAqLworZXh0ZXJuIHVuc2lnbmVkIGxvbmcgbm9fcnVu
dGltZV9jb25zdDsKKyNkZWZpbmUgcnVudGltZV9jb25zdF9wdHIoc3ltKSAoKHR5cGVvZihzeW0p
KW5vX3J1bnRpbWVfY29uc3QpCisjZGVmaW5lIHJ1bnRpbWVfY29uc3Rfc2hpZnRfcmlnaHRfMzIo
dmFsLCBzeW0pICgodTMyKW5vX3J1bnRpbWVfY29uc3QpCisjZGVmaW5lIHJ1bnRpbWVfY29uc3Rf
aW5pdCh0eXBlLHN5bSkgZG8geyBub19ydW50aW1lX2NvbnN0PTE7IH0gd2hpbGUgKDApCisKKyNl
bGlmIGRlZmluZWQoX19BU1NFTUJMWV9fKQogCiAubWFjcm8gUlVOVElNRV9DT05TVF9QVFIgc3lt
IHJlZwogCW1vdnEJJDB4MDEyMzQ1Njc4OWFiY2RlZiwgJVxyZWcK
--0000000000009b66050642641f04--


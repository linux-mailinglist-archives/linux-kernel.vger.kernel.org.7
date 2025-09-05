Return-Path: <linux-kernel+bounces-803521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC46B461CC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 20:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 948244E4527
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5646E31C566;
	Fri,  5 Sep 2025 18:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWJNDUTx"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB5A31C561
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 18:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757095732; cv=none; b=haSDJVeNsJyng1RBerQukGf2wk+LowMoJhOA0fKBjVJlgOZhtpSfVpIZQ4EvXrjfwwuNuoMf74ncllGL/2by7k9A4Ga0TADeFJkXAj9oMZTElez9L74eJ5zmUn970wiNRobEzoMf/euLyEPVcE8F8f/A/oASj69Hc08ByVoGYjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757095732; c=relaxed/simple;
	bh=iGdnI/KfWDDu00FpGfqLB2W/2CyE6C3w8An1H9pjQWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rwmO1NaVUhjxA2a9mSEb5VzNrhUSLM9OEccG8+tYIVVmbXUT0kET5pvjdj5Ud00lP2uRhQpr/fZejq3dgMdVLdHLpcFM+WmbbmvFNNjenW7pYMsN0oWFPTZFVNosw15r07LBgNIcwgQia+f0dpmj8oHlG48ouetcZ5pSXXMP7Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWJNDUTx; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3df3be0e098so1324912f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 11:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757095729; x=1757700529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iGdnI/KfWDDu00FpGfqLB2W/2CyE6C3w8An1H9pjQWM=;
        b=AWJNDUTx1rc6Op03fCL2hNfjshR/cZToG1bzaooFX8w5e09anK3CKZy1Nfepr76WLb
         2ea5uDyOPCP0x585/EV7cedqvrcuIdMXMI5BpQUo1xlsZ5tOq9+Tk+2EO9dsLnm6pN/g
         FUMaYHZR4z7R1HMcvjJXEYoTnjmWSM78+XymGi8EImYFLl1YbKg/qJEIGdJ8cMPfo7T9
         GM7+EWe5nc0xIX9heELGxK+9qs6q6O7Uyg9LJfDsjjJvwk/MSzzHJ6cGEamWTZxsUt50
         UsmFfugvkvleiyl5pcOdxN0NfVQUab1uNqhas08kJ6Qpo1TUACNiwGLXcciUnnNIwkpy
         Jhsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757095729; x=1757700529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iGdnI/KfWDDu00FpGfqLB2W/2CyE6C3w8An1H9pjQWM=;
        b=QcDieNON8RGjr0d6wLvpo3cGSxxCj5KHl6XbSsdbFtyhg2H3FMgY8RSNSGwhRDCZBD
         QnTVduvBhtB5K5gf+S1q1iH5Fof2jjYI+iP/QdloTnHx7D94+gHk+pQGtg1mFB67vJdp
         xxye04luA5HstIA5j6uQ1KMkv1CYk0pv6h0f9oP1/ZmLfta9jKCOEasikC1fGBt8EcK9
         2QToTkPwjEAb2qOTp0rj4H+jCRKgeRMdfA8VNSCLThOfrCAVEWCfVL6Os1Lry8BjiL9c
         IB3/bcy5lG5RcWAgnObfMDefhK2CaqLggInVcbwDQXAXJQwDjSMBxbQDQrVEFQoG7aeG
         M4NQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+YJ5brX+2I/yC2x+sJSvezZgiwjc0s3rPUBFGODltCwyqUk3inrmg2rUNBwlZRx45FZmddIB/xNe/Hhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoSs+lzSiMFtdBEvbT7Ggy4N3zZVBBVkELUheww058rjaWtb7i
	sOfrGIY3v0/8pTru2pxcD3PW+hGfrPB/WgcrNmJBBBECHOXJFhpdgibqsbLjFvBIAbt9NTl7sB2
	3brT+9iA2L60S4xzArszj8DFb6L0XIYs=
X-Gm-Gg: ASbGncuVCM+XhsKKjlLHeN6BJEJy38rIK8k8QUFD38DvywYImai4FX1DtMsVMbX0TJ1
	P2WwTM+Pm4Ucn3RxThp/fgJSbVflBf0WAisTdGvwhRA43AZbRJH08/WMirZid0oNb7EkdcnUr7W
	4zqTDsZ3Fl45E4nyR5q5cRKDCn6W0O+NwXx6jC/GdLSSsTMURILjgxJWAQS4Cqrqg5uLQVFWH9m
	A1o3cL8V42pCRp+ng==
X-Google-Smtp-Source: AGHT+IFERVcRo3NEqVJraCj4UK8XqQK1l3sZQfzYHrDnZAXUKAj3OQJ2L1gNLfVRJ4WTCNxbt7GRroTNPcmh78bqpuE=
X-Received: by 2002:a05:6000:18a8:b0:3d9:7021:fff0 with SMTP id
 ffacd0b85a97d-3d970220156mr11837479f8f.37.1757095729307; Fri, 05 Sep 2025
 11:08:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820053459.164825-1-bhe@redhat.com> <CA+fCnZdfv+D7sfRtWgbbFAmWExggzC2by8sDaK7hXfTS7viY8w@mail.gmail.com>
 <aLlJtTeNMdtZAA9B@MiWiFi-R3L-srv> <CA+fCnZf2fGTQ6PpoKxDqkOtwcdwyPYx2cFwQw+3xAjOVxjoh6w@mail.gmail.com>
 <75a2eb31-3636-44d4-b2c9-3a24646499a4@gmail.com>
In-Reply-To: <75a2eb31-3636-44d4-b2c9-3a24646499a4@gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Fri, 5 Sep 2025 20:08:36 +0200
X-Gm-Features: Ac12FXwl8rdmcy6KM72QT5kbnXVskzKHCQ5SWTQj8L2OmEz2lTLzNNXRX0uI6YQ
Message-ID: <CA+fCnZdWxWD99t9yhmB90VPefi3Gohn8Peo6=cxrvw8Zdz+3qQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] mm/kasan: make kasan=on|off work for all three modes
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Baoquan He <bhe@redhat.com>, snovitoll@gmail.com, glider@google.com, 
	dvyukov@google.com, elver@google.com, linux-mm@kvack.org, 
	vincenzo.frascino@arm.com, akpm@linux-foundation.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, sj@kernel.org, lorenzo.stoakes@oracle.com, 
	christophe.leroy@csgroup.eu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 7:12=E2=80=AFPM Andrey Ryabinin <ryabinin.a.a@gmail.=
com> wrote:
>
> > But have you tried running kasan=3Doff + CONFIG_KASAN_STACK=3Dy +
> > CONFIG_VMAP_STACK=3Dy (+ CONFIG_KASAN_VMALLOC=3Dy)? I would expect this
> > should causes crashes, as the early shadow is mapped as read-only and
> > the inline stack instrumentation will try writing into it (or do the
> > writes into the early shadow somehow get ignored?..).
> >
>
> It's not read-only, otherwise we would crash very early before full shado=
w
> setup and won't be able to boot at all. So writes still happen, and shado=
w
> checked, but reports are disabled.

Hm, I thought it worked like that, but then what threw me off just now
was seeing that zero_pte_populate()->pte_wrprotect() (on arm64) resets
the PTE_WRITE bit and sets the PTE_RDONLY bit. So I thought the
kasan_early_shadow_page is marked as read-only and then the
instrumentation is disabled for all early code that might write into
the page before the proper shadow is set up. Or am I reading this
bit-setting code wrong?


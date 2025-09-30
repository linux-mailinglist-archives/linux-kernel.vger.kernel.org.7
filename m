Return-Path: <linux-kernel+bounces-838027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F151BAE422
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 19:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FE48173D5A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8CA26D4C1;
	Tue, 30 Sep 2025 17:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Af7a0oos"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDF526B75F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 17:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759255137; cv=none; b=rgXlosKEOAgnjhFQIvKrdcb7cNJvbujdTCwwJ67Oyo6WZA14U9X4I1ax/NxfeIVQU53R9MZ4gYMelRzFjxPCGuzLLOihhorjgHCVF/LSvPLmnO8QY/0934s9I7+3LDgC7MPgX5Dff+0hhhsv96MdTHUobBnqGF0opKPfG/0NxP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759255137; c=relaxed/simple;
	bh=Nejn7Jw0qE+Kkdg0YSBfXxO/oPYC6wySV3pVzrR08nc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nPQS7oC4NgnIsOFrsR9Oaa34yf4razrtDDdWJg9L14a2WS3juzs+bAmZreotffLU5qVU1QRdoekNwVcTBTSC70O/66xXHKqP/8NyFt21Suh6nNrWmrenTz5/He/0Bp0lEVMpq3MZ/XWm8FhmmBDHHe32MD/AWMeBUTBJq0AGqSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Af7a0oos; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759255133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F8cF4VzuVf+MX0Y5TLwWhlMcsr0VxyJ6vPdjbuar+xI=;
	b=Af7a0oos1cNQqnSoBPjy6BJIbfaIqPqj4dRznlnfUXt3VA4ITYEAgwH1AThkytQZUI/p34
	sMvLewXLI5rRWt/RSt/R4KuuozVKuU/o95sT27zBytn65E/feXj1DF/rfBd8y5Qx08ExKB
	0AwC0XixIX7uBumkTcP2ZTD9vQInyoY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-WX0uj0ihNWeoQiCk7BZbhg-1; Tue, 30 Sep 2025 13:58:52 -0400
X-MC-Unique: WX0uj0ihNWeoQiCk7BZbhg-1
X-Mimecast-MFC-AGG-ID: WX0uj0ihNWeoQiCk7BZbhg_1759255130
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e35baddc1so39231615e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 10:58:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759255130; x=1759859930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F8cF4VzuVf+MX0Y5TLwWhlMcsr0VxyJ6vPdjbuar+xI=;
        b=TWf/sbPxERn3yr6Plw2JtgoZJwd7Ij75Q9oISN/mV5SUOSk2Bc+wbllVeR29lXP3bG
         4Wm4TQ6W1oyppVpig2FyQPaAT0VyMylhjzAS0f+5fxzpfGO0HrddhVsEZi5WAhLLmrwx
         rlRGR5h/h+uOSLNbmLC/JzPfzEcI7Gb+IC7Mj0YnDIuNjumwIEXgEcg2nWcBN1PUDUxd
         CkCOkX7C7YJ87VWcJxKCUmFpIOp5yuc1MBa6Grf1PllNRX9TDvRhJhQN5f4mew173MJ5
         TlgAyIMlA1ObD+WJIkKcmS2b/ehUl4BLw9DZK65cHIx/jX1AynfW4d9QU+/qSHG5xqF8
         RrCA==
X-Forwarded-Encrypted: i=1; AJvYcCXVF6z1kNJ+FNEUxuxjRuAL0uX383/IblRXrmndOftVUZrzSWiNaQ3wkCd92LV/rnSB4LS3/pjpS47bwZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHN4W7c2G60x6PMjyBuYePT3gNNmD2TBQXinPFu/fabXj92qUU
	qVIfXlvkvZ0VHzBvq9h16ACgjpllRa1if2bx3FuLGswKVAPsPjoB2FpIFG4bBONP+i6DqDD9k8w
	Of+J2gHwL7WuooTb/kGVzS4tKtxnyHDFO7+C6CY17PsZkA8JAhM5hnuBAdPFfxhZ8hI/X9HFy/S
	xIVAdOD8AL7FBVUO72mzJDWZUA5a9C9ljlHPkJtkndPAMIwFZJgaM=
X-Gm-Gg: ASbGncv/CbcesN8cNr5g/oQ4hMpkjVLit4JG+PM7XRp3Wt9mUc9FgTe97RRmVQGUmm4
	XK9FFcQesKGkXc9GMz/L8r5+o5axrpxVfGwVTZFBLupEO/eAjuwlIKIRA9AJHumxw0LUkB4KGMt
	v41M2IHijBXWNEq22paJM4zHmXBHIN6Od5HCI7qMa/5itD2VOeibDdmarUKww8hinHrF+hl4WiQ
	rspbFNZ3tpShOihhKVNlMgHnPZZOWpM
X-Received: by 2002:a05:600c:5303:b0:46e:4287:a85e with SMTP id 5b1f17b1804b1-46e612192ecmr6607335e9.13.1759255129650;
        Tue, 30 Sep 2025 10:58:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGX2ydmCLO7e7qdwMiaI77CR0x1R/qx+ietFiVLOLU40Tb+lvt9g/R/AsWRQlZ5JMQ4XFB+rlRpfSE5Yr1lgI=
X-Received: by 2002:a05:600c:5303:b0:46e:4287:a85e with SMTP id
 5b1f17b1804b1-46e612192ecmr6607135e9.13.1759255129262; Tue, 30 Sep 2025
 10:58:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924081305.3068787-1-chenhuacai@loongson.cn> <CABgObfZvdkAR6YGx7HKT+aVaE06w=FG7Jus=3B6nxadDiv5c_Q@mail.gmail.com>
In-Reply-To: <CABgObfZvdkAR6YGx7HKT+aVaE06w=FG7Jus=3B6nxadDiv5c_Q@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 30 Sep 2025 19:58:37 +0200
X-Gm-Features: AS18NWCD5Cu1BM-gCbaA5ScKHErZkLAW39Qw6t4H90yeM5txDIxnZuzOmIqqkbo
Message-ID: <CABgObfaPEMTGYSSZp_5S8J67+=GdkxmwNuRMHVfV37iCQex7bg@mail.gmail.com>
Subject: Re: [GIT PULL] LoongArch KVM changes for v6.18
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 7:16=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> On Wed, Sep 24, 2025 at 10:15=E2=80=AFAM Huacai Chen <chenhuacai@loongson=
.cn> wrote:
> >
> > The following changes since commit 07e27ad16399afcd693be20211b0dfae63e0=
615f:
> >
> >   Linux 6.17-rc7 (2025-09-21 15:08:52 -0700)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongs=
on.git tags/loongarch-kvm-6.18
> >
> > for you to fetch changes up to 66e2d96b1c5875122bfb94239989d832ccf51477=
:
> >
> >   LoongArch: KVM: Move kvm_iocsr tracepoint out of generic code (2025-0=
9-23 23:37:26 +0800)
>
> Pulled, thanks.

Forgot to mention, please pick one between chenhuacai@loongson.cn and
chenhuacai@kernel.org and use it for both the committer and the
Signed-off-by line. :)

Paolo



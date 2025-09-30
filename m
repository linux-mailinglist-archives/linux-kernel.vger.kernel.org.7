Return-Path: <linux-kernel+bounces-837998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C253BAE326
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 19:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 998801896E9A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608AB25B302;
	Tue, 30 Sep 2025 17:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dFiyTxjo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E091E9B1A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 17:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759253620; cv=none; b=UDeZHZ0iwcK2jgkmuFj1OwAfY//4pGhvfPDy71/hX/hxGRjTtAQGHlBR7G8yrqbekSPpdoPK1KqCqPg3BK11kHXUbp7oFanJ9Ps0u7g0GGhiD4wx4BFhTiHyB/d5Io5XrBbz2F2gNGCsC4kaLrS5/WvEjCJH4KwXxurKwMWA3/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759253620; c=relaxed/simple;
	bh=/uzHTZRlmfTXfkbDbdCgwivf0VeFrYx3UT6Fycy7EKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eFQw03p/5SYOHoBI2iLH5DYwlTsskwY1qABu92njsGoHo4ClKiDo699+dXRUqPgnh9zEMOC0iRqnEzt/fpkVj1M74iDE7sEhZ21hf1JhgmfgwZ3uTDtmfm2S+2NcBpWSY29iaUspixR1YrLPuy1gErbcxAsqqvU5f6sgreQFN/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dFiyTxjo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759253618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DVdC9fzy8g2U07P39DvGMyerTR2hUiEGZN4FGElHXu8=;
	b=dFiyTxjoqWwObaRezi4Fbsc9Fv+wP37RR0ufgLqpJtc1c/WqhKbf53cplHAzS32jd1eX+9
	JZNEEK5XOsXemNAWU+oYx4mAIHBFTVpEyRr8e8Ja858pecQW5/aJJ4JeOswm41zpN0UBmf
	uhxSu+3vm3QZQB9r3SRKwn3XldeyrYo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-7dJGic4lOPSg33sHuF_5yg-1; Tue, 30 Sep 2025 13:33:36 -0400
X-MC-Unique: 7dJGic4lOPSg33sHuF_5yg-1
X-Mimecast-MFC-AGG-ID: 7dJGic4lOPSg33sHuF_5yg_1759253615
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3f6b44ab789so3637743f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 10:33:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759253615; x=1759858415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DVdC9fzy8g2U07P39DvGMyerTR2hUiEGZN4FGElHXu8=;
        b=wvsR85Bh6PzHSZB9QvHLih0qQfmmtLAVnI2ZTzUj5wW28zLgDER32o4s7ieWsVc3o/
         zzomtXGij7ekH89vAUU/4C5BKtPg+/Xa62vNCHn7q6vjCCzvkOwFkfKmNDqdBaIn/WZ6
         1A+7EH0WREV3X3ahbGwpyNbG88LART6pE50H1WBP5JyqYaro5V0DvxzGHtmlhTFhCf7x
         MY2qDS/z1KNMVJ04MehpwbVfUDCQsrlwV3dtqzpVZJ4U1zpaoprVhelH4d8C36MqJAG7
         VcoNNdrwiCQEODB5OIh7WVCWkH6vZa9d4HRW4lfvm+Yxl8tWXBDufPjFofV2mguMgK7W
         7CiA==
X-Forwarded-Encrypted: i=1; AJvYcCU27/F5She6pFZkWswe6smXjGUaX1HG++S88tsde3xMlk1OouLea4oWZ+2KA7R3iFTZoB7pPIK7+9HYLkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyspXShQ2Ima4eYZ+rEYpgUo4LuYRgUtMCG5GCa97z+yEt/r8AL
	VPJk5mJIvvT5cPZqE40s2IimDvDwADvoHKG6NpfeS8sBJLZxaNyxKNz5GvCR/rrPddyzjxkhx4r
	l4YTI7Ok/38vAAGLaR2h/EA7qdDd2eM4+BRLpWiYkJvaIuBUD/sfKVPfbKox/Is41j66yzSRYC5
	tcWnLl4WTvPlwwWJ9iM+GhM1zuu1ZRwfN4VP0Ts5Zz
X-Gm-Gg: ASbGncvmjdLODadcFn0fmyyGvIBvp6gS9X0zlV++Z+D0ba+INHWoebp7G6AbRDhJGua
	BORD/xIfyMEySF1VHJneczCGXxPt566kFXx/eXCI89RwHLFP+tQPsmqX4NaEyT1V0MAtyXx8E1V
	LeS2aPoqbjmcwPVA2oh5UMiAgtmFqqbz9lh13oaXzeNjclplbNdUANF/SMQ2m/kqd7pAdwMYROZ
	TcYUT4dbXwb5yip2bU/z3djCRL1VH/G
X-Received: by 2002:a05:6000:420a:b0:3ee:15d5:614f with SMTP id ffacd0b85a97d-4255781b050mr453891f8f.46.1759253615167;
        Tue, 30 Sep 2025 10:33:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPEGl7i1wI3zGz8Gl0JlNQlV381u6TWCOx0x5yH96A4cHnQkC4YdjEEJwapOyYbkd/ZvX3EIxM60w4sr5oFVo=
X-Received: by 2002:a05:6000:420a:b0:3ee:15d5:614f with SMTP id
 ffacd0b85a97d-4255781b050mr453874f8f.46.1759253614771; Tue, 30 Sep 2025
 10:33:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250927060910.2933942-1-seanjc@google.com> <20250927060910.2933942-6-seanjc@google.com>
In-Reply-To: <20250927060910.2933942-6-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 30 Sep 2025 19:33:22 +0200
X-Gm-Features: AS18NWBYZvWeclECRyRctpt0s36DZsWKpQ0aMUf6N3yHtD8DPtsunh5xRdz3dz4
Message-ID: <CABgObfbOSffjFPgpOe1TQ8XJNYD907Ufa-YQN7C--9dREkFw2w@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86: VMX changes for 6.18
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 27, 2025 at 8:09=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Fix a TDX bug detected by Smatch where KVM would return '0' on failure, d=
o a
> bit of early prep for FRED virtualization, and tidy up.
>
> The following changes since commit c17b750b3ad9f45f2b6f7e6f7f4679844244f0=
b9:
>
>   Linux 6.17-rc2 (2025-08-17 15:22:10 -0700)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-x86/linux.git tags/kvm-x86-vmx-6.18
>
> for you to fetch changes up to 510c47f165f0c1f0b57329a30a9a797795519831:
>
>   KVM: TDX: Fix uninitialized error code for __tdx_bringup() (2025-09-19 =
15:25:34 -0700)

Pulled, thanks.

Paolo

> ----------------------------------------------------------------
> KVM VMX changes for 6.18
>
>  - Add read/write helpers for MSRs that need to be accessed with preempti=
on
>    disable to prepare for virtualizing FRED RSP0.
>
>  - Fix a bug where KVM would return 0/success from __tdx_bringup() on err=
or,
>    i.e. where KVM would load with enable_tdx=3Dtrue despite TDX not being=
 usable.
>
>  - Minor cleanups.
>
> ----------------------------------------------------------------
> Qianfeng Rong (1):
>       KVM: TDX: Remove redundant __GFP_ZERO
>
> Sean Christopherson (1):
>       KVM: VMX: Add host MSR read/write helpers to consolidate preemption=
 handling
>
> Tony Lindgren (1):
>       KVM: TDX: Fix uninitialized error code for __tdx_bringup()
>
> Xin Li (1):
>       KVM: VMX: Fix an indentation
>
>  arch/x86/kvm/vmx/tdx.c | 12 ++++--------
>  arch/x86/kvm/vmx/vmx.c | 37 ++++++++++++++++++++++++++-----------
>  2 files changed, 30 insertions(+), 19 deletions(-)
>



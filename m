Return-Path: <linux-kernel+bounces-802157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FD2B44E46
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 08:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAA9F17E186
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 06:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9972D2490;
	Fri,  5 Sep 2025 06:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="OlbAFEVm"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9692C3770
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 06:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757055120; cv=none; b=EQdvH+1NHcIEjnuK123giWFrO1kaNegEIOkQXu7ht5zS8aT6L3twl/tKuNiiXoknCJD93ijnrONpJ/lIKyJk82RLw5R+LFTNzswQ+I1SF6+zFcHEuZ6vdHYn0LuYkemMpXGtxFm9Xhad5zwgSQwq12qZHImCbo2GNB3cL8JFeus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757055120; c=relaxed/simple;
	bh=DaOHBz3Vp86bsV/wqEUhViNPWlyVfnJ/beJ1Xp5QxAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HlmEkWz+o9rif81hb0u+/DMWNZCosxTis84LOIKsRs/YNFMWEoHr+ph2LnZ4lJ7dsE6plPBckM6YUQR3BhO+TjNViGcYeFJ3bbTZNaHNTi8yuWEFgA6WthcyNgt3cRUh9Q8SAOioaSUsv2U3YVbIkLQNheghlYRyBYsY3pXstoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=OlbAFEVm; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3f0fcd81068so13506205ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 23:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1757055118; x=1757659918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4nDTd5Gv36YNMyq5Qhnn8xJEK9lVHzvftyFkSysDc/4=;
        b=OlbAFEVmU5dnqNJzUnvocJUJH1fIAVCjYx6awQaowJXgrGDDJf1u6/d2qo1qEeSCz/
         PvyL+XrJ50KclY3zPkyaIf61uLvXky9vi7fLwMvDBErRF2NnVO59QnDn1LVSyL8MSTJG
         00l4dYxuYJYuMPa9tI3pOk1b9G+rM2N578imvUt92lTpRVOaAcq0bvfMl+I5NpYktL/B
         3q4gepybSzfip+/ybsJHWyk03qur7JpHK8nNkwZ/fuI1+U6wDEfu3SaI83qgO3XICML3
         JvTVAYWwuCYi0/yBmXZQ0FVLzI0aiT/GVmJk5DJ38N5V6GE9NDuHAg85pUgOz23u/MVx
         c3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757055118; x=1757659918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4nDTd5Gv36YNMyq5Qhnn8xJEK9lVHzvftyFkSysDc/4=;
        b=KHdwwhyUP0beW0momZ736+Nt0DWl1fD93fOkRGltP/FabJ0EItEAEZJr6PnjQzBwWa
         s9N7MvIBZgHGJr5uIWoJ7thFOuD7+4vd08tcIy6z4rJEM9562vnD1+AKfwIkQH85h/+M
         dlZav67RLe/u/7VtCJ9sWEMRVDgocKLPl/YZ7ExPPdLfwpx0AMO24g8hmoqx06/lBYxS
         ddjH28mrSKyvhiEKk0BpRlHtgneKApZgUYW53/drolacXDRnNbekNspvVCbTT9j52QqC
         yH4AV06tzZJdDm615PQDcp+wnIlM+fpc/YZ8I/TA3HtRCUHUnbkYXbKz1dzT4uMe7tPR
         4yyg==
X-Forwarded-Encrypted: i=1; AJvYcCVSoseSseVJHlgM/0GtquMb6Qg0OYzHHGe4M+4Hkr1moAGNy3j8+byVdArUrnZZGJHNakgG2cToVzOOnAE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywto/qSvm/t36g45GV4IjJmOtw8kwMa+JHfBs4pyn9olTfcokX1
	f614g6AqF8DvbEGNKSnEwOIfEBgBwTi3T75pK5kl12GjZSm/ukSLTC/+Fw7cErOWy+WNijp+S6G
	FdTGVBJg6ckq42hx6Jyq3U9Av/PaYqlmctRWSmINgbg==
X-Gm-Gg: ASbGnctY5TQdXOHCYIyNI57cwN3HS8D8hJf7vQ/ISjDtuB9it0p7k6Hhb0xC1y5L6nW
	KhCEGLXcHXq5RAmREX4ZU4W4KFCe2E/8OE2Sux5vWQdLJYsUGLhZHXmNOZOnvBFLFEo5zCL27z7
	Ubhwk0dOR2vF9Qf9njD5FBiKva+vnqn+AfOw/7lhLBOfAUtEYPx894d1Bl3l0hwFfSV7oucbC71
	zmKwsMqNQvOTNiloV5gZLfCOIACDv/EeXBQk7QoqVPxfbHA0fXUNU5Cui57xw==
X-Google-Smtp-Source: AGHT+IFqhsp8QkbEH2AYxxy6aZR2+3njRKvf1EkNjHXrSfDyXXsLjXgWGyrgUdjW9lEocsZBNm6jnwrKVQArR5mwmho=
X-Received: by 2002:a05:6e02:4616:b0:3f6:554f:f83e with SMTP id
 e9e14a558f8ab-3f6554ff9d2mr206848225ab.18.1757055117887; Thu, 04 Sep 2025
 23:51:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821142542.2472079-1-guoren@kernel.org>
In-Reply-To: <20250821142542.2472079-1-guoren@kernel.org>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 5 Sep 2025 12:21:46 +0530
X-Gm-Features: Ac12FXzs-ev06L7BPaxBsQRN2id94q1V5j-qhNEmATN7a2fxkATv2aO3WzvlWf0
Message-ID: <CAAhSdy35BTE8YwxKb+1YwE3eHDfRytt71fU4014zYjwyXYn5qw@mail.gmail.com>
Subject: Re: [PATCH V4 RESEND 0/3] Fixup & optimize hgatp mode & vmid detect functions
To: guoren@kernel.org
Cc: troy.mitchell@linux.dev, alex@ghiti.fr, aou@eecs.berkeley.edu, 
	atish.patra@linux.dev, fangyu.yu@linux.alibaba.com, guoren@linux.alibaba.com, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	palmer@dabbelt.com, paul.walmsley@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 7:56=E2=80=AFPM <guoren@kernel.org> wrote:
>
> From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>
>
> Here are serval fixup & optmizitions for hgatp detect according
> to the RISC-V Privileged Architecture Spec.
>
> ---
> Changes in v4:
>  - Involve ("RISC-V: KVM: Prevent HGATP_MODE_BARE passed"), which
>    explain why gstage_mode_detect needs reset HGATP to zero.
>  - RESEND for wrong mailing thread.
>
> Changes in v3:
>  - Add "Fixes" tag.
>  - Involve("RISC-V: KVM: Remove unnecessary HGATP csr_read"), which
>    depends on patch 1.
>
> Changes in v2:
>  - Fixed build error since kvm_riscv_gstage_mode() has been modified.
> ---
>
> Fangyu Yu (1):
>   RISC-V: KVM: Write hgatp register with valid mode bits
>
> Guo Ren (Alibaba DAMO Academy) (2):
>   RISC-V: KVM: Remove unnecessary HGATP csr_read
>   RISC-V: KVM: Prevent HGATP_MODE_BARE passed
>
>  arch/riscv/kvm/gstage.c | 27 ++++++++++++++++++++++++---
>  arch/riscv/kvm/main.c   | 35 +++++++++++++++++------------------
>  arch/riscv/kvm/vmid.c   |  8 +++-----
>  3 files changed, 44 insertions(+), 26 deletions(-)
>
> --
> 2.40.1
>

Queued this series for Linux-6.18

Regards,
Anup


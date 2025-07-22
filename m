Return-Path: <linux-kernel+bounces-741018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CA4B0DEF2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03E75582411
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9742EA752;
	Tue, 22 Jul 2025 14:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s5v6arL6"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C27245012
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 14:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753194860; cv=none; b=fjgbbLfTL57zzlHFmaRqSIbZKEejFQBGSRjmqRBDYnyw0DeJJ6M26+yxhzgV/EzToDOZU7FbFLV9ga3/0Zji4vyHrYT652X2NAq0tU/KmBSB+4hxEd7u00w5+ir6XUUnkDvPwRmhfxcKJvSikjIMo3RnfGiozjyOfkkoYdX3iu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753194860; c=relaxed/simple;
	bh=tTaaoCIOiIiKq0geWq6x9SoXkVZFzNZhOavzs9Ddr2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JbnitUOWc0OBLCqONE2I3sJhZZX7hAATkzxgsJLMKZGjZ5Ujuz58tfEF+hB1F5/DjbLiJVNHBkn3P+24O5SrDOx2yc69Ku0aJ/vwdWirw98rSlv7PuzccRnXYfjShs0+6xYbQU1k0WUV/0ShgZ+XTOXz6mHSDaRMCzwl+1EeLGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s5v6arL6; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2357c61cda7so125625ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753194858; x=1753799658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTuXuP+3bZghdz+mkEOJA+9pHpr2ihbN2H3rGh74pds=;
        b=s5v6arL6EvWT3Z4BNQsMDHyQaJVcSFKr/DeoYANdZUwKSz7g7cHe3yr+6jAaBros+C
         Zi7/JFt4DVzUZLDXFASICFLt/zOkdlkF87NOnKWUIttrrALOhfX3MfxaEEXs4JSP4yHR
         JIO7j/5fsJeFEeUaaKJ2KSsckTys2DUrkLJs1QbuK0y3K74XO7IsoL/GShIaPn9lSZeB
         1Myp7BimhBu3Geiu4A35mAXMyPH3uRIXMSkCgLhNmRxz4ILmJHHV80xL28cqqJautJs2
         aUR4xajW9BCnZYKd926oX5K2cbSCu9hCenS6AUTRO3tk+ZOkbkmV3vIHQXj18TjznmHh
         CS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753194858; x=1753799658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cTuXuP+3bZghdz+mkEOJA+9pHpr2ihbN2H3rGh74pds=;
        b=j8/OlVdbkB7POvq+emdDWbijvwUE5M/4nVJocwrffw/cXSb6cNfOpFG0wsolx5qfb1
         rO+dRsAmqip7MrIs/27zDIPuU0TdztEnt4hKMZqAC+TH9dIkjAIhcnUPT75JNB/3XgmJ
         Dfmqgj6CWffJYTaWG/ljbAjdRJ3hw/yqS8f/lYA0poGQ+8o/toTVs8rbetiCfzoA9xg6
         5G23w0WmgOrM/js/eABVYFsGNWrOnCDitk1t0HRR7cgwQ1u/1497i/T4iUJrPstSZcDN
         L2xqwn/5sP/x1IQxWpVYczKmIWAn2Ywj4+gAz2oLMMJ1hHh7sqj2zjKbTlNRbH1vMyS+
         /W/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWM5PKBjaW8sIIrjaZlmVUsRz94eNOG1zYlhgOsmpLlFL9A1+8Tpt526xa3BhgaN/dWU+mQK0Ad7dBXVk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzExZ6OJLneeE3HVVbKtRfDiwPvVUHPPcmgOFvWmFsc+NCx4uvF
	PPOSUnRs61kZuH4xC7P7WtKQGT1YtNj/EONpFP0DLmQgQrbhddswU7TJwkkDzrgkoizEYYYroE1
	K9SUEuOaI/DmuXZxccIXV+fHuBo9X++bdPD1yr6qp
X-Gm-Gg: ASbGncu7ZqxDzPEHuToNUhq3yHa8IP67riL1s1RZNjXRJB5BIaREcT4uYkK5MWiceUw
	2v+pnWet4axQDqCLZ0lmXxI0gYooYck7eqsz1yWhyuvXwjSRe+KdGtCYZBKJ0hkPdYwIkm/vB5v
	TkYIZdqcKGtdH0OZoV19JA8ygEq7OWbZjq2v7/MBYvSnIM3hFy2VJHf1ZwLIQ0O1aceUIrGXIcz
	mRG
X-Google-Smtp-Source: AGHT+IEC0LjPp4D4nb/8yDJGDSW5ow7uyVR9e8P45jSv6/mggQkYh+PG6iWMUWSWD3lY3B0VJst7mPo59OeYvbX8olQ=
X-Received: by 2002:a17:903:19e5:b0:22e:1858:fc25 with SMTP id
 d9443c01a7336-23f8cf87d00mr3114605ad.9.1753194857672; Tue, 22 Jul 2025
 07:34:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721202015.3530876-5-samitolvanen@google.com>
 <20250721202015.3530876-8-samitolvanen@google.com> <74bd0822-c8c1-47cc-b816-78036abff8ee@huaweicloud.com>
In-Reply-To: <74bd0822-c8c1-47cc-b816-78036abff8ee@huaweicloud.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Tue, 22 Jul 2025 07:33:40 -0700
X-Gm-Features: Ac12FXx5EtR43-0uezus7W46478LtdegGDxxKuOynwE5VCpfViAuraSoEJ6DyfU
Message-ID: <CABCJKucpfQ2nsmo8npc96SAQeQbTJiMcseWA1L-oNEJzF=Hu0g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v12 3/3] arm64/cfi,bpf: Support kCFI + BPF on arm64
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, Puranjay Mohan <puranjay@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Maxwell Bland <mbland@motorola.com>, Puranjay Mohan <puranjay12@gmail.com>, 
	Dao Huang <huangdao1@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 21, 2025 at 8:44=E2=80=AFPM Xu Kuohai <xukuohai@huaweicloud.com=
> wrote:
>
> On 7/22/2025 4:20 AM, Sami Tolvanen wrote:
> > +static inline void emit_kcfi(u32 hash, struct jit_ctx *ctx)
> > +{
> > +     if (IS_ENABLED(CONFIG_CFI_CLANG))
> > +             emit(hash, ctx);
>
> I guess this won't work on big-endian cpus, since arm64 instructions
> are always stored in little-endian, but data not.

Nice catch! I'll send a new version with your suggested fix.

> > +}
> > +
> >   /*
> >    * Kernel addresses in the vmalloc space use at most 48 bits, and the
> >    * remaining bits are guaranteed to be 0x1. So we can compose the add=
ress
> > @@ -476,7 +483,6 @@ static int build_prologue(struct jit_ctx *ctx, bool=
 ebpf_from_cbpf)
> >       const bool is_main_prog =3D !bpf_is_subprog(prog);
> >       const u8 fp =3D bpf2a64[BPF_REG_FP];
> >       const u8 arena_vm_base =3D bpf2a64[ARENA_VM_START];
> > -     const int idx0 =3D ctx->idx;
> >       int cur_offset;
> >
> >       /*
> > @@ -502,6 +508,9 @@ static int build_prologue(struct jit_ctx *ctx, bool=
 ebpf_from_cbpf)
> >        *
> >        */
> >
> > +     emit_kcfi(is_main_prog ? cfi_bpf_hash : cfi_bpf_subprog_hash, ctx=
);
> > +     const int idx0 =3D ctx->idx;
>
> move the idx0 definition back to its original position to match the
> coding style of the rest of the file?

The const definition needs to happen after emit_kcfi, because we
increment ctx->idx when CFI is enabled.

Sami


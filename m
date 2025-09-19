Return-Path: <linux-kernel+bounces-824432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A53B8930C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 13:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 455781BC7FA7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 11:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA6A3093C7;
	Fri, 19 Sep 2025 11:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8SC6C39"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C6E19755B
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 11:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758279985; cv=none; b=iYOus5DFfAqMtwS8sy/9TcLNd5NpCi2xPRProf8oLTR8Y6ACbE9cEGq5xJR1Esli0ymx2Rt2L5WKhnbTeQKnjQs8Gef9wG1VI1mMfp7T54hEomIwJE+OuIjxkMTpVCN2mupePcMrYc9WwrGulbVy2DNFOTuLrKOY+p0HhIJR33Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758279985; c=relaxed/simple;
	bh=FeRgsSRi/iWOgqISnP+r+zKDQoLdP8inVV16qsd7MGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNH29HDj0l7Tgt/K6cY9J7ZwuBdH2HBboNIccijDIOk1cuvCN53NrTS9MeD9SqIFntn8T0qTi5oYPX2wulTbI8fmyCAAj0U/hs+JyvOqY3cBsKJDfZy5jf0eU7FWFfG6nPnG3QqvR/w/zFWFFD2gx2slJr3aq5ft64Q/jKA7vIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8SC6C39; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3e8ef75b146so1812343f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 04:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758279982; x=1758884782; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E0gpwB10/6E2U+Sby0w+MPfG8NeegflF3tJftb7joqA=;
        b=Q8SC6C39HSzMllgd/UNkS5pHqobCWsVLBjBEoSNzLAi1wsLTx93PZqvd4EabCCHfh6
         cMHspRcNaxe1EUOPs1/THG2wDGA3vz51R9eOdzC/3l3r4e/iQd7To8YerJGalNMfVJqC
         uiTF0rDFb5fx5D9veDlLBTYsbpNcME9/bbEld9/ZGMIf1TlCyonJUAKCmx5vMZkm7D7X
         tQXLJa+AwBiM/GRvYgxFU7pDgyWOKdyD2J/kznrNiArhSTDytaR7xmFm+cCYX1LDG24o
         /8c/T8JCJDl3Yhlwn41FOJWVLglJoXkfu4FjDDbjHn/fkX+AsKjHR5nWxq05trMcuq1A
         eOWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758279982; x=1758884782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0gpwB10/6E2U+Sby0w+MPfG8NeegflF3tJftb7joqA=;
        b=A6Eu+HM2YVMQvGu/RLbV8gBpAXsC2CLOAHoG8Xfo5KFB9/nQ+2dJsMck9aLvfS7Xdq
         Ri8XP801FNimwVD5lxHC4PcVRCrcFwxZP3aTTAhgC90mv/PkxPUiQReHahSMLkRQk1rX
         tQJ11ETLqVU1uBj1LNuOdj7+5QVFOgDoX5lQdc2SLOC+y2bcMq6O+4JTuCJymI+nxzaz
         npJaBfcg+suG+CdAiSL3eZdI/whwZs9W4ZcM6Lz5Su17CXP0iBTrQ5CWQpYuMbNO5Z8v
         rHIpwUJh4pWxjpP4zdpAQVcks0lF5k3rp/ss3pSwvE7+y/qJT5iEE2FHV+deR+TW/kqr
         SQZw==
X-Forwarded-Encrypted: i=1; AJvYcCXUJ7L8IAdjpiHzoqmWpU8dkHtBCdWei145nJTZjQosQOcr1weA8kROet20Xa5O9ZpnVU+jLMOsZ0I+XjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRFAbL+xDMckL2IUYJrbVPtBCRpqraveFXK4sg7ORG6RrRu+7X
	4CEIEaJXIv+3mr11cVm31cfKEkbxI2tC9uzK83eKXm5bl/DQVsGXDMgG
X-Gm-Gg: ASbGncvL3ueZQ2Bx6AIahJZHNFo8W+ShXli5j74cQBb51hqqC0rf5zeMcwYwqBnm8Mt
	aO5RL/DU4PuB/8MUgjSoznqhJVVvTONyUwlEivlhrhOGHPbPL/BsL1RJi0nEX20uT/dPsL6+7yo
	TRWk2Vk8Qm4bSGb5uRXHOrIWCWZw+kAluoTDH4dyg3ahfrDjFiRA9jzJ/L1oSPkx2d4ccEm/i00
	XXuu7kRk9/FZbgSwNkTwM7BT0rHWieNR2SQJJEqzAE4hUBxZA04S1jV9uNa1v4PIdOo89oLFm9m
	xVLh6hq+mOPiR7/lUNBMiZn8WVdWwDJW1ts7TrJs6O0XjeAWCoqgjsKQFtkj3GurtmLm18C92Fa
	PIWVgQ8u/ea3Pty87bseR
X-Google-Smtp-Source: AGHT+IF2Z0bInAWZqDYYETRVnCkFEjbkAn2Fex4pkyig1CAMuVquXF5ao4cQ8XxsbTLy1k2XXr+50A==
X-Received: by 2002:a05:6000:2881:b0:3eb:dcf:bfa4 with SMTP id ffacd0b85a97d-3ee868a75b0mr2033940f8f.54.1758279981950;
        Fri, 19 Sep 2025 04:06:21 -0700 (PDT)
Received: from andrea ([176.201.192.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46138694957sm139550595e9.4.2025.09.19.04.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 04:06:21 -0700 (PDT)
Date: Fri, 19 Sep 2025 13:06:15 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Xu Lu <luxu.kernel@bytedance.com>
Cc: corbet@lwn.net, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, will@kernel.org,
	peterz@infradead.org, boqun.feng@gmail.com, mark.rutland@arm.com,
	ajones@ventanamicro.com, brs@rivosinc.com, anup@brainfault.org,
	atish.patra@linux.dev, pbonzini@redhat.com, shuah@kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, apw@canonical.com, joe@perches.com,
	linux-doc@vger.kernel.org, kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject: Re: [External] Re: [PATCH v3 0/8] riscv: Add Zalasr ISA extension
 support
Message-ID: <aM05J6FU0xG3SBzR@andrea>
References: <20250919073714.83063-1-luxu.kernel@bytedance.com>
 <aM0qlTNPiaQRY2Nv@andrea>
 <CAPYmKFsP+=S56Cj2XT0DjdvBT_SY84moM4LVeqxHTVWbtq4EVw@mail.gmail.com>
 <CAPYmKFsV_ZPifJBtvPOdqM6_Mzhac9A4-PH9zt8TirOqAwKGhw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPYmKFsV_ZPifJBtvPOdqM6_Mzhac9A4-PH9zt8TirOqAwKGhw@mail.gmail.com>

> > > (not a review, just looking at this diff stat) is changing the fastpath
> > >
> > >   read_unlock()
> > >   read_lock()
> > >
> > > from something like
> > >
> > >   fence rw,w
> > >   amodadd.w
> > >   amoadd.w
> > >   fence r,rw
> > >
> > > to
> > >
> > >   fence rw,rw
> > >   amoadd.w
> > >   amoadd.w
> > >   fence rw,rw
> > >
> > > no matter Zalasr or !Zalasr.  Similarly for other atomic operations with
> > > release or acquire semantics.  I guess the change was not intentional?
> > > If it was intentional, it should be properly mentioned in the changelog.
> >
> > Sorry about that. It is intended. The atomic operation before
> > __atomic_acquire_fence or operation after __atomic_release_fence can
> > be just a single ld or sd instruction instead of amocas or amoswap. In
> > such cases, when the store release operation becomes 'sd.rl', the
> > __atomic_acquire_fence via 'fence r, rw' can not ensure FENCE.TSO
> > anymore. Thus I replace it with 'fence rw, rw'.

But you could apply similar changes you performed for xchg & cmpxchg: use
.AQ and .RL for other atomic RMW operations as well, no?  AFAICS, that is
what arm64 actually does in arch/arm64/include/asm/atomic_{ll_sc,lse}.h .

  Andrea


> This is also the common implementation on other architectures who use
> aq/rl instructions like ARM. And you certainly already knew it~


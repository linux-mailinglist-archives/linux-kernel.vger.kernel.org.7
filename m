Return-Path: <linux-kernel+bounces-735806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DB6B09411
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 20:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57ADC4A666D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3F32FE386;
	Thu, 17 Jul 2025 18:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Fp2L17nc"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EC9204680
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 18:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752777367; cv=none; b=dYSOoXgymQCstIvuFBxDXcl0/F6ezQf7gqPSQwrNCiW91S/Go2tHL17eOHaENpDGvn9BkwEBF1r4sXgZbw1N2qXDhcgqqruEcodogqywQN7nXy40o6oeugznZ3hGh0HDgQJfn5jF90rt175gOcDiIwa3wdpjewh6absN0YYNc70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752777367; c=relaxed/simple;
	bh=nT1GppLNav7xgnl/ObI19ndyqjnUwbm8v4pO3iyByg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I70FwB49mcIK/oF5utGORBIUolCrrSrAndaL1ZYrp2zaZIbSZrkui8lzekrLeoUAOzGoTbtp2WeiJMxeQwVaJdK3ZhRChK5VH37+ARiUqUCLlb54Nt/mKSnvpReA2LEfV/FjMj2dqZDZhMXqFI5G7houJmlKN1xZjCdW5mTv3Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Fp2L17nc; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ae35f36da9dso253431166b.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 11:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752777363; x=1753382163; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aieKFP+WlFpL5D5yzi8pvP6vZRe7mbkNZOfzzhMJB0Y=;
        b=Fp2L17ncI5wICc2c3vrZt9B23oheclQIt1FJKetProM1QUmQCmGDQWdsGTLAF5NiaT
         uLnnVV+tiwb0hnRO+mn9U3/3O+mYcZUVcJ5xfnC05sBbkwd1dBgMjFRQfkSN5qe7z9fL
         2P0P3esHhCq5uJA1jrjW2jRUzSdbts+ACO4gA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752777363; x=1753382163;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aieKFP+WlFpL5D5yzi8pvP6vZRe7mbkNZOfzzhMJB0Y=;
        b=Bdn16AkP54nEcSahclHqN2/g90l0vqi+lc0R0jMCXgDFNR7RvYij0O4/2owXO/W0bR
         r3EZ23Ax0heGb3RIGwCWbg+1De4O+U0ttMC8ZrWC6Da28JT2zJKdqdAC3XEszOZaM7dE
         aeHx+yupxndMu0Iu+jrmVR5NA+2MRQ0FZoHfhtvQtlbaT+eSFEbTDzGoCyqbVgqltILq
         OfKf3NJwxFUFsmVyjNjkJHax8eoKMDoDQgMTjhhyXIu5Pe/FqEOyFDIWrC2y8csfZMNK
         CzYCRw4Lpcgr3ssxCtSbV+c8+OAkBGbhxlWoc3SVC+Go8xPhw1SrwPR7wfvZ3ApgEVkF
         Diag==
X-Forwarded-Encrypted: i=1; AJvYcCWNpFoXEpqENx8QxWlr8q/lgz6XoVwCKpbVzNJ9MI1N/zgA47NTvL00QwmKXppix0ofDiysZ5N2onkMjXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YziRgDQGOPPlUlzCh+VZK74VGxxyUMW5++ChV9ioA5QVb4oC7Zh
	brRQzZRp1tbnvCZ2FsnRl2XEXVg8vK3ZOeGcB2Bc9eTjP5q1C2mO6n0gaAqBbdke+B+pIjXiASn
	QU84IPjw=
X-Gm-Gg: ASbGncu89zCEw/Skzvr0/ZaDJxcaQK7V1JQpGJI+jVCFnJa1mkeXPSabRvcOVE6yqM8
	oPtCYNKDfkyLpIqSvNrSYTr5UMr3wJbchgHPBUNP+CE6xuUlIEvcLRRHh2ap9hdgHgOJYCocSXQ
	NX077MKLX5RHvvkfqR4XgfauBMQwdWr1QExniqqqlrSupUc6F0jAs/5h2GQyYEGCjjSZsnWABFv
	asqj790OzMeWYoLZnD3xHXFgH952LvErqKJh2HwSt8fGub96/S6kVADoRa/hXGTuZFnXxPzG/ys
	HC88oobdyueNPywSYhZ+jLVLsxKwhW4nHgTg9G6gFgXe1Ai0YBHwg5Hppr8/WT2b1wehW7+LA/J
	lv7rpf9fO6LYE6tg//I4suM7ZSI2HBdWVaiSpQuS4SYrGS3zrbhgT6wDX1AomkOHYAeQo6A3F
X-Google-Smtp-Source: AGHT+IEVet8MJawAe02NpRKCAKzNb2XL6JsmGjDq8L8gEVS66KHVjkuV6afCIx8aisD45fDQZjNswg==
X-Received: by 2002:a17:907:96a2:b0:ae3:60e5:ece3 with SMTP id a640c23a62f3a-ae9cdd8436fmr773274966b.6.1752777363326;
        Thu, 17 Jul 2025 11:36:03 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7eec2a0sm1417531066b.67.2025.07.17.11.36.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 11:36:01 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-60768f080d8so2399419a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 11:36:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWx6gkrxomAOoA1anfVDOBKcRdVDx4OCDUrhpvUtAMmVGTiZ/HKsK0+VcrxhbjlDKNeinCO0RBUU2cMJIg=@vger.kernel.org
X-Received: by 2002:a05:6402:34d6:b0:608:6754:ec67 with SMTP id
 4fb4d7f45d1cf-61285bf3730mr7487110a12.30.1752777361408; Thu, 17 Jul 2025
 11:36:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716123916.511889-1-bhupesh@igalia.com> <20250716123916.511889-4-bhupesh@igalia.com>
 <CAEf4BzaGRz6A1wzBa2ZyQWY_4AvUHvLgBF36iCxc9wJJ1ppH0g@mail.gmail.com>
 <c6a0b682-a1a5-f19c-acf5-5b08abf80a24@igalia.com> <CAEf4BzaJiCLH8nwWa5eM4D+n1nyCn3X-v0+W4-CwLg7hB2Wthg@mail.gmail.com>
In-Reply-To: <CAEf4BzaJiCLH8nwWa5eM4D+n1nyCn3X-v0+W4-CwLg7hB2Wthg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 17 Jul 2025 11:35:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=whCDEuSH7w=zQBpGkustvis26O=_6cEdjwCanz=ig8=4g@mail.gmail.com>
X-Gm-Features: Ac12FXw_kNIbTRokcm7T_S0XklVgvPSebW7F_Vtc8CMTkt7DzdcMPhb6rT3qzqo
Message-ID: <CAHk-=whCDEuSH7w=zQBpGkustvis26O=_6cEdjwCanz=ig8=4g@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] treewide: Switch from tsk->comm to tsk->comm_str
 which is 64 bytes long
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Bhupesh Sharma <bhsharma@igalia.com>, Bhupesh <bhupesh@igalia.com>, akpm@linux-foundation.org, 
	kernel-dev@igalia.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, oliver.sang@intel.com, lkp@intel.com, 
	laoar.shao@gmail.com, pmladek@suse.com, rostedt@goodmis.org, 
	mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com, 
	alexei.starovoitov@gmail.com, mirq-linux@rere.qmqm.pl, peterz@infradead.org, 
	willy@infradead.org, david@redhat.com, viro@zeniv.linux.org.uk, 
	keescook@chromium.org, ebiederm@xmission.com, brauner@kernel.org, 
	jack@suse.cz, mingo@redhat.com, juri.lelli@redhat.com, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, linux-trace-kernel@vger.kernel.org, 
	kees@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 16 Jul 2025 at 13:47, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> But given how frequently task->comm is referenced (pretty much any
> profiler or tracer will capture this), it's just the widespread nature
> of accessing task->comm in BPF programs/scripts that will cause a lot
> of adaptation churn. And given the reason for renaming was to catch
> missing cases during refactoring, my ask was to do this renaming
> locally, validate all kernel code was modified, and then switch the
> field name back to "comm" (which you already did, so the remaining
> part would be just to rename comm_str back to comm).

Yes. Please.

Renaming the field is a great way to have the compiler scream loudly
of any missed cases, but keep it local (without committing it), and
rename it back after checking everything.

Then just talk about how every case has been checked in the commit message.

             Linus


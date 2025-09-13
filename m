Return-Path: <linux-kernel+bounces-814999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FECB55DD1
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 04:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21C9DA0837B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 02:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96051D5CC6;
	Sat, 13 Sep 2025 02:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhqNS/da"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD45B3594F
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 02:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757729794; cv=none; b=s2b7KPcpdsapzCW1+5nKJHp2tUFEEBlUJGGrNuZS2smtKgyyyEcr3lgUbAl27AQOeyYw4zSz5VgfkQoeGlb0JpRCocAlrsaSLu2aCAFtyZZJFvlSgPdOQgSuWL1PfmNKVtXbFvEIVypu6vDpcCreDUaANpmJxkoxwlRvmufFiE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757729794; c=relaxed/simple;
	bh=xGbt/rQns9Xu5005jWUhfQNWdPT+cghf1LrEGQeNWFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u+IVwcMRQ1xL0INx9xcjjrD3EUUieOVtWiQ8hIFMeEOtfQCZM3pmsRtU6ltd9HrSx0sokA8rCAUnvzoEXtyhpx4sxpBYzfMxkrCxOmQhHVES79YQhB91z8Tcy49KTLeM/XJQmW+jX6MFylcA+ZyZNVsRwQvHlJ6Wjj+uPWU/mfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bhqNS/da; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e96e1c82b01so1520139276.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 19:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757729792; x=1758334592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGbt/rQns9Xu5005jWUhfQNWdPT+cghf1LrEGQeNWFI=;
        b=bhqNS/dakLhQNXHeGd35vFqEnlG8EnX+a9Gbg67EOUje61ZaoV6MQ5VQuWx2jNwcmb
         1UgrWtYzPbaOYDNxh4jeEdwnt5gLtO9pe+XA9/Zvw/tsEj9tTgDci8mlPtP1rcsuedjY
         P7ioeokpljH2rU5tLV+3wm8pyxedjz+pYzWsBK66I1pKN+5tYNL5NmEimYhq1aJQ2KR5
         cG6jTcY+8Hhwo2fOhHF4C2wNO1yZHg6eGaasMa8tNkJhS9Gf/m+wme+IDbZSYLjO4v8k
         8TOr6OtK724LF3jot+UekM6OR4ikTTrOH/QTNRvLnLvP2llerrs4KKkUWqNlAlYZ2WYT
         gbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757729792; x=1758334592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xGbt/rQns9Xu5005jWUhfQNWdPT+cghf1LrEGQeNWFI=;
        b=Ic/xsg0CKhW5mahtZTDLCFt8Q3J6GYT9aNeqNhSz9vLckZv7JgrkfIfOOYOVZ0zf7q
         mhKURbOrR2+PrvEmWdyQYZ2jldCed9+oYy4kLjZsu7JZYV2P8gXCXk+4RZegEn795C3Q
         2SmkD3NiJlRKnemmKMq1xDfxa2NvFSWuPbd1dcy07tyQJCLZjxlhlWqNWjSrZVmeGwFm
         zFuK1DkkE6rm9n13CFK1kcZKROif15F6stBVMfA6luGk/AXsnoNUPZUNbf41ZZ/dnMqK
         BBSOj90Rp+dI50swFttzUCQxD70PoEOZsokLzOT29S4aaVo4TnsEyw+w/Age/J8lW++Z
         ApgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwyNYjWvU/tXhWeHTTKeVpYvWiKvNu0Wl764isi1PIC4SZ2RT0PySMgoDd8ZAlf3MJJ4FqtkxrGiQ3MKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNX4oCo0pgidI8euZOnVLDt2Q99u7vu+WZtjBNdW06a1aknBRZ
	OtAleNkhRpPWXR4pmKgY+N0WAptMn09V/D6nAYfJ8hUaAk7N2ZlFs7K5j8I9RTR1MbiJIGFQSXn
	F1gsbjulnAQrXZ8jl/gh/vxNsF/Yxtes=
X-Gm-Gg: ASbGncsCN4pRBdEnvYhVzLDKJp4DtrOc3LODHJyS1mIWsUrnTfJqrM3lF/S8yDFoBFN
	K6oIYMWpHpsF/84P5N6oE6ZBHI0ZbPtHMWhzAG7TdqOvM+6aCh8wLVQ260bjlCeR/orK61SbpGU
	vjUmeEhf2XDf0nhI5GWrusjzZ7JRd9GX1Xcd/5/V6MZxK7XoMYhyIdeCFwfJillIUPEDLQCNUPk
	nVEbmS+y7PMoiILj11p6Cyr+pI=
X-Google-Smtp-Source: AGHT+IEuudP1MbDDzDJ1Axa9SCCj4RwO48Bzzr207D0xOeX8T5X5b1dOTn/r/1lDgWqGhIk9sTkt80hOQTBN9t/z3bM=
X-Received: by 2002:a05:6902:540f:b0:e9d:75c1:7584 with SMTP id
 3f1490d57ef6-ea3d9a326e2mr4933440276.15.1757729791476; Fri, 12 Sep 2025
 19:16:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFRLqsUfDuoMMCUmBuSkiV_b=VNn7CuYqJSc19bhyQ6Kims36w@mail.gmail.com>
 <CABBYNZ+PJuvWYk_XVw=esNj1hVMPESjTc70VLQH=LrKdSqD7ag@mail.gmail.com>
 <CAFRLqsUE84wW0JKbsh6Lw0USQbnCbokXd3PANc+4i_nsnEUMYA@mail.gmail.com> <CABBYNZ+xg05sbfU51VXo1M=PqPOktDtRpTe5yHwwUhF9ui+NPA@mail.gmail.com>
In-Reply-To: <CABBYNZ+xg05sbfU51VXo1M=PqPOktDtRpTe5yHwwUhF9ui+NPA@mail.gmail.com>
From: cen zhang <zzzccc427@gmail.com>
Date: Sat, 13 Sep 2025 10:16:19 +0800
X-Gm-Features: Ac12FXzsluXLpHyt7EcRtG6kj7lTIOteS8YvIwP_xzOAOF1VPauaqg8FN5vOBFI
Message-ID: <CAFRLqsVj28niHO9XejYrMu2g3fCrDXXgArshP-kr4CM=eV2smQ@mail.gmail.com>
Subject: Re: [BUG]: slab-use-after-free Read in mgmt_set_powered_complete
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: johan.hedberg@gmail.com, marcel@holtmann.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, zhenghaoran154@gmail.com, r33s3n6@gmail.com, 
	linux-bluetooth@vger.kernel.org, "gality369@gmail.com" <gality369@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

Thanks for your patch! It not only addresses the TOCTOU issue we
discussed but may also fix another bug I reported
(https://lore.kernel.org/linux-bluetooth/CAFRLqsWWMnrZ6y8MUMUSK=3DtmAb3r8_j=
fSwqforOoR8_-=3DXgX7g@mail.gmail.com/T/#u).

I will test it soon to confirm.

Thanks again for the great work.

Best regards,

Cen Zhang

Luiz Augusto von Dentz <luiz.dentz@gmail.com> =E4=BA=8E2025=E5=B9=B49=E6=9C=
=8813=E6=97=A5=E5=91=A8=E5=85=AD 02:29=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Cen,
>
> On Fri, Sep 12, 2025 at 11:59=E2=80=AFAM cen zhang <zzzccc427@gmail.com> =
wrote:
> >
> > Hi Luiz,
> >
> > Thank you for your quick response and the important clarification
> > about hci_cmd_sync_dequeue().
> >
> > You are absolutely correct - I was indeed referring to the TOCTOU
> > problem in pending_find(), not the -ECANCELED check. The
> > hci_cmd_sync_dequeue() call in cmd_complete_rsp() is a crucial detail
> > that I initially overlooked in my analysis.
> >
> > After examining the code more carefully, I can see that while
> > hci_cmd_sync_dequeue() does attempt to remove pending sync commands
> > from the queue, but it cannot prevent the race condition we're seeing.
> > The fundamental issue is that hci_cmd_sync_dequeue() can only remove
> > work items that are still queued, but cannot stop work items that are
> > already executing or about to execute their completion callbacks.
> >
> > The race window occurs when:
> > 1. mgmt_set_powered_complete() is about to execute (work item has been =
dequeued)
> > 2. mgmt_index_removed() -> mgmt_pending_foreach() -> cmd_complete_rsp()=
 executes
> > 3. hci_cmd_sync_dequeue() removes queued items but cannot affect the
> > already-running callback
> > 4. mgmt_pending_free() frees the cmd object
> > 5. mgmt_set_powered_complete() still executes and accesses freed cmd->p=
aram
> >
> > I am sorry that I haven't get a reliable reproducer from syzkaller for
> > this bug may be due to it is timing-sensitive.
>
> Let's try to fix all instances then, since apparently there is more
> than one cmd with this pattern, please test with the attached patch.


Return-Path: <linux-kernel+bounces-727169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B85B015EE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 10:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D69B41C87430
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 08:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33F2201004;
	Fri, 11 Jul 2025 08:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="KEfBDueQ"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6189D212FAA
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 08:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752222363; cv=none; b=eMLIGySrjE6FEnkPjQcERKhIQEQQ7j6i0HqvQlObcSRVpBf8oRoCVqWla9xjsWRC98vk3LYelPRc/UutOmITunFfPoMRWO2oLxZ7VVR4V0c22pWl+mGmoDd7gqjKvTYcZJ9sHqh4fHFkD3SrsE6J6GwmZUuJgiG1jAzJXHp5nCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752222363; c=relaxed/simple;
	bh=0bP+GByP/BRW1kn9Hg79IzJwx8Y/oExKL7f3IGwumNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UEH135Y4z2hW2xTs1yTKAHrETXyA0ph0SdAi+FC/uXdvrDFSvaVAZaXGyAnj230jk22fbNiyWOFXh13DA9g14/bBE/0jDCmSCzi7PuMuyAq5fW2rx1nqt7DhN6hgSOZCYwE9X5E64COFgbgVNnRcKInhZtZbgSspnT8hrpBicdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=KEfBDueQ; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3122368d7cfso1638457a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 01:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1752222359; x=1752827159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/A2fAk/hY+VXgln3RIT8cl3wcMIkArGIQeZSyy9BGEA=;
        b=KEfBDueQbSoC4ezji2EHMb8tSOD/FxNAa8e8LZykAc84CM+6tSHfPtn07kh1z/kWLk
         SHSwrVDm10L2e5ZHLhfrq7ovQA1ZMvr9hx8vmBipmoVIivEAmJ3wcOrwiE05VEiLd2Of
         +3JakFla9Qwl6F0LrbX4Ayszwpzs69vTAWdd3NMU+NPZokpf2ahp18om+8fzHZ42kKA4
         7xLJbvDxtZ3WdOeRAEpDog3EeOOySsW+87B4vLddDM7dlnPTkL38diDRUiILvnp+2LYq
         hX+3EE9ElUawcgkHGW82QDCrCgbaBcEVTTQCdVi4JD5aBiHezv8ZUxHF2tIpFaSSHWc2
         BwiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752222359; x=1752827159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/A2fAk/hY+VXgln3RIT8cl3wcMIkArGIQeZSyy9BGEA=;
        b=ENxyhj3fpbFkdtY6c6Rf7+uA6M+zzVu2QDgVh+hX+EuYRe8kDTYDGaawkEX8u48Acn
         xuxFCLzKMz4jYdLSHnAkRGkU0D7hSG+thrRRbWA4jMSQwwzvJs3MNu8DNIua7jFq0m/T
         60VRp2gpoUpJtfc+YlY6t2XJTUMHSPJoRcZdouTSxTenOk+eLOeTdxK+QjkSGNH/jctB
         J/JIT9e2wqwvt/Tbyqkc3e+DLITHJ1vP/72hceAiDFJSCUQVu2yXs7QtyHK4CxrLOMUa
         bub+CRRtO7anQqFTaWOifwNf4ncE5FLqSmWX62d+OrPULRevRJjcIvqpniQUFzHcWaY5
         2A4g==
X-Forwarded-Encrypted: i=1; AJvYcCXaJXdncIFJZQiksxY2EqtUhtNuMqzfPZhvsBM19dwhqxOtd0tyG3b6QCIqK5iBcdeyOFnepZhJL6C01X8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP0yKwNLDUalPobeYslfzvPcAJrpB27DI6tD+FN1bRtzdDQ+DO
	ZFkBck9hveS4UTlvO3OTltXXiIBuiua+TjizIqni9vwZrM+Qb/jefZY6MCRGQxqFqMfoCdEM2RQ
	WxkyLmjB3x9eWcAdQfNb/tHvbNJ2H13GEPDtMfF40Hg==
X-Gm-Gg: ASbGncucaFCldb3PWdiWkPYoJziEwyz4Ylu8rhv/S9N/1TQmo5IqkhGzcQtPyCwzcdF
	UVjspPUSj3e0SmOXpcBUzclQKZ/a3aBT5svZK39KN+a2N76EiptE3+QqF47gwwS0WUgjFjb2G+y
	xjzpFAqSy1apaNm3VYjrhD2/X4ji1CKZfBCX50yJjHwAsMZ5Z+kys6ZZS9cCwUIXmF4dArRIfrs
	DzkrQ7GEgU2e4oEL8s0
X-Google-Smtp-Source: AGHT+IFCp1pcD9GmdtCsf5iRMPFHSbp9FsiGavSusUMyRrFKZGE3x/NS3PMLeRJnScYqO8frgAwfK8U/bj7U7Muxpzw=
X-Received: by 2002:a17:90a:d88e:b0:312:959:dc4f with SMTP id
 98e67ed59e1d1-31c4cc9d4f4mr3742093a91.5.1752222359484; Fri, 11 Jul 2025
 01:25:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710133030.88940-1-luxu.kernel@bytedance.com> <DB908AUW6N76.3SYAGIFGCDJ27@ventanamicro.com>
In-Reply-To: <DB908AUW6N76.3SYAGIFGCDJ27@ventanamicro.com>
From: Xu Lu <luxu.kernel@bytedance.com>
Date: Fri, 11 Jul 2025 16:25:48 +0800
X-Gm-Features: Ac12FXyVj12e58tShQlG7C9K_6PvavwmURsMwnmPFZyguWbVaWs8xpiRLy86iqI
Message-ID: <CAPYmKFu2Ggu7_SFkrhfKX9rT7Pdas+jSjksGMFAhHf7Wa83Y8g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] RISC-V: KVM: Delegate kvm unhandled
 faults to VS mode
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>
Cc: cleger@rivosinc.com, anup@brainfault.org, atish.patra@linux.dev, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 2:16=E2=80=AFPM Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcma=
r@ventanamicro.com> wrote:
>
> 2025-07-10T21:30:30+08:00, Xu Lu <luxu.kernel@bytedance.com>:
> > Delegate faults which are not handled by kvm to VS mode to avoid
> > unnecessary traps to HS mode. These faults include illegal instruction
> > fault, instruction access fault, load access fault and store access
> > fault.
> >
> > The delegation of illegal instruction fault is particularly important
> > to guest applications that use vector instructions frequently. In such
> > cases, an illegal instruction fault will be raised when guest user thre=
ad
> > uses vector instruction the first time and then guest kernel will enabl=
e
> > user thread to execute following vector instructions.
>
> (This optimization will be even more significant when nesting, where it
>  would currently go -> HS0 -> HS1 -> HS0 -> VS1, instead of -> VS1.)

Nice supplement! Thanks.

>
> > The fw pmu event counters remain undeleted so that guest can still get
> > these events via sbi call. Guest will only see zero count on these
> > events and know 'firmware' has delegated these faults.
> >
> > Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
> > ---
>
> Reviewed-by: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@ventanamicro.com>


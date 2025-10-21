Return-Path: <linux-kernel+bounces-863740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0D8BF8FC0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5BB784E72F0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 21:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5435D28CF56;
	Tue, 21 Oct 2025 21:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2g9BtgC"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AFC2777FC
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 21:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761083597; cv=none; b=EZ8Ulq9ecQQ1kyUVnu9+FpBQ9K5Asg23U196dUbI0QKJXb9NdcYXHOV6MdTA1KGORe+cTsLAoJK2AerRowRkvfgVQK+UW/SKuSHUP9HenMp9apWHEP5blMurcYsOBLshk4+eHJ+eXZP/Xv5lQkbSCf8gPTMkTQ8HI9fXv9pMnsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761083597; c=relaxed/simple;
	bh=Lc3WtDTd1WYQC9A9nm1WTBB9FxsPLQHScnVEcTR59VM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J7vb4hxY/68YqhlDFeZEcDHqrTDClgJNVcBPcMIf6HyDqJ5YqFn0ftvyJ8OVadeCket1ryCv1ET6lgYmfrJcEUMZUfHE3wUP1HJ7ACxlkHLn9Y17UV55C6baHgaVTKLDo1ilSI/LGuEaKBuqS/QjInNgKA56V34spOFtH9TUS8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2g9BtgC; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b50206773adso78980466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 14:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761083593; x=1761688393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lc3WtDTd1WYQC9A9nm1WTBB9FxsPLQHScnVEcTR59VM=;
        b=a2g9BtgCQBcF4R1QXWCynwW3o0KpJTJid/msuZBMqqoVCsifab0apduzrNWmaxrd7e
         bLpeUqThWv3tL4dMUTIg+QpSLnbmTnqUQ/N+QDGaZmbIqBPHTM3albwzaQ6TgbFs2i56
         zpGR1k+7s4H+7acQDMFExA+lF1SBzo/sbPRv8WfHxuBW/ZY7JRihcvrVkCl8hDnJa7Mi
         7YD/dMz2HXwHcrFrSCp9FuD4LY7q1RMQgfeB1bxoJMr+inLgNocCb7hz4H37RdJjAXBN
         88+0uIfP9YTVX1fAJpxeMs5yQ2V4LKCd7E5FAaqlZNnWXhXHg//MknucTgrA+/nf5Yz8
         gC8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761083593; x=1761688393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lc3WtDTd1WYQC9A9nm1WTBB9FxsPLQHScnVEcTR59VM=;
        b=lIDsrhxHWnr+EGb/uTDNa2JIhtzxMG4plZTeB0QjfSw76qPGuIH1d2p+t9RnNpk3TV
         BKy2vF7QW9rt+uh4X/ZMFI0fayYsNcFQfLTVRE5cFdIFIyMu4kE0lY6C3cbRPAfA6m3v
         9v2kb5gGFmdvVmXVOHT6zobmhn5QVulih7g39oIpz8KMxWJ+78hFSkuxuImnXkRzbeyZ
         0FRsiHZTRsXVYuoccpZyNL+1xWlgT9IlZZb90E6kxlXY8GJ9SgBtJ5n91rT/YNDR49EI
         cXChV4497c6HYKPnWxVAdAo6Sx/pj6LemEx6qS/gA1+StOgqy52zN9wrAFcqtP7xUrfJ
         s3kQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfZMk4MdTAEongJhH9cQBZNM4HhsvvFSVYpTrrUsmEBl8Z5Z/LZk7zEDJUUHc4lCk8POcYtLM51+Ii6x8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJb3MFY0qKoy7FKffMNZKGWj8WvQNR3/rPbz1OFNQffGjpjHyK
	lP4DES3PI5cTCt+m54ApDWEmIqDTZ3Ue+axiKu7gxb6fDwiQZ7TI1MkL0xo2A4ItDjJaTCHrG5P
	0YIoCkF+HUv03nNPsNS7GQxTogqxGiEQ=
X-Gm-Gg: ASbGncui108mLuUhHBqfxVoU1HFEAcotFC6GsWaXMizHqPJKyRURWpu4c8Rs9xDwYFG
	wTzOxVKiRAJCnhQlD1YPzI4fTpdmnBR459n/6WJTQ4g1EQcvOrOefDCrEX851WT9m5DMVTmjuEA
	NktKZkFvYTXQXhWLLslJFZzuA/ZxlMYgalXrWH/M4Twv7HYn8hpPr6w/0AC65+bxAUtlqbmyxGp
	ARttZIVrhMEyi/7KAXGwDY3q+lu2pEqebeUUf5EoFb+ryICZN1jBUeT4bV6qr8vBGan
X-Google-Smtp-Source: AGHT+IHgL6OS1zyNh0o71e3k4WV5Tf6ETzDakWmigXYDAG5OGfCGMEg6wbmkgvp8Wv+rjUuXZp2cr5meg9MQtWIDPkc=
X-Received: by 2002:a17:907:60d1:b0:b4a:e7fa:3196 with SMTP id
 a640c23a62f3a-b6d2c0f0100mr178904766b.20.1761083592864; Tue, 21 Oct 2025
 14:53:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007115840.2320557-1-geomatsi@gmail.com> <20251007115840.2320557-5-geomatsi@gmail.com>
 <CAFTtA3MObvXRHxbULghGcT=ThrBDeFDJzUY7LOhgNnarzpYeGg@mail.gmail.com>
 <CAFTtA3NoOZEMqYD6+vjP=09T15GiThjVy1LeDX0U8CC-4HMKOA@mail.gmail.com> <aPVYIOz8XRZ-737r@curiosity>
In-Reply-To: <aPVYIOz8XRZ-737r@curiosity>
From: Andy Chiu <andybnac@gmail.com>
Date: Tue, 21 Oct 2025 16:53:01 -0500
X-Gm-Features: AS18NWAt2pbpVXFat7QXlAftkjLF0aVf0hUbqLUhJriBx4VQpw1cMjJ_tGTeY0o
Message-ID: <CAFTtA3Op5e9gNrCrO1arpUw18oLQ4MX6cJxsiKCS+SZn48_qaA@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] riscv: vector: allow to force vector context save
To: Sergey Matyukevich <geomatsi@gmail.com>
Cc: linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Oleg Nesterov <oleg@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Jisheng Zhang <jszhang@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Thomas Huth <thuth@redhat.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Han Gao <rabenda.cn@gmail.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Nam Cao <namcao@linutronix.de>, 
	Joel Granados <joel.granados@kernel.org>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 19, 2025 at 4:29=E2=80=AFPM Sergey Matyukevich <geomatsi@gmail.=
com> wrote:
>
> On Wed, Oct 15, 2025 at 04:32:05PM -0500, Andy Chiu wrote:
> > On Wed, Oct 15, 2025 at 3:18=E2=80=AFPM Andy Chiu <andybnac@gmail.com> =
wrote:
> > >
> > > On Tue, Oct 7, 2025 at 6:58=E2=80=AFAM Sergey Matyukevich <geomatsi@g=
mail.com> wrote:
> > > >
> > > > When ptrace updates vector CSR registers for a traced process, the
> > > > changes may not be immediately visible to the next ptrace operation=
s
> > > > due to vector context switch optimizations.
> > > >
> > > > The function 'riscv_v_vstate_save' saves context only if mstatus.VS=
 is
> > > > 'dirty'. However mstatus.VS of the traced process context may remai=
n
> > > > 'clean' between two breakpoints, if no vector instructions were exe=
cuted
> > > > between those two breakpoints. In this case the vector context will=
 not
> > > > be saved at the second breakpoint. As a result, the second ptrace m=
ay
> > > > read stale vector CSR values.
> > >
> > > IIUC, the second ptrace should not get the stale vector CSR values.
> > > The second riscv_vr_get() should be reading from the context memory
> > > (vstate), which is updated from the last riscv_vr_set(). The user's
> > > vstate should remain the same since last riscv_vr_set(). Could you
> > > explain more on how this bug is observed and why only CSRs are
> > > affected but not v-regs as well?
> >
> > From looking into your test, I can see that you were trying to set an
> > invalid configuration to Vetor CSRs and expect vill to be reflected
> > upon next read. Yes, this is not happening on the current
> > implementation as it was not expecting invalid input from the user,
> > which should be taken into consideration. Thanks for spotting the
> > case!
> >
> > According to the spec, "The use of vtype encodings with LMUL <
> > SEWMIN/ELEN is reserved, implementations can set vill if they do not
> > support these configurations." This mean the implementation may
> > actually support this configuration. If that is the case, I think we
> > should not allow this to be configured through the vector ptrace
> > interface, which is designed to support 1.0 (and 0.7) specs. That
> > means, we should not allow this problematic configuration to pass
> > through riscv_vr_set(), reach user space, then the forced save.
> >
> > I would opt for validating all CSR configurations in the first place.
> > Could you also help enforce checks on other reserved bits as well?
>
> Just to clarify, the suggestion is to drop the TIF_RISCV_V_FORCE_SAVE
> entirely and use only careful validation of input parameter in riscv_vr_s=
et,
> rather than using both checks. Is that correct?

Yes, exactly

>
> If that is correct, then I assume we can rely on the simple rule ELEN =3D=
=3D XLEN
> to validate vsew/vlmul supported combinations. Additionally, reserved vse=
w
> values (see 3.4.1 in spec) should also be rejected.

I am sorry but this assumption may not be correct. The spec does not
restrict a 32b machine from supporting ELEN=3D64, according to my
search. There is a way to infer ELEN though, by inspecting if zve64x
is present on isa.

Thanks,
Andy


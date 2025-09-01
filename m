Return-Path: <linux-kernel+bounces-793847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B02B3D91E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 07:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC90A18998CE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 05:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273A92472BC;
	Mon,  1 Sep 2025 05:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GD/IGNcz"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AE1242D95
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 05:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756706256; cv=none; b=gXzq52ckti1tpLyTxXGHmMdhcICRX0EKQo1vDUx2RDmBtQdeyI4jWzKoTDqJxDl1RMMzO7bTYk2yX0iHVAfNpatRz5V+MnqDPNQHo+nytQEL63VnFRgH+gXQ1TsuAiFUt2O6jpoZy4cYb1LpG3ZsBxLrcvgFzy1gMdmzhZpbKP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756706256; c=relaxed/simple;
	bh=w32AAvhXSV0MdHV6sniBejLaanWJXswlmthT7KmASNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eAsV7418jthrT5ADyqRM/l4shSzI9FEUjBwAR2dSzXy6fYdCTcuDlEbMwfBQlJcqeNixa/2gl74O65c35kpnkpoWGmjHmMs1gu9w4pzK4Nh++QpZNkoF29WIdLY6RubTpl4l9UBlMknjtmDFKMUjTCQBpd3W+gNsO+arNCJ+s58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GD/IGNcz; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afcb78ead12so632307666b.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 22:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756706253; x=1757311053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=atfmDciT87We9G92rpl9fIpB9K1Hgs3DJ4wP3oz+nOU=;
        b=GD/IGNczKfUp8lBpdl1yNPqsmlafyDB/MErR6dlwYJM8nUCJvxlaoibYr1RHsVIEto
         RIDUokNYxb2VmMAJlLdg6p2JQ7ETur4poLyB13YcHm5uLv+SSTfTd/4sF9e5TG1eO5L9
         9w79mDO7FEb3j4piQQKbc+XuHvUGTHWXHtYKh1/7nozMO8tSldZ5qNTx2CJNnMElICqd
         VvSBRYfyN2XD/IEC+H8UQCP4sed6YgL09wSPg7C+ZBJB2cBNx+g/UZkUYdzc0NUqVq9u
         jtquCspUbmAwi7P7bqeGCTw7cNKTxScPiWDlMf27/M9Hup8b6abvzjfy1QgT1m16U9xC
         duRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756706253; x=1757311053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=atfmDciT87We9G92rpl9fIpB9K1Hgs3DJ4wP3oz+nOU=;
        b=vK8sg2SEKQyT+1r33QAlhpkvZ8+fNQ1lpF7r+oZg7mVDDOPduCH7yIifkzM6/PBWGD
         fSPEgQFVC8PcG8XcZolIp6foj0VgRtk54P3hONzn06QvzHVamgCxfhepHTZDFFzemrbv
         mVlq4+1II5NRhVIb6qBDSULwqf6UF96dutlqkW+GFH+apzz0Ghypa4dDcKRtBhGd4ute
         GTWscEOOeDIl6mEpnEy1xzgu682gC8BmBoj4LXBXi3dXL1e6r1S3ii0ua9/Z/IglpW+A
         KfhR4JcQKXJyoOsIH0li5FqGlVVWuqiwis1fsOsNywhoUIrciW8uGjv3rG9MAO7jM4dP
         BzgQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0xP9GJI6xYppGl1iHoRug4IUc1yOs7uIKBSd6mxG4PJdHZ4T7WLqqrxKRvl+yk5CA0w/YpPL4Ty9ZUtc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKm2k2UhDuTPuH46QneAoA4guxE4vnBd34Cdf2S7ydNAuZFHfJ
	TiyEtr+qKcwDrnZVZ7SzULF/zvXfV9s59M4DH3oEZSjUZOKUiFGsy56fNXkYA+4386JJnJwl8xL
	HxpbSGs+VrFd6NfMGmq6GLYy+pGv1Pxo=
X-Gm-Gg: ASbGncshJi4ycaot/NtwltlSE9MOhV1fdMJcHzzLqYZdhSFVG2pjyjHbHiIInRRPafs
	en1eNi8IOBnIHa3+gmqT8k1jMSvxBmKb0EW8WPK9tqqpc/nLFmRpd0u17J8xHxUgaN1EanbQ0Ib
	teqvdIFhM49M7DSmpIXThWsEFJMfYgTViheAuKUhKiHod11KTLlgj7aqmNWkaAJ1pxd0s3iAKo/
	W09YuFmOPBr/T1tYY7Owe4NNkFvjxQEInmAix8UGA==
X-Google-Smtp-Source: AGHT+IGs2efo+IOitpvfttlp4QpHm+UdTuzypNYlU+dL3lMMdmTt1AUNYkmBc7Tet2CctEcc+m+cKaKxdPgXex6paWQ=
X-Received: by 2002:a17:907:720f:b0:ad8:9c97:c2e5 with SMTP id
 a640c23a62f3a-b01af2e0b76mr615719166b.0.1756706252682; Sun, 31 Aug 2025
 22:57:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <871pp14pkr.ffs@tglx> <20250901040538.381976-1-kaiwan.billimoria@gmail.com>
In-Reply-To: <20250901040538.381976-1-kaiwan.billimoria@gmail.com>
From: Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
Date: Mon, 1 Sep 2025 11:27:15 +0530
X-Gm-Features: Ac12FXxUPY4QvmXb8GUBOvVPhQCnYWtPBmgGFTiodjw4BbIZhYZ-Q9Y4Lx9pjfk
Message-ID: <CAPDLWs-oikjGMDE1L36UETaN75D6n87E+MLtqRmetHiyhHPA6Q@mail.gmail.com>
Subject: Re:
To: tglx@linutronix.de
Cc: Llillian@star-ark.net, agordeev@linux.ibm.com, akpm@linux-foundation.org, 
	alexander.shishkin@linux.intel.com, anna-maria@linutronix.de, 
	bigeasy@linutronix.de, catalin.marinas@arm.com, chenhuacai@kernel.org, 
	francesco@valla.it, frederic@kernel.org, guoweikang.kernel@gmail.com, 
	jstultz@google.com, kpsingh@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, mark.rutland@arm.com, maz@kernel.org, 
	mingo@kernel.org, pmladek@suse.com, rrangel@chromium.org, sboyd@kernel.org, 
	urezki@gmail.com, v-singh1@ti.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Apologies, subject missing; it's:
time: introduce BOOT_TIME_TRACKER and minimal boot timestamp


On Mon, Sep 1, 2025 at 9:36=E2=80=AFAM Kaiwan N Billimoria
<kaiwan.billimoria@gmail.com> wrote:
>
> > What the heck is BOOT SIG Initiative?
> Very, very briefly: it's an initiative that plans to measure the complete=
 or
> unified boot time, i.e., the time it takes to boot the system completely.=
 This
> includes (or plans to) track the time taken for:
> - Boot from CPU power-on, ROM code execution
> - 1st, 2nd, (and possibly) 3rd stage bootloader(s)
> - Linux kernel upto running the PID 1 process
> - Include time taken for onboard MCUs (and their apps to come up).
>
> The plan is to be able to show the cumulative and individual times taken =
across
> all of these. Then report it via ASCII text and a GUI system (as of now, =
a HTML
> file).
> For anyone interested, here's the PDF of a super presentation on this top=
ic by
> Vishnu P Singh (OP) this August at the OSS EU:
> https://static.sched.com/hosted_files/osseu2025/a2/EOSS_2025_Unified%20Bo=
ot%20Time%20log%20based%20measurement.pdf
> As mentioned by Vishnu, the work is in the very early dev stages.
>
> > -     pr_info("sched_clock: %u bits at %lu%cHz, resolution %lluns, wrap=
s every %lluns\n",
> > -             bits, r, r_unit, res, wrap);
> > +     pr_info("sched_clock: %pS: %u bits at %lu%cHz, resolution %lluns,=
 wraps every %lluns hwcnt: %llu\n",
> > +             read, bits, r, r_unit, res, wrap, read());
> --snip--
> > So let's assume this give you
> >
> > [    0.000008] sched_clock: 56 bits at 19MHz, resolution 52ns, wraps
> >                             every 3579139424256ns hwcnt: 19000000
> >
> > Which means that the counter accumulated 19000000 increments since the
> > hardware was powered up, no?
> I agree with your approach Thomas (tglx)! (eye-roll)... So, following thi=
s
> approach, here's the resulting tiny patch:
>
> From 1e687ab12269f5f129b17eb7e9c3c5c2cec441b7 Mon Sep 17 00:00:00 2001
> From: Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
> Date: Mon, 1 Sep 2025 09:17:57 +0530
> Subject: [PATCH] [sched-clock] Extend printk to show h/w counter in a
>  parseable manner
>
> Signed-off-by: Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
> ---
>  kernel/time/sched_clock.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
> index cc15fe293719..e4fe900d6b60 100644
> --- a/kernel/time/sched_clock.c
> +++ b/kernel/time/sched_clock.c
> @@ -236,16 +236,14 @@ sched_clock_register(u64 (*read)(void), int bits, u=
nsigned long rate)
>         /* Calculate the ns resolution of this counter */
>         res =3D cyc_to_ns(1ULL, new_mult, new_shift);
>
> -       pr_info("sched_clock: %u bits at %lu%cHz, resolution %lluns, wrap=
s every %lluns\n",
> -               bits, r, r_unit, res, wrap);
> +       pr_info("sched_clock: %pS: bits=3D%u,freq=3D%lu %cHz,resolution=
=3D%llu ns,wraps every=3D%llu ns,hwcnt=3D%llu\n",
> +                read, bits, r, r_unit, res, wrap, read());
>
>         /* Enable IRQ time accounting if we have a fast enough sched_cloc=
k() */
>         if (irqtime > 0 || (irqtime =3D=3D -1 && rate >=3D 1000000))
>                 enable_sched_clock_irqtime();
>
>         local_irq_restore(flags);
> -
> -       pr_debug("Registered %pS as sched_clock source\n", read);
>  }
>
>  void __init generic_sched_clock_init(void)
> --
> 2.43.0
>
> Of course, this is almost identical to what Thomas has already shown. I'v=
e
> added some formatting to make for easier parsing. A sample output obtaine=
d with
> this code on a patched kernel for the BeaglePlay k3 am625 board:
> [    0.000001] sched_clock: arch_counter_get_cntpct+0x0/0x18: bits=3D58,f=
req=3D200 MHz,resolution=3D5 ns,wraps every=3D4398046511102 ns,hwcnt=3D1409=
443611
>
> This printk format allows us to easily parse it; f.e. to obtain the hwcnt=
 value:
> debian@BeagleBone:~$ dmesg |grep sched_clock |awk -F, '{print $5}'
> hwcnt=3D1409443611
>
> So, just confirming: here 1409443611 divided by 200 MHz gives us 7.047218=
055s
> since boot, and thus the actual timestamp here is that plus 0.000001s yes=
?
> (Over 7s here? yes, it's just that I haven't yet setup U-Boot properly fo=
r uSD
> card boot, thus am manually loading commands in U-Boot to boot up, that's=
 all).
>
> A question (perhaps very stupid): will the hwcnt - the output of the read=
() -
> be guaranteed to be (close to) the number of increments since processor
> power-up (or reset)? Meaning, it's simply a hardware feature and agnostic=
 to
> what code the core was executing (ROM/BL/kernel), yes?
> If so, I guess we can move forward with this approach... Else, or otherwi=
se,
> suggestions are welcome,
>
> Regards,
> Kaiwan.


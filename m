Return-Path: <linux-kernel+bounces-734698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B360BB084ED
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 08:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 675307A932B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 06:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C1C21767D;
	Thu, 17 Jul 2025 06:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sbHWwg4h"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A138D217707
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 06:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752733895; cv=none; b=IBO9m7FpIOU8b4TFVxG1nMt/wPO6AOUFyxgPIGj3IJQ8Pwe4JSmpzZbbEj2t+jbGgxZISMUvAban5y5iDqK4eQHWu8NvW/aBv/D/rrkImWcV45C0J57tiPuYGo6hMPtblvALONI2sK/ja2SVk/Wpb6Y2rnxl0b8HXFcpgceVUSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752733895; c=relaxed/simple;
	bh=Z3nMzBNMQJhkw+Db8SYzD3+6WKD4XlRLevv7kMhG7M4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jLGPTKITeUIoX5njQZKMCNnFNk6Yk4/i7KJ3a/XNyrZQPGdKOBPlilS/3w5Gvc15dkpc6+d38IgDMTeaxIdOYIIk0d0stjPlfO2vpUvhP7T8NSH24Zhb4pixLR04ERydYeT3PHKNh0lI2CP+O+u1LgptlAyMvNfifhqvYyjE2jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sbHWwg4h; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ab8e2c85d7so9097841cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 23:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752733892; x=1753338692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TFKIsQ6iNNtZZF3Du2FdB9bGbfigbMp5SNRZxQs4rkE=;
        b=sbHWwg4hnQYLXIx57wPHwWwtup444Gmbx6T3nwk0qJCXqPGKQttgnr0cp5RCsO06BT
         bnZxC/cKNj2/7mp7QRQBUDOBrPQQhdih5g8DBwpNFD+U/aFYt7Bxo7K875f8KP4z8PPg
         oooQADER1fpqTupTs2tQUMqLIMWmh9i4VRlIru6JRIM36eY/Nwi29po6QRSjRfx3BASr
         iOGNx7D/7ejiqSRWJViWoEnwuTYYs0/DRoJVeDX1jkvwcK320x9THEAzIMmRh0AgeQ45
         hYFJheRLQGsIenWlhZNhkXJBWo4kIt8vtbqF5RccCM4mrNgHV528gKODvqi4qfgTD5Oo
         ht/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752733892; x=1753338692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TFKIsQ6iNNtZZF3Du2FdB9bGbfigbMp5SNRZxQs4rkE=;
        b=CPTpWCVRTamGIKna3bA2GiRbqDvTHZAknQIpTlsxKOOJa0/BrzEgruuKfjFzlme/Y4
         4TC6FoQq8EKvDjfQ70R8bF/D9UDRYlKGRHu98z8EgOUteXuGcJZ6dAdZ5QTlDyAxbw+/
         ZA+AEoyCLCHVfU1jwdT4oVaAbJgpbtMHBpMeCFTp7uyjWnCk76Wh//EKkpdZMwRz0Dsa
         HGFu37Me4gM0ug1aF47Bm82swglZKsbOixRfKwbaqfGOAZVjoEHPsKdc104O+/ucSSa9
         bFRaT65qqOdfUHPpq4IWy9rdX+eOzZXyJKrC35ecUnhEOTHMbl8CvUQyFTcbsgCYwgYJ
         f9oQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdNrbVKm8q8grCA3QaJQHjnnZdCzNnl9HTWxq/Wo4z8aZGpzKlX79wFOEeIzefgLSEKQilXooJmCKZehg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyi5D4vOmP+1BJh3YCfhrot85X72RQ6vWPeaHGK81h/0Gya9Ng
	/KSnUAjLeGIbXknfnTT+rCo8xcaPqLEXIIeWqI6ZSaWSECDfX6Rjf1w3QTEAG7ZosIJmZM1EeRW
	lOyLiSQENSKAazMi1JtC59IJbh9VQq8hM4vX5MLZh
X-Gm-Gg: ASbGncuSoO5rGFhj8j8PMl0ufcQOQmDdGYk1L/JDHp4noXLiiW7i6lJl7zmxlxILeUZ
	e02ycfA8BkOe8QfeUm0No0qX8E5bQTdIIZNLhYYwaQuivsUq8yP+3VyhLuJ0kEU19L4THUOFFk4
	Xje6jpQqGhkj9R3WbB6yMDTbWsZq+LaTyqXcQpRCbfgpwktIA5qcDAm7P7wDcWKHvOH5L6uIb3B
	dEW0drZCwM5UCWpICIx6mxrkD3b2LuQit9kVExAotmHanM4
X-Google-Smtp-Source: AGHT+IGEbJhY4DfxEpZKIPYIBJ/rhqZtUITOnzqog6b/XfJIxSxeQoR8JLRFE0dNcb52FJM82weIgPKIldnKGNR1STE=
X-Received: by 2002:a05:622a:41:b0:4ab:8d13:7151 with SMTP id
 d75a77b69052e-4ab93c43046mr90041101cf.7.1752733892205; Wed, 16 Jul 2025
 23:31:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714033649.4024311-1-suleiman@google.com> <20250714033649.4024311-2-suleiman@google.com>
 <aHXnO6KapsNLjocd@google.com>
In-Reply-To: <aHXnO6KapsNLjocd@google.com>
From: Suleiman Souhlal <suleiman@google.com>
Date: Thu, 17 Jul 2025 15:31:19 +0900
X-Gm-Features: Ac12FXyfLxSbuS-HTvNNG4tE_g4D4Q8xxWx82Vy566yxYvgG8eAtPQDkbsFxaIc
Message-ID: <CABCjUKB07exDN9nkjoio7LFct51GRaT=ZGXUq3iwoqfLog-trA@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] KVM: x86: Advance guest TSC after deep suspend.
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Chao Gao <chao.gao@intel.com>, 
	David Woodhouse <dwmw2@infradead.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, John Stultz <jstultz@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ssouhlal@freebsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 2:29=E2=80=AFPM Tzung-Bi Shih <tzungbi@kernel.org> =
wrote:
>
> On Mon, Jul 14, 2025 at 12:36:47PM +0900, Suleiman Souhlal wrote:
> > Try to advance guest TSC to current time after suspend when the host
> > TSCs went backwards.
> >
> > This makes the behavior consistent between suspends where host TSC
> > resets and suspends where it doesn't, such as suspend-to-idle, where
> > in the former case if the host TSC resets, the guests' would
> > previously be "frozen" due to KVM's backwards TSC prevention, while
> > in the latter case they would advance.
> >
> > Suggested-by: Sean Christopherson <seanjc@google.com>
> > Signed-off-by: Suleiman Souhlal <suleiman@google.com>
>
> Tested again with comparing `date` before and after suspend-to-RAM:
>   echo deep >/sys/power/mem_sleep
>   echo $(date '+%s' -d '+3 minutes') >/sys/class/rtc/rtc0/wakealarm
>   echo mem >/sys/power/state
>
> Without the patch, the guest's `date` is slower (~3 mins) than the host's
> after resuming.
>
> Tested-by: Tzung-Bi Shih <tzungbi@kernel.org>

Thanks for testing!

>
> > @@ -5035,7 +5035,36 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, i=
nt cpu)
> >
> >       /* Apply any externally detected TSC adjustments (due to suspend)=
 */
> >       if (unlikely(vcpu->arch.tsc_offset_adjustment)) {
> > +#ifdef CONFIG_X86_64
> > +             unsigned long flags;
> > +             struct kvm *kvm;
> > +             bool advance;
> > +             u64 kernel_ns, l1_tsc, offset, tsc_now;
> > +
> > +             kvm =3D vcpu->kvm;
> > +             advance =3D kvm_get_time_and_clockread(&kernel_ns, &tsc_n=
ow);
> > +             raw_spin_lock_irqsave(&kvm->arch.tsc_write_lock, flags);
> > +             /*
> > +              * Advance the guest's TSC to current time instead of onl=
y
> > +              * preventing it from going backwards, while making sure
> > +              * all the vCPUs use the same offset.
> > +              */
> > +             if (kvm->arch.host_was_suspended && advance) {
> > +                     l1_tsc =3D nsec_to_cycles(vcpu,
> > +                                             kvm->arch.kvmclock_offset=
 + kernel_ns);
> > +                     offset =3D kvm_compute_l1_tsc_offset(vcpu, l1_tsc=
);
> > +                     kvm->arch.cur_tsc_offset =3D offset;
> > +                     kvm_vcpu_write_tsc_offset(vcpu, offset);
> > +             } else if (advance) {
> > +                     kvm_vcpu_write_tsc_offset(vcpu, kvm->arch.cur_tsc=
_offset);
> > +             } else {
> > +                     adjust_tsc_offset_host(vcpu, vcpu->arch.tsc_offse=
t_adjustment);
> > +             }
> > +             kvm->arch.host_was_suspended =3D false;
> > +             raw_spin_unlock_irqrestore(&kvm->arch.tsc_write_lock, fla=
gs);
> > +#else
> >               adjust_tsc_offset_host(vcpu, vcpu->arch.tsc_offset_adjust=
ment);
> > +#endif /* CONFIG_X86_64 */
>
> Wondering if it needs to acquire the `tsc_write_lock`, given that:
> - The original code adjust_tsc_offset_host() doesn't acquire.  Note:
>   adjust_tsc_offset_host() eventually calls kvm_vcpu_write_tsc_offset() t=
oo.
> - Documentation/virt/kvm/locking.rst [1].
>
> [1] https://elixir.bootlin.com/linux/v6.15/source/Documentation/virt/kvm/=
locking.rst#L264

This is an excellent question.
I used a lock here to make sure that only one VCPU computes the offset
and that all the others reuse it.
It might be doable with atomic operations, but using a lock seemed
simpler to me.
I don't think it has to be tsc_write_lock specifically, but reusing it
for this purpose seemed appropriate to me.

Thanks,
-- Suleiman


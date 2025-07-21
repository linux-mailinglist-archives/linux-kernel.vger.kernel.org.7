Return-Path: <linux-kernel+bounces-739147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6353B0C25E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80F993ABB2E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 11:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8F6298CB5;
	Mon, 21 Jul 2025 11:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="DnwYFzih"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8742980C2
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 11:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753096453; cv=none; b=F0vYjYVB07jvFHI4Z3NLZMaT8eNAZKwXNUUJqkIn2a0NC/YX8KNXHKeJNYVhSbrrOu4lsZCgV8eK8JRdgu8eUxMeBTYMe/Vy5R8L7iGExanQ9FTljW/oCN4kZV6uRy1NC2kxuLIxWgAKuLN/vQ5yq++3H598CKW0s5fyOsH3BQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753096453; c=relaxed/simple;
	bh=fLbKWdOARv40pCY4qGliofKyRxzK3AsCP0pWclC3jfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KtdK3g1MfEE1nM6w4JWML7Dx4s9o7UBQU9Y4v/XEsqZeaArQ5H2OZV7JvUQNsWFogGqTkMCFVbx4w+3vuHOYzNZJZz2ncbp6xiZkruf/fNwTa8VEkCNJT6fDBzOBEVOLox5VR/IeyU0Lc/g3LMHVUwCaliGGjZ0UWDB9LXnHF7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=android.com; spf=pass smtp.mailfrom=android.com; dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b=DnwYFzih; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=android.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=android.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ab554fd8fbso42343581cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 04:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20230601; t=1753096451; x=1753701251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GtlRa4EnHRvRTTXOu323ubV7Cd4GPOUPDvFH3dEXzK8=;
        b=DnwYFzihBM/jOWjjfgFVjHHsjS0mP/SgkzxH0bI2GqQOOONz992+T1jI51Mty6NOZU
         uchyt0kuJMJy+B0HMhIMfpGI5kGGXnvtRfngYZZldCQM2CycEMkcxfjOjCzaa9fT5uY3
         Npwwu9JqMp5yRWs2r3V0q9olkApecUiWRNNraoN4O3AevjcHb/uuicXMpkGlRIgJ9JRb
         5AArrDdq9fO2D3X0LY6wd7rfylY1x6KsXEMLxRItM6CuBayB1/J7Njcz/I6yw2o664HB
         ttOa6gA4ZdOqtjwe5BpZj9V7gffpPKZqehRcpBy6phuXnJF+a3kItpi5iOBAcqM1Haj9
         qUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753096451; x=1753701251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GtlRa4EnHRvRTTXOu323ubV7Cd4GPOUPDvFH3dEXzK8=;
        b=a6vTRqd73jx/vEn9gMKoJS0HcAnDgK46jb5bwA96TREkC+ndc8h8iJuMwaEm9i1voK
         YfUNfYof9B6R/MtNiRj35RJgbt8aNGRSS8RcAqmCM+IYOuxPOUMrJOVL7ci64JpmdTiM
         wdwHumkV5mNbp90TqOjBG++0uMmGtljdyaGlxCM7yQ0R/JtRhxXDhhNAGxXgBrrPKNxc
         s5RzZASeUskpYoeEIVafAWDS322bOl6tN9UA2d4mRRcpOz7p53d1Foz/nkRuy04soJZo
         i44jtaCIpQQIKbPuCcR2cOqSvEceIkzke8BIKSpJuUKRDwGvf+5m/KQ4CtH5srTAFmPH
         24og==
X-Forwarded-Encrypted: i=1; AJvYcCXTO6wITcXfvFe5vhFHsQdd8zhtmox+q6DETVfqzYTCfGJ9Y1/g2Lhw8UIENBM3eoGgf0JMOuLzdJTCiQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRUYrARNDgG0Axj1QBXSfG2U/MZBfA9d64MPYtj9iIPCZcgKlS
	Zqt00yoH+zWswD5qsScRMNhNt2N7pMlis1LyK4QG3kKPfF60FgkniHXU+NeZ7n/I59D2juV9Nnh
	PLU0cXEziFjf5oH1Q3Vik2wzxHF3dWzK+ax8kQhdF
X-Gm-Gg: ASbGnct4cwmDRq2Y61Wsf/Yhhy0XvZW//9vJVfIuFNuFfDWtcaF+wgDoUTUcotBBip3
	pMnHcpud1Zl2GIZGl1XTlIId+meQSfWVrws8isVeERm3l7bn3J4yV4X43NSlYiob9uGcY+v5t3l
	L6gKD8ftrVyUr9FQLU/kfETmJLjcnF22594XJwBOuiwSzh4fltfO3BM2ixrdAeENsWnt2+YRgTE
	VE3lTvK/RwRT+3R2l0DZIHGapkk43I7dSQzVg96IQ==
X-Google-Smtp-Source: AGHT+IF/Z0HI6TmXWcSejGmxIumXwzv7Wt4N9tNfpJJWx7Y46lpv4IgUdvc+GB5ne/UGCDyxnW+oQUgbgPZJGkXl9xU=
X-Received: by 2002:a05:6214:3305:b0:704:f44a:75ff with SMTP id
 6a1803df08f44-705162103c4mr156533906d6.22.1753096450633; Mon, 21 Jul 2025
 04:14:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701-virtio-msg-ffa-v7-0-995afc3d385e@google.com>
 <20250701-virtio-msg-ffa-v7-5-995afc3d385e@google.com> <aHpRvBO864x1vvqP@willie-the-truck>
In-Reply-To: <aHpRvBO864x1vvqP@willie-the-truck>
From: =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>
Date: Mon, 21 Jul 2025 04:13:59 -0700
X-Gm-Features: Ac12FXyFG5yEbBpu73BqZFIB9DdaO3n1VasDGNS_MIwe8KNKSUyKkMDnLJwSvog
Message-ID: <CAMP5XgenLo3dk=NB-iJ4MLs5azB7w=0RHkbQJRGb_qMnixCTsQ@mail.gmail.com>
Subject: Re: [PATCH v7 5/5] KVM: arm64: Support FFA_MSG_SEND_DIRECT_REQ2 in
 host handler
To: Will Deacon <will@kernel.org>
Cc: perlarsen@google.com, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, ahomescu@google.com, armellel@google.com, 
	ayrton@google.com, qperret@google.com, sebastianene@google.com, 
	qwandor@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 6:53=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> On Tue, Jul 01, 2025 at 10:06:38PM +0000, Per Larsen via B4 Relay wrote:
> > From: Per Larsen <perlarsen@google.com>
> >
> > FF-A 1.2 adds the DIRECT_REQ2 messaging interface which is similar to
> > the existing FFA_MSG_SEND_DIRECT_{REQ,RESP} functions except that it
> > uses the SMC calling convention v1.2 which allows calls to use x4-x17 a=
s
> > argument and return registers. Add support for FFA_MSG_SEND_DIRECT_REQ2
> > in the host ffa handler.
> >
> > Signed-off-by: Per Larsen <perlarsen@google.com>
> > ---
> >  arch/arm64/kvm/hyp/nvhe/ffa.c | 24 +++++++++++++++++++++++-
> >  include/linux/arm_ffa.h       |  2 ++
> >  2 files changed, 25 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ff=
a.c
> > index 79d834120a3f3d26e17e9170c60012b60c6f5a5e..21225988a9365219ccfd69e=
8e599d7403b5cdf05 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/ffa.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
> > @@ -679,7 +679,6 @@ static bool ffa_call_supported(u64 func_id)
> >       case FFA_NOTIFICATION_GET:
> >       case FFA_NOTIFICATION_INFO_GET:
> >       /* Optional interfaces added in FF-A 1.2 */
> > -     case FFA_MSG_SEND_DIRECT_REQ2:          /* Optional per 7.5.1 */
>
> I think that's the only change needed. In fact, maybe just don't add it
> in the earlier patch?
>
> >       case FFA_MSG_SEND_DIRECT_RESP2:         /* Optional per 7.5.1 */
> >       case FFA_CONSOLE_LOG:                   /* Optional per 13.1: not=
 in Table 13.1 */
> >       case FFA_PARTITION_INFO_GET_REGS:       /* Optional for virtual i=
nstances per 13.1 */
> > @@ -862,6 +861,22 @@ static void do_ffa_part_get(struct arm_smccc_1_2_r=
egs *res,
> >       hyp_spin_unlock(&host_buffers.lock);
> >  }
> >
> > +static void do_ffa_direct_msg2(struct arm_smccc_1_2_regs *regs,
> > +                            struct kvm_cpu_context *ctxt,
> > +                            u64 vm_handle)
> > +{
> > +     DECLARE_REG(u32, endp, ctxt, 1);
> > +
> > +     struct arm_smccc_1_2_regs *args =3D (void *)&ctxt->regs.regs[0];
> > +
> > +     if (FIELD_GET(FFA_SRC_ENDPOINT_MASK, endp) !=3D vm_handle) {
> > +             ffa_to_smccc_error(regs, FFA_RET_INVALID_PARAMETERS);
> > +             return;
> > +     }
>
> Why do we care about checking the src id? We don't check that for
> FFA_MSG_SEND_DIRECT_REQ and I don't think we need to care about it here
> either.
>
> Will

I think not checking the src id for FFA_MSG_SEND_DIRECT_REQ is a bug
that should be fixed as well. The receiver expects the hypervisor to
have validated this. If the src id is not validated here then the host
can impersonate other VMs or even the hypervisor itself. This bug
might be minor at the moment since other VMs can't send messages at
the moment, but it is still a bug that needs to be fixed at some
point.

--=20
Arve Hj=C3=B8nnev=C3=A5g


Return-Path: <linux-kernel+bounces-872823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CC7C121DB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 00:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A52DC46701D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 23:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F8B328610;
	Mon, 27 Oct 2025 23:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JKkpqAPF"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654CE2DE709
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 23:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761609506; cv=none; b=OK1nPa0QldknivaBN+sC8trvgNJ6YGSSwrfXUzb+4KEYiMJ+obNKTd0vMZlp1kf3DT5eAqBQa6Ov8FegDNM5gjq4Oemkfe2mr/mNdQQ03A5jfheoU1aJ46nT/l9OhNOiU8aMilRpcx2L0TDQ8IDDMc0MQI0ofCOiK25hC/myGKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761609506; c=relaxed/simple;
	bh=B3mpFVAR6ZmcNWLBi88Xta8WGYLy+I86D02flIVttrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XGSwvriTsrzPJ/G33GtJDCJD02sXJUM+NvVjLNUENb7iyeyzwE2vnjz49Er1DLwf7H5wcwED8DO7/ESUgnOfIuHTDT6hFaZxA5h3Thaw7g+Mywz0attfSYB+SYizL0mECuUV5Vr58ytUVksRVTP7NaEBpuhM1WzVXJ/D6fOIzx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JKkpqAPF; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-63c44ea68f6so4725a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 16:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761609503; x=1762214303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9F1wSsSxhw2D505fXHUdjLY9NdHqh0zXhSCGVR/itg=;
        b=JKkpqAPF2K0zQPqB6mLPQdzCvXG3z9KleGjfprAjVFPvnTyU79PccWGIckYtl5eqPt
         WBhZcrTWIFxDBax5bhpNbLvNk/lDuwE0T14uiLre4McmpbHnY8bi9aKyMwbrYcj3KQLR
         Jq+yez/2IUM5pK/4HBqeHyBDEnEnLDuDehTQLfp+vtQSXoQ2KBDu/MecyHYzXUAFBmsm
         MCm1kOv59mrPEweqLxUhqLs2yee+6r8K/ts7JL0CaW4Aw2/IZ2cMBvB1yVk1gNsO29BD
         RhSV2uuoDIB1AiyWqoWPRyxD5BLXbmNqpP1EpGSHA4SH5kcCM8S/cV+FjRP5fyX1Ur4W
         B/hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761609503; x=1762214303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k9F1wSsSxhw2D505fXHUdjLY9NdHqh0zXhSCGVR/itg=;
        b=qTmdtmiDWT2zr6FyY59LvrTylObyKyj8q51dFaYlIYSRJ3EV4Q+QfdoW83bN9AGKmk
         IFvMTtL9Zb9ayf9/ZCBJ4peNy5r5QQABvSLTkmCIZxPzJPqKYeuis8SUOU9o1EHFtdzU
         S45v7OIvCL9xiXRncRd4m6W/ZjmGP+0samdBnzzJIiAwWaYRSnzTJvmug2yC8GqxQxqy
         fUkk6EYceKnlAD2sKVHHsf6SLX/aXn6nnL4IRlU3EmGL0psQE2T15neea2quB9GmWp6x
         qW3UzS41tediaJvKIH+lBhTiSsP+3zSlI8yMapcxLxIURV0MqAI5mvGHGKvnv/z8soEO
         VAiQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+nL2aNGtPeQui71zsqDnKlDN/BOSBcR5IuOPaq6I/ghT+lr7eArygsthZuGuSa6xMv1a0LbBaLovEtoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdHSYb39DC8WMhLcjvvJckK6n8rKDUA5YR3iNYz4eVp0ixBcbA
	Xq5UyqiNnfIlP3opR61N5WOh0RqKKafq4H56WJsu9auVitHIvS+d5FOUg2ALa+0GP+n6kYcgNfP
	GT+TZSOn/1M1s/tRSJkMLguelRAoPpkWrbYV/PYOM
X-Gm-Gg: ASbGncu+ZVpc+3OK8l00VNfBezYmHWwMGlO2CNFk9lnzaW2ALqh1CH8ZHqHMRQG8rhN
	NFMECIXeSi7yX99gz+pkp2GjFURLjs8Tg7xAbnzL8pDTdfU+/vviE10CgwdeyCL3SRG8tQuB+6o
	YYxyhU1CTDgwoIP1iyPM0jxnV0rlHVmtAagSIeYERo7qpRCC/b3P4UKhK8c7b9dBB3I0soQgP+K
	NYHr5oHv4sCWtmpBfjTjZBosJKyFVUWCQxQ29xAq5tXzFtjh2Ap4jmnYXnhZTPfQK/yKgc=
X-Google-Smtp-Source: AGHT+IFI7RbCRSrkZ+26mAjogVrTWudlWrC8fSNj8O9PmlVdQ7Csv0X4ZvVnTgaBHpL6T+OSCphRK3ecNFW9+faxMrM=
X-Received: by 2002:a05:6402:206:b0:634:b4b5:896f with SMTP id
 4fb4d7f45d1cf-63f6f88db75mr39252a12.4.1761609502550; Mon, 27 Oct 2025
 16:58:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016200417.97003-1-seanjc@google.com> <20251016200417.97003-2-seanjc@google.com>
 <DDO1FFOJKSTK.3LSOUFU5RM6PD@google.com> <aPe5XpjqItip9KbP@google.com>
 <20251021233012.2k5scwldd3jzt2vb@desk> <20251022012021.sbymuvzzvx4qeztf@desk>
 <CALMp9eRpP0LvMJ=aYf45xxz1fRrx5Sf9ZrqRE8yKRcMX-+f4+A@mail.gmail.com> <20251027231721.irprdsyqd2klt4bf@desk>
In-Reply-To: <20251027231721.irprdsyqd2klt4bf@desk>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 27 Oct 2025 16:58:10 -0700
X-Gm-Features: AWmQ_bk2eMNKxzyzah9DPVxHOoXxsYy6Xljo8QBDtIqM98MaTcgTmbgiB2zzshM
Message-ID: <CALMp9eSVt22PW+WyfNvnGcOciDQ8MkX9vDmDZ+-Q2QJUH_EvHw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] KVM: VMX: Flush CPU buffers as needed if L1D cache
 flush is skipped
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Brendan Jackman <jackmanb@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 4:17=E2=80=AFPM Pawan Gupta
<pawan.kumar.gupta@linux.intel.com> wrote:
>
> On Mon, Oct 27, 2025 at 03:03:23PM -0700, Jim Mattson wrote:
> > On Tue, Oct 21, 2025 at 6:20=E2=80=AFPM Pawan Gupta
> > <pawan.kumar.gupta@linux.intel.com> wrote:
> > >
> > > ...
> > > Thinking more on this, the software sequence is only invoked when the
> > > system doesn't have the L1D flushing feature added by a microcode upd=
ate.
> > > In such a case system is not expected to have a flushing VERW either,=
 which
> > > was introduced after L1TF. Also, the admin needs to have a very good =
reason
> > > for not updating the microcode for 5+ years :-)
> >
> > KVM started reporting MD_CLEAR to userspace in Linux v5.2, but it
> > didn't report L1D_FLUSH to userspace until Linux v6.4, so there are
> > plenty of virtual CPUs with a flushing VERW that don't have the L1D
> > flushing feature.
>
> Shouldn't only the L0 hypervisor be doing the L1D_FLUSH?
>
> kvm_get_arch_capabilities()
> {
> ...
>         /*
>          * If we're doing cache flushes (either "always" or "cond")
>          * we will do one whenever the guest does a vmlaunch/vmresume.
>          * If an outer hypervisor is doing the cache flush for us
>          * (ARCH_CAP_SKIP_VMENTRY_L1DFLUSH), we can safely pass that
>          * capability to the guest too, and if EPT is disabled we're not
>          * vulnerable.  Overall, only VMENTER_L1D_FLUSH_NEVER will
>          * require a nested hypervisor to do a flush of its own.
>          */
>         if (l1tf_vmx_mitigation !=3D VMENTER_L1D_FLUSH_NEVER)
>                 data |=3D ARCH_CAP_SKIP_VMENTRY_L1DFLUSH;
>

Unless L0 has chosen L1D_FLUSH_NEVER. :)

On GCE's L1TF-vulnerable hosts, we actually do an L1D flush at ASI
entry rather than VM-entry. ASI entries are two orders of magnitude
less frequent than VM-entries, so we get comparable protection to
L1D_FLUSH_ALWAYS at a fraction of the cost.

At the moment, we still do an L1D flush on emulated VM-entry, but
that's just because we have historically advertised
IA32_ARCH_CAPABILITIES.SKIP_L1DFL_VMENTRY to L1.


Return-Path: <linux-kernel+bounces-862591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2D8BF5B33
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3A2F44E6C66
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8063E328B68;
	Tue, 21 Oct 2025 10:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VU6zeb5I"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4471B1DE3A4
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761041322; cv=none; b=G6D1nx4O8T+NQuJI7OGIx7voIUD4oKvwqodhJVxcSk/NfMU/32g7UuKVYe77ZPkZyRMox550BOa76w4t84+WI363MRczIAb0clSTqIXcxkbbkiPSJXVQF1h3DRNdZPG4cd7U+5Fn8aQC2s58nPrBJi5CVHzQttwpj8fr3RtdGLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761041322; c=relaxed/simple;
	bh=qAbJyQPPInrxKG97wEiG3fxqPfQEM6oQEkIzdBx2QKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=boubHarJXWxe31FccnVWw1LthTjwJCYKBZ3sgrdziGaUr/lzYHVcGIo/bA3Hy3kk+tnItpbYbMHHYJE4BYboASvRCEI8xKs7D3jcfYxpQhJtJE8U/qsOhBoHhNN98bhTEWDG+O3+fNIDdk/lGgKz8hlWR9eT9f4IYvw1GdW8m1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VU6zeb5I; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-71d71bcac45so57396317b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 03:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761041319; x=1761646119; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FcY1WuRhXouiGA4KCWU+G5cXctN3EhAkLVSQq5aIkDA=;
        b=VU6zeb5ITjgm6HsjuHLQtKaFcRpUmaTE7qMmuyBuM97iK4xuFFT2ibCUCWn6U9vLFO
         +Bdl+Lm81GjNDuqf12b57tkzf/p6HGT5y/f+rp6gg8qj8w//fU0cWDTEMG2peNGgpknX
         XkQxAisH9BkOaXNrwgZq5Nqmrdp0R4wYTDtRuGXro8FMsk5wglFjSZTUXbApGHelYHKM
         yVRM0KxFMrFJ6boZMFlNJS+qbunguqNk6HvFui1/QcTxY80BGFXGKQIuW7rp9nSxk7oj
         e1svSpqgbtZM6yZmAFCnpizgr1DBF27p7bRM3uVv2SZXZX8fABPQYby/kcY3pzP6Odzq
         K2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761041319; x=1761646119;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FcY1WuRhXouiGA4KCWU+G5cXctN3EhAkLVSQq5aIkDA=;
        b=k2ZyXh/xPsXD0VET5IAkqPOX18V9/Reak2nO1FrQwxligkb+okWvrBmPCx67yAIFZc
         HqWm6s+qsDmJP1qiU8LaKHAOud0Sn12L1W8tk6CCs1PHSxAhdflBO+21dYEVAPvr6RKk
         d9t44NVtixQiNw3qZ4Mq/+1oAT3+92g8316lr8zf1z8bKR+BnDT3oWJ4FH056c5Xz84I
         LxAO2gI0ubDHf7s83EOS84uu0P43JTqYHZ3W14WpbMcnIvRj2Qsnz5ramLJDCj+n9LnX
         fQAVdqgpyjfoqYJPnxbUJD3mnQF7/0SGaW9tfgH9s/8LzMTc8brO53YNHm9uldk4heG5
         XOQg==
X-Forwarded-Encrypted: i=1; AJvYcCVDXDv0tG95/SEr02BYsZmhlJS7PcicUSIQQM7xsNSVaiKday1xAjojzydtAKgSmEBtFd3cgXB4/RQZyaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsL62TSiGTqO4KoJu2D3Wtkh2ImVWZXr1lTAcYLksYsU742AJK
	FJWP2m102AM/bjagPDB4iitLOpCmcAktOFumnnfeTx5dKVZ9smvyRy2qx7R6+Mha94LXdAZ78lU
	sXEkbMLnpC+iIbfCis5dl3tu8PWM7TvUi3k/aCKBldw==
X-Gm-Gg: ASbGnctUd3cSo28NOiVsDHW6eu4Igiol0OEGijgFmrR8J1L4Nx940chAPbL5ey/hpTB
	J1bosW6wnwijF7znS9XlHiIFUDC8RWeQt5Cl4ryF/arZeHXSgDSjZttqM1fzWeRJAHCgYp3D6C+
	5iB+mrrYWEjSw38dK76QojiR9rVpQFhX+4wRJiA3GfniQJt323Y/8J1luwIGXsQrM+elcxtbBzt
	H/tP234EFl/cgrQXhW8ZWvOe3jovBsbeaeWnSR6+2QpqNEBIwvq5pH0lYPsRA==
X-Google-Smtp-Source: AGHT+IER588Lwab2jH1RPVxWEMKtc71AdHZ7rUDhw6Az9ENBa6h+mO9XQH92FP+m3bjNm6autc5uWg5ixjt23yxAFE0=
X-Received: by 2002:a05:690e:d51:b0:636:d3f9:6418 with SMTP id
 956f58d0204a3-63e1610c2eamr12824971d50.22.1761041319091; Tue, 21 Oct 2025
 03:08:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020141718.150919-1-ulf.hansson@linaro.org>
 <20251020141718.150919-2-ulf.hansson@linaro.org> <a0120876-0f00-4e1a-aa17-5fe7c3512276@arm.com>
In-Reply-To: <a0120876-0f00-4e1a-aa17-5fe7c3512276@arm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 21 Oct 2025 12:08:02 +0200
X-Gm-Features: AS18NWAG0JIz8WscydJtNeviSVU0idBmTgh-4-AojKeBaYrYkaU30tTtBYxU8G4
Message-ID: <CAPDyKFrY5kOsoOH-mcWFiaiggV4q84xOtiKHdNN4bMfFmYOQPQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] smp: Introduce a helper function to check for
 pending IPIs
To: Ben Horgan <ben.horgan@arm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, 
	Maulik Shah <quic_mkshah@quicinc.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Oct 2025 at 21:11, Ben Horgan <ben.horgan@arm.com> wrote:
>
> Hi Ulf,
>
> Only a comment on the naming rather than a full review.
>
> On 10/20/25 15:17, Ulf Hansson wrote:
> > When governors used during cpuidle, tries to find the most optimal
> > idlestate for a CPU or a group of CPUs, they are known to quite often fail.
> > One reason for this, is that we are not taking into account whether there
> > has been an IPI scheduled for any of the CPUs that are affected by the
> > selected idlestate.
> >
> > To enable pending IPIs to be taken into account for cpuidle decisions,
> > let's introduce a new helper function, cpus_may_have_pending_ipi().
>
> To me, "may" indicates permission, i.e. is allowed, rather than
> correctness. Would "likely" be better here, cpus_likely_have_pending_ipi()?

Sure, that sounds better to me too.

I leave it a few days to allow people to provide their additional
input, before posting a new version with the new name of the function.

>
> >
> > Note that, the implementation is intentionally as lightweight as possible,
> > in favor of always providing the correct information. For cpuidle decisions
> > this is good enough.
> >
> > Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Changes in v2:
> >       - Implemented a common function, rather than making it arch-specific. As
> >       suggested by Thomas and Marc.
> >       - Renamed the function to indicate that it doesn't provide correctness.
> >       - Clarified function description and commit message.
> >
> --
> Thanks,
>
> Ben
>

Kind regards
Uffe


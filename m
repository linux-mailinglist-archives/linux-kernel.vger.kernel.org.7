Return-Path: <linux-kernel+bounces-860975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6C3BF17F2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 557214F5479
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B51A21348;
	Mon, 20 Oct 2025 13:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LuyIgp7h"
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2809185955
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760966182; cv=none; b=hUhG136ce0Szf/KJSNSZytD6YVXoHVYAHdGSUYgH0HvkwgNFDHJO6vKFeb4oZmo3doPEZcCd3CEVk0rTJtWxf4/ExJEUANudZz7cwl0npIbfLV+SQLfI/A0rTt3NObxA2ct+mAf9T4GwWYucvE5erZU/lhboHtF9mUsz99vaDzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760966182; c=relaxed/simple;
	bh=Mts36fyNnyZuf8TR6hsMlEXKwl2CcVVXzvx1QoeQXrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uCjUfeIO/PMOvGi+3NyOiE9vdPY3TJhiniiHkbeSQ5GtMf1hstfzdd5PvWmUuuJnkuERlsArbXsv6dW5kIpG1zkMSEEqzkSHGvAPZsAsR+Pl5qTjkDhmC2MSYurrKdMrfZ9qlEbid1ppcoEGkTOrjD0Yahnowe//uni09QHrUlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LuyIgp7h; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-63cd60ca2b2so4479854d50.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 06:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760966180; x=1761570980; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Bv/hgIoX+50q6Ixl1xcYkiMJg4G9dL+7TCf9i2+ayLE=;
        b=LuyIgp7hYcD5rggvHOqpDkGLm6dVcg27vqPhVb839P8eA6a4GW4fZKE3se+qmbqKJ9
         bma8T5YGzJZOyJoDjV4YH/9yov/ebdqhNYagBDbkZkS98f9bZ8GF7Pk9mHDrzAvF/S1d
         UUeMgYiqfjFs+bOMqGLeLsWRRM7ZhE4AQOQWbfddRShxe0k8C/+SAHLxaKRoXBxvhxrF
         KtPlxPLBnyJamgHeOZF5O5ZmWCu61v5SiAsfgNgWvbH6nTwA4dJmM5a3JFP9sseckhmj
         XWaaLDU7YSevjXleYoOIVvXhv20rAaC0jDLJGgeMBs/PXSnQUr9NX6+PUeeIsCClMRRk
         gKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760966180; x=1761570980;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bv/hgIoX+50q6Ixl1xcYkiMJg4G9dL+7TCf9i2+ayLE=;
        b=QBJDjt9lFNNCIbZSWU7jwJIw4CPXMs2LxX3FrV+ubjCcEXdghH4eJiaslSW1Dw1+jA
         EipatIAhb1rsMwlcoM7QMdxbPFFbpLJW60E39WRK6LVd9zJcyaVoB3F1XnbaQVnsRofe
         3sckA1Djb+iRGi8DTbCZnC4TsGnCXhn+R6OioA/f6QIzHrVIFmgpUDscMzGcrQhNGTNQ
         dAEhdR8lPFWPr+LMCiTHeKkoSzvn0C4WH8sX9kNKeabDfLb1ffBi8+gheRUyWhYiCAmO
         XanD3tE5BaKc/x7a62k9I2CQJewsAlnGZtYJPOvm10lHckSiqg2z02+lgMevDyHfW+mm
         Pytg==
X-Forwarded-Encrypted: i=1; AJvYcCWL8kOY5vEbPQe7TDHK751IrNqbtIqWVqYr5QWg4RhSBZ2t7xyVkN2m0NAF/g1nj9SuHUOsFv8fdS8D7ww=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXvke+Mb3oSeD3LrHPKB97t7uB1Mn7Ex8z61qUoWs6UZaFoHsX
	WCbpTgzsp58GkeXKecy5oInWiCP55E1aOaOh0lo1E4DDOFrW42LlaANoeN69ryDx5KbjxpVNAV2
	GejlyMBBBLUVL1r1hJ5b5DEOTJkI0qAQaWos2vBqBPg==
X-Gm-Gg: ASbGncu0wfNkY/IiBYFX3Nbq7aG/T+pT8nNrKy7tLen4M+nuBGe9R4NP0AXjRttDqZY
	8K2yMezJzMIBaubbBpEQWmNCeT+3e7XZfqwQ7VguE1x93pcf76tNwxbMyJ9Ww+eoBCQZhSXXdUr
	VNNJoW7kK1GLJCiEbFhd5SKDg/qdOzExneOEJqVGCQEv0fUndsE7G3sNrVBWy66Q2E9zL6UAzEt
	YBO4XwjFFyRjswGlMoCQoXXZlH+IuxOOkjzKwBzvjzBDi+1+nj/DfydiJlyR220sPv8ekv2
X-Google-Smtp-Source: AGHT+IGnRUd6oOWdcIGq7ZJOM2TXHgRRiMIGNGat5wkkLEzDStDeU0jE+0gV73QBrOSN31p7sfrpQMby2GN8IBO6/98=
X-Received: by 2002:a05:690e:134f:b0:63e:3352:4eef with SMTP id
 956f58d0204a3-63e335251d5mr4077188d50.69.1760966179641; Mon, 20 Oct 2025
 06:16:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003150251.520624-1-ulf.hansson@linaro.org>
 <20251003150251.520624-3-ulf.hansson@linaro.org> <87ms5pzkxa.ffs@tglx>
In-Reply-To: <87ms5pzkxa.ffs@tglx>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 20 Oct 2025 15:15:43 +0200
X-Gm-Features: AS18NWAQ9Q6Yt14QDB7s6GeA-9Aoe7Poi1wd95vo2hk4UxQrH-HTLgjH3ho0lzw
Message-ID: <CAPDyKFrVkO1nn-1C7z9RJBX-bzxQ8_tBhhKNaK7h++NbAoT3zg@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: smp: Implement cpus_has_pending_ipi()
To: Thomas Gleixner <tglx@linutronix.de>, Mark Rutland <mark.rutland@arm.com>, 
	Marc Zyngier <maz@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Maulik Shah <quic_mkshah@quicinc.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Vincent Guittot <vincent.guittot@linaro.org>, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

+ Marc

On Fri, 17 Oct 2025 at 16:01, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Fri, Oct 03 2025 at 17:02, Ulf Hansson wrote:
> > Note, the implementation is intentionally lightweight and doesn't use
> > any
>
> By some definition of lightweight.
>
> >  static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
> >  {
> > +     unsigned int cpu;
> > +
> > +     for_each_cpu(cpu, target)
> > +             per_cpu(pending_ipi, cpu) = true;
>
> Iterating over a full cpumask on a big system is not necessarily
> considered lightweight. And that comes on top of the loop in
> smp_call_function_many_cond() plus the potential loop in
> arm64_send_ipi()...
>
> None of this is actually needed. If you want a lightweight racy check
> whether there is an IPI en route to a set of CPUs then you can simply do
> that in kernel/smp.c:
>
> bool smp_pending_ipis_crystalball(mask)
> {
>         for_each_cpu(cpu, mask) {
>                 if (!llist_empty(per_cpu_ptr(&call_single_queue, cpu)))
>                         return true;
>         }
>         return false;
> }
>
> No?

Indeed this is way better, thanks for your suggestion!

I have also tried this out and can confirm that it gives the same
improved results on the Dragonboard 410c!

I will submit a new version of the series and I will try to
incorporate all the valuable feedback I have received.

Thanks everyone and kind regards
Uffe


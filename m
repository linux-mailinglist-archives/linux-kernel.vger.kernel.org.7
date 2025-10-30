Return-Path: <linux-kernel+bounces-878830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D441CC218EB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 100481A21F71
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33E536CA8D;
	Thu, 30 Oct 2025 17:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="BvN84mmA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF74B36CA85
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761846620; cv=none; b=PxaPWfUm5spSFMkttMH4PIY587hEE458GHz8Vh2EZIKmHHts6JMWPCl2s/g54oPeN19lNbXXVB8IQLIr8NArih59F07PqqIBwE7a4SiM66g5vnoy0KUd9hf1H3HZkktQr33z9P4hZer8n76dgSo4LF63r/cW7PRn1W6dW5TMifs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761846620; c=relaxed/simple;
	bh=cnfOiHcXorptPrl8VAK8ofA4Qt/qiW2XlLxz5RTznp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DJEkg18VigeledvBjkqM+UF48JztehCD4Q5Z3Jmx+zI0QAUeEX7Avd5m79689dQyoUgDwNmonxK5drAGJDFQEzMxIkxLGiUxZwyZpCsAV4scHTyAHukci5znd+dAgAlhMszylfTt5ImLedAx0Xi1mRd4ulb4XWefTpZqJux6abI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=BvN84mmA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3893C4CEF1
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:50:19 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="BvN84mmA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1761846616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cnfOiHcXorptPrl8VAK8ofA4Qt/qiW2XlLxz5RTznp0=;
	b=BvN84mmABqzhgqKBgBRxGe7J6EA28A/3p+AOybRDs2xqIjEVww6I/mbC54SRXgMjyRc1FQ
	JiEyaOeR8Uicd2yvz/ztmbEg63QFJFN2v4xooct5/9s5rT7OswO1fsC9SlD7NipWA/VBGO
	1QNcHa3rEtNA/MiZpCNDEE03EOPj4u4=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 70d067b9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <linux-kernel@vger.kernel.org>;
	Thu, 30 Oct 2025 17:50:16 +0000 (UTC)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-3d220c5a16aso921505fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:50:16 -0700 (PDT)
X-Gm-Message-State: AOJu0Ywv2dDxD3subA69VJOnHod8phpTgDnIOdHB6sd7LowTulDsamFw
	FxnuXvWZxYTqcWN054dMV/0U1C4t5rx5pIo1iA7pV8jS+ijCfYjbRbOsz7UD/EE8yVk7MTpDu3M
	FppiWZn6yCp+FK4RV9Evr9/VsZzn1/go=
X-Google-Smtp-Source: AGHT+IHfwenBU4lNCBXi4ppH1xPcBv5mtzVX9Omz1UWcQnKdsaBto9k2ZRPkB0qReNCeYL+CQb5Cc5gsEfuylUoHPvM=
X-Received: by 2002:a05:6870:970a:b0:344:34e3:5143 with SMTP id
 586e51a60fabf-3dacbfabd05mr289136fac.28.1761846614778; Thu, 30 Oct 2025
 10:50:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030155728.271373-1-marco.crivellari@suse.com>
In-Reply-To: <20251030155728.271373-1-marco.crivellari@suse.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Thu, 30 Oct 2025 18:50:02 +0100
X-Gmail-Original-Message-ID: <CAHmME9re7wh16pfqwyJm5EYbwjKZDkzKLL4EZRLN0WG0bZ=Lcw@mail.gmail.com>
X-Gm-Features: AWmQ_bnBcpXFjJobDvvwjX6jX4AbG6DQazDAqjO5cGEjP0P1rxjFaas2dAc5LZc
Message-ID: <CAHmME9re7wh16pfqwyJm5EYbwjKZDkzKLL4EZRLN0WG0bZ=Lcw@mail.gmail.com>
Subject: Re: [PATCH] random: replace use of system_unbound_wq with system_dfl_wq
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 4:58=E2=80=AFPM Marco Crivellari
<marco.crivellari@suse.com> wrote:
>
> Currently if a user enqueue a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
>
> This lack of consistency cannot be addressed without refactoring the API.
>
> system_unbound_wq should be the default workqueue so as not to enforce
> locality constraints for random work whenever it's not required.
>
> Adding system_dfl_wq to encourage its use when unbound work should be use=
d.
>
> The old system_unbound_wq will be kept for a few release cycles.
>
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>

I rewrote the copy&pasted commit message to be simpler and also
include a reference to 128ea9f6ccfb ("workqueue: Add system_percpu_wq
and system_dfl_wq"). And then I queued it up in the random tree.
Thanks for the patch.

Jason


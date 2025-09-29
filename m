Return-Path: <linux-kernel+bounces-836190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D78BA8F6E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7BDD3C5DF3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104E32FFDCB;
	Mon, 29 Sep 2025 11:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="iHMDjXj4"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97ED82E7F08;
	Mon, 29 Sep 2025 11:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759143828; cv=none; b=TMLdVdtrM9Ybb67FJuzZa3DHZQKjhMFOKUMEuyHKs3YbGJx3eucm7wcEbPu0doxvpabk1dLKX/cxeGHJBpCDSgj/0SjZvUzGG+OFLyQr/2dTHFhK/JeqjppbbQg3ZZPiDCu4mBsXtS0qp4u0kgPDQioYF9thAlCmYazj7jnp6Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759143828; c=relaxed/simple;
	bh=4WwcJmryCjc1IxQRMdYRN6hwLNSO+6fUwKFiCFVa6uU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=XlnXyMMuMKsL5/TpZtNfIRjXrX56aXe5mou+VBTtLTI8fPmiq1WODmpeElkdPb0ZS/i2u8OYfCItJFkV6/K/mwDS0ltcJjMnEJljCoHiiL2JFusto9diByRNFzPlhO7569ezIhNYn5YOcmCXJpGwEZRbEWCVd14CB1Vu+vaS8S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=iHMDjXj4; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759143815; x=1759748615; i=markus.elfring@web.de;
	bh=7QNDcDvygux8/QpIMd7kqNXUDWj2J0hXPBGXGHMR2sw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=iHMDjXj4VPQzzqnIvHTM/vdYFZ2dyU5PvqB5fBFQflv3YqJmBUOTfOeAADg6xZaz
	 qfhiu9jDnXyhvuQYFlQS7j1GjFXBDnYxLKb7NyhR+Su+0GrsxRM35x9AYVCBsiCtO
	 gRjr7VQnNhBsYVF/oVU+20OlF8xkq6FAh7wobDhwBDIfR3/Oh13ZvI4/uaDfmRLQp
	 rLm0AoIhEMU+WYMXQ4t0//QUATZRS52VHnHY9LxS1EIj9RgAPASGzzL6R4veXzN41
	 YJGbHdtDmfYpJCvyvtBxK8+tVadrEP9c4QgtbGDKfq/C6jPYneTKMrLe7bBJZnsHI
	 cG365z/JbLUl7kqyjg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.245]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MAcpg-1v9lFf0A8G-00Al6m; Mon, 29
 Sep 2025 13:03:35 +0200
Message-ID: <48cca942-6b35-48b3-91bd-770265521203@web.de>
Date: Mon, 29 Sep 2025 13:03:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Alessio Balsini <a.balsini@sssup.it>,
 Andrea Parri <parri.andrea@gmail.com>,
 Luca Abeni <luca.abeni@santannapisa.it>,
 Yuri Andriaccio <yurand2000@gmail.com>, kernel-janitors@vger.kernel.org
Cc: Yuri Andriaccio <yuri.andriaccio@santannapisa.it>,
 LKML <linux-kernel@vger.kernel.org>, Ben Segall <bsegall@google.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>, Mel Gorman <mgorman@suse.de>,
 Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
References: <20250929092221.10947-14-yurand2000@gmail.com>
Subject: Re: [RFC PATCH v3 13/24] sched/rt: Update rt-cgroup schedulability
 checks
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250929092221.10947-14-yurand2000@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sNfXIfBSwcY5KnhzbejJ4CSTGgOlnZRSJHbPtm2M85AQPeRV1Qa
 dH6GCUONzj/9yEwsFNoSIZ+mMwYzAkK847bruEhYP1MZUGwm0YlO3L+d+m/LGFjsAChxGJ8
 r4WnhaN5HoawRE+2KolANTIdy8mYesxWRWXjZ+xLT9c/PzLK/LGjKraSIuEjUNm0GZB8wn+
 y6ZlN/qeb2X/eRqyfHhYg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nEJjGIBThAw=;WAX68xgOv9wGvR8ETI4Hm+aG5OL
 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
 yypTH+2bHQwRMA==

=E2=80=A6
> +++ b/kernel/sched/deadline.c
> @@ -340,6 +340,39 @@ void cancel_inactive_timer(struct sched_dl_entity *=
dl_se)
=E2=80=A6
> +#ifdef CONFIG_RT_GROUP_SCHED
> +void dl_init_tg(struct sched_dl_entity *dl_se, u64 rt_runtime, u64 rt_p=
eriod)
> +{
=E2=80=A6
> +	u64 new_bw;
> +
> +	raw_spin_rq_lock_irq(rq);
=E2=80=A6
> +	raw_spin_rq_unlock_irq(rq);
> +}
> +#endif
=E2=80=A6

How do you think about to define and use a corresponding lock guard?

Regards,
Markus


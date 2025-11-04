Return-Path: <linux-kernel+bounces-885150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 985C4C321FA
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 17:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4818B4EE0DE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 16:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6FC33554E;
	Tue,  4 Nov 2025 16:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aeV2uXfE"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102AE330305
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 16:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762274672; cv=none; b=WoH51xn11YvM/NMKmkvVRGQYSM0WF+q7jeUZuG5rltWPPTOLmNb8YVAASftanI7CDv6i6CqSyci6BBrcAII1FMkXVs+IYFbc3WJBpeqIwZcwlafB+WYS8XCXa/3k3opaxgkMBoQXMKb39SiPvFtnZOnIBQpZwXLKN5osDLCIAJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762274672; c=relaxed/simple;
	bh=iKL6Oeeg1vcVGMXoUhbs/QIz4j1Xx/62odlfUSouZuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jB4VmeF/ZVt0B7Ban818MDZlQvw8+8f+fDvFnmSfvE9YsjGYXui54hpun/CF1uUDXzJ6rYiwEzCK2eVeq2HlGKfxWa2Wcn2xqE4c8fZ4Lg5Eg+en7fS0il0v+AOvpwoJsUd9upZpT+NMlCWOW7HWNq4CuHg65zg3FvFNZHWzPss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aeV2uXfE; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3737d09d123so74642371fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 08:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762274665; x=1762879465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKL6Oeeg1vcVGMXoUhbs/QIz4j1Xx/62odlfUSouZuU=;
        b=aeV2uXfEwfc5rG6NTnzHWeOYpJl4S2aeKCldzqn3rM0lYkRApZarEazuItDuJZuLUm
         U/92wjEKK2vHaxD30ZPT7gVylJOGtPvx8RUimA+x3wZIGPli9L37SGaN58YwX3JsYJC0
         6N5zFNZuIxn5XLWPvvcCRKo51+HmQfG6nJXeveNY7CiL2ltdcSjOt1aWPzSO5oidl6vA
         xXo02fqvY7kbAPmdt3UWTJaalxCo2HJA9jCNqH8PGUswbu8h1TSfmWofC4ow78RJiRPb
         lOsQ91kVj3gyt8rrbgUW8ZnCHnarepwiA+4q5F3zmxoz+WscnU71zpa9Qepx1sngAtxl
         yptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762274665; x=1762879465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iKL6Oeeg1vcVGMXoUhbs/QIz4j1Xx/62odlfUSouZuU=;
        b=b0anKpvsm+R2KKuuqDXT2t8PghGrKn+Rg7WFbGPO/h2kVZ3UzhjvFEQNEvTAR4M4EK
         v4DPh3GCQFi3R8kD126CjzeZUS50D+Ivbh8v6FG9UwABEWsJAreblaahoeyKrEP9lnPo
         TiT36qFb4YMAIBeq41w3cSShbIBOM8b95h0dBeWpzjC8MxS1tkdYR/VISEqtyoLP1Evb
         CPNWaSbX++P8xlsqpnVRUXBIu1KGecfdHe0aFnQFvw/yACbgKgy885DM+G5m4uaZaYmp
         FVYs66QTuPTtdzdbrgDeq+rLI2UxMDL6tPqLK8ER2495p9K+msFighBn1L9iGw7ehYCr
         J2Gg==
X-Gm-Message-State: AOJu0Yxy0JucU7IwrLyV99DX1eFGV3ibdIxuiWQPQ+JJGncxEZfREpnx
	O2+WdIri/7mibp9UsUJtXB0czTcOKhOJFqY3ZtoCYgYkLAezeUV5d+zey3FScc+tnzPHj3gLmBM
	vLfqBCXo5J8mPVHO4Sk53W0PqNSg8CAl6Oo7ByAmVLA==
X-Gm-Gg: ASbGncuOLz/g6yT+ulYEcQQlGEaaro4rOeTO6cdGN08cwVEZSdu/Iu8zyZ+m5Js3ApH
	3Mh1Q5/ySqpdTj49jXDG/NhDoaaIKluxbqOCVp2xqnv3ie7TaMj76RLda2FRlpZhuzg5+PhCdJc
	ljSHlWDfmAU3UOdrtNzJNprgFbzwz3qf4Ly93GcAl9cKwqt86tqh4OmIOgMeR91bYPi1Gg5MKcL
	I5EqMSKfXXDQBXp+RJg/LbRbLDt5KnnSdAPeDwFaw59c1gRyYsTSmWjIQt/e4f/ZkgcOcqkEEc2
	SK36+LlebyPGqgB1NQ==
X-Google-Smtp-Source: AGHT+IFa641/YIc8QEoSM+2u3rdMj8MWSovTl52bmxJ5Ic3O9e6IQnM9GzYEfzl+ACXNT4BjGQcDXpztd26xVGUGShQ=
X-Received: by 2002:a05:6512:12c7:b0:587:7f2d:2580 with SMTP id
 2adb3069b0e04-5941d532321mr5046018e87.32.1762274665492; Tue, 04 Nov 2025
 08:44:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104102048.79374-1-marco.crivellari@suse.com> <5ce483e5-7384-4d63-8dac-8050c2bd5930@collabora.com>
In-Reply-To: <5ce483e5-7384-4d63-8dac-8050c2bd5930@collabora.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 4 Nov 2025 17:44:14 +0100
X-Gm-Features: AWmQ_bmjsY3yYfB6P9rCzLcYpPklV0nouDUkJG5kFnQHbiBlQza70BlS69U3bhY
Message-ID: <CAAofZF7k7LDxGoXENBtrpP-xokGoCJCqouGX-qumGTPwipAwVw@mail.gmail.com>
Subject: Re: [PATCH] media: synopsys: hdmirx: replace use of system_unbound_wq
 with system_dfl_wq
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	kernel@collabora.com, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 4, 2025 at 1:46=E2=80=AFPM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> Hi,
>[...]
> Took me a minute to find what "dfl" stands for. Would be great if the
> name was self-explanatory as system_default_wq. Even then, not clear to
> me what's the point of this remaining, the system_dfl_wq naming feels
> very obscure compared to the explicit system_unbound_wq.
>
> Could you please explain the logic behind the new naming? Doesn't it
> create more confusion than remove?

Yes, dfl it is just the abbreviation of default.

The reason is to suggest the use of the unbound workqueue
instead of the per-cpu, unless this is really needed, of course.

There are parts of the code who just used system_wq thinking it was the
unbound workqueue (the "general" wq to use), so to make explicit the
"default" is the unbound (system_dfl_wq) I think it is appropriate.

I saw this myself also in this conversion round: there are maintainers
who are asking
to change the wq they were using from system_wq to system_dfl_wq.

Let me share also where the API change (and other stuff) have been discusse=
d:

https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/

On Tue, Nov 4, 2025 at 1:46=E2=80=AFPM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
> AFAICS, right now system_dfl_wq duplicates system_unbound_wq. Suppose,
> instead, the default wq could alias the system_unbound_wq.

The idea was just give 1 choice, so remove system_unbound_wq (and
system_wq) in future.
Personally I don't have a strong opinion, but I think it's easier to
have just 1 unbound wq, and 1
per-cpu wq.

But if Tejun has other suggestions, based on your observation, I'm fine wit=
h it!

Thanks!

--

Marco Crivellari

L3 Support Engineer, Technology & Product


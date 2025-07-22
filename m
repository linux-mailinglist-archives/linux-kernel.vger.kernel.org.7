Return-Path: <linux-kernel+bounces-740271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91506B0D213
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 08:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 786FD1C21843
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 06:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C81C28937F;
	Tue, 22 Jul 2025 06:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFFwD7EG"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7380F289364
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 06:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753167037; cv=none; b=n/Ap2JCqNkYWqm3ZwlLK+QAxxhruOUFc4rxXgI/qgsai1ITs/KdFUd82zedmTeP8RSdPGqFRdGqsaAiNfd+oMdT/Pk+1JEE7TTYUc9HPN/gqhGMaKF4iU4rMANejDz29urnfvbXNJdawWS9Qn4KCiShDXGzkZkrfNGjRzPqHsxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753167037; c=relaxed/simple;
	bh=b+1B+Wn7HNOWmy4ymusRgiKtdV+zyXXU8YbrbkuG2KM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HUlt31nZQ6oXfBay+ctPV3odIfaOlCLX1F4cYch2TyTzHlGOPaIunoQP8XrXJRPVgIUSdns+bgQ1Y3ad6Q8YBGa32M8c6jFVpBr2ZBQi2bkUjxpZ2BB4ESMVsYVSjrWu3GaH3iH4DHdQEM2HRc+/Co7f7kkc9vjQQLP4NB5pKOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFFwD7EG reason="signature verification failed"; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b00e4358a34so3329622a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 23:50:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753167036; x=1753771836;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :precedence:mime-version:list-unsubscribe:list-subscribe:list-id
         :in-reply-to:dkim-signature:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L4fsLwxmK2ZnQnVdh655BQ3QV8h38rfOFwSvZPlcffU=;
        b=IeFcKi1FSDTDpgkeVvPFKWdgsMp4nnHPYXCfePdnl96OF7GtpfzEdK9uuib0MJEODY
         YhWbRECfU5ktAhp6EpiLhIHPKkPVYv4kWM7YIvtL7TAwYCRGAY+N5MiOWb6x4MQr5koI
         sYfDspJwVHdIxfNI112x2WUeh6RVLfpqai9mkwmN7zzCRiffBsD8CGjVa5312/TNcJFg
         rwcZ177vhzTuII8nrJBhT9w9r+6K8WlfJszfZp9L/f5JLOdNueAXngOPSxm0C37QPEHf
         JmaOAxEnYhw3THuxv6xxAhddG1m4oOm0FeezCdVtZDewE9RBJdWjY/+jCvHSGneGlNBE
         YuYA==
X-Forwarded-Encrypted: i=1; AJvYcCXjPbtKiUEc1F/IBtah2tnRPGt2HlWeKwS36agqVyTILqpbGGAgkLdvBlrQvRYmWWAOJ/AfRxH1b7C1dwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf0X1dUh8a+n00scwwygK/1zmazSiC8COVmFXliKOuov/4/3Wk
	4XprHWaPKEkBXO6WowkZtUUoylDXdUzBvFBWkhaulU7ACqvPHmS+LWid0fSDhRKomX2qP4oUfCg
	cmoKsmLyCGbVBB5q6qFcIahToIg==
X-Received: from pfblu8.prod.google.com ([2002:a05:6a00:7488:b0:746:3244:f1e6])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:4304:b0:236:5ceb:b9d with SMTP id adf61e73a8af0-23811d5ac1emr34751483637.5.1753167035810;
 Mon, 21 Jul 2025 23:50:35 -0700 (PDT)
Date: Tue, 22 Jul 2025 06:50:32 +0000
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20230601;
 t=1753046000; x=1753650800; darn=vger.kernel.org; h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to; bh=o6gErZMJt76V1eqKZ0fc9t2jYBpWpuemhCSqXUz2On8=;
 b=TFFwD7EGeRt+h9AJJPWjbV1uKa2gKH3vS/z9rxSxoUHBGmEXAS7a0h1r6Xs3Xy6li/
 OhFAm1p/YZ7nTp3ycyyrh4J7khfJF/llMwAwIAn+x62R2XSkPNjttPCxmGD8ZQO0zRxQ
 yyDUIVMIDuLOHbPptc+gsmkO5b4Oxj2EZ27rz4r1XQnNmEqLjZUHWa72ij/uIwd8yGIm
 V0ZzpFSqa8zBn38m1Xe8w+q6BTpgGBaeVreDkHoXXxnI46KtoosiVmAh4pksyM1QDF1+
 6NAYDv5Pj0hXY2BEoovwatezwn9+JbIZlEEIcApvc/GfSBKRHJpxuVV1B2Gs8LkulgOi RsYA==
In-Reply-To: <20250618080339.969173-1-joonwonkang@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Precedence: bulk
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com
 [209.85.167.176]) (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256
 (128/128 bits)) (No client certificate requested) by smtp.subspace.kernel.org
 (Postfix) with ESMTPS id 5FAA98F40; Sun, 20 Jul 2025 21:13:21 +0000 (UTC)
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-41baecbdd33so2143031b6e.1;
 Sun, 20 Jul 2025 14:13:21 -0700 (PDT)
References: <20250618080339.969173-1-joonwonkang@google.com>
X-Forwarded-Encrypted: i=1; AJvYcCUIqRTYVk5DYU47Vtl0BVlM+j5m8FCTAvv/bbWeYafgWJ8vbNgxpINfVmp9r3Gmsuwd3vvoeWadLJN/2NQ=@vger.kernel.org,
 AJvYcCV+cDgLTOR7OFFUgRvrYh3E0RkOINWlRAwkK26rULp0BJlx0pS52imLKkgbJFOK9Pdis3xB9QH4zJ+06Lk=@vger.kernel.org
X-Gm-Features: Ac12FXz9vOtA1Fg51kXnXqCTNXVof0pWwc5qQoUQiAq93e2W0_AVQrge6SyFrZM
X-Gm-Gg: ASbGncsOZshUrwHwD1EBaqV6YDYpT13TvMxXalipJgouXw1wUTtvrItcHOI+B5cb76O
 E45apbK+Il8vixR39xAccGfQ3cJv6a0ulWhbGIH6Q9AjUmNAvUpV6zWxDrotD2w2Mclc3iw0CJq
 gLc3RTDcZrw7KmQZczGqMUD5UBsluWhM5f7p3yhSo/jkCdDHI907P+XhEgtPw3YjxlTaBLqHlGF 7c+s9lp
X-Google-Smtp-Source: AGHT+IGQBjCiAD9vIQwxV0rJzEKHpmjX4gL4eliT0pjfkXkTEmtGeAlanzndulSYj+eEPQNmRrUoqpol2Hvsi+3CglM=
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
X-Received: by 2002:a05:6808:81c7:b0:41f:79f9:1b6b with SMTP id
 5614622812f47-41f79f9201emr6057246b6e.34.1753046000383; Sun, 20 Jul 2025
 14:13:20 -0700 (PDT)
Message-ID: <CABb+yY3CBiLpZ1KrD8RFypRgkP9MOzBf1FB+gL2E-qEuSbrj6A@mail.gmail.com>
Subject: Re: [PATCH 1/2] mailbox: Use per-thread completion to fix wrong
 completion order
From: Joonwon Kang <joonwonkang@google.com>
To: jassisinghbrar@gmail.com, Joonwon Kang <joonwonkang@google.com>
Cc: alexey.klimov@arm.com, jonathanh@nvidia.com, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org, sudeep.holla@arm.com, thierry.reding@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Jassi Brar <jassisinghbrar@gmail.com>

On Wed, Jun 18, 2025 at 3:04=E2=80=AFAM Joonwon Kang <joonwonkang@google.co=
m> wrote:
>>
>> Previously, a sender thread in mbox_send_message() could be woken up at
>> a wrong time in blocking mode. It is because there was only a single
>> completion for a channel whereas messages from multiple threads could be
>> sent in any order; since the shared completion could be signalled in any
>> order, it could wake up a wrong sender thread.
>>
>> This commit resolves the false wake-up issue with the following changes:
>> - Completions are created as many as the number of concurrent sender
>>   threads
>> - A completion is created in a sender thread's stack
>> - Each slot of the message queue, i.e. `msg_data`, contains a pointer to
>>   its target completion
>> - tx_tick() signals the completion of the currently active slot of the
>>   message queue
>>
>> Link: https://lore.kernel.org/all/1490809381-28869-1-git-send-email-jasw=
i>nder.singh@linaro.org
>
> Is your issue different from what is described in the Link?
>
> thanks

The issue is the same, but the solution is different.

The previous solution in the Link tried to have per-message completion; eac=
h
completion belongs to each slot of the message queue. However, the solution=
 in
this patch tries to have per-thread completion; each completion belongs to =
each
sender thread and each slot of the message queue has a pointer to that
completion; `struct mbox_message` has the "pointer" field
`struct completion *tx_complete` which points to the completion which is
created in the stack of the sender instead of owning the completion by havi=
ng
the non-pointer field `struct completion tx_complete`. This way, we could a=
void
the window where the same completion is reused by different sender threads
which could lead to a wrong completion order, IMHO.


Return-Path: <linux-kernel+bounces-794981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2580DB3EB38
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 17:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C4417ADCE3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB382D5950;
	Mon,  1 Sep 2025 15:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/Atu/UZ"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73C41FDE31
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 15:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756741502; cv=none; b=pzn0rwO0CsEYLe8eaunSc8zmfvCnTuVIWn9xg4H5XqGQ+cwiqngb3v4GWbmKtgksOdHdzzMFUjioQWK6/pwqvb64wZn3A2JmKhtZnezw73L6O0V01BiM/aFqRAhPm7A3PQhOzssbf83UhVuxyFnBW39XXkQd7dwkU0Inml5lLYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756741502; c=relaxed/simple;
	bh=GiZo+3xs06RcsVe3xuokutWKR93wSXmm1FaZO2v4oaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lw/JYb3iqY9ETTNPr1g2/voW5pFIFpX3eMj1EXzgHzgYdDtiAcc763dQRLc5eGTALH8zZlcRe0mu8P+Sm607MNDJShYuhp1DTBO37bViQ8MYiPGCj89d0UhZQAoQmRcKRYbn6FhDO2+Exm/YPOwvIduEhU3d1qcJxT+phVQDnsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/Atu/UZ; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-61cd3748c6dso9371774a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 08:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756741499; x=1757346299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHPTKC2Vu8KHnQ+uWsWsYWbp4MhhjwmYo/8R9vlIMOM=;
        b=c/Atu/UZl6qGHoK8CfZ0az8zaPV7cJcpIrispdaiyxaIdqUtUhEYGy7vFFi0POwyI5
         towQBtHJ9zjJBCyxuFzTd1w1XeJmj82/CM9bMg8ytuZC643rP0Wcjn3YiJH99+R12YyW
         GET2no0Fk8NypZf/0iXT+z43X4AQRvKRlQDKYnv5zYoqV6p3I/2aRhiuVFqecnVLy5xu
         d8Ibx1wrVlwUCnGMUgN3MXHHb5wamACED3YSzIDSVwJmn9AG6G3RpEC5v7BLT9SX+k9t
         TbcpkXsj3q5srcidVrfMhdHEOVc7DjD+YxWAW1sv9BSnW+qkTLHcBeZahn4ivPW2f/Zw
         6gNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756741499; x=1757346299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UHPTKC2Vu8KHnQ+uWsWsYWbp4MhhjwmYo/8R9vlIMOM=;
        b=HF7lJFkDflpbNNijRYYrcME2c8uKEfPYiCxBL2bAR13/l0smLKzPs3FKHUQhmEFpkD
         W1HRsTtpwQUyJgsgfam/t0B3X+SNZalSN1w+aCXvqXwF3GKXvhc9DXoHkKBo5odkRId4
         VmUIoUqXRqznyuFgraL2EEZMAjn3gLSMePjsaQrRotcFzAjoOyAQ+P10+am1Y3wWsi/A
         1P2ovw7rn4Won3O6uatWctOF4NoPowyJrRDlYszqA4kcU1Z3ynmYHLbYEDhvjP6OAyFv
         afKUGh+vANPO7oBudWRd+OvRfcDBKStx1WxYR7ahonwJZvTeJ/TEHbx7wbqoDuXhrbOc
         K+bg==
X-Forwarded-Encrypted: i=1; AJvYcCXKN0GLphKMod0nRNaelUq+Q2QzDiFeV7idvb15UJ19rvmrOcn8RW9aj7m10YpXMEFdOWwPyIV26TKRuGM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx16QK0qZiFqJfdTiMazGo4ukIq4KyD3yVFDhJsP3tfTBY1bnSO
	HkhLE74gT4r+TsXt2wNW7n2rnuVgqnd23YU5VoLlEGyUpJNTZP5GKH6c9Eaj1zeMjN50NXE03f5
	V/nSk8PQKIYueVvxowv7MhffNILDQf6I=
X-Gm-Gg: ASbGnctzEaEDY+IiMv4WJoxR/456hc//UrhEf6b3g+YpQAujmJZhdL1DcMQY28eCJ4L
	NAqZEGxxUZmoqyd7baKxKs//dZ4eQpwJ/lL2efU0/9AVboux6ZWdRCbs9g2AywX0Ib+foUgMztq
	Q47xZod41NXUsRlWGE70bJcRVEJsC1iqzepxxIOXqbrXNLWplh2MDOCpU6y/AUzVgx9thZJ0BMd
	T1qDKh+76tabbq57w==
X-Google-Smtp-Source: AGHT+IHxIhKYzDvaYlAd0N8sT0LtRUJz5RTuCzWwBkGRu2LMSnlGXT2KJ0YNoKbo88CyOV+mgu4rFLAnfsqrNe5DLD8=
X-Received: by 2002:a05:6402:42c4:b0:61e:aa4f:657 with SMTP id
 4fb4d7f45d1cf-61eaa4f1c3dmr1689085a12.8.1756741498991; Mon, 01 Sep 2025
 08:44:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250802022123.3536934-1-gxxa03070307@gmail.com>
 <20250819-anbeginn-hinsehen-5cf59e5096d4@brauner> <20250819142557.GA11345@redhat.com>
 <20250901153054.GA5587@redhat.com>
In-Reply-To: <20250901153054.GA5587@redhat.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 1 Sep 2025 17:44:46 +0200
X-Gm-Features: Ac12FXzPUeZHYAFLmB2vfH7SshZcIwk-HtJug82eUekfQ92QpKyUhQyNxi_zVAY
Message-ID: <CAGudoHEoK9f=M6-iOL5yHqK=o4wiJW_78t88BEwsAksAW5HNqQ@mail.gmail.com>
Subject: Re: [PATCH] pid: Add a judgment for ns null in pid_nr_ns
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, Xiang Gao <gxxa03070307@gmail.com>, joel.granados@kernel.org, 
	lorenzo.stoakes@oracle.com, linux-kernel@vger.kernel.org, 
	gaoxiang17 <gaoxiang17@xiaomi.com>, Liam.Howlett@oracle.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 5:32=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wrot=
e:
>
> ping...
>
> We need either
>
>   [1/1] pid: Add a judgment for ns null in pid_nr_ns
>   https://git.kernel.org/vfs/vfs/c/006568ab4c5c
>
> or
>
>   [1/4] pid: make __task_pid_nr_ns(ns =3D> NULL) safe for zombie callers
>   https://git.kernel.org/vfs/vfs/c/abdfd4948e45
>
> in any case imo the changelog should explain why do we care
> to check ns !=3D NUll, "Sometimes null is returned for task_active_pid_ns=
"
> doesn't look like a good explanation...
>

Since I caught this a stray patchset I'll bite: given the totally
arbitrary task struct in an irq handler, why even allow querying it
from that level? The task is literally random, and even possibly dead
as in this crash report.

To my reading the code which runs into woes here is private to a
vendor. Maybe I missed something, but I don't see a justification for
querying the task in an irq handler to begin with (and per above I
don't understand what the point is).

That is to say, if this was up to me, I would at best assert we are in
the process context and that ns is not NULL. As a result I would very
much *ban* the call as reported here, unless there is a good reason to
make it work (what is it?).

That's my side rant, feel free to ignore. :->

--=20
Mateusz Guzik <mjguzik gmail.com>


Return-Path: <linux-kernel+bounces-797402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2A1B41004
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 00:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94C433A801A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 22:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA9F2773CB;
	Tue,  2 Sep 2025 22:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="PGHMFI+O"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6978D23BCEE
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 22:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756851905; cv=none; b=FiFr3IgBPijadwHdu31Gu9zQ99nQbz9DC5u4sN9SpOX+HC8ZWbDmqmuZ71y9svIuDNyYp5LNx5p9nKfr4I4PPrTWc3UmX3stM+GayeBCDDel99PnPFNcuMC9pQS7Af6TceQd47kHd1qxkOfIWcpxZ4NeqDlZb1UGJ6y9SQGhOIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756851905; c=relaxed/simple;
	bh=1iy1UuTw6lEJ2NwgCGNoKYrNukFmN3deNRw2dmxMW9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LL86e7HlrmVQrxu7qVxb08vrupXw4RMUmB6N4G7cFWOgej1uxcupbLRr5qBEe0yL7bR6gPGby/c/r7lE8rKkrtGvMJQrNHQiX+tvh2fBScnjeBBP/Xz/Y0CsLFo0jTqQftR2pQPc2iRwqoHxMNkTNPyf7P1VKCrpnAQPEu6bvHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=PGHMFI+O; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-24456ce0b96so4509645ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 15:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1756851902; x=1757456702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=goWE8+4wadNs8Lr3ZlBGwSTIYXLGfMy0Q3cAuxNQchA=;
        b=PGHMFI+OwD3E5L6bsg/XMFZSY7VzSlgQFcAewJ8d/S0bVALIbgmNmBs6VUd6r3XQIR
         ZU7sX7oYTtD/DTXwJkFfjKjxJrq0+GhFVZ5vPu0p0wnr+qyyBIe8QLXGUGowf06yMcDA
         4SzSNRs69atYPJ2BybvP/pbCOpPSYMdlPDTcYOO/uJPYVHClstsY+9PdBMjXYbvNjVs3
         5h8/5/rhlsgHjWCZa0lu6N5UEEHAXXlQkN/2iRm3jQPgCcL8ebF61FhVY1vkkEwYzwp2
         QMDaSeR1K0NO6uqhoSlamr9Cc1J0Twr2yOXO//VbuUhAL/1vc9djk0IoxoU+imkpDSyA
         lbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756851902; x=1757456702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=goWE8+4wadNs8Lr3ZlBGwSTIYXLGfMy0Q3cAuxNQchA=;
        b=Lqh+i+Njq6QrBJPvOLu513prvYLRm/t0rd73u6ALolqXuFevlvBhFHcK36jNdZxx5S
         tc9L8IQoZPrFGmyeXXf7mFa0QPx9xRdmAse+V4Yr31NCo0KguMXzn3hj5OLg70nIKstD
         EX8vRBFtPYrRT/wrJIdoVgBBbI+JLWMCcUjKCh9fk4pfCcf5R++GE1uTQiKVQBLFgPX+
         dxyXdxpzLnrA4hgWAz6a+RXU7jYnckL+oLcew+KqsCLksiQknX/f1fJ4ZFFI8XU3CN2q
         3T9OnEPGt+16EiEKylY+PSTtqB1TtDiVUBEEDQhESYtVONOyusMBx8UZro9u91l4/5/7
         mudA==
X-Forwarded-Encrypted: i=1; AJvYcCWjJAbVwVFG3gGG2ldRxQrgqJXIZxHsGYTmgUw9SpsL19O854s3kvcTApgdnW+bOqL45k8dgtIHRrG/8Wc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEyCChpwT0ynx7/r1UZLoaZqfuUUZtZBg5IeDxpS/XgmKhz2u1
	+OkBj8opg7IYIbdtJODekEu/mmCzkx3UqAQ1j5y/hosHRqWkqEuqL0iUVfYFQjSajsnplEzAkL7
	FFAFcOGloc9ASX4YSUAJwRpYXpWNOs88Rp9fMQ8VGag==
X-Gm-Gg: ASbGnct0oRPAx++tBSDhjoVB61XSj0gJcZJLKoAMqBEI4wcFjzWs18/fmL3EbcXWMfm
	Z7pMeBHHtGejGIW6rlSY+NofpvZm6sV6R8MTzKC4UAKXbt/0xQhs7/2yHsW12n5rvN+1PyFsoLm
	Fug7CoSY6rWtVQhJI9HacoyxVXMybgrRKfFx8585x1J9tKGfE0kaaGS1SvFhTrMHOaIPFbp122M
	VP+BcesVv0+VZxCXQ==
X-Google-Smtp-Source: AGHT+IE+GuPuwIi0HALNRYE7COclZsdxu+LtC3uR80YuYT0Ap6u7TRJrOcZjbn/+xL05gLgJGPzhKrW2ZZxS44wSvgk=
X-Received: by 2002:a17:902:fc8f:b0:24a:4560:49be with SMTP id
 d9443c01a7336-24a45604eeamr165939475ad.28.1756851901619; Tue, 02 Sep 2025
 15:25:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902131948.154194162@linuxfoundation.org>
In-Reply-To: <20250902131948.154194162@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 3 Sep 2025 07:24:45 +0900
X-Gm-Features: Ac12FXwiesQX507YxRyjZkNgjnZMjLVD0vNTuMmrfDECGQRtT0AQVZvnJkRsc7k
Message-ID: <CAKL4bV5ZuM9J9-6oy27WVMrmA-sX384NowBacG57x+t+Ydt60w@mail.gmail.com>
Subject: Re: [PATCH 6.16 000/142] 6.16.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Tue, Sep 2, 2025 at 10:27=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.16.5 release.
> There are 142 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 04 Sep 2025 13:19:14 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.16.5-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.16.5-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.16.5-rc1rv-g6a02da415966
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.2.1 20250813, GNU ld (GNU
Binutils) 2.45.0) #1 SMP PREEMPT_DYNAMIC Wed Sep  3 06:18:52 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>


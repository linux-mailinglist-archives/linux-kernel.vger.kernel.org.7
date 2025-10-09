Return-Path: <linux-kernel+bounces-846994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A12BC99B9
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 16:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A7D23AB621
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 14:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698B32EBB87;
	Thu,  9 Oct 2025 14:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aK572t8l"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4292EAB85
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 14:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760021196; cv=none; b=GOFzPRhnPHHZMebToHyd1snOl6iw8uyZIVOlukm6lmaDkGbJytXJUPTcT/go7pJDJ9L1gsi1stTWWjyeeVGNa+mgDWLNtLW0AMnM2V3SNo64vSYGdXyu8lxta0UT+2a9t2B9RZQyjFTUo+HYq9UH1hx4jhPk6M7co3ZCVz60kXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760021196; c=relaxed/simple;
	bh=1ea2FqGO8X0KyhXFhsQvQ5VIp9EZmkCaEw/l+PkhsCQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=nBKlCh3Iw6gHJQ1UPIduS3nTxpmWwGREFB8j9VZ2bDTWgKY79Mi6ljoeA2njRmFw2ewljd+q4vuAt9ih7sa4AaZO40cmYlUjpGTTNBc2/lXjEHUrS7SB5J+f8T0fjPpEdY4gf60EXj/RZUSImscYrRl5AYSXfblpHFcFcMHkqeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aK572t8l; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-373a1ab2081so9047141fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 07:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760021192; x=1760625992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U+Ry0FtuB8pr3QUc1iPcQ7b9TeRIdgYSFC8Pqih22Tk=;
        b=aK572t8ljPaweFTXt2XrgDCFio8yNeOzrjmZ2vsIMPO6pgX9mT55KirLcXTmju76pQ
         L/kKB9eTtGxumV8PDZBcpwBD/Hbw5Nnxpo/rRFCR9Gmp3aLNQjxWMMq6qZN9T3V/v4m1
         b0xoEx1Wkrwm2udrQjUjyS+Vl8qQ82JniuOgFPtR615Kvd03JlsVvYMUTT84OO2EjwrO
         y0usFbS92s5X0NDBz7JGZAvg+sePLisgm3gpm679FtVJf17zYLpJZHcWbicztYsNMr2R
         /vLSubFoSjKNZpbjt7q516uiR0m4hnkV/p2yaiHp9RsjdZuquOZJKNWy1i4oyVwHamOz
         s0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760021192; x=1760625992;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U+Ry0FtuB8pr3QUc1iPcQ7b9TeRIdgYSFC8Pqih22Tk=;
        b=o/8TKtwnsSFln5CebwZYYEDRqIhvEVA9S5etvfL9AZHANRE0hyC0tIq/cMjWBUkepg
         2rHXNSzTDNX50tmVWSS+K5feGYK8w30ECMLKnRV6WyQBWyfXf5lAbk57lF7BAKX4h/ef
         ekz07HY9PI4s80CveU+7XkMGfh5B1jh7GOyd79b8EuUS0ratLUSSqDsDWpgQgNHhZI3G
         abM/LKKPXd9IRKh3Xx9vlaBsCTass5nP1rzf9h+JRJzHKqNbCdl5dOxYhB2Ds6YH+sAW
         LW7zBqAiw+T+g8eYNT7I8m3QH2vtDQfYXqT5mfN+IX6rX10EImaelZxXz1fY1P+lOqLv
         2sew==
X-Gm-Message-State: AOJu0Yzuovvx7vkK1ST6XiMvsJpeaMuzjGCMwts/gc5Z9bzgq5rVfCu6
	CrRwC+6RaI9ikIMR9UWsctv8VWNlO0rKGx3nMSPvVcFlkyNg9Jqr2Z8n
X-Gm-Gg: ASbGncs005LLjihE3VbrIcz6KHeQDLQ+kRh70Vkl76y2kRo2UAX5EGWnqMKQNAqcuU6
	uY7kPjO9vSWevQ5AfCw9BQD/ao+UZWUo4ROaCsgSZIs57ES/mV3oh/ELBwwLpWzF7SNsDs06b0W
	+2DLwhGb8wDR9gGiLinO/4+yXDjgF+EcSC6Yezrvg0ElI7AbPu28hV6CjX3MqQYCaweD9IVPQUr
	9BXcuj/WeOu0bKNryNNMQZhIIksO1CgTz1Ntt64viFUfQhsH1zqFYIXn8FiQjJXXtvGU+2STxNu
	PTeEy0YgqTof5hdaRdX448a1TGIZJbH7SJBcvVle50JcYj1aG51Z6qnjtCy2WMXFpsZaHWsyJOx
	Sz+GrNK2HV7Os0vBaklZZlR5emFuI/AHezBogO0Omo8PID8wsOzFVTyG0DOy4
X-Google-Smtp-Source: AGHT+IHwyEGvBSBRL4NxF69Ss3wFZqx8O7qBu5sX0qrXAdrs+B0du5qbYJMW4TSqCKGBrYoCZEFIyQ==
X-Received: by 2002:a2e:bc24:0:b0:36c:f6:a4e1 with SMTP id 38308e7fff4ca-37609cf7c10mr16222961fa.14.1760021191840;
        Thu, 09 Oct 2025 07:46:31 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-375f39d509bsm29511861fa.12.2025.10.09.07.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 07:46:31 -0700 (PDT)
From: Sergey Organov <sorganov@gmail.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-kernel@vger.kernel.org,  Russell King <linux@armlinux.org.uk>, Ulf
 Hansson <ulf.hansson@linaro.org>,  Shawn Guo <shawnguo@kernel.org>,  "Rob
 Herring (Arm)" <robh@kernel.org>
Subject: Re: ARM iMX6sx board fails to boot with kernel 6.17
References: <87v7l03pqe.fsf@osv.gnss.ru>
	<CAOMZO5DG=cQtqyzihrFarEq6=1AOAPAMkeXajjGxiW0yvFRa0Q@mail.gmail.com>
Date: Thu, 09 Oct 2025 17:46:30 +0300
In-Reply-To: <CAOMZO5DG=cQtqyzihrFarEq6=1AOAPAMkeXajjGxiW0yvFRa0Q@mail.gmail.com>
	(Fabio Estevam's message of "Tue, 30 Sep 2025 16:09:13 -0300")
Message-ID: <87zfa016bd.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Fabio,

Fabio Estevam <festevam@gmail.com> writes:

> Hi Sergey,
>
> On Tue, Sep 30, 2025 at 12:49 PM Sergey Organov <sorganov@gmail.com> wrote:
>>
>> Hello,
>>
>> I'm looking for help with the following issue.
>>
>> I'm trying to upgrade kernel on my custom iMX6sx board from very old
>> 4.9.146 to resent 6.17. The board has eMMC connected to usdhc4, and
>> u-boot happily starts kernel from eMMC. The kernel boot sequence,
>> however, hangs waiting for root file-system as it doesn't see eMMC.
>
> I tried booting 6.17 on an imx6sx-sdb board and it booted
> successfully:

Now after further investigations of the issue I find that success
a bit surprising.

I've found that my problem is cured by a commit in

https://github.com/nxp-imx/linux-imx

that works-around an issue that looks like imx6sx generic problem, and
should probably cause troubles on imx6sx-sdb board as well, but doesn't?
The commit is:

commit 65cf3a49ab15cdbbede3c97fd6bba731a3cd366f
Author:     Anson Huang <b20788@freescale.com>
AuthorDate: Tue Aug 18 15:53:54 2015 +0800
Commit:     Octavian Purdila <octavian.purdila@nxp.com>
CommitDate: Thu Feb 23 14:21:42 2017 +0200

    MLK-11375-2 ARM: imx: disable cpuidle for imx6sx

    i.MX6SX CPUIdle with ARM core power down has issue
    and cause system hang during kernel boot up, disable
    it for now and will enable it when busfreq driver
    is ready.

Later (by the DAG, not by date) on the same imx_4.9.11_1.0.0_ga
branch at that repo, there is:

commit 816978f83b1d8dd6ce3bd5dd62223dbfdf74bdd3
Author:     Anson Huang <b20788@freescale.com>
AuthorDate: Mon Oct 20 16:16:20 2014 +0800
Commit:     Octavian Purdila <octavian.purdila@nxp.com>
CommitDate: Thu Feb 23 14:21:42 2017 +0200

    MLK-9708 arm: imx: add low power idle support for i.mx6sx
    
that effectively reverts the aforementioned commit while adding a lot of
other stuff. The resulting kernel also boots fine on my hardware.

Curiously enough, neither of these commits are there in the latest
branch lf-6.12.y there (and that kernel hangs on my board as well.)

Provided the latter commit is indeed the right fix for imx6sx support in
the kernel, what's the procedure to get it to the mainstream Linux
kernel?

Thanks,
-- Sergey Organov


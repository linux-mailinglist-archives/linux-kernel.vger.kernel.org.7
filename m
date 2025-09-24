Return-Path: <linux-kernel+bounces-830092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C38B8B98B97
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B5CF7A4DE3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 08:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40501280328;
	Wed, 24 Sep 2025 08:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5rmQ2ks"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035BB26E6FA
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758700987; cv=none; b=tAJ7uad+0kID+0mCgSvSEZxLM4m6JXPcr02/pIGVXZWGkmC+146F++EheJxrhQFljwoa42QeRiIpH9/HDoPX1R50Ba2UXj2O5Hcv07XMXc0VULrpWWB0Z6+GJ//90oBp9zWsldGvaeY3OKaMU6ln0QI24R1qos4w8+O9d+9BSsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758700987; c=relaxed/simple;
	bh=gZYO00dsgw1/sZf16O3pqxqviKudSlUhSQE7SGYKT4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I30kTpD2vQudZ0zhYD/Z22UfHNlvARv3nXO0+lcgF2hdkKdOslwYcmoHeCvU7JyQpenrkbCn5zR0olmrkcvYrF7xckq6AqjWZMktITN+QRo7jLq/rzy1IHAJr4vSfV4aVrCCNrAYfG8Ar3uWjdXoXkjBVjKBhUP5+m6kEckzhsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5rmQ2ks; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-62ecd3c21d3so10384282a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 01:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758700984; x=1759305784; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ehfc7lW7bxLwmLG05CxRKvZLBCPLLvWLd72j5jVN5N8=;
        b=A5rmQ2ksjJV+pH7ww7oZxhdxMVAJ0gYbbfAM/WrQGTIw58y4P4Jk2lqIzo6/ORDGsB
         12H5G2Bl7oHGfFvDzPhe4nB1SZ8Ij/ldLcOVUtaebURd9kfKxb0XWQiRG1cZoKLI2KaX
         Bvv+VL4QOTY7UlAnBIRV4IpLSIChPshAK6gwQBRbuVla0mzqlLfYjGsECHPx2uO3amo9
         yNU4NXW6yDQyIB7+DJ6RQXPWuAMdwq2AKVe/hrAnOhMc2WZ1ScOvIXQdwdE9LkCnJBKN
         po+S88dsNg13plFmdClOuJcyCauaMueZ516nahpV4bfGpZGUy9v8MtDXc8+9fokE0wuP
         I83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758700984; x=1759305784;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ehfc7lW7bxLwmLG05CxRKvZLBCPLLvWLd72j5jVN5N8=;
        b=LLtUmSFTNH5MU1kbl54fIBA2QMRjDhgv7KgMlX99i17yglKy/40FpKcW7Sf9natsop
         jC6gLph4K4dyv461Cah8Vf5s0Th8JqXLwb2fIG2a5u5RmFdWrQgKim0+gKxxIF80Eo92
         BLFKiVkGzVcy667aS/4hHDaOfAn5dGS3MIsw13MWkTXwdGIclzgxYpWqglPmtq34a9q6
         yYTi98sYkufCvvcRl8nwzwHHzkVqP8liQn/0ZjDHS0PE4E+YPr3ZQD82txPHMO2PIbtu
         nWULACkdAbJp4G5x6JoAFcP/5rox6r0HQA5qS0y8BlyebS7R2cTYjYKujoDLq+yUpYjt
         plLA==
X-Forwarded-Encrypted: i=1; AJvYcCVVmYVCVzaNRaDRGwlhn74rdj9s9r/2N8R7+YAZqyFcrFIoGsHG6XrBUYsNwhMYfbBy/NcNw79Bx+ofCsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwULZ8j1Nituj2ZTA8D4UYiXVNbobn5AhA0fGtiKCRWnh0HEEa4
	+nJE7ykUC/qAr7VD9oG/7v/ceprd76czQXpD5lR1NvV3tjVXuw74r4Uhdm9PwepP7qS3kwQ2XkR
	9o2Fa3X7zLd67igvsK8/PfieUEKeb28c=
X-Gm-Gg: ASbGncsACe09UWfU6AGVvJlGff5wTESBaWFkHWRSvY1EI3S0CColYvsZbNoZ03mue8S
	9i0V76LXUr5YstFipEDWH6kSz9MXo+cZ2yCPDB8vufI6Lm7DQPOTKoyw24Tge4nJGwOuTLHJVSS
	D2BTzf7pf97mL3EWQ1YOot9rO0njcCGCNpyrZzJZLwQgmIYRPTM/4eZPEH8WSmuKw2gpfCq5Ck2
	6XPprgOWdXK9UoLySXpbpLY5HSljDUJE2e4e7/IIv/wZ6l3SgKhMw==
X-Google-Smtp-Source: AGHT+IFxLHXew9N/JexqdNTfDfR/A0LfnbXCLzDT8ABYFnADQGfGxHrMbIpi3ZFG4X939kYRjpoOubp/hHRjAOYou84=
X-Received: by 2002:a05:6402:254e:b0:634:4e0:836f with SMTP id
 4fb4d7f45d1cf-63467795097mr4196054a12.1.1758700983944; Wed, 24 Sep 2025
 01:03:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <83171a57-cb40-4c97-b736-0e62930b9e5c@lunn.ch> <20250920181852.18164-1-viswanathiyyappan@gmail.com>
 <20250924094741.65e12028.michal.pecio@gmail.com>
In-Reply-To: <20250924094741.65e12028.michal.pecio@gmail.com>
From: viswanath <viswanathiyyappan@gmail.com>
Date: Wed, 24 Sep 2025 13:32:52 +0530
X-Gm-Features: AS18NWA4QzzqyxonbnUZkhNBqNGPKS9vhQ2TwPcWTvWPtTGvwTC0T-6N-mfumR8
Message-ID: <CAPrAcgMrowvfGeOqdWAo4uCZBdUztFY-WEmpwLyp-QthgYYx7A@mail.gmail.com>
Subject: Re: [PATCH net v2] net: usb: Remove disruptive netif_wake_queue in rtl8150_set_multicast
To: Michal Pecio <michal.pecio@gmail.com>
Cc: andrew@lunn.ch, andrew+netdev@lunn.ch, davem@davemloft.net, 
	david.hunter.linux@gmail.com, edumazet@google.com, kuba@kernel.org, 
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	petkan@nucleusys.com, skhan@linuxfoundation.org, 
	syzbot+78cae3f37c62ad092caa@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Sept 2025 at 13:17, Michal Pecio <michal.pecio@gmail.com> wrote:
>
> It's not freeing which matters but URB completion in the USB subsystem.

Does URB completion include both successful and failed completions? I
decided to go
with "free urb" because I wasn't sure of that.

> I think this description is needlessly complex, the essence is:
>
> rtl8150_start_xmit() {
>         netif_stop_queue();
>         usb_submit_urb(dev->tx_urb);
> }
>
> rtl8150_set_multicast() {
>         netif_stop_queue();
>         netif_wake_queue();  <-- wakes up TX queue before URB is done
> }
>
> rtl8150_start_xmit() {
>         netif_stop_queue();
>         usb_submit_urb(dev->tx_urb);    <-- double submission
> }

I wasn't sure how to describe the flow of execution in a multi threaded program.
I will resubmit a v3 with this version of the execution flow

> > Reported-and-tested-by: syzbot+78cae3f37c62ad092caa@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=78cae3f37c62ad092caa
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
>

> Tested-by: Michal Pecio <michal.pecio@gmail.com>

Thanks,
Viswanath


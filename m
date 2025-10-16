Return-Path: <linux-kernel+bounces-855768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 247AABE23EB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAE073ACC7C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 08:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D392E426A;
	Thu, 16 Oct 2025 08:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jWwWirqE"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE9630C60C
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760604982; cv=none; b=G9qzop8XoW0NwofMG0vkVT2vV3JalY/jg+HfWg3hJBmCwOORg1CLj6+eqVuBostktVgRpKSgBeMgFIg7wPX0NbX8SP/Bvlj4u86B6vJiwcOWHWllKj31tQX/dhYGA2l/Wclk1l19OYCESo0o0YU9761ACicngJSwz1gSCRIarwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760604982; c=relaxed/simple;
	bh=BTJ5BDmS1jbavXTN8W5DVTEeJJq886cvTMsOxekHMXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hWbEDfg1yxmIPVUft8A6Jgc1TizFPvwvMAEmeW117rzLKz+k6lBwWvdQfC0+4DNGwAqnKOwugBcfBjSsg8vrS9gXj5QOTYDILkoi4eky4jwBbx+fiF1ukgxG9ucJEX17SSHO1z7r5/o+VgECsFo5ECRtiOxWXdgo98vkP08Zyx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jWwWirqE; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-71d5fb5e34cso5907357b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 01:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1760604979; x=1761209779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTJ5BDmS1jbavXTN8W5DVTEeJJq886cvTMsOxekHMXs=;
        b=jWwWirqE3QEI6lWNFj/7+5RR2L5bxPNe1ud4s2AtPOvfbbS5A6CkYZWza+a6RCNDFH
         93N+UCon8hBkdIT6saX1iUKgu3f4apc66BBsMJq/MIDKs+TdSz4mspMFfmD0JPfF4+dL
         WnZU7tbGwhhLhy49RvQbWKJHTunb7Bcd09N4LO8G4o9y8BrlG8LpynOcAKIJRSqy+ib5
         B61j9QvIGyN7LziizwQQnQVdkf52qyXXiMoUmSOJBiqUAozR9vzOVz6Eo0RvDqg1gyrP
         QMgnxkv5gBxS7x1BkCnik6MN54stZ0EhLzw870phdeFDMvYuqfNrK6URwWRZtpHIPkSd
         DbPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760604979; x=1761209779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BTJ5BDmS1jbavXTN8W5DVTEeJJq886cvTMsOxekHMXs=;
        b=K+QIHBVZWIyIl6tGwu4gpYjN87hRcpDpk1DNcV+vSfMivF+VxrLWuttxBXrnDvkCiA
         2wUhd51zv6mpBxJWd2RDnsQ0i56RgcHEIU+9A3xOXIF16wrUuME1txPO7w40CrpRh8lp
         VWS6J+1pobJ09CiLh21vvX7oRTnPx6srQoyLzuCNc0KNDNRy7G31apZI76p5UBxs1S/w
         HmkQYCUPxOnakU0JsXDZTwII0IF5zVDgAddAXZHUm9mtsgf73tkfa/KUICvmBhXR5ZJ3
         BB1wFnZr4cA00LsFcbdt3gTh8ksyrVwgP6Klm01zBVNcxebE0gfQiIJdMIyZqS5biHis
         rp3A==
X-Forwarded-Encrypted: i=1; AJvYcCU1GwKYDUdhuX7L/n6pzoKa6xDAT9pk8lnIId6BY+KSyVnWAOFho3rWtMlW2624cZJWExhJAqUtcKyhscA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+6Apr70N+bWsLgzoIteGSHhN6wxmrpQJ8edXV9fyZnvJze9EH
	man17dffXC1dsEMuE1bac1Ih9w2XVbaIq7HBVRmU/k5boF50pg0rs1q7qfXO/qg2sOJwNxEnU0c
	74ZrxBkecxUWxzexYESOemdOsonG8OEvO5rll5n2MxQ==
X-Gm-Gg: ASbGncvA2Uz5L4c2d4gtNH0enNg6NJGQUuho2qbjNI1D4dIyFTHUejNIHbM0Lvqwi3G
	208rBVx/HJoY4gdKkzkxckX1/AAPTlV8UOb+Be/Og5HHivZiDQ8+JPRuXxGH1vu3ylNnm9UMBfM
	ja9cokpp5SyOxoy5z30c93vLTBBGgfbuRSzYlYOdtdpE99e4GfbQ73/nSUOplRaCkGOgAZqxR5Q
	50Z5B7pmwIsP0kNyKZEWAhKatsP/4AhpnoREjlJvsjx6ccGTH9c+a/dzZ7Hz84Mad5e
X-Google-Smtp-Source: AGHT+IGxqTGy5wHmODLi1UF6gIFjWY6sKPakop2EXbRVgjjq12zyCIQCyGdiYtedanfT5A77kDydHAWRiH5qffLKEn8=
X-Received: by 2002:a05:690e:1686:b0:63e:c3a:ea77 with SMTP id
 956f58d0204a3-63e0c3af55dmr1343586d50.14.1760604978793; Thu, 16 Oct 2025
 01:56:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016070516.37549-1-zhangpeng.00@bytedance.com>
In-Reply-To: <20251016070516.37549-1-zhangpeng.00@bytedance.com>
From: Muchun Song <songmuchun@bytedance.com>
Date: Thu, 16 Oct 2025 16:55:42 +0800
X-Gm-Features: AS18NWB1MKGKlQ42nxBswbDuR0UxKYudldovqI8s1wflRtIJVP8mzsQzwaKGcuo
Message-ID: <CAMZfGtWhgHoYU4c2Yz5w6XCXJ0oSoJbm0_kW=YvjFENv+pDj3Q@mail.gmail.com>
Subject: Re: [PATCH v2] serial: 8250: always disable IRQ during THRE test
To: Peng Zhang <zhangpeng.00@bytedance.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	ilpo.jarvinen@linux.intel.com, LKML <linux-kernel@vger.kernel.org>, 
	linux-serial@vger.kernel.org, linux- stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 3:05=E2=80=AFPM Peng Zhang <zhangpeng.00@bytedance.=
com> wrote:
>
> commit 039d4926379b ("serial: 8250: Toggle IER bits on only after irq
> has been set up") moved IRQ setup before the THRE test, so the interrupt
> handler can run during the test and race with its IIR reads. This can
> produce wrong THRE test results and cause spurious registration of the
> serial8250_backup_timeout timer. Unconditionally disable the IRQ for the
> short duration of the test and re-enable it afterwards to avoid the race.
>
> Cc: stable@vger.kernel.org
> Fixes: 039d4926379b ("serial: 8250: Toggle IER bits on only after irq has=
 been set up")
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>


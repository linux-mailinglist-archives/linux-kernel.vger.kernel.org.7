Return-Path: <linux-kernel+bounces-728218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C72B024BF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 21:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15C0D17C2BB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 19:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91812EF2B7;
	Fri, 11 Jul 2025 19:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cJ1Okkz2"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430F11EDA02
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 19:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752262995; cv=none; b=lHfPUCicwXDa2ds7kH8yCjUJIef9QkNRwwBlN+JpMur4AagqIFFuQn0tE6LsYd8xAD2+HYOOFDvxbeYNjyuiPi9cBJ1Y8Y+SeU6NzhZh5GZ1FtRbPGRD8tMEZqRATQ+7CnSeDF8lFZiUoil9NdyHcjqeVzaXeh/8WGFDsuWZqgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752262995; c=relaxed/simple;
	bh=YuVVPwZ25CbTKPK3Z0FQD2M2CVGVme349VWUdFJBcsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=flnrDpjlN22YAKNrUWDRf4v374DbNOaRh/1ftWrcp05tCLp81f7ojYnHgY+tby7g0TiuAHN62nacAATa7kmyvnIry75UlkMzfAR/cxQufGawSoC12VJGZqP0gjDnLfdmyqqy6aNKQx30z69SrZcWC6pFrUqE+AaEqHVWL3lxzu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cJ1Okkz2; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60c4521ae2cso4497752a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 12:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752262991; x=1752867791; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9ZfdodvbHY+23Mq1hb6r26JRQ5egJtJgCen/4Rtzlo=;
        b=cJ1Okkz21Sejd/Twxuwrt2KXWffnfRmVnT4NW7CfQeAJQdvBWXlLcRU0zRG4igLrhm
         99FztMH0tSQG0+cvJRxx0w7WumcVGI5zNSoxlEgx4qfmAtpMXQJadMzOtGH5zfdCoky8
         6pfmBq9h34TLgyaJckVRjPJVSXd/Doath7COc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752262991; x=1752867791;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y9ZfdodvbHY+23Mq1hb6r26JRQ5egJtJgCen/4Rtzlo=;
        b=FES4oADpV5FwWlrVh2w0wld4yHegAeBd0c/kbKbDWo8WKk6yeYXtGdDq+jBQQXwpsq
         1n8vGrlBwkzHa5pBuuQxJCSizRA3V/w0d2BJ0JcwYsrp27MaApymhyCpSZYng3odGONw
         NzeM1XeVenoUZfo4wvXqyQj+aZ4h8hSMcz3uwu8gxSAiwEwK53CXjVy8/ASPK0Vlbe+O
         XdLk28LtysLnlKRNvsHk7FQWIIvAAktEbwSGbFqU20IbfI0bXFQ+Q6lGAwET8CqbnF+d
         GjtTNRYMmU4wrY4+JQAbDnMWC+wUJpfa1JZUjuh3xS1E9oXJWC0z8enPFQ0AOls2p6YJ
         6THg==
X-Forwarded-Encrypted: i=1; AJvYcCXeC+gtyROEV3oNW3e3GyFzR43Oulk8rnEvrlTQ36BLKOO0XsEd4yYw706QEVaWqgevJvAZeKubhlV4WYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLppPqq+cAeleQva8QSvIw/ujZOFbw2Rk7mkViIpK6wIXU2i6h
	yeSFs+UTG5AvAnByr685lW0JeuSBWzr2lJCnBdbzg9w2DLCWKSdX1cbFyIqRZcMBsiELbe9GV9J
	9IkrKBerXQg==
X-Gm-Gg: ASbGncvjzO2B/UrjLtw89PRvNzQWNOnKBxOaj41qiu0potAK/jX30N5nAvloLK3pGN1
	EQSdWJFCLXiPQrbSRMn3pSLhESuQRyXVMrhumIaUjPyHOJ5trpP1LUPQDtdTsVXHhR0kX/4FIcj
	wVr4SDw/LNqqVTpEmUXnfHlHnEtMQHeZzN7/Smu/XB6b8I/UE8GCGXWCBzLC97VObwWPusUF28D
	4jMKFuedsxvRO4XeN8ClTWIv7V1UE+G8kUDX8fAUxnrqdp0mBe4RG7+ofn2dmlexLO0p4lOn7Tg
	WNSTQLtho21CADqWwBL4x1zHHxTZyPUJWkDFCfsXRUMGUrfRv0p6Tb4p7hr3K5XoD9WypBz/j2h
	AK4eEMhWB4tmn1eEqiRRX4S3ilp/Ye7DWokA1ngBon5gXq+ETJQd4BZmq/T42w5FDx4sR0QaK
X-Google-Smtp-Source: AGHT+IHQWlg+Uhgn392aDnW69nmwYstXlaEO6cIi2uKOywOnqb2V9Eqxz5V01s++/0fK1Ty7qtEiaw==
X-Received: by 2002:a17:907:d858:b0:ae6:ae75:4ff6 with SMTP id a640c23a62f3a-ae6fc1cf1a8mr476267266b.52.1752262991225;
        Fri, 11 Jul 2025 12:43:11 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8293ff2sm345685366b.111.2025.07.11.12.43.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 12:43:10 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-604bff84741so4677091a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 12:43:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUoTF4Wle/jiFaE3H3WzWjiEhhZZj3WftnnxqNTXdjtKV2/y2kmZpPrtLasKTMdVaPRHR/+MyoOzo2hVc8=@vger.kernel.org
X-Received: by 2002:a05:6402:b57:b0:60c:6a48:8047 with SMTP id
 4fb4d7f45d1cf-611e765cb6fmr3016397a12.11.1752262990316; Fri, 11 Jul 2025
 12:43:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711151002.3228710-1-kuba@kernel.org> <CAHk-=wj1Y3LfREoHvT4baucVJ5jvy0cMydcPVQNXhprdhuE2AA@mail.gmail.com>
 <20250711114642.2664f28a@kernel.org> <CAHk-=wjb_8B85uKhr1xuQSei_85u=UzejphRGk2QFiByP+8Brw@mail.gmail.com>
 <CAHk-=wiwVkGyDngsNR1Hv5ZUqvmc-x0NUD9aRTOcK3=8fTUO=Q@mail.gmail.com> <CAHk-=whMyX44=Ga_nK-XUffhFH47cgVd2M_Buhi_b+Lz1jV5oQ@mail.gmail.com>
In-Reply-To: <CAHk-=whMyX44=Ga_nK-XUffhFH47cgVd2M_Buhi_b+Lz1jV5oQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 11 Jul 2025 12:42:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=whxjOfjufO8hS27NGnRhfkZfXWTXp1ki=xZz3VPWikMgQ@mail.gmail.com>
X-Gm-Features: Ac12FXyPtqVJ9Y08_msIv6jNrtKjZmcd0_WCbnv2xHgZgXnR4R8GpwOuT4Zyud8
Message-ID: <CAHk-=whxjOfjufO8hS27NGnRhfkZfXWTXp1ki=xZz3VPWikMgQ@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.16-rc6 (follow up)
To: Jakub Kicinski <kuba@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, 
	Dave Airlie <airlied@gmail.com>, davem@davemloft.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pabeni@redhat.com, 
	dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 11 Jul 2025 at 12:30, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So that "Oh, it worked this time" has been tainted by past experience.
> Will do several more boots now in the hope that it's gone for good.

Yeah, no.

There's still something wrong. The second boot looked fine, but then
starting chrome had a 15s delay, and when that cleared I got a
notification that 'gnome-settings-daemon' had crashed.

And the backtrace is basically identical to the one I saw with
gsd-screensaver-proxy.

So it's some socket that times out, but reverting these three

  a215b5723922 netlink: make sure we allow at least one dump skb
  a3c4a125ec72 netlink: Fix rmem check in netlink_broadcast_deliver().
  ae8f160e7eb2 netlink: Fix wraparounds of sk->sk_rmem_alloc.

did *not* fix it.

Were there any other socket changes perhaps?

I just looked, and gsd-screensaver-proxy seems to use a regular Unix
domain stream socket. Maybe not related to netlink, did unix domain
sockets end up with some similar changes?

                   Linus


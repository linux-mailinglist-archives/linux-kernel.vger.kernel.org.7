Return-Path: <linux-kernel+bounces-751565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCAAB16AF0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 05:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D8663AE6A0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 03:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD3623C8C9;
	Thu, 31 Jul 2025 03:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="E0bHP1F4"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904F12F41
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 03:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753933271; cv=none; b=inL/OTIl3bHJJCPuFRqE05QZgJOuOvX7tBsR+rauyruq5e6OOueRJkQ1+hFxedEOzjXQltHxgk3JSj/+azR1gd9Z5OXxW9TRxE+JJuwWEnmOqiIrjSrko7qzK9F2lqM21v9Z2tbHpj0tdjoWvPZ9wRmxUmftsrZMv5nSoYPpeu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753933271; c=relaxed/simple;
	bh=clKTf/x1bzR1Z7lzlH2Bfjd4uJzvjb3k9UW9QnUtZpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C2hOShWMF7FRaQ+SXxPyc0YimYLJ5KfOOod1eSDF8xWWeIrsjAN+j1OZqH3e4nf46wDIrrJG11g+RjonINCM1h8jVqcc+VXxlif6OpQnKegE0/fqDQxzbWBSio5BVAL+36Si5MPcagQhSs1Hasc6BPUH6+DMRbqOriKi83d5cfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=E0bHP1F4; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-61543f03958so591967a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 20:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753933267; x=1754538067; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QvnFRPkMsCEK+aaS89AQGekDsy5pWyg4qq7HlQ9+a4w=;
        b=E0bHP1F4xYSwbxZpe4+xkNSu3mIDgD/WgWpDdII6RxDE6mkkR8sW/giRpRkfzpxaEq
         3sa1zJXdSMqsuF5PvZjFMoT7feI9cYL+mkdG5syV5LopgFwZWIwrGC/IBG0tPgoGkJ/w
         ipQru9MHIBu6OfztT/QhCz8fDw/U4NH59e4f4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753933267; x=1754538067;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QvnFRPkMsCEK+aaS89AQGekDsy5pWyg4qq7HlQ9+a4w=;
        b=Q/fXNS3zBn7UWbaxojRZRtoxJqfylYDfbf/Iinb12s4sf2QKyQ0Ma9ui8MtcN7o9x6
         U+k7tbZAqWPIY1XtYgHwQDtjrws2a5O0QmbDX55oQ4bLoZ+afkwzQQv4aPQcGow9MjA8
         I3zKgN9+0fGc7DE7zTUcoLpCgkcfdWpnHS9YtI4fIr2RjBTltuhxcH6NOFrMridC6wOP
         B6zIC1H6t4unLWW6k0fgHs2yTlnJdudd5zCJV+NsVEHZade+BZ7Dk04EOW7qHBwmDanN
         LyCtsmBqF8quPGuHBiqoWT6gX5kegl7pexP+PiAuS5HoX+1XqL4HwhiT2JI8xMRlm7j4
         O/OQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbxQnEEeF+Qsedoz0s0eXgZFrVWz7dRS9Wp0skKENZjrgDUyejJt7buMO69BdjvJ6prj4gbsq7scCz9cI=@vger.kernel.org
X-Gm-Message-State: AOJu0YykxAF4CYtGQ5D8gxKN3O9Z/u+ask7F5WyJVXQGnZ1i+jUVs18/
	eiIU3Sd+iQXsAWzJptqEI6Qdn8XSsYScFMdyiuhYhdGprRFBYSmCn3I5acZfp7bOOsEUHAkjT4k
	OoWX6wKs=
X-Gm-Gg: ASbGnctz+GArijFjrf8BFiY+VpgUZ46dkx04IpWfLzG/8DLmwrArAAd1UQ/PT2Q7g+m
	3/94ftjK+gekkfRgMqWK8NYhY46p0Gh25jaD9tQ5XyR4s/m00CiH1+w/iNSOsZEutfd/e1NAubZ
	2XAS2rdUKGfg4OVn43GIFEeboMeelUXpfLzV0lCsQ4Igr5EL/i1S5NYtWFwBodlXZM8fIkZow72
	Cdw3FsbOXcL6kEIpuG9gMJ/cqRpQwm5gN1AElNqpIwZJnP/1DOJZ5p57+NqL03BgnON3UMy4oHO
	m3Ztu7pcmPUyu5zP6x9ncqm6WpPYxD6ihG2Jj/BO7ubKT73jYRoQcl2JQAT/zg2y7MRSBfGfdK5
	3KEWV/Ro9152KaHopN/L4CE45LWv/x9HQ2UJ8/3w0f1GLGALYGB2FUNiMnWaW684/9IItPFY0Ag
	HloZ8CFfs=
X-Google-Smtp-Source: AGHT+IFXIIfc3bPbRGssYRjdBS+Oit2bWXv2qsbfPwor69DirsDoVc8DJesZXmP0WVDPXiT5QI/Wbg==
X-Received: by 2002:a05:6402:13c3:b0:615:1563:4462 with SMTP id 4fb4d7f45d1cf-61586edd5f5mr6236976a12.2.1753933266683;
        Wed, 30 Jul 2025 20:41:06 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8ffbdb4sm461882a12.52.2025.07.30.20.41.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 20:41:06 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-61592ff5ebbso716818a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 20:41:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX/jQcVtt9ylKpxaAmMT5L46+ViNzHWQvKBjpUKR/qa2KHRJqwa6iPJo07iRqjXDWAHaNL396jfQrZBId4=@vger.kernel.org
X-Received: by 2002:a05:6402:51c8:b0:607:77ed:19da with SMTP id
 4fb4d7f45d1cf-61586edd68emr5405818a12.1.1753933264981; Wed, 30 Jul 2025
 20:41:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tzVm80-v6_5nt6kko3nR+aQLZ7R98i419FV8f4-ayQWUw@mail.gmail.com>
 <CAHk-=wirxHy+KU6jmtO2dzmGQ1BwaOdd5Mjtrc40fGvZVULQQg@mail.gmail.com>
In-Reply-To: <CAHk-=wirxHy+KU6jmtO2dzmGQ1BwaOdd5Mjtrc40fGvZVULQQg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 30 Jul 2025 20:40:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjn5Pg2Gp=o2NVv-nRKqE=E75AxUypWCCpQ7MDXuHx+YA@mail.gmail.com>
X-Gm-Features: Ac12FXwMPSRQdouGzuIRGoSW7QIrmRqrk5WhWBYQ7lHtHAufO7o1YAQXgYqXm7Q
Message-ID: <CAHk-=wjn5Pg2Gp=o2NVv-nRKqE=E75AxUypWCCpQ7MDXuHx+YA@mail.gmail.com>
Subject: Re: [git pull] drm for 6.17-rc1
To: Dave Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Jul 2025 at 20:05, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Again: I'm not going to guarantee that I got it right. I *think* I did
> - I'm not feeling particularly unhappy with my merge end result.

I spoke too soon.

I'm very unhappy with the end result, because it just results in a
black screen at boot for me. No signal.

It works on my laptop (Intel i915), but my Radeon desktop is very very dead.

I guess I'll have to bisect.

               Linus


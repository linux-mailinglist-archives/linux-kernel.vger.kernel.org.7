Return-Path: <linux-kernel+bounces-815432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 351E2B56426
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 03:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 211184E04B5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 01:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09D31E260C;
	Sun, 14 Sep 2025 01:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EukDtsiu"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C1F38DE1
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 01:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757811906; cv=none; b=Z2OLPzusS/5s+Z2WGwIWvDfi6fVbbzQEavMiTwKxDHsjeFI013Mp1SAoW+X5eLYRADknuLiWXAk9b7I9LZHWIDSMLU2DbPKRdtyYmM1oForf/Nzt1J7LbTUIAzx+rETm0GS77pYo+vi7RVr4jc9p5XIp7x4389AZnIBG1zDgm2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757811906; c=relaxed/simple;
	bh=KwCI67wzBCMSE+sGNwxoXxj0NxENSx9BrFmgM+/HkqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dve2CAmnXhfaqg4PJYxTfrngp0Sy1uK40QAIULTIPcu+LyOeDjP5+y3VmizkLhJlGV8qidhsKe077pAhBy5g5B+lM9yFVtPWQjGgut15FigouJ+umjhfchwHeTyX4cCC2pscfKIECrYtHNOTvj5gMIzau69krwK2WUb1TDslYMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EukDtsiu; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7725de6b57dso3857909b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 18:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757811904; x=1758416704; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2H1DEIqxcw9L6IzZmS40PiTXQNGrmQIDZ9w4fzliZPs=;
        b=EukDtsiu4TYMBENT3Jz1pJqoRCMTLFTnyWsIw+7igIOh4Dhqotm6lW3oio9vk1zhpn
         7nNtztHfqPin0GgfXi9czeBVNAv8aHYtjutw7KZt1P4gqy3WGdL2L0TgwieGLqQGfbEM
         1Hwu4dv6MFp0NMEo7KDybWcfOgTse1P8l7HD5sTs7ZpxNkjfW65VFlKujrj419IEMuPI
         MwHMG5ckatft/Q0OLzAkiateIhnNcWTLggYICuorF2gNADoQ1CK7xmFrQYRMp8OfwJwz
         chnw3+8nfT7MsnZgl/6L0c4mtCtUHLmV+gIqJrSsJ5AfrhEbb/UGKHHJZxmZgW6MLQiY
         3rfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757811904; x=1758416704;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2H1DEIqxcw9L6IzZmS40PiTXQNGrmQIDZ9w4fzliZPs=;
        b=ESRsLiz6TqB++WUnSmBknbP/cU2LWYaBaUbU91YB4iicN0YVmDZqZ1ECi4R2IwloxU
         HxxHjZsoESPDnrJruKyVMhcVdE84kIbklTOEeQd+kIgJYHJd7uEXdhhr49LS0DB8BqPE
         +Doy1i5HrsDoUpVlr/ro31r/zCi9fPQ9xFxYqEl0Pd/taDuZbX8GlSMRIWq2gPR8QQZb
         /IZky95VSBgV4Kuq5OcNciUu5qv+nbNN3NgBSnfnKJKybby2PCcqj/grXXLkYJ4CmLWA
         2Ed5laRGO+cbFjeNVOfso/JlA15JCgUpoanvr8m3xu7aFX8sdGbV3zgUxSUox4MeIXqB
         RuPw==
X-Forwarded-Encrypted: i=1; AJvYcCVw3pjO59bRP8JHn1fLEjRL9HfQUpSIloQNhWQzDMszPpaJlOsZDj4qe+qs0v9Mh/VhEc4NQyvhWdDxz9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD0qBJVUU4KfNJUMpn6rXISjOhPFWdtjhsvlxp9PMsv8A6pGYM
	fUtQCC9IkclXNKPRBb8eSeZxD3ccJuXfasZlRKQ/AGoPyXuq/Z0fRV7E
X-Gm-Gg: ASbGncuilx0wGtMg4PXxk4G6aeWLlwP8Lj9B3oZyyCtZi7p5gb6GH4LVc5e3Nex1tdB
	jPgybOJ+EtUkyusNuTdfYnoJyGHsjxpmcXw+lKmCjJ5lu7rmo3aR58MzfeBekrOJrR18GCokwuc
	ctR9d8EJnYRplNSci3aEPp3m8VUZg0xmMDQ94OWfwO13P9zowzz99Sg3a3NJcmacLSYa2+hd2y4
	WhJ5E8Eyxl+Mjr8fR2Oj1IYWNg6hY5D1hp4yRNrz3TRKWqLYPBPwbsiUM67N7PXgKAK3Q6ZwiHG
	WQ4YQj4X4VlE2l6ezG01gIdAaa+YKm+tlQ4vzNwTCgB8FPCMP99d50jsdEBPwM/kxyJkHP12E4O
	N5keOK0u8+H6dR1+2xd6SJzyJH5m9VIewBTqF9zXJ0xM=
X-Google-Smtp-Source: AGHT+IH2JCR/UgWVMA5jNgjyGNIJ90r5/YIM6Tob3LS+1FHup5VN/X2Uo8gbBRUdy3Aa1wBnWJSvCQ==
X-Received: by 2002:a05:6a00:1806:b0:774:1ef3:78ec with SMTP id d2e1a72fcca58-776120957e2mr8003853b3a.9.1757811903861;
        Sat, 13 Sep 2025 18:05:03 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:81bf:abc:6590:f690])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607b346dasm9531512b3a.68.2025.09.13.18.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 18:05:03 -0700 (PDT)
Date: Sat, 13 Sep 2025 18:05:01 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: Jonathan Denose <jdenose@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Angela Czubak <aczubak@google.com>, 
	Sean O'Brien <seobrien@google.com>, Benjamin Tissoires <bentiss@kernel.org>
Subject: Re: [PATCH v3 00/11] HID: Implement haptic touchpad support
Message-ID: <shsgwirjtyyo53lrczih3x3fracqtbwrlcfbdc6e44eddnglzb@ht7tyyngww2z>
References: <20250818-support-forcepads-v3-0-e4f9ab0add84@google.com>
 <CAMCVhVOUn-un9N_Bv00RVJ7kAw1O+AHgAHOzSGM6UuMBZVdtYw@mail.gmail.com>
 <vyhhm3x6nfdfw6gbgluq3sjr6bzamhear7nec6xdi5wfxq7wcz@cx2egj4yr5sp>
 <4267074p-78q9-54p9-8q43-2ro1n03259os@xreary.bet>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4267074p-78q9-54p9-8q43-2ro1n03259os@xreary.bet>

On Fri, Sep 12, 2025 at 05:28:03PM +0200, Jiri Kosina wrote:
> On Thu, 4 Sep 2025, Benjamin Tissoires wrote:
> 
> > > > Angela Czubak (11):
> > > >       HID: add haptics page defines
> > > >       Input: add FF_HAPTIC effect type
> > > >       Input: add INPUT_PROP_HAPTIC_TOUCHPAD
> > > >       HID: haptic: introduce hid_haptic_device
> > > >       HID: input: allow mapping of haptic output
> > > >       HID: haptic: initialize haptic device
> > > >       HID: input: calculate resolution for pressure
> > > >       HID: haptic: add functions handling events
> > > >       Input: MT - add INPUT_MT_TOTAL_FORCE flags
> > > >       HID: haptic: add hid_haptic_switch_mode
> > > >       HID: multitouch: add haptic multitouch support
> > > >
> > > >  Documentation/input/event-codes.rst    |  14 +
> > > >  drivers/hid/Kconfig                    |  11 +
> > > >  drivers/hid/Makefile                   |   1 +
> > > >  drivers/hid/hid-haptic.c               | 580 +++++++++++++++++++++++++++++++++
> > > >  drivers/hid/hid-haptic.h               | 127 ++++++++
> > > >  drivers/hid/hid-input.c                |  18 +-
> > > >  drivers/hid/hid-multitouch.c           |  47 +++
> > > >  drivers/input/input-mt.c               |  14 +-
> > > >  include/linux/hid.h                    |  29 ++
> > > >  include/linux/input/mt.h               |   1 +
> > > >  include/uapi/linux/input-event-codes.h |   1 +
> > > >  include/uapi/linux/input.h             |  22 +-
> > > >  12 files changed, 858 insertions(+), 7 deletions(-)
> > > > ---
> > > > base-commit: 86731a2a651e58953fc949573895f2fa6d456841
> > > > change-id: 20250625-support-forcepads-0b4f74fd3d0a
> > > >
> > > > Best regards,
> > > > --
> > > > Jonathan Denose <jdenose@google.com>
> > > >
> > > Hi all,
> > > 
> > > Please let me know if there is anything else needed from me.
> > > 
> > 
> > Dmitry, I've just re-reviewed and tested this series. I'm fine with it.
> > Can you give us your ack on the input bits?
> 
> Dmitry, did you have time to review the input bits, please?

Sorry was traveling. I acked the relevant patches, please merge with the
rest through HID.

Thanks.

-- 
Dmitry


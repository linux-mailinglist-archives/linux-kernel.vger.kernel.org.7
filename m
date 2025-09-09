Return-Path: <linux-kernel+bounces-808086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D35DB4AD04
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C632E346DC8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8922C322A30;
	Tue,  9 Sep 2025 11:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6Xj4yHm"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB7C3203BE
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 11:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757419044; cv=none; b=E1TFI+8sn9+D0QlMYIr8Nv50FG6JBfdX4FFmjv+Cd65gYL0mSGOnKRSrElnOMBrV14dPSItJCAC2K+vfqoM5p3Z3WnGX4v6p61SYYvS3ew69wRbgV1SDG++T3o5Vkpnwr/E9F7pUZ36cwSVijkBxy9rndracMSigXOJ2HFWekcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757419044; c=relaxed/simple;
	bh=yuCDpFi5rbOpE0JK/zNBJ23ZkC7xxv42pAHKzW27gjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L5rc1VANupBtjS5P5nhKEDK3qE5uKw893axzCvtzN54NLmWG1GIkQpRm8lDNyKZaOcLUUD0EkI0vdqbWoP4Z9v8nVTdoeYhFKg1/8d0Dc/D2zM/COFEhUtOc8SQc1RJqhVzj5OW78nM7UaonShbgyLkpwoLPwpOLXq8725MWZQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6Xj4yHm; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-625e1dfc43dso5109301a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 04:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757419042; x=1758023842; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yuCDpFi5rbOpE0JK/zNBJ23ZkC7xxv42pAHKzW27gjI=;
        b=f6Xj4yHmN4OlI145czn7FE9uTva7B5PktcJFGj2E7EbA6ZtJNAqapGN5MIOl90snSG
         r0boHPKpz2u9Fz74nA+Z/xEL3/RYv728V+GaW1vvcxDDUDad96G6Bmq/wJk+gojvafmh
         oyqxzulQeaLd6Xml3pZRuHgIWRUlJuU76QfIqxtynbhzDMG0eROOfskh6+m8Hdg/e0bo
         sKMQJslA5C1gd/R//NOloaRrOPs0dcm8/e/WNulXbCnU+hr0lTBsI6391PmhUsz6eLhQ
         a8DnNG2T9cU4wDthlMcKhMyazLNHmqmLtfzE/GJLiYog/9KB5/fdusM4UCsHYV0Rvfr7
         ozdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757419042; x=1758023842;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yuCDpFi5rbOpE0JK/zNBJ23ZkC7xxv42pAHKzW27gjI=;
        b=M6p1fUCb3Jjb8MNRsXFlHImphsotM1x12tasBKOXL0r+HV/+F/zoMbs0QdBl4YM0/g
         0r/e9Ivkc++Dh6FghbceJzG6YtJD98BSXxlSqpG11FDV1FIQsQMUHeolZdvlJ+YfQlbL
         k/iNIYB3pL0oNx9NbYtYDvmAr8NMx1gG44VPqa3gWEKX+Nf89b/G9KScMZ7/1eAkbNit
         q73i20nDgHJTjsjHhoLFJGejWfWea+QsJyl1iSJNM/6E/FD4aA6RJG4mpoxERoZ9svdN
         nFLUFVcMOYDtHkryLv9ACvydsB1tL5Wd3hUR1BBnUUKM2Ov8vavPvjuXl4aMFVXx9754
         5x/Q==
X-Forwarded-Encrypted: i=1; AJvYcCV/ii/lgFWXXu0u+A8fnZ3fUnZfjRTKoB2kXaecesPHU9LsY26x2oq5P7sPuxiW+ODmbLmGNWv55xiFMmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGglEher6MV7LEri0eufkpxy/Ezq0a+kk2iLgZeSvK+bkhKAo7
	2tbDbxDNmDGxuecQcAIIEklQsv629MqfFp7rDq3zlQvUozIOTGqkl1SNF0a7/OVnFWIeQyjh6zi
	Z8SZhC2+W6RzpuVBrUuZlqc1qglLbxPA=
X-Gm-Gg: ASbGncvHs2/4tFbguEUhe3Ha0oR1RrCkgLjqMSFE39RpDRtgr/+3eLsTSsL9iBQNKpj
	KQJ1Eq0NHtqeFM+ZY5MIYCOrQ4ACK7X5CUuBIhSzJLJ5+iVjU3/AbF5hQR6Ste+aAb/u+Z93w1Y
	VPZttgAVRU485ypceNPR8ye57p3ivBTpnOtw6PEyJnT6KzJbEt3EjtqMOscGqudBu78KXmt2+Hp
	3qJFHZi3Hu+id+HwU19xpz4/OyDkQ==
X-Google-Smtp-Source: AGHT+IFWzr+q68gGxYAFoeb3uI8/O6WUTRKkifzdIp81TCMsGZWVR3LYvNL8bjLQ9XMbKBsOaM3e8t33FBxcTQ4++NE=
X-Received: by 2002:a05:6402:3511:b0:628:1503:e02c with SMTP id
 4fb4d7f45d1cf-6281503e1cemr6478837a12.2.1757419041365; Tue, 09 Sep 2025
 04:57:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827-vchiq-destage-v1-0-5052a0d81c42@ideasonboard.com>
 <20250827-vchiq-destage-v1-4-5052a0d81c42@ideasonboard.com>
 <731ead88-8dc9-4032-86f5-7a2dd5044b22@gmx.net> <175690685574.8095.13306600513284108529@freya>
 <0b9fa19b-195b-4bee-8f51-6b00ff2fcb6a@gmx.net>
In-Reply-To: <0b9fa19b-195b-4bee-8f51-6b00ff2fcb6a@gmx.net>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 9 Sep 2025 12:57:10 +0100
X-Gm-Features: AS18NWA1T_AOrlXPyZD_b1ewqRjcdGDJaWojtfrcUD5zfFVI3yE7LhbqooWIwow
Message-ID: <CALeDE9PQhYvGXOWE35EZG-e=7HCTRCw9gt7KhtuWUxMHVz_--Q@mail.gmail.com>
Subject: Re: [PATCH 4/5] media: staging: Drop bcm2835-camera driver
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Jai Luthra <jai.luthra@ideasonboard.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, "Ivan T. Ivanov" <iivanov@suse.de>, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kernel-list@raspberrypi.com, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"

Hey Stefan,

Thanks for adding me to the cc:

> >> Am 27.08.25 um 08:24 schrieb Jai Luthra:
> >>> The bcm2835-camera driver is replaced by the V4L2 bcm2835-unicam driver
> >>> that is already upstream. So drop it from staging.
> >> AFAIK the old Raspberry Pi Camera V1 isn't supported by V4L2
> >> bcm2835-unicam. Personally i'm fine with this, but this must be clear in
> >> the commit message.Did you already talked to distributions like Redhat &
> >> OpenSuSE about this step?
> > As Dave mentioned, the OV5647 should work with V4L2. I don't have a sensor
> > with me, but I can order one and try to get it working with the upstream
> > kernel separate from this series.
> >
> > I did test the V2 camera module (IMX219) with my series applied on top of
> > upstream kernel, and capture worked fine with bcm2835-unicam, so I don't
> > believe V1 camera module should be an issue.
> I was in holidays the last days, so I better reply to this thread /
> context even there is a V2 out yet.
>
> Yes, this explains the technical part behind the motivation and I'm fine
> with this to speed up unstaging.
> But my point was "Are the users informed about this step?". So I hope
> the extended Cc should do this job at least for popular distributions.

I was vaguely aware because I randomly read the lists.

The last I looked there's still some missing bits stopping the unicam
driver from working out of the box upstream. What is the status of
that delta?

Overall I'm fine with the old camera driver going, it never worked
particularly well upstream on Fedora so I suspect overall even with
the missing bits on the unicam driver I don't think we're actually
worse off, but it would be nice to get the last bits in place so the
camera actually finally works upstream

Peter


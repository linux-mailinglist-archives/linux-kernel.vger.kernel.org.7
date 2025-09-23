Return-Path: <linux-kernel+bounces-829781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF5AB97D03
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 01:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EFE019C73FE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 23:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF5130FC3B;
	Tue, 23 Sep 2025 23:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNdg7zw8"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE32627FD56
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 23:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758671086; cv=none; b=et4mOzzH3FZnVQgIodUie5D+DuQp9/ypvGpeWSqiXVXoLJ1qWEvmLakjzbiqMfF5IY9dkPX3znYkXX5lbzvryrD2YXJYz/lhQK9sae+KzqZ+E2ND/2AKanQUFucaafzqqyzX4K4f9KYctV4AaZWY2OCX9fQLMUpt0dpQnupRD18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758671086; c=relaxed/simple;
	bh=q+ShdNu3mZLTF7V/TpTF+BaAtp8uVS6tAaTiAN+OxgU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hjG7jtF2Knp91yKmpFsXPI2zctXzLhZOma2LgvqJuvfAW2bP7bYmh+tJ5THyM1SatoBZ28sDuzG8Zxfgxx75Z6/mrVrRv18vha3IzzbmffWoXnOl6wpPK5kLYPEuGQysczfn5oXt3LlGbRm3OKhGJffT+2sxWAwxZDJJusQczHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNdg7zw8; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-33292adb180so2114189a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 16:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758671084; x=1759275884; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ljeySVlhO9O2RzXIms8aAw71D6omm7wNApUjDETNmPM=;
        b=jNdg7zw8A9vH/v8yPEp3pUqHzkz9aFa3hCTY4U8DXD9XR75HwUwiBz9e6f9cTPdR5P
         I+UaI+nAHiEkwoVx3ofXRwvhhFnRJcwdH9L7EQkqbk6o6/H0HG4tzvBPCNbE4+Tr+Rhb
         2ygJsHnM2orV8Nw9J4OZO1WL/KS14nIznzVOLoM9dGe2ldmgpMDnjVlFbQxpnn+q47U5
         V43kPT4BEdxfqoEVfMteoz/LwKLLHoMeQ3e4NzbWHkNI/uPqD6EifS9Gn42QmkHvryha
         91BPPD1bPotVJcN+LzoIYARN29q8h5gBymmrRdmt+/1JXe3yloCcMd4Nu5ql/2z8liMm
         Mr5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758671084; x=1759275884;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ljeySVlhO9O2RzXIms8aAw71D6omm7wNApUjDETNmPM=;
        b=OsJoD54b7VCw6n0ekxWMdo91Kv2mSvzsw3JKluB366aiE7Tpwy7Om+5nRCAGhM1G/p
         mnhxayrVc52F+yKKDvWlWlt3/N8SyWhqM6Kce5M0VyeudmwtS5Bqgd80HUOaQa20JuWW
         W/tFzNTwK2oT1IW6UfV1gMaDUp1kA+MpPxUl37m8e0UvwqrO5tTab8cIH1S0mImFpe/1
         cuH/E3MliY/a7hagoHj68IHw17S2FPZBuQPzRIJH4ESV5doQwB9V0SPC3H3EvxPO+n82
         fT6ffkzydg18RmfQiYG5FCQkzraP5mL8GHqfe8VkPmlT+QebnyALB5S9oEvcAqBMzA3Q
         D4+A==
X-Forwarded-Encrypted: i=1; AJvYcCXh/o17vN08gjnZBf4aCTdvQsa9DXeBwNt+fXWyuC2G5YeejntfOELCQutq0ahuDvMWfg7NP1Lr97gt1bo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2Xwqb/3CRxs+YxUKeLnLAdDtRXOa+9ucUm/+FEYDBoSdecFNi
	7tmiQYxrSzmJRRcQi3X9wnADYrcbxNZc3Sa5a32NLFQY1OPD5g8/6/Og
X-Gm-Gg: ASbGncuwGnAl2grKOFXgEt0yrNIBGBVkDfLoxMMDlyoGFZdx9fJ5eCfKkLmFp7cY9uX
	DzCfLw9CWCrjgTEtUqd7RCwFrY7qCX+618DE/lhbuj+jwq21JvuNjoNN6SBIEO7jjawZ8xeCbJP
	oTCwlvEG1xcdtw4ViAz8DlGoRZ1sxQuSPMhIncK0EI/vTo6XDtfdpvr8KrkxJJ9rvFy63771X4S
	jJZf3P8ZrwJoUoe9R0KlIAIuRcYu2Lmslkk+SiLBNB7Nbc1jTQ0EiKcnGqbR2RrW2t/xLMB+J+D
	zzpdbvBtYYDWo8aMopMqbc8HVOuQbLG0Y1j+1bXrzJWROF3nKBwPv7O89586m9L1leEAKdd7eA+
	5/dZx+pmpTmE15sncxU4xzj6iKeKAvo3sqHafBjDWew2rEEsSY8ylW6T40SK0TwOzWvsz7B2ZiC
	SC40t2nzks
X-Google-Smtp-Source: AGHT+IEVnZIbbqf2p9wMdtt8M+QLyi1YtUEPt/5HLeZ9i7P3juMXg/cqIvjxJL7ve5wKBdQZvEgNpg==
X-Received: by 2002:a17:90b:38c3:b0:32b:65e6:ec48 with SMTP id 98e67ed59e1d1-332a94df134mr5552161a91.8.1758671083824;
        Tue, 23 Sep 2025 16:44:43 -0700 (PDT)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341bdc1bd2sm311257a91.21.2025.09.23.16.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 16:44:42 -0700 (PDT)
Date: Wed, 24 Sep 2025 08:44:39 +0900
Message-ID: <m21pnw91js.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v11 10/13] um: nommu: a work around for MMU dependency to PCI driver
In-Reply-To: <39692eca904137ce7d51fccdc948ae0b94b4fe4f.camel@sipsolutions.net>
References: <cover.1758181109.git.thehajime@gmail.com>
	<4a9dde10c586883d20a8201ca7d76e6d7d52eaf4.1758181109.git.thehajime@gmail.com>
	<a58620ecefa207e141a435c36492647c3d5bd3df.camel@sipsolutions.net>
	<m28qib8g1r.wl-thehajime@gmail.com>
	<6b1abe384237c8129e8043ecdfdad77758d2fd2f.camel@sipsolutions.net>
	<m27bxu949d.wl-thehajime@gmail.com>
	<da39f51b76cca54e5304064f7e34a8863442605d.camel@sipsolutions.net>
	<m25xde80qh.wl-thehajime@gmail.com>
	<39692eca904137ce7d51fccdc948ae0b94b4fe4f.camel@sipsolutions.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII


On Mon, 22 Sep 2025 15:32:22 +0900,
Johannes Berg wrote:
> 
> On Sat, 2025-09-20 at 08:46 +0900, Hajime Tazaki wrote:
> > diff --git a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
> > index 6a0354ca032f..04025207a077 100644
> > --- a/arch/um/drivers/Kconfig
> > +++ b/arch/um/drivers/Kconfig
> > @@ -159,6 +159,7 @@ config UML_RTC
> >  
> >  config UML_PCI
> >         bool
> > +       depends on MMU
> 
> That won't do anything since you elsewhere have "select UML_PCI"
> independent of MMU.

i see.

> > @@ -170,6 +171,7 @@ config UML_PCI_OVER_VIRTIO
> >         bool "Enable PCI over VIRTIO device simulation"
> >         # in theory, just VIRTIO is enough, but that causes recursion
> >         depends on VIRTIO_UML
> > +       depends on MMU
> >         select UML_PCI
> 
> Right, but you also need that for UML_PCI_OVER_VFIO.

thanks, I understand too.

> > and do
> >   ./tools/testing/kunit/kunit.py config  --kconfig_add CONFIG_MMU=n
> > 
> > the validation currently gives the following error:
> > 
> >  ERROR:root:Not all Kconfig options selected in kunitconfig were in the generated .config.
> >  This is probably due to unsatisfied dependencies.
> >  Missing: CONFIG_UML_PCI_OVER_VIRTIO=y
> 
> Well, OK, but that's fair - you did specifically override MMU=n, and
> virtio-over-pci needs it.
> 
> > 1) use --kconfig_add CONFIG_UML_PCI_OVER_VIRTIO=n when using kunit w/
> >   !MMU, and drop this patch from the series (no modification to the tree)
> > 2) prepare a different file for !MMU & ARCH=um testing (e.g.,
> >   arch_uml_nommu.config), and add an option to kunit.py to switch MMU
> >   or !MMU
> > 3) implement virtio-pci for !MMU and propose to remove the restriction
> >   of CONFIG_PCI depends on CONFIG_MMU.
> > 
> > 2) will be removed when 3) is done so, I'm hesitating to propose a
> > patch used by whole tree.
> > 
> > so, I think 1) is (not the best but) a reasonable solution, with a
> > note in nommu-uml specific document (i.e., [PATCH 12/13]).
> 
> I don't think (3) makes any sense at all, we should just _never_ do
> that. !MMU is really here in UML for testing to support other
> architectures that are !MMU, and since by today's definitions no other
> architecture can have PCI without MMU, it makes no sense for UML to have
> that (and complicate the PCI code unnecessarily, etc.)
> 
> I think it's entirely reasonable to have overriding CONFIG_MMU=n to also
> necessitate overriding CONFIG_UML_PCI_OVER_VIRTIO, i.e. (1).

okay, I'll go for this direction in the next series.

> As to whether or not to add a specific config file, honestly I don't
> really know or even care - you'd have to ask the people who actually
> want to test !MMU.

indeed, this will be the out of this series if needed.

-- Hajime


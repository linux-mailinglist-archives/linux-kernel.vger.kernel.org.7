Return-Path: <linux-kernel+bounces-825352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBD7B8BA43
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 01:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 618A17E77F2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 23:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E705F29CB4D;
	Fri, 19 Sep 2025 23:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R340Evta"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F4523E32B
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 23:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758325582; cv=none; b=iaPLGCeVO7Mm/lEJ0jFguXrfqbtTDEs9vsyZsRneRSnkvz07uye4R4kCZ6IgtyvU/v+pOj9QQGJEZW6R3Xc+T4xbyyKDp0F0ntmg7FArlxvOJAmIBw/lFtPe4R0EHBKfw6qBWgyv5RoGZIykvV+d1gQF/FgCYFkOXftIklDT6PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758325582; c=relaxed/simple;
	bh=cDvnHPbUj+LRk/djy31bfrbfi3dmwyipTstia3wXvbs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mt7rFuBpc67F1fcZerOdAzTN4QJPsksL7GEnv+sUG/rJHWeFh+Iw1PTeqA6c1Wl/xZHddOTuaPRQmimnFaG5B7AudQJQ7uEyB/b02b1J6QOLGzrhZJQCXqQ1/ayttUdnqwgv99ManhpwWhforroaq5fGTFqD1zVPO/3jvZbTOHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R340Evta; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7761b392d50so3519217b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 16:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758325579; x=1758930379; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XM6G+Tnflz7sZdGSI4xVWIr0TRe/kf+B7MZhs/o8MZU=;
        b=R340EvtaBsNzh+b4E0fLT52hb9UBe+0aX8dM9fPJkqyC6n+ghTazlen7UBEkhZ/Cy3
         325ttD6RMdCrxvsHvvfwPRXHYs+2yQnOmj4bG105XjYIxxzKV+zj2P0/nDLgW+Qv6a8k
         MeyU9XgIl+w/Rl/me+saLGgZ8AROaYsWhr0IP5TzS4aJepe6LyjE4lA9/tBtCJY1sBmm
         qQq+1OCGrMqEfxNkHX0uXP8XhnL12acDmRJZH7cUBW4GoVLHNgx576f8iCgz3kCTffnY
         03+q9LzfZQ36VE4csr1wGyNwp8cJi1vD8pVzy1RpsshhmVdxE4pdSnB5WJOKkKYZWyr8
         i2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758325579; x=1758930379;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XM6G+Tnflz7sZdGSI4xVWIr0TRe/kf+B7MZhs/o8MZU=;
        b=Ce6Kuk8rCB0fADg579CpuimOIM0Md//6ns8j0GoyubCRLutmWPh/Z1u6e7v05332q+
         bCcK2Osu6v8iirdxBWQbkDbSt0+Q+DIetJJvygafCFUdVUKNXEm4/XtpHdE1p+AePJA3
         K9O1A3gOmW67z12ePA6d+mzqMU5TorNr4boPIW8+vuNMMdmR3bWpUpgrDhe+Y0Gh02yz
         gkiiBO5+Hypdj2arecbwSK2H8dzHYpHuivldsuApkwGOPo9/KdXNJBeyX7gOlXxfg8Md
         KzJtDBvhAb6m9P1hAVtCxgqYusDKP8lBJBsZ92ZdqFWSgZyNn0KoAJjSHkZYq3OMJXzC
         Fd5w==
X-Forwarded-Encrypted: i=1; AJvYcCWU5wOFMygeXFKLlY8TwGErD1Y0TbMfBrPfk7lMOVEYNeXYhgPL3+3+TQGdmoZWBINQnXyhBh6xlmUXFIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBa5lanGcOWlTHQSCtmk4zpgYVRXXfDNtY8Sr7oBhYoY4tndUH
	YaIZd/97l2KBXTCU+ii0Mcio0TrtZ5nik/e68BHicOEgmdDLpYUlxp3I
X-Gm-Gg: ASbGncvWmiBEcXoXdURGZLAQrk69huKgXFRsRsyaHwk1t15X4ks9xjUs3y4O54WU5xc
	ADb5NKXwUjkQaRj7nesKq+IxadHR9x+daJb4BHww8fYCEWISrGhY4cScpQS3qlPxx68t/YYgzHm
	YAQB57igXLB8/1Ux+q8S62VbRl4Z7pIbGZKfkRKs8rO1BBz3kAGQ3+b19S3BighSUsFzSXBe3BH
	YwdgbYGxuy99kEMTXqbn+zLC+2mk24Us9Bbe+xpNNJbtM4XuTctkRwDvxdatovYz0iJnpItzRhj
	9yrXNOY3vKErq4GZF3wT/k4St89LqlAeYZsnJCfdBiF4JM7j3OYlRg8GoFy8TPlrj5rXut0Vs/a
	UiCTpMO+1WpdUiBZQO8rlPUsQmsfJ5M8aswnJ/GzCvrgCEGyu95gaJBAkJQjS6XyGAziGGetQZ7
	J48gTtf3Kz
X-Google-Smtp-Source: AGHT+IHTGzVIJIJcoTXCreng0sRNp1AId04yLbL+ZcNgHnLi02tUhTStytUkT5LQWEaFUur4vICTog==
X-Received: by 2002:a05:6a00:3e1f:b0:772:101f:5e46 with SMTP id d2e1a72fcca58-77e4d223acbmr6416198b3a.12.1758325578758;
        Fri, 19 Sep 2025 16:46:18 -0700 (PDT)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f0ef2db80sm1846205b3a.24.2025.09.19.16.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 16:46:17 -0700 (PDT)
Date: Sat, 20 Sep 2025 08:46:14 +0900
Message-ID: <m25xde80qh.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v11 10/13] um: nommu: a work around for MMU dependency to PCI driver
In-Reply-To: <da39f51b76cca54e5304064f7e34a8863442605d.camel@sipsolutions.net>
References: <cover.1758181109.git.thehajime@gmail.com>
	<4a9dde10c586883d20a8201ca7d76e6d7d52eaf4.1758181109.git.thehajime@gmail.com>
	<a58620ecefa207e141a435c36492647c3d5bd3df.camel@sipsolutions.net>
	<m28qib8g1r.wl-thehajime@gmail.com>
	<6b1abe384237c8129e8043ecdfdad77758d2fd2f.camel@sipsolutions.net>
	<m27bxu949d.wl-thehajime@gmail.com>
	<da39f51b76cca54e5304064f7e34a8863442605d.camel@sipsolutions.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII


thanks Johannes, I think I got a clearer view than before.

I guess Kconfig does the right thing.
And Kunit does the right too but an additional job which Kunit does
prevents run tests w/ !MMU.

> >  CONIFG_MMU=n
> > 
> > via --kconfig_add CONFIG_MMU=n.
> 
> Sure. But that should disable CONFIG_UML_PCI_OVER_VIRTIO, and it doesn't
> now.

Kconfig (via kunit.py config) disables CONFIG_UML_PCI_OVER_VIRTIO
correctly.

But after that, Kunit does the additional job, validate_config() (in
kunit_kernel.py), which checks the configs (arch_uml.config +
--kconfig_add) is a subset of the final result of .config.

When I applied a patch below:

diff --git a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
index 6a0354ca032f..04025207a077 100644
--- a/arch/um/drivers/Kconfig
+++ b/arch/um/drivers/Kconfig
@@ -159,6 +159,7 @@ config UML_RTC
 
 config UML_PCI
        bool
+       depends on MMU
        select FORCE_PCI
        select IRQ_MSI_LIB
        select UML_IOMEM_EMULATION
@@ -170,6 +171,7 @@ config UML_PCI_OVER_VIRTIO
        bool "Enable PCI over VIRTIO device simulation"
        # in theory, just VIRTIO is enough, but that causes recursion
        depends on VIRTIO_UML
+       depends on MMU
        select UML_PCI

and do
  ./tools/testing/kunit/kunit.py config  --kconfig_add CONFIG_MMU=n

the validation currently gives the following error:

 ERROR:root:Not all Kconfig options selected in kunitconfig were in the generated .config.
 This is probably due to unsatisfied dependencies.
 Missing: CONFIG_UML_PCI_OVER_VIRTIO=y
 Note: many Kconfig options aren't available on UML. You can try
 running on a different architecture with something like
 "--arch=x86_64".

so, if I give an additional --kconfig_add CONFIG_UML_PCI_OVER_VIRTIO=n
to the command line, the validation passes, because the configs
(arch_uml.config + --kconfig_add) becomes the subset of the final
result.

what I can handle this would be either of them:

1) use --kconfig_add CONFIG_UML_PCI_OVER_VIRTIO=n when using kunit w/
  !MMU, and drop this patch from the series (no modification to the tree)
2) prepare a different file for !MMU & ARCH=um testing (e.g.,
  arch_uml_nommu.config), and add an option to kunit.py to switch MMU
  or !MMU
3) implement virtio-pci for !MMU and propose to remove the restriction
  of CONFIG_PCI depends on CONFIG_MMU.

2) will be removed when 3) is done so, I'm hesitating to propose a
patch used by whole tree.

so, I think 1) is (not the best but) a reasonable solution, with a
note in nommu-uml specific document (i.e., [PATCH 12/13]).

Let me know what you think.

-- Hajime

On Fri, 19 Sep 2025 18:38:03 +0900,
Johannes Berg wrote:
> 
> On Fri, 2025-09-19 at 18:32 +0900, Hajime Tazaki wrote:
> > currently, drivers/pci/Kconfig (CONFIG_PCI) marks as depends on MMU,
> 
> Right.
> 
> > so we cannot select it when CONFIG_MMU=n.
> 
> Actually, I believe that's not true, I think it *can* select something
> even if you override the 'depends on' it has, it just causes a warning
> in Kconfig.
> 
> But I don't think PCI is even selected, UML_PCI is selected, and then
> that selects PCI_MSI which should really only be reachable when PCI is
> enabled, so this perhaps does nothing? Not sure ...
> 
> > but it's different with kunit when using them via kunit.py config,
> 
> It really isn't, you just don't see everything because kunit.py hides
> the build from you.
> 
> > it first adds
> > 
> >  CONFIG_VIRTIO_UML=y
> >  CONFIG_UML_PCI_OVER_VIRTIO=y
> > 
> > via tools/testing/kunit/configs/arch_uml.config, and then add
> > 
> >  CONIFG_MMU=n
> > 
> > via --kconfig_add CONFIG_MMU=n.
> 
> Sure. But that should disable CONFIG_UML_PCI_OVER_VIRTIO, and it doesn't
> now.
> 
> > and then execute make ARCH=um olddefconfig, which in turn enables
> > CONFIG_UML_PCI_OVER_VIRTIO.
> 
> Keeps it, let's say.
> 
> > if we append "--kconfig_add CONFIG_UML_PCI_OVER_VIRTIO=n" to kunit.py,
> > it will overwrite the arch_uml.config.
> 
> Yeah but that being required doesn't make sense - the Kconfig should
> express the correct dependencies.
> 
> > # I don't know how kunit handles those appended CONFIG entries, though..
> 
> It just puts them into the file and runs oldconfig, I guess?
> 
> > my goal is simple; to test !MMU code via kunit.
> 
> Sure.
> 
> > my original patch or the additional kconfig argument (--kconfig_add)
> > satisfies this goal.
> 
> Sure. But both are the wrong solution, as I said, the Kconfig should
> express the correct dependencies.
> 
> > > The problem is probably UML_PCI_OVER_VIRTIO selecting UML_PCI selecting
> > > various PCI code, but nothing depends on PCI in the first place. Which
> > > it should, then?
> > 
> > I don't understand the 'nothing depends on PCI...' part.  care to
> > elaborate ?
> 
> See above, I think?
> 
> My gut feeling is that UML_PCI_OVER_VIRTIO should depend on PCI but I
> don't know if that then doesn't end up in some kind of circular
> dependency.
> 
> johannes


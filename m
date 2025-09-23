Return-Path: <linux-kernel+bounces-829422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F248B9710B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C1CB2E2769
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE12283FE5;
	Tue, 23 Sep 2025 17:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DMM9b5Aj"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E53280A20
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 17:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758649339; cv=none; b=lsKmiG7BbgiW+pzHXHnt1UVWlyUPHOiz7rXSAjGj5Nfan9N6ere2cRXzlGthDiEmjtnS8Vo/U0kU9BmaimpIfAM3fAUnDrhfjcn2iOMmPNg6gY3BACUb/ImUyQbhqrf8ywVbMbpUmshmxtboN+h8H6uUyJdQQKDr3bhESzbw63s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758649339; c=relaxed/simple;
	bh=6G5hq2ESPXxgPR53Lq8sJO77YPWnS5k2F15nLBfDTQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=igRbnnaw5Ttcr1W1EDTcFk9J1ic7XrbV3xYh7lph6G+zhLF55+N/b7gfDomwhy125RFF8d4uR0gar+OvDBbypAzabOkPYCX5jWKdlLzbdcik5YccMndHMAfYHB2J8jNaf8KgKQ6aFOfbLMH/1168U/5RK3JXMvEiqIOkBwvvVxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DMM9b5Aj; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b4fb8d3a2dbso4136669a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 10:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758649336; x=1759254136; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p5fCe8unG2HiHz5XK0SHyJ7RQ4XF1Lq7hOFJcFoGeh8=;
        b=DMM9b5Ajy3IOhVOBk7y54ekzwIDr/1TF22r4z5B6hOlNuDv0FPMAs3EJFbw8+CNalH
         B6GTxKMqrVAo/OCFJDkpoRwvSuklRmz7QOkErP4zua26IKf+tC6ZFFeY4UDGml8mBjEI
         ULPNyc5PoNtn1Ff3XocHVciCu6I2k3c+JaXxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758649336; x=1759254136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5fCe8unG2HiHz5XK0SHyJ7RQ4XF1Lq7hOFJcFoGeh8=;
        b=vvxsNR2FesFcvfKuGG4+OX/+TZiwUEk0l8a79nMtn8G2nzmQgX+4M+2puwQNJJe3vP
         kLHq2tFl9G0IcTD0y5/FyvKtF/PTauOPNfwQ+kncTPbARJtTrbX1PGlCb9i+pmcrqtqf
         iY8812MT0BgMiBNueJ4dHStnZcxTRD4lZwsLzP26QcjKRAR4e3uuB1+Ao0rSCmBzOqTv
         vLY+ezFIJgKFJjmiAxiOuiL0smm70YfwGcRzrZTqdLyO062+vCoLVZgxHRbDMf+aw/zG
         r5Bgz6MNfbkPF37qY/XpDLeJ/hX0h6ggv6pQ5HC/LW5VBWvTVKRdqBGuGKFjk3GeyvuR
         dv7g==
X-Forwarded-Encrypted: i=1; AJvYcCUt4Wi0u39WBOSuCMx6UYK1PU+oBmSBmyQEH+5Q1B6rJPQtvXiRAf+Hk3TXMI/41lDBfV4E8K2JlyXSQrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuRM3Oomj0EPgsCNEmXdgIOk+8TxlWe/yP+YHXqVbjS/k+Eea1
	CbzfPyLP0FL8x6kqR2TkOoa+7o92OBCbL/ZlUmY5wJg2vFMiqm8hjqYIp0vaFpWR5Q==
X-Gm-Gg: ASbGncvnODPatUKfiUjUwAF2h7u2kj1c9gv0t6MNy8WGzya07mLx3UNYZh77vd1YEHJ
	UOd5IRf65wfvixz8GSWvR0zZJiGIXT8bCdTMgaKKbpS9btUA2FmI7z6gvnRfsAwnUypnogKOqIJ
	/8bf2xCzMCTE1uXBGsKCqAzswtWedxp2Z91kkf5arziyw9+is2ScQM2QhP8VhDtWjGuyyJtzSxr
	hNLK4zur9IGMigyuFdZf9eqfSyOC1IAk58ehAlFKYAuFbZNXXG5DiCX1KUKSwQq1k2Szs6PWpgT
	ADyjifHgftOIcbdM6AWPg52oDgixYv9jRy1cbbJnYloUpqy8wnmzrMeSbvb0s7tLowbwav0uIRi
	lW2753f9+tw/N8bShux45bZNWm7/u3Wd4H9U4rtNjTtxgrSiOk/tWfCGyKqHMuHLHXiloJObk07
	oX4qg=
X-Google-Smtp-Source: AGHT+IHJbwEaaCpD6dZUF3mz350pgxjUUNoYTVUR2WMjcFJjbWFfvBHQKr1Y1HlZkG2OkTtL8B8Dkg==
X-Received: by 2002:a17:90b:3cc5:b0:32e:8931:b59c with SMTP id 98e67ed59e1d1-332a9909c66mr4171539a91.27.1758649336532;
        Tue, 23 Sep 2025 10:42:16 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:f126:ac9b:b8ac:e280])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-33060803335sm17000731a91.24.2025.09.23.10.42.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 10:42:15 -0700 (PDT)
Date: Tue, 23 Sep 2025 10:42:14 -0700
From: Brian Norris <briannorris@chromium.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Daniel Gomez <da.gomez@kernel.org>, linux-pci@vger.kernel.org,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Sami Tolvanen <samitolvanen@google.com>,
	Richard Weinberger <richard@nod.at>, Wei Liu <wei.liu@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	kunit-dev@googlegroups.com,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	linux-um@lists.infradead.org
Subject: Re: [PATCH 1/4] PCI: Support FIXUP quirks in modules
Message-ID: <aNLb9g0AbBXZCJ4m@google.com>
References: <20250912230208.967129-1-briannorris@chromium.org>
 <20250912230208.967129-2-briannorris@chromium.org>
 <c84d6952-7977-47cd-8f09-6ea223217337@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c84d6952-7977-47cd-8f09-6ea223217337@suse.com>

Hi Petr,

On Tue, Sep 23, 2025 at 02:55:34PM +0200, Petr Pavlu wrote:
> On 9/13/25 12:59 AM, Brian Norris wrote:
> > @@ -259,6 +315,12 @@ void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev)
> >  		return;
> >  	}
> >  	pci_do_fixups(dev, start, end);
> > +
> > +	struct pci_fixup_arg arg = {
> > +		.dev = dev,
> > +		.pass = pass,
> > +	};
> > +	module_for_each_mod(pci_module_fixup, &arg);
> 
> The function module_for_each_mod() walks not only modules that are LIVE,
> but also those in the COMING and GOING states. This means that this code
> can potentially execute a PCI fixup from a module before its init
> function is invoked, and similarly, a fixup can be executed after the
> exit function has already run. Is this intentional?

Thanks for the callout. I didn't really give this part much thought
previously.

Per the comments, COMING means "Full formed, running module_init". I
believe that is a good thing, actually; specifically for controller
drivers, module_init() might be probing the controller and enumerating
child PCI devices to which we should apply these FIXUPs. That is a key
case to support.

GOING is not clearly defined in the header comments, but it seems like
it's a relatively narrow window between determining there are no module
refcounts (and transition to GOING) and starting to really tear it down
(transitioning to UNFORMED before any significant teardown).
module_exit() runs in the GOING phase.

I think it does not make sense to execute FIXUPs on a GOING module; I'll
make that change.

Re-quoting one piece:
> This means that this code
> can potentially execute a PCI fixup from a module before its init
> function is invoked,

IIUC, this part is not true? A module is put into COMING state before
its init function is invoked.


> > --- a/kernel/module/main.c
> > +++ b/kernel/module/main.c
> > @@ -2702,6 +2702,32 @@ static int find_module_sections(struct module *mod, struct load_info *info)
> >  					      sizeof(*mod->kunit_init_suites),
> >  					      &mod->num_kunit_init_suites);
> >  #endif
> > +#ifdef CONFIG_PCI_QUIRKS
> > +	mod->pci_fixup_early = section_objs(info, ".pci_fixup_early",
> > +					    sizeof(*mod->pci_fixup_early),
> > +					    &mod->pci_fixup_early_size);
> > +	mod->pci_fixup_header = section_objs(info, ".pci_fixup_header",
> > +					     sizeof(*mod->pci_fixup_header),
> > +					     &mod->pci_fixup_header_size);
> > +	mod->pci_fixup_final = section_objs(info, ".pci_fixup_final",
> > +					    sizeof(*mod->pci_fixup_final),
> > +					    &mod->pci_fixup_final_size);
> > +	mod->pci_fixup_enable = section_objs(info, ".pci_fixup_enable",
> > +					     sizeof(*mod->pci_fixup_enable),
> > +					     &mod->pci_fixup_enable_size);
> > +	mod->pci_fixup_resume = section_objs(info, ".pci_fixup_resume",
> > +					     sizeof(*mod->pci_fixup_resume),
> > +					     &mod->pci_fixup_resume_size);
> > +	mod->pci_fixup_suspend = section_objs(info, ".pci_fixup_suspend",
> > +					      sizeof(*mod->pci_fixup_suspend),
> > +					      &mod->pci_fixup_suspend_size);
> > +	mod->pci_fixup_resume_early = section_objs(info, ".pci_fixup_resume_early",
> > +						   sizeof(*mod->pci_fixup_resume_early),
> > +						   &mod->pci_fixup_resume_early_size);
> > +	mod->pci_fixup_suspend_late = section_objs(info, ".pci_fixup_suspend_late",
> > +						   sizeof(*mod->pci_fixup_suspend_late),
> > +						   &mod->pci_fixup_suspend_late_size);
> > +#endif
> >  
> >  	mod->extable = section_objs(info, "__ex_table",
> >  				    sizeof(*mod->extable), &mod->num_exentries);
> 
> Nit: I suggest writing the object_size argument passed to section_objs()
> here directly as "1" instead of using sizeof(*mod->pci_fixup_...) =
> sizeof(void). This makes the style consistent with the other code in
> find_module_sections().

Ack.

Thanks,
Brian


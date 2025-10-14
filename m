Return-Path: <linux-kernel+bounces-852379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7B2BD8D05
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A4B24351D27
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4A02FB986;
	Tue, 14 Oct 2025 10:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gINuyYcg"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256622FB629
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760439064; cv=none; b=ezjZjh6lgoYnP4jkDsJX7rUTlzjmutkVelz6qREg6d2TnNNDzSyxwEq88Jo5LRSV6sPz5VUl0d3R9TOaczsMLMQJvFMU8MSOKkchtDN1DjvSPVFJXQJxb5ue7MbtBLBwuZcHA+8VYYOTbrowhWdl+eF6+pRqygCeo0k+QrVJXEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760439064; c=relaxed/simple;
	bh=t6ZTEkCFjn7ORmNR+yNDKdr9EdjjuJkJcyLAzNXnR6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N+2QJRrzfFD2WwiCeRvKgE7lSeh7TMB2i4GM26J0mshVdCjt6Xc14j2kek2MdzkS3tbhHGuIvxOODk2YUv9x2/ItVkMJMJ/dibnCvDnJxi5VdKd3cvxwfSbwkr+ExUrISIVVrQF9ZosRHhgb/kC9Q5HdbUtCBlh6mSivClMsGb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gINuyYcg; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46e3cdc1a6aso38898305e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760439061; x=1761043861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67sZRhK17t0DvjrpjVukNiKTpa8PMoIUjXV3F+8FBkw=;
        b=gINuyYcgvMiZQNDtP6TVjTOitQNfx+ny55X8oQv+Fzouq+pzoX5ihNHszTaGBoDN01
         rj9YZqGRd7uQ/aIm2D3jfMzDinqDgTi8R/m6MfjCK6PsUtji4C7UA+8CsnCgCY0mr6yg
         MAhjRidsV88AH0ZjH2hLCI++E2eogBZoS5VPA9oPSgm6Lu0M6bzRHTUJ9cblVksxm0Mv
         5CNFPPxi4FsVB0Ccr8su4YlU8wp1nGTp8Upe2RRolr0zyoy/4udMBMF0K0btRpcB0XiU
         49dsM1m9z66PIpHpIO8ZMOVyK7w6BZSdXOSD2s/H9OgeMzDxGNDCVTQAtEbwvZ+BUUEt
         JDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760439061; x=1761043861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=67sZRhK17t0DvjrpjVukNiKTpa8PMoIUjXV3F+8FBkw=;
        b=W5RLUgj6wsDiGWfOL5jndpb38wfXocp2M9hCn72e8ReM8Th5/c02+LziSl3gDAhn/7
         TOxBRrfmy7bgEWDFH9gVa4RX68fXlFk9xeETGqoAf+9LHl7ca+2h8uxkvvngn7cTw0VL
         KHWcfmG+w1OUIinaNzCbqivtpxnLRzrlgv1du3BPVWB5/g6Xm5U2dUZpK+LJaLteNSPn
         o8+P1+uGcdf2NEo3E1C75zNbl+BkadJjfjlVK+E7S06YVy5FCP0ODHF3NIrJxE7IhlAl
         U/Hb5YYW5m6PLNwoo6XVfF3sOCeI3Xd4AmGYlAA6uH7ks3daO+Ikf99Fr0BPeODXcFKh
         odxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOkhxX9MVu3kQxCGWFjNn9NG5dilO6Q37VnqNzY6+g4Hd0YLgX5FdaH+tLPTCdvEee/3ZmRn7S/ibHLeE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1RQ/k4+LHApxtvyvQc3IQWSCuyqWvE2Lec22Bmggwa0esd0Y4
	YxlZ+OeWuvTO50Wm37/GuORdUNVFla8URTzlOsi3rbqWjbDVSkl//g3w
X-Gm-Gg: ASbGncuRnzue+K7sSjE6bFljkb/rkOwFDcJnzh/xieKy5R9kql2Zy4ZfCv/8LMmpcuD
	B43sf/xVA2q+zFhzBpzEQOQAWb4+pggILtejoTiL2yRCu2i67qnKlL9i5xZBqgee1loAX33//Yx
	FOELcJmsNGa6M2RiXvyrEgnhY5pbovK+YgBiMVo+7H97quQdsX5KD+/vC30R8zzEx6su/wZBJlw
	JCv0FfnCRn7wn7gQlFh1u4IM6WXdbvNNk8B+rhGgBG7rxogiJ8wA5cfO6ITH4FZX0vVYid32eb6
	TWL3dxsk9gUZxUgnmot1Y9f0kJQLmsuTnmUKJpdLy/Hmb6G7BeNvuVRQ21/jg4D/0sVLwHeoCuC
	8Mqrr2iLaB2ueX/fjFd1YOssuP9db+HSF0GsH0JMRyKSIN7c5eBBZaRl7ZEnOBi5Tr1zxd9Mcyx
	aeWwKyC2Mdx0HBQFvbMA==
X-Google-Smtp-Source: AGHT+IH4aXT9bKP2phzL9KTt7CS0kf3eVsmrvJ6Vyb4hKgYH2GwIshKQzfIR8lFujzcRcVX6xLMerA==
X-Received: by 2002:a05:600c:6011:b0:45c:b642:87a6 with SMTP id 5b1f17b1804b1-46fa28bbca1mr144270075e9.0.1760439061091;
        Tue, 14 Oct 2025 03:51:01 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fc1c5227fsm169561175e9.9.2025.10.14.03.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 03:51:00 -0700 (PDT)
Date: Tue, 14 Oct 2025 11:50:59 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Borislav Petkov <bp@alien8.de>
Cc: "Kaplan, David" <David.Kaplan@amd.com>, Pawan Gupta
 <pawan.kumar.gupta@linux.intel.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>, Klaus Kusche <klaus.kusche@computerix.info>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/bugs: Qualify RETBLEED_INTEL_MSG
Message-ID: <20251014115059.797a888a@pumpkin>
In-Reply-To: <20251009231437.GCaOhB3aeJlTCu_OkQ@fat_crate.local>
References: <20251006140442.GDaOPMemqB7SRJSHWL@fat_crate.local>
	<20251007182257.ywrqrrhgrtrviila@desk>
	<20251007221229.GAaOWQTadGWlZSeAo_@fat_crate.local>
	<20251007230821.5shpa3pusyzaohb2@desk>
	<sb7p6quwxkn4w4etgsxlqd6fcsia4xobf73d3fnybxafxrmvwi@ajg5lkdxtnfy>
	<20251008102136.GAaOY7MBd4_VBPBNtG@fat_crate.local>
	<pnobm2r4icma6xzxvzklxoyoy3a4yhhxuxdoq2srmz6rpnegms@qneijnfu6fmz>
	<20251009101557.GAaOeLXYDjOnyFTWdg@fat_crate.local>
	<20251009171331.vplg2zcfystojcxo@desk>
	<LV3PR12MB9265301AEA5D0EDB672DC7A594EEA@LV3PR12MB9265.namprd12.prod.outlook.com>
	<20251009231437.GCaOhB3aeJlTCu_OkQ@fat_crate.local>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Oct 2025 01:14:37 +0200
Borislav Petkov <bp@alien8.de> wrote:

> On Thu, Oct 09, 2025 at 06:13:20PM +0000, Kaplan, David wrote:
> > If we really want to optimize a CONFIG_CPU_MITIGATIONS=n kernel, why not
> > also look at alternatives that will never be enabled?
> > 
> > All the extra NOPs I think can affect performance in various ways and if
> > there was a way at compile time to know that the alternative would never be
> > enabled (because the feature is completely dependent on a cpu mitigation)
> > you could eliminate the NOPs...  
> 
> I don't see why not. That mitigations gunk should be just like any other
> CONFIG_-controllable item and not simply "leak" into the build because, oh
> well, we've done it this way from the very beginning and no one should touch
> it.
> 
> So yeah, eventually we should try this. I've been experimenting with
> untangling bugs.c today, will check how much it actually saves us when
> I finish beating the stinking pile into submission.
> 

There are systems (probably with a busybox/buildroot userspace) where,
even if everything doesn't run as root, any access that manages to add
any code will likely give you root access.
So all the mitigations are just pointless.
Similarly if you disable 'page table separation' (which 'trivially'
allows programs to read kernel memory) there is no point compiling
in anything else at all.

I'd even suspect that Linus disables them all on his kernel build system.

In both cases you may also want to compile out clac/stac because of
their performance impact on most cpu.

	David


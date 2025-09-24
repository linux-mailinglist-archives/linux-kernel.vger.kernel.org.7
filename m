Return-Path: <linux-kernel+bounces-830083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C54B98B12
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 394337B62F9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 07:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F144284B25;
	Wed, 24 Sep 2025 07:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Vgo3cKoc"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90B228488B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758700133; cv=none; b=PYW+cTsVVvWtfYZLB8UDzjwB79kN5xGOSZJtrvSBMFWEgy32/cA7JKUl9aWJKCJX+zE/VYsG3sAwoAeEObRLkJNVhxrcWpZIn/mFJ85YBIoxrVkAEXzs2CTAnYx6e3/1YNIAOoRJZU0hJ8ZD6LOso0rLjh4NIx1HaBh/gkPB7xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758700133; c=relaxed/simple;
	bh=ntgz0WoIRVipjrzOQMbzUgc/QyjDqtJ9eBcmpETq3SI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j+KZHKzgKMwhBVvzz6KKvXLk/1qHP6w7DOJq8RVbVHY6YnuPl2yaFTZS5yVL1UiqmBrgfgFEsNHWUxcBsEuLSG4cZcgXvyRuWXeTxnngZOcPvHDRXroQud6L4Dn6SMexdyfKZMvA997z8+fMbX2VjOW0JIaPj8oBYu4/OokYzOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Vgo3cKoc; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45dd513f4ecso47014915e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 00:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758700129; x=1759304929; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R8l3AdnOSsRSws2FudDrnNOobQlzeM81boeBiHgd3uA=;
        b=Vgo3cKocO9IKPAvFAUXQCY1KpmVTN2f1h1FQPIA+GpkLA4VqhPu6o1VF71lkxX2sjT
         zHfHdxfX+1Pi66GTtnma5ywW3EgNB/Ej/3mtC8EY5IEz1z5rupqzP9vlXq2RmYMLrKSR
         eVxYeA7Uq6u/aZR0ZOQREL77KOqHgj8BN4nPj6F7H6DMuaBMKGZTwvKTg9ggwLPiXEDv
         JW5brNLHUaM6ZHpNTb//6VTK9l6UwfzpLhDP2x1xqauShDf478VAj+74iGhiQP5Qax/L
         Zhz5Xsi/aNWIPufa7BYGyoeT9PzuRDd0gzPahqUgE0TMOMUcTFeoi/KG4IznyHZ4tp+b
         FU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758700129; x=1759304929;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R8l3AdnOSsRSws2FudDrnNOobQlzeM81boeBiHgd3uA=;
        b=mj1I0NO6a+7fLKewF4ygeq7sz+l7a6YU27sLsQGNzY3k3ratcxxyIolRLdK/V/Lgwf
         2AvjSNvoS40OLb3Xc82Li2PIESow2A7J1aIDGgZ3ZwRNlpr7sWXuENtVLwaYBcn9K933
         s2Zu1MJQQUn6i+he+a/nFL616gZV05t1Ems75Rm5RElFDsoZIEElP6zH9+Rb/gm2M6lO
         UwI06bUPIRp/G4U1CHQf98b6+ONSweIHaf43dxF35TO+g+pLI2F9z6asQe/FxF/k/bSG
         S8NMWxkVbFvsEViLh+2z99CedNAbmn2lpao9dwmUG9XSojwbKign6Yh3DYZzbEOLgUN2
         XnJg==
X-Forwarded-Encrypted: i=1; AJvYcCU9fZsUYjRgCa7yCLMhDfeDG7vZsszGK7AKcvTR4JHH0RctHq7CEtBeAlQS5bZAsWfP1B5hSwr/djkD8tA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNJsabaIKc5oIKbq+hulrg30oUtmEAC+ltJp44iyxwWd262dTK
	A/6Gki90nWMkpNuTsXPloRUU6C2HTBJGCkKM3PukvmUSer+sczNdcSwQJRvv5mCsngw=
X-Gm-Gg: ASbGncvrBsa9hYLCQWtYcMXxyMp1+gjQSkOAEI5Y1UuVBxp782iV0ENmsiea9NJyJ61
	P3XeiHUlY/w0h3RqIrWGdzAvz4ef3zMOuVnUvudX+8woqTvKONa2FfBLnwPGWCWKdnrC60idn/g
	XC0qKAffvS7k8VLnqOfq8Vp8IbUgTQ3q9QA/3sCjZcKI/1RlgR8KxFC3EeNKRHXWwrjbXzf4K7r
	qSJe2FdFMo1r/IfD8/iX0xsqcSA4VQmxgoXorCtL/nSGScVdNct0caAFCbdsqfN5NmkNrdcCXPi
	DS9SQkPau44jJ6O2uXSwilhZJNReXFvkPqX1b7Clkk1+cCj4xK/lnSDEWMFew76E4venpsJoovz
	/Y0veLwOIPZCs22j/t1cnhC7y+m/gXW4+B3bdXb6bmuYhu40M9xw=
X-Google-Smtp-Source: AGHT+IFwNQTWzI6GYN83BC1thuAIQC8cKI7ga+QSPsI75xrmILyCBppuSPCKc3GbCcHRTNLHchQcjw==
X-Received: by 2002:a05:600c:1c87:b0:456:19eb:2e09 with SMTP id 5b1f17b1804b1-46e1d9746d5mr69959415e9.8.1758700128971;
        Wed, 24 Sep 2025 00:48:48 -0700 (PDT)
Received: from [10.0.1.22] (109-81-1-107.rct.o2.cz. [109.81.1.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a9af289sm20857535e9.6.2025.09.24.00.48.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 00:48:48 -0700 (PDT)
Message-ID: <2071b071-874c-4f85-8500-033c73dfaaab@suse.com>
Date: Wed, 24 Sep 2025 09:48:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] PCI: Support FIXUP quirks in modules
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain
 <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 linux-pci@vger.kernel.org, David Gow <davidgow@google.com>,
 Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 Johannes Berg <johannes@sipsolutions.net>,
 Sami Tolvanen <samitolvanen@google.com>, Richard Weinberger
 <richard@nod.at>, Wei Liu <wei.liu@kernel.org>,
 Brendan Higgins <brendan.higgins@linux.dev>, kunit-dev@googlegroups.com,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org
References: <20250912230208.967129-1-briannorris@chromium.org>
 <20250912230208.967129-2-briannorris@chromium.org>
 <c84d6952-7977-47cd-8f09-6ea223217337@suse.com> <aNLb9g0AbBXZCJ4m@google.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <aNLb9g0AbBXZCJ4m@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/23/25 7:42 PM, Brian Norris wrote:
> Hi Petr,
> 
> On Tue, Sep 23, 2025 at 02:55:34PM +0200, Petr Pavlu wrote:
>> On 9/13/25 12:59 AM, Brian Norris wrote:
>>> @@ -259,6 +315,12 @@ void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev)
>>>  		return;
>>>  	}
>>>  	pci_do_fixups(dev, start, end);
>>> +
>>> +	struct pci_fixup_arg arg = {
>>> +		.dev = dev,
>>> +		.pass = pass,
>>> +	};
>>> +	module_for_each_mod(pci_module_fixup, &arg);
>>
>> The function module_for_each_mod() walks not only modules that are LIVE,
>> but also those in the COMING and GOING states. This means that this code
>> can potentially execute a PCI fixup from a module before its init
>> function is invoked, and similarly, a fixup can be executed after the
>> exit function has already run. Is this intentional?
> 
> Thanks for the callout. I didn't really give this part much thought
> previously.
> 
> Per the comments, COMING means "Full formed, running module_init". I
> believe that is a good thing, actually; specifically for controller
> drivers, module_init() might be probing the controller and enumerating
> child PCI devices to which we should apply these FIXUPs. That is a key
> case to support.
> 
> GOING is not clearly defined in the header comments, but it seems like
> it's a relatively narrow window between determining there are no module
> refcounts (and transition to GOING) and starting to really tear it down
> (transitioning to UNFORMED before any significant teardown).
> module_exit() runs in the GOING phase.
> 
> I think it does not make sense to execute FIXUPs on a GOING module; I'll
> make that change.

Note that when walking the modules list using module_for_each_mod(),
the delete_module() operation can concurrently transition a module to
MODULE_STATE_GOING. If you are thinking about simply having
pci_module_fixup() check that mod->state isn't MODULE_STATE_GOING,
I believe this won't quite work.

> 
> Re-quoting one piece:
>> This means that this code
>> can potentially execute a PCI fixup from a module before its init
>> function is invoked,
> 
> IIUC, this part is not true? A module is put into COMING state before
> its init function is invoked.

When loading a module, the load_module() function calls
complete_formation(), which puts the module into the COMING state. At
this point, the new code in pci_fixup_device() can see the new module
and potentially attempt to invoke its PCI fixups. However, such a module
has still a bit of way to go before its init function is called from
do_init_module(). The module hasn't yet had its arguments parsed, is not
linked in sysfs, isn't fully registered with codetag support, and hasn't
invoked its constructors (needed for gcov/kasan support).

I don't know enough about PCI fixups and what is allowable in them, but
I suspect it would be better to ensure that no fixup can be invoked from
the module during this period.

If the above makes sense, I think using module_for_each_mod() might not
be the right approach. Alternative options include registering a module
notifier or having modules explicitly register their PCI fixups in their
init function.

-- 
Cheers,
Petr


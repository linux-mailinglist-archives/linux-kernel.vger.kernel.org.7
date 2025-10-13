Return-Path: <linux-kernel+bounces-851571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4C8BD6CAD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 01:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 645C64F37DE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 23:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984CA2F3622;
	Mon, 13 Oct 2025 23:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lZOCtGcb"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FCE2BF00A
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 23:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760399686; cv=none; b=sUxF6x6sQDoBqZInGlk6hJPp+WxEX1Q9tOZTOqQaoRzTPy1cJ+eqoBeDhYDvRzFadYonoIkv5/KSKiGUJNp2Gzy0cL23sNdoWQyh0qaI/GYT9LLq8yfY2urwjvray4ev8QETHsexbfe02+qamqcRaTlsVZDPYZ0INOCaWtoimig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760399686; c=relaxed/simple;
	bh=wt8ABhQBNkuDTssrmADKWdmhe2+xsFwQvydnfFEZuw4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qvhWSVgFNJnlhWwWMJntQ41cok2NilveoQeLexkAimAJVy2Np8CDWsZHHr2xs7LT4KtKzg1imKpKws+H6hsu7gE5nGf4nKKwj1VsBHi+ZXAR4htPE3Bb2SMLhtWfRZIWvQ6PWtRvMr+YZ4g3GsT7OUaZQW+z/bcSAx8MRlCdPQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lZOCtGcb; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-27eca7298d9so222922655ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 16:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760399684; x=1761004484; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5eSzM1BbjacPfILv0jrYJHzJQhHV06H7cFKDBkrRkvg=;
        b=lZOCtGcb+hFCxLPKlNasSR1pn8YsATj2jdsl0LhBLh3LnYOCP41DQM/t1xjRbeKyO2
         GlhY3SCDfKje92lP6UIE1rZRdgru4y52z16sh0gsHa5PR72irecohXObMtBPnFk3xA3W
         gGj9amIh/53e2IkSdkTWcjkHm7AtsC7HXhuT2cQXJm7f1uyDUkLxaA33Y8dqg/kMaeer
         njIhfVS46t7COelKYPcpN5sLtBLRrKmRuREM3BJq76QjPaaD/nJqE8+iw6kzm5pw82M0
         dZJduz3JZBnt8pbDvRw187tsjcRkbHJj8ma3bjWEv7VYC1/sXQqMgT3wq4l9giTmbnvw
         Fudw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760399684; x=1761004484;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5eSzM1BbjacPfILv0jrYJHzJQhHV06H7cFKDBkrRkvg=;
        b=DxA8unQZmoOUMQstFucvG50Hp5VCGys/sNcLi4QZNlPya6ud5Fse05j4cn2g6iMhKq
         9SqQdWYT0ESSKfhkXeqa3fSDPaFiZnJWQb8PsAV2fwQq/N9do2jLZXFjxcYDKma7W4ou
         hj9btjx8PFgV1Ef7r2cPEXcJXFSvpgB678GDgEGc7ILXromZ42495hymYtrJu2QecDHV
         EpK8achxQRklFtUSBMIjXu8w2mYRTrAc+vWUf8KP/88obJ2a+cd7MhcSwrpBFATwmtrb
         IZbkKHKYgXO/Tvs7nl/8D8Tgh4F38StvAZHXUl8RgvgQViqc9cCwUGM7v0PZHrLR58C/
         83+w==
X-Forwarded-Encrypted: i=1; AJvYcCWGt49i/4xZ8q/L7blinWD7MSyKAXDRyjFsT8naC9S/Aid4I9H5NRc3yKsW5AYXabyJzz/mYp4ldDQP7kE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUmIZQiBFzsqE473oa3UprQ2ynaOYRKmwWAqEyYIBFWDhMWA8O
	Y62TQ/01VitoNO/Lth4xN0PJ8Dh4vlE9ioccClopooi6xmEteGix6LW1+e6u69OXkQWH4/QyWqn
	2bt7KXg==
X-Google-Smtp-Source: AGHT+IFG+BjAtYLOX1KiZpqF3jGYRoMOZPFJ6jl35/04RXhu8tJ/N/pUxAQejmx4mm6AggTYbzBFwK4lnFo=
X-Received: from plsd3.prod.google.com ([2002:a17:902:b703:b0:27d:6f45:42ec])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:246:b0:24c:9309:5883
 with SMTP id d9443c01a7336-290273ecb35mr293031675ad.28.1760399683860; Mon, 13
 Oct 2025 16:54:43 -0700 (PDT)
Date: Mon, 13 Oct 2025 16:54:42 -0700
In-Reply-To: <d75130b0a0fb9602fa8712a620cb1f7e52606ea4.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251010220403.987927-1-seanjc@google.com> <20251010220403.987927-3-seanjc@google.com>
 <d75130b0a0fb9602fa8712a620cb1f7e52606ea4.camel@intel.com>
Message-ID: <aO2RQu-xuSC0GGnn@google.com>
Subject: Re: [RFC PATCH 2/4] KVM: x86: Extract VMXON and EFER.SVME enablement
 to kernel
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: "x86@kernel.org" <x86@kernel.org>, "kas@kernel.org" <kas@kernel.org>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "mingo@redhat.com" <mingo@redhat.com>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "bp@alien8.de" <bp@alien8.de>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, Chao Gao <chao.gao@intel.com>, 
	Kai Huang <kai.huang@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dan J Williams <dan.j.williams@intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "xin@zytor.com" <xin@zytor.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Oct 13, 2025, Rick P Edgecombe wrote:
> On Fri, 2025-10-10 at 15:04 -0700, Sean Christopherson wrote:
> 
> > +
> > +int x86_virt_get_cpu(int feat)
> > +{
> > +	int r;
> > +
> > +	if (!x86_virt_initialized)
> > +		return -EOPNOTSUPP;
> > +
> > +	if (this_cpu_inc_return(virtualization_nr_users) > 1)
> > +		return 0;
> > +
> > +	if (x86_virt_is_vmx() && feat == X86_FEATURE_VMX)
> > +		r = x86_vmx_get_cpu();
> > +	else if (x86_virt_is_svm() && feat == X86_FEATURE_SVM)
> > +		r = x86_svm_get_cpu();
> > +	else
> > +		r = -EOPNOTSUPP;
> > +
> > +	if (r)
> > +		WARN_ON_ONCE(this_cpu_dec_return(virtualization_nr_users));
> > +
> > +	return r;
> > +}
> > +EXPORT_SYMBOL_GPL(x86_virt_get_cpu);
> 
> Not sure if I missed some previous discussion or future plans, but doing this
> via X86_FEATURE_FOO seems excessive. We could just have x86_virt_get_cpu(void)
> afaict? Curious if there is a plan for other things to go here?

I want to avoid potential problems due to kvm-amd.ko doing x86_virt_get_cpu() and
succeeding on an Intel CPU, and vice versa.  The obvious alternative would be to
have wrappers for VMX and SVM and then do whatever internally, but we'd need some
form of tracking internally no matter what, and I prefer X86_FEATURE_{SVM,VMX}
over one or more booleans.

FWIW, after Chao's feedback, this is what I have locally (a little less foo),
where x86_virt_feature is set during x86_virt_init().

int x86_virt_get_cpu(int feat)
{
	int r;

	if (!x86_virt_feature || x86_virt_feature != feat)
		return -EOPNOTSUPP;

	if (this_cpu_inc_return(virtualization_nr_users) > 1)
		return 0;

	r = x86_virt_call(get_cpu);
	if (r)
		WARN_ON_ONCE(this_cpu_dec_return(virtualization_nr_users));

	return r;
}
EXPORT_SYMBOL_GPL(x86_virt_get_cpu);


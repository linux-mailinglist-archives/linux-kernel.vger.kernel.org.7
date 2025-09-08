Return-Path: <linux-kernel+bounces-805696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC65B48C66
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 748D5189F839
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84DA2EDD64;
	Mon,  8 Sep 2025 11:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cWO/sbEj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4B620C038
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 11:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757331757; cv=none; b=JGT//rR6xqTKs8EG8RHVEXs//mE7yqp9yhXdnUt4HW6+cFq6EF/c+QTHv5SQLMfqQhALArui2e7V528wgzGmwlCQOhCpg9EGeVyBvPQcpiNQG2B2B62abjJci8jtLpDHfZr747qqlh3wCUMEYRMKoZ46LUZdZF+CKPg6/OD62kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757331757; c=relaxed/simple;
	bh=HhSJYCCfbK3ztTJo75ERHVNJWoBVLjkd+Z+wB75j1Ns=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WEiWdwBeF5t0ihlILH9u6QFmn2Yfk4lzAO3YP0kaT2AhxBgn5NMq/9LuD2jOiDIKtz60/t+pVHFJUZwJ/KRUZL3wz3wNhjXTbf7sbusxxE0qFU13OixXLM5cKBMeLAvZklftJ5v+vbF20RJvC+nY4omu7f0eiuoN9juWlLYsPOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cWO/sbEj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757331754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ui+E3yAQjYMbX0VewGqiiUymsURsQ5gb2Eg1Kh6Fyxc=;
	b=cWO/sbEjmBNbx9pV5BgP+Jt6aCYwJQukepSX4X9RO/4/lvh/HUIHXeYscLBKKfm4pdreCk
	/n3a8y2Q0EgFmXtfsz3tO6YfDyk9joDtWXWLogaT3B1ccd7C8GiPZWmAzmVU1LJbzBY2M6
	StE9+7bpAQasnB1X/qu5owQxYKJvzG0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-_t1qguniMM-9JUPJ9U8ouQ-1; Mon, 08 Sep 2025 07:42:32 -0400
X-MC-Unique: _t1qguniMM-9JUPJ9U8ouQ-1
X-Mimecast-MFC-AGG-ID: _t1qguniMM-9JUPJ9U8ouQ_1757331752
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3e067ef24aaso2135378f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 04:42:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757331752; x=1757936552;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ui+E3yAQjYMbX0VewGqiiUymsURsQ5gb2Eg1Kh6Fyxc=;
        b=tf8Q5DPZ8tZI6uyIkkcOVBCf/THFTEiY/4LVwFzrKD9sWARIa1Ga6dU1TM5aJMgRsd
         YQmj0Fz96Od7A6gnUhg7ByhTlX9nEwmX8EmXXwdhny2rOfaJdv2sDx8K2zUJ7bk0H3mt
         MmCZeeLJtmRAbuRO11csuUhEYBE/RkyYsc1h/WgHbHPTtQ2nsKVqGh8FJ8bc82ZIwyGl
         7QEygCLY632iXNzbwxYjFlZUBLAX5C9SQL1b4lwe7BfuBYo1S3s49LMnnyff/uYai3pC
         I8wnw5Hf1cGAtBsPVvsfecQf0MAbJG+g01M6rmxymTVws6DzLcBl/ICvW7J7CbQL4Wyx
         tnuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzQnZNSvW5epxylP+65nkrUPMu1SD1QpkLila1LmHNMMOaRvLUxWURigwrMMoezeq2UCQsms0svdHhcTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRo8Zed8BvuvDDRpL3i8ST3SUYqtAf74XlEqR5o4X3iR4bUB2+
	iDufC5DdUD5E3z4LiqOl5A8xtv1BQbcycmHvVGRpg53gtT8zYTRVWOoRkgodtDQPFv2b8DXzhEs
	bl2iBe8dbS/k3fvcbP6EbI9VmF+rf6rgiO48aiexR63ZfjHCR89CtKP5kSmjI6ZzMyQ==
X-Gm-Gg: ASbGnctt8XgrCl7XGM40OhgFpXKbumtOE1xh69kKeJE4YWMW0wOS3N6tAj2LghG8Z8u
	jbAa0Y5CgD8HgojEN85wNqpiofYTqZr9yqnPZxmM9hfkbdoU0KoM1AvNX6O6kjClroRQ8xcThtT
	G5j/X5G3FI9mRiVHAymavTvWO/8incdVwjcU2Iv0wkfKN9hOLVT4gvJBj4wjiFiyOHG1dPIK5iJ
	23DkObW2lO2tEvL82EjAUOobUFlItyaVh7Yw5tewYNfvfEHnVdF5QkquCxXXP6+U8sQ4JLKJaLS
	iNyUiRMHKfp1NeIfjls/bvEJJ2gdRZGAe6w=
X-Received: by 2002:a05:6000:2306:b0:3e7:441e:ca1a with SMTP id ffacd0b85a97d-3e7441ecd94mr3850947f8f.34.1757331751647;
        Mon, 08 Sep 2025 04:42:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFNduNNMS2QypUGoHefwq2OBmU/qLWwtZfbpj/N0PFIGWheTE/CPUM6x/z4wzHmYCkGM6cZg==
X-Received: by 2002:a05:6000:2306:b0:3e7:441e:ca1a with SMTP id ffacd0b85a97d-3e7441ecd94mr3850915f8f.34.1757331751243;
        Mon, 08 Sep 2025 04:42:31 -0700 (PDT)
Received: from fedora (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e705508e22sm8404675f8f.49.2025.09.08.04.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 04:42:30 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Khushit Shah <khushit.shah@nutanix.com>
Cc: "seanjc@google.com" <seanjc@google.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shaju
 Abraham <shaju.abraham@nutanix.com>
Subject: Re: [BUG] [KVM/VMX] Level triggered interrupts mishandled on
 Windows w/ nested virt(Credential Guard) when using split irqchip
In-Reply-To: <D373804C-B758-48F9-8178-393034AF12DD@nutanix.com>
References: <7D497EF1-607D-4D37-98E7-DAF95F099342@nutanix.com>
 <87a535fh5g.fsf@redhat.com>
 <D373804C-B758-48F9-8178-393034AF12DD@nutanix.com>
Date: Mon, 08 Sep 2025 14:42:29 +0300
Message-ID: <87wm69dvbu.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Khushit Shah <khushit.shah@nutanix.com> writes:

> Thanks you for the comments Vitaly!
>
>> On 8 Sep 2025, at 2:35 PM, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>> 
>> Is there a specific reason to not enable any Hyper-V enlightenments for
>> your guest? For nested cases, features like Enightended VMCS
>> ('hv-evmcs'), 'hv-vapic', 'hv-apicv', ... can change Windows's behavior
>> a lot. I'd even suggest you start with 'hv-passthrough' to see if the
>> slowness goes away and if yes, then try to find the required set of
>> options you can use in your setup.
>
>
> Actually in production we use an extensive set of cpu features exposed to the guest, still the issue persists, 
> With the following hv-* options also the issue is present:
>        hypervisor=on,hv-time=on,hv-relaxed=on,hv-vapic=on,hv-spinlocks=0x2000,hv-vpindex=on,hv-runtime=on,hv-synic=on, 
>        hv-stimer=on,hv-tlbflush=on,hv-ipi=on,hv-evmcs=on
>

Try adding 'hv-apicv' (AKA 'hv-avic') to the list too (not to be
confused with 'hv-vapic').

>> 
>> On 8 Sep 2025, at 2:35 PM, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>> 
>> Single CPU Windows guests are always very slow, doubly so when running nested.
>
> The bug was reproducible even with more cpus like (4,8), we use 1 to reduce noise in captured logs.
>
> I should also mention by slow boot we mean extremely slow (>3h).

Oh, this is next level) Do you know if the issue reproduces with newer
Windows, e.g. 2025?

Also, I've just recalled I fixed (well, 'workarounded') an issue similar
to yours a while ago in QEMU:

commit 958a01dab8e02fc49f4fd619fad8c82a1108afdb
Author: Vitaly Kuznetsov <vkuznets@redhat.com>
Date:   Tue Apr 2 10:02:15 2019 +0200

    ioapic: allow buggy guests mishandling level-triggered interrupts to make progress

maybe something has changed and it doesn't work anymore?

-- 
Vitaly



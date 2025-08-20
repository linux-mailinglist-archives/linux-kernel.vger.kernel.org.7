Return-Path: <linux-kernel+bounces-778511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07943B2E6AF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 22:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0221B1BA7DF7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 20:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AE42D249C;
	Wed, 20 Aug 2025 20:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HOYW/VT7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F1728C01E
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 20:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755722121; cv=none; b=ZwerjvFBsnd5wiOLa4WKgRPpFoBF6/K3+dPQd8FsxlBPCAHIm4JSrdLErohxd4N9APS45zgAFU/YjBD1fvkJvTjVOO8cmgxVMJOFUOHvqv+pweGvKzQXQ/27Buc51I/LxdsVkZpcAx2YCqudHZ4/zTs4s99WdLkl86Al8+LiU24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755722121; c=relaxed/simple;
	bh=LodTljcOT4TtQyHZQayMErRhCN0BNUnXKtuy8bDOLxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ph52UR+Y+dkxJVvMhFK7eSu2Sf/hB9pnpLGRQ7umHxiYRpIMiNxvWeNVO5lEnfREKE4MGtZ8ZygmPiwCzaUswoyBETYD4kQ3EdWFibXUry6Sjz7cvRmiIBTTmMyzzVca64IKEHFawDUno4GR1JoIOqVJFxS41sjaq4u//VO5uak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HOYW/VT7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755722118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UMWKewj4duOHzGzgzfLMgmgz8uOtIqtx/lOuEzQJpoA=;
	b=HOYW/VT7FDult6HIoUEpd5NFGwmqTzZb4TzKsAAhwsslowxKe64r5miuLGvfvgBrC6Wsdl
	rmigDqgmMGXu7mQ3fmI4hIfXThbUCo93LuDgau1pkygYVD7vEBAqUqONge85+xZPkg/lAz
	QWlKHO4iR5/OFzpdpq24oWqlazkW3/c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-b380v-OcPrKYXiWGrspybw-1; Wed, 20 Aug 2025 16:35:17 -0400
X-MC-Unique: b380v-OcPrKYXiWGrspybw-1
X-Mimecast-MFC-AGG-ID: b380v-OcPrKYXiWGrspybw_1755722116
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45a1b0511b3so1175745e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 13:35:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755722116; x=1756326916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UMWKewj4duOHzGzgzfLMgmgz8uOtIqtx/lOuEzQJpoA=;
        b=MvYZd0pzFHPdi7Rx/jUDGfxuqQCq9cjBzsOdsl9hXNQ4Dr6D1STYCFYNebK+n9eb7U
         x+5n2IgLQaxVQBBBqAwOP/ofWYdhtp7ltGVT+EH2iUhN4Whgklw1Hw1+msvcZ7NQhXne
         3jyPzFvKcv2VC8JWV8wihLCjlFFDAL949RQ0Xde2o4it0E71JcZugcIaui4uLucFH7vT
         3XOMWeVkvlTmqFhl6dBNlOdLWM/35Fzty0+st+fTtqbp6qvjMTb9GmY7xooFt/Iwy/Kn
         7+nzmnEjUjX8nASHhrLl4jE5Gq+36Aqd1ovQ9xszpQhz0a3Tys8p9iefEamlhPyvRC0x
         6Xjg==
X-Forwarded-Encrypted: i=1; AJvYcCXVI6wsb0+hH2B8J0H2diyLZZ2MgLLIViHdxmmPrTap2Rqf3gsqsFr/XxrBR+sgCfU7pLkYFTrxXQWKAJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpLR+Ih/N16XTcdJvhhUstqrngkRmQbZjzixJk39h9NJ2lH2fS
	Hce0wBAQjEMKCQQVk6x3SZoU1YfYn7Gv3EdEqBlbBfqgtN/pCb9AtefJhVncxQhwQYdJS3bzQZS
	Y6ixg+OhxmvtD+7uUsWpyNvsuSyShhY5dsK33zKzXdv/Z37BebmtT82P6AWk4CdGeY2BQ3y+l1j
	UXHv/Imsgk4RmkwqjZXlaYGDXbuhmo/7IAdgvBDIwc
X-Gm-Gg: ASbGncu1th2OKo3OSe6ZMPaQTtWmESKm5ig1oWMN5yZ8LqMTG5ZD45dCRWCM51n5GRh
	2UiLXXUuK0FCMZ2xwJZDoEI4UARdtf0KDAR6U0ms5rgWcGRN42Qk54jHk7uXgS5fneLJQvmWieM
	433vF6m6uBxiymJ+r8h8BF
X-Received: by 2002:a05:600c:1d02:b0:459:dde3:1a27 with SMTP id 5b1f17b1804b1-45b4b1b241cmr22863175e9.26.1755722116014;
        Wed, 20 Aug 2025 13:35:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxqwftEk4d/K5bkEpCemFoAFNzyVAoqbJChQUtSpEyzBd2+oLjDWI0gD0WL9bn0I9aeBcUFnrSa6uO3vk0VRU=
X-Received: by 2002:a05:600c:1d02:b0:459:dde3:1a27 with SMTP id
 5b1f17b1804b1-45b4b1b241cmr22863005e9.26.1755722115624; Wed, 20 Aug 2025
 13:35:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755126788.git.kai.huang@intel.com> <d8993692714829a2b1671412cdd684781c43d54a.1755126788.git.kai.huang@intel.com>
 <aJ3qhtzwHIRPrLK7@google.com> <ebd8132d5c0d4b1994802028a2bef01bd45e62a2.camel@intel.com>
 <aJ4kWcuyNIpCnaXE@google.com> <d2e33db367b503dde2f342de3cedb3b8fa29cc42.camel@intel.com>
 <aJ5vz33PCCqtScJa@google.com> <f5101cfa773a5dd89dd40ff9023024f4782b8123.camel@intel.com>
 <acbcfc16-6ccc-4aa8-8975-b33caf36b65f@redhat.com> <a418f9758b5817c70f7345c59111b9e78c0deede.camel@intel.com>
 <78253405-bff8-476c-a505-3737a499151b@redhat.com> <c736d2040f5452585e670819621d3bae5417fff4.camel@intel.com>
In-Reply-To: <c736d2040f5452585e670819621d3bae5417fff4.camel@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Aug 2025 22:35:03 +0200
X-Gm-Features: Ac12FXxuQq7r6E4xywLacS3G_lJsfME8QDJWxY-7HHfw9DS68TGdJOjSXEJIBew
Message-ID: <CABgObfZSKoT5xLm9XUR9wweU2MgXj4xww1irL8KZRBUze3vDFw@mail.gmail.com>
Subject: Re: [PATCH v6 7/7] KVM: TDX: Explicitly do WBINVD when no more TDX SEAMCALLs
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "seanjc@google.com" <seanjc@google.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"ashish.kalra@amd.com" <ashish.kalra@amd.com>, "Hansen, Dave" <dave.hansen@intel.com>, 
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "kas@kernel.org" <kas@kernel.org>, 
	"Chatre, Reinette" <reinette.chatre@intel.com>, "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, 
	"Yamahata, Isaku" <isaku.yamahata@intel.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "hpa@zytor.com" <hpa@zytor.com>, 
	"peterz@infradead.org" <peterz@infradead.org>, "sagis@google.com" <sagis@google.com>, 
	"Chen, Farrah" <farrah.chen@intel.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, 
	"bp@alien8.de" <bp@alien8.de>, "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, 
	"Gao, Chao" <chao.gao@intel.com>, "Williams, Dan J" <dan.j.williams@intel.com>, 
	"x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 1:22=E2=80=AFPM Huang, Kai <kai.huang@intel.com> wr=
ote:
> I think one minor issue here is, when CONFIG_INTEL_TDX_HOST is off but
> CONFIG_KEXEC_CORE is on, there will be no implementation of
> tdx_cpu_flush_cache_for_kexec().  This won't result in build error,
> though, because when TDX_HOST is off, KVM_INTEL_TDX will be off too, i.e.=
,
> there won't be any caller of tdx_cpu_flush_cache_for_kexec().
>
> But this still doesn't look nice?

Why do you need one? It's called tdx_cpu_flush_cache_for_kexec(), you
don't need it if TDX is disabled.

> Btw, the above will provide the stub function when both KEXEC_CORE and
> TDX_HOST is off, which seems to be a step back too?

Let's just stop here. Are we really wasting this much time discussing
like 30 characters and 0 bytes of object code?

> To me, it's more straightforward to just rename it to
> tdx_cpu_flush_cache_for_kexec() and remove the stub:

Sure, just rename the function and let's call it a day. If it was me,
v6 was good enough.

Paolo



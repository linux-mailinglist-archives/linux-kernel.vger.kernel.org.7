Return-Path: <linux-kernel+bounces-790410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADE4B3A6BD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 18:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B95AE3A96D0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 16:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD3A32A3CF;
	Thu, 28 Aug 2025 16:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J1d5MnBF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8255A32A3D9
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 16:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756399476; cv=none; b=NlQXOYOS/3z8rihBhc3PIrQm+stJMTDCzxEveXrmjJ3Zs1sIH1Lwe85xDpTMQ/K4Lpda4qAa+6wgasI1g0KprdFA1R1hRRnfhd0TZaeW50pITsGGtuEf6NM3mSK0v7Ohy8OvqtkLrrU1/ouyF46BvTl4yIRiEcBuBLPXJmZ9kJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756399476; c=relaxed/simple;
	bh=16g9F5woniiXrhsLLuxG1053++5xXv7LjCWoyLqXmvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DUscNKMF37iYn3t4vBFX92pIQhQEEnjFLk9It3lYyjRIvpEnQbY48DeKQ8hT+0S0YGtPCa8025TovBdd7ffOYyX2LPvwGIzz0yxWJw7s7F9pT12mvBFZ4wsc7GmR1p0CKCakRCZ/4eHxTtPGPZdqcZa3W6ODXXNuZ6Tf9mh+TLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J1d5MnBF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756399473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=16g9F5woniiXrhsLLuxG1053++5xXv7LjCWoyLqXmvA=;
	b=J1d5MnBFDJMwq2tBjjJyR7sKyY9Nzy9d8T91zDBH/irkmCetXUfNzZJamBQtq/kIhG/6U5
	/6AaDJQbvxDJvMZD4MqkHP83jQ4bVseHnY2BziiZ3F0GjELNFBOtsYUhQwQYJcVNfb1fjb
	+HbHXY/QElOG13SRnKGMPxIFA5FelLk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-lT3drFKWMKukor-KBwuChg-1; Thu, 28 Aug 2025 12:44:31 -0400
X-MC-Unique: lT3drFKWMKukor-KBwuChg-1
X-Mimecast-MFC-AGG-ID: lT3drFKWMKukor-KBwuChg_1756399470
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45a1b10418aso6942355e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 09:44:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756399470; x=1757004270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=16g9F5woniiXrhsLLuxG1053++5xXv7LjCWoyLqXmvA=;
        b=IqfftGwBZj5ZEGCdc2Uh4LBhU5MNe7YA2bLpo2XwKNyQZ5pZPtWx9C6vyHwHgimHtU
         MTTtEZgsxuRTAhFH2nRssLp8ET/OguHpOvzoa2Z6mBi7sO88aaM3Fb8dwlZu1CCzuae8
         JBcMs8v2XdX7ona0PwqwECrueN/WuV74Mr70fMI2n32hG9zoHg4QQSia+/Dv964Z+0Jy
         RxXs0ZxIvVRC7VzTvsPqGYNEhaoSi0YLeyeft2ukjMQ7KFOMLZ5aotr+QSmvePcv9g9S
         14+DSBPxPyOEM/RHECVgPX4yiFUelONcnvURE1a+i9AP5giAJwIcbP4CxEU6lBjxur/s
         ozOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwj47xklSHPGcq/A4rIGxslBGiSLMgZH22a1bI1lKJ0gabMEdPrLcmFM/+BFU8c8ZB3VT3PY+f8lmifk4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2/OabhHH/62On2uDmlu2ghoKUzZgHbke3OxTLLvz6hixppAd5
	FCdq+cF1Hs8xntOeatBWommCG43OmDXlTecS1i+Dc+IEbm+My2P0Rg9LFJkoB7tM66n+ths9g0c
	f0ryBb5Eu0uA0wkbOY39l81yLsXnerCS7P6dzN/ZujXbJydwaDGrBrm8Etp1j+2qUA8jCd3cwn/
	nnhC99JuQjoRUOFKBTOlwpyhJBZVECHDzgy3vGeWjG
X-Gm-Gg: ASbGncs3s4/yLrsLNdBhO9VxI6SxSW/Whs9NOXNLpOCwvI9iqUucioWVSyMeMfp1tch
	oa9aRjgCMDwfAVFnc2x634fKpjeNSwQyfBNAxL9KjbncXYUkW6Fa6AYo3fjfsBBM2O3P779gvPv
	XSKy9hVTtk3zn3LWPe+Ibah3JijCCxFbQccQIS6SUaGCvjrW6Ncoly6hA4HIc9R9G14Qbw6rLIC
	ZP0Bgzhmx61/iypTIYwuuq6
X-Received: by 2002:a05:600c:4715:b0:456:302:6dc3 with SMTP id 5b1f17b1804b1-45b517d4c47mr197984335e9.26.1756399470545;
        Thu, 28 Aug 2025 09:44:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOQ697WbVXyU99n0waspLzqYpTQQBImj5MyrGfz7lwIURmhpghnGB5Sbe7cWt+MuicJOIRjj3b26keLzpmBNo=
X-Received: by 2002:a05:600c:4715:b0:456:302:6dc3 with SMTP id
 5b1f17b1804b1-45b517d4c47mr197983995e9.26.1756399470139; Thu, 28 Aug 2025
 09:44:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827152754.12481-1-lifei.shirley@bytedance.com>
 <aK8r11trXDjBnRON@google.com> <CABgObfYqVTK3uB00pAyZAdX=Vx1Xx_M0MOwUzm+D1C04mrVfig@mail.gmail.com>
 <f904b674-98ba-4e13-a64c-fd30b6ac4a2e@bytedance.com>
In-Reply-To: <f904b674-98ba-4e13-a64c-fd30b6ac4a2e@bytedance.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 Aug 2025 18:44:18 +0200
X-Gm-Features: Ac12FXxy8RFR1sySn2cIpHgzn1YV9jdcFkuTVaa1o9x9iu2acXvfPgiJQStuG6A
Message-ID: <CABgObfb4ocYcaZixoPD_VZL5Z_SieTGJW3GBCFB-_LuOH5Ut2g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] KVM: x86: Latch INITs only in specific CPU
 states in KVM_SET_VCPU_EVENTS
To: Fei Li <lifei.shirley@bytedance.com>
Cc: Sean Christopherson <seanjc@google.com>, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, liran.alon@oracle.com, hpa@zytor.com, 
	wanpeng.li@hotmail.com, kvm@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 5:13=E2=80=AFPM Fei Li <lifei.shirley@bytedance.com=
> wrote:
> Actually this is a bug triggered by one monitor tool in our production
> environment. This monitor executes 'info registers -a' hmp at a fixed
> frequency, even during VM startup process, which makes some AP stay in
> KVM_MP_STATE_UNINITIALIZED forever. But this race only occurs with
> extremely low probability, about 1~2 VM hangs per week.
>
> Considering other emulators, like cloud-hypervisor and firecracker maybe
> also have similar potential race issues, I think KVM had better do some
> handling. But anyway, I will check Qemu code to avoid such race. Thanks
> for both of your comments. =F0=9F=99=82

If you can check whether other emulators invoke KVM_SET_VCPU_EVENTS in
similar cases, that of course would help understanding the situation
better.

In QEMU, it is possible to delay KVM_GET_VCPU_EVENTS until after all
vCPUs have halted.

Paolo



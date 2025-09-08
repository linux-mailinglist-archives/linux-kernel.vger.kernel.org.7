Return-Path: <linux-kernel+bounces-805377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCA9B487C3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98AAA7AC6EC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92582EE5F4;
	Mon,  8 Sep 2025 09:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SlvDRGb9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44722E4258
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 09:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757322356; cv=none; b=m/H3fTexkrh6dPM5JS8psNyto42EFi9T6zOsbM8CVuHjhuHZYISRD/K6nXlrwXze6auu8iFTbkFfbtxQRKsamxpMWse4hcJL29azeHeoqKjU48jNFx/MZuJv79fPaBSHDXMtb2mINTw+pMfMU+xU2rnVM3Z13hdzWkwG2V6QjeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757322356; c=relaxed/simple;
	bh=P7ve4bSvP7D//DVLn8z2qtyy/eqBVe8bFLdQw6y81a0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UvaEgMWGcroWJTLOofUGV/L5F70vzCZ7g4T2oWu/cCqmkvCQNDv3kdjofD81QKXkNfe8+aP3v2JHN4gi6HxRohwHyJsomCJ6pnYLvdpLnrcqhBxM0Bve5uF1IC2iIT0eO50FXkm0E27hWv2awzQ6urJHXO0o7bELuTrVNAe1F5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SlvDRGb9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757322352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CCKOAqyJnX/UJPJicswImDhbccEcHQgSYKYFWGw4a9k=;
	b=SlvDRGb9qdmd7lGFoXWPnacWIn8v/mi/uhfEbb8WNpBC7M6EV5zYG6opEzfnd1cD8azLVZ
	LL6W3Uep4ot+pBoxtd1WBVMCUSVPAQVn3K0+I/bumIrcZnXPUWQ1SU1VsmQWFeZc3dMhrT
	jdOgK55+K7zvmZwFnm6NUZSkNXNoMaI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-4UGNe8slO6KP5YMCGiUEfw-1; Mon, 08 Sep 2025 05:05:50 -0400
X-MC-Unique: 4UGNe8slO6KP5YMCGiUEfw-1
X-Mimecast-MFC-AGG-ID: 4UGNe8slO6KP5YMCGiUEfw_1757322349
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3e26569a11aso1994343f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 02:05:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757322349; x=1757927149;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CCKOAqyJnX/UJPJicswImDhbccEcHQgSYKYFWGw4a9k=;
        b=YXt6ovIKW7Vn3IeXJ7nHnQNle1mi/kgX+nIrjw7b8+oyveA43rW05qpbVAYTjGZfhw
         TkxA63GzO/MJXuDUxLgwmBgYOWvSduPDiLhO0r+Wr8649tIeOhlVOmzMh0g19OTsgMFA
         3oz3ZwssuhxKQ/JuCg1iVCZKflbcfTW3sft1xR/wjabQSG4pgwKg333C9iT2ewKfvmCr
         FLZUL+K4JRM+KVnIIx7WQOOiAnfi/NUk2pHKF02Uuc+PFMvOGMeHCWNsNEBy7F8Jkf5j
         VwpPh3j48S0bHLYkEXapUbuHOFwNgGmBPyC8pKzWJrZu+DNSTG9DqEGNu2IgRgO2tDa4
         izPw==
X-Forwarded-Encrypted: i=1; AJvYcCUWLicOzJ8zWffMezWCfzj1HeP7WXqw7UaiVdzGcy/n3tjo+bQKpc098gIVAWZRJzvXzCphv1UUvOA9f7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKf+fKb/hqZ8wBBw3yLvkFA4w01ciV4O8UJocH3ThJ4+cphPBN
	4+7y2ckycNruC6FA8FmzydL0rChZ7hyeTaS015H8OmyM6txpEcQK4VIWTADEGmSlB6Lnm1eADUE
	NGQ0JZHKUqYfhUBpEEz1soXj+sRf3jRIDJ0i9L6dGQp7Wc+b7xplmK/0PF5AL8t3EFQ==
X-Gm-Gg: ASbGncujw+0+yT89o0IJ0bWJPF0ad+dKcGMo4F3WakDjSF9309Krjrr/pV318bBKOfx
	XteMYfBMgdR9NzfPyuACyYhAKDVEml6v/u5tp0eNT3A9+dDEXS2bmJSQYL+Nijm6QQl1lovrPK4
	tL/pPabykRo2OtcLDUJvVaMc7UvI2ds3biZnnN8OcA2Md+3UpfNB6t+a0NeaPb0QEI/bLUapo5j
	HoT65q6tMrJ9xYgsyub93ducfOsjBn0y+dEE2KR6vCFJdOQPVrfjOS+JNk0/FJkdX2Xh+lXAL6F
	hHsT2iGVp/soq/1U4o4eTGXag0mFtz09QMY=
X-Received: by 2002:a05:6000:2909:b0:3e7:44f9:131f with SMTP id ffacd0b85a97d-3e744f91924mr3349913f8f.1.1757322349193;
        Mon, 08 Sep 2025 02:05:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAtDjoTu66KftpdkoNBJ3Mi4sooxHp7L/u6879vG7/2W23K/UfayFxyfeL/kY+x1C2acs1Kg==
X-Received: by 2002:a05:6000:2909:b0:3e7:44f9:131f with SMTP id ffacd0b85a97d-3e744f91924mr3349885f8f.1.1757322348768;
        Mon, 08 Sep 2025 02:05:48 -0700 (PDT)
Received: from fedora (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3db9b973869sm22277715f8f.18.2025.09.08.02.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 02:05:48 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Khushit Shah <khushit.shah@nutanix.com>
Cc: "seanjc@google.com" <seanjc@google.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>,"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shaju
 Abraham <shaju.abraham@nutanix.com>
Subject: Re: [BUG] [KVM/VMX] Level triggered interrupts mishandled on
 Windows w/ nested virt(Credential Guard) when using split irqchip
In-Reply-To: <7D497EF1-607D-4D37-98E7-DAF95F099342@nutanix.com>
References: <7D497EF1-607D-4D37-98E7-DAF95F099342@nutanix.com>
Date: Mon, 08 Sep 2025 12:05:47 +0300
Message-ID: <87a535fh5g.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Khushit Shah <khushit.shah@nutanix.com> writes:

[trimmed 'Cc' list a bit]

> [1.] One line summary:
> [KVM/VMX] Level triggered interrupts mishandled on Windows w/ nested virt(Credential Guard) when using split irqchip
>
> [2.]  Problem/Report:
> When running Windows with Credential Guard enabled and with split-irqchip, level triggered interrupts are not properly forwarded to L2 (Credential Guard) by L1 (Windows), instead L1 EOIs the interrupt. Which leads to extremely slow Windows boot time. This issue is only seen on Intel + split-irqchip. Intel + kernel-irqchip, AMD + (kernel/split)-irqchip works fine. 
>
> Qemu command used to create the vm:
> /usr/libexec/qemu-kvm \
>   -machine q35,accel=kvm,smm=on,usb=off,acpi=on,kernel-irqchip=split \
>   -cpu host,+vmx,+invpcid,+ssse3,+aes,+xsave,+xsaveopt,+xgetbv1,+xsaves,+rdtscp,+tsc-deadline \

Is there a specific reason to not enable any Hyper-V enlightenments for
your guest? For nested cases, features like Enightended VMCS
('hv-evmcs'), 'hv-vapic', 'hv-apicv', ... can change Windows's behavior
a lot. I'd even suggest you start with 'hv-passthrough' to see if the
slowness goes away and if yes, then try to find the required set of
options you can use in your setup.

>   -m 20G -smp 1 \

Single CPU Windows guests are always very slow, doubly so when running
nested.

...

-- 
Vitaly



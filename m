Return-Path: <linux-kernel+bounces-809739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0A0B51167
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84076486D96
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFC730F801;
	Wed, 10 Sep 2025 08:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DDaixZFO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9948228B501
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 08:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757493254; cv=none; b=RO+h8mMif96VFqvPcnTX24CMftyWjxcf0esBOvlxvjLgRZ/VZeRTGA7Stl9mXLTdLq2izQvQAvLhFcd8IT+UaLFps5X/G2zgR7I29OrNEMN+IIPdgM26aGi6KL7019mng9+8sTj36SuvBxW6qxdqFve//UUZ7rFV036mtGVRChk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757493254; c=relaxed/simple;
	bh=uNe1ei6a9Sb1+j34arhysm88BnViKlUeFkNkrxOClGI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FWMbP3RJaEgHJXChDrz9ENccwUqV0GUK0u0/vxbOqjzKvO9AWeEJK0yMr9GtNDV2QXUCvWpPx5aDBRG07nORuzCbuNwr3FK9Mf/D+3HWS4HHsm2QDFzOj9s/WQ8bqiEv8FHI6URUrLnZSC9PIcphyf0+s2d9SIRy6TPVUVyKbPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DDaixZFO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757493251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Amy5eP+TPpCVu2gnynuIcytRxwDWLIJGmgKp9e+fkkw=;
	b=DDaixZFOuXjGPfrfaRMKb2gh31+asQhrLA7lp/JfdVeoCDunPAJ4J8czuzaxwTj0lIdDRj
	YBkpmd41f700OFQIIQrXwKrLMLdugv8nmtK4gkREQvfVWlHPmZbQb1kSvn1fh7lIE/clhz
	XuzeVGpDxaZNcu/UmYYfP9dKphQA6dQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-Axja5x8PMDaqNS8SA0yf8w-1; Wed, 10 Sep 2025 04:34:10 -0400
X-MC-Unique: Axja5x8PMDaqNS8SA0yf8w-1
X-Mimecast-MFC-AGG-ID: Axja5x8PMDaqNS8SA0yf8w_1757493249
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3e753e78902so853788f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 01:34:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757493249; x=1758098049;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Amy5eP+TPpCVu2gnynuIcytRxwDWLIJGmgKp9e+fkkw=;
        b=bzVvjhdYwHJD6eCVSkyzN+yv/hCEA/7spD2zMlaLnmdX5TWPsNym1fofSgyEynz5fi
         vVgwsbgGxAN9WI9zDa/xKZMsq3S7YWPNElpZWWuzvRJ8f6KfUBGPNddtzwN3S/f2EnIm
         WPRJP1+ZL6Hwb16kylvltXxXXs0EL0P3ycyGhlqRGNdw7MkNAifG4QX5mlSAqFqgAFcO
         cgnX8iJNQJm/DxOgJC7LOUuouDxNbpc9cNCkEYksolJPq3RuNTpO3kHst1cwL8uo+DPq
         VP8hz4ZedtP90gyZWueCrQVaYlH7F2X3fyGtYC1rWekgvLbClsbjM51znSbAntjJNWPX
         VW0A==
X-Forwarded-Encrypted: i=1; AJvYcCXu7OB8lEWUO0YtF6RrjsxD6SnSPCcaFm1UGVoJ1LmBKhEkE4zEJXSpsdB9gDZfZ/mY87JQVSNeM9X8WV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTG1zlbg8jANwHZg0ZlbMYA+BINbehDPy41hM5UNxA6ze1LILA
	isr9tacL0aXZ9k7HG557hVv1+HbxTdvaWp6tgf39wSMNHNktBb4YXzT+3YfXV7Z74E07SdcAuvE
	vQN2o6sV1wE0zl72esR6LV4DLQq5omDUIvDthqv5rOqZZpiqiWKA5HMG3ldoMRZsQ0g==
X-Gm-Gg: ASbGncsZY+8GNIrD8VV5Ig0WuPn20qtxjDvofhn3eGmj3iwkifVr3SJWrMU1Jh/Ih/V
	Sp5g2Ba8UF04xMFmHKbDXowM+CWk97HNzkLIdHvAJPjr19M6Ks9a5w2rBCltGBAuVPpIXWCQWYO
	//RJEXJO4yL/D3jG79Np6shq2fixwvL9EWNbYP4sm4kdYbkAMbgoa1i5vosz9F36Yj7HF5iUyTE
	wOJM41XTkDy5TK3MK2UfVCKTZEi/FW4TI6nSzGKhna3U61J4VwJsXztHK65aPqLpV8ryUlqTM/x
	b92yha+m9yD78mb364twN/7CCBnZZH4TkVA=
X-Received: by 2002:a05:6000:2405:b0:3de:daf2:edca with SMTP id ffacd0b85a97d-3e641e3b009mr11927987f8f.21.1757493248829;
        Wed, 10 Sep 2025 01:34:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEESRtO3VhGKSJcJh71t22NBy80LBauADrI4j1BdKqoBklXHwQ8jjnI6nP/m8EGktQBpwx0Kw==
X-Received: by 2002:a05:6000:2405:b0:3de:daf2:edca with SMTP id ffacd0b85a97d-3e641e3b009mr11927965f8f.21.1757493248419;
        Wed, 10 Sep 2025 01:34:08 -0700 (PDT)
Received: from fedora (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521bf85esm6098839f8f.1.2025.09.10.01.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 01:34:07 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Khushit Shah <khushit.shah@nutanix.com>
Cc: "seanjc@google.com" <seanjc@google.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shaju
 Abraham <shaju.abraham@nutanix.com>
Subject: Re: [BUG] [KVM/VMX] Level triggered interrupts mishandled on
 Windows w/ nested virt(Credential Guard) when using split irqchip
In-Reply-To: <376ABCC7-CF9A-4E29-9CC7-0E3BEE082119@nutanix.com>
References: <7D497EF1-607D-4D37-98E7-DAF95F099342@nutanix.com>
 <87a535fh5g.fsf@redhat.com>
 <D373804C-B758-48F9-8178-393034AF12DD@nutanix.com>
 <87wm69dvbu.fsf@redhat.com>
 <376ABCC7-CF9A-4E29-9CC7-0E3BEE082119@nutanix.com>
Date: Wed, 10 Sep 2025 10:34:07 +0200
Message-ID: <87ms72g0zk.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Khushit Shah <khushit.shah@nutanix.com> writes:

>> On 8 Sep 2025, at 5:12=E2=80=AFPM, Vitaly Kuznetsov <vkuznets@redhat.com=
> wrote:
>>=20

...

>> Also, I've just recalled I fixed (well, 'workarounded') an issue similar
>> to yours a while ago in QEMU:
>>=20
>> commit 958a01dab8e02fc49f4fd619fad8c82a1108afdb
>> Author: Vitaly Kuznetsov <vkuznets@redhat.com>
>> Date:   Tue Apr 2 10:02:15 2019 +0200
>>=20
>>    ioapic: allow buggy guests mishandling level-triggered interrupts to =
make progress
>>=20
>> maybe something has changed and it doesn't work anymore?
>
> This is really interesting, we are facing a very similar issue, but the i=
nterrupt storm only occurs when using split-irqchip.=20
> Using kernel-irqchip, we do not even see consecutive level triggered inte=
rrupts of the same vector. From the logs it is=20
> clear that somehow with kernel-irqchip, L1 passes the interrupt to L2 to =
service, but with split-irqchip, L1 EOI=E2=80=99s without=20
> servicing the interrupt. As it is working properly on kernel-irqchip, we =
can=E2=80=99t really point it as an Hyper-V issue. AFAIK,=20
> kernel-irqchip setting should be transparent to the guest, can you think =
of anything that can change this?

The problem I've fixed back then was also only visible with split
irqchip. The reason was:

"""
in-kernel IOAPIC implementation has commit 184564efae4d ("kvm: ioapic: cond=
itionally delay
irq delivery duringeoi broadcast")
"""

so even though the guest cannot really distinguish between in-kernel and
split irqchips, the small differences in implementation can make a big
difference in the observed behavior. In case we re-assert improperly
handled level-triggered interrupt too fast, the guest is not able to
make much progress but if we let it execute for even the tiniest
fraction of time, then the forward progress happens.=20

I don't exactly know what happens in this particular case but I'd
suggest you try to atrificially delay re-asserting level triggered
interrupts and see what happens.

--=20
Vitaly



Return-Path: <linux-kernel+bounces-763235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C48B21220
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4041B1885684
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F118B2741D1;
	Mon, 11 Aug 2025 16:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xXarj+61"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3A51494C3
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 16:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754929957; cv=none; b=GVpj+x7QEzRvXLxerXLKElmoE1f8XEPy15j1uJd2AqGPwhuFhZ1FJJrMFquNjRl/lXsdJPvcvtEylGyvUucE4qznFBQLGKAdFsfnoyvQYBiwmf6EWoI1jaIb8ZucHIaEE3H6xHfYMTJI7GJFmZhRTbXVuGIBdw3cm0Ui5on85IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754929957; c=relaxed/simple;
	bh=5raDWbiePQn0tje7bhi3tF92rjNg+D7Dv2EAjpEf+mY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h1/mWBL72JYE49/wQaf/SKL/CVM6twpVZsGxZCna5ckmOmZBICahfUbJDkGpwSUQUEgFaOY5oNxzh/mVO18eLrrUv10hcVlRmrL1uvV3DBKjlycD56U6ZOJh5NEPaPP4gjcCT2/UA7U8ZyXo2Oqri49PvBI0UBiJWbk0Fo0f/rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xXarj+61; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31f2a98d91eso4354258a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754929955; x=1755534755; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GceKkPTmMSoOd608Hoj+deNhw1AA/rgSC3HPnAq53ts=;
        b=xXarj+61eJgjWm8/pGcjRrHEKQ6fxL3KobmLlnFahDCrXTmhg0MvZDSU4mOTpGIl9r
         xlkqYNVgbr+JnI7XqTqsv1jp2zOTYp6xUdPACouXaX0eYRahGipZZyD/hEnNnLS1U8ZA
         QVmoSu7UrJlIr+XcU9XT4QNhj8khVeXCY3GRHcEoiVXoX31CJHeqrERY2ABjPCM6/ahr
         eTHqoyxlHn+pEA7KeDD6y69+RstkYcCp8UvPebfQ8J3KarQ1MMvxiTCPR9bA6zrV+21S
         B6BCP8r7t8w9E+w+3evH9/zQDQrPcsuhR7PQyWTF1WlLvLT9E0YFmemMkmjgrjDrzfIw
         vwkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754929955; x=1755534755;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GceKkPTmMSoOd608Hoj+deNhw1AA/rgSC3HPnAq53ts=;
        b=GcTufcPg7U6linrN3nAk3GYrDxXhWhq6NsjSlsacoBoE/v/n/YKh1hoX6ogA0gJiLU
         CEK1nzDcJnl3ypJmpHX5AVNboWDdrwCMQAGRSIZz0G/pSnBGbvXwAnGfZU9IEbAhr/I3
         x0WkkDl4EbUACySTrJH9I2F2boQvNWzHJ9+1wkw2gRVdcvlSKO/xHfFrleo2TJWKYNjc
         qeTYKEi9SdYxXCLsZr3cUR/coWbFFKyuDAyScfHihHWh8sA4Zhzbrp++vcczOLLsGa+U
         RgW6LAwyukYbZkmnaQykCcs7KysHO6PQRZ/BGyRnAfmooj1T0BvyK9tF+Vbia8g06BqE
         51+A==
X-Forwarded-Encrypted: i=1; AJvYcCU56uP+UNsa+F4txg7T0/jEq3WsdyHpjQ8VS0vSeeoTX28+8/Ji8HGzLDYnWn4Oq+X39pz7TXcjHOjKXrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyHtHkctt2/w+r4cODUhVaGMACfkqJcCpkcRx1PWoUK23JApvd
	H4rB+V8KinzqjxN+VXLhaS33SIjL5fxROhna4Wj5j89lMsg8CsoS63AsCe0KynjklOINLF6XuRM
	DB7QIBQ==
X-Google-Smtp-Source: AGHT+IFVzvg0CK9ZwoCOipgIshs73qxcJYeuZK5kSL1kqfjNfLJu1baJB5mrueBiJG7WDykBfBGWJG3ix+M=
X-Received: from pjbta7.prod.google.com ([2002:a17:90b:4ec7:b0:314:d44:4108])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:ca96:b0:31e:c95a:cef8
 with SMTP id 98e67ed59e1d1-321c0ae441bmr148738a91.32.1754929954966; Mon, 11
 Aug 2025 09:32:34 -0700 (PDT)
Date: Mon, 11 Aug 2025 09:32:33 -0700
In-Reply-To: <CAAdeq_+wLaze3TVY5To8_DhE_S9jocKn4+M9KvHp0Jg8pT99KQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250806081051.3533470-1-hugoolli@tencent.com>
 <aJOc8vIkds_t3e8C@google.com> <CAAdeq_+Ppuj8PxABvCT54phuXY021HxdayYyb68G3JjkQE0WQg@mail.gmail.com>
 <aJTytueCqmZXtbUk@google.com> <CAAdeq_+wLaze3TVY5To8_DhE_S9jocKn4+M9KvHp0Jg8pT99KQ@mail.gmail.com>
Message-ID: <aJobIRQ7Z4Ou1hz0@google.com>
Subject: Re: [PATCH] KVM: x86: Synchronize APIC State with QEMU when irqchip=split
From: Sean Christopherson <seanjc@google.com>
To: hugo lee <cs.hugolee@gmail.com>
Cc: pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, x86@kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yuguo Li <hugoolli@tencent.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 08, 2025, hugo lee wrote:
> On Fri, Aug 8, 2025, Sean Christopherson <seanjc@google.com> wrote:
> >
> > On Thu, Aug 07, 2025, hugo lee wrote:
> > > On Thu, Aug 7, 2025 Sean Christopherson wrote:
> > > >
> > > > On Wed, Aug 06, 2025, Yuguo Li wrote:
> > > > > When using split irqchip mode, IOAPIC is handled by QEMU while the LAPIC is
> > > > > emulated by KVM.  When guest disables LINT0, KVM doesn't exit to QEMU for
> > > > > synchronization, leaving IOAPIC unaware of this change.  This may cause vCPU
> > > > > to be kicked when external devices(e.g. PIT)keep sending interrupts.
> > > >
> > > > I don't entirely follow what the problem is.  Is the issue that QEMU injects an
> > > > IRQ that should have been blocked?  Or is QEMU forcing the vCPU to exit unnecessarily?
> > > >
> > >
> > > This issue is about QEMU keeps injecting should-be-blocked
> > > (blocked by guest and qemu just doesn't know that) IRQs.
> > > As a result, QEMU forces vCPU to exit unnecessarily.
> >
> > Is the problem that the guest receives spurious IRQs, or that QEMU is forcing
> > unnecesary exits, i.e hurting performance?
> >
> 
> It is QEMU is forcing unnecessary exits which will hurt performance by
> trying to require the Big QEMU Lock in qemu_wait_io_event.

Please elaborate on the performance impact and why the issue can't be solved in
QEMU.


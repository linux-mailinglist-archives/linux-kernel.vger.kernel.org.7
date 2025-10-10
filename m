Return-Path: <linux-kernel+bounces-848574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 885E0BCE11A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 19:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3FD134E30C3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 17:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0FD21D3DF;
	Fri, 10 Oct 2025 17:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/lfwDDP"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CC11DF751
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 17:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760116698; cv=none; b=cm3e1DO0xFNk/qNEsDjypZ7sxXQdO7tVw3Ns+7/3BOiOV44PvHZcuOFjvt+osh3DWkN+tNDUrM00uf6vZJEZXN21xCnPl0gstlu+fqSsFApva/YtBj0xWOnJ85RJc+rvKdQJNMmGMcHNmbmXYGNbWAXQraEx7uY6T8XDvW8GbLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760116698; c=relaxed/simple;
	bh=Z8Bgg8Yh3z/S2AKEWMy72snzKqxcwIZAWYiJw1H/xlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ka0gyTOE7v7/8B1AwWaLGRm4IT2q5ca1Cb2Y/JYYTy+l51NpogsRIV5OI6b0IRmg29zwog1uP2IccQGTBaIHZ08gevHubsjtJ06BBhMAhLt0Diev/pPAS1Y10hvUzunPpVnKpEFyIpheU9tGfQtmZ563cWW6sVlW8MAg70/yeaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/lfwDDP; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-33b5a3e8ae2so1635298a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 10:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760116696; x=1760721496; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4BfVsigI/RIm7lCLr6Chg7lwMcGQgn9TsXQSX3+pXnM=;
        b=G/lfwDDPTIJm8F10JlGVZ42+ooBOZZXzLjuA2ttCnThVp9CKtnJUF4Gl8qy1BD1itS
         UIFvhdkeIHPS5A0RAB+QETV0YKlOorO4mbCKjLIeDpugPXH2XBCig4gq1xeqne8iIhuJ
         1Lpv2vkFO9YUMRITCuTAn3qaznCTNI9o8dmEzcVJIp/XjRBBaVl+txBIDZ8/yDqCwQhU
         H1W7EuIU/3rFbEwvMnRps35TyFxgP6gQaEPsl0dgQmBbZT4upspBgwIR6JvsOUxK/LjT
         T8V7UIl/eiVmrfW1yyZrsqI+Wf22UtaskmcWiemq2Ud9jPFFDoORu+yfzTpHn5BfWbY1
         TnpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760116696; x=1760721496;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4BfVsigI/RIm7lCLr6Chg7lwMcGQgn9TsXQSX3+pXnM=;
        b=VyWhX+Wag+GRiWIHZ0xA+hJ+cOC2b7hMVoOSOvEDg8M/BLVavjuKeX8+32T+uzMRve
         50TymzboddRKtQYmLy/C6aFNVjXJj1LkllbwRY5EKTXBxxxOLyEhrHlYCmfJcy1rVrCb
         VVZFy7sBNeQr4mmqLYMO85VWHlA2ojAi+xKNmXdqHfexroD4S1v1Wyv+exjgWV318BM/
         yYJKCn3g4wXlJ+EGagE5vbMpF2cJ2lKsvV2fuzRManPy7z87NQgv4wJN4mkq6OhKl8Q4
         pXOSGy9xSMdE21WNFkfMOGAaOEdYx7SubWJoDCHg14VLj7bFHOiC3dtnoTlcbvMclwi0
         ckzw==
X-Forwarded-Encrypted: i=1; AJvYcCVahm2Esb1FMd2EzjNCvy4O8We/q4WA2HQk13YgPJmNyez58/gMGKbHLbKSO3XxvtGfJH6bRRfp8Pwt33c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9/oCIwo5iyf8ssCeSbQW0NLTFyabaOTklnsgpzXydMr7o5seJ
	vCuZZf9k7XIjVvUDvJNRgNOVrVaHWaUFDPYLywxhMfqLUwwVXL2IGUj0b4wONTc9n+8L/qpYWav
	QFOoCDLmfjSIrEjpSkFRdV9VuMPAiPu8=
X-Gm-Gg: ASbGnctvBHjwCojd8EOOYjyU34IL0C4rZa9j5RfOFUyQcE7sNb+gR2m7qNHWLp2b5YM
	8hnvwnswdlH2yQcgcySwMVS9YOj0KT0lJRmSDK6UHRbrJkIH5enLQ2IKYY96ZEdy2Ddg5XUnk6u
	Ug1Qy5ItrqKiMdwpgKDekpq+o2mqt/Gu3s8Em18/2wZLKAH/v8rzW+DPoP1v6HRezx5Pvy3VegR
	G7AdQmVd+ruDiiQwagC9a/f/1YyUEAPkgy/Lg==
X-Google-Smtp-Source: AGHT+IH1giPZcnOv6CGAjB6Rl2QcFEzz3CPtE14GWTh10ezJZ6kvXIL6/4N3fdyqX9JAPTZlX1XtlfpaKep3fWug9Ws=
X-Received: by 2002:a17:90b:1fc4:b0:32b:d8a9:8725 with SMTP id
 98e67ed59e1d1-339edadd5b9mr23216650a91.18.1760116696201; Fri, 10 Oct 2025
 10:18:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009150651.93618-1-jckeep.cuiguangbo@gmail.com> <20251010071555.u4ubYPid@linutronix.de>
In-Reply-To: <20251010071555.u4ubYPid@linutronix.de>
From: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
Date: Sat, 11 Oct 2025 01:18:05 +0800
X-Gm-Features: AS18NWB9IwjfwJLLXvf_C7PSNG6WlpQ2fa-Gc_uHnrsGBHqIZb9E1EFejDVQ0N0
Message-ID: <CAH6oFv+SUo7B6nPPw=OgQ1AhqVfQYC1HvX=kjcHJX8W13kTwZQ@mail.gmail.com>
Subject: Re: [PATCH v2] pci/aer_inject: switching inject_lock to raw_spinlock_t
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Waiman Long <longman@redhat.com>, linux-rt-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, Oct 10, 2025 at 09:15:55AM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-10-09 15:06:50 [+0000], Guangbo Cui wrote:
> > index 91acc7b17f68..6dd231d9fccd 100644
> > --- a/drivers/pci/pcie/aer_inject.c
> > +++ b/drivers/pci/pcie/aer_inject.c
> > @@ -523,8 +523,8 @@ static int __init aer_inject_init(void)
> >  static void __exit aer_inject_exit(void)
> >  {
> >     struct aer_error *err, *err_next;
> > -   unsigned long flags;
> >     struct pci_bus_ops *bus_ops;
> > +   LIST_HEAD(einjected_to_free);
> >
> >     misc_deregister(&aer_inject_device);
> >
> > @@ -533,12 +533,14 @@ static void __exit aer_inject_exit(void)
> >             kfree(bus_ops);
> >     }
> >
> > -   spin_lock_irqsave(&inject_lock, flags);
> > -   list_for_each_entry_safe(err, err_next, &einjected, list) {
> > +   scoped_guard(raw_spinlock_irqsave, &inject_lock) {
> > +           list_splice_init(&einjected, &einjected_to_free);
> > +   }
>
> I would either convert _all_ instance of the lock usage to guard
> notation or none. But not one.


> Also I wouldn't split everything to another list just to free it later.
> I would argue here that locking in aer_inject_exit() locking is not
> required because the misc device is removed (no one can keep it open as
> it would not allow module removal) and so this is the only possible
> user.
> Therefore you can iterate over the list and free items lock less.
> This reasoning of this change needs to be part of your commit
> description. Also _why_ this becomes a problem. You do not mention this
> change at all.

Hi, Sebastian

Yeah, you're right. Once misc_deregister is called, no new user can add
err injection, and aer_inj_pci_ops was deleted by pci_bus_ops_pop below.
All places that access einjected have already been released, so freeing
einjected can be done without locking.

I will drop the lock in aer_inject_exit, and update commit msg.

Best regards,
Guangbo


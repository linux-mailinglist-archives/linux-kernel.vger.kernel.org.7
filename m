Return-Path: <linux-kernel+bounces-841643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA58BB7E22
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 20:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A45BC4EE94E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 18:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A35C2DA77F;
	Fri,  3 Oct 2025 18:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i37GG8P2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BF7442C
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 18:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759515960; cv=none; b=I22R4dq4jDWF1HXXNgKtNqWBTSqo9YZ3J3KaDD74WcKLYMbOLlfJWyGZkfsez3F02pHjvL2UMyBYdz7WPPHXMC8wq7bHXH0wkBvOilujfO/g+/E5kiA10VMXoArU6Bj5Y0F5oOUvHoEkSeb0d0WPY53wdCzgin/3fmmna8dORO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759515960; c=relaxed/simple;
	bh=LActVDNHHJ01+cVP7NdYblEaRaHfOE6w3rkfKjPwdu0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Syn4KPKPHeV6CoAmlT7JRwdC2MWCHMLZ6Wk5ss5P3F5mAc+g2QZLgmzHJFce+rEUJi8APUhznJ0Pre3jdgd/fn+NujV45OwUgF+Pz6KbfI3MxG0vhrTVvG729RCegAXFfDWQbOG/fdUJEnFb5Mht8tSy5+P52cpMt+CYoKiqgE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i37GG8P2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759515957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LActVDNHHJ01+cVP7NdYblEaRaHfOE6w3rkfKjPwdu0=;
	b=i37GG8P2YTAVSmZ+cj1CiEPOtjhTn52e1RvFqS35ZUfUtbGHRBWPLaudRcjgvCEpY0Yccw
	cofY3vCqwmpQxU039bkZXu7g2a3BiJfkEZagZFvK0mdDbpp6XlsLvmWGlMGOePKpV3dyRz
	SwhKmIZ4hbVCjRGcQ/bfQ0QIe6AJ6zE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-XzvITU9kMdyddvC54sYXOw-1; Fri, 03 Oct 2025 14:25:55 -0400
X-MC-Unique: XzvITU9kMdyddvC54sYXOw-1
X-Mimecast-MFC-AGG-ID: XzvITU9kMdyddvC54sYXOw_1759515955
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4dfe8dafd18so106687051cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 11:25:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759515955; x=1760120755;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LActVDNHHJ01+cVP7NdYblEaRaHfOE6w3rkfKjPwdu0=;
        b=Tml+dQZxkI//++TgTxUxPD9Xzh+MWdtpnGc08VKnyVF1toUzT7/bhjuk5QRMocEzN7
         3LjPx9Onj0FGqHZIcqnLUOnp2/jF3tpRcPfDwOWLq3QxRLTDILMhWXAyuG6vttDL7avR
         ugLCVkED0IIaF3S1RiQp9pEw4S5clBz+8+ZfhEcrgkFOD454QJjK1o10yvipbJCtDm5o
         2hgnUQZZw+66WsQt+d4rGbQ4pUHlFrqyHdm93LeEdWwBRw57Zcq9dxu98quizIW7VQUI
         QcB0Sjn/HmaR0jEqvs0LBXAOvNHvhvVwAC58t5jpVRBkTAWjBuAv6C5xPtwToiRQtuNp
         RJmg==
X-Forwarded-Encrypted: i=1; AJvYcCUVzzomCjRKK7qxH8O6qvya+Rm2tMiPk93+I04tbLtkf68A552uyzk/pAGLnDpREbLax1BpBssPYASOWjk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Sd6hkfFRHn+j3KuAkMjOOuq8IUjuk5zniFxmqEQc5TFp/s0K
	/2VTCYpeTe8gb39IvmCWxR0bZwnlLBaK59x3YVp6ev+YXvj+H71r2I9JR/yKJ8Wu3TZmcpZUWvd
	LeZdC9m8T0G9LhxepA+JB6FscfzOTUfqulXIKZGkiNOi5RjFiUeI7Al78/brDpjJbjA==
X-Gm-Gg: ASbGncvqMDIBHHPVFapEJ5qC9wuFM0k/RrSTenr1PI4MxCCS/cq9rOs3cNmy2+guf90
	aQrGXHTU/1j6HVXXc9SpyRnpMktTW+Bh6g73f7Bcv5n/JuYAeu2iWOPM4gTXpb7eBRbwZp5XfjC
	qeULsNEQfuN3v/o5B5hegWeTlPPqj87coB4iq3fcwCyOdaZH45yZXlKAXgQLR/bFQHSpyJoOORT
	waZjOA06zMGSHryGLFSf7ZUbw4KXhUBOkGEFz4J8xk9SOTqaBjm34rsg1t+YnPwH2hFBLobdiu4
	gO1/QqF5sq26dvAiKDaumt32h0rc/aa4cy/aG7keSPlr84FaI9A5TVZX6xVul6PkbQBej7tyAA=
	=
X-Received: by 2002:a05:622a:420b:b0:4de:5adb:20df with SMTP id d75a77b69052e-4e576b49fc9mr51800351cf.75.1759515955463;
        Fri, 03 Oct 2025 11:25:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHl6MbKs3Xb6exRfHKs8R/8W88faZKEv/f6HSCYFxtPk4/rUynv2mK5zOAipf0zbQgK3MTWtQ==
X-Received: by 2002:a05:622a:420b:b0:4de:5adb:20df with SMTP id d75a77b69052e-4e576b49fc9mr51799931cf.75.1759515954967;
        Fri, 03 Oct 2025 11:25:54 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([50.145.183.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bdf52afcsm44134596d6.46.2025.10.03.11.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 11:25:54 -0700 (PDT)
Message-ID: <1b3684b424af051b5cb1fbce9ab65fc5cdf2b1a1.camel@redhat.com>
Subject: Re: [PATCH] genirq/manage: Reduce priority of forced secondary IRQ
 handler
From: Crystal Wood <crwood@redhat.com>
To: Lukas Wunner <lukas@wunner.de>, Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Ingo Molnar	
 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli	
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Dietmar Eggemann	 <dietmar.eggemann@arm.com>, Ben
 Segall <bsegall@google.com>, Mel Gorman	 <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, 	linux-kernel@vger.kernel.org, Attila
 Fazekas <afazekas@redhat.com>, 	linux-pci@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, Bjorn Helgaas	 <helgaas@kernel.org>, Mahesh
 J Salgaonkar <mahesh@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>
Date: Fri, 03 Oct 2025 13:25:53 -0500
In-Reply-To: <aM_5uXlknW286cfg@wunner.de>
References: 
	<83f58870043e2ae64f19b3a2169b5c3cf3f95130.1757346718.git.lukas@wunner.de>
	 <87348g95yd.ffs@tglx> <aM_5uXlknW286cfg@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-09-21 at 15:12 +0200, Lukas Wunner wrote:
> On Sat, Sep 20, 2025 at 11:20:26PM +0200, Thomas Gleixner wrote:
> > I obviously understand that the proposed change squashs the whole class
> > of similar (not yet detected) issues, but that made me look at that
> > particular instance nevertheless.
> >=20
> > All aer_irq() does is reading two PCI config words, writing one and the=
n
> > sticking 64bytes into a KFIFO. All of that is hard interrupt safe. So
> > arguably this AER problem can be nicely solved by the below one-liner,
> > no?
>=20
> The one-liner (which sets IRQF_NO_THREAD) was what Crystal originally
> proposed:
>=20
> https://lore.kernel.org/r/20250902224441.368483-1-crwood@redhat.com/

So, is the plan to apply the original patch then?


Thanks,
Crystal



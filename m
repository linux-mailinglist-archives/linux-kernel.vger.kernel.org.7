Return-Path: <linux-kernel+bounces-787008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD5AB37022
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 18:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 163571BC1AB9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF53312814;
	Tue, 26 Aug 2025 16:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IFkdVRZJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF942C11FC
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 16:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756225465; cv=none; b=Tw9YnkvqRbfL2jGDc4h6f1A7dGmgD94s9XvPVJm7cFGbQBRWAqX0r7CkhJNsOAmi0vHBwjhZmOFuUfFpMLESZM5qjygFpo/S454sndQDFvZqhtzhiSG2EPBSP7wUxpjoIXhl5RzodXqoBgqwXOjF5oY7jVmLhtcg31aSI54grRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756225465; c=relaxed/simple;
	bh=pk1+KDkyoaqAtnIkFzZI+W1at4fbDeoEIRnzxJiguA4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gwsn06QgtC1h4T5f5xvGePP8r8WsnzVzu7relbEYUmsMfcFeRR1heoZBi1Lu8ZSbOKG1fmspU7SegzG6KpK0M2ZgG4rV4oDBOsuvH+6je1WD6j5usvjqG1XC3fhrfQlAugIRZ4iWu7DyRbJsrL98/jtajby5Bdvt/r2ddOjLREk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IFkdVRZJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756225463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3DRvj9SHcb313RxmMOQKtcYFfPDoXScIlFzVPwHabrg=;
	b=IFkdVRZJC4FbaR2J1kwGhAUevv7pMu9Qx1G4L3chFV5eblD8HICkc8W2vSZDKk+3KFjqV2
	CErIrYT2YM53OyjvQl7YVixjUrtKV7WjMHIdarSUalYI98r6w92yjN+ICKNTuLVHzVEg/7
	thRb4zzwnyMbhOBSkxWPvr9DPdyjNuU=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-WKHpf4Q0OyWmH9lRKOdX4g-1; Tue, 26 Aug 2025 12:24:21 -0400
X-MC-Unique: WKHpf4Q0OyWmH9lRKOdX4g-1
X-Mimecast-MFC-AGG-ID: WKHpf4Q0OyWmH9lRKOdX4g_1756225461
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3ebd3ca6902so5415335ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:24:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756225461; x=1756830261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3DRvj9SHcb313RxmMOQKtcYFfPDoXScIlFzVPwHabrg=;
        b=DtNacrDJ6s3lX3PXPUvtQc8G3MUvyzhXNuySt7e8Gi09pE3j4Kynu5gdTwRmuR40Zt
         aq8bPK1UDtyZ/q3IpnvbvXy6ve+o4h3IFbAs+jjq0lEgNAPySidd2/3kcDWm4JR1lNml
         ZKGalbxEr/P8YHTOzESuqTUFL1PsrqI4+5Al4/U6Hz1e1fe4gPsCh/B+YGCdcqWeWcc6
         +4/1ISbKCaMESxzNVSw3Ndl8PdNEMta7VKU2lqL7054K99Gc9vjeIuZrgFAR/Tt8vGLx
         6SqTNUh1hsiTrYnEhaz2Fi+eBwWy6+QkD/FGaecXxBMEjU45yCq2EFAupYGH5ggjTggL
         +Umg==
X-Forwarded-Encrypted: i=1; AJvYcCW0n3bxEYPgRjqnn9bRzaVp34jyTqsgL5HiGE90pUnWdcWsWTsSPXwSYkGdlD8tGX4Vvvx2bfoYQVmZ7+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEpN2bz0PwBdb2vFJ9ET7vgKyG6Yj5j5v82Fw1btr9+wfPyaEB
	iOcWDPw7Z6bqQdgfgKda+jRqZfdJaCfbI/ScQmsb4LIWJMpaj9EtyDldBUS14gVC0uP+K1wOMYX
	LgOmXWlQP8O5V7Ri1lKsUXGO3tJ+rv1CSTqqXEUD8tzh1AkiXzoaAMOzieeCSDw00kg==
X-Gm-Gg: ASbGncvHfQ8j4b7ycyK8QatpnZw2OV//BGHEkhYg3p3quoK7L3PqGyKalzc82vIm482
	xPL8hIoqHIxUPo+gHOlTPIHapF/Jf+LP8OHlaQLo8HLRTRPyIN1M1tEpaY8YFvd1qRa+tSzJhWB
	IdjC3P8Q2yKzFw8CPSpIwAOUBrEi05l6WDiEzITtdaPVsvmp+slz+e01flZI4SH2GBby64USgOK
	h6t0ej+q6ps9/sCVC1D7tfb5zMGedEnYoeur3/PIlfG5c7CQwhjfL8sX08Cdggfv4qEo0mSkxMV
	uYfHK0wacPmAHbfC7nGGp9wq0zd09YrTlf4UUk9mm+w=
X-Received: by 2002:a05:6e02:ca3:b0:3eb:9359:d896 with SMTP id e9e14a558f8ab-3eb9359db7bmr40662735ab.3.1756225460644;
        Tue, 26 Aug 2025 09:24:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmin04GaruynHXLV3EmAB3AOv0MHqsYH/MYaIx/IC/y7jDBa3d4BpatCwcs6IsDHllI5zy1Q==
X-Received: by 2002:a05:6e02:ca3:b0:3eb:9359:d896 with SMTP id e9e14a558f8ab-3eb9359db7bmr40662465ab.3.1756225460200;
        Tue, 26 Aug 2025 09:24:20 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ec79dabe36sm42903925ab.29.2025.08.26.09.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 09:24:19 -0700 (PDT)
Date: Tue, 26 Aug 2025 10:24:16 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Nipun Gupta <nipun.gupta@amd.com>
Cc: <arnd@arndb.de>, <gregkh@linuxfoundation.org>, <nikhil.agarwal@amd.com>,
 <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <llvm@lists.linux.dev>, <oe-kbuild-all@lists.linux.dev>,
 <robin.murphy@arm.com>, <krzk@kernel.org>, <tglx@linutronix.de>,
 <maz@kernel.org>, <linux@weissschuh.net>, <chenqiuji666@gmail.com>,
 <peterz@infradead.org>, <robh@kernel.org>, <abhijit.gangurde@amd.com>,
 <nathan@kernel.org>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v4 2/2] vfio/cdx: update driver to build without
 CONFIG_GENERIC_MSI_IRQ
Message-ID: <20250826102416.68ed8fc6.alex.williamson@redhat.com>
In-Reply-To: <20250826043852.2206008-2-nipun.gupta@amd.com>
References: <20250826043852.2206008-1-nipun.gupta@amd.com>
	<20250826043852.2206008-2-nipun.gupta@amd.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Aug 2025 10:08:52 +0530
Nipun Gupta <nipun.gupta@amd.com> wrote:

> Define dummy MSI related APIs in VFIO CDX driver to build the
> driver without enabling CONFIG_GENERIC_MSI_IRQ flag.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202508070308.opy5dIFX-lkp@intel.com/
> Reviewed-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
> Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> ---
> 
> Changes v1->v2:
> - fix linking intr.c file in Makefile
> Changes v2->v3:
> - return error from vfio_cdx_set_irqs_ioctl() when CONFIG_GENERIC_MSI_IRQ
>   is disabled
> Changes v3->v4:
> - changed the return value to -EINVAL from -ENODEV

What are your intentions for merging this series, char-misc or vfio?
Thanks,

Alex



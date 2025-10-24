Return-Path: <linux-kernel+bounces-868558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C345C05764
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E85491B87DDB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D9630E0E0;
	Fri, 24 Oct 2025 09:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cRnMyVZm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3886030DEDC
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761299842; cv=none; b=Tx7AlBPLURZPd+xMcbO0aDSq5j75WhNVnGN0tklNBVxsJ30PAR0tfbOUqh0PG2AcerDHdZGs88Hz8NLUlnR4J6NYfxZUcDQuey0RvTZzlokWyU/pJZ04tnQiyMQfvwZHM4J5t8FvU/m5HcZoDoOaBvEsJQX4bSoji5NNJBPGrGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761299842; c=relaxed/simple;
	bh=nIEK9cEhnaH1yJ2ZUGlKpHTQhWUHwyWzPZXXs9pPUfc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uZRvso2q6rEiKjzFFXF/jjAz2BECs4F+RGtWSbrn7iRJg13jDhmsj2zv+HAOUtplUw3gli5sb/0oSykoz7Jvsrjw0/xxY7YEvzJBNyggLQqqVXPswNre8plp6s+XBFr2MfadhVm3vqXW6x1KInm06NmsXVV4WnjEoJh8racl88U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cRnMyVZm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761299839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EECPZ9d8E6GPLO4i/dKA5m4dqP651VCNME9poiUNpOs=;
	b=cRnMyVZmP7k6ohG18EBQWlyBlWC32SKQRiQGiZKxCypdH5Qj2GqRfu0nnYaCUHq7vB6jsS
	LyF91l19LT8OBUZZIMfryv+D0SLgqOlVWNliCiYMQ17WaGQ+qz2DLKecvCOY8ktKlrAMmD
	UpQ8Ldlhho60F/SsZaouRio2A4Hs2ss=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-pXNxq4P_NlWrMCRHbAaCeQ-1; Fri, 24 Oct 2025 05:57:17 -0400
X-MC-Unique: pXNxq4P_NlWrMCRHbAaCeQ-1
X-Mimecast-MFC-AGG-ID: pXNxq4P_NlWrMCRHbAaCeQ_1761299836
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-471193dacffso9510705e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 02:57:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761299836; x=1761904636;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EECPZ9d8E6GPLO4i/dKA5m4dqP651VCNME9poiUNpOs=;
        b=AF4I/4aPOZl0nVI8R1dY9fULCM2u1FxQ0IENgi3uZNFEpvsz5OcQ1saIdv7budyKOh
         cpVjQotMkdDf9Dmrwzl+Y8v0NxQ+m8KoF9FjVqCMU7ktQAwp4ebvJwg/dCUh9tOJzvyB
         WvDOdfSo+4G5tNAOolsjyD8VwYLgThrRbwTA/0VV0lP4kFiyh+rpsaMKb2XuKzHrY/vh
         KPsqHuBoLybVg4c6nHKmjQfiQeCjj0yQfBSCgzGulyBCxQ+VbDIR3dwyZjMvZVc8nnYb
         bjg2yXYnRe4Ptj9IrpRzvm9gKQ6+XHC7eEqjUX1SJYFBG2GPuYiuSqKUOxvWiminngVq
         EhCg==
X-Forwarded-Encrypted: i=1; AJvYcCXoztJexJYr7kggvDMeQvMnl8s5auqbOQH+JfCH1Qzbigugshky8UMNQckPbP2m1Ntwl0iBS6fbq7Fnh/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwboMJLdPfjZutLA2JUlo9YCU8AxrcWWpfIPi+9wU4ddtrd+OB
	mty1F01/AFwOLlvGjkcwdi0fVTYwkC7ciWlbl2Wq4fMQ6MFlAHp+lWDGs0dT4vuqU6VL+14ZAqk
	6q+Q2dADiQxAPAAG7G7bnQO1ZvdaVRMBAkvEPiX3H07llGlp5UTkcCbrVbd7a3LXEPpq80/DWHQ
	==
X-Gm-Gg: ASbGnct5RSuEIa9moT6j/pPNrVYoLU687LL1hcQtqsQrk7sa96NmrS4IfNjr5BLMFWu
	XTcS+GvjzEzNhPTTtHsUR79c45N6wppnA9na1GMZXOzilqRMvEB/+f+I3ZwWGrynXV95wndGASr
	a7ImKKt11C+8YDXab4mRA8P6TojJVCp2sDTZ/FvavUgVoLpGasQjkggx2x8LNQsGkHIzzEI/fnF
	QrTVSP7Wfjrd/HXMoSG3SHQaQgFSgbB2z0upIB5o/+czWUA/rWEDUckC/wluriEwrHvs0IZ+xcM
	4+jePPZL52lrqECH5PLT58TGNEacTj1WYdvSyc/os/QXk0LHWwGfbZhFnznnCVDzeVlahRDonqu
	VeKfvv4DEPo7/pZyXnM7msDw/cHCYAWICkQDCM27H4IfhNXsYzX5lWg1NwQ==
X-Received: by 2002:a05:600c:c16e:b0:46f:b43a:aef2 with SMTP id 5b1f17b1804b1-475d30d20fbmr14523855e9.38.1761299835790;
        Fri, 24 Oct 2025 02:57:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFi4kHieaFnLco9wucyoKPkPcEj2osPLAl9lyR18xfQ/pKl2+mHzfqAxTuZr5DT8hf24aXQRA==
X-Received: by 2002:a05:600c:c16e:b0:46f:b43a:aef2 with SMTP id 5b1f17b1804b1-475d30d20fbmr14523665e9.38.1761299835440;
        Fri, 24 Oct 2025 02:57:15 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47496afd459sm84966385e9.1.2025.10.24.02.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 02:57:14 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, ardb@kernel.org, jonathan@marek.ca
Cc: linux-efi@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 5/5] efi/libstub: x86: Store EDID in boot_params
In-Reply-To: <20251015160816.525825-6-tzimmermann@suse.de>
References: <20251015160816.525825-1-tzimmermann@suse.de>
 <20251015160816.525825-6-tzimmermann@suse.de>
Date: Fri, 24 Oct 2025 11:57:13 +0200
Message-ID: <87o6pw8vwm.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Retrieve the GOP device's EDID information in the kernel's boot
> parameters. Makes the data avaialble to kernel graphics code and
> drives, such as efidrm.
>
> With efidrm, the EDID is now also available to user-space compositors
> via standard DRM interfaces.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat



Return-Path: <linux-kernel+bounces-837785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09187BAD2E1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 16:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68022321EEE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BFF303C9D;
	Tue, 30 Sep 2025 14:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XoE5x3ww"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C488A2253FC
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 14:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759242670; cv=none; b=hk59lNYLuM+ke4WVpgWXm44m5DCY6pDvdPz2ZI7YIyR4q/QE50ej5UjWhRSD56Cir8DHDfG0hcEiAFLJdng//CpUeSTOctd/3o5Fxbrbtf3Lvdg5YSmBQcyjIqF6nlPsPUK5yvT+QJWuR3fL4Q9rNEsvwWzAqNbRrKeFUzyP7SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759242670; c=relaxed/simple;
	bh=TxtdYZk9dsFJydGVO6ymBCi05gQcE0LcJqQYcYklqBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=islQIAAZ374xqDEeoMMjiJiaJgwP1wGYMChOrMkQDbb/FfS9TEz5BIopybu1350Zc037lEkMBYsonNesowkfS2pYyBlAjO1pjX2qoXsDmbOykjkHNknhCh06YZML3lgHntnTIqKmLfgna//RnaeKh27GrqAGh3Uy4/kv5+CFgfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XoE5x3ww; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759242667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KiimNVQCGI88ieZh8p4IJZ/Sr9pCyj861BQTbYqy/Tk=;
	b=XoE5x3wwTJGFK9OmUiOuYkn9xmyE4GBO5GtZkZBZ4X3VHJ7/lYB6CDlb995F76IbtOiOEf
	s1guHuB4HRYXG163indjZUp6Fc9Uy0uyjZmmO0wK9Vdr5Nxfi71YOtNa4uI5cxKtDbFiiu
	v970KMCSXfnRR6Fayq+jBKXZ6lFyHv8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-4IxxznzeOOybS9KPpf-ciw-1; Tue, 30 Sep 2025 10:31:06 -0400
X-MC-Unique: 4IxxznzeOOybS9KPpf-ciw-1
X-Mimecast-MFC-AGG-ID: 4IxxznzeOOybS9KPpf-ciw_1759242665
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e3a049abaso29875975e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:31:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759242665; x=1759847465;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KiimNVQCGI88ieZh8p4IJZ/Sr9pCyj861BQTbYqy/Tk=;
        b=a4d2tVzeVCouzkgIhbvVesZnh4ZNvE6S0kYKjUabCdRO6nfsXnd9t2PVLtvP7bxmEI
         BS6vP6KQSAOsvZdvcfbirAlJxabx6gcTkcBf5iXGl8Vqw/ELDdCZbJ9xFXwU9Eo3fAvO
         6dcmUVS5BObTVS29E4ujGAd0yV3cZhud4e0JTlbRksCl8OgGuOOEVKvu23RC1Ax/PK4N
         lfar5aqeMoPZzhhqI9hTq8IroOE6VF8hY4DjfjGPHb+MOQ3CU2C86iJsMNShjJrKMi6a
         heo/RvvFc8YKOZqs7wURFV3/hrhIwfFoRE37eIWoef4w34KkWl6+9+G83JU9AB580QUP
         Ia3A==
X-Forwarded-Encrypted: i=1; AJvYcCU/uUI2DQuzkmlEMoyiODMcWX3DmQVfoZK5xdwvxwPvMBYkYrQ+4UxzwgUh2F2IE6ChkRPwM2jxRTjxMP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL3x0JUkIbIUYnnB2vYn+eL7nC2Db0SmEaLuFyiY+OsBfLdptF
	23c88im3gsZjYGoVg3VS6MzcwvAV5PYwlh5jVc1d1qh4Zts2zZ5xzyzr25HV6N8/50Fi8xS6Ens
	3XdzLzWCuuqd/N2ZtrtbQ6ZV98eGMdi2ZXD7phZ4zsFTCnZ/gngcgb1pGSdKrYZQ8FUZ7qRcK5g
	==
X-Gm-Gg: ASbGncs3wYhA9C4Vtm6h3tU4MNzyMBpfxB2nIKF9PFGQAMNr/AM6GeQxTzW6nuIYcf8
	w99Yl/X3Jvs5crr7sFtA1YvuStTgO6eGvnVUzk2Ijc8Yy9IN+dr+rtDHum2nNKYVTiHUneRNXwQ
	TtnDfyAwqGlLo/3Y6rUbamG0xKc/NCPfJPmj1G2M4TFUdqr5LLkf7lzZHN8leIo2t/zVKL5CL6j
	d/GgYP2yb6w3Tggs5rOGtp6QSG56W2EERYzHamd+ktJrwk3gXio6Z6IoyzwghFh546ELAlbXRbh
	m7wnaEXUOdbPvuejcZHNDqkgWWP8icCu+TknRlLMnQi3ePRd9y1Ux1oM7EyFKfc+/43NbAob1i/
	p3fALO1eyoHeRQjzCiQ==
X-Received: by 2002:a05:600c:8b55:b0:46e:45ff:5bdb with SMTP id 5b1f17b1804b1-46e6120218cmr1302085e9.8.1759242664804;
        Tue, 30 Sep 2025 07:31:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVjdt+VONnfPWja9/VsLbNc3mnehERm9krtPABV0fyuDy+ajxw8o2r9+1p0b6nLCu4FSG8KQ==
X-Received: by 2002:a05:600c:8b55:b0:46e:45ff:5bdb with SMTP id 5b1f17b1804b1-46e6120218cmr1301575e9.8.1759242664074;
        Tue, 30 Sep 2025 07:31:04 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e56f3dc27sm68198535e9.5.2025.09.30.07.31.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 07:31:03 -0700 (PDT)
Message-ID: <377697dd-15bc-4a2d-be19-1d136adb351c@redhat.com>
Date: Tue, 30 Sep 2025 16:31:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] atm: Fix the cleanup on alloc_mpc failure in
 atm_mpoa_mpoad_attach
To: Deepak Sharma <deepak.sharma.472935@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org, pwn9uin@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 david.hunter.linux@gmail.com, skhan@linuxfoundation.org,
 syzbot+740e04c2a93467a0f8c8@syzkaller.appspotmail.com,
 syzbot+07b635b9c111c566af8b@syzkaller.appspotmail.com
References: <20250925204251.232473-1-deepak.sharma.472935@gmail.com>
 <54234daf-ace1-4369-baea-eab94fcea74b@redhat.com>
 <CABbzaOUQC_nshtuZaNJk48JiuYOY0pPxK9i3fW=SsTsFM1Sk9w@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CABbzaOUQC_nshtuZaNJk48JiuYOY0pPxK9i3fW=SsTsFM1Sk9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/30/25 3:33 PM, Deepak Sharma wrote:
> On Tue, Sep 30, 2025 at 2:15 PM Paolo Abeni <pabeni@redhat.com> wrote:
>> AFAICS the mpc_timer can rearm itself, so this the above is not enough
>> and you should use timer_shutdown_sync() instead.
> 
> Hi,
> 
> As I understand it, `timer_shutdown_sync` will prevent any further
> re-arming of the timer. I think this is not what we want here; since even if
> we somehow fail to allocate our first MPOA client object on our first
> ioctl call,
> and hence end up wanting to disarm the timer, maybe on next call we can
> allocate it successfully, and we would want that caches are processed
> (which are processed for every time out). So we still want it to be
> possible that
> we can re-arm it.

Ah, I missed the goal here is just being able to rearm the timer (i.e.
there is no related UaF).

Given the above, I think you could instead simply replace add_timer()
with mod_timer().

/P



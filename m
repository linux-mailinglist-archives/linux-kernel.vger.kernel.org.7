Return-Path: <linux-kernel+bounces-862293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CA962BF4EC0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 05A1D505684
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044B525A2AE;
	Tue, 21 Oct 2025 07:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mnw2Mttz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41FE26C3B6
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761030886; cv=none; b=hTwiqq8uTclJreOsG9FmH2MCB+YInYJjdZfuvCas6euIOSoVRAnG2tHIPJt6HA+5SbIzHE+XiW8Mced2DDIEWrn92WsEW0kxziwORx/ajMzv5NtVS/PH0JpRLAaSgM5JU6xZmFwZxa9/U2yw5Hr7qjbzCaQlIRGd6Z3z14bDmKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761030886; c=relaxed/simple;
	bh=+B2pxE/i3SpbGCZgmKAbV6E4BQeWooWjeCR64E75cc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NCBY6/WAWqk3G59Plg4/578RdJFIZF70q0Z4h5ihWeoe5X0faDoKdJ9TOZuIV5khpvYNy8rS1hXPxrEuqxWlaRiauZJhRDiQ3ncwLT20cMc40kc9APMYsigXhCIhhlCMnITd8s4R40Z2dMhJEFMYgayKZMYT329/vS7u5/BsfK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mnw2Mttz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761030883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P3VpVCv3g+Sg2rw7HqhbXAeRhRk3VZinAbv22WqGX9s=;
	b=Mnw2MttzGR6BKtIJwSGOCbLSCAfEl/DLZY+XGQbROTw7LsDUhdWU/03JbOgkSwtSc+39Pl
	lZLoki8dH+WcndxythhkDzkgK6hNDX/dY3CX4cDMY7AXr1VrDg7vJkZGLXBAuF1Z/VdK/4
	lfD8/0fsz8dNw0nOSL07wWiroQ6G9Y4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-CyRxekzFOrC1qOgqpGTIBA-1; Tue, 21 Oct 2025 03:14:42 -0400
X-MC-Unique: CyRxekzFOrC1qOgqpGTIBA-1
X-Mimecast-MFC-AGG-ID: CyRxekzFOrC1qOgqpGTIBA_1761030881
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47114018621so25767255e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 00:14:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761030881; x=1761635681;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P3VpVCv3g+Sg2rw7HqhbXAeRhRk3VZinAbv22WqGX9s=;
        b=iQV2UmXSPHpq0IAg3Xyl/msr0Wd3snNft9oqA3Fm6V0Ty/RHrGXX+vkK+394oRUE3U
         +lHkyRyFF8VLlRqPl8vhbmkQkpcuplg3PWBMNRun2NECNPiFO47xH7fM56KM4jXM53xQ
         v7SlLsc3s7TmBh2XzqXHa2DGme8Sc0RPh/iYFL6Cp5O+3tGNXnlZ8zU9oxe1hGM7e3n5
         Z8eN70dDvtNiP+B85IjptBX0Q8LqoaQvsihLFFg5YtpPeV46zT06qSj/Di71jRm1bvyy
         G5Sj3ilxWuXqlekKjTLNHTwcczaAwNXMRPS3qMJAj5ZraZtxibr6KKvL9C+Fa6lpjjjG
         3SYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmsKQ/Qf52KqusejwbHHWgPp+G+9rOjmVUbvL9IICVnSV3Sl8OoBkq29G9MhwmbKcRhX5veWFQPkJEA3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfCkKcf2LjBXIgC5M28wbAc6tkYJnsqczMJ2Zpg0CfL2fT5gx3
	a/tzO8SuRbrWEEru66ZpNRhcEcDRzugWzW4m2PuTV5aS205FbtIvL4NkT55YNor53tiDVFlI2uE
	UJzzAhKoyQMgLWdqmAB124VZJIRk+3odPVCBqvHIHuQGkUyX0c3YyH0sxtQtPslIsIA==
X-Gm-Gg: ASbGnctKx2RM1ZE0bCRCeA2dVifoTAxU5qM7gSVXljTDee1YFuxeNMlw2bDzCqkdPwU
	RSbkfJAkVwLUOgLirADztAj0U7FxaVjRxntHDGrBtVx0G7mRRQVJv9YPuZZ6+wZHZLz5wAQQnoQ
	4c4Dr1eoSqulvMYQFYlL0+yZrh7e3V4+UBw+mMyJ2ndR4+YHV6jGNtbpkB4cxlPd/YfQIybksO2
	rNw5xfa2OavqXnKpMwRqlDtUr/MM9s6YBZLhDVECUNDXgvzs8cvwTR/bQ5flS0mQz5pma2G8ZSv
	7+ca3043ZjlFN4Si1RGHU6YV2t9da5B09axo+2UHL5Y0pbZCRIh3F2WMAYmU/MF7PWr12iJsx2i
	qY9ZAAkJKUS/rmlZZ1hbOhZeeb2KEEacHKbolFedj0d4NnWY=
X-Received: by 2002:a05:600c:621b:b0:46e:48fd:a1a9 with SMTP id 5b1f17b1804b1-4711791fbbbmr122888435e9.33.1761030880625;
        Tue, 21 Oct 2025 00:14:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAbONMD+QOMnDrNKO8RV6QYb7ZpSXAEjBfkQuhDaa4d7qoOlbgykLKNXPsi+4U3b+ujGw+cQ==
X-Received: by 2002:a05:600c:621b:b0:46e:48fd:a1a9 with SMTP id 5b1f17b1804b1-4711791fbbbmr122888225e9.33.1761030880241;
        Tue, 21 Oct 2025 00:14:40 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00b9f9dsm18907741f8f.39.2025.10.21.00.14.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 00:14:39 -0700 (PDT)
Message-ID: <be03d7a5-8839-4c84-9e16-b96e52f6983a@redhat.com>
Date: Tue, 21 Oct 2025 09:14:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/8] net: enetc: Add i.MX94 ENETC support
To: Wei Fang <wei.fang@nxp.com>, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
 xiaoning.wang@nxp.com, Frank.Li@nxp.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 richardcochran@gmail.com
Cc: imx@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20251016102020.3218579-1-wei.fang@nxp.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251016102020.3218579-1-wei.fang@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/16/25 12:20 PM, Wei Fang wrote:
> i.MX94 NETC has two kinds of ENETCs, one is the same as i.MX95, which
> can be used as a standalone network port. The other one is an internal
> ENETC, it connects to the CPU port of NETC switch through the pseudo
> MAC. Also, i.MX94 have multiple PTP Timers, which is different from
> i.MX95. Any PTP Timer can be bound to a specified standalone ENETC by
> the IERB ETBCR registers. Currently, this patch only add ENETC support
> and Timer support for i.MX94. The switch will be added by a separate
> patch set.
> 
> ---
> Note that the DTS patch (patch 8/8) is just for referenece, it will be
> removed from this patch set when the dt-bindings patches have been
> reviewed. It will be sent for review by another thread in the future.

Note that such patch is (AFAICS) breaking Robert's tests. Including it
in this series will possibly/likely prevent (or at least slow down) acks
on the initial dst patches. I suggest omitting such patch in the next
iteration.

Thanks,

Paolo



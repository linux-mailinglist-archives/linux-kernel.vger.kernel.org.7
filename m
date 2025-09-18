Return-Path: <linux-kernel+bounces-822578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1737DB84313
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10EC73B7CD2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E5F2F9DB2;
	Thu, 18 Sep 2025 10:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BNhcXiXQ"
Received: from mail-il1-f225.google.com (mail-il1-f225.google.com [209.85.166.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED372F90F0
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 10:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758192088; cv=none; b=H/49rMeTwcI9+2+Ej240LqXxWGDefGacdT88KrftHvd1akUDIUoqhzQpPfUQrO9oHDUmtE8JzfHaf8cAlEjNCfVDDUhJYSV0oZ7xJLwRLYAt1zv0PacRiTvFso/6yysamjY5beXpCVHXw44uyrmSULhhRJjdVqNNr37+zCUDtC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758192088; c=relaxed/simple;
	bh=CbE49JSJ+LMRaHZriOstDzk9yUxo35FaLPw3pqofbVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j9Z056qbNmhXHCr13ldGGtUKmzyUKqE56AplDa7aWTw80B2fxWBG7a4+lhumm7/DKe5wCJhC22T5Tf+wT+3r6qZc8XLoBtReAocWG+HFB360UIGaZy7PmafRnNm98vmc72Il8nNW3W8V51q2e+/ITsxISttK8lrhrQSqjXnYskQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BNhcXiXQ; arc=none smtp.client-ip=209.85.166.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f225.google.com with SMTP id e9e14a558f8ab-42406e56820so3969985ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 03:41:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758192086; x=1758796886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QQCJx6p5vPHKg/pDposcY1SdIZSMhxTSp8O6tFxrHXM=;
        b=NDPttKnfLFm6mnYOP09OmhwQoKv31dDB0zrHXogQcr4pnXP2MRpnrx4fqh3wlLlJpa
         8TUwsqOwgfCywney8zTg3fgVll9f3CkDidz76UcDkA7aE7OCyjhqsvcxF8h0w0GPfP3/
         tDs44jE3sex4fZmuc0yfuEloSPKe7tYjJe5S1v4dAyoC7fEzrerF022wprVyUdjYUUdJ
         gjePlULaFOJwc3MKsLf+Th0novqq6lUwJqzvKvc4XgnbRm1f80JqkCBzHrz9C40URHbO
         H5P2vefBPjZpiUvs0qru7nr/BpxCJ1i9RESijA/Y4bxjaFkK+F6ko6zdSdi2OiStxpeP
         r5zw==
X-Forwarded-Encrypted: i=1; AJvYcCWUj2ta1q8thlOTfVjIb3imansaBEQ4vrqCB+ihYE9YU5CpsmG34HABNeUNogWNAp96M4Mw0XTz9W4+Lm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhSU6KFVEGIjjgo7QmiBly1GAAs+c8v7duW9AhLY+UCLughLUV
	r0w0sfZrsC1AuJVRaTkyXaDwK80CUul5jXN18Lbnqt8nK/lhdZA0c85R+E9E2q5TycE1hdV4MH7
	0/9BoTZoZdL2F8sxdIg0vcDwLvk18Ee6R89V+s/Pc6jwz1EfPjUeKSmUOAW9LN7VhqA59h8COCb
	3Icsr50SRDPny+Fx6KmuYKTMLzJq2qkxZ9X+m0mNnqkyJ0OcAmxOJ0IiGU0YaLh9fhrd6xPZZEP
	tPSB4LnbDa36WgWeMcydVjCiw==
X-Gm-Gg: ASbGncsIeJzdN58soVt/KJ6P5kUCx2kxBQB4Kh1q/k/h/eWoAGUH8uP8WHcxcEYGVuF
	QA6CK3qsnRHJyvRcxNYRqf6WYkLVk3GwulwZotkGrrOTNa0F+sE5vQ+fOkePIqJuR8u1qInCT6w
	GHhLbazDOWR2BFeo+f3f0XAezYqK4kGHqWsKkys6ghaGt5SgU9Bn8FFNIqsu17BjVirlvThiAYu
	1fENS3i6Oi0ix9Jv7v/H5qcx9A12bYfuE3DWDU99iYCkuiO3rMlyVolLyvwnaPO9ze+Z2/fdbH4
	ypz5SQe7w6xvLbKkS2sb6ta7/dkPXdHUqRaB7vR1vQlXoQUEf63EStAHdGFAias+GOr0SXgqwvk
	/gbGx6HW1OLnEUs/BHMXVhSFDz1mfz8NDwG2L+FBvZGeFj57cE484c/0RNkHtbyJdajpqm81MBm
	PMhx39PksD
X-Google-Smtp-Source: AGHT+IEeAh64t9Y1XO8B5GRln2jY2FpNAzNn4RT4CbvTR2JNrxCFyaa+tfSvdZWSRYAioog0dht53Dqz7TJR
X-Received: by 2002:a05:6e02:480c:b0:424:1c3e:772c with SMTP id e9e14a558f8ab-4241c3e783bmr75604005ab.12.1758192086283;
        Thu, 18 Sep 2025 03:41:26 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-123.dlp.protect.broadcom.com. [144.49.247.123])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-4244a39273bsm1546665ab.12.2025.09.18.03.41.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Sep 2025 03:41:26 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-269939bfccbso4968395ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 03:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758192085; x=1758796885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQCJx6p5vPHKg/pDposcY1SdIZSMhxTSp8O6tFxrHXM=;
        b=BNhcXiXQGqm9CM8zSPgnlcJB7SOKNBfda2nDknRva5BeAb5O17COUPsoL4VksisPn8
         l7KIVKwxeEujPgq3butIBOUcbsN1MEBLhGqa1ic5INoAeLoyovEWSJOM34cUIk3pLT5Y
         cIHmSZMG8aF07Rur9yQjG8zjEcKNPZtvBg8Cs=
X-Forwarded-Encrypted: i=1; AJvYcCXHXLXnW51ojz2/2lk90F4OkKVV81uoSgE4AqQNDdGZ5r4HmQbWmt2rAtv6E4wf2n15SIgZ8krfKVLC+Ew=@vger.kernel.org
X-Received: by 2002:a17:903:4b07:b0:25c:101e:8f04 with SMTP id d9443c01a7336-26813bf16aamr68403955ad.50.1758192084748;
        Thu, 18 Sep 2025 03:41:24 -0700 (PDT)
X-Received: by 2002:a17:903:4b07:b0:25c:101e:8f04 with SMTP id
 d9443c01a7336-26813bf16aamr68403675ad.50.1758192084392; Thu, 18 Sep 2025
 03:41:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911193505.24068-1-bhargava.marreddy@broadcom.com>
 <20250911193505.24068-9-bhargava.marreddy@broadcom.com> <20250916155130.GK224143@horms.kernel.org>
In-Reply-To: <20250916155130.GK224143@horms.kernel.org>
From: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Date: Thu, 18 Sep 2025 16:11:12 +0530
X-Gm-Features: AS18NWBXxQ-XRVIz_9_yMEp0dLlt_TczR64kZc3knMwWoDDMOSdrut_aSwS6y_M
Message-ID: <CANXQDtYdxMq_EAPqu_WvnYqZ5SKW2k139Hwm+jW=kZpSQQgRtQ@mail.gmail.com>
Subject: Re: [v7, net-next 08/10] bng_en: Register rings with the firmware
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, michael.chan@broadcom.com, 
	pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com, 
	vikas.gupta@broadcom.com, 
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Tue, Sep 16, 2025 at 9:21=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Fri, Sep 12, 2025 at 01:05:03AM +0530, Bhargava Marreddy wrote:
> > Enable ring functionality by registering RX, AGG, TX, CMPL, and
> > NQ rings with the firmware. Initialise the doorbells associated
> > with the rings.
> >
> > Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
> > Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
> > Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
>
> ...
>
> > diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_db.h b/drivers/net=
/ethernet/broadcom/bnge/bnge_db.h
> > new file mode 100644
> > index 00000000000..950ed582f1d
> > --- /dev/null
> > +++ b/drivers/net/ethernet/broadcom/bnge/bnge_db.h
> > @@ -0,0 +1,34 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/* Copyright (c) 2025 Broadcom */
> > +
> > +#ifndef _BNGE_DB_H_
> > +#define _BNGE_DB_H_
> > +
> > +/* 64-bit doorbell */
> > +#define DBR_EPOCH_SFT                                        24
> > +#define DBR_TOGGLE_SFT                                       25
> > +#define DBR_XID_SFT                                  32
> > +#define DBR_PATH_L2                                  (0x1ULL << 56)
> > +#define DBR_VALID                                    (0x1ULL << 58)
> > +#define DBR_TYPE_SQ                                  (0x0ULL << 60)
> > +#define DBR_TYPE_SRQ                                 (0x2ULL << 60)
> > +#define DBR_TYPE_CQ                                  (0x4ULL << 60)
> > +#define DBR_TYPE_CQ_ARMALL                           (0x6ULL << 60)
> > +#define DBR_TYPE_NQ                                  (0xaULL << 60)
> > +#define DBR_TYPE_NQ_ARM                                      (0xbULL <=
< 60)
> > +#define DBR_TYPE_NQ_MASK                             (0xeULL << 60)
>
> Perhaps BIT_ULL() and GENMASK_ULL() can be used here?

Thanks for the suggestion, Simon. Some macros have non-contiguous
bits, requiring combinations with "|",
which would make the definitions longer and harder to follow. Since
these Doorbell Register (DBR) values
are hardware-specified, I believe it's better to keep them as they
are. Please let me know if you see any issues.

>
> ...


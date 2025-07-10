Return-Path: <linux-kernel+bounces-726532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B92B00E3C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ECFD1C86057
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 21:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD84D290D9C;
	Thu, 10 Jul 2025 21:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AneX5pvc"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D05323FC74
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 21:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752184571; cv=none; b=EHrpXA83fxehY7K3/9JXAlz2TeBFR49s5VPulLy6Tk8MQJ//IuKks3FpRJuSRELwIAIUUogwKI9RFmwktPVS1e8n8TnN3r3S0dpf5Xn8LlkYZTWpvOBoHD4dcFPW5VEpfDWukvDrDfHpVetV8T33ZPvSIt44+fmAGWWvOXide0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752184571; c=relaxed/simple;
	bh=yEUe36iGT2tjYBEroWVItA/U8MgbKRguqLFT0OU+jLo=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=tJGFdqpsJQ1ogDkyUB6BTE5rpCWbDmDhw2/AbyhtRO9F6oJHSs71ejW3P5y/jMqqtoHFRyLN171wZgJ5T885XtchWS7RCQ+8yE1YrqdqpKr7w+mQWmepGmtUsKgJXiZiJ6t9DQxXD74nvaFqnQGBdF04jrZ52Qk8fH7LBo4VXOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AneX5pvc; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4a97a67aa97so11111071cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 14:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1752184568; x=1752789368; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yWbp11K8y8N54piZ0w9HEapGynmdQ61Of/cRxlwOOcw=;
        b=AneX5pvcDwhox3k3cfU2QySpiKm4c0b7zBygPtlf0O5EIRHmYDOKnxdVgfLbqQXE8s
         EJ444n5LJAAu3d6bBMgCFPso9AnU8+R/dmEc52Qyf3fiiNrCzjqoIZ3hjZufR//pq7qE
         Th6R2I+3rViKIq3gVsPWuAHlRYprf0CS52RhSLIijc27ExlRyaS2c9xBIw0TodX/N0HJ
         YjxNGAbvcuw58x/jcqcsJUFCNADYWrWHw82bSX1/Zq0x3IoTtJhgJ3PorpfAMsGFaDh6
         1ON0U4aBAof86ogjtcqzHck7s0/38FUNfoYCJu3ZY50qpDocns2oPNHTo03kLGvN/ZVU
         QGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752184568; x=1752789368;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yWbp11K8y8N54piZ0w9HEapGynmdQ61Of/cRxlwOOcw=;
        b=pX9KOtUGF0Rhun6C/6cj9n4YdI8dVBlJRquCeFhlK8LkzwWZORTHyOpEpVHPc9LfRo
         JD2wp4QDL4+MmRtfFzFeTgoQFdZE/g7jT0JpoStjf7ZDCxaQw3H25/d1PAtZvnXI0aTK
         518jI5kiPBfJYmHIg9nkiyXi8k6AGTNbWLOZLVEicwY4GYqa47eMlWd/2TEBYo2lYeG2
         Pz5Bww7yhcyfEptFiTTkYSLW+oYYRN5rQwcUrHf3tOifuRcA+Gw4AWAjRAaicnUi1DuM
         P1HA77C2YNzzMZnYKw+CRn+B+OzDVCh8gNCLBlJqt8z8qj5tpN9dl3stWQdfvGBQa4iP
         yotA==
X-Forwarded-Encrypted: i=1; AJvYcCUJt51wNnO98PPSzuV32SKrWvKTPXEtiDvb4g664Hs01TmbGp18U5hhsXA+dS1DTmLZyeBQAZyy9ZwDhSo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+zvD7KzhqdSdH3FsG8cbkngGUulvt/JHR8e5HuY+xwCDUPSGA
	U2CbZGKV2uvgMIQRPXgJrHoP+zNxEhd7B+WpkXmShywbJyh1b5Lt5CLh+M/NRbQy/w==
X-Gm-Gg: ASbGncu+zUzUk1p7w/62+6yWMs0LKUA2Jn2X1LGjwomW0jlyPlpyJAes5iA6D2Ge3OR
	cJcqLcpaqEm2zwDtDktIc6rFCRfdyZ1b7xWQc1mqri1GB0QFuk5zt3Omsn0RDb5rCAKdWbbEoOd
	PrJBFo2GGKVw57e03mChcgBhLDQulW7UVgeAYdMQOqa6C6C/Q4vsdhLT9RgB7DGu9iFAIPLrn9c
	qBoP/QsFydqgVz71p+jCXCRySEERuygdly15boaQayR2mYHeG4sDlpqycm5l7HzuZuMct1uoU4q
	PZIIoRNE1jEnC7yMlRGqrIPKH8VCtJ1xwRNPgrOg/puvjR94nMMCq/okRonN2Fat2dlA3CBgZpa
	WWumvGs4faKADrjtPBG0qvhjN+5O+ysg=
X-Google-Smtp-Source: AGHT+IEpnELhzqIjxusSklObVJoQn6zvdS6ZOqrP6ujD96X7xvUTFs2JekOXI6D29K/IxMigh4k6Mg==
X-Received: by 2002:ac8:7c48:0:b0:4a7:fbd0:79c4 with SMTP id d75a77b69052e-4aa35ca48dbmr4704511cf.11.1752184568511;
        Thu, 10 Jul 2025 14:56:08 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4a9ede764acsm13481451cf.38.2025.07.10.14.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 14:56:08 -0700 (PDT)
Date: Thu, 10 Jul 2025 17:56:07 -0400
Message-ID: <9076ab8364625a675e2c548adedeb854@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250710_1750/pstg-lib:20250710_1741/pstg-pwork:20250710_1750
From: Paul Moore <paul@paul-moore.com>
To: nicolas.bouchinet@oss.cyber.gouv.fr
Cc: Xiu Jianfeng <xiujianfeng@huawei.com>, =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
Subject: Re: [PATCH] MAINTAINERS: Add Xiu and myself as Lockdown maintainers
References: <20250624-add_myself_to_lockdown_maintainers-v1-1-bed2bc934666@ssi.gouv.fr>
In-Reply-To: <20250624-add_myself_to_lockdown_maintainers-v1-1-bed2bc934666@ssi.gouv.fr>

On Jun 24, 2025 nicolas.bouchinet@oss.cyber.gouv.fr wrote:
> 
> The Lockdown LSM has been unmaintained for some time now. It requires
> some work to ensure it works as intended.
> 
> Xiu Jianfeng and I volunteer to maintain the LSM.
> 
> Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> Acked-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  MAINTAINERS | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

It's been a couple of weeks now without any objections, so I'm merging
this into lsm/dev and will send this up to Linus during the next merge
window.  Once again, thank you both for volunteering to maintain
Lockdown.

There are a few more adinistrative things we need to do off-list, but
those are probably best deferred until this change lands in Linus' tree.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0c1d245bf7b84f8a78b811e0c9c5a3edc09edc22..776c7fffcaec08f71faf2740599f0b4570179832 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14060,8 +14060,10 @@ F:	Documentation/admin-guide/LSM/LoadPin.rst
>  F:	security/loadpin/
>  
>  LOCKDOWN SECURITY MODULE
> +M:	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
> +M:	Xiu Jianfeng <xiujianfeng@huawei.com>
>  L:	linux-security-module@vger.kernel.org
> -S:	Odd Fixes
> +S:	Maintained
>  T:	git https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
>  F:	security/lockdown/

--
paul-moore.com


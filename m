Return-Path: <linux-kernel+bounces-785587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E7BB34E1B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 23:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D26A13B9863
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 21:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8238A283FDF;
	Mon, 25 Aug 2025 21:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XGikredX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F91F9CB
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 21:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756157712; cv=none; b=Kyy3onQ3zjBGMrGpWCm6V92YslF83r3emt3mD0bq6vA0cmzOf0pSZ7qwE3BMSLZN/IVnRzKEpenWEw1Is0eqoWxj/NGIrcShKX4eStwiv0RM7tuWugWgE0fIAwu1+5letwcLhthKYAQk/MrNe938VloKTO229kBVIT2tIIewQ1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756157712; c=relaxed/simple;
	bh=Q9CPbQpH2d/T5EyyLjYG2kTFNAop20As96U/hmdEPUY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cYiEhfb6XueBZjFk+bT5RfRtwMPeH/P1KcKZjbMZHfER+ejLd79Gp6Cj5Y8xuk4CIGY+Fdc9eTRsNCVPXWFDI9EWz7OModYO78HBFxovjQfMU6Zym9P3wR8Izy5yx0qVKOc251oUN1SHqF3gX6BBA7JrQkXd1TkOtc265xSLx4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XGikredX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756157710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TuacPQu0sUaEe98IXzV5lAzTlLH7oY2OXfsQpZup1+Q=;
	b=XGikredX5v9jn7PBhhl8HgjMknJFTTTB4B58fESiAj8/LLM3okH0Jfh8lyo0XLWS/DBDcO
	sY4T4VlIT31wrG01aDWsnEDK5TquUP8n8c0gyyGwy/3pmT2NppLQTBD5u9Qsd/SC6imE8Q
	SdZv4gbjElGnKYy3H9ew+JM6+LJGStI=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-V7Fn8OG4PDq87lz8YFJTsw-1; Mon, 25 Aug 2025 17:35:08 -0400
X-MC-Unique: V7Fn8OG4PDq87lz8YFJTsw-1
X-Mimecast-MFC-AGG-ID: V7Fn8OG4PDq87lz8YFJTsw_1756157708
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3e6804691a2so9451305ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:35:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756157707; x=1756762507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TuacPQu0sUaEe98IXzV5lAzTlLH7oY2OXfsQpZup1+Q=;
        b=QLglt8FT6sJosrIMjelUulUboUyhmeX4+QUMqOy9xW3A9P9F494BFv5keHPkrbvsfJ
         oV1g0luRsfHg6EDc2ixwdzYrFns9e1dk3Bn1f++oX5DbNsw5ig8W9djk3h75HDDCMtdC
         X2yJFtF0klm2/jJaE4r5+tMhXmXK8YK3G7++Tio52Rb2bg3bQeP0nb6PBqax3RbxUbw5
         WfIWqhbN5m2BDX9pIXa31kyESjHfKUL74tbt6PwIswyfIwpi2knAsjtNCvUa5fr5OvSe
         jkq4f5d/y6evmHV/cnmWahrBdVHm67QhfnjhjRnrEj9BnpVtXOcwp9GXRsAHXDcaW8wr
         zj1g==
X-Forwarded-Encrypted: i=1; AJvYcCWTv3Erb7gEFwE0blqm/8ELI8Cxsq5lsFF89NouXwPAkOoBgZjNU7n1HbxqzxJl0HM/hlpJMq6gpjX8uic=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfT4wNKC6jos/FV2pz8TxAwHQGsLLjWtalweP+SvXsXqDOa2K0
	kvl/Z9GUU27CBIqUrHNpg345MMCwyuQvixXP6Nnw5NXYKqeiOTJOpnpvUbupqS2Pz6i46h5bM+u
	goHQ/YGhN7k0wITfhcVZ0lyCrphdoabv9e3M26h2X8MZg3fNpo5xkEAntbcspBTH1HM+i1dr9eQ
	==
X-Gm-Gg: ASbGncs03NBUfeg0rFdW0fMrv4KTEzPsxAX7HXr0xW5DhXhjaAf/ldvF/eiCM+6lqLz
	kAn7JnLu8M1wuyifu+C0eggKRliM8EmGRXF3bFRzjqQ8DX76za34fXn/mHrd3PZmVKyfO6H9SiA
	cLqD/cnlTmELQ2xq0HSH0ywQDUiIuHo5cuSjLBGt9YZP2B8UBIwcEX49T2ZQo8+juZFUejsgcjy
	QSvEayVzTONtGJRTaL1GbNN3N3xf0Hc8ESv/+RjC7AM1FOIjMRBuMAGdo19E869IRgBY24E9MZ9
	LcPis7ccuPw2JFJh/cfknyApg+ilTWaFlXxml2FxpJk=
X-Received: by 2002:a05:6e02:4414:10b0:3e9:9070:b0bd with SMTP id e9e14a558f8ab-3e99070b2a6mr42182185ab.2.1756157707161;
        Mon, 25 Aug 2025 14:35:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjadVuAgSDvfABUcZMm01Kysw1HDncV59yUGSUyp2hVa5KPH4rom30lUjRmGeYrcRiA010pQ==
X-Received: by 2002:a05:6e02:4414:10b0:3e9:9070:b0bd with SMTP id e9e14a558f8ab-3e99070b2a6mr42182075ab.2.1756157706803;
        Mon, 25 Aug 2025 14:35:06 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ea4c761718sm56163575ab.23.2025.08.25.14.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 14:35:05 -0700 (PDT)
Date: Mon, 25 Aug 2025 15:35:01 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, helgaas@kernel.org, schnelle@linux.ibm.com,
 mjrosato@linux.ibm.com
Subject: Re: [PATCH v2 1/9] PCI: Avoid restoring error values in config
 space
Message-ID: <20250825153501.3a1d0f0c.alex.williamson@redhat.com>
In-Reply-To: <20250825171226.1602-2-alifm@linux.ibm.com>
References: <20250825171226.1602-1-alifm@linux.ibm.com>
	<20250825171226.1602-2-alifm@linux.ibm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Aug 2025 10:12:18 -0700
Farhan Ali <alifm@linux.ibm.com> wrote:

> The current reset process saves the device's config space state before
> reset and restores it afterward. However, when a device is in an error
> state before reset, config space reads may return error values instead of
> valid data. This results in saving corrupted values that get written back
> to the device during state restoration. Add validation to prevent writing
> error values to the device when restoring the config space state after
> reset.
> 
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  drivers/pci/pci.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b0f4d98036cd..0dd95d782022 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1825,6 +1825,9 @@ static void pci_restore_config_dword(struct pci_dev *pdev, int offset,
>  	if (!force && val == saved_val)
>  		return;
>  
> +	if (PCI_POSSIBLE_ERROR(saved_val))
> +		return;
> +
>  	for (;;) {
>  		pci_dbg(pdev, "restore config %#04x: %#010x -> %#010x\n",
>  			offset, val, saved_val);


The commit log makes this sound like more than it is.  We're really
only error checking the first 64 bytes of config space before restore,
the capabilities are not checked.  I suppose skipping the BARs and
whatnot is no worse than writing -1 to them, but this is only a
complete solution in the narrow case where we're relying on vfio-pci to
come in and restore the pre-open device state.

I had imagined that pci_save_state() might detect the error state of
the device, avoid setting state_saved, but we'd still perform the
restore callouts that only rely on internal kernel state, maybe adding a
fallback to restore the BARs from resource information.

This implementation serves a purpose, but the commit log should
describe the specific, narrow scenario this solves, and probably also
add a comment in the code about why we're not consistently checking the
saved state for errors.  Thanks,

Alex



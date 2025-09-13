Return-Path: <linux-kernel+bounces-815065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96107B55EEB
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 08:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB14D1B24D49
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 06:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFD62E764A;
	Sat, 13 Sep 2025 06:20:45 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2992E4437A
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 06:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757744445; cv=none; b=QhnHSMGBgMArvno94Tl9EQMvLphO28F09AhsKETMBkL8XNeZMnTFjC2vwtlFJDAuL308dtsk7FpZ2Cssz+Iu/IW9hEeWKacLtAhDOqFekkiRf4WJ1cW20xSGPYdKlOIs1sQ/NESoQYir3ifctLmRY/5KDKo4ANn8gEeNMRrWThs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757744445; c=relaxed/simple;
	bh=eKqGAKGnvYVVr650P1zWrcUeP5ASxo6BtaEVJZ9ebMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Na0LVuO00LlYMbCSU8zibv+Pz6tBIikS6NrQFeH3Xlzrn471sMV2FdRyDN6ekwU9WREMxCNk+nfPNyjx4SrQQd9y/oSFS0x0lqeMbJNt/Si2gkzLUG9NODWAi+PbG+o3L6yrzZ2kR5ZcxDTm7vBs77PJUL3dxMpevQkXxmXw82I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so2221399b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 23:20:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757744443; x=1758349243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hMbcUGKbGoswq7yrabTwHGQfkgjayENehQjNWLCUge0=;
        b=kTDu4XFuTpz1+MOtMq4q7xrRm/pLs2pGqykHZMcajoeNLxmKxVhKS0GdZbLqr8obQu
         QaSNzxUIK777zlqVCL+RMUv2ssc+sKE43TcMxXvbDwLdySKqmBQT85c58jyYaUkRmfzv
         3KGT+uWwcCqfI2maRyCXfBtIGCeUyV/RiiJNr4Wid4aGkNlnWpvKhGva6QEOBL7ErZRA
         h3/H67TYuzudIR5jyi1gzJbF97C6NOw5DzxaG/8CZAb0CUerBZqah59PypA0ZZRB50FU
         WZ/v4rZgarP5jePzNul1CqmB7kzho/W0tahCdVhU2/22zNtdpnzYexzeLMVWLbicm3YY
         abfg==
X-Forwarded-Encrypted: i=1; AJvYcCUXtP83Fn9OuyJfOQRiQgIYsw/ISp8LlAsWY6LEzQM0BmU98jl3nEMbLJYcfDWCCT0UUpWRGie+UY/hycI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAv1Mo+2YsTHtFqEZRPzhNpRCR4b39CHDCmgZ2BOC/T+HXmjzf
	xvvCJN9o/jMzyD3DbCW1yoeP+3GsdNnitPzBVfRE+WX7x/9heesMyTrT
X-Gm-Gg: ASbGnct2DJydJNsb9jX6uXgUaVVB49YMSdRq/HZ2zoDISwyWWklDG3KMIvrcD0HC4UZ
	xrM0v8RWZsWNH2xA8hZmG+xfModLKLNYA5DsCCdoazcXeJHNH5gvgYjNGXvaK67vRxNMI4WPU7k
	ivZCyZqqeZxtTU6f8Ud40N8j3ATSn6+zi217x2JjXJWDbVC1G/gOTziChc97p3TwDYVLNrZpd2i
	rm3BXOnaLCruAh0LDNXIiTEfI/ClBR3Mlg6+dvEvihYgMABHyQ80ENsfBj+FF5UNhCOyD+PKN4i
	F0OYNMvQXNKCqFsfWkcvwARd/UYGqtaJqSd2ED7CztvwDJ3lYwvgbz++fNdnbsx3kvRPoqJJURh
	SA+ESfq13FtWHSbX6mU5SvHmv077ezURszHlcNtfuk8a9VIGT79Q9vkhwmQ==
X-Google-Smtp-Source: AGHT+IFy9e7Y+/3SbtDW/asZcyygm87uuiMiZExwIokWjMs3W5ZFuROkIGjwyYGhm6DkItSwVFqgEw==
X-Received: by 2002:a05:6a00:2289:b0:772:823b:78b5 with SMTP id d2e1a72fcca58-77612091336mr6531461b3a.8.1757744443383;
        Fri, 12 Sep 2025 23:20:43 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7762088ab63sm1669689b3a.69.2025.09.12.23.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 23:20:42 -0700 (PDT)
Date: Sat, 13 Sep 2025 15:20:41 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Matthew Wood <thepacketgeek@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Mario Limonciello <superm1@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [RESEND PATCH v7 1/1] PCI/sysfs: Expose PCIe device serial number
Message-ID: <20250913062041.GB1992308@rocinante>
References: <20250821232239.599523-1-thepacketgeek@gmail.com>
 <20250821232239.599523-2-thepacketgeek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821232239.599523-2-thepacketgeek@gmail.com>

Hello,

> @@ -1749,10 +1767,13 @@ static umode_t pcie_dev_attrs_are_visible(struct kobject *kobj,
>  	struct device *dev = kobj_to_dev(kobj);
>  	struct pci_dev *pdev = to_pci_dev(dev);
>  
> -	if (pci_is_pcie(pdev))
> -		return a->mode;
> +	if (!pci_is_pcie(pdev))
> +		return 0;
>  
> -	return 0;
> +	if (a == &dev_attr_serial_number.attr && !pci_get_dsn(pdev))
> +		return 0;
> +
> +	return a->mode;

It would be fine to have this sysfs attribute present all the time, and
simply return error when the serial number is not available.  Not sure if
hiding it adds a lot of value.  This is how some of the existing attributes
currently behave.

But it does add extra code to pcie_dev_attrs_are_visible() where it is now
a special case, somewhat.

Thank you,

	Krzysztof


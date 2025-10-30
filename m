Return-Path: <linux-kernel+bounces-878817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60123C21879
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3785D1A6808F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3770A36B986;
	Thu, 30 Oct 2025 17:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="KeQETYzR"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85593368F4F
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761846057; cv=none; b=NHmpkV9NWblLKjJkVMKz11QhtFMrNFHbOxOsWFCIDcKlrPA22stEJI5rUtZFsAUIvulXHlEPgbMDcCQM4TN2nCvqqpabILfEvtVF4pjo1AwjnsCBvftKSoQlGGI6iBhA07wSe8UpxMAzoPLnE6f8+nDxX2b8x4zdCwE41Owrixg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761846057; c=relaxed/simple;
	bh=m/ntmb/Nr5XTaAoFpnI3XGWj4UVbw7mUq1L0Jecd/Yc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XuRhCEao9TkbSJmlTwP3fPXQ/2APmsRbPumJnQu8Bt8ZNOCFNigk1qfCzE4+m5v5Wh1rYrTSC1YQkC81Oj0rsD+HwhuBm6LnRW5IRmlPa+rHkXyBNNokJlHuC38RZdFE+B/4LRPQ8kv7WcQVjyDu2/QXWjHDUFl5h5YZe6blzAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=KeQETYzR; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-940f8a73275so140019739f.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761846054; x=1762450854; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/22pqQ5hwp4Fzi994om9q5KGyGnCNdWdbuYVMsnFBOM=;
        b=KeQETYzRUj/5F25ISREZW79vifauKna9hMNIBP8Pud3YRglQxMs8o8vEwONSJFZwVw
         OHdQjZ1Ne+i0p+7BKavxShwvwGqTyor4DByWO4iDIpN9ONz6vfxbdAzcO7fZsqfdj3SW
         t89/1kMGSBY+H35j6UV+K0MAqY0gn+hvQTNOVFKY3pE6swZLiFiq90hlhctzGKv/Gzs7
         plvQuaKgXuNtnK3WzeO8t/YCcEnUzc4S5mc6mm32OXLSGN4r4tQHXsVZ5fNDr8+3+NGX
         oIOgd0HO8cl8H0dfBgXhciDTGJIzxQSnjo+aJSJoXByUJcf6wXDbgrCQNuPV61u0zeNj
         vHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761846054; x=1762450854;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/22pqQ5hwp4Fzi994om9q5KGyGnCNdWdbuYVMsnFBOM=;
        b=OK9S1iBL6FZF53wPZaqRTqq33oG3/6D71ix2KWnrMxQ1IIulNy/WSzCJ8ECROmzCKC
         oxK/NHok77ftmqNGZPeOzdQ/Ih+JSlIK6UsygkJnljf7/Gs9EPQp2kP/jIqkzNbIt6U7
         vuPSHtjNNDSB596HlZ9v0Ro/dyqCh0tNlT4KMSyhEukd9lSbXHVQZ+yLYbpIMzSec+tN
         5BNEBSmXQYKPXEZmP+Uf+wHK8Sp7oYyJbVPqVvDVXRWa9B5p606OhlcInS9ppl/GB6ti
         deemHJAp6/Fpn1HJ4BM03BguFIBj4PX41ALBvEOotDSIK4oTxvfw+vUpcwGFyanKp68f
         Xpqg==
X-Forwarded-Encrypted: i=1; AJvYcCWvNjq7rJBqNqfJXaB8dHpYGGINR6K+YFqXK46nqT8y4Namyuz5Wy8AFvg4BqCVu+94r95WlG7QFFFpjCc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7LLWzBGc/EuUzF4HBV5QabrNw9nC0uodhrh5htZEa5wfe6dtB
	7EN7ncZwB4faOFcqMa6pvLycWjg+YuqA9WoDQjQth+rrDELf26iYVcMyuu22x15zFn4=
X-Gm-Gg: ASbGncv5Czxy24d1V/i3rkFJYm4jGPjtI+2UTZiaeKosFaf/3CvGMEr7IQHLsf0b5/r
	B3we+PiSi+ORET33k4xx+h9omRB29zJm/uvnJ+dnAPEKPJe4CUAnbiMkowQYEF/BhQsIMjsbXkL
	4/W+UTVovIMVXetMuU+xXhNEqxCuq3ciWFCUVcparVwcXAZ17YCCzVbnVot26jaw5d+Bnh4yLpm
	uKFXYMy0jXSNqonauQwFQ+MwW9GRt8F3Bj5HTSdNkEFsQmO0y7/2NHgEDs0QZvvn5A0qMjFTt+J
	G8YiOSKW52FAu7Blu7a9/yoeM3fgJ+JY709ru9KUNCi1HE7jca1XxbyYaXK+bQulTQu78q0JTJZ
	PjTeDRz7kPb/bXbn93ssJbxAJdO0C2aqMhY6L6CxNd5UCmriurApD7jf4Ok0zqeml6qXSaN5wg8
	4HhqZaU0m/Hz3bC1gLAnZzYF6z/Ii7Lxe9qWXmjfxG
X-Google-Smtp-Source: AGHT+IG0aVGPP4r/NKWIuJVfbyDvqDCX0k5Xe21gfoqAbmkB04rb+6Q12tuONUjEXsT6ELB2rdCzfA==
X-Received: by 2002:a05:6e02:1a28:b0:432:fbe2:35f2 with SMTP id e9e14a558f8ab-4330d125b9dmr9455495ab.4.1761846054513;
        Thu, 30 Oct 2025 10:40:54 -0700 (PDT)
Received: from [172.22.22.234] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4330a6ffddesm2802175ab.27.2025.10.30.10.40.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 10:40:53 -0700 (PDT)
Message-ID: <43333e1f-dcc2-4691-9551-3c35ba04bf7b@riscstar.com>
Date: Thu, 30 Oct 2025 12:40:52 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: dwc: Warn if the MSI ctrl doesn't have an associated
 platform IRQ in DT
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org
Cc: robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251030171346.5129-1-manivannan.sadhasivam@oss.qualcomm.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20251030171346.5129-1-manivannan.sadhasivam@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/25 12:13 PM, Manivannan Sadhasivam wrote:
> The internal MSI controller in DWC IPs supports multiple MSI ctrls, each
> capable of receiving 32 MSI vectors per ctrl. And each MSI ctrl requires a
> dedicated MSI platform IRQ in devicetree to function. Otherwise, MSIs won't
> be received from the endpoints.
> 
> Currently, dw_pcie_msi_host_init() only registers the IRQ handler if the
> MSI ctrl has the associated MSI platform IRQ in DT. But it doesn't warn if
> the IRQ is not available. This may cause developers/users to believe that
> the platform supports MSI vectors from all MSI ctrls, but it doesn't.
> 
> This discrepancy can happen due to two reasons:
> 
> 1. Controller driver incorrectly set the dw_pcie_rp::num_vectors field.
> 2. DT missed specifying the MSI IRQs
> 
> To catch these, add a warning so that the above mentioned discrepancies
> could be reported and fixed accordingly.
> 
> Fixes: db388348acff ("PCI: dwc: Convert struct pcie_port.msi_irq to an array")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>


Reviewed-by: Alex Elder <elder@riscstar.com>
Tested-by: Alex Elder <elder@riscstar.com>


> ---
>   drivers/pci/controller/dwc/pcie-designware-host.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 20c9333bcb1c..f163f5b6ad3d 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -357,6 +357,8 @@ int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
>   		if (pp->msi_irq[ctrl] > 0)
>   			irq_set_chained_handler_and_data(pp->msi_irq[ctrl],
>   						    dw_chained_msi_isr, pp);
> +		else
> +			dev_warn(dev, "MSI ctrl %d doesn't have platform IRQ in DT", ctrl);
>   	}
>   
>   	/*



Return-Path: <linux-kernel+bounces-877234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 963BCC1D82D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 22:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47386401467
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 21:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217272D2391;
	Wed, 29 Oct 2025 21:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="UpZPb28H"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E98420C00C
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 21:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761774564; cv=none; b=G/+NGUmNMuvZSh1jnr/7pz0NVzU9xUQfaptjT+M0Sno+p8GhFnwVqPgbhr+tkgKWq+AopI2fzxDyooCNS3QQyic44RkzSK/ei49fspVsRLcCNORoYGUF0gkqHSsydEC7Bb5RDpNXfcu6N0kQfzG9QISsOIO3PWRGgXbGGsQuHyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761774564; c=relaxed/simple;
	bh=4y9V70WFBvxyqJjplO9V+cIfxz5Th6UpWFken6ZSSjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klVNTNFnpzG9Cn+FHCB3lyeq95UkEJhLYd91NrgAKewnmI3O2TQY9B950+mUSyBL0k5aCLD0+b+hyqn5VVBgrLhTLaoJNph31cg1/XpVqMZMT9VfW+TA68OeKywIW053jpfoE3GdwXhcy7kcsMHHnwoHAsLxIaxuAtSMcCp0ME4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=UpZPb28H; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-87c103928ffso4719616d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1761774561; x=1762379361; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rE1JyEMJ3v3jXraVaSIO/rQxseox2pYjQmRppVzrLvc=;
        b=UpZPb28H4f4dICsWtZ1LtUhJ+DoPAHLiDJIcEEkYOGZ528pFDB92iDL5Radi75VKvE
         m6At3BfLyakLSd4yM3n3tMZntsQIjT3X06GCqIrOxG+EDXHC0Aey1DrhjvfzTsER+YDV
         veu3YI2H+o25YXQFAUZ9u7D+XCj5wA+VRT+0pFn+RqJK8LARvLT2WStG8fQ426z0UWre
         vq42+qKqNCYntIZtm6Mfcs1yT4Up5wM7Awcbge5DdDihkdKC1xPHI6MF85qg1pIOeiAa
         CnffT7aYM9tUhPcVA9A9wqiQQ6JdRUrFRODnKOm6BuwWtav2e3GLdeiFT+VPansqYo8g
         wbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761774561; x=1762379361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rE1JyEMJ3v3jXraVaSIO/rQxseox2pYjQmRppVzrLvc=;
        b=aKbhAui8Uoz1MPxF5lxCuUk7KQBGAmZeu6s71PeI1XkTjvUf5Af3HNHFx7qS/Ry92y
         vrJaQX0++pz6XQpWDgsAST9fxbA2Mhlag542dEb1ZlgH2Pg2YDO+14xTWoIwcIGGpEzV
         h35o6+F4vEJ8d4tiF81B9jIj7WrNnljoXdTl2zSn6wHB5cT5ebgslWdKxMYcfAWS+34u
         1p3xmjh/LQ0M9f592Zt7KhxdV6dARf5Q/a++/841JQWbOZD5aoyNdSc0odK66VxF4Ks5
         vWl9x1YEEvu8RWHmNR8fIV9lh3YDydQhKLEr/hvkBK5gLST2GLhiw1U36f48VzYan6lz
         8v1A==
X-Gm-Message-State: AOJu0YyYHKwlEmvYRFbh8ANvOKXsKN/zYedec044WX7R3J7F3S16d6FR
	D2yRGCret31nusmrxxPJuR3QeSdHJR0tiOpqNvWI4TmeBnBghP1gm9rxYY7WMA0KYA==
X-Gm-Gg: ASbGncvBEtX/pp8ITHFOF2whxpfwMPXzb7exl+lECEVw1JUgE8m9vh6ceyRRU6MOJAD
	W4JLPVp1kAB3URfy6qbxbhEJx317rhSemdlDDDYct0PGZ4bkcQArWlp5PmaHdyr0Wq6Q8fW+WhK
	iS5cb9MkLJStNpjeQJckmQ+YeEEisRGBDBvAGz5dHvR/9JFcuTnI6gDfb/oy4ksc6smr/wp0obW
	ZxHWJGwj52dWXQP9uTfUYz8yHA8W1d4Frh0ndbX+G2z029pB2VNz1CL5eHHLI+VLeYFUo+QgqRm
	yp7yIkbCSUBzkeR7kYTAzRthTUQnA5aoPHs39SOhvsRDolsNLVnLvglKfbT4F9eereovJComH42
	VNtRTfk7kUUHlSHIJqVsAm8nTck/gUNvR4WE0kTw9842FFfi+dI9hkc/eW3lckRyu8oP8GtqE28
	L8hQ==
X-Google-Smtp-Source: AGHT+IEia63DWtt3sJ/hE8wQB6V+RWNyg4QYX5RQRa/XSY65kZ2z6hDGlDeovmsAIVmEGP2Uj0ltIw==
X-Received: by 2002:a05:6214:29e2:b0:87c:2ba1:16b4 with SMTP id 6a1803df08f44-8801b2113camr15045546d6.46.1761774561522;
        Wed, 29 Oct 2025 14:49:21 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d03:1700::ba76])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc4944a84sm108980116d6.36.2025.10.29.14.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 14:49:20 -0700 (PDT)
Date: Wed, 29 Oct 2025 17:49:17 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Desnes Nunes <desnesn@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: storage: Fix memory leak in USB bulk transport
Message-ID: <2ecf4eac-8a8b-4aef-a307-5217726ea3d4@rowland.harvard.edu>
References: <20251029191414.410442-1-desnesn@redhat.com>
 <20251029191414.410442-2-desnesn@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029191414.410442-2-desnesn@redhat.com>

On Wed, Oct 29, 2025 at 04:14:13PM -0300, Desnes Nunes wrote:
> A kernel memory leak was identified by the 'ioctl_sg01' test from Linux
> Test Project (LTP). The following bytes were maily observed: 0x53425355.
> 
> When USB storage devices incorrectly skip the data phase with status data,
> the code extracts/validates the CSW from the sg buffer, but fails to clear
> it afterwards. This leaves status protocol data in srb's transfer buffer,
> such as the US_BULK_CS_SIGN 'USBS' signature observed here. Thus, this
> leads to USB protocols leaks to user space through SCSI generic (/dev/sg*)
> interfaces, such as the one seen here when the LTP test requested 512 KiB.
> 
> Fix the leak by zeroing the CSW data in srb's transfer buffer immediately
> after the validation of devices that skip data phase.
> 
> Note: Differently from CVE-2018-1000204, which fixed a big leak by zero-
> ing pages at allocation time, this leak occurs after allocation, when USB
> protocol data is written to already-allocated sg pages.
> 
> Fixes: a45b599ad808 ("scsi: sg: allocate with __GFP_ZERO in sg_build_indirect()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Desnes Nunes <desnesn@redhat.com>
> ---
>  drivers/usb/storage/transport.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/usb/storage/transport.c b/drivers/usb/storage/transport.c
> index 1aa1bd26c81f..8e9f6459e197 100644
> --- a/drivers/usb/storage/transport.c
> +++ b/drivers/usb/storage/transport.c
> @@ -1200,7 +1200,17 @@ int usb_stor_Bulk_transport(struct scsi_cmnd *srb, struct us_data *us)
>  						US_BULK_CS_WRAP_LEN &&
>  					bcs->Signature ==
>  						cpu_to_le32(US_BULK_CS_SIGN)) {
> +				unsigned char buf[US_BULK_CS_WRAP_LEN];

You don't have to define another buffer here.  bcs is still available
and it is exactly the right size.

Alan Stern

> +
> +				sg = NULL;
> +				offset = 0;
> +				memset(buf, 0, US_BULK_CS_WRAP_LEN);
>  				usb_stor_dbg(us, "Device skipped data phase\n");
> +
> +				if (usb_stor_access_xfer_buf(buf, US_BULK_CS_WRAP_LEN, srb,
> +						&sg, &offset, TO_XFER_BUF) != US_BULK_CS_WRAP_LEN)
> +					usb_stor_dbg(us, "Failed to clear CSW data\n");
> +
>  				scsi_set_resid(srb, transfer_length);
>  				goto skipped_data_phase;
>  			}
> -- 
> 2.51.0
> 


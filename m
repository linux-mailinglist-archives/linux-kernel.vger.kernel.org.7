Return-Path: <linux-kernel+bounces-880348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 121FAC2590E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5AC134F64CF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B54B34B667;
	Fri, 31 Oct 2025 14:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="EPfpt8ex"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1FF2222A9
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761920722; cv=none; b=rGyJ3ht01Nv40lAJgZQsXyjAYDI4/79jtQTGjOObyRFZDFZui8lFJFVLBXLu4hCMqoz+2wgGQHPsj6Bcvn1slim6d/RTZvWN38QWG4G5kElNk/Eg0sYwmeTyXYf6D6U3lQbOjG711Jz2Lyup5q6JOZaGsUOH2s8jXj9HnU/Q/FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761920722; c=relaxed/simple;
	bh=5L76j+zuXHG1MHBpIZXuVQSIaQJX7GuLY5HJ6kmV/ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dkq15k9Mx79czP5cVHTd62UWh7vDi3a7Jdw8hlyY6k8fR9xgvqKNiXpEvMN6Bzml32nbc+T9s7H+JOcvKAgIQCFySynHyYZXbSvNwDqxhcJhjBz4fHOYnu9WcJEweBeDoGPoWv0csboELeruVIjc9IIgEc4YX5c82wPu3uBH6WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=EPfpt8ex; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-795be3a3644so14234826d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1761920720; x=1762525520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ts+XWgu1bIuF9gioKC8vzQc4NBdSlbXvz8mnrqcOtY8=;
        b=EPfpt8exaA/Bhwi+BUdvTAlmpUbJNWpxf13J70ussVRTkwzUSuj+1n/zGwt8YGhjmj
         eNdL3kPy3nlqfaiBoNTm24NYPOBFnvFaSvd79NbEaBx2e0Ax/U5Wi5qX9mjPgOyVGEme
         jSZR6TGqoE7FbFn9bJZSKg8y/KHK3usCLA9OPk4RXLRlDTdQXAvGH5QZwYOh1rm8s5Wo
         QAj//C1royiSJqNdmQ5iok5QLakMTPBpw2Vqart/aM+f0rpPFdIxe4EGBdrCzDv+evs5
         ylAHDydDoJ3bLy9mo3Wg+SR5M+gfv43tBzpRjG2KP5bVWiLshZBOVUtgbF+3fKvLkO9e
         pHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761920720; x=1762525520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ts+XWgu1bIuF9gioKC8vzQc4NBdSlbXvz8mnrqcOtY8=;
        b=wvLkl3sSHmpXS5+Z3jUabtlNZikUiQT0aOz78P0pOiZplKVoMFfmi0BXSmVpDshcUT
         Is15ymVZom+HQPIlDrv+dno/Dp5hfPaqiXMXBjTdRGtAe9SeYTaUh3Rz01JR9U2eT8Ro
         QEoOvpcVLb3YB1A9jr7xGMvt+b0JeRbO/tP14ah5IQ/83XeSd6/v5r+Wm3PUM/l+9h0W
         gzbDaF9k88D9m/4w1Z32c61wUzAwIul/ZSwWa5agdgNFpRqCq+ipr4PncXdyBuqW7fAR
         0baFtIu95wLmTgY4wdxKstltgn+HjxFbC/KHsbmjhmdK2Dc2aE8L8x9GyxfnRDuthiyr
         zGdQ==
X-Gm-Message-State: AOJu0Yws73Rfgaa8VgVE1Bh4XypOJqcFSSi7n1gsKiC+s5wvz8EwUemN
	yLHuzwu8WmWFATV6rc5tZOzqiHG3uD/pWDapiF22RK7BbN5On1iZLcim76DmSS246nUKYnjOTAs
	AxIE=
X-Gm-Gg: ASbGnctcdSllqqj8kNwJjZ9pZnoF1ZxESeSpIrDv4BVTCiCHJgJP4/x7KCN8ax+Qs3w
	6xPdrZaKClb29747xqkSWI4y0du1GNIMiK4UV5TdPiwBJ/TqaZ0zXskuyIC16OM2B0jJ4T/RGoS
	AwB9tLjse8lkD1oYSLyVLKyvLcog+8bQcgXqGWRsXfjSrx0C8Xe/NmkTaPDsPMTouIUw1vz79Fa
	UeobmgYeNfjf3sBkhCCif3Xj/1VUMCpa9dVhpwyRQ3dnVoLVy1VZo1Qnt1rlI9pgcWm6acjmxCw
	koWmCL25dpzb9PRhhkc/r9mBIOTX6YZUGMvwaNy0PhGqV01VPYVlxFGQJq/4/FYKViGPKuv+Hft
	RWLuD6fogSjZaQFv1YLoDGBqwlFEpHyVr6NzBri3x9nnICa72fjb/bZLsHDRvs/qg9hMdmua0Rw
	bp5EDdlX5qLYDj
X-Google-Smtp-Source: AGHT+IF6emX81maeXlXvNR7Q+/JX5uqsOM8FgN5qPjqjUpWdjdqPZE4LA+SysAtKbX+FH1pFta/gMw==
X-Received: by 2002:a05:6214:29c5:b0:87f:9f18:49ba with SMTP id 6a1803df08f44-8802f2746d3mr38802496d6.13.1761920719781;
        Fri, 31 Oct 2025 07:25:19 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d03:1700::db9a])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88036070868sm12264306d6.24.2025.10.31.07.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 07:25:19 -0700 (PDT)
Date: Fri, 31 Oct 2025 10:25:16 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Desnes Nunes <desnesn@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] usb: storage: Fix memory leak in USB bulk transport
Message-ID: <697fe35e-a3c2-47e2-891b-c25861c95dfb@rowland.harvard.edu>
References: <20251031043436.55929-1-desnesn@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031043436.55929-1-desnesn@redhat.com>

On Fri, Oct 31, 2025 at 01:34:36AM -0300, Desnes Nunes wrote:
> A kernel memory leak was identified by the 'ioctl_sg01' test from Linux
> Test Project (LTP). The following bytes were mainly observed: 0x53425355.
> 
> When USB storage devices incorrectly skip the data phase with status data,
> the code extracts/validates the CSW from the sg buffer, but fails to clear
> it afterwards. This leaves status protocol data in srb's transfer buffer,
> such as the US_BULK_CS_SIGN 'USBS' signature observed here. Thus, this can
> lead to USB protocols leaks to user space through SCSI generic (/dev/sg*)
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

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>

> V2->V3: Changed memset to use sizeof(buf) and added a comment about the leak
> V1->V2: Used the same code style found on usb_stor_Bulk_transport()
> 
>  drivers/usb/storage/transport.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/usb/storage/transport.c b/drivers/usb/storage/transport.c
> index 1aa1bd26c81f..9a4bf86e7b6a 100644
> --- a/drivers/usb/storage/transport.c
> +++ b/drivers/usb/storage/transport.c
> @@ -1200,7 +1200,23 @@ int usb_stor_Bulk_transport(struct scsi_cmnd *srb, struct us_data *us)
>  						US_BULK_CS_WRAP_LEN &&
>  					bcs->Signature ==
>  						cpu_to_le32(US_BULK_CS_SIGN)) {
> +				unsigned char buf[US_BULK_CS_WRAP_LEN];
> +
>  				usb_stor_dbg(us, "Device skipped data phase\n");
> +
> +				/*
> +				 * Devices skipping data phase might leave CSW data in srb's
> +				 * transfer buffer. Zero it to prevent USB protocol leakage.
> +				 */
> +				sg = NULL;
> +				offset = 0;
> +				memset(buf, 0, sizeof(buf));
> +				if (usb_stor_access_xfer_buf(buf,
> +						US_BULK_CS_WRAP_LEN, srb, &sg,
> +						&offset, TO_XFER_BUF) !=
> +							US_BULK_CS_WRAP_LEN)
> +					usb_stor_dbg(us, "Failed to clear CSW data\n");
> +
>  				scsi_set_resid(srb, transfer_length);
>  				goto skipped_data_phase;
>  			}
> -- 
> 2.51.0
> 


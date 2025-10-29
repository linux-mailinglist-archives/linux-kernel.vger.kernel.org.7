Return-Path: <linux-kernel+bounces-877238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF94C1D86F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 22:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E75EC424719
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 21:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1B52F5467;
	Wed, 29 Oct 2025 21:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="o9cQesmw"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3BA2EBB84
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 21:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761774871; cv=none; b=UZ6pk542uTs2pW62PhRDgxTkP7gfwH9tCHrR3zWP+FP0O9zaNL66Oh+YEfeZbHw5kBGEncwrIc27JmCSp8/2aj6N3wktuqU48Y2FOWMBgjMT5yA8US+PiKHTyNo1goQVBGQD5UwwqO1iIqnDhGJmFJST45YQ3ssHfNObdhaKgq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761774871; c=relaxed/simple;
	bh=cIwGmoG6KP+sY1YSTmMMxTqL53Jo8SKq/654DLCBB+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rRObLWW6fv3puxZY1Gh1JpO7wCB3K2txEYS6fRGS0XPEJMo62SOSHgDi20nHhs0DZCsDRlvPPr2ca4tkkcjfRlg1RqSA5WFd0Y+nCdpFFMWHgvufryzkNakbRWMF9x81pZUjECKgyEbNMNJ/ots18GO/UZbna9wyMq4lMQdOf14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=o9cQesmw; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8a2eb837c91so25081485a.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1761774869; x=1762379669; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lau32vXxFs5By0zcyxNZ3NthUAuasdtB8eW1riZ0p7g=;
        b=o9cQesmwplCNn52/m3jiDMjyLi4L2bfgHH1dL19oak5IKT307Lhqu4CE8yBlWc/auZ
         dsjNUyjrBN/AxrhXBpBYqDRE4EipC/r7/d9QQfQuy8jmSwEWVslo10gHIcjULuA7WhFq
         955ZmpbVdaDKw+6xR42FqtZfwDvHBdsVxa5qRVytwdU+75ClmRj3SK7rMKM5B2/r5gRv
         Uz1bdcVDbDdgFf7mPSXdbdwjRWRkoejz4fAMV1qrOCTy0+RKhWuu9/w7NgjzHoKmOkJ7
         CtdBIBarjPsISp1+KVbNSZKqkJcvlEmGSHoUENZwnZPOUrS1XNraZ6oZJMYVYjwMMPlD
         wBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761774869; x=1762379669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lau32vXxFs5By0zcyxNZ3NthUAuasdtB8eW1riZ0p7g=;
        b=S2dlll5t0nh76lWPd/drFtF4yntJ0AwL6lgBKfCFscSkSzycDhPtnUyNcj6YYAOKky
         /O6XPthwdJ2Z4RwGpFljJYwZ6MYvJsUmBrxZZuIoh0we4RacHJi4lwySg/aLaGfb5LVk
         PCZYJcFpYnZHSKtyOR220hZS/V6TLHOJ29jfgjESu5Evp5urbc1Ej2LbZ4Y8SlQl6ZR8
         RvafCfxu40oQ3IZFUBp80k/A47kNrvNudZ5G+rOiEqCxaGslESVAw79I9oiL7uOnPzWO
         bGsglHY89TDVUJe/wcoR6CPpbgsNyHvoU3k/ItpGyeT/3DHGnlTaEZnS8dHFU3ZQFFFp
         bqPg==
X-Gm-Message-State: AOJu0YzXmbdblSKz8k3pGsUtl69XtBCOJFFOflt1RTqaeqEEMrvwExCj
	I2SIw0rSC58ILZksusPvNeNYMOJo7QIXRIowYybOxHL/a1PibH7HvLP0qElHEzIFkw==
X-Gm-Gg: ASbGncta4Tt72OKIqFmmS77ByicDqe+I82GAIW3xKeWId25/Y510unuFjL9es3qG9fb
	SPINp1+ypONuCZuzJuC1wtRrR2GIsf/2F8Oi5uYlpOy2Xu5tz15SEQ5EB4nrTmlTroLaofzChc/
	jYhcP09b5/sqlAN48KI4pQPT8UoL6PWHlZRA4VBwPhEdq5IfuH0OUeyN8QdeQEXkjjKpSgy3bUO
	lNlNGcpJTlF4sD1DzMKIqIPSRFu4mX6Ka+89HyU4Ied5cCoqF44s9bDVBJwiRwULqBZU3u92wID
	IiPfAvi2mVO1Xms6J2Yn61xt66aPXOr8S3TCCXkH/Uum7FlEIsDkCgN3f9AJRi9fY29i7ksJ34u
	oD55eMTQ2tidmx+ALidtdMladpBRQdgTvtu5b6sAi9gjBOnwPWA3r5agOQ9GJ8TIB98mU+UEENp
	f7DtO2z4dLSAxn
X-Google-Smtp-Source: AGHT+IFhpGghbcCzXrdXqfDNrNwYDxBhx91ExXwPj2DoT8qHmF03AdvGiT0F44YF42NAfT9ELHtvoQ==
X-Received: by 2002:a05:620a:31aa:b0:892:63c8:2861 with SMTP id af79cd13be357-8a8edcffa9bmr699189085a.40.1761774868744;
        Wed, 29 Oct 2025 14:54:28 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d03:1700::ba76])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f25e8685fsm1135234785a.50.2025.10.29.14.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 14:54:28 -0700 (PDT)
Date: Wed, 29 Oct 2025 17:54:25 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Desnes Nunes <desnesn@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH 2/2] usb: storage: rearrange triple nested CSW data phase
 check
Message-ID: <27c07b90-f4ef-462b-8b6d-46afd4301912@rowland.harvard.edu>
References: <20251029191414.410442-1-desnesn@redhat.com>
 <20251029191414.410442-3-desnesn@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029191414.410442-3-desnesn@redhat.com>

On Wed, Oct 29, 2025 at 04:14:14PM -0300, Desnes Nunes wrote:
> This rearranges the triple nested CSW data phase if clause, in order to
> make usb_stor_Bulk_transport() code more readlable. No functional change.
> 
> Signed-off-by: Desnes Nunes <desnesn@redhat.com>
> ---
>  drivers/usb/storage/transport.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/usb/storage/transport.c b/drivers/usb/storage/transport.c
> index 96b81cf6adc7..3f2e1df5ad1e 100644
> --- a/drivers/usb/storage/transport.c
> +++ b/drivers/usb/storage/transport.c
> @@ -1188,18 +1188,17 @@ int usb_stor_Bulk_transport(struct scsi_cmnd *srb, struct us_data *us)
>  		 * check whether it really is a CSW.
>  		 */
>  		if (result == USB_STOR_XFER_SHORT &&
> -				srb->sc_data_direction == DMA_FROM_DEVICE &&
> -				transfer_length - scsi_get_resid(srb) ==
> -					US_BULK_CS_WRAP_LEN) {
> +		    srb->sc_data_direction == DMA_FROM_DEVICE &&
> +		    transfer_length - scsi_get_resid(srb) == US_BULK_CS_WRAP_LEN) {

This change has nothing to do with the subject of the patch.  Please 
leave the code the way it was.

>  			struct scatterlist *sg = NULL;
> -			unsigned int offset = 0;
> -
> -			if (usb_stor_access_xfer_buf((unsigned char *) bcs,
> -					US_BULK_CS_WRAP_LEN, srb, &sg,
> -					&offset, FROM_XFER_BUF) ==
> -						US_BULK_CS_WRAP_LEN &&
> -					bcs->Signature ==
> -						cpu_to_le32(US_BULK_CS_SIGN)) {
> +			unsigned int offset = 0, buflen = 0;

It seems silly to initialize buflen to 0 when the very next statement is 
going to overwrite that value.

Also, "buflen" is not a good name for this variable, because the 
variable does not contain the length of a buffer.  Rather, it will 
contain the amount of data that got transferred by the 
usb_stor_access_xfer_buf() routine.  The following "if" statement then 
tests whether that amount is equal to the buffer length.

Alan Stern

> +
> +			buflen = usb_stor_access_xfer_buf((unsigned char *) bcs,
> +						US_BULK_CS_WRAP_LEN, srb, &sg,
> +						&offset, FROM_XFER_BUF);
> +
> +			if (buflen == US_BULK_CS_WRAP_LEN &&
> +			    bcs->Signature == cpu_to_le32(US_BULK_CS_SIGN)) {
>  				unsigned char buf[US_BULK_CS_WRAP_LEN];
>  
>  				sg = NULL;
> -- 
> 2.50.1
> 


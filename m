Return-Path: <linux-kernel+bounces-728282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5118EB025DC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 22:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A37E24A6E81
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF81220F4F;
	Fri, 11 Jul 2025 20:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ESyTlqpD"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC85200BA1
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 20:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752266446; cv=none; b=gWOTG3RyuTkzO5nc2ViD15gRAgM1YONjnO2foVPlkAdRdaF7Y/efHgAMfS2+cRxJBPKD5eK4mZRbO+UXf3tnMhhy8xbt7xNx1TYwXhh5iidE6ORn/Wa0yw8Mq4vbbb5svqx6+XYJq4isgjjEazNLNN0ovvsBPkZe3uFc00eFIM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752266446; c=relaxed/simple;
	bh=BUef1P1w0/U+Kyukr4lZGxc0gpaZoyw21Z7BU8ALwws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OUefkPcTx7/VFYQxJ+OlRph1gRLadqL0wMVoOboPzDC83Z2j+p9n25+SpHyd1/oLpTLSCa66Ni4fTJlIzKSY0mBwoTtT830/NJsIw6E9OjYDkzyZUU5m4hVl+CI2UsWZxQJzHnrgLk96FB05uaMLKyPIyaj7rweLYZmRzyiSijY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ESyTlqpD; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-748f5a4a423so1668891b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 13:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752266444; x=1752871244; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hOyN7zjdU8EtRk4awPMVtS0gWU07X0lbhTs0rtFKa1A=;
        b=ESyTlqpDMV6JobMmbJcx654Q9FDrhC4xVwh5xHskTeKl2w7TMmyST1NnIt8H3az6iv
         7K5ikw6nqqJk5Z328cZtDKUZOE5iW9TCGsdnmO7jCdJ1jEFx8zrQAtl1m6fsELHKC3X9
         R5hdTZQ0sj1ofTT0Aj++7ZIaz89ru8A7ktzv+Rr9xicHqy3mx10k+2eqBHDelM/BALJP
         uut25y1iz8s8cpBrzhGYR2VPWDJcvBY5cisD86h3dieBOmBXmh+Edtqo5nxkb25guAsF
         rmriS46DNcclykZ1T1ZK7YEiRnCGDTz6J8L3CgkpXQx344e5WOsvlwR5qAsn/Xa/A9Zo
         yfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752266444; x=1752871244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hOyN7zjdU8EtRk4awPMVtS0gWU07X0lbhTs0rtFKa1A=;
        b=mGHp0/ObswhPZ4z904AO2k9pMJI+H0O4QXd7o5B7PEFuWgx0O7hlKq5ZNRlosVRstt
         oLCAyXGnowSDb/h4pmbIhR+xhZ2ZmoJJiZ+OYMP7HrtU7BScUT+2jqZHq1rBADTIetAA
         QFjnUCFU1s1AJm7yHPXIfDhzVLU6B5jWr7z/5Oyr12VFKEolJ3HETqTHwRMk64XRabkD
         N4NZ+rsWKmd+p8GZWhsHg8KmTRdjm13dDE4NUA5Eq66R8mVflyJMeWbtkNZRYorMgnFL
         z1LRdorzBcoQdiUhQkNWj8wfRjjgU+s2YL0GFDVMGMdSaA6WBhdPJWfd1F1fdPfmLGYC
         gIBA==
X-Forwarded-Encrypted: i=1; AJvYcCUJ12v+DsSWZMQ5ttJeDJ8zwNeaox2B7PhWkZvP/2Mf7cFm41ibFhBKs57cnA6NtbfYaTtqeZpJgNzVlpI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4XBVuTIWITiERfkSpBtCeCuGsdjAuszMBpJW4iZekbZCyqScj
	oWy27naQrmS1Rfu62Ktzf41EyMNfmhl6s4CoSc2Mh9zWKIU7XZKTX3MSCQhsUZozaA==
X-Gm-Gg: ASbGnctQ/WLfG1GT01ZQbfRt8URUZEw0gZ/e816/uxfIYoEDgD3/DrLyrypSaVolpRW
	HDU9eKNPMbcwqCtpTYAVwqiJtHs0xf8hDqxcMbH03ZEOi2lUlY8b9mggWJT3VVrx9x7qBfUSmHr
	E/xyvhKtCGuDuRDKv9Ne0bANi+iIejXYz3xtwSFRJlSZRrOceg3NcCu2IiGLTlxY9xqLzcqDrn3
	ij9auxibFygu75/AVrMofkQdBSV5ZCzzHtEBi1vj7k3HJmISDTVll4jR2f2c+GkEMbr64QdQOs8
	UWuulMUcMJo+mpb3J3iqz2OlCWuhPDyj10JfIl8QOvk8vGbw5XmbE/we4ueVrKBFqSKkofkeveJ
	RH9wdOr8TPWsE66rh/RSkRZ3fXfzP07uIrHzVhmAQNQ7R1sQDSfPOg2UtDj1K
X-Google-Smtp-Source: AGHT+IGKwyEiWIvNN5ljOOt5rhXv44UIeUvI/e+ufFqX9vvMzpakBy8GcdBfL2xk6ruLl+tI0VvWdA==
X-Received: by 2002:a05:6a21:69c:b0:204:4573:d855 with SMTP id adf61e73a8af0-23134a6a3c2mr6222085637.9.1752266443600;
        Fri, 11 Jul 2025 13:40:43 -0700 (PDT)
Received: from google.com (236.219.125.34.bc.googleusercontent.com. [34.125.219.236])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe72912asm5645201a12.71.2025.07.11.13.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 13:40:42 -0700 (PDT)
Date: Fri, 11 Jul 2025 20:40:38 +0000
From: Benson Leung <bleung@google.com>
To: Jameson Thies <jthies@google.com>
Cc: abhishekpandit@chromium.org, ukaszb@chromium.org, bleung@chromium.org,
	heikki.krogerus@linux.intel.com, akuchynski@chromium.org,
	mattedavis@google.com, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: ucsi: Add poll_cci operation to
 cros_ec_ucsi
Message-ID: <aHF2xpf5LMTm1B8Q@google.com>
References: <20250711202033.2201305-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711202033.2201305-1-jthies@google.com>

On Fri, Jul 11, 2025 at 08:20:33PM +0000, Jameson Thies wrote:
> cros_ec_ucsi fails to allocate a UCSI instance in it's probe function
> because it does not define all operations checked by ucsi_create.
> Update cros_ec_ucsi operations to use the same function for read_cci
> and poll_cci.
> 
> Signed-off-by: Jameson Thies <jthies@google.com>

Reviewed-by: Benson Leung <bleung@chromium.org>

> ---
>  drivers/usb/typec/ucsi/cros_ec_ucsi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/typec/ucsi/cros_ec_ucsi.c b/drivers/usb/typec/ucsi/cros_ec_ucsi.c
> index 4ec1c6d22310..eed2a7d0ebc6 100644
> --- a/drivers/usb/typec/ucsi/cros_ec_ucsi.c
> +++ b/drivers/usb/typec/ucsi/cros_ec_ucsi.c
> @@ -137,6 +137,7 @@ static int cros_ucsi_sync_control(struct ucsi *ucsi, u64 cmd, u32 *cci,
>  static const struct ucsi_operations cros_ucsi_ops = {
>  	.read_version = cros_ucsi_read_version,
>  	.read_cci = cros_ucsi_read_cci,
> +	.poll_cci = cros_ucsi_read_cci,
>  	.read_message_in = cros_ucsi_read_message_in,
>  	.async_control = cros_ucsi_async_control,
>  	.sync_control = cros_ucsi_sync_control,
> 
> base-commit: b4b4dbfa96dea8e299a47ef877eb0cfe210a7291
> -- 
> 2.50.0.727.gbf7dc18ff4-goog
> 


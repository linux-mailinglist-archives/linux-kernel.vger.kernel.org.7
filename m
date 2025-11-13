Return-Path: <linux-kernel+bounces-899963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AD56DC5925D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1837C34A547
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B34BE49;
	Thu, 13 Nov 2025 17:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tkuf4I92"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0A729C327
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 17:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763054314; cv=none; b=Fou/itEbkfr51iv4lKYkDLIUX3LETq5IHIhNbA1tsIRhPDsi9nZwJWU1Mv/UoJZSttjUDHSbJ3ZK3OKPYIzd0CEiFeYvYcOVnpLErdbIKgzTQ9OcjOhMiMnP5Whxad8646b1O++4+Yz9E4xhy6Fems1VCOLOayGASBI0pjkzbj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763054314; c=relaxed/simple;
	bh=SnVL18vcQZUAN6xgjrn+FRb1WIhCgUpcajyf8u1AR0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nUcQdT/nR6asxPUjyc2kju3xnjmq5pShHXo6CM605RTj8dwKWpx38IRZugEPPI2B0xIqRX261o13W9fl8xDr0c6ZKiu5E2YpLl9C3aaJJM7nlu8u3YoPqcs0pc2KEK82Nn8BDK1PtujVbie9wtwvXA6hmtZmilxIsvh9+7J3Cbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tkuf4I92; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2953ad5517dso12714765ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763054312; x=1763659112; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CLU6yk0Yztb2/O+GWzRwbmOA/G7sPQL4gwZtot3K55k=;
        b=Tkuf4I92HP+RgME0wfOYC/Ueh4Iv6RUfYTXbfsprXS/g0OKDuV80A7sJ90v8dYarbp
         gwPEfgXi9GEGXzWMsyI2hAHj33vH4tt49wtjCegW5pu8tmdexI580lXG+FiTIqRB+Jrj
         X16SSuAylnMKTgee0PYigdUZw3YbIkCts3dVHhxZHiVvPHOkd7mRy3WHwdpQfYon/sKd
         FKqli8I6D04A2lbZA2IjtS8cR4G6ZbcFZa/vazXQXPQRXHTioX2ectwoAnxISFsUbgEG
         gBgCeYhrGTLqo5252Rj69Z05WvTdhbGPOr3Be4M3UENFdn86P6PCCYL+bcewSc+7Dgg/
         8evQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763054312; x=1763659112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CLU6yk0Yztb2/O+GWzRwbmOA/G7sPQL4gwZtot3K55k=;
        b=WPe9n2/gJkrtYwr4ZRvx5HY8kP4wVxXcfhV0Hm/qJE34cxFenlApCNwxicMrtxJ5h1
         kv7vgpCGma/Ki303rhjWCvUsbWvyYO7iAjo8Bt8OgeMcvV728pkNO5UUt7tCrJb8Y4W+
         w67O4Vowk/MLpqWT51aNCyFx/J/arD+rUWkwq0LAYNiDIGFqR20+2aqlT8hp6nPa8Ag9
         IWbOeLkBxKxF+LM9BCwOkCX0LvAHAOyQigdAyC9zDPhpLag196ZXet2vGulA+B0d/rq1
         aCoHAZySBjWkbLifqVIsH930kCpsiWj+KdTyXF57SyyIB0dsoap9S3w8Y6MiKvNgnGR6
         mpBQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6s4kwezkss4qTm0Fs7xoL1gCY829JBgOuZzgPrqafVCSqhLZQ9MkkjTytNrfgnUl5s9IYtnH83f87B/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxxhJ9g5TL5l66CiDULY5Thnirta3zjVwzNSvAjwnr1tATQyDl
	ziH/FAaf5H8TErTL5/bbF7s8M2wfCUqJKF/M/6GMyDEJPYM6O8CX4YlH
X-Gm-Gg: ASbGncsub1dIkbjkyCltsLWgC9GPpAciZLwTwqNgoqxCSDxAS/A4l6SwtWPY2vXjRPD
	ZyNpn4tnFqG41iDawXuEsWGnSZA1s6Up3tW/jNDuwknjX6CAIjaHP+vc9KZAX+6Bu75XiFz2331
	wF+fHNkwh/Sd7Qkp7atedn+ourCzZd0F1FE5Boh3XhTLinbgJ8cZaA67A+6t9lnXGcin1rfPdFL
	p+7L96RPm5dF1Y1JLmKbN5geVSZWfsMAv+4kkXn9DTZgpfowWbQVXAlhy0Nc/wmAtZolLprTZGt
	Sv8BwStFj4IqakmaNqSceoJm6CtkEf7Td4Unrszy9eOGmhYFhopa8cmyIXm3Pnj/d2i7gcd5tuV
	Dhg9jbQXzaYLlCLIg9LXUsweCYkVy0uZrC800AEwaXajnrZXCDUTaOX0dK3Rk+pJHDhvANgHLzf
	Xrk+xq5brN+ZV8zG28v91LbIk=
X-Google-Smtp-Source: AGHT+IEotKYkYq6nQaDTYNyp8wTjepFyxltQYF4u8CLaKcnh2+F8uXTp+00cxCEmCtT4klCHOp8owQ==
X-Received: by 2002:a17:902:e807:b0:25c:8745:4a58 with SMTP id d9443c01a7336-2984ed7a011mr103510485ad.3.1763054311942;
        Thu, 13 Nov 2025 09:18:31 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b0bf0sm31722695ad.71.2025.11.13.09.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 09:18:31 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 13 Nov 2025 09:18:30 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Wenliang Yan <wenliang202407@163.com>
Cc: Jean Delvare <jdelvare@suse.com>, christophe.jaillet@wanadoo.fr,
	conor+dt@kernel.org, corbet@lwn.net, devicetree@vger.kernel.org,
	krzk+dt@kernel.org, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, robh@kernel.org
Subject: Re: [PATCH 7/8] hwmon:(ina3221)Support read/write functions for
 'power' attribute
Message-ID: <79da1c83-0529-48cb-a20d-23512f68397e@roeck-us.net>
References: <20251111080546.32421-1-wenliang202407@163.com>
 <20251111080546.32421-8-wenliang202407@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111080546.32421-8-wenliang202407@163.com>

On Tue, Nov 11, 2025 at 03:05:45AM -0500, Wenliang Yan wrote:
> SQ52210 adds power attribute to report power data, and implements
> read/write functions for this purpose.
> 
> Signed-off-by: Wenliang Yan <wenliang202407@163.com>
> ---
>  drivers/hwmon/ina3221.c | 79 ++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 75 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
> index abb6049c8eab..ea01687ad1fa 100644
> --- a/drivers/hwmon/ina3221.c
> +++ b/drivers/hwmon/ina3221.c
> @@ -348,19 +348,16 @@ static const u8 ina3221_in_reg[] = {
>  	INA3221_SHUNT3,
>  	INA3221_SHUNT_SUM,
>  };
> -
>  static const u8 alert_limit_reg[] = {
>  	SQ52210_ALERT_LIMIT1,
>  	SQ52210_ALERT_LIMIT2,
>  	SQ52210_ALERT_LIMIT3,
>  };
> -
>  static const u8 alert_flag[] = {
>  	F_AFF1,
>  	F_AFF2,
>  	F_AFF3,
>  };
> -

Please refrain from making such cosmetic changes.

Guenter


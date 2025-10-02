Return-Path: <linux-kernel+bounces-840819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B56BB57E7
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 23:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 780CE19E7966
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 21:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28AE3BB44;
	Thu,  2 Oct 2025 21:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkmelcSG"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA861E4AB
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 21:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759441109; cv=none; b=NGlBkty6zgpX7tGABsP5c2ZcxuS3KdZb2IpnL3WPnQVU5ouDIvWWaXbIZ681q158drjIUoN9oDxsqfMGCmDirzcg+f4DgF8rNTsyYCi7hbzCLaWeel9qepPru0S8YbycA9nEOy3cD0LA8bTtZ+GGvi23YYXdqLH8L8LhQjZPNfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759441109; c=relaxed/simple;
	bh=9dF0uJ3ISA22smG2brOHKcN/I7pK9c344S34aWAoh5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=reR+JwoCiYyY9h9nF2qLflDIdqiSIzgEGtkWN/Ub7sX9OsQe+9TOYrNx6GBNE5KvVn2cTKvgRN3xkiF8xuc1ejh0k6740Uk+4vVDcENuqgy4D9GvGh571k5kDPEmYlWZuTPaJ/8VKFdgRanwj5xGGEghWJg7b5yesEyr3tQtORc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AkmelcSG; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7833765433cso2139655b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 14:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759441107; x=1760045907; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DIgw2TUDYPujfob1ItVYazOFg+arl5pUESpq99Cor8Y=;
        b=AkmelcSGRu3932uTOYGDJEADP0HTBJOxNAfPgccn2+o6RdZ8YtVXo0CDAzlZ14Xvc2
         XZRbfX1YLFNG48memWUdjuYGcp/m2hKt5GytLNmIE+6OWaYfNcFLNHYPNsbWCCrHkX1q
         7criSdxCPrOUEp7L+0htUYmfrPb12WwUa9VBwMNXYCvfZDOUCaHI+PC5DTVgl4A0tap+
         jsqTkFS+UlSVvD9QVgyoHlbVKTvKrP5u4xlqqJ+DoGjrgvRZPrkwtTfgrTjOa/WTpVv7
         MIO2+lX9rwFJR9N1iNveYowQDWut6JvP9PUIOcxvCzkKtqEstcQrKk8PXjDm0/Jhokrc
         2sxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759441107; x=1760045907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIgw2TUDYPujfob1ItVYazOFg+arl5pUESpq99Cor8Y=;
        b=KPL41QwlfPYfcS7ykx6SKnYFQubyCRKhJzC0iRRxcCgiWhcKELMVA2sWDFBylOEwZ9
         Glg2lR5swEQmwIidqQVPFvZaQD3KRUtEDEzpAev24Z1q2I9vCORhF4gwyBxMBxdKsFW7
         gGtq7hwd7zE3pAsoiJxa2W6U/ojSsv4HIw1HOj7ALjJr/xpMwHcBFhxK61eCTB4N7t4C
         fk33duMBlnNxVUleNMWiTQOlTfX+TXAi6g/BBjRi07ri6VXxhAhPK/5NmrJisnOmDH/9
         SB0OkMxz+p4TTPtUusKmNpSWRrXv137h53bpUQtPt4zsfoWoCYywlTGDWj/iXvCO1x5g
         FuVw==
X-Forwarded-Encrypted: i=1; AJvYcCUDmdi5ApJ1f0IKsfAPIJDpw/LbVDcsuGKo3C+pGC8W4dHJq2mY5ghg7LBytdfAH61p5/zrYUIo+LDZKTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxzQaDmC2InwJ4X7H7O/bNO/Plqob4Cmed2XSIPLcO+SeExWA4
	gkgMupCoKRtG3JPaKmQK68MT8DOj6//E5uHb9x8H8GIlWkIhEnc7uP69
X-Gm-Gg: ASbGncvLdZIkgM9HQkUL4rTH/3cv4vvm07Rf4sG4knlJyc8rfKFj+vp5cAem6r+0sRf
	IyMi1QQtZzAb3TpTU1t8xYVrIdxCNyYPDvqnHuTM+GlK14uHwMpzVBVcMS2a530vKCDaCYA84OI
	2EO/YKli2gO40ddNhovbEH8peDCP2VJ1NxdZiiLDw41viJiYWrD/IWEylNnHBuCOyueVUqXZxJf
	1U8v31eoeXmeANGeOXPB/I1QdeRj6WWqvoG6u3QY45o/sxYyiT5h7j0tBotoSPItDcKNroeAvf1
	y9cVNIatdZp3KR3IrrcxJmqFUcWjETpqVA0OKR20JLaN+zVck2JQAlXgIj5k4xGxMUK8b8QYwl+
	rrXYU/s9tmya9nL3XGPoBTLpjACQOt+7L6kQa4PBZbJIqX9rvVRdm2u/T1v0=
X-Google-Smtp-Source: AGHT+IHKI+feEMtSNCRgXeWWSvyIHg/eMcVz9KANAAoF8cg8/wBIuazCOx9v2nwjg3cKvHoW9MEgFg==
X-Received: by 2002:a05:6a20:12c9:b0:263:1c48:912f with SMTP id adf61e73a8af0-32b61dfb34emr1222197637.12.1759441107306;
        Thu, 02 Oct 2025 14:38:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b02074549sm3020231b3a.76.2025.10.02.14.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 14:38:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 2 Oct 2025 14:38:26 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Eddie James <eajames@linux.ibm.com>
Cc: linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, andrew@codeconstruct.com.au, joel@jms.id.au,
	chanh@os.amperecomputing.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org
Subject: Re: [PATCH v7 RESEND 5/7] dt-bindings: hwmon: max31790: Use
 addressed fan nodes
Message-ID: <c7c23305-d53a-40e1-a783-9ea8598c96d0@roeck-us.net>
References: <20251001144441.310950-1-eajames@linux.ibm.com>
 <20251001144441.310950-6-eajames@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001144441.310950-6-eajames@linux.ibm.com>

On Wed, Oct 01, 2025 at 09:44:39AM -0500, Eddie James wrote:
> Since fan properties can include reg, the fan controller should be
> able to specify address-cells and size-cells properties and use
> an addressed fan child node.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Applied.

Thanks,
Guenter


Return-Path: <linux-kernel+bounces-894536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3424C4B423
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 03:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56B5418934E9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 02:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3917734A77A;
	Tue, 11 Nov 2025 02:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="hR7NSD1U"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7870834A766
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 02:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762829775; cv=none; b=IsiWkoA0ny+heSe+klkeJc2yfvsGowWNSEyy7WN3drkwth7IHo/APGAT0M6ERgSZt/5SxxBIss61iGRuhz0Qee2d9GagWrM4pnlP+1uQuDbWbHQJ/vP4Zs/Z8PgOh2uDkxqaFAd/hQpMZ64TT4xi4GrqgKOaVBjlLVIwCCQX43Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762829775; c=relaxed/simple;
	bh=fa+jvPPey51O3Idw/pKSiJ24tekTBIwnDg80v2iIydc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQC/vsb4KE1F0LM3oAIAxM4cTg9kjZ7JTx6smZVOfzx94wzzbo5pJ2w26Ax4Pc1b32okKNNzntyib1fywYYy1YP9mN8BWrKRIuo1YGBF31l0Tfl1BGB7lDTyOUKrcRNvVzvMDfsULc/X58474NmG+/kL+QHqL/mfd2iOMKNruYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=hR7NSD1U; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8b22a30986fso365928185a.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 18:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1762829772; x=1763434572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B0Mv6RGbUEpA365vvsW0RrdXBUD+tvy3Sz5bzo1J/PQ=;
        b=hR7NSD1UYBtIzGOygHUdl/7yCA0FhAnuFF/5uNxGoWrkbSqMZk8pbI5Z2Li5EywEW+
         XRupfci7mKqT/x/guuIukpazWX5JO6twKTwM+4AhjRPQ+lXKXyB/l1V1fKzrWTQMnAcH
         zqBkz3/+d2noC6UnQuhj+nIHlahVlASu6alJ1cAUuVWiUhn1pwF6Z4oFt70h1Ey8LKrx
         gOsfqyRrdB+46tz9UeKxQ7WZnTD7a2PDxHuuPjy96CrUd6aK+4kBtoRA6copb2pcPEKM
         yUj/EO3/cpUa5AgVUzgozNcMsbHhAHj9g2sqm6U/jW1dnJhKWVs1IqqoMW5WlURPCFYa
         yvTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762829772; x=1763434572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B0Mv6RGbUEpA365vvsW0RrdXBUD+tvy3Sz5bzo1J/PQ=;
        b=tBTgEa8CzGQr1diPFIfNhP6HtTnhVlTHA/qjdshX8Iw02krk+7nKRExktCSrAx9CGv
         gYLHyoE6MO8en5jb+D/FKPEgQQCuTrls9UVEZ3HTlwhOMyajQFyho/NJHeeF0voJZCsa
         WPbAmRjqnScJP3+3OzYq3Nm7uOLk7az9lGsJzpnYUPq7dH6rW/PaDJT+gkvPaGznejSc
         uBcx1DB/NMUHPuVcui5soheziP+VuHwpnsRx1RAJ6pER+l3d9fcejtSBW0wwxrFqYEjf
         YoVpBRX/zMW8QUHFbEX15qvuVe7QEIP0A3MhlF06LZCBxOTitNy7bORM+gsNs91CNg/3
         3d6g==
X-Forwarded-Encrypted: i=1; AJvYcCVHCH902+JUqsByaEgolJkTi2BvBMUuKqtFvxKweXB97gtm539C4iSXJMbYpEAcfvPNIpOmxYvx/Dr/BS4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy9wQ116aYdcbrRfqFBizE3VgnPk08GVRuJ9/+7iM2DLZkHjy1
	N7t5vMxNQP0u0hLVIBnWFipThNp5h4JK3pYoJxBIdfGV1YN7VhOgTlnYQ4oFPRClGQ==
X-Gm-Gg: ASbGncu5MzF7l/hCbcrHIouVP0sWWdokUVq89W+otUUwhv4zJPf5qdOpalZr0j6kiLX
	6zo82ahj3kCJ2wGqFLYJo0KTp/00yfPiG6W8qP4UdsYh3droRKep2tTOUWQUgTJBrdUL2dcRyzt
	maLL6UniJwUJRnjyHhFDV0z8A5PR0myD6HRKHAQeSLbVpGKBEJbnMQXDYpVacUa/S3iG1GEVMe/
	zojo4JEkXgs4T/kFc3ikAPs2G/CMr/JoPXZmOynJKQthjA1YO9kTinKPKBJ0o1mAxZWC9Qxiwvy
	LH7b9+HIRPTiCqcj3Zhlv8t93YY0DGi9GFG5Bw5lK99bejyD4j75hpa8F88JNE/UNMMrA/ZpQl9
	g6++zg2witRYn4dXtXkfMRSJRHf7iaY+iIXCewCQh18aPcqRkFd94B7vFisduCDL8181kqKus83
	zi4xh290R68SqLd+psUDRmxdE=
X-Google-Smtp-Source: AGHT+IE/rMh/OADA7qnVKS0msIcdxyIvvi8cRxBf0f6eX5Qe3v4BCpdfpo1D+HiI4+SYhoxmBsxt1w==
X-Received: by 2002:a05:620a:4416:b0:8b1:f2cd:76ba with SMTP id af79cd13be357-8b257eddfbfmr1354362085a.1.1762829772221;
        Mon, 10 Nov 2025 18:56:12 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d03:1700::ba76])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b235826d4fsm1125896085a.50.2025.11.10.18.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 18:56:11 -0800 (PST)
Date: Mon, 10 Nov 2025 21:56:08 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: ccc194101@163.com
Cc: benjamin.tissoires@redhat.com, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org,
	Chen Changcheng <chenchangcheng@kylinos.cn>
Subject: Re: [usb-storage] [PATCH v2] usb: usb-storage: No additional quirks
 need to be added to the ECD819-SU3 optical drive.
Message-ID: <7cfc5d3f-6e08-4557-855f-605c079d27ca@rowland.harvard.edu>
References: <20251111012737.13662-1-ccc194101@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111012737.13662-1-ccc194101@163.com>

On Tue, Nov 11, 2025 at 09:27:37AM +0800, ccc194101@163.com wrote:
> From: Chen Changcheng <chenchangcheng@kylinos.cn>
> 
> The optical drive of ECD819-SU3 has the same vid and pid as INIC-3069,
> as follows:
> T:  Bus=02 Lev=02 Prnt=02 Port=01 Cnt=01 Dev#=  3 Spd=5000 MxCh= 0
> D:  Ver= 3.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 9 #Cfgs=  1
> P:  Vendor=13fd ProdID=3940 Rev= 3.10
> S:  Manufacturer=HL-DT-ST
> S:  Product= DVD+-RW GT80N
> S:  SerialNumber=423349524E4E38303338323439202020
> C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=144mA
> I:* If#= 0 Alt= 0 #EPs= 2 Cls=08(stor.) Sub=02 Prot=50 Driver=usb-storage
> E:  Ad=83(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=0a(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> 
> This will result in the optical drive device also adding
> the quirks of US_FL_NO_ATA_1X. When performing an erase operation,
> it will fail, and the reason for the failure is as follows:
> [  388.967742] sr 5:0:0:0: [sr0] tag#0 Send: scmd 0x00000000d20c33a7
> [  388.967742] sr 5:0:0:0: [sr0] tag#0 CDB: ATA command pass through(12)/Blank a1 11 00 00 00 00 00 00 00 00 00 00
> [  388.967773] sr 5:0:0:0: [sr0] tag#0 Done: SUCCESS Result: hostbyte=DID_TARGET_FAILURE driverbyte=DRIVER_OK cmd_age=0s
> [  388.967773] sr 5:0:0:0: [sr0] tag#0 CDB: ATA command pass through(12)/Blank a1 11 00 00 00 00 00 00 00 00 00 00
> [  388.967803] sr 5:0:0:0: [sr0] tag#0 Sense Key : Illegal Request [current]
> [  388.967803] sr 5:0:0:0: [sr0] tag#0 Add. Sense: Invalid field in cdb
> [  388.967803] sr 5:0:0:0: [sr0] tag#0 scsi host busy 1 failed 0
> [  388.967803] sr 5:0:0:0: Notifying upper driver of completion (result 8100002)
> [  388.967834] sr 5:0:0:0: [sr0] tag#0 0 sectors total, 0 bytes done.
> 
> Signed-off-by: Chen Changcheng <chenchangcheng@kylinos.cn>
> ---

Your patch description should mention the fact that the bcdDevice range 
for the existing unusual_uas.h entry is too broad, and so the patch 
restricts it to cover just the value of the ECD819-SU3 that was reported 
originally.  Otherwise readers won't understand where the 0x0209 values 
came from.

Alan Stern

>  drivers/usb/storage/unusual_uas.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/storage/unusual_uas.h b/drivers/usb/storage/unusual_uas.h
> index 1477e31d7763..352e9d7324a4 100644
> --- a/drivers/usb/storage/unusual_uas.h
> +++ b/drivers/usb/storage/unusual_uas.h
> @@ -98,7 +98,7 @@ UNUSUAL_DEV(0x125f, 0xa94a, 0x0160, 0x0160,
>  		US_FL_NO_ATA_1X),
>  
>  /* Reported-by: Benjamin Tissoires <benjamin.tissoires@redhat.com> */
> -UNUSUAL_DEV(0x13fd, 0x3940, 0x0000, 0x9999,
> +UNUSUAL_DEV(0x13fd, 0x3940, 0x0209, 0x0209,
>  		"Initio Corporation",
>  		"INIC-3069",
>  		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
> 
> base-commit: e9a6fb0bcdd7609be6969112f3fbfcce3b1d4a7c
> -- 
> 2.25.1
> 
> -- 
> You received this message because you are subscribed to the Google Groups "USB Mass Storage on Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to usb-storage+unsubscribe@lists.one-eyed-alien.net.
> To view this discussion visit https://groups.google.com/a/lists.one-eyed-alien.net/d/msgid/usb-storage/20251111012737.13662-1-ccc194101%40163.com.


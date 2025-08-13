Return-Path: <linux-kernel+bounces-767326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18575B252E4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 20:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 898251C83C6B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A047429B8D0;
	Wed, 13 Aug 2025 18:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="JrTh/BEB"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E40D1DD9AC
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 18:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755109178; cv=none; b=Z9enuPpC2hkgmZSc1cZiXYUsX8EiwDcqlXQ/QHthDtNjIon8AccCBg87NUcZGkB13+jRGTrQeDs5CftQ/e44pZml5Z+fVv0LYYI5i4Vmc8QQhO4xqMCX+uOGRoe42VvmLW9vi0yxfVdXldwYTFMOU5iw8u931UFV9PfmzHLhT/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755109178; c=relaxed/simple;
	bh=iD0th0JPT9XvS0OT+NlKvnds6lV5srAjhD+Ek1vOBmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8h8/i2f+CDjImxhntbSxxDuwx37vKmP2cX9ESigYENR/YwIOspG5mQ7ufJYbCEuV6d+MwvBdbPhs03ywnLNIHkx3lY69FAvprcSHl8RHxDIbzspFadkOzdl6YGgXooR5Q/3ZrtOZTeQM2OrOY0a/Dtm4RAs39aHK2mF9Nq3LK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=JrTh/BEB; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-70a9f15f15fso2048016d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 11:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1755109174; x=1755713974; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+EddfMazfmOOVzuGouJhvs/WQquMhL7Ov9e7tsnnf4w=;
        b=JrTh/BEBe+eiHnrv7LLDsDJb2uoDcogn6bVEFOZkiLtamoLTC4zqya6aCxRXxo2CeK
         fuvffVTHyrY4WmMib4X1WlXPTDkJ6/LgdQexz9JGXT+rR+n7r+Vu5RriCTX75oCU5DiI
         uVhSxEYaPH76f7RDrzpa5PYVweAuIfOm4LAy6C3cbK+/Qb5ydDNdPfCHupjhoGgv0UT5
         zIcr2rBw9S6Uxmp2AkXq0qVvo2bMk0dSjPZEKnuLWBVOzW6AqKRheeCCNlhu2dTKt5cB
         Ix77ohwiseXno+Ja2ctGi4YU3Lr8c/6GRl18hbUU4Z9uz/JdCRqRCe41eJzMm5Mzo5Q+
         UPTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755109174; x=1755713974;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+EddfMazfmOOVzuGouJhvs/WQquMhL7Ov9e7tsnnf4w=;
        b=l7qGk0rkTDxrBNmPChwPc/68EmUoyuZj3aHJgK268IzEmLXzHq0J/o4+N3jy1QmNS3
         uCeIkalZqUD4lcCkuahyNROzv5uRwlfft/P3cDwNc+6aVJtWUbAesag9mzAsOJM/xSVX
         V+199rFDXiRAe2G6rqiPPEq0KvaspD6cY+VS8jOf61Xy3gvaTBCbfe/h3ZKBd+whkuHR
         c8T1pHP1+QXm2lyFVxTxPHZoObPeLCOFuI4oOFcYI5BdPWo9LvXDQ5yn6MpAUzdbxO2w
         k5CP38JqL67GYcYtlCuO1yLyGdpFnQ0BMdZIgeDrCoS2GQJ32NbSrEhRj1XfLnTTJcBC
         GXiw==
X-Forwarded-Encrypted: i=1; AJvYcCUUsG3MmkheY3NmoAZdVmd4GI8b5Asj5Ubq+aLojI+DloiSDx1gZej4cZesjEiT9Bsais7cFKl06hihtaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaUTR5sUeM3LfXSUjlODeCWx1lmp068lrPQoC1dZbx0zjBEJDG
	VBaqqGo43+NLwpkkDNOamSFwAMmO1hA2PLFCuiM+CnBM++1RBZ9QYIZ+6HjQ0NDPhQ==
X-Gm-Gg: ASbGncugbx/dQEyC4V8795EeT+f0ku35f9c1wK44jxu7mt43AMwlBTDPzxuj1TETo47
	KevaZRJS+pOTRdZIh1tn68VB0ImHM1WsKIxxk5NJc+LXgBb5B16xBZzVZHyY2DvIdmOkA7clC4z
	j2K5/Y9g0VLVhlLvUM1i0q/Yx+/Ng0pe52KVnfAjfbVLzM3XlBxq8pfqtmBNDMRSZMglfybPnIa
	XL2a99AqnX0pX9GKDgRsogCPrxn2vXgCNJgGMK00VSftPX4XF9Eir0zaTXTUyV7JCHEf7tGgS93
	aqzZpW1cpfa1A62e5jcaaoQ8RfwB/ZxfAm8v2+uZr2Ysg0XqChcruHTKgLrQ8CDYU85gka97LVx
	Yyb1yQ/zSjPSvyj5SujLfN1FTMK2h77H/rBHbU/725Dtn+JFCmUonIFc0N+1m8yWqzg==
X-Google-Smtp-Source: AGHT+IHKYi8hdhJJIgu/bCYBOlGTkEfmfhsKUWy4uhRFa7m1jaX30iy/xegLNRbs2iwR0T2ioiWIeA==
X-Received: by 2002:a05:6214:2307:b0:707:6c5:55ad with SMTP id 6a1803df08f44-70af5c0002emr4387246d6.12.1755109174206;
        Wed, 13 Aug 2025 11:19:34 -0700 (PDT)
Received: from rowland.harvard.edu ([2607:fb60:1011:2006:349c:f507:d5eb:5d9e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70af5c1df31sm1233556d6.81.2025.08.13.11.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 11:19:33 -0700 (PDT)
Date: Wed, 13 Aug 2025 14:19:30 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Zenm Chen <zenmchen@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, pkshih@realtek.com,
	rtl8821cerfe2@gmail.com, stable@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net, usbwifi2024@gmail.com
Subject: Re: [usb-storage] Re: [PATCH] USB: storage: Ignore driver CD mode
 for Realtek multi-mode Wi-Fi dongles
Message-ID: <03d4c721-f96d-4ace-b01e-c7adef150209@rowland.harvard.edu>
References: <ff043574-e479-4a56-86a4-feaa35877d1a@rowland.harvard.edu>
 <20250813175313.2585-1-zenmchen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250813175313.2585-1-zenmchen@gmail.com>

On Thu, Aug 14, 2025 at 01:53:12AM +0800, Zenm Chen wrote:
> Alan Stern <stern@rowland.harvard.edu> 於 2025年8月14日 週四 上午12:58寫道：
> >
> > On Thu, Aug 14, 2025 at 12:24:15AM +0800, Zenm Chen wrote:
> > > Many Realtek USB Wi-Fi dongles released in recent years have two modes:
> > > one is driver CD mode which has Windows driver onboard, another one is
> > > Wi-Fi mode. Add the US_FL_IGNORE_DEVICE quirk for these multi-mode devices.
> > > Otherwise, usb_modeswitch may fail to switch them to Wi-Fi mode.
> >
> > There are several other entries like this already in the unusual_devs.h
> > file.  But I wonder if we really still need them.  Shouldn't the
> > usb_modeswitch program be smart enough by now to know how to handle
> > these things?
> 
> Hi Alan,
> 
> Thanks for your review and reply.
> 
> Without this patch applied, usb_modeswitch cannot switch my Mercury MW310UH
> into Wi-Fi mode [1].

Don't post a link to a video; it's not very helpful.  Instead, copy the 
output from the usb_modeswitch program and include it in an email 
message.

> I also ran into a similar problem like [2] with D-Link
> AX9U, so I believe this patch is needed.

Maybe it is and maybe not.  It depends on where the underlying problem 
is.  If the problem is in the device then yes, the patch probably is 
needed.  But if the problem is in usb_modeswitch then the patch probably 
is not needed.

> > In theory, someone might want to access the Windows driver on the
> > emulated CD.  With this quirk, they wouldn't be able to.
> >
> 
> Actually an emulated CD doesn't appear when I insert these 2 Wi-Fi dongles into
> my Linux PC, so users cannot access that Windows driver even if this patch is not 
> applied.

What does happen when you insert the WiFi dongle?  That is, what 
messages appear in the dmesg log?

Also, can you collect a usbmon trace showing what happens when the 
dongle is plugged in?

Alan Stern


Return-Path: <linux-kernel+bounces-821096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B668B80565
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1495545D98
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E7333B49F;
	Wed, 17 Sep 2025 14:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="iyOk5hTd"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4AD33B47E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 14:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758121049; cv=none; b=am6jfMKmARBQNesvr+TQvu3pJB46sbxBypVQCXyG4ucGR654ypE1qicq7lXMidbFu0ggsFcXyyE6wU9ct9dLLZBT2ij6bCr4vKLk1Eb3eN1jni6v0YKYZAVvESJudOQo+3tmQz6l90jNpRHEQ9G4w6F71w8liHOinelS9oEOb+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758121049; c=relaxed/simple;
	bh=9OJQZq6bHCOGv02hQ9NPzIP7qKBnKi5yAR5CrQuWy6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRVB9PY6jcEdmAeeP3HAHYARwpfm9sjTUOLPnNyLtUGnu17GC3cqaRpDsqXR4+u2/6mMruyoRldqz6A/Pzd8UWId7GaliU3SPvUsbSJtGT1Rv3giP/rGPkmqm2oTu8jxCU71+SQnW3G7FzOinVFmxPBwOv6NpWp6pD5n9iKw2CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=iyOk5hTd; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8127215a4c6so101695485a.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 07:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1758121046; x=1758725846; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W8HN1UTZvELIwcpsDbtiuDd2WLyYOA0zppT13Ez3H28=;
        b=iyOk5hTd0RGR9IJYHKGcrhnycmh/4ftPLUaqp3uwYYz6uA9kAqIbgGODrL6+WBffg0
         ASlqAudM790xLRDtuWWVwGyscKIBeOCecYaxuipegTHgeE3O2ZwrmDYwfAcZmOhtrYQs
         gfKdsmskHqq3krQtsNfAaxiEd3Hyp41ZR6lsxwJBmigCoKmRuSdQChvKcyJjfMq4K4WV
         hK30HKK/+ZfvEEt4CWApkQQB5nEMOCD3uJYt57jUsnemEI1SeaoBf8fSVBslYFyb4zJ/
         qKaDohT80/SXOdXnCUU+ZFDXbAaoyRjUz6d3wNqDRh7pDiGVCollGDl+dZzXX1RK185h
         9o8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758121046; x=1758725846;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W8HN1UTZvELIwcpsDbtiuDd2WLyYOA0zppT13Ez3H28=;
        b=e7Swz3VY76PnfiagSgNZlQps/O6oGwVCOa7R98nAgCKWy2P9GsNOlruHTgEWGb3xEU
         30lOBOvw2fKk+PfTPzVVD2zPXdPtl/BFzynzNQ5sTABPC1oWcyR61ytl5mMh1gB6yKHA
         aETj/IdgTPILbHuNvNdf408uUFIRr3c85WGt6rnm3KAQ010pzaPWsMnN/GBL4ovROMfF
         L1rT5zLPn1Ds1HfTuNzxxgP3KJli8O48dJHYGxal7/pVSy4p9HTGJ7xYgazwtLiJzHUl
         yh9u8efrQPpWmi+QOvif1NXUQnL3HRcQ0xV8FnD5Y8rt8UwUkwziua3SZgqLJmgwCyGe
         H2Cw==
X-Forwarded-Encrypted: i=1; AJvYcCX+EvD/JzwDdGmv0uulushDEArn7B1Mz028OR+nkD9yCrPSnTh7P+B18pyCLKPsIMsCnrnBAbk6gxBrcWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOWBDaQAUyzdciHc7GZPa7ct07mfKEmE+cTjmLBkUJzhcp3Gxr
	Yx46bMjEYm/GUvPt5fyTfGwVvMG/ZNZSXNfAyNf7Hvl8tR8ntHNmBQIqif158ZVD3Q==
X-Gm-Gg: ASbGncuLyMcexXJb7ZKS3C/E59JSvpK6Lp3yF3X6rzL1cu89tycnIw5D9WOE1qAy0uk
	4IBR+0wzMP55kPMjgqLV80nZutIz8ijAJD8bWlPofFdmPUhJaSOQlX1XrUDj7bTz/vgOX4bcRkk
	3g+rX3Me2Sd/TbKmyD57eJ1ufgJpW25M6eM/e85qwbBRYyg0Ft3HuHSikyHVZCjiPktFtCA8Y2j
	SCxnmgo22taVMlS42EsgRvWiyQ5FqLEOSi0DtCYEPrN6wSbkOlRunfbuROvFDqB4mqsJyWhzRAt
	MaBR0Zy0ZeYN0dI36NSmkUVYqCmIo6lODhP+5tPqb2prUHOZcGdHy5IYvVT0yBmXh+gjMCvzk6V
	TA8FEg3JG+qfiaX61i5KWnTCFb64RmfDRfebTs+/KZJgZAFTbh6TT3DTuLoRBrfN1GrARxHGkEt
	nWQxthIgNxgZjkUcgFMwsd
X-Google-Smtp-Source: AGHT+IHSha0l2uy8bY+NcvRiDKKxmDF7lfi4/yLSRxZTDI+PO2c2F0E2cv/USSjdeL4NWU7Va2vk2w==
X-Received: by 2002:a05:620a:4713:b0:828:b2ab:a50e with SMTP id af79cd13be357-82b9e38f41bmr799576585a.31.1758121045894;
        Wed, 17 Sep 2025 07:57:25 -0700 (PDT)
Received: from rowland.harvard.edu (nat-65-112-8-24.harvard-secure.wrls.harvard.edu. [65.112.8.24])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-820c974dbbbsm1145829885a.21.2025.09.17.07.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 07:57:25 -0700 (PDT)
Date: Wed, 17 Sep 2025 10:57:23 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Hubert =?utf-8?Q?Wi=C5=9Bniewski?= <hubert.wisniewski.25632@gmail.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>, stable@vger.kernel.org,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
	Russell King <linux@armlinux.org.uk>, Xu Yang <xu.yang_2@nxp.com>,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH net v1 1/1] net: usb: asix: forbid runtime PM to avoid
 PM/MDIO + RTNL deadlock
Message-ID: <ccfd7d48-401b-4f25-ac8e-aa6aa9654956@rowland.harvard.edu>
References: <20250917095457.2103318-1-o.rempel@pengutronix.de>
 <c94af0e9-dc67-432e-a853-e41bfa59e863@rowland.harvard.edu>
 <DCV5CKKQTTMV.GA825CXM0H9F@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DCV5CKKQTTMV.GA825CXM0H9F@gmail.com>

On Wed, Sep 17, 2025 at 04:31:40PM +0200, Hubert Wiśniewski wrote:
> On Wed Sep 17, 2025 at 3:54 PM CEST, Alan Stern wrote:
> > Are you aware that the action of pm_runtime_forbid() can be reversed by 
> > the user (by writing "auto" to the .../power/control sysfs file)?
> 
> I have tested this. With this patch, it seems that writing "auto" to
> power/control has no effect -- power/runtime_status remains "active" and
> the device does not get suspended. But maybe there is a way to force the
> suspension anyway?

I don't know exactly what's going on in your particular case.  However, 
if you read the source code for control_store() in 
drivers/base/power/sysfs.c, you'll see that writing "auto" to the 
attribute file causes the function to call pm_runtime_allow().

If you turn on CONFIG_PM_ADVANCED_DEBUG there will be extra files in the 
.../power/ directory, showing some of the other runtime PM values.  
Perhaps they will help you to figure out what's happening.

Alan Stern


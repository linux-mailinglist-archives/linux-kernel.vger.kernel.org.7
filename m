Return-Path: <linux-kernel+bounces-863721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FD2BF8ED0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B1DC44E7B7C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 21:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF708288C20;
	Tue, 21 Oct 2025 21:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="PDCyzPdo"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E4528505E
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 21:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761081618; cv=none; b=F/38afMtHy7VPu5PyquDGuWvtLuG1EqCBxzsp5iLXnKwyyB8bW2nf77TE5EL/skFOZTLmSAiAQogESX19LNqQMGNKRjvUtnUL9guY0xpAsN9rbjtzq/ZqFKPxJ2wS3t4qkrkZDQfo7B89pw0F/CqLwirABL2Z0gkkfat52ISTeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761081618; c=relaxed/simple;
	bh=d+JgfX7f+chDjmnMm5X4qjo+aMhbpyauVERzrs1GJsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFDEuwJcHauXEeov7zUZAz6AOI8oCqx392OEtv5/sEz3zzrp4ghpRoYDhmILJI9GoMV5+zdW0BS0o2Q8Gg+2PgyQ/+t5zEh6Ul1XvfcuTaoq+0H24iD2jL1dSK0p7876kZTvDrbL5YPkAtw+hd9PxOLgqesREhahM6haArU6NWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=PDCyzPdo; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b6cdd7e5802so32834a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 14:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1761081615; x=1761686415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NKBpLJe6dQK72erPWdp1puVpkmn6KWf/pa47Xj36tzc=;
        b=PDCyzPdoAcpczZytXqY37LK21YrZ/0RQv5XO14ufgTKJzJTcFjVr3LQtK/wSKjqbBb
         OhNeRm1mbniRmP0yWFD71HGWACJEbLT3BfFbPWAvAhIQWl5k/PkymuSEy7LrX0IFuyMJ
         abJRcNhoQyontR+b+VLU6G1KQhIaSiHYZMf217Qm/L+G/5fM9gIV7zq/HJVWef4FVxJw
         UGeQ9mCsEOI6J2wU79H1hDw/nrdth5v5eerEKe21dq4uV9NNPtzjtGt0oVthH5LlyBTu
         K8Km+XTlVkwaosFANyEzmlHCJwTg3+E7zdKd2BsEVz5qBWmSE6mlBdtbxqoPnj2Y0MCF
         U/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761081615; x=1761686415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NKBpLJe6dQK72erPWdp1puVpkmn6KWf/pa47Xj36tzc=;
        b=kigL9uyLMd3bCDaB67pwOSpspZ/6WDTGieA1+CMCq9MP7h6EgbOqkeBAZGRHxCer17
         URiX9ZHoVfGfQRMeRRQ1QYmZbQ5tl9/eQ/CKrKlZzm9h95sHFezd+VwXVAEP9SNYFO0F
         UO+C1cQTnZWNv1EHU0VEuH2J4pzfUX4YDs1BeI51a0lwtqHw1KNfrcP2OMcd1JknGCt0
         4cQOVG247+Hr1kQ02V6rQJZAem6Fdh5jTdew3U7SfPJg24QuJc/1dwxmMoj/nbCOQ6qD
         OQYSQaOa7bt8Osfnut27sFamllI8pkKjcDsPF6YAn0CnBsGdOXKX4wpqUJ4K4rDlPhwd
         oapA==
X-Forwarded-Encrypted: i=1; AJvYcCV3sBfC13gD9XUY80Uh4JmIj3cfEk7OG9fCL2dY2E5qXP8Hp8u//EZPeUBkytGUvFVqy48eT8P6a9VsxyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvLPbXHwpGRzEL0PjagPkMm2H+roGxNBDyf3JqRALa3OA4ui2b
	a711Eqqh5y6eVG6BR+Zu4bIEpqe448nRbaSNl5mGgFmh/hf02As0+uonjswOoS4NSEk=
X-Gm-Gg: ASbGnctNHwjUi02S+4mZ44wyVz5wGsgJypTJ44RdINqujEy3CV5airHYgdfZEQKhDql
	/vwItbh1okC380U6qSJ3hRrvHf2oauZE8cY2crrahw2LIWgwJzh0S8spweNNoybrC0knezoxybP
	2r5QnPLB9SDPXTLMHp366FieV4Kbe19MjlbFlwkFcQUw9WIuzwPbROo/OptEszVoRMjZj3SUz5B
	KdjCbCO+qX2IGPNrRpwGBc1F5B4Rz+8nUwQcnXeh9L5h6h01YZY4izZw1aJOeCpCLwGAFqXUhH+
	3nCspKMqQmPMqVq0STaFNW5Q/Fi5GBtGs9gCrpKQ60gx+QU+WYRqGCrr1+EHAVSRq8YSJiIZEz5
	73G0CbpTGHY1okgStyIp+G7y3j7is2DN49t1i6gUsf2D+KcBgCFizGa/JYYE/7pOdrQq4zECinL
	313Q==
X-Google-Smtp-Source: AGHT+IF7SOcnQpWdfQ59cqPsx+uS0pX16PxatoEuSqjtpKrk7k2OwEb2NGWnYl5hAvgls3IoLhSOIw==
X-Received: by 2002:a17:902:d587:b0:269:8fa3:c227 with SMTP id d9443c01a7336-290c9c8a5f1mr191001155ad.8.1761081615550;
        Tue, 21 Oct 2025 14:20:15 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b5d0b4sm11102371a12.29.2025.10.21.14.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 14:20:15 -0700 (PDT)
Date: Tue, 21 Oct 2025 14:20:13 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Francesco Valla <francesco@valla.it>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] Erratic behavior in btnxpuart on v6.18-rc2 - and a
 possible solution
Message-ID: <aPf5DZVYrc2YAXXT@mozart.vkv.me>
References: <6837167.ZASKD2KPVS@fedora.fritz.box>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6837167.ZASKD2KPVS@fedora.fritz.box>

On Tuesday 10/21 at 22:53 +0200, Francesco Valla wrote:
> Hello,
> 
> while testing Bluetooth on my NXP i.MX93 FRDM, which is equipped with an IW612
> Bluetooth chipset from NXP, I encountered an erratic bug during initialization.
> 
> While the firmware download always completed without errors, subsequent HCI
> communication would fail most of the time with:
> 
>     Frame reassembly failed (-84)
> 
> After some debug, I found the culprit to be this patch that was integrated as
> part of the current (v6.18) cycle:
> 
>     93f06f8f0daf Bluetooth: remove duplicate h4_recv_buf() in header [1]
> 
> The reason is simple: the h4_recv_buf() function from hci_h4.c, which is now
> used instead the "duplicated" one in the (now removed) h4_recv_buf.h, assumes
> that the private drvdata for the input struct hci_dev is a pointer to a
> struct hci_uart, but that's not the case for the btnxpuart driver. In this
> case, the information about padding and alignment are pretty random and
> depend on the content of the data that was incorrectly casted as a
> struct hci_uart.
> 
> The bug should impact also the other platforms that were touched by the
> same patch. 

Hi Francesco,

Thanks for investigating, this makes sense to me.

Funny enough, I specifically tested this on btnxpuart and saw no
problems. I suppose some kconfig difference or some other innocuous
patch moved structure fields around such that it triggered for you?
Not that it really matters...

> For the time being, I'd then propose to revert the commit.

Adding back all the duplicate code is not the right way forward, IMHO.
There must be some way to "mask" the problematic behavior for the
drivers which stash the different structure in drvdata, right?

Any thoughts from anybody else? I should have time to spin something up
tomorrow, if nobody beats me to it.

Thanks,
Calvin

> Thank you
> 
> Regards,
> Francesco Valla
> 
> [1] https://lore.kernel.org/linux-bluetooth/be8edf7f8ba8dea6c61272b02fb20a4ac7e1c5a5.1756179634.git.calvin@wbinvd.org/
> 
> 
> 
>  
> 
> 
> 


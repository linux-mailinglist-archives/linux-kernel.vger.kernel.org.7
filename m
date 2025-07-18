Return-Path: <linux-kernel+bounces-736488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD145B09D7D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 596E0A8655A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9DA291C2B;
	Fri, 18 Jul 2025 08:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="SwrTJZYp"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503F91D7E42
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 08:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752826439; cv=none; b=ZObuAKF0FZYJOKlGefpEnkHB4kdR3pD/WHbyFffvbX4J3cpkz5PNIrnddGeuNfjFDXMBZM7PWPx5HGs5DKEce1M7is1Slmwesqcsr9uiVIxKsWKwtdX/CPsXGny8wkvlVCuzYucrSjw+gMAUBPG1qWlx+egFuXionGwtmjEDszM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752826439; c=relaxed/simple;
	bh=2XxJMxqvE/Cjfusd0XxjbthJPfpvtef/UFrkblBe79c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gaug8ay69fd7Ry/MpQbqHy/eTDjXEBnLmE74pFvDNIQpVbSfzEd3FvC3FoJy89X0nr2hbpbi/VfFM+Lu8m2wPbK8p6inDMB5WUw+VVgyY6sm7Ke1K1SiDCaJqQ7oGv+C8fgUmE71l1Q+w6mcAcO7T/uusX5Nl8G6zoA8fMRfMyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name; spf=pass smtp.mailfrom=chrisdown.name; dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b=SwrTJZYp; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-747c2cc3419so1594740b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 01:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1752826437; x=1753431237; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qMPeAL07/lZrKnUkmH8nVJ8wh1GwyumIputOyztfgS4=;
        b=SwrTJZYpL9BW/5AE1sgr1NXM8fBoz3t/1IYRep4VjasHeMWV8VuVpZ8M/zqGANLyDB
         oSGqJJMkt4QM82e7f5zleJCHzPLjQyShvTC6XZ7YX8gJ8uG1kdBLOXK0C3l4XMYxl0Ej
         Ml15xPwaO0fq05wz2sbC34Kn9xNDfrYLOpX/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752826437; x=1753431237;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qMPeAL07/lZrKnUkmH8nVJ8wh1GwyumIputOyztfgS4=;
        b=N5NPhNsU1vnTIbOAVBgkBVet4LZ2FPdpuxgnSmQglLezCInm356qWUMYpGOd7mTlAK
         Vwt2eBl5kgt1JuGD4DGClHhdZkBfMfK2q+fUrPWIrWpDBi6ZpcU5TRcjYZ8ddN8/pEEA
         t1nAPkHpA471GOhkM3fXriJe8kpPKp5nXepfcxVb/o49RuPTQzTHpWYMwlMSCWUc4JBZ
         w3lWm5EAVg3ltAy+51rVmtnx/O6TF7OJHamWssj8TAFwgkQVWRXVAVDeUxCmgAaO+7ez
         NZrDWChAA8BupxdZ1loK0VbBiP4E9hxmyIZpyyScj9W2e9z+52vNCxfyVHPeMinG+Xle
         +s7w==
X-Forwarded-Encrypted: i=1; AJvYcCW/qvwASw38fHVsd25XV/rAzZeuMKdPOcC8cQk6lARFPcgluDsMmBKD32NawGzbc9wUfuH6196gsIFF658=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGfgVQiA1s1l1riCR0r5upS+KTlcfgN5ZPHgod0NrJIJIqtvli
	y27UUrk5EtF08RscWdgj63N8wm0uPs9zn6DuhQnU7hqILV0jsLDycIbGeVi356f+NZRKMR6+uH/
	5qJx83WM=
X-Gm-Gg: ASbGnctK9frUuGjGjn5bYBr1dhDGoumjPe6bVXNOtEtXmyWCcLGIkZYlRGxSOn1wUyU
	Ic0ZIIAxKPBr/BmDGTCFsf6EQmvolnALZFxJhu4cio10ardlSe8LNE86JfJo55ly4vtv/9797oK
	0Ihn6gZNmSbXo2hgyF1cINp+rZz6L2WtoNw+3jk0tv3LZHYn7yDfmVm/Se6DHZBChYfGb1tDZoV
	3OXbIYH8jnPsgXW4zHv42Da7HkSHBsr1xQzcTMiQWqo61+3/eE3d/ben0ciciSE6LEx+dd+CkGP
	xeqTTPJfLU6M6/7Pu3R1qeWPbIHz7anbsibve/CczlSBTcVouHCOG9GNVFbojIw+sY37YscxsVK
	RXuYyoIHWLipXs8A3kLX/00U3P0Gw2g==
X-Google-Smtp-Source: AGHT+IG73zCnFU9COboaEFW/fs2gtFK6dqDUiJYlBGv5r2t2tuOfTRYElrNJO1jXi74JhoPkFbTRRw==
X-Received: by 2002:a05:6a00:23d5:b0:748:323f:ba21 with SMTP id d2e1a72fcca58-759ab639668mr2324482b3a.1.1752826437509;
        Fri, 18 Jul 2025 01:13:57 -0700 (PDT)
Received: from localhost ([116.86.186.54])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-759c8eb0e98sm763432b3a.66.2025.07.18.01.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 01:13:56 -0700 (PDT)
Date: Fri, 18 Jul 2025 16:13:55 +0800
From: Chris Down <chris@chrisdown.name>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@fb.com, Jaganath Kanakkassery <jaganath.k.os@gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_event: Mask data status from LE ext adv
 reports
Message-ID: <aHoCQ_RfBl5Zm4oQ@chrisdown.name>
References: <aHfd_H6c9MheDoQP@chrisdown.name>
 <CABBYNZJo48983SWhxcB7UzWXPeUofRCMhQ8mJjih-rJoTET3_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CABBYNZJo48983SWhxcB7UzWXPeUofRCMhQ8mJjih-rJoTET3_Q@mail.gmail.com>
User-Agent: Mutt/2.2.14 (516568dc) (2025-02-20)

Hi Luiz,

Thanks for the review!

Luiz Augusto von Dentz writes:
>Can you include a sample trace of the above?

Is that with btmon or similar? Sorry, I'm not a regular contributor to this 
subsystem :-)

I mostly have a personal desire to get this merged because it's a particularly 
noisy case where I happen to live :-) These are all with 0x40:

   % dmesg | wc -l
   3815
   % dmesg | grep -c 'Unknown advertising'
   3227

>Also it would be great to  have a mgmt-tester for example that attempts to 
>generate an advertisement like that to exercise such change.

Looks like that's in Bluez userspace code right, so what's the order of doing 
these things?

>> -       if (evt_type == LE_EXT_ADV_NON_CONN_IND ||
>> -           evt_type & LE_EXT_ADV_DIRECT_IND)
>> +       if (pdu_type == LE_EXT_ADV_NON_CONN_IND ||
>
>I'm not sure I would keep checking for  LE_EXT_ADV_NON_CONN_IND, maybe
>just return LE_ADV_NONCONN_IND, LE_EXT_ADV_NON_CONN_IND is not
>actually a bit it is the absence of any bits being set, so I guess the
>only invalid adv are the ones for legacy which seem to require a bit
>to be set.

So are you thinking of doing this?

   if (!(pdu_type & ~(LE_EXT_ADV_DIRECT_IND)))
           return LE_ADV_NONCONN_IND;

Thanks for your help!

Chris


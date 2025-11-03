Return-Path: <linux-kernel+bounces-882588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6268AC2AD39
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 10:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 64D9D4F0EEB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 09:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B802F39A9;
	Mon,  3 Nov 2025 09:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="L5fbvBuu"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEC52F12C1
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 09:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762162914; cv=none; b=ZNEtpOeHTg0stx/yGLp4Z+rn6epNG4hNbmk7yYmTMfXNX2GqxNhBvo6SVkYWSDJpGXKkgX0wOpg2WgSXDjpuZN+bUlaGl0ixcFiwxaYMxKPrLqQE5KTpfQPAnPQihG5ia+Gnr0AFOHlb0NlRgXcJrkrgtgilkOA2APcMm2IIjZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762162914; c=relaxed/simple;
	bh=aXJZtEP9MzAuBE72bhvix2W9bevYZ5Ri5o0a3J6FafU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VY0KrRNgpJ/iBHp3M0vtCg6k0CSh6enmpY/qT44w8e2zUA2xpcJsCihiz1R5PUPjJjCeJbISHlxJZONXj3ZF3n9mt5+spbn2POrv4mRcdkGka2ra7j8F06HucZgWPC0tBp+OTjztuUEhJa9b2HcmYXL2m+QBKbFnajrb3jLinBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=L5fbvBuu; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-640bc4ced7bso1459332a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 01:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762162907; x=1762767707; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uQ4p8extKYli1hpsb18sxQURINeyF5Ujv69r9EjqtSM=;
        b=L5fbvBuuYsWJnsh89kXTpRVZTh+PLokuFWNfs7/0+mtBW1LLO9yJbex1RKcvIjrf8q
         yFdzWW7gomoG07KS5KwlMg5qW0DY323HInapNEYNmPqx12MrW/2DxmlbOEDVqfWjvK3w
         1Fqp6SNs2OWJWwSwVJMFSC+gj7CCH8DnDhSeUz2sO7eSveMgRHR5yQ+OZqS8NYsOezKU
         qBWjen17GXNdKjVxzEn+wM6sciJ5OHK48LjIl3vKRKuWlUoglBCd/eEQneJfvF7v/3WY
         W7dEXrJtZdTY9R5oyL7qPt/2ijqm7eLWmQl33DfFv5ljgwpYfpn9Kg0nmBkLLlpuyWeY
         Xxfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762162907; x=1762767707;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uQ4p8extKYli1hpsb18sxQURINeyF5Ujv69r9EjqtSM=;
        b=Hh8wXGMbkWpXfOwYLcF7YJnsl9kvbH9ahQ25iVpTYhIQzvTYqPbyAQVWS38UkycMjZ
         HQVxJevIIusjD34TrvjAouESgutoyAxvgYj/xGyXfaZ8HdrJTJZAjPBs7e2b3jC0DZFy
         Kn1i55+onG7SEDT7tCkNv9JlJjcv7JBE9Fqc3k+ZYuzgBzjukExn8mEV6lu22vz46mBn
         UA4gbAvuzkmgw/owCfQYf5bcU9488GTq7ymv/p6JWZzsaSCeiNM6R1Nokc0KFrqldcpi
         AURzIh108/D19MuMc5JDBko3SD3h51i+/emIQfP0D1N6buhQ4a7F08MBGPhplT4YfxC7
         vyhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwcw14g+/gP4E7deQwueOitEzLJsZtkrppfSBjz5yP1q0JdLXMhe2Q9/P5z9DWeB7gWosO6Y1Z9iV90YU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzERz6uBXGn9/T9yqpRLwQ8f/piehw4CYIJjY8L7jwerOJ6a+rl
	RyTLwoUPeEexv7NDZg95WBFlY3M+OqwGJigZg07l3JdU1Yt11RYFguf6VUToHA/IM1bbljRc4uK
	AnLgQ
X-Gm-Gg: ASbGnctwNKMcVtL+G0WkoBrENaXRcHPEwZY2U5KWkOBpoLGZssITqvXsiazz/SydyHt
	CJTJuysog2Asu9/MngZx3iQmuo5NN5+Zduv/aHij93djzK01cb4h3buCdajqPhKjrMx10/vGkb+
	DvaJExSyWXWlHACtqVxFWjCnXBElDW1fOed8/tY7nVtSaGDSnjHwzGCleBOIUTttJQSgSZWNJXY
	yTfgR4gvyBriUDQ5v1Uqby6xfmZgWJv/g9ed5eyqWPkpuiPi+A+a8jkRyBQ+zEfV8VBEOC3+PpM
	O1C2qB4bvZOTCFBU2YDp+qSHNp4YT6mcTjRTPxZjHaiD+i+ky7pAeyV5PPtYo74yZNpASpCHIv/
	9bCXYWDJqur+E54us3mrbTuCeMqy502mSbBu3wY8lNVbXjehYRVdAcg/YZiGkSdr7m7v7vVDTUR
	8URIsHBA/FyHwfe2PCUJakTeTyXKnKMTcmIxtKRckoctfHZtkTBKTquwc=
X-Google-Smtp-Source: AGHT+IH2gzj+vo7E8Ikz+oUAKkZsomKKLWkfIfLWgoIJFmJJqNapKWXnB39jlaelhJtTjBQ7ItLs8A==
X-Received: by 2002:a05:6402:1472:b0:63c:1d4a:afc4 with SMTP id 4fb4d7f45d1cf-6407704138emr9280289a12.4.1762162906723;
        Mon, 03 Nov 2025 01:41:46 -0800 (PST)
Received: from ?IPV6:2001:a61:13df:d801:cb2e:7d62:bafe:d300? ([2001:a61:13df:d801:cb2e:7d62:bafe:d300])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64098077b1asm6659522a12.7.2025.11.03.01.41.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 01:41:46 -0800 (PST)
Message-ID: <a3d9c04d-73fe-4624-abee-b06abda9fe97@suse.com>
Date: Mon, 3 Nov 2025 10:41:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [usb-storage] Re: [PATCH v2] usb: uas: fix urb unmapping issue
 when the uas device is remove during ongoing data transfer
To: Owen Gu <guhuinan@xiaomi.com>, Oliver Neukum <oneukum@suse.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-scsi@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
 linux-kernel@vger.kernel.org, Yu Chen <chenyu45@xiaomi.com>,
 Michal Pecio <michal.pecio@gmail.com>
References: <20251015153157.11870-1-guhuinan@xiaomi.com>
 <aP8Llz04UH8Sbq5Q@oa-guhuinan-2.localdomain>
 <8de18ee2-ccdd-4cdd-ae49-48600ad30ed4@suse.com>
 <aQYRIgg2lyFhd7Lf@oa-guhuinan-2.localdomain>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <aQYRIgg2lyFhd7Lf@oa-guhuinan-2.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.11.25 14:55, 'Owen Gu' via USB Mass Storage on Linux wrote:
> On Mon, Oct 27, 2025 at 02:35:37PM +0100, Oliver Neukum wrote:

> I think the error handling only takes effect when uas_queuecommand_lck() calls
> uas_submit_urbs() and returns the error value -ENODEV . In this case, the device is
> disconnected, and the flow proceeds to uas_disconnect(), where uas_zap_pending() is
> invoked to call uas_try_complete().

OK, I see. You are right. Please resubmit and I'll ack it.

	Regards
		Oliver



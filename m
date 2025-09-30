Return-Path: <linux-kernel+bounces-837575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF71FBACA70
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 13:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74CF8167AA6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9122505AA;
	Tue, 30 Sep 2025 11:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BRHsesoG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F171CA84
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 11:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759230836; cv=none; b=ArlQ0FQZtTtKT1A8aALvB7a1MtriYSrh4ggHvgczCWiXmOwOL20oOw69oNkviPF6D2rjpKHXPC+bJDVsvddZgTxX/npRfajQry3btBUF/KRuspT8HbsPvWILZP4E5YhD+Sr6/mwtB6f+QwXeCvFOHqetoRaArrXoNJp2AdzpzsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759230836; c=relaxed/simple;
	bh=k93mxj134tykzcVQj1QfAGA+nyICxzHFdI2oEVReNtk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hINSt3ow0G1PzP5FQRrd49i7Uco91tYRSIG4SFuxuBfx4FT+1jk8fACGhIsHGeVw0qxunMrH9ljSwZgzmPO7eZ5XwRgVuYYsV/1Xki5oJ1sm6qt1yOP6msxOrKaaBq66evbHXXN+p4gyE2GhcAWHHB4egFzur0dOB/w4l26Zsuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BRHsesoG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759230833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9KcvC5cBSi1iBleTgpoe3AI8RltwCt0Ed3z8BuW4Pu8=;
	b=BRHsesoGPQ7eLAeebf25GR/FEafwNgeFG/j79+pcmD3iIncidIWwoAP18f4Q+A3612dmi+
	4nP5epbLIeHTPPyvuoHoGAXXIxJ30VnImcx5Qhxnt82HilXcBNRaFqKFECYQpxannuwLi0
	CuQqYslPx3ReT4X8VbNAgb39SXSziI4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-0bJTItXCOtKmo1NAZUJUaA-1; Tue, 30 Sep 2025 07:13:52 -0400
X-MC-Unique: 0bJTItXCOtKmo1NAZUJUaA-1
X-Mimecast-MFC-AGG-ID: 0bJTItXCOtKmo1NAZUJUaA_1759230831
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3ecdd80ea44so4158722f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 04:13:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759230831; x=1759835631;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9KcvC5cBSi1iBleTgpoe3AI8RltwCt0Ed3z8BuW4Pu8=;
        b=Sll5y7VhjhLmqrVZ6jpVrvnqFwUOEcEFBdk7QhQ3asN74NX5mPZ4GYV3RfK3CHN969
         3968Agmm/DZjb0KWKsX72kagy5oAc6KPmcDNUwHAxIeBvPdYUKJQzZal69fHtANC7NL/
         7WhBRe2kj5f04z/s7D2PfjCVWSkfqWjkyuW/Oge6mjlhdIRNKqCP7w+QeJJJCKzhlXuk
         Wsij+KjEuAahhvGOeqT3VnwS9RuvNiDfyhpyKaBVz41aTvfJvK7E3u2aNqC8C5WXOlPY
         ZGf8ZraKasSM3UD5zbi3YbPwprajQ7aeh8jfliitsrPQkuXzqw5c0zP2fIOXTqqhRLkm
         qGvg==
X-Gm-Message-State: AOJu0Yw2rij2jHaeYvxm949DOWwiskj5+3IjWF62EV/LTaDShO+mnPEr
	h9YFu5U+bUurNKWt0rRSFyN8HuzWIsI3DoZsaptaF03GtHV6oWktXzux1alHp1obm9usRxlFtsu
	ip6t9Ica3uUQlSFh0uBGJeilwGJ9jKiRpKPhSitU5XVV1fj4bsNSUJqRJnEeBfi4xlQ==
X-Gm-Gg: ASbGncsaYdAR3yFxKz+JWOcc1rDJfkKMLhYme8YqYGNEo421QD+8YMkdzxiUgn1GE7n
	nC8CcwEmLVD9BfkKcHF/ysgp++KA59hCMnRF0wfOCAy5DeEnzU9Lne4HLJu5PYVIirg1nSTKJWB
	F0nqzSQq/czAkUmIVuhnoBnlT1Yar7UErZ74wHNVWvLdS2mY6rGnCxy3xZKyoAFkx2IqQrE2bj8
	xsAErt1IOlVCTHAu/C3dyxOWbnZLau0JCudKS81HwGWM+explHJQRYUDpvr6NmYJLUR6eUUUobU
	lprEsVGK50Vh2oiRFecC7ZFAdYPiZb+4VxE0p5UVIxxeRMgsUZ4zC16EVbj8c66Ep3rAT3PKzRP
	Bv7MWYX3jFgKgv7+TAQ==
X-Received: by 2002:a05:6000:4013:b0:3ec:dd27:dfa3 with SMTP id ffacd0b85a97d-42411e9dc0emr3836744f8f.25.1759230831010;
        Tue, 30 Sep 2025 04:13:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsuO8Iq2wP0Oxbja1qwoJoUN0P64DEkSmlfa8kXErE7tflD0SLgBdRttPrLOYzXZyMTCkKMg==
X-Received: by 2002:a05:6000:4013:b0:3ec:dd27:dfa3 with SMTP id ffacd0b85a97d-42411e9dc0emr3836715f8f.25.1759230830565;
        Tue, 30 Sep 2025 04:13:50 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb72fb017sm22223822f8f.3.2025.09.30.04.13.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 04:13:50 -0700 (PDT)
Message-ID: <052f3394-ce15-4e6c-bfe2-4dfbee25be29@redhat.com>
Date: Tue, 30 Sep 2025 13:13:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: mscc: ocelot: Fix use-after-free caused by
 cyclic delayed work
To: Duoming Zhou <duoming@zju.edu.cn>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch, UNGLinuxDriver@microchip.com,
 alexandre.belloni@bootlin.com, claudiu.manoil@nxp.com,
 vladimir.oltean@nxp.com
References: <20250927144514.8847-1-duoming@zju.edu.cn>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250927144514.8847-1-duoming@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/27/25 4:45 PM, Duoming Zhou wrote:
> diff --git a/drivers/net/ethernet/mscc/ocelot_stats.c b/drivers/net/ethernet/mscc/ocelot_stats.c
> index 545710dadcf5..d8ab789f6bea 100644
> --- a/drivers/net/ethernet/mscc/ocelot_stats.c
> +++ b/drivers/net/ethernet/mscc/ocelot_stats.c
> @@ -1021,6 +1021,6 @@ int ocelot_stats_init(struct ocelot *ocelot)
>  
>  void ocelot_stats_deinit(struct ocelot *ocelot)
>  {
> -	cancel_delayed_work(&ocelot->stats_work);
> +	cancel_delayed_work_sync(&ocelot->stats_work);
>  	destroy_workqueue(ocelot->stats_queue);
>  }

AFAICS the stat_work can unconditionally reschedule itself, you should
use disable_delayed_work_sync() instead.

Cheers,

Paolo



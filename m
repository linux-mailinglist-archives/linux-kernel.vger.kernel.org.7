Return-Path: <linux-kernel+bounces-807506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F36DB4A54E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A4E5174F50
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD76A247281;
	Tue,  9 Sep 2025 08:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gjAIUQYs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850EB24167B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 08:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757406717; cv=none; b=NyskEy11SjRhhhI9/PlNudJBC5MA9fF8bfneVKWw9AeTgiXcHQYqp+rEL1Cd+YEG7bns6MSJ2CfCQ7BhaVzsJIpNCr3HMbmNoEt495QC5hlR1NM1KAO/OQZ4sC2ZaaXtBaV40bRNCukoQVUOvZoHkwMQgyBUhLmXVARFWoZ25EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757406717; c=relaxed/simple;
	bh=6G6CgNfZE3HhCmcVYoqhzdz20x6QjWDcqIpAGfIuSYg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=t377LZdYBDCHdDroEyhM7LZZv0q5jvJ76RwUFvTO9pyJ6U4IYJO02KuGQVdiiwijOXH7irq+J80KXfiQSERLPcESDJAaQ/8yaGZuahwQul6q0eNZETkkRznNwaWyKZjczsHw0YOWmUBtMHdLa2dZCmLJa4rEVBiQqmGopjFYTZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gjAIUQYs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757406714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B3JiqpXYLeFdSyLXqDESG7NejUBS/eexgYk1TpT8BmU=;
	b=gjAIUQYsD27UqMlN1WzdzIdBRd25bfxCjW/PsPG4dav7FIH6Z9VJwHBf+uXRm7CfT8a5vA
	xorWuLkqcEacsY4ClC2geq4waH4Du7+2DJAZ9SJvCdgSx44tQBjYv2NU+KkDixF/TbDIrP
	kB1m1otV+doyEHbEHa47aat670TVsjk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-i2AZoCAmP4eQTUeWfrbS4A-1; Tue, 09 Sep 2025 04:31:53 -0400
X-MC-Unique: i2AZoCAmP4eQTUeWfrbS4A-1
X-Mimecast-MFC-AGG-ID: i2AZoCAmP4eQTUeWfrbS4A_1757406712
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45b920a0c89so22012565e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 01:31:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757406712; x=1758011512;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B3JiqpXYLeFdSyLXqDESG7NejUBS/eexgYk1TpT8BmU=;
        b=BMiRtCAr6qt8gqqKCUKd5+xuoCSbVCTceiZ/3lZH3hD8KLBbPw5JgyowyZwGXhTrNq
         X8dqakvZR6lBJoTZbst3avJWlk/r3ytJHADDTNeAsxnzyDlBwEj+QHFrPLSN6JexsSmy
         ca2M0GbO69x0YwS2IgpcRZHgjN/eQLS+rTZUQ01ae1vIN2xzznyCqafUwZ1NIIZEukJ6
         gf2y+crYE7FGKBGAv8TUlWDH9OEvUFTx3bMmOFKQSjAfoavCoV3Pb7H55K62UNj+aEny
         U9NsQhgRkYvRGYdF/kr1+ZvKpdf7SGkCsv1E93vfBF8B5DR0DrhBqk3nrNaZPMzQumLE
         LM1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUAyZDQSoYDcgxiL66E8X9ygiu/ghuo/1t7shfp8W3z+Qwhbw+LzbMy4GDoB7IQIHF/rvzWbXU+2sX0P2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVg67B9/+GzqDO2oM2NgLhNbUlOzH/TZCkkTOw18VKuOW4y9ZK
	NkhSJnOsRuHTLkFB/Yf3rZxC3pIfLt5ZWxdkja/Dy3o7Rjjyqks6OlOrBukZ/F8lfIx03anmrlI
	YJtnPxbC5UBH2a3UXexqHzrmNdIDn3lMlBB8yDWxhSa9AfiIoighENyV3PEmkgVVWrw==
X-Gm-Gg: ASbGncsz/Ew63fu06uvVBw7V4T5WmR0xLxjZdWkCEVaKWoCuvUSAPOVHDPF0bRMSa5a
	RWKo4h6TnEh/w5e5tAJhMUToc31voK/Nrd8EgnUeCBWpwaKAOAYVygq8I/IAxDgTItsGzR6UHCa
	H/hg2WlDOxFoQuWYVND+jdPvFmpYWQmR34eB9uiMUoqcKxO/GzoQ6GDPSMuNHKU4Z5Pr2G4qMlK
	3yJgqc+To0CgeVILrFqOLB7Wh53U+1I1j80N94zHkMNaUV49eTG25SVTaOyNmp76CnFfPPy2JMv
	Ng0tTW0deM0eBVwjXDqggTkZGHvAvdC8vS6vyNtXFWMosseJs0uG35eKpiNGoUYWVq7/H9hnr30
	fJ4GJGwn/rbE=
X-Received: by 2002:adf:a2de:0:b0:3e6:e931:b3e7 with SMTP id ffacd0b85a97d-3e6e931f910mr5636038f8f.61.1757406712233;
        Tue, 09 Sep 2025 01:31:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFvsITKaBUrZYvh6g6weJGpHyBKLHpO6IqHhZjtEprYVnnx/USfiBncaI/4OPGMS02ilTbLw==
X-Received: by 2002:adf:a2de:0:b0:3e6:e931:b3e7 with SMTP id ffacd0b85a97d-3e6e931f910mr5636017f8f.61.1757406711837;
        Tue, 09 Sep 2025 01:31:51 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521ca123sm1717027f8f.22.2025.09.09.01.31.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 01:31:51 -0700 (PDT)
Message-ID: <9873f106-0e32-4ab2-a05d-2b17d281e997@redhat.com>
Date: Tue, 9 Sep 2025 10:31:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next V2 1/3] ptp: Add ioctl commands to expose raw
 cycle counter values
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Mark Bloch <mbloch@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Thomas Gleixner <tglx@linutronix.de>,
 Jakub Kicinski <kuba@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Richard Cochran <richardcochran@gmail.com>,
 Carolina Jubran <cjubran@nvidia.com>
References: <1755008228-88881-1-git-send-email-tariqt@nvidia.com>
 <1755008228-88881-2-git-send-email-tariqt@nvidia.com>
 <ca8b550b-a284-4afc-9a50-09e42b86c774@redhat.com>
 <1384ef6c-4c20-49fb-9a9f-1ee8b8ce012a@nvidia.com>
 <aLAouocTPQJezuzq@hoboy.vegasvil.org>
 <3f44187b-ce41-47e8-b8b1-1b0435beb779@nvidia.com>
 <aLmQt838Yt-Vu_bL@hoboy.vegasvil.org>
 <1f85b803-eeda-4d62-b36b-8fc84390e74f@gmail.com>
Content-Language: en-US
In-Reply-To: <1f85b803-eeda-4d62-b36b-8fc84390e74f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/25 7:52 AM, Tariq Toukan wrote:
> On 04/09/2025 16:14, Richard Cochran wrote:
>> On Thu, Sep 04, 2025 at 03:09:23PM +0300, Carolina Jubran wrote:
>>>
>>> On 28/08/2025 13:00, Richard Cochran wrote:
>>>> On Mon, Aug 25, 2025 at 08:52:52PM +0300, Mark Bloch wrote:
>>>>>
>>>>> On 19/08/2025 11:43, Paolo Abeni wrote:
>>>>>> can we have a formal ack here?
>>
>> Looks good to me.
>>
>> Thanks,
>> Richard
>>
> 
> Hi Paolo,
> A kind reminder, we got the needed ack here.
> Yet patchwork state is still 'Needs ACK'.

I was traveling in the past days.

I see Jakub has some perplexity WRT this series. I read that as "I
prefer don't touch it" (as opposed to a "no-go") and I think that the
feature makes sense.

I'm applying this now.

/P



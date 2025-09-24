Return-Path: <linux-kernel+bounces-830914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 759D5B9AE33
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 18:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34E054C64F8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0CB313E07;
	Wed, 24 Sep 2025 16:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvSgCOis"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA103043B0
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758731823; cv=none; b=KZnOMpbQbkMiQsxb+fqqOpVFyRobpLJAm9R0NsDLi9CJi+wU839tdAesjcUWhOTcUIh2Ev7CcIxxF+fao/0hruFS+0i3iSOibLdzHTksSJIuGMpo5bU09j05Ic83v4FO6FychxzU+jgTmhjNmiE0bP+fdaf9HIn7TA2h+3/y9Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758731823; c=relaxed/simple;
	bh=slMHZf7pDj+LFIrXTqw09zXP6T1Q1gmwv3Y28fwaRO4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=r5kSqIOZq0nyfwRtQw0jqcY+afwXVHNVDh5CNuBViHHa9CzwfDcHSsqPhj6UV1N7g5ajXaWcfN5CXyrKwsOJ2/jSVJ3x3mctr2g7/oV4L7y//oXNG381mGfWbvo5Fyl12tsiVCtLDKFi12iiw42GbXocWLoISYQxACEQJA91O4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DvSgCOis; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-77f2c7ba550so39063b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 09:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758731821; x=1759336621; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3wqzINicnkLL2c14gwZ1hx+hWX66mtEw47ebSibOks=;
        b=DvSgCOis5AC8MvFwMlKcNFkj6pGO3wBPWML9+EKEwhyq1oFV0I2uXi5wvZzXnIGxnV
         95iHDdRhbjMjvRX/2w55u8I1eQXdo9cwvJk8CHqPBslUBNFkOXLrYKeAurd9DCk+bcUE
         W3bKMmIdULAZf0Sxcdx0iITFQwjmC6hlNj0NzswXtZqasURqj/tgdU1/Xqh+3ibdDEq3
         OrtVq5OKyAkTaPkfNg8vikRjP2xtrPlN/p0V+CXBWpDw+29Y/tR96n51mF7dxIbro4VU
         64P1QaF4jDkTH4t2qMkMWV1mLJdzume7MKUMhi1JMTphrZ2byvNqapAVHRc87PQgv9zJ
         d4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758731821; x=1759336621;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z3wqzINicnkLL2c14gwZ1hx+hWX66mtEw47ebSibOks=;
        b=UN88s2Gdvw6NIZB/Qij/lJWI580qIrogj2/+273lZ2+MMLZywBucNIBpG1s+vntI3L
         z7b+Ueefb9gI8o2tpHmCI8kndev1+na/4swDH0jRoAXAVfzMbjEFK2o1b17uPg5wy649
         5d+V0+4BCVJ2WDMcAl6IuWi9AYrHpZaO1L53R6cPp64d1BQVjyYWaOEJCdIL/vsfczVO
         oXGpNz5B9fiVS9FF9BSmjikyjonnEj4asOGMfVeLQWc/YmnB8EUPYubJekuaVk025ze6
         n/SMNQyp7GtB1135d31JCH/mf2pxwAFVZ2DQRtciS01Nx/rHu97C8QytxCFju5OLgbOq
         KBJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWe8LncxVfhBCHzfzSbgNxCsFyuJq9C3m5nwqq9EqHGBA3xpcpg/yYeakw/S14wKKaMSOmc+2DvqIStmc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YycxKDRr7AqvLHzMcrSXImqU0/BvmcjefeYQv6XcebNFPoLdg1W
	3TjllPx0lcTyc+UcwcgoXoT9LNSAXSKtV0Lcju6WcS0YVRNoTW2AtwfL
X-Gm-Gg: ASbGnctWfYbt8wZgTHbPRGPSYNYX+06odDLqwqo8AU2VJlKdwgLGKcsP6lq8N7eBWxx
	ZFh3siOGA07elWV7R58pwg2OXtvf0hkN1je7Va6RrYShKOszUUm7GltYPwi910+kPpKX+UIT1Gm
	ljse+ODN/Hg83qdwgBJsurUfvoSMDy80ge2/6Eggg7Jwa2MSIDdcScJCPbXkZL2Irlk+q9P+HGU
	S727Tjngrhl0zTbmOR2GTM8YAj9NGi+BfQ9kdY1cZeA7+v8Nf9OoMEgEsa1AYSmDSiyJ8JARR95
	r0xLu8YbcEgp1q3IodeiFXCVbGrP5OEyFFkHRXBZbEwlbca3TO/GPjQ9M/YiAkkoQLp6qwwyUY/
	3nxcAd4CKAdJ1phqO6wfioBQoME/z5q/7qzJsSLNm5euMvk8DBOGg
X-Google-Smtp-Source: AGHT+IHIiPcXqnb4ZuXzHkhTE/WRNCDaCxsTg2AL8U2suEQAkNt7mCt5UlbYVTc4ITkK9ujzuppd6w==
X-Received: by 2002:a05:6300:2109:b0:2ba:eb8c:92e7 with SMTP id adf61e73a8af0-2e7d2c5cf1cmr258004637.49.1758731821173;
        Wed, 24 Sep 2025 09:37:01 -0700 (PDT)
Received: from localhost ([121.159.229.173])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b551b31ebb2sm14540645a12.6.2025.09.24.09.36.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 09:37:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 25 Sep 2025 01:36:57 +0900
Message-Id: <DD16EAXYP4SM.1JYDYPDJ4I7VV@gmail.com>
Subject: Re: [PATCH net v3 2/2] net: dlink: handle copy_thresh allocation
 failure
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Paolo Abeni"
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Jakub Kicinski" <kuba@kernel.org>
From: "Yeounsu Moon" <yyyynoom@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250916183305.2808-1-yyyynoom@gmail.com>
 <20250916183305.2808-3-yyyynoom@gmail.com>
 <20250917160924.6c2a5f47@kernel.org>
In-Reply-To: <20250917160924.6c2a5f47@kernel.org>

On Thu Sep 18, 2025 at 8:09 AM KST, Jakub Kicinski wrote:

Thank you for reviewing! and sorry for the delayed reply.
There have been quite a lot of things on my end recently.

> On Wed, 17 Sep 2025 03:33:05 +0900 Yeounsu Moon wrote:
>> @@ -965,14 +965,11 @@ receive_packet (struct net_device *dev)
>>  			struct sk_buff *skb;
>> =20
>>  			/* Small skbuffs for short packets */
>> -			if (pkt_len > copy_thresh) {
>> -				dma_unmap_single(&np->pdev->dev,
>> -						 desc_to_dma(desc),
>> -						 np->rx_buf_sz,
>> -						 DMA_FROM_DEVICE);
>> -				skb_put(skb =3D np->rx_skbuff[entry], pkt_len);
>> -				np->rx_skbuff[entry] =3D NULL;
>> -			} else if ((skb =3D netdev_alloc_skb_ip_align(dev, pkt_len))) {
>> +			if (pkt_len <=3D copy_thresh) {
>> +				skb =3D netdev_alloc_skb_ip_align(dev, pkt_len);
>> +				if (!skb)
>> +					goto fallback_to_normal_path;
>
> The goto looks pretty awkward.
>
> 	skb =3D NULL;
> 	if (pkt_len <=3D copy_thresh)
> 		skb =3D netdev_alloc_skb_ip_align(dev, pkt_len);
> 	if (!skb) {
> 		// existing non-copy path
> 	} else {
> 		// existing copybreak path
> 	}

I totally agree with your point. However, the two cases handle `skb` and
`rx_skbuff` differently depending on the `copy_thresh` condition,
regardless of whether `skb` is NULL or not.

This patch is only intended to gracefully handle the failure case when `skb=
`
allocation fails.

	Yeounsu Moon


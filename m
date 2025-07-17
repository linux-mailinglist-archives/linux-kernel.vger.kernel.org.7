Return-Path: <linux-kernel+bounces-735452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8010B08F87
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6AC5A42874
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C11B2F7CEA;
	Thu, 17 Jul 2025 14:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="tZJ1DULF";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="ihcA8BLA"
Received: from e3i105.smtp2go.com (e3i105.smtp2go.com [158.120.84.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151701D88A6
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752762794; cv=none; b=cwr60O4U7omgU6dGxCaFRpDN/P0PE7AlGPOFLuzK5En8YYiNeMS4SXCkXb/KE71kK16FW7/9Kl1BJ7j8g9qH7atrNRxpheYrP7mdHI98qv7VyDeNXh6GCiBz1YkPvCJVFgjLCXw+3wW8/unqjCLncjPMUxQD49zLe0GvVn4ujIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752762794; c=relaxed/simple;
	bh=KEDsAVHxVGER8/quttS1kdduOVdPIELhw1UAUA4h8Bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SrtXRfZWcxzRb7RXXmD0+iFRc0A90R11LoJ1Sb23qoY+HPcaLb10SEDihI8oFjmvT0HDD2jg95MqxGU5/KU+tJhUxxLz7HPq2/G3txjQUA3VfsJ9AGIIdBI0SaHtCXH5USR+0wA+hhxEL26s3oBpUI3iWAxbbRGd8qXnMtPnVqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=tZJ1DULF; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=ihcA8BLA; arc=none smtp.client-ip=158.120.84.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1752762789; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=P8aWAVi1JHdhRfr6mcngPcM1V/JkdL8TAXeFc1ey/hs=;
 b=tZJ1DULFRx97uny7h6ZL+1JWjnRwLgsH8bYrwPBSanvJomLBjlruVgJo2eIh4AsxITyXg
 nYY+aRipAiGshG8ee7ffApTTTYWozF59zMvuILibAaW42PBWFsze48vQY52cv3ecvd0TQRm
 bn3F8cguXl5nEKS7iDk5EH/KHqXvdpkZ2eGiEJmvSr3pkrNFglz1EZTwKNteKj1eGJfrTyI
 CjUEKUlPqDOx80HhTcGuLInynOTEA09ezLMGJ9kmpuxarB3KoYcdllqVd5kIkaAOpO02Eb4
 gfit9k0JDchYbXGzv2OQFq1dPpvl+uQL7lhzMmvwlKihyj4wMX5JZ7w9JswA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1752762789; h=from : subject
 : to : message-id : date;
 bh=P8aWAVi1JHdhRfr6mcngPcM1V/JkdL8TAXeFc1ey/hs=;
 b=ihcA8BLA+DWMDpkQ6m4qB9rQurcCH7Xku2R24Vevv4MdzGbC4uX/tQQAnxGadXEMbWY0B
 uXOt7WJDH/9fVDPAH7GVqJOZA7K8UnMQkIJ0Ny2ZJKvWIm1uTkb+gaaq9PoSgXokdGtUjbo
 DbwbpzfkbhCNL7KZsJAfTgVZl3JpxFqFqbGBAOR/vTVw4r/2xpCT/2i84hR30YM1rFxHvX7
 QLo29GxL6C5jruS+TL0KgPTGszi7q7au9nzSK/SuM4FtGBGaPqeKph5/ei2bBmnBYZ4SmnL
 fpdn7JknE+tqJXbpgdeJJJJgCOtXuyNVupr4qm6iyvHY8eRpJxzKMEzF+icQ==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1ucPfU-4o5NDgrfJDm-sFY3;
	Thu, 17 Jul 2025 14:33:04 +0000
Date: Thu, 17 Jul 2025 16:22:48 +0200
From: Remi Pommarel <repk@triplefau.lt>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Bert Karwatzki <spasswolf@web.de>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH wireless v2 1/2] wifi: mac80211: Update skb's control
 block key in ieee80211_tx_dequeue()
Message-ID: <aHkHOC6DYBXtnE5e@pilgrim>
References: <06aa507b853ca385ceded81c18b0a6dd0f081bc8.1742833382.git.repk@triplefau.lt>
 <20250410215527.3001-1-spasswolf@web.de>
 <Z_jpq26P99qzPP1c@pilgrim>
 <1df3a3df19b77e3b8d1f71a3a93c61221ff46a6b.camel@web.de>
 <aHj4zS_3uhDRhzDn@pilgrim>
 <fa538ba960369497f6d65c1448ab7710f76aa078.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa538ba960369497f6d65c1448ab7710f76aa078.camel@sipsolutions.net>
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616sBGiWowcYh
X-smtpcorp-track: R0xLeI0OiuLu.-32-XTI8pDOv.dMZVoAU6EDI

On Thu, Jul 17, 2025 at 03:46:00PM +0200, Johannes Berg wrote:
> Hi,
> 
> On Thu, 2025-07-17 at 15:21 +0200, Remi Pommarel wrote:
> > I have ordered a mt7921 card so I could reproduce this and finally took
> > time to debug that. 
> 
> Oh wow, talk about dedication. Thank you!
> 
> > The issue comes to the fact that mt7921 uses 802.11
> > encapsulation offloading and as such we are calling
> > ieee80211_tx_h_select_key() on a 802.3 frame.
> 
> Oh... Guess we could've thought about that, sorry. Though I would've
> thought ath12k will also do that. Maybe not in the config you were
> seeing the issue in?

I've mainly tested on ath*k HW. Either without 802.11 encapsulation HW
offloading or with it but only on ath12k and it seems that this driver
does not need the key in this mode. After a quick look into ath11k and
10k that also seems to be the case for those chips.

For the record, if I am not mistaken, ath12k driver does not seem to
support 802.11 encaps HW offloading mainline yet, I do seem to have some
vendor patches to support it though.

> 
> > This function casts the skb data as a 802.11 header regardless the skb
> > is 802.11 or not in order to decide if the info->control.hw_key needs to
> > be set. So the hw_key is likely to remain NULL in ieee80211_tx_dequeue()
> > and because mt7921 driver needs this key to be valid data frames are
> > dropped.
> > 
> > Will send a patch so that ieee80211_tx_h_select_key() does not try to
> > get info from a ieee80211_hdr mapped on 802.3 packet data (i.e. when
> > IEEE80211_TX_CTL_HW_80211_ENCAP is set).
> > 
> 
> Sounds good!
> 
> johannes

-- 
Remi


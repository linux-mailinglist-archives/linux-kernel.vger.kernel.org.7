Return-Path: <linux-kernel+bounces-807181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B23AB4A144
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7F4D4466B4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 05:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722AD2475F7;
	Tue,  9 Sep 2025 05:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b="rT9w5P0J"
Received: from www.redadmin.org (ag129037.ppp.asahi-net.or.jp [157.107.129.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75775221F26
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 05:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=157.107.129.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757396166; cv=pass; b=jrLYw13QKwZWGbZm9xYt6CZ7FHU6bHb8tzNfLbhrNzlD4lOelz7GYTIv46YLQ3hbI4JMu2hx/gOeOTxzy9NNt72U7KC6/YvcDArBl3A9ChEggTibnFnwBiYaUCyQr2upEsVOvL53JzE1vkkRwEM7dXAuNmQvscdI4kFGzRjSX60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757396166; c=relaxed/simple;
	bh=hqF+nTI2qsoTph3y5+X0NPupecETl+Kl1t6FzuGP3yc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=iHyILQdf6tuHHvTszCQwzogIeGqZJ7JlKr+VA9T9Lk054CqQR2S16ZBHNaaeTaP8/q92LXVNjUktnshQCNzfHVyzaw+eze4WZCS6AvTbWZh5odX4e5sEAYhIRWp3iACxRSCyt657BFJwYYQl8LFJrRPSQxL+Dynv/gaZxbNWSDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org; spf=pass smtp.mailfrom=redadmin.org; dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b=rT9w5P0J; arc=pass smtp.client-ip=157.107.129.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redadmin.org
Received: from localhost (localhost [127.0.0.1])
	by www.redadmin.org (Postfix) with ESMTP id E497B10A2494E;
	Tue,  9 Sep 2025 14:36:03 +0900 (JST)
X-Virus-Scanned: amavis at redadmin.org
Received: from www.redadmin.org ([127.0.0.1])
 by localhost (redadmin.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MqA_TB_5KTOK; Tue,  9 Sep 2025 14:36:00 +0900 (JST)
Received: from webmail.redadmin.org (redadmin.org [192.168.11.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: weibu@redadmin.org)
	by www.redadmin.org (Postfix) with ESMTPSA id ADC1610A2494C;
	Tue,  9 Sep 2025 14:36:00 +0900 (JST)
DMARC-Filter: OpenDMARC Filter v1.4.2 www.redadmin.org ADC1610A2494C
Authentication-Results: www.redadmin.org; arc=none smtp.remote-ip=192.168.11.50
ARC-Seal: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space; t=1757396160;
	cv=none; b=OakdlDd8eSlpFf3mVhV/CVbXRmVY8S8lJiwoFo76t2LXoEKvCEsTB761t/kPtmLRzwri54GRu0U4ujNNrPpDmLCfMyf7WU9eURPO1Mg1+qFFyFcMEmKqxufTiAm6U76tx9n7R8gQOIRUl/sOO6u15G+tMdnGfLtgiUtX6BYASd4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space;
	t=1757396160; c=relaxed/relaxed;
	bh=z0UvudrzHbTC1zF9TFR5boSXeqo8L7QbwJaDwPvBEqk=;
	h=DKIM-Filter:DKIM-Signature:MIME-Version:Date:From:To:Cc:Subject:
	 In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding; b=s0FvvJB3013Q2gfiBdzbYRX1zrDCwsq/IoRNLRyZjBOFX1EoPRMJ/oe4bmM7USGlXlB+BJZk6d/y8m6vqkmC5hT+3B/vUEE9BOP7Nu3KhILk2mM3bPHo3m5erOqVbhs8GZXW8HWYqT2ZH8+S+etwdWFNNYUw568GCtyqEFUpcPI=
ARC-Authentication-Results: i=1; www.redadmin.org
DKIM-Filter: OpenDKIM Filter v2.11.0 www.redadmin.org ADC1610A2494C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redadmin.org;
	s=20231208space; t=1757396160;
	bh=z0UvudrzHbTC1zF9TFR5boSXeqo8L7QbwJaDwPvBEqk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rT9w5P0JNYaJ5yIm6ZyvGxQykgMbfWdqyM3TAu5i0XZkpslOIcKbMEKW1RczhuyxR
	 PjozzT9k7r09j66SeQ5tAZQuXNccqWUC9HRAhIg6+OQcQfmVhP+v0oqt5fZkX/ZSig
	 YP89jATvQkL+vme216gJ23x3VPGfH8833DDDw90g=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 09 Sep 2025 14:36:00 +0900
From: weibu@redadmin.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: rtw_efuse.h: simplify copyright
 banner
In-Reply-To: <2025090917-tribute-dividers-abd6@gregkh>
References: <20250909035804.129904-1-weibu@redadmin.org>
 <2025090917-tribute-dividers-abd6@gregkh>
Message-ID: <7cba51d1668a9efaacd59b1bb64e32b3@redadmin.org>
X-Sender: weibu@redadmin.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

Hi Greg,

Thanks for your feedback. You were right — I had mixed two changes in 
one patch.
I’ve now split them and resent as v2:
   [PATCH v2 1/2] simplify copyright banner
   [PATCH v2 2/2] fix double space in PwrState parameter

Sorry for the noise, and thank you for your review.

Best regards,
Akiyoshi Kurita

On 2025-09-09 13:43, Greg KH wrote:
> On Tue, Sep 09, 2025 at 12:58:04PM +0900, Akiyoshi Kurita wrote:
>> Replace the banner-style copyright comment with a single-line comment.
>> No functional changes.
>> 
>> Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
>> ---
>>  drivers/staging/rtl8723bs/include/rtw_efuse.h | 9 +++------
>>  1 file changed, 3 insertions(+), 6 deletions(-)
>> 
>> diff --git a/drivers/staging/rtl8723bs/include/rtw_efuse.h 
>> b/drivers/staging/rtl8723bs/include/rtw_efuse.h
>> index 669565fa1c69..d791e35db769 100644
>> --- a/drivers/staging/rtl8723bs/include/rtw_efuse.h
>> +++ b/drivers/staging/rtl8723bs/include/rtw_efuse.h
>> @@ -1,9 +1,6 @@
>>  /* SPDX-License-Identifier: GPL-2.0 */
>> -/******************************************************************************
>> - *
>> - * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
>> - *
>> - 
>> ******************************************************************************/
>> +/* Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved. 
>> */
>> +
>>  #ifndef __RTW_EFUSE_H__
>>  #define __RTW_EFUSE_H__
>> 
>> @@ -95,7 +92,7 @@ void EFUSE_GetEfuseDefinition(struct adapter 
>> *padapter, u8 efuseType, u8 type, v
>>  u8 efuse_OneByteRead(struct adapter *padapter, u16 addr, u8 *data, 
>> bool	 bPseudoTest);
>>  u8 efuse_OneByteWrite(struct adapter *padapter, u16 addr, u8 data, 
>> bool	 bPseudoTest);
>> 
>> -void Efuse_PowerSwitch(struct adapter *padapter, u8 bWrite, u8  
>> PwrState);
>> +void Efuse_PowerSwitch(struct adapter *padapter, u8 bWrite, u8 
>> PwrState);
> 
> This doesn't look like a copyright banner change :(


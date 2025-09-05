Return-Path: <linux-kernel+bounces-803257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D4DB45CB5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 290F31BC274B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991E72FB0A6;
	Fri,  5 Sep 2025 15:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b="SFbAhKrJ"
Received: from www.redadmin.org (ag129037.ppp.asahi-net.or.jp [157.107.129.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABF72F7AB5;
	Fri,  5 Sep 2025 15:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=157.107.129.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757086607; cv=pass; b=Q2q27a1ouil+BjEQOigDJFkX/4oMFt8xbLB1Li+HVvFkiGDbD2FtxTidu2qln3S41ol/51i/Rt+xwQ3G8iMYuZokLLGSDYyp1KStf3TgM3HB7fFlMU2PShqXEfsEArmdLwGsURwKy0UJfBBYcsc5MB2Cc5WgTHXjai6Jocm7uHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757086607; c=relaxed/simple;
	bh=Odry3R6bS1eAPQGsgTzOfdP6nZUl5g4nQsM0O34G8I4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=M5Y4L79FDtgSagFgBNUxn8dUtIP5jf9AHE26LufMO7rWuuiHX3vUIAMLlAlEuCXU2sTEtODR71WgurKAzdErwlWyn4Ky8byuTm9NUxAmJyABYV8hxXJxQvHWQwkvGrARIUqiuTMiasXseGvQuVfIOq8+7uEXLrZ75+lN/ye3znM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org; spf=pass smtp.mailfrom=redadmin.org; dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b=SFbAhKrJ; arc=pass smtp.client-ip=157.107.129.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redadmin.org
Received: from localhost (localhost [127.0.0.1])
	by www.redadmin.org (Postfix) with ESMTP id 1B7F0109D5675;
	Sat,  6 Sep 2025 00:36:42 +0900 (JST)
X-Virus-Scanned: amavis at redadmin.org
Received: from www.redadmin.org ([127.0.0.1])
 by localhost (redadmin.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vqmMf98r-Zyc; Sat,  6 Sep 2025 00:36:38 +0900 (JST)
Received: from webmail.redadmin.org (redadmin.org [192.168.11.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: weibu@redadmin.org)
	by www.redadmin.org (Postfix) with ESMTPSA id 1F7E9109EFCDE;
	Sat,  6 Sep 2025 00:36:38 +0900 (JST)
DMARC-Filter: OpenDMARC Filter v1.4.2 www.redadmin.org 1F7E9109EFCDE
Authentication-Results: www.redadmin.org; arc=none smtp.remote-ip=192.168.11.50
ARC-Seal: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space; t=1757086598;
	cv=none; b=UQe7sIMnmpygKUu6f0Z4NOIE3rbil4S/pD9sDY9CBUyeM+c16qC4Y0m2WhFiT/SJXWtvz2yXprvfYrwCxF5nY/XhTPyxr/okAhm6VYjfDPyIYXK5bHcNFRyg3BDJ90joxg3uKqq+QjVEYSTFB94fm19+4cNBdDkSe3v+MVq1xsU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space;
	t=1757086598; c=relaxed/relaxed;
	bh=3D+SPF+6ZhBelny5po/Ar3EvbsOnw9N45aR/eUFC7ww=;
	h=DKIM-Filter:DKIM-Signature:MIME-Version:Date:From:To:Cc:Subject:
	 In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding; b=eD2bJltBytMrM3cHidoRkmMFuScyZvp5voi3TpWaCAdCd1pYut+RYjFk3af6HW/cN/4wYCNp10ga7xj2Eyi08GDtcDvCYDMF0quz137XRp7YGmNbZQ5TofsALmr2LI6fUH3ark4GMQGDcY/QbWEM+jkHRo8avR9MFeM+ck8wOEI=
ARC-Authentication-Results: i=1; www.redadmin.org
DKIM-Filter: OpenDKIM Filter v2.11.0 www.redadmin.org 1F7E9109EFCDE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redadmin.org;
	s=20231208space; t=1757086598;
	bh=3D+SPF+6ZhBelny5po/Ar3EvbsOnw9N45aR/eUFC7ww=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SFbAhKrJATOaqlmDsCkoueGvbkyKr3pnLGK4567JzpNnUynfHHC7vBmi9HD13ITks
	 wPqZ55ovfDYXbWw+zOl2pbHmwf3vuNEK2EXyTPqTSHk/989Gn8drE1WoEUksXouoAg
	 J/8IE7TO828Vgjvgdy3fU5IsELkJ7AXVZaKRzA/U=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 06 Sep 2025 00:36:38 +0900
From: weibu@redadmin.org
To: Akira Yokosawa <akiyks@gmail.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, corbet@lwn.net
Subject: Re: [PATCH v2] docs: ja_JP: SubmittingPatches: document the 'Fixes:'
 tag (+example)
In-Reply-To: <cd17b8f5-b5f2-4d9a-87af-04ecb2a235ba@gmail.com>
References: <20250905032729.2284883-1-weibu@redadmin.org>
 <20250905111403.2338934-1-weibu@redadmin.org>
 <cd17b8f5-b5f2-4d9a-87af-04ecb2a235ba@gmail.com>
Message-ID: <c5a767e4d064cee8092b79ebc30e9cb0@redadmin.org>
X-Sender: weibu@redadmin.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

Hi Akira-san,

Thank you very much for your review and detailed feedback.

I will update the Fixes: example to use a consistent 12-character SHA-1 
hash.

I will also move the Link: line under the --- separator, as per 
convention.

To clarify: v2 was intended as a full replacement of v1, not something 
to be applied on top of it. I’ll make that explicit in the changelog 
section for v3.

I’ll prepare and send a v3 patch early next week with these corrections.

Thanks again for your guidance, and have a good weekend.

Best regards,
Akiyoshi Kurita

2025-09-06 00:14 に Akira Yokosawa さんは書きました:
> Hi,
> 
> On Fri,  5 Sep 2025 20:14:03 +0900, Akiyoshi Kurita wrote:
>> Sync the ja_JP translation with parts of:
>>   - 8401aa1f5997 ("Documentation/SubmittingPatches: describe the 
>> Fixes: tag")
>>   - 5b5bbb8cc51be ("docs: process: Add an example for creating a fixes 
>> tag")
> 
> Consistent SHA-1 hash length would look nicer.
> 
>> 
>> Link: 
>> https://lore.kernel.org/all/20250905032729.2284883-1-weibu@redadmin.org/
> 
> This link to v1 needs to be under the "---" below.
> 
> Wait, do you mean this patch is supposed to be applied on top of v1?
> 
>> Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
>> 
>> ---
>> v2:
>>   - Add explanatory paragraphs from 8401aa1f5997 (purpose + stable 
>> note)
>>   - Keep example and pretty-format from 5b5bbb8cc51be
>>  Documentation/translations/ja_JP/SubmittingPatches | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>> 
> 
> I think I need to be more clear on what I am expecting.
> I'll send a follow-up comment early next week.
> 
> Have a nice weekend!
> 
> Thanks,
> Akira


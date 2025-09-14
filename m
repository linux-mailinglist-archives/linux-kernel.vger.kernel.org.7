Return-Path: <linux-kernel+bounces-815709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 607E6B56A3B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 17:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 270F417BC97
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 15:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B0B2DAFC7;
	Sun, 14 Sep 2025 15:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b="Dd4hd1d7"
Received: from www.redadmin.org (ag129037.ppp.asahi-net.or.jp [157.107.129.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B599726E6F4
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 15:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=157.107.129.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757863755; cv=pass; b=R8q5HCMbYgbLmGJnmCMRWojJmFXgWrD9FVAIyfAzgGBrekJQjUu/Uf99KDlmReR/EmY7j0OmyzN9IJ11K8b/n15595IjiFvdxWw0Ja7AutYX7P0NoViFW0o8eFh9uL5qx+k/D59sJz/lOsrJKZRKEFt/5mF1LAMPxgatXtMC9gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757863755; c=relaxed/simple;
	bh=3IbcCx+AzyrNphEQIcDTAkdn1N1em1rTzkiZ6HKjbc8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=slFIS9KqPJLPI7YQPvk8WZXZcsxrs+T6ZQ8SpDdQESxbEz9SdxWt1Vp3oyQWMnd2KxIkAT3KA3MmPw7jgda0fZ9W5qXYj8Ut4uANeJI8zjG/DhuMkSh27UTQQUYDx92+LoGjqe7aNOc7XU+h2g0PB4xL3Q3D3qfdnhHWhdz7Sy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org; spf=pass smtp.mailfrom=redadmin.org; dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b=Dd4hd1d7; arc=pass smtp.client-ip=157.107.129.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redadmin.org
Received: from localhost (localhost [127.0.0.1])
	by www.redadmin.org (Postfix) with ESMTP id AA0F110B40B64;
	Mon, 15 Sep 2025 00:29:04 +0900 (JST)
X-Virus-Scanned: amavis at redadmin.org
Received: from www.redadmin.org ([127.0.0.1])
 by localhost (redadmin.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KDMaOXrOWeDG; Mon, 15 Sep 2025 00:29:01 +0900 (JST)
Received: from webmail.redadmin.org (redadmin.org [192.168.11.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: weibu@redadmin.org)
	by www.redadmin.org (Postfix) with ESMTPSA id 0EC30109D55C3;
	Mon, 15 Sep 2025 00:29:01 +0900 (JST)
DMARC-Filter: OpenDMARC Filter v1.4.2 www.redadmin.org 0EC30109D55C3
Authentication-Results: www.redadmin.org; arc=none smtp.remote-ip=192.168.11.50
ARC-Seal: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space; t=1757863741;
	cv=none; b=eG7Am4rUAHxQanyz5AOdYQFhTRe1HEoGQvkv6cJVzpNyk3dSwao0HsCBJsrk53BmDbbTV2BT8Xv/PrM59D5SGiHAyU7BrQk/LEp/4kKfjTGiXmeRaB6ZgS1lfBjyKRnEpbDK6AnpIAsa6cIG0S9agg5r5l3A5k7BUqWNAmCJEHY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space;
	t=1757863741; c=relaxed/relaxed;
	bh=IG/wxvFjZ4KF1WA6DzU9Avkd2drHlzCGrrowgiuJ+yg=;
	h=DKIM-Filter:DKIM-Signature:MIME-Version:Date:From:To:Cc:Subject:
	 In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding; b=OLyGn81QNDE5TGf+3wQr3dF5CwJSSZKu2ryECmODDCfkR8O91iQPJUWa9BKYqVh04iZTJcGqc00RJNTwla0obimUdDJahC201BLMEzrdfvRI8I7Y7Ar3JLoPQgsTBLJahiGtYyiA1o2zu1Jo8hrW4i3mjcwCd19f3A2eK4CF8ZE=
ARC-Authentication-Results: i=1; www.redadmin.org
DKIM-Filter: OpenDKIM Filter v2.11.0 www.redadmin.org 0EC30109D55C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redadmin.org;
	s=20231208space; t=1757863741;
	bh=IG/wxvFjZ4KF1WA6DzU9Avkd2drHlzCGrrowgiuJ+yg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Dd4hd1d7YN090V777FZrg+E09AWr2lywkVZq8Z6rDNl9rsxTZM5xhrlb6GOGWWcUr
	 Q6zuO+u5yRAikJj/I6R/tttQfacvbG7QMBVG74oHm3jbrCe9Y1IZK2gjc//x3fB0bq
	 2D+TwVnT1Af03BUrt82E9VGbPIIcxOZm+uIPBzu8=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 15 Sep 2025 00:29:00 +0900
From: weibu@redadmin.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: rtw_efuse.h: Fix prototype whitespace
In-Reply-To: <2025091454-popular-overall-9864@gregkh>
References: <20250913112458.910059-1-weibu@redadmin.org>
 <2025091454-popular-overall-9864@gregkh>
Message-ID: <1d0fdc3bde254057539b7e8506d0c211@redadmin.org>
X-Sender: weibu@redadmin.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

Hi Greg,

Thanks for the heads-up. That patch was generated against linux-next
(next-2025-09-12). I’ll rebase it onto your staging.git 
`staging-testing`
branch and resend it as v2.

Thanks,
Akiyoshi

2025-09-15 00:09 に Greg KH さんは書きました:
> On Sat, Sep 13, 2025 at 08:24:58PM +0900, Akiyoshi Kurita wrote:
>> Several function prototypes in rtw_efuse.h contained extra spaces
>> between the type and variable name of the last argument.
>> 
>> Remove these spaces to conform to the kernel coding style.
>> No functional change is intended.
>> 
>> Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
>> ---
>>  drivers/staging/rtl8723bs/include/rtw_efuse.h | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> This does not apply to my current tree, what did you make it against?
> 
> thanks,
> 
> greg k-h


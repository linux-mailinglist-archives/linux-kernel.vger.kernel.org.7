Return-Path: <linux-kernel+bounces-791713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A76B3BA7F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 14:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D4CC188FD14
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 12:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5618D311957;
	Fri, 29 Aug 2025 12:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bcc.bai.ne.jp header.i=@bcc.bai.ne.jp header.b="Cv9hQKSQ"
Received: from rmx-a.mailgw.jp (smx-a.mailgw.jp [210.171.6.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9002D0C8E;
	Fri, 29 Aug 2025 12:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.6.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756468836; cv=none; b=pfZwCqZVAsTSbiWP/yzrQwuMGtXjDtpGxWNWanVJn/Llk1XlH84Bol+Bzhb2ZmFWzMV2mPUSkuIsnNrMV5RoexoAaJQTHgqLTfAXchgKkQSNi1mdThkkbzwDPM+uax6kkL8iu/fXH17aUy1Oln4RHLva7fiaZrw5xUiAA4O/KKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756468836; c=relaxed/simple;
	bh=JKCmRsH4/jUUBuCHPbYIajZSeQ1SmRMLWrveK+Ykvn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t2lNWJgqi0CYzXA9BOjWu1YFQlHHcIwZjXxUgFKo4scAYw/x9j+FRv8DE4bLfWXPwAPfBq3ZbAr6x6AnBeRhsbxHcnYov+sBI3MoF0XM+dDnbxseUMo9Mn+h75Gn/T0aGfUZMry05zhX8QyJdMCbw7pUIYuAiefjicYb7lPlsXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bcc.bai.ne.jp; spf=pass smtp.mailfrom=bcc.bai.ne.jp; dkim=pass (2048-bit key) header.d=bcc.bai.ne.jp header.i=@bcc.bai.ne.jp header.b=Cv9hQKSQ; arc=none smtp.client-ip=210.171.6.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bcc.bai.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bcc.bai.ne.jp
Received: from bccml.bai.ne.jp (bccml-a.bai.ne.jp [210.171.3.161])
	by rmx-a.mailgw.jp  with ESMTP id 57TBxvln023337-57TBxvlo023337;
	Fri, 29 Aug 2025 20:59:57 +0900
Received: from [192.168.11.5] (bai859bcd79.bai.ne.jp [133.155.205.121])
	by bccml.bai.ne.jp (Postfix) with ESMTPA id 4964881773;
	Fri, 29 Aug 2025 20:59:57 +0900 (JST)
Message-ID: <0b061e42-0a01-4839-871c-a5d760dbddeb@bcc.bai.ne.jp>
Date: Fri, 29 Aug 2025 20:59:57 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: rockchip: Enables sound output from the
 audio jack on OrangePI5 Plus
To: Maud Spierings <maud_spierings@hotmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, heiko@sntech.de,
 krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-sound@vger.kernel.org, robh@kernel.org
References: <20250826134456.9636-2-opi5plus@bcc.bai.ne.jp>
 <AM7P189MB1009A67370CA029038DF2A69E33BA@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Hide Hako <opi5plus@bcc.bai.ne.jp>
In-Reply-To: <AM7P189MB1009A67370CA029038DF2A69E33BA@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-FE-Last-Public-Client-IP: 210.171.3.161
X-FE-Policy-ID: 3:1:2:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=bcc.bai.ne.jp; s=20240516; c=relaxed/relaxed;
 h=message-id:date:mime-version:subject:to:cc:references:from:content-type;
 bh=qkU1RGbl9BVgABIuUMMvRh0yoQdtBqyMhXOop0bDDvs=;
 b=Cv9hQKSQCoZXlO1FE5xL0R85p8woA96QjvXwvKYl5Yc+czjzgJS0+oTG1I1nUUDd0m2JRdQhBLI9
	g1BbClQhUZnjXIVsZ2kCQX99UrNk8AREPpCRCGtQ35C3zb3LxYwh9gk8smjmwRzEn1WASS68EkPO
	H+1ldF5wz4Yi/xklxpPCmUo6AY/avLbM0Ms0qLPJQ4Gc1o1rhzU2CiR6jnMA+hJajJFC7ZS2UsiR
	iLTqohar4uvZOcbW7uHBzghECQY+LHvzq1Fy0thTV3SplTbShWT0OMdWs7QPKn4j4bLAkOl1DeMs
	PPiga5mOWTA1GaWIlA6x5oWHuUcHSm2w+AyMEg==

Hello Maud,

On 2025/08/28 17:47, Maud Spierings wrote:
> I recommend rebasing on the latest next since my fix [1] was applied.
> I also recommend testing it with that patch, for me that fixed the 
> headphone detection and enabled audio playback. The microphone is not 
> working yet though.
>
> Link: 
> https://lore.kernel.org/all/20250823-orangepi5-v1-1-ae77dd0e06d7@hotmail.com/ 
> [1]
>
Today, i build linux-next.
But sound not come out from headphone.

If you test the 6.17 kernel after using the 6.16 kernel, sound will be 
output. Try building and testing in an environment with only the 6.17 
kernel.

Or is it okay to use the JMB582 "M.2" nvme-sata 3.0 expansion card to 
connect a 2.5-inch SSD?
This makes disk swapping easy and convenient.

Hide




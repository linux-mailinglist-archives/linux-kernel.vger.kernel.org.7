Return-Path: <linux-kernel+bounces-886557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00176C35EF5
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 14:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 630363A2120
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 13:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E944324B30;
	Wed,  5 Nov 2025 13:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="tC6QKNpA"
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31886315D32;
	Wed,  5 Nov 2025 13:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762350812; cv=none; b=FDX4Lan9zZE3iFffovfaZDliIezNSme4cFKH9RvOtm2j8HSfWy61PwkPOrwQyR/LdrnaefJHufujEsophesws0TYwG9oogqLknVB5gvYyxKWmKyOFnU2ym2J5f5LqBBunddeopI05zOpScPQxnrbN31idF1ZKCPpuk0aJJ5T5ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762350812; c=relaxed/simple;
	bh=6d9IcH2OicdCKalg9vvKq5SuiuYmnSJLGBtauMRG4Bo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DBo9Ez1AI/y5bQqmNDfO+r7v8qviSiHR4i9tjwTxN25XqKC5/6gw6i1aTctrsI7cuxLOJQ9jP9wOKm68kjJOrSjO6TRvKJVw1/MvKX7vJ/orbzh4feqomTZVmh398Wtcj1TPqkZZIvWbf60iy3bL8CL+Y8yzlS3uej9SuOpIrCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=tC6QKNpA; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4d1mxW3ft4z9tfs;
	Wed,  5 Nov 2025 14:53:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1762350800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JbLI4yPdwxmQiBQFMSIwAXMLWFoiw+0UcA/s0AWrkCk=;
	b=tC6QKNpAaZh/R6wYAMcWKzg3amV9m6DcsjgUGZu67sYGCARdZhdDPd0Q9Dho3irtoKMKvt
	P4yh61te4HZGqLGantm5Q2mPUwW+G63MRCyZzq4EMli4HqlraYW3o+/EB9diXJrCzfqwlO
	fzaRFaHMDc8obQS9oCPiZUKWvRQql7dRCslDjXvAvg4xhjuFhHFcB8tyoM/3IY3qpK13dh
	WhDMj8Q01pYmSRD7c2BGyC3jDZ6s0g1fGbOWngPv7oWbRQ+mBikHLVYmJhlz7r7Jmmo+SP
	JYhAxvwvId+jfk05GkyJWHgRbHiXSMYu4qA0lmw0knf3/FFUjyQasquPK1ZCOA==
Message-ID: <65e61291-d02f-42f8-b627-6e622cf5c7e3@mailbox.org>
Date: Wed, 5 Nov 2025 14:53:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] dt-bindings: eeprom: at25: Add Anvo ANV32C81W
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: devicetree@vger.kernel.org, Christian Eggers <ceggers@arri.de>,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Markus Heidelberg <m.heidelberg@cab.de>, Rob Herring <robh@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20251105023138.68340-1-marek.vasut@mailbox.org>
 <20251105-omniscient-deer-of-glory-ddd1fe@kuoka>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251105-omniscient-deer-of-glory-ddd1fe@kuoka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 1fd80bc1b93fc2e0162
X-MBO-RS-META: fxhdojz9tsg4mweqt8gs5zkmfmuga9wd

On 11/5/25 10:26 AM, Krzysztof Kozlowski wrote:
> On Wed, Nov 05, 2025 at 03:31:17AM +0100, Marek Vasut wrote:
>> Document the compatible for ANV32C81W 256kb Serial SPI non-volatile SRAM.
>> Although it is a SRAM device, it can be accessed through EEPROM interface.
>> At least until there is no proper SRAM driver support for it.
> 
> There is no user of this binding, so no need to document it. If there
> is, but somehow hiding from my sight, please use the changelog part to
> explain such less usually details.
The user is coming in the next few days or so, do you want me to 
(re)post it all together as a series ?


Return-Path: <linux-kernel+bounces-666587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6AAAC7922
	for <lists+linux-kernel@lfdr.de>; Thu, 29 May 2025 08:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1470189C048
	for <lists+linux-kernel@lfdr.de>; Thu, 29 May 2025 06:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5672566D9;
	Thu, 29 May 2025 06:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UPf7xsKz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE9725229E
	for <linux-kernel@vger.kernel.org>; Thu, 29 May 2025 06:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748500887; cv=none; b=XRuZFpvOTOROuYI2DUyRTtQtmo7gz1OizZzReudRHABK8VRwYrQuzWlP4nTU1afhunPMHT30fwfrpG+N+RCPEtS74uR3ZrtasSKdiLjhhF6zEIorERRw+YRXNop+RDbgH8bsOkwpQWYf6EoYgqsJhMIUVhsplnyH0aZiQnt9arI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748500887; c=relaxed/simple;
	bh=uo6zWtMJAmsChlsFAzrq8E9fCgS8gXBxbYq/eth/kWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cEgQFQJDFHmPnrbrPj1zCME4ahH5ymEg7fIQ/tre2/B5JZlSb9m54ad8h9c7C/yRO/SVUqOw+ll8N47kZwu7YautUCCbJXRMnNThYhCcbzn/fKh4u2pQwAmNdwoTYc575XmmlSES7hFMFqgxRGfHGslhY+ddjw+FrbOGwPrU3Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UPf7xsKz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748500885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9gZ8u/vWknXqeMvhMYoZse25X6ebh82JRFp9N4VCxqk=;
	b=UPf7xsKzYABpkxeUyDePSTbs6E9MnkX2E0KJ5mjhVZxqOftdxPBMkMczr0yoA+dbMZwJj7
	NlnsaEwoLhUp3ZsdEJWGrjAg2j3WEVvENMHjKibWKiWK6dhNvZvEay6vVGQVl7Q76kQaHF
	izTqssu8Sp2P8ZKPPNmJcF6DiNReRsE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-f_Dvg7ZAOhyr8aga1J69qQ-1; Thu, 29 May 2025 02:41:23 -0400
X-MC-Unique: f_Dvg7ZAOhyr8aga1J69qQ-1
X-Mimecast-MFC-AGG-ID: f_Dvg7ZAOhyr8aga1J69qQ_1748500882
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4dde7eec6so318656f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 23:41:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748500882; x=1749105682;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9gZ8u/vWknXqeMvhMYoZse25X6ebh82JRFp9N4VCxqk=;
        b=XwOLYLcDNQEQmGskktL3yTMtpTmtT29aR5sOlTCIEch9XK5lMmSl78GIpQsE/PidFZ
         nA7cMaaUNqvhUCrow0zpRPbXB0oiODNHia3Bm8H/iIAKCIvcTZQQcgYgnjh+vgrdmNQy
         7G4IjGNLOOxzx24vi+L7CzREX30bddHhKNBD6ujVuzoCglOUYGist0U7rNG/dSUy3A8R
         eSvSY7eAu3Wxeo4Hqqej67bqd9tBXTpdW0WG+kO22JMS8VzEhvoDTaBGBOXuVgDOL1UY
         3baLQV0Ru/HBGqNm/94uJ1l/g4JZcZrmk6VbhYGG0qAFVL6yp7MhdO0lalL9EqONbp8W
         isGg==
X-Forwarded-Encrypted: i=1; AJvYcCUobFN51aVm5lIG11DrdfZbXy/JJMsSUZUk8fVTEKblPJkizHRkzNtq9pPrJBL1DMNN6Pmwzi15GSwwuek=@vger.kernel.org
X-Gm-Message-State: AOJu0YydKkHrMX4/07/pHBpZaR+BSO0JWFCml7FbxoI+eKOWj6h1Fdju
	Jvp9xvijpvIMBrrM9z9nC9lJ3+/Ud53P71TY51TMpcaPMRNZm+tya73a5mZzDXUc/5NNBUnvGa3
	I9m/g4Oqvq+1l334jD0akyVd2PSpTkSTIPSV+IO7JsUcNF8xoeH1/vAIesbicNqKMNQ==
X-Gm-Gg: ASbGncsO3M6aYRN2Irc87WxC+LRoFvpyr6xnlGdAftIIlf5dd73elufE7Ksw3PNXl/W
	Ceg/riLfSI516dJOCjlvwPmYFIQW0TJHHEmXFdEBn15Tt8DQ74Y3QSt0s1GL68dnjrDLD2cqtcL
	q8sEQxVYjgAqAa+ECBToo7vxYLPMNawOuh9Jf5SFCKMVATCjcGNluliaecLe+X0OtlY9vXqVP0i
	W4KxpXfN2gOB6CDQ5FjGfO6TcxSpPG1sZEqtc8j0aK/gnRNvgGlOZbSfiIulaXO612Z7+iwgpmU
	DS7oY1T402HrP0WqrJacCqb8doY30sYiGxGjQCn0ummdnj6Dk6tmO2PMq1E=
X-Received: by 2002:a05:6000:381:b0:3a4:e4ee:4c7b with SMTP id ffacd0b85a97d-3a4f358f0camr603428f8f.15.1748500881764;
        Wed, 28 May 2025 23:41:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4WDum86fTnMvRYqch6MR+ztEYQ2eZPtIMANK31N5JRpHf3kQXQ5zQS9pHaQJE0QCeX7DRPw==
X-Received: by 2002:a05:6000:381:b0:3a4:e4ee:4c7b with SMTP id ffacd0b85a97d-3a4f358f0camr603408f8f.15.1748500881399;
        Wed, 28 May 2025 23:41:21 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cce5:2e10:5e9b:1ef6:e9f3:6bc4? ([2a0d:3341:cce5:2e10:5e9b:1ef6:e9f3:6bc4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f00971efsm1015064f8f.62.2025.05.28.23.41.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 23:41:20 -0700 (PDT)
Message-ID: <21c1b2d9-1b94-4caa-aa68-8abbb6562446@redhat.com>
Date: Thu, 29 May 2025 08:41:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next,v6] net: mana: Add handler for hardware servicing
 events
To: Haiyang Zhang <haiyangz@microsoft.com>, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org
Cc: decui@microsoft.com, stephen@networkplumber.org, kys@microsoft.com,
 paulros@microsoft.com, olaf@aepfle.de, vkuznets@redhat.com,
 davem@davemloft.net, wei.liu@kernel.org, edumazet@google.com,
 kuba@kernel.org, leon@kernel.org, longli@microsoft.com,
 ssengar@linux.microsoft.com, linux-rdma@vger.kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, bpf@vger.kernel.org,
 ast@kernel.org, hawk@kernel.org, tglx@linutronix.de,
 shradhagupta@linux.microsoft.com, andrew+netdev@lunn.ch,
 kotaranov@microsoft.com, horms@kernel.org, linux-kernel@vger.kernel.org
References: <1748382166-1886-1-git-send-email-haiyangz@microsoft.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1748382166-1886-1-git-send-email-haiyangz@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/27/25 11:42 PM, Haiyang Zhang wrote:
> To collaborate with hardware servicing events, upon receiving the special
> EQE notification from the HW channel, remove the devices on this bus.
> Then, after a waiting period based on the device specs, rescan the parent
> bus to recover the devices.
> 
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Simon Horman <horms@kernel.org>

## Form letter - net-next-closed

The merge window for v6.16 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations. We are
currently accepting bug fixes only.

Please repost when net-next reopens after June 8th.

RFC patches sent for review only are obviously welcome at any time.



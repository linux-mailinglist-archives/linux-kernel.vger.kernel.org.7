Return-Path: <linux-kernel+bounces-743984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA1DB10688
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D86631CE6920
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0098285C86;
	Thu, 24 Jul 2025 09:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eQGQQ2nW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9922D46D8
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753349391; cv=none; b=TAFJtGGBqIhMEzYJUPUehW01DMZ61Ayt861SCKq9dE9mN5nq/Zpu4ZhQdJhBY0BULLgPO3DnLy1kRBeSq/KgkF6eLA8kqBJqeKjpFxzxUl5522TVeGFYeVeQfHstbXzPxOMefPVBeiwOpbDlXmjELZjRZQYqFOvf10f/CluF3bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753349391; c=relaxed/simple;
	bh=COy83tWwM4souj8Dt40LunOOP/o/rdXvf4yrQ2AELEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W6k33PErcorYzk89ACGKtZgC3NsxjUrH4WIPY5cd75ahX19GUWOGGUNlWxld5Qv7cTTA1Ipa01551UAh08oca8e9HDf3hGzDjIfnQuiyeUihcIUhH8MBzODhZdoD6oQkzqhkG8ttzEaK4FV/mwt6ykp2EGxiLIrB339vnxDaTKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eQGQQ2nW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753349388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=COy83tWwM4souj8Dt40LunOOP/o/rdXvf4yrQ2AELEA=;
	b=eQGQQ2nWW7/eh3rIbi53Oc9L0B+gbfEsCv2Mcc5mjJPh9OdrO57sR/Shj+Uy5rotXVXrVS
	Va0TrPBsp4cGWQPTDtYE+uVdhzV938wh1UPPFyp9/VG2NCbFokZ4E/GPNtIvBiPzNs2Q8b
	fy5ckhoDdDrCS013sRFf+j3+K7lRP1k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-2b7yYcN2Ni6e-gVKmAEyXQ-1; Thu, 24 Jul 2025 05:29:46 -0400
X-MC-Unique: 2b7yYcN2Ni6e-gVKmAEyXQ-1
X-Mimecast-MFC-AGG-ID: 2b7yYcN2Ni6e-gVKmAEyXQ_1753349385
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-451ac1b43c4so3829085e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 02:29:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753349385; x=1753954185;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=COy83tWwM4souj8Dt40LunOOP/o/rdXvf4yrQ2AELEA=;
        b=JbS06HyxiYbdr09DxaOUjA5Zkrkl8iV5vkOGvUrf8c0RS+EfwesReoz1ZG8QSETZWU
         WiaG5kumQMvmZpHJ1PCZUFFrp2C+NKRXmesr8ly236pM+ItFhilSutFJjIFgPKu6TPjX
         sxsiD0rr2VR4Ng4btA1ixcW2SwZ58taI3atIdxwqVnOTU2cMcvb98zJDOtqn0QYG4biZ
         AReAJq2eV5ITj+JsO9I0ksEU2DHRIoxSzrGGKlvv91mpDueuzRa9z9mPqWVAcMNOkFwp
         IRj7aEmn77eGIOL7OurDU5kzMeEAygfHghFWwG8JJNtt5Odn+3th7c9FTbca6YLaJwOD
         1RSA==
X-Forwarded-Encrypted: i=1; AJvYcCWI6sR6orygDKM7OCrK1Nra+MREN8k/JnZvO/YkN4lQtV3R1aHEHUuXjcUOpTwFnZ82NxqfiVEogsQUGiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXBgBq1g/v43vWLJil8ALn4p0POdFiMJrjk1xeW3swocK4e9OW
	FMfXLQ4lat5EtZd7Vb7UrvXezJFLyKGqzZBIxEVBOx/960/zmkbzMmykAvOLoHd6KWG2JpSxEBu
	XaUJrAkaNW1Sdds2aBGmN3622ZwwK5LxkNahRtKHciliGBoRKXBlKGvX7FjBTcsPfKw==
X-Gm-Gg: ASbGncv++Cbt+zUV8c6Xe28xcHWEYLtHYaZL+mpSWEZtGd+9D+fKR9lf67vebuLH6Vb
	6tq1IgrPJfQ7HLxbsKEF3mEGeSjFGac15xaYNKFdL3lvu2eStpwNrhhYof0jFr7IfJYt4ctX8HJ
	kfDs7i2tguozJpt8QeBOp1g7p0w0pUixPTkGVHCrl2I92YrQ4/i8/3f8RG9Zi1/pX6pVrQQSxIl
	U9mxsv3HhKDk6mKUeubShEX/va4EAdJg/YbSC8hILO5Wl5JJa4j8H8boIaxDiXl1qGIEwT8onvd
	XNe4oMuFjH1nzTZhMcEKvF49SIhuNPBaEjZ0PKTfz/bDkmO4VAESmHVeLvJIlTLo7u2iZ7Ue5ym
	5BjBttg6NN9s=
X-Received: by 2002:a05:600c:6085:b0:456:207e:fd86 with SMTP id 5b1f17b1804b1-45868c9151dmr56874995e9.2.1753349385156;
        Thu, 24 Jul 2025 02:29:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBDCtOdNtOOjUer8U/bVwafMO6zqzIY2wA51iUL1BDNrL8+9tX2KQFb/3D9W5WVuxG+nKEQg==
X-Received: by 2002:a05:600c:6085:b0:456:207e:fd86 with SMTP id 5b1f17b1804b1-45868c9151dmr56874635e9.2.1753349384672;
        Thu, 24 Jul 2025 02:29:44 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4586f88ce71sm12109225e9.0.2025.07.24.02.29.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 02:29:44 -0700 (PDT)
Message-ID: <08f2d147-5a49-43f0-b698-6ededd7c93ba@redhat.com>
Date: Thu, 24 Jul 2025 11:29:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 net 0/4] There are some bugfix for the HNS3 ethernet
 driver
To: Jijie Shao <shaojijie@huawei.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, andrew+netdev@lunn.ch, horms@kernel.org
Cc: shenjian15@huawei.com, liuyonglong@huawei.com, chenhao418@huawei.com,
 jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
 salil.mehta@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250722125423.1270673-1-shaojijie@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250722125423.1270673-1-shaojijie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/22/25 2:54 PM, Jijie Shao wrote:
> There are some bugfix for the HNS3 ethernet driver

Note for future memory: I would appreciate a slightly more descriptive
cover letter, i.e. very briefly describing the fixes included, and/or
outlining the most relevant ones.

Thanks,

Paolo



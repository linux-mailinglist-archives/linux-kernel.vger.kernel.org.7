Return-Path: <linux-kernel+bounces-846431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B9EBC7FB0
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 10:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89BC33E5EDF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 08:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC512270ED9;
	Thu,  9 Oct 2025 08:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fpaM2M+r"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9608E25FA05
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 08:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759997755; cv=none; b=d4OfuCdRHCv2L//swYGRw/de91sCJi56fxf8pJCIQfIP8IkJfnBj0vm40Gex9NHOmQQxA6goDLzRGS2NX0R/cEEyYIQyPQlyy9tSa3snQAr4rn0xuQFUM0Z+B45VHQdaGsA2f6eZ44ruXxJIFjo/yhrZkMCYW/c08TuX3jyYgmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759997755; c=relaxed/simple;
	bh=m9XiVtTAN/QcQjl8cEjXtLDaFvDP8ICTqR1U2yHijVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CdTW2paKE2lPvIJKls5bZcg+W/cX70HgrGpVkKClGSO6xMl4Jmb3cWbOnrWKFODGNkdmt1E5sLbzpWcU7st5hC71lX2cBjDBtsUJUsr5xFBVxHqaHZCr3lpglZcUxYMRK/7HRpTAtOJ4oDXEXhWzCFX66FS1frWci8IcmAMjk3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fpaM2M+r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759997752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uRe9k9uGBBpiKkw7TBSCO4t/JPzp2ByEOYJUEhSNCs8=;
	b=fpaM2M+rVjj1ccMzQ4+AdPUZNuek5W9X6RcZZg50LqDi+PCq3nC6BdsDahvcMa8ubHAv0w
	X185ijS29XsllI9vwAaaWYc9hM4o1wC0nJYmR0P6rsiXIwGQpfYoJ/UcqzmDUYgvKZSK/r
	uUDBB6nMnYDmDhybweUMEtv1O3q4EIk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-qNr64RMBOEuCQbODiIDK7Q-1; Thu, 09 Oct 2025 04:15:51 -0400
X-MC-Unique: qNr64RMBOEuCQbODiIDK7Q-1
X-Mimecast-MFC-AGG-ID: qNr64RMBOEuCQbODiIDK7Q_1759997750
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e38bd6680so4966615e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 01:15:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759997750; x=1760602550;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uRe9k9uGBBpiKkw7TBSCO4t/JPzp2ByEOYJUEhSNCs8=;
        b=FjpsJLFwpW+nLxWpBIpygN22YUBpzAwHzNoqOdYC6tsaiXtDraFqgWNYtVK1LUweIa
         uOK3069E3nWoj+QoVB4pcQKn5lZeCgyHYZGIRdkOJSQThNd7KMJoS0fNc8VWDmThxLN6
         01hYvqKberTgA3ggBc/CfJqb1vFWIYoP4H+sqMhdC0yrkqvkVJu59QVfwK6SZibboqRr
         rNA6R2rOFa2xJ9RSom2kLn8tgYrwx1iPlEUpJOri3jBnGsz1FCaaxvu35A5flQaSpWQ2
         mFbyHqg/lWZaoYC7jEBM0Q2n4J2ma0vjps5DdWVCjBlG5k0jVlcqA5H1hvOpYXpQmqsj
         m2eA==
X-Forwarded-Encrypted: i=1; AJvYcCVfvc2SslpBOGXvdEdXVIc0JfDSX9zoyAnmn6lcf6+09aft7XDvWI+uqG1eZbvg2L+eTQzoFT7qHVqBnXM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgfyy0A0nkxePtTVTxbmutkx8KK9BJbFYe58JCTqaTEPpQ6CWr
	f2oac0o/c9ozkdX6sNs6VZLCEOUycRVZUgueIxKRQFNzrZ7zxa5aZ+4JVAGpH+E8q84fd/0z7ZA
	qalSUz/oZ0eJ0VkwB5Q3mY4RhUx+AnfYqUZF0VuyjGu7F3Md8FPEsbhski51OMIbtLg==
X-Gm-Gg: ASbGncvGGJ646CpVcisBbvjylNcH0KZ/mR3K2/6/5zqv7KGYPMF6lnZyoHdGYCd2jfE
	JDF7ZWdSkF4/pH8PSnLJ0r80noKHDUv/vCRxB91mrHmZcyRXc33qxZFc/wkLGPHHSs30FT6JIaw
	FTUcmL7rDSag3VywY41N7lEabklFzIcBY2Qs9yy0BynaI4fEhj3DvNPvOvlljfxd4l8+lkYKILe
	s+xT8mDOjjX1DijMAZSc+VdY+EsyaNAoprlMl5XrCOmP5l7MiWukPVQxveU3uit0KWu9B2ASYXo
	/nuKcq8qyWYC7k6YdVVH7WinAnDAkytB/5hkdE7WDob6DSyLdjUczAq0IYgrC0cEam3FRsiKKMT
	T/eYXYWOilQ9ztc/LxQ==
X-Received: by 2002:a05:600c:1e87:b0:46e:345d:dfde with SMTP id 5b1f17b1804b1-46fa9a9f051mr57108925e9.16.1759997750108;
        Thu, 09 Oct 2025 01:15:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/NKmEyIKDnjxYZK02GhdTjC9WGAo5EZp8s6qd6Yj74nKrU+HmnBUFXfjEDbRJZ4WcC3QcWA==
X-Received: by 2002:a05:600c:1e87:b0:46e:345d:dfde with SMTP id 5b1f17b1804b1-46fa9a9f051mr57108585e9.16.1759997749648;
        Thu, 09 Oct 2025 01:15:49 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa9c07992sm84826105e9.5.2025.10.09.01.15.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 01:15:49 -0700 (PDT)
Message-ID: <32800363-aed6-4e59-9ad1-435e819bca80@redhat.com>
Date: Thu, 9 Oct 2025 10:15:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] r8169: fix packet truncation after S4 resume on
 RTL8168H/RTL8111H
To: lilinmao <lilinmao@kylinos.cn>, hkallweit1@gmail.com, nic_swsd@realtek.com
Cc: kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251006034908.2290579-1-lilinmao@kylinos.cn>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251006034908.2290579-1-lilinmao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/6/25 5:49 AM, lilinmao wrote:
> From: Linmao Li <lilinmao@kylinos.cn>

From: tag is not needed when the submitting email address matches the SoB

> 
> After resume from S4 (hibernate), RTL8168H/RTL8111H truncates incoming
> packets. Packet captures show messages like "IP truncated-ip - 146 bytes
> missing!".
> 
> The issue is caused by RxConfig not being properly re-initialized after
> resume. Re-initializing the RxConfig register before the chip
> re-initialization sequence avoids the truncation and restores correct
> packet reception.
> 
> This follows the same pattern as commit ef9da46ddef0 ("r8169: fix data
> corruption issue on RTL8402").
> 
> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>

Please send a new version including the fixes tag as asked by Jacob.
While at it please also add the missing 'net' prefix inside the subject.

You can retain Jacob's ack.

Thanks,

Paolo



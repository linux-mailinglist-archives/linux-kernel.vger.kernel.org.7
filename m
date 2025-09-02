Return-Path: <linux-kernel+bounces-795672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E093B3F63A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C62091725DC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 07:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0933B2E62BE;
	Tue,  2 Sep 2025 07:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aPXixlpU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C552868B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 07:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756797092; cv=none; b=IOft/y/Kf3SVk80braQh8iQpSvs4N7N1LNMZnMIs3xXYcNhq87/l9lwYGuwkmdqbu1bb6LlxA+956QkKjNkH4t2X1q9wJcZyjxa0QzFh50l/AshNH6Afo/EAdKm6HdU76W5uu0YQqWTNDeRW+kfKFJFMvwAzdl5vDA/Movr8Gvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756797092; c=relaxed/simple;
	bh=IqLMwKkkt59SYd9Cy2XUMqz7cADLh+Lyy2fNTI3v6Uk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XsbRAmr2bhpHINsy07lDdzDG+xK+Ut455WsNuLHyYvjfb+m/G3mGklbMY304lE/H1Fox0ZlV8K6HA9hWKuYZOlILSH8HLXCGkA0AtnDZqF98DHQveLDe7cukLnKblxqN3IGcfzIr94nj0rrXST6Fjw689kFPAqhNeE42CmzlYbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aPXixlpU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756797090;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/q3Or7FAMzqs9ZCwxniYPcM3YtbJGBMo6/RbTDPCPPg=;
	b=aPXixlpUlRwfnSzV0XNka8Blm1sX8fOFE6k8kXacSZkoz2BLr+wjwmumjZ0raHDRuWoH7X
	/C79XCs0Xov9xxS4ds7ykk2TyXUSonyDmMvAXn2Lyo74lTwh/hQ1WC0Ztc6NBhVTx2jfBw
	DkJv3uMEP3Fb5F/SOhsp8WKfbXA9Vsg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-BUi6ytxeN1aDn4f_56BbZA-1; Tue, 02 Sep 2025 03:11:29 -0400
X-MC-Unique: BUi6ytxeN1aDn4f_56BbZA-1
X-Mimecast-MFC-AGG-ID: BUi6ytxeN1aDn4f_56BbZA_1756797088
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70dfcc58904so75550186d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 00:11:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756797088; x=1757401888;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/q3Or7FAMzqs9ZCwxniYPcM3YtbJGBMo6/RbTDPCPPg=;
        b=VrS3FEjeETKWt1JLRk/fE2QNrrUcBmV+BUWeqoG4/H2+s0sUvloCn5xkWVJUS1Uzdk
         fAzQ1ay06Td4+AVSjmbB2OXkGbUkFKBs/hu/ybE+nVWIWB+s7dd0mdoSbVVGIBakQ0N9
         zVRVn4PJ1lEoIQKhAedOF5+DbnvdGwYuR1pzuA/+8UlMOENELu6hSWDNbJ6wmCsfEB10
         dpSoamiwUee1t+h5KIWf449+Hr3oN4d0lifg2hTRE9PheFq7446ExLmq2rHAjl3uy7gm
         xLLcuqzh5ubKzCsNptjlYqSCD2R7Km4U1qQGlGKyic4p+fzkW/31kvHCkkwziR8/ot1n
         X2/w==
X-Forwarded-Encrypted: i=1; AJvYcCWDuON9vGIPVVV7foxtgTpils5efEbLsFWnD/Odvbw2UbT5y+Wq1gZxUpXUO11pbeuknrl9kfheKZJCehk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8UB/F6ceLIbwhj3H4Ej9EyXSD/vYKLpcVikTq1gf7AwDpTuAm
	1a3fdw3v3N5A9EfnatThrLRat83QmhtawvAVvtvBb5c6JsWK8+X2pnQo2718cYI8FleIvGfdpD0
	9gDvGYgCanNhxHFf5hcgSx981xdGKIHk8g7pfxc7XDtUoLG7CebzWM+85EkFx83RU4Q==
X-Gm-Gg: ASbGncuYzFa5kStgjpOSc/J8xzPU7vUEHdcyXcW1fjvYslgFSl/gi4GuFF56Xh6lQyV
	wgXkbDLclugV+dtcZq3o9WnVIuxe0QgMPV9xnlFadQNyWDX+KIXusl8VK66/cE8iGaOzcexga/r
	vOidBd1GE2crY4eJrBDOcL51FAyv58tkPRvkLlHCZPc7609hak5memTS+hC8o+J5pXPYAeyL7iV
	lstFCr+ZW3G3z2FWjo5/02mdz/nzNdOO8xhZkoEv/iRL8qGY7AFEvKGt4pPbNHNeIrtvOoziY7H
	dQyrdLevISmoNMV2CdpLJFKA6baKfIUiM3iNZ7Y4Zvcr8IuRWDnH+UJ4quAOJO8DYGzHBMF6LKv
	6hEyAVm1sSEY=
X-Received: by 2002:a05:6214:496:b0:70d:fce5:e977 with SMTP id 6a1803df08f44-70fac78f374mr110448026d6.27.1756797088300;
        Tue, 02 Sep 2025 00:11:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG15EB+jbkVn3ZVi16tBlTJvm6GsH+57MS134IuEwF3OJ5dBPiG8SFU6VO5RFsxz1li1KEbXQ==
X-Received: by 2002:a05:6214:496:b0:70d:fce5:e977 with SMTP id 6a1803df08f44-70fac78f374mr110447796d6.27.1756797087787;
        Tue, 02 Sep 2025 00:11:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874? ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720add63b87sm7609876d6.29.2025.09.02.00.11.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 00:11:27 -0700 (PDT)
Message-ID: <16e575e4-215e-4611-a9ea-be44aa1ecb58@redhat.com>
Date: Tue, 2 Sep 2025 09:11:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH] MAINTAINERS: Add myself as VFIO-platform reviewer
Content-Language: en-US
To: Pranjal Shrivastava <praan@google.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>, clg@redhat.com,
 Mostafa Saleh <smostafa@google.com>
References: <20250901191619.183116-1-praan@google.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250901191619.183116-1-praan@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/1/25 9:16 PM, Pranjal Shrivastava wrote:
> While my work at Google Cloud focuses on various areas of the kernel,
> my background in IOMMU and the VFIO subsystem motivates me to help with
> the maintenance effort for vfio-platform (based on the discussion [1])
> and ensure its continued health.
>
> Link: https://lore.kernel.org/all/aKxpyyKvYcd84Ayi@google.com/ [1]
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 840da132c835..eebda43caffa 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -26464,6 +26464,7 @@ F:	drivers/vfio/pci/pds/
>  VFIO PLATFORM DRIVER
>  M:	Eric Auger <eric.auger@redhat.com>
>  R:	Mostafa Saleh <smostafa@google.com>
> +R:	Pranjal Shrivastava <praan@google.com>
>  L:	kvm@vger.kernel.org
>  S:	Maintained
>  F:	drivers/vfio/platform/



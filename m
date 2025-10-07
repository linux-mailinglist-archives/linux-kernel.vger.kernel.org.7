Return-Path: <linux-kernel+bounces-843983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D044BC0C4F
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 10:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53C9B3AC691
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 08:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AA62D6409;
	Tue,  7 Oct 2025 08:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BD0lMbSc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6C52D29CE
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 08:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759826513; cv=none; b=XVap4RTCCpioTpSksEvtp4foNONhl6jG8x2aw/3Lt/4scMrJzKzawu91hOqrlH7Hvm2BqlTEdi6uY/4u3ghvUDdON9g6LX9zeaAIiADA+qJS5+MZG1CYBqljCqykv1gHlGR1H6qecLRUFHAxj36VsqKV0YdGwBUvZ5X3ck7/dio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759826513; c=relaxed/simple;
	bh=N7osgbXR/Nb02nCTiJ+ibSI+O2czeqyHA6JbTI2aH0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U+skgKk96fFBXPEKwBie6GxW/upT2bAFQML2mDvf9OQqd3lCSgw3XBFpGIPumhV5b71TjjzhMI7o7R3mG1g7OxsF0zxyfY5JSxwYCExAlOi+/KNJLV8rAFHvOi39KQbI8Hi6e5U+Icgn9YCuCi6s1LfRlsxD1fAALAXkuLyzHoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BD0lMbSc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759826510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N7osgbXR/Nb02nCTiJ+ibSI+O2czeqyHA6JbTI2aH0c=;
	b=BD0lMbScysGJBz0GrUafq96/xFv3l/JUid3Gm318KFJpnh9VtJOhY/6RF9Js7+Ean6tsKr
	BaTF1fRONuulbTJcVRwDHxgHPDJLsZ7EVxZSnIPkuouK9RRLDNPTqO+ncxgfzdn4OqDrO8
	nlvkEmYG+F2BrrrEXOQx/aThbpU2n+A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-P7LlxTxmPDqOaycd2woISg-1; Tue, 07 Oct 2025 04:41:49 -0400
X-MC-Unique: P7LlxTxmPDqOaycd2woISg-1
X-Mimecast-MFC-AGG-ID: P7LlxTxmPDqOaycd2woISg_1759826508
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46b303f6c9cso39052105e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 01:41:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759826508; x=1760431308;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N7osgbXR/Nb02nCTiJ+ibSI+O2czeqyHA6JbTI2aH0c=;
        b=HCarLC9BXYdH2J+yI2NjC8RMf3neHB/VZbDNQIu9PVVe+jwlZ0d1bi/rr0FgDdf1tp
         n/gD9w6ExMwqcsjh/fhTszxVMhrXcZGuzuqEjNcWGmfG0ymm34X/gHPfeLbjmjrAOEmJ
         W6auK23T/hEpLOaxvVl6XHSyhAooT/da0mM2tqMcFPXi+55WeI9XroIPaRgKmIYiHx5w
         i0VEIGjYVOzti5zqeeRlHcm7Qxyfgwl+8s9O/+CkZ7VNU6CHpSsf5qfZKMOfrcpijNcT
         o7FiHodWH/vwUUERearXYowbV1mLIDOKW+tfFP7d4hnrYwy7vYRbrXDikKvPBqLXvo1H
         S2bA==
X-Forwarded-Encrypted: i=1; AJvYcCUg0LVQLt+M7nDiaA5VEmaf8gW6AlfKG8OZiHgh71ytwJCIRchYwM3k8RevGZjrykWahfynUyCUP8vzsx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzF43prx3DHK8vOmby627N9Dg/ZNC8tcRg25eBv2xC5ImT2BtV
	2doSc7XQhd4rm6tuHLPxc3K56/GV/Na0otE2BVH1MSzr2idArOhFJei9Uj+LgRaYB4+3VZpWcOh
	nN3JnIL9ICJZb+TcTBoDSeZg2b/1Y/B8O1nwP6exiV52odoEqKKL1Xk5TG/6wFDr4mg==
X-Gm-Gg: ASbGncscVtkdcGxLeWufClaKmDcJdJZZDlDE72PLtqExtB1/M6nEA21mmN/2uCyQlCU
	BlAxX7zZQS4E2o8S5XXcF+99NLlmJYUeN9np7DCtn732aHVF7x4HTJOWTjbb5xBA7lNq8g3LhAD
	1bB0scUkfYafj7JEXULNnFIPV2MsHVtD45b5OUQuI0/lVnGdZu/muelLo9uXied24ePUfeFuuwD
	kR3SpmAiIaiz3sA+FTIUv3sRh9Ja9FYV+vjLxcyFXbLXuhoakezSNqERUbklxKcT9SlV51iwsKq
	+vcsR65cwuZwhVYBilqMOgnf2n+H54nLYR/R+OwfnOxBqgoZZkAC1ZmiXcdyzshbUjLuWfr3slS
	c56x2xDkm1PXXw3orlQ==
X-Received: by 2002:a05:6000:1884:b0:408:d453:e40c with SMTP id ffacd0b85a97d-4256714d755mr10312695f8f.25.1759826508114;
        Tue, 07 Oct 2025 01:41:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSxdfixPGpLhL9XW+jR32nQk9zCoNallfAtZ7SneV9aO6UUhophTTA8FHKS9scyKLuEpDDBg==
X-Received: by 2002:a05:6000:1884:b0:408:d453:e40c with SMTP id ffacd0b85a97d-4256714d755mr10312680f8f.25.1759826507682;
        Tue, 07 Oct 2025 01:41:47 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f0170sm25156532f8f.49.2025.10.07.01.41.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 01:41:46 -0700 (PDT)
Message-ID: <d8fb2384-66bb-473a-a020-1bd816b5766c@redhat.com>
Date: Tue, 7 Oct 2025 10:41:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers/net/wan/hdlc_ppp: fix potential null pointer in
 ppp_cp_event logging
To: Kriish Sharma <kriish.sharma2006@gmail.com>,
 =?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
Cc: khc@pm.waw.pl, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251002180541.1375151-1-kriish.sharma2006@gmail.com>
 <m3o6qotrxi.fsf@t19.piap.pl>
 <CAL4kbROGfCnLhYLCptND6Ni2PGJfgZzM+2kjtBhVcvy3jLHtfQ@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAL4kbROGfCnLhYLCptND6Ni2PGJfgZzM+2kjtBhVcvy3jLHtfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/3/25 8:43 AM, Kriish Sharma wrote:
> Thanks for the clarification.
> I can update proto_name() to return "LCP" by default instead of NULL,
> which should silence the compiler without changing behavior.
> I can send another patch for this if you'd like.

If v2 is not ready yet, I think it would be better returning "unknown"
instead of "LCP" when the protocol id is actually unknown.

In the current code base, such case is unexpected/impossible, but the
compiler force us to handle it anyway. I think we should avoid hiding
the unexpected event.

Assuming all the code paths calling proto_name() ensure the pid is a
valid one, you should possibly add a WARN_ONCE() on the default case.

Thanks,

Paolo



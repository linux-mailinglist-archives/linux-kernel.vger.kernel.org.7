Return-Path: <linux-kernel+bounces-875476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7DCC19186
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8FDDB5842D9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFC025D917;
	Wed, 29 Oct 2025 08:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bbpPYvcj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4E92153EA
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761726005; cv=none; b=cYzFFEjjJn1i1HcY4wq0A1tkp8ArpNZ5PtrkRY9Gk6tLCAwrlILKluYDZg3MLmn+tXuxpkhZjtKj/MQe/sXE9OhLE+wNJwrT/U+pEQGAv3fxPAiGKR9O5ma8aO+u36fZaXaQaLZ32qVWjkb5rT92N6aGu7Tjzc6JlXQ3BMMVk3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761726005; c=relaxed/simple;
	bh=dF3Bio0TgnJ38n1yJDNKl2Un84TNaqbPbXxpnnYQNmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RQs593GM/CjIgkAwJiIhjA2mdZxJAq59dbyidURBoOEfbAbkT2KPJyxAMQcc+SvDkb0RgMSEheEuJNFNS5nEWfVy+zrcGHUZMU9PZR32WlqsR88pWzOYkSb6VJ/mazP8tm1W2eqe1TjM2a6r7nzWxirpQB7r24dzmWQdJCKOZdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bbpPYvcj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761726002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jlHEB3885pfS5dzEnYONWhgNpmOARZh1obJdxfgK8IE=;
	b=bbpPYvcjCJmE3PLd+21MfD5M7J1pQZPlUttyOk9YAbe8sZlxshvOgBHc+6AhU4isEOFKT6
	DurP8pi8qYK4YPBN5i3h6Eo+OymCslatmOSCL2B9wksdcwnKhwe8PfmEGRZ9OzCk8qyA4j
	U/VCaHJ9iEVlJjAiAx5ooE4sqnDr8fM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-DhFUI0sPNOqARAlxVfrQxA-1; Wed, 29 Oct 2025 04:20:00 -0400
X-MC-Unique: DhFUI0sPNOqARAlxVfrQxA-1
X-Mimecast-MFC-AGG-ID: DhFUI0sPNOqARAlxVfrQxA_1761726000
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-470fd92ad57so82330225e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 01:20:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761726000; x=1762330800;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jlHEB3885pfS5dzEnYONWhgNpmOARZh1obJdxfgK8IE=;
        b=wZw8tLN0Og+jETaOaUVvo6tSc94edOTjOu35FuC6IyxDZ8Z+0wMpbgBOuYqjvgw+OU
         cVSzToGmIwSVYs+wy/JeM7EJQB7Cfg+M7OngqFktiYaRYBPhECsae8VFGkeu8Lv1FIj+
         svoqjPHKS3aJR1vg6KQNzlnqd8y+9rq1oCAG9RyhJDexQ2dzoN79sxIvGsv7Kad1vRlQ
         KYMe9qbBQAynyZUsWboDjqz86Lyz2c8Oe8eeZ23Jiy97C9Ydt7EnmvqnuYF2rYviIXDB
         AVmB5uEiyQVirx+ilhKSSzoSRQLIYPcYBgJ1bnluYoeU1qAL9M+6QwNF9JoG5Mrc30+e
         K6XQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUlBVY2c/6iPY5xDWY/m515UeSVy6tCRcr0+P6/qtumbWJoqm1piaKzcqdVb/cG7g5l6XznMtwUvzJh1M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn+dPOAApmM8ploLrna06T7HZH8+9iCFbAqr6BpD2xXnkkw3JI
	YRfqkBty3IonDffk7GsIRSIHSJhIWPUQ4QMBGfDzR6aeH2C6whVAHJJxw0sp3r6Ug6C+9Ja3sPp
	YIROeQup1tnzNceb0+dEssC+H4I9t1/4ZTadIbZN3XEvXJcRTDpDVHi83dGFJ6KRXvQ==
X-Gm-Gg: ASbGncsCzVizGDDSmQqVJnqQRFf9rofdqbtNyaAhavjqGyDJY9jtWMRYKIOgG4j70PZ
	e2B1SupGk+3t2PdkLiKp33VXJVjxqlJ6UzyfLK0vHbFVXFl7a2C3ChSxSb+Dgk5W4tlLaKx+tpJ
	frTIX0BqxIPMcguK/CC4a9F4EUbjK3GVCvp1CgYVpPqX0G/7EdSB1JD5CZK7aPfV4P2LyExrrvk
	5tYANUIgnkmFdk11n6lUwyIL8Q9tmTeRF+Sa/BVU33pjlJCpU98u3jIjzHg0oT3Botxc6bwssDy
	VZxK88CajPjgwdJcbT/3bR6AfMfG3kgIWdlYmgkOowMYIByZ5nRqfCbTwil8BaxNKCMcJxPu/yK
	vhn0qaYNtpQwoUY9x1x1o/ezOJ59UAflN9y7L9yaUw+PohOw=
X-Received: by 2002:a05:600c:3f0d:b0:468:86e0:de40 with SMTP id 5b1f17b1804b1-4771e32f67amr17216415e9.4.1761725999690;
        Wed, 29 Oct 2025 01:19:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIKqhZC0CRaoe+oh+5iFeCWKZfBRUDuYDM2nN5t0zCHgNGsk8VxrCIMd1bsBbPfplLJXnHhw==
X-Received: by 2002:a05:600c:3f0d:b0:468:86e0:de40 with SMTP id 5b1f17b1804b1-4771e32f67amr17216155e9.4.1761725999244;
        Wed, 29 Oct 2025 01:19:59 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e3937b3sm33177645e9.5.2025.10.29.01.19.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 01:19:58 -0700 (PDT)
Message-ID: <d0f1f8f5-8edf-4409-a3ee-376828f85618@redhat.com>
Date: Wed, 29 Oct 2025 09:19:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] virtio_net: fix alignment for virtio_net_hdr_v1_hash
To: Jason Wang <jasowang@redhat.com>, mst@redhat.com,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20251029012434.75576-1-jasowang@redhat.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251029012434.75576-1-jasowang@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/25 2:24 AM, Jason Wang wrote:
> From: "Michael S. Tsirkin" <mst@redhat.com>
> 
> Changing alignment of header would mean it's no longer safe to cast a
> 2 byte aligned pointer between formats. Use two 16 bit fields to make
> it 2 byte aligned as previously.
> 
> This fixes the performance regression since
> commit ("virtio_net: enable gso over UDP tunnel support.") as it uses
> virtio_net_hdr_v1_hash_tunnel which embeds
> virtio_net_hdr_v1_hash. Pktgen in guest + XDP_DROP on TAP + vhost_net
> shows the TX PPS is recovered from 2.4Mpps to 4.45Mpps.
> 
> Fixes: 56a06bd40fab ("virtio_net: enable gso over UDP tunnel support.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Whoops, I replied to the older thread before reading this one.

Acked-by: Paolo Abeni <pabeni@redhat.com>



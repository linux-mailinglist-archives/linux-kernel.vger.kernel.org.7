Return-Path: <linux-kernel+bounces-756055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF41B1AF4A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 09:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65DAE3AEFCA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 07:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B6C201269;
	Tue,  5 Aug 2025 07:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e9eLQCdT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120F41FBEB0
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 07:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754378543; cv=none; b=IW+vwxDav9Z/UFEWlgzdzRf9ZP/Ewm/FjYdH4uaw895F2aRCpd4Ohxn60Ru5N5peuHW3Rhe8AnoaUwNW4H337lWaIA6p09Ci/k8i3EvKQPyZ7CP5w/rbPMlQlb5WU621KUOaCLtPyU6+NyfjKWrFmEl4d+LshynhmHbnSgf1tYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754378543; c=relaxed/simple;
	bh=Rk0SHI+PWqhqEbwPZy9Q1SRiwPsOpKQ9ER7M3n76sCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejxVNTAPdg1/2CjQyzyWt2PruxbyyNmFncqpRCuqZ2esZc3JurX8ATpB8I/OkRvTa0xYI0Gk1PNsTyZd/Q9w7mGh173izEM6bRUTElvrONFxP9TCfn72TdJ3aqCXHiboGhGj6g8HssB8Q5SxQONUehVTfVJe6tIgJG9RjGgkHPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e9eLQCdT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754378541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VxjW/XUa/Tox1i570xeV1gDkoladwDp8K5HU/5Xe5bM=;
	b=e9eLQCdTl9VMlMeMi5EBs8DCdN5Q4CVlEgD/DG2/wL3UeoStEsgF1v2rn1Ta+3LHqkl8XE
	NQTgWsaMLE5Y0YD8SynBz4NZ/3IazAG/jz4UIIDw5YQr0DtZ8SwSfvbgHYKdeCIhDuezzx
	kYh2jP1jyfJm9e+gP9TUAxFm37UAoxw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-41Fqc4R2OpOuq37YfCuuyQ-1; Tue, 05 Aug 2025 03:22:20 -0400
X-MC-Unique: 41Fqc4R2OpOuq37YfCuuyQ-1
X-Mimecast-MFC-AGG-ID: 41Fqc4R2OpOuq37YfCuuyQ_1754378539
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4af117ffc70so76458341cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 00:22:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754378539; x=1754983339;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VxjW/XUa/Tox1i570xeV1gDkoladwDp8K5HU/5Xe5bM=;
        b=AzxuexPbf+zTEpeMuJlqkqqe6euAIB+CI/QtwnsfNFSCXlyVwKHHIPKMUXavvA0ZG5
         /ASlGopkFyTkLXmQumr1aVN6LeY/0s9o2W4zjrl1G+c7P96NsANEsc+fOVOa/WITe9cr
         IuQgpIobLLRf00ekxIeNMdkaxgZCmTnve5tFNtpb1VNRUZWEnbdPjBItxu+Apr1uUn9Y
         42/ZdU3uf/DrDCYL+H4lcM/iNKUllkfnbW1NS5IwhgROsFCb4t0KBCKLPnxa6mngJdiU
         g6avxHJ6i/hDfGm5u091dNJT+3xcIjZqKydafJ5ot16cGpovBevHFijVvREY4H5h+l3d
         CYyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxA/OdCvb0ZUaB4WgusPDZV7HYlqqJ6tr73g39zkxQlFEOMBMXTPq0AriDzfXKbXNp6G6cKMgWxQ9zCnY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzuo5q+Bq6Fjvba+WuNjYzyU3lcDBxt5fc23sOU/ZTp3ZLJbE7d
	wIVjlxxdVRd6EwyfLyD3Cm8km+gPEfuFYRWz76yDdJ8hJUn5Lzpi+xf5IMrJt83JQ+DTud8pV0I
	AScTYpGWyx0SWGOTsahWGkXaBNmRYY24s7jJ6wgUe7F0g2DkPwsgmooM0eva/UX1uOA==
X-Gm-Gg: ASbGnct32or237uxtA6DjaKF3BDI7h3ZryHHt6e8EguXl7k7TPosjj42L601F1OJ1Q+
	ZqpqYTpazXMQDcH1Et1YCzLAJBXQXl4LdERKVuP+gRYgSXzkiIWBy3Qtd/sfpSK56SR+7vmA3p0
	GAtDhLh2weO+5Vo0WfNC77mLWF6l23meMaOrz7mN9BCVelEALrY5iGkhs65SiHjq/JYZfn+TiZn
	Ikt0SwJAUUieiC4R+bSpwA4x35Ao3f3LfnogVKjy5bmWX07J1Bv1M61TZJl/8a3m5rO/Pm1GiPP
	JIVQfz9Dvq77ZkOkac5F0wnNVu/5Gl79MX6BnhTrczCRUNcTGIScAgw11DdFh/i7lctRioeZcoj
	ykjeSDzkqx85uKBU=
X-Received: by 2002:ac8:598c:0:b0:4b0:7298:1ec4 with SMTP id d75a77b69052e-4b07298225dmr65010621cf.51.1754378539431;
        Tue, 05 Aug 2025 00:22:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbFGbWbc/7vsrqHQg02yIUPn2Mkudvs+7LqNqnEBlCgK40SEkxmxEpp0vQ/78kK5UTY0baeg==
X-Received: by 2002:ac8:598c:0:b0:4b0:7298:1ec4 with SMTP id d75a77b69052e-4b07298225dmr65010161cf.51.1754378538873;
        Tue, 05 Aug 2025 00:22:18 -0700 (PDT)
Received: from sgarzare-redhat (host-79-45-205-118.retail.telecomitalia.it. [79.45.205.118])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b06f790834sm19298781cf.60.2025.08.05.00.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 00:22:18 -0700 (PDT)
Date: Tue, 5 Aug 2025 09:22:10 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Wang Liang <wangliang74@huawei.com>
Cc: bsdhenrymartin@gmail.com, huntazhang@tencent.com, jitxie@tencent.com, 
	landonsun@tencent.com, bryan-bt.tan@broadcom.com, vishnu.dasa@broadcom.com, 
	bcm-kernel-feedback-list@broadcom.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, Henry Martin <bsdhenryma@tencent.com>, 
	TCS Robot <tcs_robot@tencent.com>
Subject: Re: [PATCH] VSOCK: fix Integer Overflow in
 vmci_transport_recv_dgram_cb()
Message-ID: <bpm2jqi4qv5mkzikcazchdpzb2ztqhwldpyi6wyfowqsqsaobj@pltf2mfrbf7a>
References: <20250805041748.1728098-1-tcs_kernel@tencent.com>
 <ea9768e9-0427-4684-ad42-caad4b679639@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ea9768e9-0427-4684-ad42-caad4b679639@huawei.com>

On Tue, Aug 05, 2025 at 03:07:38PM +0800, Wang Liang wrote:
>
>在 2025/8/5 12:17, bsdhenrymartin@gmail.com 写道:
>>From: Henry Martin <bsdhenryma@tencent.com>
>>
>>The vulnerability is triggered when processing a malicious VMCI datagram
>>with an extremely large `payload_size` value. The attack path is:
>>
>>1. Attacker crafts a malicious `vmci_datagram` with `payload_size` set
>>    to a value near `SIZE_MAX` (e.g., `SIZE_MAX - offsetof(struct
>>    vmci_datagram, payload) + 1`)
>>2. The function calculates: `size = VMCI_DG_SIZE(dg)` Where
>>    `VMCI_DG_SIZE(dg)` expands to `offsetof(struct vmci_datagram,
>>    payload) + dg->payload_size`
>>3. Integer overflow occurs during this addition, making `size` smaller
>>    than the actual datagram size
>>
>>Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
>>Reported-by: TCS Robot <tcs_robot@tencent.com>
>>Signed-off-by: Henry Martin <bsdhenryma@tencent.com>
>>---
>>  net/vmw_vsock/vmci_transport.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>>diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
>>index 7eccd6708d66..07079669dd09 100644
>>--- a/net/vmw_vsock/vmci_transport.c
>>+++ b/net/vmw_vsock/vmci_transport.c
>>@@ -630,6 +630,10 @@ static int vmci_transport_recv_dgram_cb(void *data, struct vmci_datagram *dg)
>>  	if (!vmci_transport_allow_dgram(vsk, dg->src.context))
>>  		return VMCI_ERROR_NO_ACCESS;
>>+	/* Validate payload size to prevent integer overflow */
>>+	if (dg->payload_size > SIZE_MAX - offsetof(struct vmci_datagram, payload))
>>+		return VMCI_ERROR_INVALID_ARGS;
>>+
>
>
>The struct vmci_datagram has no member 'payload'. Your patch may 
>trigger compile error.

@Wang thanks for the highlight!

mmm, so this is the 3rd no-sense patch from the same author!

Last advice for the author, please fix your bot and try your patches 
before submitting it!

Stefano

>
>>  	size = VMCI_DG_SIZE(dg);
>>  	/* Attach the packet to the socket's receive queue as an sk_buff. */
>



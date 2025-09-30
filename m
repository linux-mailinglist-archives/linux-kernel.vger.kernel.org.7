Return-Path: <linux-kernel+bounces-837804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4AABAD39B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 16:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78D9D3C6481
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92062FC877;
	Tue, 30 Sep 2025 14:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QxN3m+RI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8445E2727F8
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 14:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759243259; cv=none; b=f+giC6yFGGFtGqu5NOW+i87ODYCWouQQzBprYa6G/2F0h/3WniYrNg5FTsajIBlbrP5DUW4/G4N1IwzBR8/zT5r9pKQaAuralpLTAQY6N6AXDWHLzKTjN10Uszq83HCJlWo5th6dtDEjQqnMjBel0DGY9d7BD+jx3rhFPcxTFEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759243259; c=relaxed/simple;
	bh=F+e6k/MNBHHmb9WOoUe+ofU5LLqZmUIhUhBFL3KBwyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m34hI2HXoPqvTHzaSNbuRL4gunPY4vFh+cMGm+os1+aWWdFipEkhPRffcs29+0R36VNSejEZBiJguy0QUmFy6hbiW5zONfDbcfoB7w5MAGCr+9KjvPA2GcOZK2VBfZ0De9IfrIuDK3ztwmg2cmvr86lsX/j6jpOrAuKkdF5qz4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QxN3m+RI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759243256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w3djEZpptZal3epfy3wWsnTfTbCNeOqgWpzoHsn5j4A=;
	b=QxN3m+RIe+OLSLGkp38Nws+akjiXKZFWyiE4GV3pd/XEUXMAJPkoYAozmLNV+rnqPFAczL
	40CF8CF8cMItqZwq+N84I3BLKJF1DYxawY+cLDfaB4gCku//bw2/hlmBrnllSrKCaGTDQq
	Da1/7i904+dciqqxcbrD8onqqS0uO0o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-KW1w3w8fP7Gbe1njCs7S4w-1; Tue, 30 Sep 2025 10:40:54 -0400
X-MC-Unique: KW1w3w8fP7Gbe1njCs7S4w-1
X-Mimecast-MFC-AGG-ID: KW1w3w8fP7Gbe1njCs7S4w_1759243254
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46b303f6c9cso43689835e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:40:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759243254; x=1759848054;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w3djEZpptZal3epfy3wWsnTfTbCNeOqgWpzoHsn5j4A=;
        b=Lo44/Twk/boz8FgjRVlHu+5rElbOjzUEhYR450Mh6EYfgtYXBYBc1k52j26yR+I1Fl
         FgWOSeEFQvRGASpbTaoCB7fhOsZc8Mrwu/IYQY1QUtkKHVHZRyWDUD+/ssxpM4R44+pM
         yLPSWbySrMJu4DeLJ7cuibzjWaNHdePwJwMxJTD+xN+xL8JjFvtSyXt2+6Qil3JcqkOW
         RtaqPEBYXFaFvuK8EKrBQWnHJUQV0+EU/SWfXF1lYGqf1OtcYc04jGRIfI3uFM/RkqFE
         lDEE2Wf2+RDna02gMmWDikwVKdBtU/mMgy8Cf2ZNPptB4D6abHhqGqZ6yqLGv2gfh73A
         crTg==
X-Forwarded-Encrypted: i=1; AJvYcCUzD9Uhpq2JG9kRy5HfqcyCXEFDhU4nCZMYKbQmJau3QalBTzw1q1gbYwLaytA6UBmdHwU5Y/OBKn/Nmto=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+hdCIYPjWobOw8gNJ6rkCuZ6xUPxiu9uz5A3bDAXZ9PTii7pG
	+KBZ/SO9DeOIP8Em/C5mNM6iA//fluNwQG+uV5wGk7r7+VjDbA/CdgVFyW9NV9YJXF3hQDc7F5U
	XmMRN216dT20UIed3rjzF/efjWkreBm9aXS0Hwwhp9lyZDGhkb7BIxiqMrLlcEyXb+g==
X-Gm-Gg: ASbGncsRP+X/96wLKDHsJpuM7xZ+msD1+01vDg8LOzvf3/0I5S1oWAIEOn4yNnCTf1g
	FPc05sYu3OIh7gtZxg/qEpg6g3qhW2ozPb9DJQNrB5/7qkrKxWFnVxAm5Qo2Gt7zrlZeqcBH0ga
	Qq3xaNmiR2jCex+IZV6t8m57gujp1mYQnswAOlN+wiCVz5NEdsfmoYkhurRkmT4amswXnhTs5e8
	ZMbr289b0qNroHEouEgNzSleQcRULYJxMRAGPPTxbUKw+21L4hNkG8VvQz04Rocd4yJdgaZA3xH
	sqpdlEMtrlgBn04E5JlskDUa9Bsi4RMX3s2XR7RzzihbcUqYHcIPvIbbZgOrB+4lpYCOoQbEGA5
	llPPNd9iweNGi+jP0mw==
X-Received: by 2002:a05:600c:c494:b0:46d:5572:547 with SMTP id 5b1f17b1804b1-46e612beee1mr817305e9.24.1759243253623;
        Tue, 30 Sep 2025 07:40:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErtVGkx1D5l/JnuVjXkcHnUEGbSlUgRkrwSQWF/mEtPEoSRepcReln8uah8F8nah4bhRfI9w==
X-Received: by 2002:a05:600c:c494:b0:46d:5572:547 with SMTP id 5b1f17b1804b1-46e612beee1mr817025e9.24.1759243253217;
        Tue, 30 Sep 2025 07:40:53 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2ab31f1dsm270846615e9.13.2025.09.30.07.40.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 07:40:52 -0700 (PDT)
Message-ID: <89ed50ab-07da-4514-b240-ed3d05400e91@redhat.com>
Date: Tue, 30 Sep 2025 16:40:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/3] Preserve PSE PD692x0 configuration across
 reboots
To: Kory Maincent <kory.maincent@bootlin.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, kernel@pengutronix.de,
 Dent Project <dentproject@linuxfoundation.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250930-feature_pd692x0_reboot_keep_conf-v1-0-620dce7ee8a2@bootlin.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250930-feature_pd692x0_reboot_keep_conf-v1-0-620dce7ee8a2@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/30/25 11:12 AM, Kory Maincent wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> Previously, the driver would always reconfigure the PSE hardware on
> probe, causing a port matrix reflash that resulted in temporary power
> loss to all connected devices. This change maintains power continuity
> by preserving existing configuration when the PSE has been previously
> initialized.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> Kory Maincent (3):
>       net: pse-pd: pd692x0: Replace __free macro with explicit kfree calls
>       net: pse-pd: pd692x0: Separate configuration parsing from hardware setup
>       net: pse-pd: pd692x0: Preserve PSE configuration across reboots
> 
>  drivers/net/pse-pd/pd692x0.c | 155 +++++++++++++++++++++++++++++++------------
>  1 file changed, 112 insertions(+), 43 deletions(-)

## Form letter - net-next-closed

The merge window for v6.18 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations. We are
currently accepting bug fixes only.

Please repost when net-next reopens after October 12th.

RFC patches sent for review only are obviously welcome at any time.



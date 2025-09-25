Return-Path: <linux-kernel+bounces-832187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE92DB9E97C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC8B03AAD63
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B592E2882A8;
	Thu, 25 Sep 2025 10:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TwtGo3bn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB0643147
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758795336; cv=none; b=nQkGpxHySbJ/KuSVuXw4AVPnqmZ7aa1imj5wCwQi/Z2SamxZJBkmyVn9IedKYri8VeDjvauEk3r1ljSQOx2rVblgSO4g9CZ+kT2uUp6Nbzd4Scta9lhRVoyXLNFL3OCn28NnVbvo2z2s5mhVoZ1p4mUpHatpAZxRdS0t96mSI5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758795336; c=relaxed/simple;
	bh=QyP35LZeGd53K97cVB602RLrZ+mjoe/ln3tSgKWmlyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=raLU+plLDRJj5nS5eo+KKJimR7o1w2kzv142yYkX9REm8wfXME/yD0vvGswP9lR0LLMjp+UlRSKas89t5y20omqnIkZIKFUWgD/ogHVvFgMQszLPz/8PNysAv+n1rWJB3ZPZnyYUMvITropki8C8HkCKvFQ1/dUWZwfFiPLTCxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TwtGo3bn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758795333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oE39AyDI0R2kmOiMdOAVn6YizW+gjTjX7x3iK/djyfM=;
	b=TwtGo3bnbpHDdKX4zNwBP6xTqIW++roBJQJIq84yo2VInn2YJe0wule0vVK7TMB5zo2QK3
	+EpxWROucnAapc3XgLZ22dQiTdxr5n5Vs7XIaVcOxhrU+cQJ/ipA2TBJyEuMjseZ+K35zq
	2hRYKwiwUrslOjB+Mo2A8krGt3+Le8k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-xKK43MhNNfGoyj7zttkotg-1; Thu, 25 Sep 2025 06:15:32 -0400
X-MC-Unique: xKK43MhNNfGoyj7zttkotg-1
X-Mimecast-MFC-AGG-ID: xKK43MhNNfGoyj7zttkotg_1758795331
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3ee10a24246so452949f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:15:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758795331; x=1759400131;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oE39AyDI0R2kmOiMdOAVn6YizW+gjTjX7x3iK/djyfM=;
        b=X7zaAOGtK4zPqwgG287S0ru5pxo4NHEuxTJx2RMVzh/53dgldWfbxNTLY+odjhDL8X
         N0Je/1y0qtE/ixIO5/TY2Pq2mHQyWXfpIBo9Y7c2J0uY+z2GYOqYZr61fXhqp8okqevX
         HFYQR3OVizlaSYb5ZNPjmMZmi5nlbR3GA1Sz//xCEv0jiOsoJCtGkPZ0UsFUNVdnodKQ
         VtkJZAhweuWysUyRZ/pFmOStkUPFMMI04TVbOPbLfbtsk0i0t9Yd6avjQTzkM8sEBy1i
         PaoUuSv9QtQZVHVLleTYm6NwGuhXaPSeDvE60U30G7bkIrriprSswkfbBUXQ4x8xDTmF
         E9Jg==
X-Forwarded-Encrypted: i=1; AJvYcCXe1ncpSD5CHmCXD8FMLH440mAe7X6IEL/nB8YJNH7hw8Gpefk2N6BItiah6yUal5dmrV7IENJz0fr6cB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCCJwAhFkyJn50w+gmlCIDt5YQ7XImcQO9faS7C0yccBIN9PL4
	Nrp//tJDKzO4lQMVTmI7IZxTYnI72/OZEwNp5l3d/uf8QGjif6UoJ8GQ/EN/Tw1Ac3Onk4ZyHkf
	Rk6+39hegUxbIY1bOMGabm1ADXijukcfCitukLcK67t0tTFGOwFof+fyduSFeZMpdHg==
X-Gm-Gg: ASbGncsR/4U2nyO+6Zy8ncfvSm6MqdAqJQuACJa6jR6irC5NWcRrXgg63iqE+rcuYjN
	yYEkDnHQRs5pfcnFcxGolRjRoP5cFQn6NID2E6We7ne2Zrk5xHV2toRx5mJ/Fl8hIixFPv+oTTS
	pqevhVQt6+X/pz5w3idGgkNJYnAt+Mosn5CytuRiqNqSZJ3d7RM5GpgmoEcP7QEeJ7qnTMcfGed
	hJnN1UpdNTPCVPg9Ee++8S0yC46JvC8S5uoNgGzZobNS007C0Zd5XEJx7qdnVb1K4D4MDhEGLg8
	ycuXbKxIhQMFG7zeJaYKlndHoxYT10ZfAHJND12SOrcKMGNBumkt2ygDawF4ZR3UJ0O+AbV+K92
	GhgShiz1Neo1i
X-Received: by 2002:a5d:64e7:0:b0:3fa:ebaf:4c3e with SMTP id ffacd0b85a97d-40e4cd57861mr2736632f8f.54.1758795330758;
        Thu, 25 Sep 2025 03:15:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQHZVeXB+eszjQtYT/isW1eoe/gKc6xWtsrqDnkgflOXZyLnSBxXzSUX3pKWB9cnoUV6UNmA==
X-Received: by 2002:a5d:64e7:0:b0:3fa:ebaf:4c3e with SMTP id ffacd0b85a97d-40e4cd57861mr2736592f8f.54.1758795330201;
        Thu, 25 Sep 2025 03:15:30 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fe4237f32sm2256685f8f.63.2025.09.25.03.15.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 03:15:29 -0700 (PDT)
Message-ID: <dd89dc81-6c1b-4753-9682-9876c18acffc@redhat.com>
Date: Thu, 25 Sep 2025 12:15:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 4/5] net: gro: remove unnecessary df checks
To: Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org, corbet@lwn.net, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, leon@kernel.org, dsahern@kernel.org,
 ncardwell@google.com, ecree.xilinx@gmail.com,
 Richard Gobert <richardbgobert@gmail.com>, kuniyu@google.com,
 shuah@kernel.org, sdf@fomichev.me, aleksander.lobakin@intel.com,
 florian.fainelli@broadcom.com, alexander.duyck@gmail.com,
 linux-kernel@vger.kernel.org, linux-net-drivers@amd.com,
 netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com
References: <20250916144841.4884-1-richardbgobert@gmail.com>
 <20250916144841.4884-5-richardbgobert@gmail.com>
 <c557acda-ad4e-4f07-a210-99c3de5960e2@redhat.com>
 <84aea541-7472-4b38-b58d-2e958bde4f98@gmail.com>
 <d88f374a-07ff-46ff-aa04-a205c2d85a4c@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <d88f374a-07ff-46ff-aa04-a205c2d85a4c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Adding the OVS maintainers for awareness..

On 9/22/25 10:19 AM, Richard Gobert wrote:
> Richard Gobert wrote:
>> Paolo Abeni wrote:
>>> On 9/16/25 4:48 PM, Richard Gobert wrote:
>>>> Currently, packets with fixed IDs will be merged only if their
>>>> don't-fragment bit is set. This restriction is unnecessary since
>>>> packets without the don't-fragment bit will be forwarded as-is even
>>>> if they were merged together. The merged packets will be segmented
>>>> into their original forms before being forwarded, either by GSO or
>>>> by TSO. The IDs will also remain identical unless NETIF_F_TSO_MANGLEID
>>>> is set, in which case the IDs can become incrementing, which is also fine.
>>>>
>>>> Note that IP fragmentation is not an issue here, since packets are
>>>> segmented before being further fragmented. Fragmentation happens the
>>>> same way regardless of whether the packets were first merged together.
>>>
>>> I agree with Willem, that an explicit assertion somewhere (in
>>> ip_do_fragmentation?!?) could be useful.
>>>
>>
>> As I replied to Willem, I'll mention ip_finish_output_gso explicitly in the
>> commit message.
>>
>> Or did you mean I should add some type of WARN_ON assertion that ip_do_fragment isn't
>> called for GSO packets?
>>
>>> Also I'm not sure that "packets are segmented before being further
>>> fragmented" is always true for the OVS forwarding scenario.
>>>
>>
>> If this is really the case, it is a bug in OVS. Segmentation is required before
>> fragmentation as otherwise GRO isn't transparent and fragments will be forwarded
>> that contain data from multiple different packets. It's also probably less efficient,
>> if the segment size is smaller than the MTU. I think this should be addressed in a
>> separate patch series.
>>
>> I'll also mention OVS in the commit message.
>>
> 
> I looked into it, and it seems that you are correct. Looks like fragmentation
> can occur without segmentation in the OVS forwarding case. As I said, this is
> a bug since generated fragments may contain data from multiple packets. Still,
> this can already happen for packets with incrementing IDs and nothing special
> in particular will happen for the packets discussed in this patch. This should
> be fixed in a separate patch series, as do all other cases where ip_do_fragment
> is called directly without segmenting the packets first.

TL;DR: apparently there is a bug in OVS segmentation/fragmentation code:
OVS can do fragmentation of GSO packets without segmenting them
beforehands, please see the threads under:

https://lore.kernel.org/netdev/20250916144841.4884-5-richardbgobert@gmail.com/

for the whole discussion.

Thanks,

Paolo



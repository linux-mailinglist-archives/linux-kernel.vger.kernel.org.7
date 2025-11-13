Return-Path: <linux-kernel+bounces-898327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CC0C54E40
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 01:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F9D54E3FCF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 00:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F4E3A1D2;
	Thu, 13 Nov 2025 00:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K8J9T8qt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TDigx1TB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1B035977
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 00:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762992960; cv=none; b=GHcspEWODb2rhYhRiqp7AKlhxdeEk4WJgFYxNJfr87D/GJ4/x8Jhpxz0Yeie6/xjo5Z8rOch4ADDHlNtZrirSKm6PWmbaBBilnlHcZITiyWfZvFCfR2PKZcdxWZ31Uo063VEBOMc/GIajLLLvY/BHZ8RN/7n7k6o2l6p/ZXZ7QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762992960; c=relaxed/simple;
	bh=1uQgCaKZj2tGULsNrZstj+l1JrpS7Lk/ujXpQ4zaIXo=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Z47zZOd3nuAX1d+c/6qJ2H7gVkWCSlc46A+3HSdTW1Pbnq06hdpoD4mDR5e5UEakVE1fOM+j9xTIcl0WiKx7HjAU0SgGsQIntKomSjIibgQVnOYi/lA+SfNvv3OqXAY9K+NBaRF199+kgyq4LxxDZ05G8Zcxma5fEWUdpFF1Ht8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K8J9T8qt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TDigx1TB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762992957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1uQgCaKZj2tGULsNrZstj+l1JrpS7Lk/ujXpQ4zaIXo=;
	b=K8J9T8qtJbax0gCgWIG9mQvbfK6XahZZ5NFZrXdy2/4VhjZss9wFV0iYapPZFrA5gTi3ba
	LgcB/gotF9jSAXhXdplWVJu82PDZakAajXdxKlbhYYNMXByRx0QdfaEOk0gkbrRokMlySD
	SH+Oz7zU6qorvA253AUNZhr7MxK/xy0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-Ck82k4x8N4CFtMjHGDxWRw-1; Wed, 12 Nov 2025 19:15:55 -0500
X-MC-Unique: Ck82k4x8N4CFtMjHGDxWRw-1
X-Mimecast-MFC-AGG-ID: Ck82k4x8N4CFtMjHGDxWRw_1762992955
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-882529130acso7253826d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762992955; x=1763597755; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1uQgCaKZj2tGULsNrZstj+l1JrpS7Lk/ujXpQ4zaIXo=;
        b=TDigx1TBZ9R9yU6DyT0vmJ9Wn6x2XlLQp+u6/sOz3+HfVYZblp8hpl5e3/WG3Vpi45
         TzeCxNF/Aj7wCWcs2xfl275nJCPnsVjeQZJA5SmpPC1agJ8Pbjfbsi6y5CZo25pFsuPt
         kBZjz/LJejyWgZgw4iMRlvw0y3ErxE/w0yrHvClHIc8un7TJ/fvC5u/c/Z9+5Jp/Mwm4
         9vpJKLRjbm8oh8HqQ7tlhHAXEtw4tu9XsJqrUaWfw8khScNIr2rqRNvliyOyi+YBJv5f
         ifoDwlu02sBaB9R/SVWkgjP5T3MNgl3zxxxr7hcZ/qW7oPoLAVyXG7hPzW/xrfeR25zG
         YADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762992955; x=1763597755;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1uQgCaKZj2tGULsNrZstj+l1JrpS7Lk/ujXpQ4zaIXo=;
        b=BHiwGuV6FJLHTuwCEdnOK/OyIuBZCP3ndczk57Emjgc0lhQL8vldiEVVLtpQSnrzYK
         TxNXdrzjkUbZLxOLE3dW7zoOKb272UCEIejiiOIO0aF9cYk8HNeIgm51ycodlESBOUMJ
         Z9QxYZuQb2tKj5RX2O66TBVRSeeb7MmgdxAiV1QVto7Kc650wNUw6Sv0jIqlXVDNn3KX
         +kmEs7z38x0OaEb016iV2Lj0wyUbF3k1k2JMV8cCF4upOVscbFEGUYShMjc3ZyMk2B/x
         XzJjkGgTP8BzsVXqdo7EITxSvD5qwbC7LyfPYfUHYC3yPx3WSHxIPWDrKBCSK4bHkO26
         8yhQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5+5tTqOrn5VSDtAnQubbkwKtq+yYgsj1cODhfOOiSoPL4VqDDE4c49A9y+uNM55/fMDFcNaTpNTNe44g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4Ev/wCHU8dcnDTlrt6yAw8YBhz0SOgD+GsC+jENmeOjnP1FZn
	0S3qJPyKFlrtwrPj19J9K1mw/88uxNdI9Tsayc5Wy+Iumk1WwR/+hQ6sQ7MkPY3iYApzWeO0G0X
	SsxljxzcswFLtp1vQh4OD2gwrxdet/RFw7e7VNLn+NKFbeOa3NUYXAby7zvHMqISgoQ==
X-Gm-Gg: ASbGncuUiTQHFoXZ9CJZD+IVN+/xPMtzrgFDM2ekSOj4c/IlN5qSgkZ4fvMQjBiqJA0
	qS3iZ/kPgRSsP+36nQZUhaOZrG0gZMwpA83xltUdCxHbMA8ZAi9Y36HE0HZl9wx/vZtmAQZIaUC
	BBMGmNb3OM3R2WTSJPm8F2to455Teos2i0qHkbu6bBMfyg4veHUGNNsd+wbdVEaHpm+DnSb0Evi
	hKna+n2/KBh9ASD1uq77/l3ChItSG2HXVkOOHLoTnN3PPt6n4tbfVJ7HK+uJponCms16MpW/9yX
	IDiEvwFpy9nforM83SRsvgsCMyoj5xfhoWDDgZwAJGeZ0l6KoclJWsEJFHGJxNCgg5U22HtxMbc
	o3wzpoa5zFVMd74qsGsKe5LWSpqX0+rSW/0b45tI7ABKltA==
X-Received: by 2002:a05:6214:19ec:b0:882:437d:2831 with SMTP id 6a1803df08f44-882719e69c4mr76020626d6.34.1762992955110;
        Wed, 12 Nov 2025 16:15:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQ/5laODbRLTtMJ6oFMsJihehWBShOjFK/xe+7cmHL2bQLklCsUIp4BkQW6kgEel0W5IC9fg==
X-Received: by 2002:a05:6214:19ec:b0:882:437d:2831 with SMTP id 6a1803df08f44-882719e69c4mr76020406d6.34.1762992954768;
        Wed, 12 Nov 2025 16:15:54 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8828655e55bsm1573796d6.43.2025.11.12.16.15.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 16:15:54 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <52aa0b5d-cc4c-4072-a590-9944fff4bce0@redhat.com>
Date: Wed, 12 Nov 2025 19:15:53 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 12/22] cpuset: introduce
 local_partition_invalidate()
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20251025064844.495525-1-chenridong@huaweicloud.com>
 <20251025064844.495525-13-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20251025064844.495525-13-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/25/25 2:48 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> Build on the partition_disable() infrastructure introduced in the previous
> patch to handle local partition invalidation.
>
> The local_partition_invalidate() function factors out the local partition
> invalidation logic from update_parent_effective_cpumask(), which delegates
> to partition_disable() to complete the invalidation process.
>
> Additionally, correct the transition logic in cpuset_hotplug_update_tasks()
> when determining whether to transition an invalid partition root, the check
> should be based on non-empty user_cpus rather than non-empty

"user_xcpus"

Cheers,
Longman



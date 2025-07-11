Return-Path: <linux-kernel+bounces-726884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 417A8B0125E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 06:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A327F587BE5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 04:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9211A7AF7;
	Fri, 11 Jul 2025 04:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e3P2M/Pu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B12A19995E
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 04:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752208874; cv=none; b=frjkCu1sSgBtpBH8SmC5KVIsaVGulf88DsPfMjCRH4kOFlVcgJ7cTKZMT3fYwN6hqFS0+2ww114hDPaRXQL7OkPtq9C/CbMvzUYsFBi8wbTxWYUd6PtFngsLTnKfg/yo3KOC7ubPYMOxHRNREZGtGOCwkEdYckJLcsQTbPkUulo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752208874; c=relaxed/simple;
	bh=lVpQETPJvymf4StpUKIvE4vjZcKQA7d722dj+8n+FH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QapwiZ4lgRDXcfW3FasaS9ekUqh+Cr5zTbFpStme/Ko0JkKicRJ5+c8thq6Dpq53WbIicewqkbayVDj+jvj3E6+PlXYRVH10aUDX9Y4f45ogff8vQGpoq7/insu5hepntjZgUAdmlCQtBMn48qoMhz/hBYmK3T+QT9WF/Agbnns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e3P2M/Pu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752208871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9izDSDydIUGaRPwUsjxklYAtHYhhvUYwvryRWYNjnJs=;
	b=e3P2M/Puqsm9zTvKh4ak00qW2tdo2uOJOt+71X2rG8kJN6rpo9BxeIUgSt94BDaWRUW9HR
	DlisXmz2S2c/mFtvpx2QPe2MFFdGkRzVjUHCeSvDYIsPV74xBYHi2flo9VnXWTcGQIrD87
	AtQwz+5toF4n1tFfY4S58yqciyhNvIM=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-76Hmo-yUPxGM2WyruprdqA-1; Fri, 11 Jul 2025 00:41:09 -0400
X-MC-Unique: 76Hmo-yUPxGM2WyruprdqA-1
X-Mimecast-MFC-AGG-ID: 76Hmo-yUPxGM2WyruprdqA_1752208868
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-749177ad09fso734991b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 21:41:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752208868; x=1752813668;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9izDSDydIUGaRPwUsjxklYAtHYhhvUYwvryRWYNjnJs=;
        b=qMvkrtw69GLaWGyRAtz2qUIn6gNjfHZnhLgh1QAKgrKujiGgdQMEpFxNmEHue3Gz3a
         UqNxIlFUvV5/p6PkSVLH+VXJA9d7Gb7I34Ym/6qk7stxGIhsOWxBCnkeqHXE1xwodU4C
         iO0+0eyuBGobI1gn7ge7pJYIXmbV28d3JRyDqBm6Lc3G2GCnRGWznWJocefGSN/qT6Zx
         GBFEGU59InoCE/Sol97V2CIuJqajuKz/DBWte0LyEkaQdCWUmkFs0OpeqbnZFUrbPEIt
         0RV0YMzYGJBcBKImQ2k7miCC+H+OPTpphBN6PZkHH9ws9fcyuTTeHnO7H9YfhhEvndxY
         Ns6A==
X-Forwarded-Encrypted: i=1; AJvYcCVracqV3t4afJVUB45OGJ/55Z2jG3GxQB0P0pJP21BLBUL5JMnU7W+LfDmt+IrOGlRR8HgwUwozgCpLcrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEpMcNH4AwjfyiQH7cxKW9yR1tOBAG8qIs/WrWVX2/gImxXWzZ
	nss7NrFovyK0QlfMl6ZTT76U4eKR/cRPU2NSjyx4WpSjixktv++CQteBznsqeT5lh8+aLupheGl
	gVwFxqQhxmYWrz15FUy1YkeAfFTkut/zud3BsYWW9KINkPK0rkiFExoh6iRjlCGPTJQ==
X-Gm-Gg: ASbGncuetjP6pBJHiBkst9Fygg0bbAnav+5ONaShBufbZWiHTVOL70UsEL4yCtJK22n
	/krogXtgbfr+hi/zy5Mjg+gs9TDhRQYAdfRl4hXRphJuOzqtp1Lb6dnV/y/USLSM1emRWSmd6Xn
	xBuYpfk3QRYcEWrVaBTXgL4rUbQQRBBx/pF9y2HAecEcsRKhohK5IgLbSkqZDHG/7Q7psIxGRSO
	nuBDlV7RpPrphhhGx9D5DQ5dr0afe+zpzfCXb7oMiy03PZrx332RSYEohmnPy/rMjgDuU/AfNvB
	LtdyRW64nn0BXUcRM+t+4Dg9+3bbNoxfI09X33o5UO2hJkl4BrFVTee28/wNSG9ubKaJIk7J4xE
	XBC0=
X-Received: by 2002:a05:6a20:728c:b0:230:fd1b:349d with SMTP id adf61e73a8af0-2312030f0admr2706282637.20.1752208868336;
        Thu, 10 Jul 2025 21:41:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMcdYm35nToxnJP8Gajj/OPdLKsWwG1PNdKCTG1ie9e/dq0pxdheySQPgc7+73HN9/wlq8Bg==
X-Received: by 2002:a05:6a20:728c:b0:230:fd1b:349d with SMTP id adf61e73a8af0-2312030f0admr2706255637.20.1752208867967;
        Thu, 10 Jul 2025 21:41:07 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe52edd5sm4007254a12.3.2025.07.10.21.41.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 21:41:07 -0700 (PDT)
Message-ID: <2b245785-7cad-4b27-81a6-7e87160049ab@redhat.com>
Date: Fri, 11 Jul 2025 14:41:01 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] cacheinfo: Set cache 'id' based on DT data
To: James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, sudeep.holla@arm.com,
 Rob Herring <robh@kernel.org>, Ben Horgan <ben.horgan@arm.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Catalin Marinas <catalin.marinas@arm.com>, WillDeaconwill@kernel.org
References: <20250704173826.13025-1-james.morse@arm.com>
 <20250704173826.13025-2-james.morse@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250704173826.13025-2-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/5/25 3:38 AM, James Morse wrote:
> From: Rob Herring <robh@kernel.org>
> 
> Use the minimum CPU h/w id of the CPUs associated with the cache for the
> cache 'id'. This will provide a stable id value for a given system. As
> we need to check all possible CPUs, we can't use the shared_cpu_map
> which is just online CPUs. As there's not a cache to CPUs mapping in DT,
> we have to walk all CPU nodes and then walk cache levels.
> 
> The cache_id exposed to user-space has historically been 32 bits, and
> is too late to change. This value is parsed into a u32 by user-space
> libraries such as libvirt:
> https://github.com/libvirt/libvirt/blob/master/src/util/virresctrl.c#L1588
> 
> Give up on assigning cache-id's if a CPU h/w id greater than 32 bits
> is found.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> [ ben: converted to use the __free cleanup idiom ]
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> [ morse: Add checks to give up if a value larger than 32 bits is seen. ]
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Use as a 32bit value has also been seen in DPDK patches here:
> http://inbox.dpdk.org/dev/20241021015246.304431-2-wathsala.vithanage@arm.com/
> 
> Changes since v1:
>   * Remove the second loop in favour of a helper.
>   
> An open question from v1 is whether it would be preferable to use an
> index into the DT of the CPU nodes instead of the hardware id. This would
> save an arch specific swizzle - but the numbers would change if the DT
> were changed. This scheme isn't sensitive to the order of DT nodes.
> 
> ---
>   drivers/base/cacheinfo.c | 38 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 38 insertions(+)
> 

With Ben Horgan's concern addressed, LGTM:

Reviewed-by: Gavin Shan <gshan@redha.com>



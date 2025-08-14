Return-Path: <linux-kernel+bounces-768796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7F2B26598
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6582E1CC1A3E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EC12FD1AD;
	Thu, 14 Aug 2025 12:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="4q5M/wLh"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF502FC89A;
	Thu, 14 Aug 2025 12:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755175248; cv=none; b=AUIdeTItdveG1+rXJ4oYlLYw6l/bLMGVmVt7BEaj0DU4mGKOQMVGnZx/8Ft8fTyy4L647iN1CiehsIyyVVO8mIsTpWdFB1Yn/XrLIc6UDcj6gisLMmeDBRDC2LGiJMI9dzeTVEcEOzcFM5HFmAtWF7rawaAEHfeLhJwQJGuLSmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755175248; c=relaxed/simple;
	bh=b9QdGej9aBENqKjuYs2W1QZGk79rDONCK2pkw/w6yWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tKdVkYHCzkUF1DjFdkmZPXCcnvT3rB7+NwCIGeUT2xGuWgBoCnVBsTaJik1ivV5bZuX4lnvJ2DNUKXV9zBrrjXcU3zWqbDNbK1Iushrt5aPuIxEHJeW1hK0NwvmuF6WPsdk5qZUm3KKC+DOn1dzQZDtOoQ5CoPHuFOd6sRY16FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=4q5M/wLh; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57ECZQJ4025611;
	Thu, 14 Aug 2025 14:40:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	5fKCMwHQw3vs0QKmCY7jnj2QoZaEjMZpEYfpWJOqqSs=; b=4q5M/wLhYIAq9Tba
	VNQeiHKNYqpAGYn2zILS0VezA5Uq6pnqUZsmPqLfPQzF+UBbKqYF67e/GeufbKY8
	jJpkZ/MMNM1Pknc0uKPEgN92k1KocX3nrxe8UR7sKv4iyFOyAwo6CY93Ubf5DYja
	Oxzu15QnqwQXCx6g9RmzARa0rRAu/yda0O1IHYPgo9vMKKoFvxQ5Zr8MMuwVAMUl
	q29Mpet3JUObDmC0zWcQo98V2XjvO4K+QQ7QFpM3PnxzKJYcDxy7JZZjjwHkEcY7
	vNxt/Oy2PhZAQULdtIpr422XsBfkzmveyaRBVsnwHvVkE5mMii+QOqGz08SSvYQk
	Pe8ZcQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48dw7gk7xf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 14:40:28 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 058954004F;
	Thu, 14 Aug 2025 14:39:15 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5990471FD89;
	Thu, 14 Aug 2025 14:38:14 +0200 (CEST)
Received: from [10.252.20.8] (10.252.20.8) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 14:38:13 +0200
Message-ID: <ac0409ee-b953-4892-961d-4fcfe6007816@foss.st.com>
Date: Thu, 14 Aug 2025 14:38:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/13] dt-bindings: display: st: add new compatible to
 LTDC device
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Yannick Fertre <yannick.fertre@foss.st.com>,
        Philippe Cornu
	<philippe.cornu@foss.st.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Christophe Roullier
	<christophe.roullier@foss.st.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250812-drm-misc-next-v2-0-132fd84463d7@foss.st.com>
 <20250812-drm-misc-next-v2-1-132fd84463d7@foss.st.com>
 <20250814-resolute-lime-raven-de4fa5@kuoka>
Content-Language: en-US
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
In-Reply-To: <20250814-resolute-lime-raven-de4fa5@kuoka>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-14_01,2025-03-28_01



On 8/14/25 11:08, Krzysztof Kozlowski wrote:
> On Tue, Aug 12, 2025 at 03:48:58PM +0200, Raphael Gallais-Pou wrote:
>> +else:
>> +  properties:
>> +    clocks:
>> +      maxItems: 4
> minItems instead
>
>> +    clock-names:
>> +      maxItems: 4
> minItems instead

Ack, indeed I wrongly clamped the values here.

Best regards,
Raphaël
>
>> +
>>  additionalProperties: false
> Best regards,
> Krzysztof
>



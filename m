Return-Path: <linux-kernel+bounces-719617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9615AFB05B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 11:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 072E03AD784
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 09:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BB9295517;
	Mon,  7 Jul 2025 09:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gmYPzf/p"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C93293C65
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 09:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751881929; cv=none; b=MqqYO1clTKTKNmulN/Vh05lXmZDiiQeoQjjoGEp20DbiUtnNR1/I5au+sygTJkNte2Yjahyatr90faaXcEvs+fQLR9Frj/MyYRnQCEIgBZyXbmL/fMtXc0F0uzJB7uhHi41Dwar+jyjgXOE3+X1nGbTLBY9GT5uZ396W/UPGkVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751881929; c=relaxed/simple;
	bh=J1aMZhWwq15iZStQW3GiNxUZFdVDmF/AcR90Dx7ydzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pe5aQAluWaf58q8ROG3mq9YTq+UtJQ4i1BgcmEnnqBrUk/D4sxtLM91AAYvxE6X8qF0dAHAFCD0QpujDIlj8tBQCKYUkKfDisy1brUUP58yrUZRfyMnj0psJE4/UAgOabPOpQrqDhm/UsxHChOC7YGonHkXqLzP8n/SwPz4Zqis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gmYPzf/p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751881927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HMhrGLUaETV0tKiBi3k3+ftkWV4GbxtfgJtsVRJydyc=;
	b=gmYPzf/ptfHhyjavSqx4lekTzzB5WhKQSz7H4WruJLKbLmmlDNlfKXgiM+Y8O4UO/QQhwh
	Us3TDzLVfKBwSkqyWDz80FLQqj+TBAeHhkpcRzEAFXiipr0qq/hfArRu2AftBe+5MfGNGp
	7E0/NDlHCv2KJae14I+OHPXeoM4EkHg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-656-Whfn57xPNRmv53xMIEKhDw-1; Mon,
 07 Jul 2025 05:52:04 -0400
X-MC-Unique: Whfn57xPNRmv53xMIEKhDw-1
X-Mimecast-MFC-AGG-ID: Whfn57xPNRmv53xMIEKhDw_1751881921
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AB2491808876;
	Mon,  7 Jul 2025 09:51:58 +0000 (UTC)
Received: from [10.44.32.50] (unknown [10.44.32.50])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9DBE2195608F;
	Mon,  7 Jul 2025 09:51:51 +0000 (UTC)
Message-ID: <4fdfd46e-9e69-495e-8b97-c9663ee87aa5@redhat.com>
Date: Mon, 7 Jul 2025 11:51:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 00/12] Add Microchip ZL3073x support (part 1)
To: Jiri Pirko <jiri@resnulli.us>, Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Jason Gunthorpe <jgg@ziepe.ca>, Shannon Nelson <shannon.nelson@amd.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Michal Schmidt <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>
References: <20250704182202.1641943-1-ivecera@redhat.com>
 <cdvecjk7sz66hnoue32nlhwlbghyqkc7rk4ri2me2oioty6aiv@nf7v2bjj63h5>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <cdvecjk7sz66hnoue32nlhwlbghyqkc7rk4ri2me2oioty6aiv@nf7v2bjj63h5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17



On 07. 07. 25 10:28 dop., Jiri Pirko wrote:
> Fri, Jul 04, 2025 at 08:21:50PM +0200, ivecera@redhat.com wrote:
>> Add support for Microchip Azurite DPLL/PTP/SyncE chip family that
>> provides DPLL and PTP functionality. This series bring first part
>> that adds the core functionality and basic DPLL support.
>>
>> The next part of the series will bring additional DPLL functionality
>> like eSync support, phase offset and frequency offset reporting and
>> phase adjustments.
>>
>> Testing was done by myself and by Prathosh Satish on Microchip EDS2
>> development board with ZL30732 DPLL chip connected over I2C bus.
>>
>> ---
>> Changelog:
>> v13:
>> * added support for u64 devlink parameters
>> * added support for generic devlink parameter 'clock_id'
> 
> When do you plan to add the code which gets the clock_id from the
> devicetree? I'm asking as I believe that should be the default.
> getrandom/param_set is fallback.
> 

This requires change to DPLL device DT schema (patch 1). I have asked
Krzystof about this change in [1] but I didn't receive any answer so
I went this way. Anyway eventual support for clock-id reading from
DT is very easy and can be implemented later.

Thanks,
Ivan

[1] 
https://lore.kernel.org/netdev/bacab4b5-5c7f-4ece-9ca9-08723ec91aec@redhat.com/



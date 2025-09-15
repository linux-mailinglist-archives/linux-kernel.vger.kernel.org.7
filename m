Return-Path: <linux-kernel+bounces-816347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11656B572B0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC3A13A9A7E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FA12ECD23;
	Mon, 15 Sep 2025 08:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YgmUThlR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088942EA73B
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757924305; cv=none; b=fKMa3TGVkVBi5D2Gt+OWk7kMVeuaGuyUG+gBjmLFbZq8DpqpsWJ3XrN+QOZPGPmnxdpfzsmI0TJvhd0FhpCZsmjbcpPOdJaaryFcZi5w5cgY/ot7sF2GIlKb81AbiZHXOKsYy303LanS4GThYvaZmsbMdgWxkWb3WLnDvUKxsQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757924305; c=relaxed/simple;
	bh=GHrc0yQIb9KLUpWhvQ29IYnGW02UxYT9eFseO4jZP4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g43u+Ngmc/QuD0/hHHBxeIj20oXrfoC21FQFoMek4yiLf7PTlbwb9tDGdGJryOReyiGCi6Tl+RcekPn5rLxjXB6ZIYjU+bKPPKshF7t2l4A+XL+y4Cca4punN75W7T+A0ye9jed3Fwtb/mCtdMCiPMjycTscKaRC2nb+DoLN0l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YgmUThlR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757924303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PqEIjCNSum5pekZp097c2PmEi/H7x+xWDTcPJJSAOCs=;
	b=YgmUThlRCZQtleY85BoY+DXVUJsR1mM9FBWSJ4kfBLyVS3aK1AhMQHRtNE60RfskY+hmzR
	+jE4yAtDbdo7PUsEamiES+rPoarA4fvss5onuBDNqS1xJGvM0NthPxCgwWP3XjpJBnXD2Q
	aw9zsSdTMmO5mX+679KxSySzvLF/rtA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-227-kt0tbXspMEeJwx-LqWhRtA-1; Mon,
 15 Sep 2025 04:18:18 -0400
X-MC-Unique: kt0tbXspMEeJwx-LqWhRtA-1
X-Mimecast-MFC-AGG-ID: kt0tbXspMEeJwx-LqWhRtA_1757924297
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 79347180045C;
	Mon, 15 Sep 2025 08:18:16 +0000 (UTC)
Received: from [10.45.226.64] (unknown [10.45.226.64])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7F89419560A2;
	Mon, 15 Sep 2025 08:18:05 +0000 (UTC)
Message-ID: <4bd1847b-00b6-42a6-8391-aba08aeb3721@redhat.com>
Date: Mon, 15 Sep 2025 10:18:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 3/5] dpll: zl3073x: Add firmware loading
 functionality
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Prathosh Satish <Prathosh.Satish@microchip.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>,
 Petr Oros <poros@redhat.com>
References: <20250909091532.11790-1-ivecera@redhat.com>
 <20250909091532.11790-4-ivecera@redhat.com>
 <20250914144549.2c8d7453@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20250914144549.2c8d7453@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12



On 14. 09. 25 11:45 odp., Jakub Kicinski wrote:
> On Tue,  9 Sep 2025 11:15:30 +0200 Ivan Vecera wrote:
>> +	/* Fetch image name and size from input */
>> +	strscpy(buf, *psrc, min(sizeof(buf), *psize));
>> +	rc = sscanf(buf, "%15s %u %n", name, &count, &pos);
>> +	if (!rc) {
>> +		/* No more data */
>> +		return 0;
>> +	} else if (rc == 1 || count > U32_MAX / sizeof(u32)) {
>> +		ZL3073X_FW_ERR_MSG(extack, "invalid component size");
>> +		return -EINVAL;
>> +	}
>> +	*psrc += pos;
>> +	*psize -= pos;
> 
> Still worried about pos not being bounds checked.
> Admin can crash the kernel with invalid FW file.
> 
> 	if (pos > *psize)
> 		/* error */

This cannot happen...

1) strscpy(buf, *psrc, min(sizeof(buf, *psize)) ensures that the string
    will be zero padded and strlen(buf) will be less than *psize

2) sscanf(buf, "%15s %u %n", name, &count, &pos) scans for string with
    max length of 15, one or more whitespace(s), number and one or more
    whitespaces(s). And reports number of parsed arguments. Note that
    the %n does not increase the count returned.

So... if:
1) buf is empty then sscanf returns 0 and /* No more data */ code path
    is executed
2) buf contains only string (1st argument) OR string and non-numeric
    2nd argument then the sscanf returns 1 and 'invalid component size'
    is executed
3) buf contains string (1st arg) and numeric 2nd arg then the sscanf
    returns 2 and the 2nd arg is stored into 'count' and number of
    consumed characters into 'pos'
4) if 'count' > (U32_MAX / 4) then 'invalid component size' path is
    executed

> Also what if sscanf() return 2? pos is uninitialized?

If the sscanf() returns 2 then pos is initialized, in other words
'pos' is initialized and less then *psize if the 'count' is correctly
parsed as the numeric value.

Thanks,
Ivan



Return-Path: <linux-kernel+bounces-595374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4046AA81D4B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 08:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C3F34C0843
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 06:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F2A1DF72E;
	Wed,  9 Apr 2025 06:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XT6l3IU/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BF21DE884
	for <linux-kernel@vger.kernel.org>; Wed,  9 Apr 2025 06:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744180938; cv=none; b=s0B51S7YPZSNpM85IaLAdyyZk0tt/zISCv5epyn+EZIR9zLTO0IWIqU1Z+Jm1DmtwXWgqi5jf7QiieyEUDIH0yBUDezxGJJqIz8tDVyFbnmj2XeWfo4NLQlJuKtjvPYo/9lSAGUQF2BtVRJ+cm877ZlZ+bEUB/7HidtpeS931A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744180938; c=relaxed/simple;
	bh=xQKw0XbFmKGsN+GZ6nIb5nWvMnctlKZfRwk3pF7YWzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WP+eAI5cqmnd71LMLNIcmV82aSl5lfWTC3Hg0pF3d9g7FyK+1PaSogS6zhCpjs/Njdpf3KqV4MxGIU3dD4OvZyNGFe7fL381o4ed4AEJ8W2JD0xi/GK1oZQlxBU5ZKk1OlBHJ5O+y6nR+gVkvrsswo3K8tz8Q4UYLBRhHDcLnt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XT6l3IU/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744180935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bXOvHf+rQnYe15TmhKJ+zlI21FPd5oLP8we8fpA0shw=;
	b=XT6l3IU/6hhWEHS9UytTZTWOSw9MMkoUxr6GnXXFjtnPY9xtLZJIC8/I8tcge0tPGeyuA1
	NU0jUhco5wGovsML+IGJwPXHBfyJwmEzrc3GyLLKKE24PaqFJ0z/1HQHWkwyFRoE4ku48y
	XSTBeAVXIeLHJQIG/5ogI6N8gVtO/7k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-34-m7d0HUV2M7GLY8AnyzUsXg-1; Wed,
 09 Apr 2025 02:42:14 -0400
X-MC-Unique: m7d0HUV2M7GLY8AnyzUsXg-1
X-Mimecast-MFC-AGG-ID: m7d0HUV2M7GLY8AnyzUsXg_1744180932
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C574319560BC;
	Wed,  9 Apr 2025 06:42:11 +0000 (UTC)
Received: from [10.44.32.72] (unknown [10.44.32.72])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CB74D3001D0E;
	Wed,  9 Apr 2025 06:42:07 +0000 (UTC)
Message-ID: <466681f4-22c2-4eae-aa98-ee923c148907@redhat.com>
Date: Wed, 9 Apr 2025 08:42:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/28] mfd: zl3073x: Add register access helpers
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 Lee Jones <lee@kernel.org>, Kees Cook <kees@kernel.org>,
 Andy Shevchenko <andy@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250407172836.1009461-1-ivecera@redhat.com>
 <20250407172836.1009461-4-ivecera@redhat.com>
 <bd028787-4695-4d7b-9000-c725a9ae4106@lunn.ch>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <bd028787-4695-4d7b-9000-c725a9ae4106@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 07. 04. 25 11:03 odp., Andrew Lunn wrote:
> On Mon, Apr 07, 2025 at 07:28:30PM +0200, Ivan Vecera wrote:
>> Add helpers zl3073x_{read,write}_reg() to access device registers.
>> These functions have to be called with device lock that can be taken
>> by zl3073x_{lock,unlock}() or a caller can use defined guard.
> 
> regmap has locking. It would be good to explain in detail why regmap
> locking is not sufficient.
> 
> 	Andrew
> 
Yes, it is not sufficient. I will describe this in v2 commit description.

Thanks,
Ivan



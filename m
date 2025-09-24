Return-Path: <linux-kernel+bounces-830252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0309B99340
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2AED3A93F6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21E22D8DC0;
	Wed, 24 Sep 2025 09:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZH0GF46"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F0228AAEE
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 09:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758706943; cv=none; b=k2Qvp4BWOh71KvrdRgDaqK/ouqCk5mbcI7lK75dvvE/fPPIxJVHxoyfS4izYqX/6zecoTbthpfqqjjw3UAKSt3FES+q88DntqGD8ussf5DFOR991ES3+VLvw/1ig+o6e9RDuW1ruT33I/sLmXAcY+ymsBqwk4CyZAFdPUTqNLww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758706943; c=relaxed/simple;
	bh=jaIOyJS/1rmljszz81W8T5bHHsG3GsxMClVYfdNZEPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZRSrxzEFt8DaWnpUx0JMIuFf/Q0sLNvMz1LWWU7JEJ9+uPt2eyYkRWyYds93zM6M0jSzpOmBk4O6C2IKMCNC1fX+AFUdPK+pRrL/opwZXn4hMNC1Nhukl9faYUkwNs+H4EwfGeLniriAaDY6sRuyxnB4Mfa3Dd9JoG3RsA0l72o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZH0GF46; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3ee12a63af1so2968093f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 02:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758706934; x=1759311734; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uDYjbaYtR9X9/K9VwNWQp4yXt0BXnnN3Mgb8xKTG+Sc=;
        b=mZH0GF46rvdqccvJYMZecYPbZeQrtM30EJFhFstc/LQAl26RNMsQHmcN2RMW2Zo/GD
         YzAh7uDJtryRyvl3f4CRbug9BcdmYpekkyJCD0HA/NcLnsoQZSf4YLbCADdzVm+qyNvQ
         cbY8vyYP4iYTuns0KauBqHFkbbrKRw1MOipy0gZ7Znmx1hA38js6SIgOna7ZZbWElLRG
         89t5EfDkplCw1razKWqn/RRRpqGiF5ZAlZXLqoO7QPb+w37SOtmRU9rXDqc5eVnf+fkm
         2dcg0U3t3LpBNU2Juh4uUtw4TnDt39GDNbiTmrQOF4heJBQlAzNy0t6Hc/oULTfkTMPF
         pEww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758706934; x=1759311734;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uDYjbaYtR9X9/K9VwNWQp4yXt0BXnnN3Mgb8xKTG+Sc=;
        b=iisDhrOV5017g6VOTLZct2io80cKgAIP8h6DubK1VpHH1JE0jeuO5bnjReGj7psRYP
         Etou2nUvEc7I5KDtt/zkI4RyNS88RiqqMCqa+e7aIyDIzrx6fF7tawzvzLszivnaB3B/
         rPEwHmbRbo29ygCLnz0t8fGB+vJ4gVE7uKYhAJco/brCnkzorDjBxDxKf6D4WU9W/SIS
         O9jitKJw37fIgGP4CeRScT65YINqAxBr5kWpsQbTfeDOagfS25rbldr9tj7Ym03K7hsJ
         cC2syQG6Wf2FSvwpFJ09B1uj8O2IHi/vJFpXFhkcl15IX0Li9jRp/zKCbSEFdZPKFWdQ
         FahA==
X-Forwarded-Encrypted: i=1; AJvYcCXJQlnG/3i0MwWGdYLQdylk/R/rpAGW1K5g8s5Hc/th5RAyggzOKGACm5iptlp7fYyntZM5YPmgVF6lL2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzstF/LDLrpQq6ZdBTcmXKqW73SEGxYQ3tJz3eXgYNHXRgAXPxs
	tynJaFlgJ68WcGTi4XwBGPJRpUUectdjZ5+EhfjSMhkK3O0B7jIN+C4w
X-Gm-Gg: ASbGncuk5yVOxqeirb/jPqPvXqbJbPQ3bhKUvzghtK4f85qugi8KUVIJLBrtX3+iiDx
	Xzf/Ku3uKJdkIyehlzu+RxK4f6nHiscUVLwN2GO3/cxVy0m5supbLPaeQRENPruQFwg14SPEQ14
	PQAoZyPjrkfdc5+9qILhD68L4vwQwDKYsOZXmndH9qmKwElPwZyhApUA83sqbXCdHrJVtSa4h0/
	5zuLEUpFL5LR90+UKGygFRHGStoFrUfHGuZEs9+9IRDkZV9YNaUEWiRtdl24aMVxBKbJ/bgbrRp
	kvLSBfYILniZcECCXM+bQQgYDPOfuIjPVMvJNAvbPr5biILoV/Of/V50WSiGbMQkUlLp5lVL1Ug
	dJ9gst75W0f0bVONNXHUcU211FOgvDOHHmpbQpagW8JMNy58YVp5VATirbMLQH0c082hV352rQM
	6sArEJbLomZ6r9BRdQGZ8GP81xFkBNxJYB5QrWaNaGa8Kc+M/ZN4f20P/QJv/L
X-Google-Smtp-Source: AGHT+IH91JwgVhi7xpvny99FXoN7tjt7AmIAW/YGtLT1L1J+48wCTADkEz6Cf/AvHGUdfI4k0/hLkA==
X-Received: by 2002:a05:6000:40c8:b0:3ea:c360:ff88 with SMTP id ffacd0b85a97d-405ca959751mr4813428f8f.31.1758706933633;
        Wed, 24 Sep 2025 02:42:13 -0700 (PDT)
Received: from ?IPV6:2a02:8440:7503:805b:76:f865:8f03:23d3? (2a02-8440-7503-805b-0076-f865-8f03-23d3.rev.sfr.net. [2a02:8440:7503:805b:76:f865:8f03:23d3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-402188ef7b2sm8909600f8f.34.2025.09.24.02.42.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 02:42:13 -0700 (PDT)
Message-ID: <841138c8-4fcc-4388-9639-391def0ebc5d@gmail.com>
Date: Wed, 24 Sep 2025 11:42:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/7] dt-bindings: memory: factorise LPDDR props into
 SDRAM props
To: Julius Werner <jwerner@chromium.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org,
 =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
References: <20250922-b4-ddr-bindings-v7-0-b3dd20e54db6@gmail.com>
 <20250922-b4-ddr-bindings-v7-1-b3dd20e54db6@gmail.com>
 <CAODwPW_oDTh9FdnLq7w2FPQv68ReAUUpssqEktUH5zhewbfcxg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
In-Reply-To: <CAODwPW_oDTh9FdnLq7w2FPQv68ReAUUpssqEktUH5zhewbfcxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23/09/2025 00:45, Julius Werner wrote:
>> +      lpddrX,YY,ZZZZ or ddrX-YYYY,AAAA...,ZZ where X, Y, and Z are in lower
> 
> It looks like you accidentally changed `lpddrX-YY,ZZZZ` to `lpddrX,YY,ZZZZ`?

You're right

Best regards,
Clément


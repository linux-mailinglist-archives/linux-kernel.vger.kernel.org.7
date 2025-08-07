Return-Path: <linux-kernel+bounces-758484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6292B1CFC8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 02:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86BBD3B6BB6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 00:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33444437A;
	Thu,  7 Aug 2025 00:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2YKg7Is"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628A11FC3;
	Thu,  7 Aug 2025 00:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754526134; cv=none; b=pjrafkgNhvYWKx6eK0eZMM3X5nITiN688ZNgRChfxTMq6wMCQdMQnBzJDzxLIiV2SbOuH1AlbZBleEYP3UQ0hjlRQ14BAP7vwECcfQmRQqQ6KKjbDZxjQY1I9kyuSjNcH69wZgTAb/8GH+xTze5kCPqUkUmTzrdPOPMI7UDG8MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754526134; c=relaxed/simple;
	bh=wAOZeYueswFbicXkTvMIsToaY6anZ2Vs1jfgPXToE0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cXUqAbSq18wuDGnmvkpXrtcoHbsnmBn15iAOeT9z/I/EGTa6ybVNXCF0uWCfEjT5vRM+Ouv0whC7irZBuaHS5j76AL+kKI9uo6cDF9ZLS5CCyQY8EgK1ZfAF5YFO82RSbRCjXe1+JSX5ClTTdsRUeAG80UfempdmhYnUMi6nBLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z2YKg7Is; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2429d9d3755so4184995ad.3;
        Wed, 06 Aug 2025 17:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754526132; x=1755130932; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=CSUnI+MvBosfqM20aTIGl6X2yF9O0ExPRQwtAZECLCo=;
        b=Z2YKg7Is5rmipRySDrEBXBTnsu7JQtkfsthJt5RHzKRjqlc8c1TaePbFzuFa9Xtrr8
         DiItup/Y4WGn1qI6PkehmENNfAac2Pm2BFAmGTrGLvZef2us9l4doI9c+gvLqeo7f1Zn
         /Lb0mZbeODyOqxkqKLfNXYs+APgvnyz8lQFWnDMqAD2HEjLDPqxub7I3hjXqUvmNkhga
         HC9xg7GHY4PZZTX5SfEP1oWBFs3nySwlWqxnV5dy7mE5nSjqqjIVZwOiKVf1qMuvp/Ai
         wlSFhoLsg3uxDOCKoAciJsitnPe+VwBAA9D5/W81qEXxlqOoq5Q2tHFIDtYN5am5SZl6
         SJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754526132; x=1755130932;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CSUnI+MvBosfqM20aTIGl6X2yF9O0ExPRQwtAZECLCo=;
        b=ayY7p5OwGcZRZvwhRYqawBA3UY1WbFBVABJQGRom12h0UggikIwm9banhoJh1TN7kw
         cGC5w9JloHHdPVwAxqNEMqcXNydXe2a79XYL0Rh1si1JWU+m3UH8sJOkJLup4KJjnBH5
         MugcbKXNiPb9F5nC5uA4PX4W4ziJN24AXNE0d9Lmbzxhewe2BFSUP3DNz7s6ttqBl80f
         4S4ElEoT7S3KuBLhcamVH0Or/go06lAx1dsMv29q6Ct9a0jjyu2PX2So6x2rBGk4as0u
         zhCxrelMNJ6RoRNpTAY2mM3IS37WhJt41iO6hU/Vr3lItKqdYKkY97Jszd9hsrom5Wzw
         bQ0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUUofjzTydQk4dv/W6fiVYYH2463pieJMsvG2DD3OEPgLo/DJWgiVKQ1nnD3IEfxWdQ9TxMFKaCtUmVeEsr@vger.kernel.org, AJvYcCX5m/VnFr7VUeOJEeFOIEcNItiGjNayqRrvffqruCJtzkIH9Nmslk9tVbWaujF3ENG3T2Q7mnMJm+lG@vger.kernel.org, AJvYcCXKDTxq9KSSFKQqgA5iYtt4q2SK1OhGTaHwlhxTmLkbe4M1/g6u7/D8IbS643raR7P1KPBnMdZEtF29@vger.kernel.org, AJvYcCXRgzpU5wC3qRMEvkwG9WivMXLfcTi2BJofgn5PfaSSKxeQ9DZm/Rjxrzplvjq1QCR6gWDZcfoIH3cMRrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHsOrTCYfBswk4BOBp0k3jdaTN5inhs9clcyhVfOYIrXD1CzZK
	acS4cyOA9I0/VBiIogLfQO18buXM+9MgaB73PRxnx9ON/CyIvAUvEnMm
X-Gm-Gg: ASbGnctbpnnXvFJ1+i5YXZRN0vvkKd/6TxLl6hCCGKLUex/ERVXhUeY9YkOpXvOl8R4
	oIU6bqPhxZUcNbEJeNQ3eWfNqwdF6mkjwWuW/a+sDMvoW9dbhZJmZxPCJXGVzJ5nVPplwFqeoRM
	TVuKcOhFU9AlUa0KmETmP/z+OsVD2lfIxfA1ERTRkYLcgwbBAib35ynGc/MxP7kiPF3NR/whteY
	cdjhBBn1LUGGxatI6a225qccOEdKW2O3WbRU1ugxQujDFDlg3BOY9sb3bT21dV5S7NcRP8QtI0i
	lH8IBfN5pREZ0cQSh7xuuY+eI/fHOC0/djP/3h0T4TNKdAODxTL9+vdqD+JflIzEpA2+d2nT3IZ
	MvaalAzF91eOpWZTbAdSghE/r38mQt48HIu9reIarrEq4NpRUn3dPw4djAvK/vJdaNF7iP7AFN6
	PeXzLlbqMP2kbqfFny
X-Google-Smtp-Source: AGHT+IH9E01uPRaBTxIPHzcEUmMzgIninHjjkuKSzY1MdyEGmzyeMrKL/iHVhkPVdKGJl/5JMxGj4w==
X-Received: by 2002:a17:903:19eb:b0:235:779:ede5 with SMTP id d9443c01a7336-2429f42f809mr67151905ad.40.1754526131612;
        Wed, 06 Aug 2025 17:22:11 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899b5bbsm167593185ad.128.2025.08.06.17.22.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 17:22:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0b7b396a-c53f-4456-ae17-1b5f3c1d6859@roeck-us.net>
Date: Wed, 6 Aug 2025 17:22:09 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Add sq24905c support
To: ChiShih Tsai <tomtsai764@gmail.com>, linux-hwmon@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: jdelvare@suse.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, corbet@lwn.net, t630619@gmail.com
References: <20250806223724.1207-1-tomtsai764@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20250806223724.1207-1-tomtsai764@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/6/25 15:37, ChiShih Tsai wrote:
> Add sq24905c support
> 
> ---
> v2 -> v3:
> - No code changed, included Acked-by tag from v2 review

Please refrain from doing that in the future. Patchwork picks up
any Acked-by: and Reviewed-by: tags, so resending a patch series
just for that is pointless. All you do is to create noise.

Thanks,
Guenter



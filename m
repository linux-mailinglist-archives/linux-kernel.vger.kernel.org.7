Return-Path: <linux-kernel+bounces-830282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35158B9949A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE051171020
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F662DA777;
	Wed, 24 Sep 2025 10:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kk8IW9uk"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D941C7E105
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758708027; cv=none; b=jc37wmaDDOd5wogTrUXdWF4TvcFl9NxsDj6ZkMk8NFnzsns8MtTiThDGp3D+NM6Cb4Ltx1YV278SjbVZLeoqyINrltrGje9W4yfYZeC8Gim9o0vwevfTJR76JdMze5fllV4U5CxE4F2/j/ky3dZLSWT3VrYaZe4o/a1quSj1gf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758708027; c=relaxed/simple;
	bh=01UY+fAj4MuEVookmStzcuMwFNrHoAXlj80xcJfzQnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NHuo33oD2HC/8wWAZeJIe2INGEVuvX/gWbi55bcypwAFJoZ5IuKMyuPl6swTX4FEBNOXiIuiC3bRAqFLzCkQL78hv90BYp6gWdaEHtiUVzhzoRAMfu2ehuw/r8ciZo9tjsUkhwfzhi9IJWroD7Sw58hTYJSAWOHIxftatdS8cJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kk8IW9uk; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3f2ae6fae12so2662128f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 03:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758708019; x=1759312819; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qmVW+Z/mziG0ZeCkjmpV+S/k8DcMMNx/U++MptcSCGo=;
        b=Kk8IW9uk4Nrvx9Wj088qh9T5tQpgrILEO17yl8H9SuP1284n2RboQXkuiDEYK4+7eW
         Jp252enS4VYa+jQMWrYSJWdDPLWvEJHBKdBjAOov5rBbK1RmRHEwwGzFdovPf3SzLIWE
         XwhCfDUmaLZlG1rS1xELtnWeuzBTUIdOivF1iGHOi/E+QzFvUlh0ifKh8AF4Vu8bJ2v0
         O8+53u066rfeDem6yjc11bGR9xO2URP49S1CMvB4qrq9hnhGbKskRJ32DCdbsNpadTak
         zlOcGeuWKat/LFQNI+BeymKGQ6AaGZ4hZldqPR0QDeUbvfI1tTnpXO+mc1Z9ACG2f3KE
         RaQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758708019; x=1759312819;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qmVW+Z/mziG0ZeCkjmpV+S/k8DcMMNx/U++MptcSCGo=;
        b=coEWfixeDLUShWFhYflqJLImdy5InTOHcZndoDM5EDMh1zKdHM79VNTNGheQJQdQed
         2XRcuCwcdtOnYuuyqz0idKfwUpj74b9JVT9n6bvjjUkB2GJvOmEL7u/vEDJeQDA3aL8f
         XQresuMo1qnwYneQJQ+0KDsgYDrrktRX8Wte7Zk08iI/HCSMqSrsUqbxQXu2JjGDZPi2
         raO3OQQJU7IOaCpW3xQFpNLPynlIlgtpRvcRLqhGUrys7FAC9heq931UHxrOKfJMi+e8
         UUFO85V13v73O8RDJXKS6DH21/6TBeeU//53aUQMqUytX8Xk+9jVY0uOipqajXjIGLjz
         sHkw==
X-Forwarded-Encrypted: i=1; AJvYcCWfQbOeX+6u4txp8n7Mec+i9/MDcbjlLYJSTBbUjqxTBUEjDu74IJaIbZ8ikKyxNZrvFDXAp/pBesB/NvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeaOxpnPCqN10gHfPeeNZs4Ox6egWgTpjUSQLgGFmEn28+i/zM
	RnXQIXsi1OOtdGGUHilyTAzOICRHfq/yemTDsbdHHTEjiWP5Os10MG29
X-Gm-Gg: ASbGncsVZZTi8jG+ZEzpULNbwkQ3zwjXc3zSUIUO6gLpjkzxBOTzAUA3duCsT9RBkg6
	VuWKaS6ne8+n/6afx1wqKXi/ZSFz6Pl6O6rCD23Phdd3RQyzPVI6i7e8PLJWvBjAloWIoHkmML6
	rUiOPtshTlRTmFXfdtye8nNhCP2ACmSRUB67IeinG4xHKvm1N0dpp6y3KsUaBU4L1b3Qo107kIN
	JSKUAJV34oGou5GHjDO+repfu1RvpOKsSxvmryjfE2UrrrGM6WVjN20FkZETFRcMmWC0nYOy8LF
	sL5HQCIyYF/TWErPaiq3gIN2WAQAgnUqpy1sx1nfmiTpGQ6wvOkK4q64TQJGgfgmfzDcc6k5jY3
	GZm8y8fep/0DE/ah71CfhHR2AJ1GnI7zPA+HAz6D4QUJv4bMQ+6m6ph1jRmDHYVdEsdCFifvRHl
	HUG/BiYTmy1KDsmnICCXe2c5a+p/nc8YxmXmHHBHwmcCHXvp/gCvcBIKy/21hp
X-Google-Smtp-Source: AGHT+IG42+8OH08VTgLUl9F1YLwdDI/MKRqmfZxK/ji2sSckzPzSa7uie7TpTd+qAIdz3qyFVuJLPw==
X-Received: by 2002:a05:6000:2082:b0:401:5ad1:682 with SMTP id ffacd0b85a97d-405c46c242amr5543802f8f.14.1758708019030;
        Wed, 24 Sep 2025 03:00:19 -0700 (PDT)
Received: from ?IPV6:2a02:8440:7503:805b:76:f865:8f03:23d3? (2a02-8440-7503-805b-0076-f865-8f03-23d3.rev.sfr.net. [2a02:8440:7503:805b:76:f865:8f03:23d3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee073f4f3csm26375517f8f.2.2025.09.24.03.00.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 03:00:18 -0700 (PDT)
Message-ID: <430e9fad-a877-4328-848f-59b982a10706@gmail.com>
Date: Wed, 24 Sep 2025 12:00:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/7] dt-bindings: memory: introduce DDR4
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
 <20250922-b4-ddr-bindings-v7-2-b3dd20e54db6@gmail.com>
 <CAODwPW9Js2AjSzQrvRFMK3xHXjbb6qV2bGEj3GhYWpDELniyCQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
In-Reply-To: <CAODwPW9Js2AjSzQrvRFMK3xHXjbb6qV2bGEj3GhYWpDELniyCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23/09/2025 00:51, Julius Werner wrote:
>> +      - pattern: "^ddr4-[0-9a-f]{4},[a-z]{1,10},[0-9a-f]{2}$"
> 
> I don't really understand why there can only be up to 10 characters in
> the module part number. I also don't understand why you wrote "20
> bytes (10 chars)" for this in the previous patch. Are you assuming
> that module part numbers are UTF16LE? According to my reading of the
> spec, it sounds like they're supposed to be plain ASCII, i.e. 20 bytes
> should be able to contain up to 20 chars.

Hi Julius,

Yes plain ASCII needs 8 bits for each char as the value range is 0-127
I was having hexadecimal in mind while writing this, I'm sorry.
I'll fix it here and in the previous patch.

Best regards,
Clément


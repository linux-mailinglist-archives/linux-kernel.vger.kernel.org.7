Return-Path: <linux-kernel+bounces-879817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E01F9C2414F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0EA8D4F3C21
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DB732E139;
	Fri, 31 Oct 2025 09:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QzaK0tDZ"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F8132E69E
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761902039; cv=none; b=a5eBE6NTHXLj6lI4OHcmYCFOZIwIVsdy2STpl8wTYMi5gPPZScCZ7ZBJyVjCovmMEhxSn9oCqJcdrW1IaCY0S43tpnXJp1XChrTYNDa/kI2IbGXlaN6oLpsvydnc69mwelkMe0Yk7ijm8kMNwdMeSkbfQ2sBbVJ3+5FnrR/oGSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761902039; c=relaxed/simple;
	bh=fj2dDXJl6zM/ibn9uNkORebDcvcFug5dDwO39m4oqs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ixOWPqyb2JPzQXPAND8BeSZo6agrXB/0rXIDMLRu3EyCqh5993AzIqR9WYUoBa/MTbABkpM5oTpXYa1ifvR5xUNTs0QI2K0/g6olOwHlpqc2XdE8FQ8/9mnucCsSDeOamtHYAJv2cssj2MTr1dzVWcFczlAC7cDNtmAxdClGYVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QzaK0tDZ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7a59ec9bef4so2639246b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761902037; x=1762506837; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HnoarLXb19bER3fZtEiYJsJttG37WwsFkpglznqPRcw=;
        b=QzaK0tDZ9R7UyWlx+XTeW5zBd7wMRle/um0rDcDeXBQxwKItKXu4mdQ8Z93w44XXsi
         PtPXfC/umH85jY0fbq+nb6Xg1iMyiyuHJN1+XdYA1ukARv5yIqZ0x2Clnh+jaumerlsI
         emcDCjWayEuONvD6DlnPzMALOIKJ4FOasuE+lBEm4hnpd0UvpWLu9okFz5JUGkLHZo2C
         zjw6m5SrCDxIjFKdpZNhYyQGXdfa0PDUfXZ0NApJVwEHzzCyCED7sCq9vbR506ti3ZF5
         CNIysl1mX0Q1tPnFO5Mzjnv0fGjKhHy9zrNeGGml/8opDCRclmEtS9q8medBz0tpgak/
         nQuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761902037; x=1762506837;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HnoarLXb19bER3fZtEiYJsJttG37WwsFkpglznqPRcw=;
        b=wwZt4LCeFhphD3A7H5+ON7AcLx0Br41/EiimKIySbr6kyHF5UGs6k7Mf0qvxXTv65e
         xaneVvvd8WfQNwUZminCJtQUiq5lyk6rCmEo0TV6IsppDu6KvU1H5MOkrp3OXi6DyB54
         Ck6EAjyhoTGHNGiHqJjEA/Xf4Glvtc9rP3w8uetM6eIhDDkfDXK8w4rmstSzuqJxX8F2
         OjC0JLh7aomBsKCwk3TsDlnEAxwwx6J0HqdrXdLe5HZG7VGyM/nQsvBvOdmumH9lzwEr
         UPvlkNlW3QirRVhl/6nmDOAP379/W+qX47I8R0ioUS2O8sbNM+ObqOuSkk3vd+U/h3VX
         mf9g==
X-Forwarded-Encrypted: i=1; AJvYcCUumnnwq9LDWXl36SY8yop74cXW/ICN5K/z/VJ7KqfOsPi8dj0N6cQJUsKBnG7HFq4rPGXhtrqK12sie+s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0MPY8JFKMuIQ7s0YySpB9Mnydr7iZ3QquZiNHkQQbtExuizP9
	wbkXlvueev+BVw+VDODiykjnZGbE8G90VNBJaT2XZu6hh6EtSH/V+Mdk
X-Gm-Gg: ASbGncuNbHloGj1keoP/rxB86Iw30mY+rPPu+Ntg4wnmXhCIVXvkKUZjuCDhBfxBL8I
	0SajJUye6pK6VyQPp8dWl6AUh0Rb1Ho45wlV8Fn6j5ejuedKkSUN+io90O3PUSo4gwNCtriPJvu
	qCeRMPtnTKQwquMA+8/YPK7SqfxCXhziN+aPNOgStwSlf+cqXLwxmKJcyV1/+ByIWJ6wQmZ8mAF
	FxiYxHlI1d2M86NE3ty+DzRDnFb4om3fdOCQy6VFS3kpubVHkZ7pBB/O5w2xSXxk9o5vTQ56tkB
	c7h3SeEbHKyZYzW8/3EW+Fvd2xMU+7NHOqbZbLBv4BTzjLXq4x+B5a6cbwvplOVIyhQW8f2Osf6
	p5et/BXX1LFrcfGrHK+p14TxRnVxdUnvoqiF/mUPFfkQ2OQnmxk333j88UBcDnjR89yP+cPaD1+
	bOxRGyOuMiWX2mP1t5vfLAJl0=
X-Google-Smtp-Source: AGHT+IGjFs4oElSscRZoSOJ7pWJlm5l1cLItFpZRGYqZAztSPJKqy71nHip2TTG9mQU6ECqE+BjsaA==
X-Received: by 2002:a05:6a20:158a:b0:340:ecf3:5fcc with SMTP id adf61e73a8af0-348cc8e36bdmr3933450637.45.1761902037173;
        Fri, 31 Oct 2025 02:13:57 -0700 (PDT)
Received: from [172.17.49.162] ([103.218.174.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7d8d71690sm1487905b3a.19.2025.10.31.02.13.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 02:13:56 -0700 (PDT)
Message-ID: <a0a18b53-dc1c-4f60-8cee-4f6e5c6baa4c@gmail.com>
Date: Fri, 31 Oct 2025 14:43:52 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/1] arm64: dts: qcom: Add dual-channel LVDS support on
 QCS615 Talos EVK
To: Bjorn Andersson <andersson@kernel.org>
Cc: konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251028061636.724667-1-tessolveupstream@gmail.com>
 <sygckhfcazo56jpmuldhctu3jnf3unekl4ahh7n3yels63ntpg@3esgqmoewfuo>
Content-Language: en-US
From: Tessolve Upstream <tessolveupstream@gmail.com>
In-Reply-To: <sygckhfcazo56jpmuldhctu3jnf3unekl4ahh7n3yels63ntpg@3esgqmoewfuo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 29/10/25 21:13, Bjorn Andersson wrote:
> On Tue, Oct 28, 2025 at 11:46:35AM +0530, Sudarshan Shetty wrote:
>> Hi all,
>>
>> This patch introduces a new device tree for the QCS615 Talos EVK platform
> 
> "This patch"? There shouldn't be a need for a cover letter for a single
> patch, the patch commit message should describe itself; as any
> information in the cover-letter is lost in the mail archive when the
> patch is merged.
> 
> 
> Also, please transition to b4, per our internal guidelines.
> 
> Regards,
> Bjorn

Understood, will take care.
> 
>> with dual-channel LVDS display support.
>>
>> The new DTS file (`talos-evk-lvds.dts`) is based on the existing
>> `talos-evk.dts` and extends it to enable a dual-channel LVDS display
>> configuration using the TI SN65DSI84 DSI-to-LVDS bridge.
>>
>> In this setup:
>> - LVDS Channel A carries odd pixels.
>> - LVDS Channel B carries even pixels.
>>
>> This patch only adds the new DTS and corresponding Makefile entry.
>>
>> Thanks,
>> Sudarshan
>>
>> ---
>>
>> Sudarshan Shetty (1):
>>   arm64: dts: qcom: talos-evk: Add support for dual-channel LVDS panel
>>
>>  arch/arm64/boot/dts/qcom/Makefile           |   1 +
>>  arch/arm64/boot/dts/qcom/talos-evk-lvds.dts | 128 ++++++++++++++++++++
>>  2 files changed, 129 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/qcom/talos-evk-lvds.dts
>>
>> -- 
>> 2.34.1
>>



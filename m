Return-Path: <linux-kernel+bounces-863362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 56566BF7AA6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 95A61347BD7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60F472628;
	Tue, 21 Oct 2025 16:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Il/ciA+O"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9177E70810
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 16:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761064257; cv=none; b=ZY/UBzHKkIQSfz19X+c8h8SsPtU2zmtZPukHF4rUJpkJ+Gf4WwjU/eB1sqQZVr6PnPHmvbPQIPFiJG9XcE+nvWTw5aRxoquF6Tasw0UabzmqqgurTdWxLFOFVA/+AgjHLiJKU/H9hjzDBj8bxIFuqonQw+4y48Jb02urnf8OdcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761064257; c=relaxed/simple;
	bh=SVNlz68IIT8b9yVQw+xofp80WWKKo5MkKmms7Dm2ptk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XVFNPOJplTkS48sAEXMeuxf0IXSzRAjQltb8EktV8gdPAEs4EcqL25QURquMRkR7Xeui/SQ6UBoe4683XNKAoIufd7IlS1ahKrjAQ4r3Y3l40A2PmYER34S9GvkE/19fPBXIh2vDdNCeLswnf62YCFr2ySajGxZYexkMndHMfMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Il/ciA+O; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b550a522a49so4736537a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761064255; x=1761669055; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZRzcTIyAA7EaA4ukA0+FnZHqzvKfstN5UrKhh4GSmJw=;
        b=Il/ciA+OBTkfdgQbCWgKDDpQF7jYH4XHbEaRhtaIpuPtn9USg+JaRK17kB0vBTFacR
         keb0A0nYw2zKppXKDNonPAFa4cvJP+vBpeYf18R6VkGq5j5QOpIEGSQpCeocCZmho2Vt
         zVrTuURN4KOmRmwNXbqPZLtLHwnNqS/q+W+PNpubPUqSbXJ9AZcZwVFw3OM86EGZe0dK
         xncq3HHqNISPWHkZl3aVHsp3KPEGnSMCqeA+vbUX+/1eUD3wlqHAZvRsvkJExTotsOXE
         0oxuwxZvPRRFJVidAKsbVUkOHpXOLxnYZBYle+B0U+3+zw3yUsHV+BYRIhXFd19YIom2
         LSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761064255; x=1761669055;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRzcTIyAA7EaA4ukA0+FnZHqzvKfstN5UrKhh4GSmJw=;
        b=jP+X7xKK6NOFxP1fmd3aRwafvdhB8D4oj4wJL3gmYjer+HmJXE5eioFvl9srQZ/OeG
         QoBZJQUPdBlB4STiF0xB8VcytHvIp/sVVNcSi8pgzC+S2M9ChMRjP6n95Sgu1FS8aqmX
         X3BwYGLUj2wDiXpKgxy3xsWWey7jc5Py5WmwrGS9Xd1WPfn2MpcIXcjw0iFGGsMFONbo
         vNlWTfGwoHpEK7olPVVcke1qJpmU1fJPls1FXWTTssG4XWOfzRyMAkeTf2E9TTjTU2AO
         j+8IFkr7R8xATuu2BCQj+piI+6zaln7p3FYXbJ8JoXZeD9kFqGWRPNC1yqfUJ703GliL
         zRNw==
X-Forwarded-Encrypted: i=1; AJvYcCUrqNBOGUOjsJ4GWB5RmkSouOs/H9pQcvSbUleHbQNrbpWa8Y/dJZhwMpn0RK1od4zXOifjRscLbplCqFY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq+4JrEsZZpVcjYOAeRu32ZaO1taN1QPAtDsaIOaX+EIwSuCoJ
	wgSVFIgRiJsYMRLz6dm+Q/Uu1o39ZqTNhzq0rvto6edF7/bGuHoCiLmT
X-Gm-Gg: ASbGncuZhK/sl6RL2z2dTuQ+h4Clj55CVJMklwAwZTjdZOy9k0CmWJpOe7ceHHGfEv+
	5kZybM5mIymVc6m9kICUhWHAKpdhUBOEM4bxaya6UbsITTyBFFHZ3Z6i5HgwEtpz1tHwYeQYr7F
	WLIgJcmetu05AEzOcKX5Xs+tLR3vITjYDe8lLuHU2mnf3iL2xnHPw6rJhtMfP8JkXrsaBBQcoy1
	LP3XVakOxokOKCFngF3YWKsBWJu9CXO23AU8af5VjHAIT+/nWCi2qfP6ju7h5VuhCyboPy43Cwd
	U2Oi2WzVb9lU8m1q+GnthPxu/QTFJxlFyTEoBvBAnCbOuMzouAr3Fy5r61XGzap0SRcjz5B+gGY
	ByGz21PYly8u/PgQYlnlbjk2YVYSsbgkYq18bqLVQYGrNYnbeji+W4dUWRRt92t1Z8aNnHMKxWl
	AGaSAp7tq6hud14uLWwXKt01WUSH7V9gUYcn19
X-Google-Smtp-Source: AGHT+IE/VQ5Q/ofHnJ/j4KGul/sNoONvhN8n2T0Y/oKQlZXIOL9+d55LsvXpf3gZePHh+6OlOX6FiQ==
X-Received: by 2002:a17:902:d4c4:b0:26e:7468:8a99 with SMTP id d9443c01a7336-290ca121e99mr250476425ad.36.1761064254788;
        Tue, 21 Oct 2025 09:30:54 -0700 (PDT)
Received: from [192.168.1.4] ([223.181.116.113])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ebce3asm113645985ad.17.2025.10.21.09.30.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 09:30:54 -0700 (PDT)
Message-ID: <df11a312-0e1a-44b4-9781-54cbc8396da8@gmail.com>
Date: Tue, 21 Oct 2025 22:00:48 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] dt-bindings: mmc: ti,omap2430-sdhci: Add json
 schema for the text binding
To: Rob Herring <robh@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Barker <paul.barker@sancloud.com>,
 Marc Murphy <marc.murphy@sancloud.com>, Tony Lindgren <tony@atomide.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org
References: <20251019-ti-sdhci-omap-v4-0-fdc63aaeb083@gmail.com>
 <20251020142710.GA576827-robh@kernel.org>
 <46aa84cd-63cc-4263-9061-021fa3205b87@gmail.com>
 <CAL_JsqKH2NTvXGPoimpVp=-yvcQgbXSoxKY6AO16WgJHSeOT5A@mail.gmail.com>
Content-Language: en-US
From: Charan Pedumuru <charan.pedumuru@gmail.com>
In-Reply-To: <CAL_JsqKH2NTvXGPoimpVp=-yvcQgbXSoxKY6AO16WgJHSeOT5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 20-10-2025 21:28, Rob Herring wrote:
> On Mon, Oct 20, 2025 at 10:44 AM Charan Pedumuru
> <charan.pedumuru@gmail.com> wrote:
>>
>>
>>
>> On 20-10-2025 19:57, Rob Herring wrote:
>>> On Sun, Oct 19, 2025 at 01:04:36PM +0000, Charan Pedumuru wrote:
>>>> Create a YAML binding for ti,omap2430-sdhci and fix vmmc-supply
>>>> property typo for a DTS file.
>>>>
>>>> Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
>>>> ---
>>>> Note: The property "ti,needs-special-reset" was not removed from DTS cause it will
>>>>       disrupt the compilation for other compatibles as the node &mmc is used for all
>>>>       compatibles for some DTS files.
>>>
>>> I don't understand. AFIACT, "ti,needs-special-reset" is only used for
>>> the hsmmc driver/binding. But this series for for the sdhci
>>> driver/binding. So shouldn't the property be removed from sdhci nodes
>>> (and the binding), but kept for hsmmc nodes?
>>
>>
>> Yes we can remove that property from sdhci , but &mmc node in DTS is common for all mmc drivers and this "ti,needs-special-reset" property is defined there for one board, so even when I remove it from DTSI for sdhci nodes, the DTS file still contains this property in &mmc node which is also common for other mmc drivers, so even if we remove that property for sdhci node, we still need to define it in YAML to resolve dtb_check. The issue here is not removing the property from sdhci node in DTSI file, but to remove it from &mmc node from a DTS file which is common to all mmc drivers.
>>
>> Here is the DTS node (ti/omap/am5729-beagleboneai.dts) which contain that property and is common for all mmc drivers.
>> &mmc2 {
>>         status = "okay";
>>         vmmc-supply = <&vdd_1v8>;
>>         vqmmc-supply = <&vdd_1v8>;
>>         bus-width = <8>;
>>         ti,non-removable;
>>         non-removable;
>>         mmc-pwrseq = <&emmc_pwrseq>;
>>
>>         ti,needs-special-reset;
>>         dmas = <&sdma_xbar 47>, <&sdma_xbar 48>;
>>         dma-names = "tx", "rx";
>>
>> };
> 
> I'm pretty sure that's not how &mmc2 works and you are confused. I
> would suggest you do a dtb->dts pass and compare the results.

Okay, then I will remove ti,needs-special-reset property for sdhci node, above mentioned DTS and from YAML too.

> 
> Rob

-- 
Best Regards,
Charan.



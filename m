Return-Path: <linux-kernel+bounces-886480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09317C35B63
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 13:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CFC218C0B12
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 12:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6803164A4;
	Wed,  5 Nov 2025 12:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KArQGNRX"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F578315D4D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 12:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762347220; cv=none; b=Q92q0ZXqMgCempm0NwB1E2zh76sGEAxecHLDdiM1waXQUNT6QZYW4aWZa4YgvNDu+GR7p0y6kWEpRuVO0qzl1Fw6rn14erwzc/fTcWEp6hZlbwWdGifV7J0NqZDHDAHVELqpPYXHB5uwv3FbA4Uq28q2wREyC61/i5l2nRDwn0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762347220; c=relaxed/simple;
	bh=ZiOZviqEvKwWICEdXoSPzWBNXEjcvi0xyNucmUY2loE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XYq0MAub310Cbss+JuuvvPrYF+DAi33kizKwZkbb1nOKRe21L97CvP1fX/RrnEiR3EHADUUQdp8R3NSXQGIQLHisyshECfULIwJSc6nOD2hev4kLWeoEETdbDlnWQJmD2WQC3NTERRIEYWbg5PG+8HRQQi35ThywnZ0CcVftlfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KArQGNRX; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-33be037cf73so6851340a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 04:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762347218; x=1762952018; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uXTWMvD9XNNtJ+0IuDLHxEJ/55opUg4uFPpMppU+ANg=;
        b=KArQGNRXOG8tTdX09tWTtDS+mm7ac+fS47hwdIhp4xmx/ZWWA9yhUGx0Wr3Ct1LkLh
         Xm93xZ0l6gJ7csUAW8USuqkXecEc+ickdD7+djOHqFqcA9U2apJQuucF6kHxheNtbxKm
         amhNkEbAeQOUZNwiFHhn4WVjz/HNiq+mQvqalkyMqBuIqcj12jbAGChKq1ssMr+tD3RB
         wbVdGbzso5hCcyh9aljtLdnPgV7MpiYFYkrbkGDXpvVXH+3AkFrJidan7CCtVFuhxAAJ
         O/pwGkpsGEca+N/UMmDrJBd4SMKrmC2cKM51u3j0kHlOH7ec66TjmC/E8gcgVKkqqibN
         +eYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762347218; x=1762952018;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uXTWMvD9XNNtJ+0IuDLHxEJ/55opUg4uFPpMppU+ANg=;
        b=pWT1ktQuvDwRIwJMvBGrXtRftGhz7KyTc2kiTRw18OTA9ZF81s+NQKL2W3MXX2iE2j
         mhYfIf7ZrJWOL9C07AwBV3IBPzbLzLk4/eMsOmwWARe/jz+8sBJXnIyOgE2YLSss1vpb
         XeUyyTH50DNe6YXcwL+H4dcl35vyYd/yE2fRmydRwNBtXRID7DGS/FFtpwz090vrZqaF
         jcNSSm63whP0D2755X2K7RMyBxChF2UDVoMKwLcQTLEpLkUqxcoQBQfcvVUi8dypqkky
         UH2zi5YUnLSLqNrtItEeR2quh0Cu2cAfk6JpS56U8OTxjFIQpAiJ5C75u5tRugPL5Thn
         TRvA==
X-Forwarded-Encrypted: i=1; AJvYcCWBe216B7outgSJE5J/E9WZYtZVCtjUyuXS800HODwTJOX8277bMhmgDHMlnyEpbbW6HI6uu6I1yursEKI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2NpqUzPWfbP9P1QAhQl62dkEdzbkyQcJ5bayAm4tBDzTnHBnz
	PkcYo+iueNmd3LkqWz1jBd0WoUtxlHjvtRP18vAU2tNufIIckVN2OCa6st9l9Q==
X-Gm-Gg: ASbGnctPA8z+W87nV0EyWMyPO1tFRYZ+RYM9zIDREX55y2OE5RCTNyntyUCAuKOOBk1
	9N1WaWBzA+2X+aSKNHEnLIJepFLWjT59ppOAmLizldgV8zW4ak9csKeP/L2yWODhVQMd5OqisWt
	9B188TWVnLW7OdgfduQKJ9KW+aD6imU9Y0NHdRoQNnEGMnlYUXrwB411RY7S2FrZEJmj0DR1co7
	X8mpYJw4tbMtxVfpZ3m4dqn+Hu7nPkDl57mu8dR3jF8qpTyG1QzPWAkLMPqn4DW8EKxnegkUKQB
	QcW1KbLcs8e8fi60iXaoflvoBH+7qp2rT/pel6vxTqDax+ZCts2om35VzmdmPv4u4gh7NIAOwj+
	zd1Bj0FEDzYKZKhmd9nJkxJlEeNvH3m6B5nSX89oQ1qdpu8iIuqIEBdL72YFZfgaYQbaBaJJhj4
	6WmwjQ0z7QRJST
X-Google-Smtp-Source: AGHT+IHDL9eiMgzkVlgRWTri8WIsiKSHk1G9FSbzFFFh7VWfcOfgAFDPdxNgUrmGjQyDZbwKIMBq/Q==
X-Received: by 2002:a17:902:da88:b0:27d:6f37:7b66 with SMTP id d9443c01a7336-2962adb9263mr50059675ad.47.1762347217742;
        Wed, 05 Nov 2025 04:53:37 -0800 (PST)
Received: from [172.17.49.162] ([103.218.174.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a689ad7fsm2938352a91.2.2025.11.05.04.53.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 04:53:37 -0800 (PST)
Message-ID: <1e13b14a-83eb-4ab3-b5e3-4721a6026b65@gmail.com>
Date: Wed, 5 Nov 2025 18:23:32 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] arm64: dts: qcom: talos-evk: Add support for
 QCS615 talos evk board
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, andersson@kernel.org,
 konradybcio@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251104125126.1006400-1-tessolveupstream@gmail.com>
 <20251104125126.1006400-3-tessolveupstream@gmail.com>
 <27f51013-9276-4e41-b57d-fb0baaec5bc6@oss.qualcomm.com>
 <4e3b01fa-174b-4de3-a5ef-67f51f0b2033@gmail.com>
 <c2b91dd0-1b0c-43bc-ad3e-5e4b136c75c9@oss.qualcomm.com>
Content-Language: en-US
From: Tessolve Upstream <tessolveupstream@gmail.com>
In-Reply-To: <c2b91dd0-1b0c-43bc-ad3e-5e4b136c75c9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 05/11/25 16:39, Konrad Dybcio wrote:
> On 11/5/25 11:01 AM, Tessolve Upstream wrote:
>>
>>
>> On 04/11/25 19:57, Konrad Dybcio wrote:
>>> On 11/4/25 1:51 PM, Sudarshan Shetty wrote:
>>>> Introduce the device tree support for the QCS615-based talos-evk
>>>> platform, which follows the SMARC (Smart Mobility ARChitecture)
>>>> standard. The platform is composed of two main hardware
>>>> components: the talos-evk-som and the talos-evk carrier board.
>>>
>>> How is the carrier board a separate entity from the "talos-evk.dts"?
>>
>> The talos-evk platform follows a modular SoM + carrier design.
>> In our current implementation:
>> talos-evk-som.dtsi — describes SoM-specific components.
>> talos-evk-cb.dtsi — represents the carrier board and includes the
>> SoM file, adding carrier-specific interfaces (micro SD, power button etc.).
>> talos-evk.dts — includes both the SoM and CB DTSIs and enables HDMI 
>> display configuration.
>> talos-evk-lvds.dts — also includes both the SoM and CB DTSIs but enables 
>> LVDS instead of HDMI.
>>
>> HDMI and LVDS share the same DSI output and cannot be used simultaneously.
>> Therefore, we provide separate top-level DTS files (talos-evk.dts for HDMI
>> and talos-evk-lvds.dts for LVDS), while keeping common board
>> logic in talos-evk-cb.dtsi.
>>
>> Hence, layer looks as below:
>>
>> talos-evk-som.dtsi
>> ├── talos-evk-cb.dtsi (includes som)
>> │    ├── talos-evk.dts (HDMI)
>> │    └── talos-evk-lvds.dts (LVDS)
>>
>> This ensures modularity, and properly models mutually exclusive display
>> configurations.
> 
> And are both the LVDS display and HDMI converter on separate add-in boards?
> 
Both HDMI and LVDS interfaces are present on the same carrier board, 
but they share the same DSI output from the SoM.

The hardware requires physical reconfiguration (resistor changes)
to select either the ADV7535 HDMI path or the LVDS bridge path.

Because they cannot be used simultaneously and represent different hardware
configurations, we provide two separate DTS files — one for HDMI and 
one for LVDS — while keeping the common carrier definitions in talos-evk-cb.dtsi.
> Konrad



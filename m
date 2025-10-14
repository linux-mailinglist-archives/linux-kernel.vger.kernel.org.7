Return-Path: <linux-kernel+bounces-853398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02019BDB874
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 00:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F084426FE9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 22:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702BA258CDF;
	Tue, 14 Oct 2025 22:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fzBt9EOD"
Received: from mail-il1-f225.google.com (mail-il1-f225.google.com [209.85.166.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C405F21CC43
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 22:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760479322; cv=none; b=JVpE+/5I7CMjkHRWEaY8d3XtOjUXZvS4JPXu58NJZ39Wf/668dK8pd35Bj7LZAF0yERD9dwB9QribOeRoM1SwBKyOc4WxIPAO2WxqQO9V4u2YLRaX8ia7n11KjNn9kuttp87hgvDXkCZJHb+TtAHO/GNirICn81FWnCqECx6zj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760479322; c=relaxed/simple;
	bh=MzT+PPiX2Ns3AvHt7w73ekUQyMyQjohybWezP0SN1m8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ho6ML5uFoXfOcPrqIyWpl3VHWdMI9ebh6gu31sMTEgQ4HG7Lp0y2+nYZykO3NQpOoG8cRxK3sqaXfmhyT1RmnfV4ZCJ3uLb07vJeVUR8v0et6/+IqyYX2gNpo3Kozb+imFFPMohRwWulrjFkxPygPwtpkxhmUdXpXeZpXbE4zHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fzBt9EOD; arc=none smtp.client-ip=209.85.166.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f225.google.com with SMTP id e9e14a558f8ab-42d857dcf92so22348455ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:02:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760479320; x=1761084120;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2e1fK4ITdfQE4nTPV/5xAA7Q8Q0cuPRv06tROKIa50U=;
        b=BXuqik5ELjTbMq9R7iVqkUWqsAvQIjxAEioAWpV/HudomlWMyfB44ZjS7K3bNXVxbV
         KVCOLIWAnlQscc49+4igbsknLhi+7fYJDOIOpXQulSg2BA1IoArcdA2v0tOyU83+7Rv4
         B3ny/bfGrPvaXXlH78/v0IJ11J/4brQzur+Go4sjSp848tkaFy/2LypVXCpX+CbjfhER
         ZT3PMnIjVFj89yCahGoe1yOiN4ohhZEGt0Qc3bX4RWLYk/ALrxZHvB4LB6iWU2K+zzI2
         iHTZN8ivVLnybpGYetXu26SK9+vZcLi0UUJ5cq5HMlS8voZ0h1DeNHpZgaAi3/ML9Sfz
         pHTw==
X-Forwarded-Encrypted: i=1; AJvYcCWWmI2UvvFkYFEi6hGfsltAa+ZIfWwogdWQWpmFNTB7+P6EN/hPM/oClZBqW1l7QUTRIq3INGeTXnoZofI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVHTu0Av4E4odmkt1xyHbUUU4vRGcuqpaBBVuUZsKsAdReHqEK
	gLwK7JfEMuVOCjSu5YhV8IhvXXp3E2pK/2toQOGJyoG8AOEdOvb7+HnvH8OVunU6gU95jdTXTPX
	XstfoasfA2M2aDP4D0+HvGoYVFZkqOfZH+W3VntH8Ct0UXCdXfuleOYxZWm3VlxIj1hm9VdIF5T
	9P5lrTe5T6EukQA/uE3CCU+ImOj15CdUGL60AwXNR4wT6VV4d14IdHOERAFMYBhB+haeFT4MJat
	+gaOPZHIAMZ7l42s8TPm0e5
X-Gm-Gg: ASbGncuPpWdkia109EzgXSqbR1b+m9yfpFjn3ou+C/fHLg4byMxYs4/JqJ1TP4lQtJD
	RbIFkGMwx3dByVjH+wg+0Df+9d3ooKFeTyRgD27ObXpno4s7CMGySY4uCRv5XuAo/NpU8In+PiM
	+VW0oiV9Jhgbc7Zwkj777nk+Xn53GeYMoja1tjwajiJKDPbdQzpE1VabrgQ13utCYVD1M7Wdm1R
	S1rMMXNNr183DkyDzBwbvnyN1ybbbN9MVcqR9tNPoG0zSBBWHw5pg3EzOcC2nPGVGa4jOmCrvj2
	iTnetmao7Z+RQ0AjPVI6V4pf53SpgPM5O+bGw2PEsHE+r0jN/k0BB7dJWwijk90jq9aFslZxtuq
	1xzozLqjpYHSW8Zq4BJSaYqUMFSRn6TWYioiRIT8JJsptVkLezLCljfmHDsu1/eJ9Sd/o8v+aRg
	BesQ==
X-Google-Smtp-Source: AGHT+IE833/Tn862zkg/iFVqP2s/WPbnSnZxFxSExT42fE6jrxeIS3RlIUV9CmtvJRo1SZzctDAAzsHrGIlT
X-Received: by 2002:a92:c26e:0:b0:42d:86fb:d871 with SMTP id e9e14a558f8ab-42f873ed35amr234655105ab.21.1760479319484;
        Tue, 14 Oct 2025 15:01:59 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-1.dlp.protect.broadcom.com. [144.49.247.1])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-58f71e1f909sm1166642173.42.2025.10.14.15.01.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Oct 2025 15:01:59 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-88d842aa73aso346741185a.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1760479318; x=1761084118; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2e1fK4ITdfQE4nTPV/5xAA7Q8Q0cuPRv06tROKIa50U=;
        b=fzBt9EODOZQKtj1cSdM9e1VNXC/ueKZPAcRtZrtsFDBM0JGXmjg4R2WmkuNKEdthIT
         Y6woNcGPuoTSUftSM+Q+lAtR2PGvns0s+iH6FOMFR4b6UlNWT6CT5VMmT7yuMT4eKNC0
         n66cYWsOHDRJIoms+U9KQSi3MeGKc/ZRzq35I=
X-Forwarded-Encrypted: i=1; AJvYcCXT4+8lMFmN34IkL+Oo1SxvzdApIlVZCRN93PonFI69utqm5NCD+XssnRQ0Toi1VYHubraO8/qIpB48kMU=@vger.kernel.org
X-Received: by 2002:a05:620a:6910:b0:850:6d5e:cbda with SMTP id af79cd13be357-88353177b8bmr2980896985a.79.1760479318468;
        Tue, 14 Oct 2025 15:01:58 -0700 (PDT)
X-Received: by 2002:a05:620a:6910:b0:850:6d5e:cbda with SMTP id af79cd13be357-88353177b8bmr2980890485a.79.1760479317875;
        Tue, 14 Oct 2025 15:01:57 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8849f3d70easm1299924985a.12.2025.10.14.15.01.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 15:01:56 -0700 (PDT)
Message-ID: <cd174f01-30f6-4a6c-b55e-a15c088eded1@broadcom.com>
Date: Tue, 14 Oct 2025 15:01:53 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: hwlock: Adding brcmstb-hwspinlock
 support
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Kamal Dasu <kamal.dasu@broadcom.com>
Cc: peng.fan@oss.nxp.com, andersson@kernel.org,
 baolin.wang@linux.alibaba.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, bcm-kernel-feedback-list@broadcom.com,
 linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251009212003.2714447-1-kamal.dasu@broadcom.com>
 <20251009212003.2714447-2-kamal.dasu@broadcom.com>
 <3791aa93-c1c0-4fc9-9706-91f3f62743a3@kernel.org>
 <CAKekbeuDux1oOOOKK8Pq-jYRzScCDOEXw1w=JBodaUQ4PU2=cA@mail.gmail.com>
 <c6b68ec7-9195-4961-86dc-802a7cc55e38@kernel.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <c6b68ec7-9195-4961-86dc-802a7cc55e38@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/14/25 14:46, Krzysztof Kozlowski wrote:
> On 14/10/2025 17:40, Kamal Dasu wrote:
>> On Thu, Oct 9, 2025 at 10:00 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>
>>> On 09/10/2025 23:20, Kamal Dasu wrote:
>>>> The broadcom settop SoCs have hardware semaphores as part of "sundry"
>>>> IP block which has other controls that do not belong anywhere else.
>>>> e.g. pin/mux controls, SoC identification, drive strength, reset controls,
>>>> and other misc bits are part of this block.
>>>
>>> This does not explain why this has to be a separate block. Rob comment
>>> stays valid - this belongs to parent node.
>>>
>>
>> We do not have a separate parent node where this will fit in. We have
> 
> 
> So what is the parent? simple bus?

Ultimately yes, there is a parent node which is a "simple-bus" but what 
we effectively did is break up the "sun-top-ctrl" node into register 
ranges that are on 4 byte boundary, because the functionality offered in 
that aggregate is partitioned on a 4 byte boundary.

Now, we could utilize the fact that the node has been exposed in our 
Device Trees using a syson:

                 sun_top_ctrl: syscon@8404000 {
                         compatible = "brcm,brcmstb-sun-top-ctrl",
                                 "syscon";
                         reg = <0x8404000 0x708>;
                 };


> 
>> the DWORD aligned  register defined here as organized in the SUNDRY
>> block.
> 
> 
> I don't know what SUNDRY is.

https://www.merriam-webster.com/dictionary/sundry
-- 
Florian


Return-Path: <linux-kernel+bounces-851089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A882CBD57B0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 19:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C37EA4E76AD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 17:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883C9283FF5;
	Mon, 13 Oct 2025 17:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EzL9JUxG"
Received: from mail-il1-f227.google.com (mail-il1-f227.google.com [209.85.166.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2324B2ECE8A
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 17:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760376275; cv=none; b=Nr/IG9X79bSENt96QzSyO6GJpG9t2GtN04PlpeC6/jTBXVTILPhqlMioIl1BGpDFnqWWT6cpuaXWhoibXEmszmItFyD49iOpDwEbxGHWV4GpAhxUMIroW40FXegoX2mOr4YvjOlbqHN5aDNxX+jzl+oogLWzOqczri3jNuyCSTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760376275; c=relaxed/simple;
	bh=I2rgN+7x0V3kulUR8rDpSMLRTeObAZ/b7gqReOdFWEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uhe71iDbKJU615psFdP9dVOCpcJaOyAOTMU8JygcQ7iWymTsG7usFebO0NhsnN/icMg6/ptkyxUXFtPrIfN4GB3WhIRX/VW2eHagdY/GGMp6QOSFmXgX2dbs98jJHwMVb/es83XexLYQC8b4sxdUEi8cQsdNiSgQf/2hA2tCeUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=EzL9JUxG; arc=none smtp.client-ip=209.85.166.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f227.google.com with SMTP id e9e14a558f8ab-42f8b7cd7e5so18079585ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:24:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760376273; x=1760981073;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HBy4kHeHSd7i/UWNv6ABVxAOKvBT8RoUJZm6Xy6Rw+A=;
        b=r2rTD9ej6GCffzywELMqdFWRQvq3BI6eUi9sjrFyGSU/Ju2h33WMoB48Q/fLOo0a1f
         G1MyUk4XIg+gDq02oJ65UjA1pFuqj3a4BZLLg1KtQfwHFJUf0K+oui2IImKLyaqTvFIb
         jFQ95IGKqzr5upYLzMvBolDI9olsIbtLQxG9TFTXf+JGm1V3IGeW8bSzShSTn4GHcsFt
         mS5Fd/C6dPwYRUjW46bvYBKlGbtwSwpNs4P/oufvTb6fVQreJQjBI8hiQdKVla2cXUpy
         nHWPyEghlBHl7xKhY19mVhKz08zp8wOnHDlqcxEtLxD8y7RzDmByz6dukvz2dg8YCFtd
         8rfw==
X-Forwarded-Encrypted: i=1; AJvYcCUHnIzMVdvCYFmf0ERDZK0m98KjnJq6h0lfb3OmZc1XG5uk+N2iLeEXPHsqP1FJaoPHi1TUxVayY82NYoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQgz5Ru3N2+pbfXeN270HQpugGWiJFD9scypQrMqXWSnkm/3O7
	P+JjpfGuGdqcIj4aG7DtfBIyXTC7kGfzx+H3vV0K8Joh9Tg2X0xvrfYPajG6oIQZCNL2Br3KF1l
	lx9KabGwfvkGwWQ4+KvsTZvAIUEHyDSQNiyLtjr50ffHRDkodTlcLNZqRDtQexXmj5ILLvUG8EM
	pFwcztAYVKP1SqbNdrRBMnuAfizn6ijLq/PBM3jIYlxbqrj5BIZkXHhWU2rJ79I5mPFR11uyj3B
	CS74z6BbAjFfnA4CS4glxkM
X-Gm-Gg: ASbGncvjM0+smGOPqd7dP2l+BPqiJ3dTOQTwVqkqoQNNSWxuQXcpt9s9jsOXV+rxRtP
	JfWyM3A4Hni/vQTG4V8YpksfGVTblrqhaQX2vpoSLhuqE+l9Buc0wbpKFLb1yPeO6E1A0FDOWxJ
	3ja0QyIObDXKW0hcdvBDMb1kdiCdIr2dfEsG4IX6TcgEiuDtM6Ne+jPaEmOp7z4G+EFQ2zhFNwQ
	63XSebz5geuYwkSMmYsse23asu2S7N6VecpFmEoCZd34hkN3v+s9nQ68h8u9CzyjRjtn0Ie7RDd
	3eUkgjg7yfiN8mrw3bKYalWpY5qSBcd9Jz28fvIBMakRZLBMkFgLppueL0gGLhnYGNDnpYAfBmI
	NmwHuVOKIyB/9ZZVdYPIaAP4TwxEHbOq0vAu21yQTWqvwBuDibWKmUVxnPLIIfuXgyUBO2aN0ku
	tSS5gHqLg=
X-Google-Smtp-Source: AGHT+IF75obF05pRCSDoHmhSCJ4KV5NKzvnP+ldmIdPGtIG19wcoSH7Zkp0oNWCaYAgKpgkLDnnNmRFio6gw
X-Received: by 2002:a92:c24b:0:b0:42e:4c23:5363 with SMTP id e9e14a558f8ab-42f87411154mr223651035ab.29.1760376273083;
        Mon, 13 Oct 2025 10:24:33 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-58f6d040ea7sm841378173.2.2025.10.13.10.24.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Oct 2025 10:24:33 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-78f28554393so237930406d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1760376272; x=1760981072; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HBy4kHeHSd7i/UWNv6ABVxAOKvBT8RoUJZm6Xy6Rw+A=;
        b=EzL9JUxGWQ99UeDrPQfgxn3AynRFrlL46i2600coYTShLI4zvQIRcOTq6uLumZZjCD
         OvZdyzdbQaHl1aQEhIwgQK6CCKGmUMDH0Do7uvG7CA9mMbeEylKeQsqhRA0GfnPIdjoS
         RUNcgH/VxJcbH1EAv3nN2zR5fVFdUIcqaaGSI=
X-Forwarded-Encrypted: i=1; AJvYcCWzT5RfFuI8ep922jajduMarmUhMN0RIJmGUeISAx27wwbp6dLQttd9RPMHab6+zk3cQRZ6JlwtwbjVUcc=@vger.kernel.org
X-Received: by 2002:a05:622a:19a5:b0:4e6:d5ff:64a4 with SMTP id d75a77b69052e-4e6ead70079mr314222341cf.71.1760376272174;
        Mon, 13 Oct 2025 10:24:32 -0700 (PDT)
X-Received: by 2002:a05:622a:19a5:b0:4e6:d5ff:64a4 with SMTP id d75a77b69052e-4e6ead70079mr314221981cf.71.1760376271747;
        Mon, 13 Oct 2025 10:24:31 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e72208f006sm35761411cf.18.2025.10.13.10.24.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 10:24:25 -0700 (PDT)
Message-ID: <35d91843-bd90-43e5-bd9f-5b6eaf4ab512@broadcom.com>
Date: Mon, 13 Oct 2025 10:24:23 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] irqchip: Pass platform device to platform drivers
To: Johan Hovold <johan@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Changhuang Liang <changhuang.liang@starfivetech.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org
References: <20251013094611.11745-1-johan@kernel.org>
 <20251013094611.11745-12-johan@kernel.org>
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
In-Reply-To: <20251013094611.11745-12-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/13/25 02:46, Johan Hovold wrote:
> The IRQCHIP_PLATFORM_DRIVER macros can be used to convert OF irqchip
> drivers to platform drivers but currently reuse the OF init callback
> prototype that only takes OF nodes as arguments. This forces drivers to
> do reverse lookups of their struct devices during probe if they need
> them for things like dev_printk() and device managed resources.
> 
> Half of the drivers doing reverse lookups also currently fail to release
> the additional reference taken during the lookup, while other drivers
> have had the reference leak plugged in various ways (e.g. using
> non-intuitive cleanup constructs which still confuse static checkers).
> 
> Switch to using a probe callback that takes a platform device as its
> first argument to simplify drivers and plug the remaining (mostly
> benign) reference leaks.
> 
> Fixes: 32c6c054661a ("irqchip: Add Broadcom BCM2712 MSI-X interrupt controller")
> Fixes: 70afdab904d2 ("irqchip: Add IMX MU MSI controller driver")
> Fixes: a6199bb514d8 ("irqchip: Add Qualcomm MPM controller driver")
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


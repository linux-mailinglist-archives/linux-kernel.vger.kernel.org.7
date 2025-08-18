Return-Path: <linux-kernel+bounces-774206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC05AB2AFDE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46E581B25170
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 18:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6395E253B4C;
	Mon, 18 Aug 2025 18:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="THFyUT9W"
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617131FDD
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 18:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755540143; cv=none; b=uqUMrNt2xbrhQwP1p8vJKEXVGbXYflO90jVO6AN4x9PnqhGCv/oTy+HlHRajFTppuiP8STDGLXw2GVWjBYymvMXhNPHwb3XbYfJ+oMd0kz86khyNuVklf/+gjvP5HWLwOe4N6nOqDvxWMXH0gwiIfi72QXnYnSVg6Kagi80Wry0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755540143; c=relaxed/simple;
	bh=A83rVwE+E37WuuoawwVfOZ/BQosRnUFciBwS/1+bCyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mn7VqpMGF7TGQstlXrbjl9FzL2dhO1vOvVdKafnp4AAtEvdaVJkTki4mBD4tcfoYqtIJBwp6vdBZ3lJBq0xdLVzJILAXVUeiaqXkPocgaCLIvIpdB9i8r+wahTkdqKVMXXKUxrwKVNk2Ic7kWcSrPtjq1BVKU1ccD3LVG0peEkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=THFyUT9W; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2449978aceaso3974565ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 11:02:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755540142; x=1756144942;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Igvk6AvqPGpyFLK199vT9ThDTTRRAoLheaWbPVeRxBM=;
        b=ZzxF4qNJOoeC5u4hAnJ9DoEGgJOCVqmLzmTcbFLl9EGbHmjpdP85nEi+SibRFgOoSL
         DNemSn1EjmeSUj8vjbMnybQooXG3l+/GNiPGF3Q33OliLdqfcJSBsMbut1U/3x1sq392
         LoRavM0AgMocgJL0sE6RS/flg6N2wtGSifKXoWceIp3rcaZ97DbZX9zfd8RssRhlAnc9
         KfNT/sz52d2CaGEyfbHoQW4203o2X99giLRx0OIBAKUP7k0nRKMG1P5IbCQYMwyz+8vt
         yw7GsnnM7FDC0D0jNnmJVwCQvbSHCkxcQtdUcocqZTVGbMEPPqtO3Ry4d7Z4iyF+8pgr
         7Fgg==
X-Forwarded-Encrypted: i=1; AJvYcCV97RyDriDXShupsCoEf8u7PfUvL4v5tnQwF0WotqMPUEY1CzeIS8kDvWENMLdnyK4DtI6GTdsnWqKe25o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFTfNhhSsDbxYkVS+Jqbq/WPgXAP+DdX49JoDqJyU6WAOp3msm
	91u4ZEaqbp6E5bKgte1Mg74odRSHT+d+5sO7nFdDLpXUuO+tuYzfk7T2I12QZYbjqdSRNJamW5/
	6/k8zECmG8zEj1SqLKD+GgocYHV/oRo/hBFvScBWqKdZom69R1GGU4Oc43I4BHWetA3HUDt4ZUy
	t8mZEniXkMvnTzN1ic0boHtEv7sLcu68XEAp/SmUGspjfR/juIqY0348D+FJy5Lh7qjbTzcdiRV
	RQdh36VhOgnIWwdlaPOHy4s
X-Gm-Gg: ASbGncuL4lMxGmFiumGk8VP+j2KoWvDcqvoEo4uDzWkt5MxVQQRRlldm48+iQeFpvJq
	TxicFGdvgo1MZew2BK5MuCrmCOFwwujMSZgJNqg71MFjhKffY05uwDaYzXfQOJEdR3dvazMUJPQ
	upG+ckaFML0LU20tDYEN+CKkcKhWdGF3ji2PsBy2EqLoVGHy7ISXrtZsqJ+3/+pamou53ixQGQT
	N7StctZHHzviFjYb3vUke/zwp056TJcJzA+YmYGiUma+UV6SiIJ3XQLG1QiTPSybPekDJEVqFzK
	nb/k2Z1Pdf5T0WuJE1OqI6I05buijiK58kkrWfsSkAyW+59cyAonyQ5oP3ry1Vdvtp6QJXofREM
	S4EdRYOKdyRt8ul56YLUt5JESy6K+DBbQk/bqfauFaiLhownTW6tPX8bd6iJxI3gV2rQkJ7zNxf
	zPYP7cdDM=
X-Google-Smtp-Source: AGHT+IHY76ZXXbTFuzM+MaeNAIQjaJm0R7HGF1lHQcjzSjQq5wn9kKJf5iApGbdXiSVFJgAw2Zycmw27nPZ9
X-Received: by 2002:a17:902:f603:b0:244:9c27:9829 with SMTP id d9443c01a7336-2449c279b7emr8154835ad.10.1755540141614;
        Mon, 18 Aug 2025 11:02:21 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2446cb15951sm7919865ad.34.2025.08.18.11.02.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Aug 2025 11:02:21 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b109c7e901so131599361cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 11:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755540140; x=1756144940; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Igvk6AvqPGpyFLK199vT9ThDTTRRAoLheaWbPVeRxBM=;
        b=THFyUT9WytKw9vv8XZXjHu+Omr9CdgXhBnbjT57taxIVZsnE5Ma+yAAysvUuObceYm
         FKd2bbc6NGt4rvArsqFfoo/tkIEXbgzde0xh/dr5/fui4LZ3+w2cGNfQ6G2GKdF5S/3u
         bmukFN/hFJxlyAvGws4RgHwKa4X77VXyJu8XY=
X-Forwarded-Encrypted: i=1; AJvYcCX1qc4esmEPw7UpS7qmg1RYxg+uLlF2SK6WA06DNYf3VaPSvex1PHazF+xEurN+obkG/4AlpU2b3jPlP1Q=@vger.kernel.org
X-Received: by 2002:a05:622a:d0:b0:4b0:6965:dd97 with SMTP id d75a77b69052e-4b12a75d90bmr125817611cf.44.1755540140271;
        Mon, 18 Aug 2025 11:02:20 -0700 (PDT)
X-Received: by 2002:a05:622a:d0:b0:4b0:6965:dd97 with SMTP id d75a77b69052e-4b12a75d90bmr125816951cf.44.1755540139671;
        Mon, 18 Aug 2025 11:02:19 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b120b96b1asm52522561cf.26.2025.08.18.11.02.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 11:02:18 -0700 (PDT)
Message-ID: <4c454b3c-f62c-4086-a665-282aa2f4a0e1@broadcom.com>
Date: Mon, 18 Aug 2025 11:02:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Add ethernet support for RPi5
To: Stanimir Varbanov <svarbanov@suse.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Andrea della Porta <andrea.porta@suse.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Phil Elwell
 <phil@raspberrypi.com>, Jonathan Bell <jonathan@raspberrypi.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>
References: <20250815135911.1383385-1-svarbanov@suse.de>
Content-Language: en-US
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
In-Reply-To: <20250815135911.1383385-1-svarbanov@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 8/15/25 06:59, Stanimir Varbanov wrote:
> Hello,
> 
> Few patches to enable support of ethernet on RPi5.
> 
>   - first patch is setting upper 32bits of DMA RX ring buffer in case of
>     RX queue corruption.
>   - second patch is adding a new compatible in cdns,macb yaml document
>   - third patch adds compatible and configuration for raspberrypi,rp1-gem
>   - forth and fifth patches are adding and enabling ethernet DT node on
>     RPi5.
> 
> Comments are welcome!

netdev maintainers, do you mind if I take patches 2, 4 and 5 via the 
Broadcom ARM SoC tree to avoid generating conflicts down the road? You 
can take patches 1 and 3. Thanks
-- 
Florian



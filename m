Return-Path: <linux-kernel+bounces-891203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 371EDC42241
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 01:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 63DC24ED594
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 00:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B59728469F;
	Sat,  8 Nov 2025 00:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="J0tfUFFv"
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA5534D3AB
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 00:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762562559; cv=none; b=cctcfDzMNwRuaw9y23TRZsf1Qu9Po/89PGIeyVRsV6zMoyJdroeh3FsTnHeYJzVrhgM9zkjRSy1Q+GZ0eXAOgTCkJWmc6JzspmMKoCAhb1UcHHLkYOOQwbnuyFrhQzxGS2Mfh82sqtGrk6NWOL38YVjyrx2tjRYPl1z0NMQ6HfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762562559; c=relaxed/simple;
	bh=iCRNFT0lfqVAQwsfcs1Igkvt5l4idcF6a3puc5VTpCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ps5uXnSHiO4dUDq+zFLYEE3gNgVpAHPsmwrCvkib/3eUKoojNTXmZhcav/mG4/eU46rk9LVPOkbfpT01SY28ykx+Yd0xHY7gcotJPBNv7lblWBUPASv+h10jYf4jlfrYFJqtDhLZhMAfW6jul+1fek/I/hAvL/FToAYopQRCV/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=J0tfUFFv; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2952048eb88so16486445ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 16:42:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762562557; x=1763167357;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WmsLMwcxvOG9UCoryp3QTB9cVXXakikEBmOQRVaHblg=;
        b=GqwvuzKJTyyrgEI1oXFY+WDo+75CwPIxJ/7aw3CZJ4pMK0DnlVALzImMOUcLEvtlQG
         BOczt9dpoCWvWbQuMTxpssEYMw+LkNIJmeeU2kDaZHpKdbD3ln3EMe2E6oE4UptiDd+W
         bQSrrAFWSuAQRD4l/Ibk5+Sqpdl6ujrC2HIBh5HBE6YwmBK9xvLBOQVHK/0ebmL8WXvC
         rYyQvYojv5h01iBnEZeB0jv2PKVxJHUjAmZ7uN3mjPly299NGsa3zNyNtOO3/TPqoWlv
         IBWgaH8leIASaFhNfk6zKyGJNM71ebVPxMMImjCvw43685YrYxrO4ToGjb5ktjh2Bswt
         snUg==
X-Forwarded-Encrypted: i=1; AJvYcCVO+8kwzF02i9Kze4ToKbcWtySy3ZtFQrRtaolEt/X1l1vMGTGfwNIVdW+8ZM6gRxgsWEQcfRwh5psjklA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRPkA6R7ilh+SpKSG7Z2dm4h3fmg2NrWSno+sWdU9vaRVQNPHd
	ZhqdrR2od6UItLGXx0m4hmxXR/ol0DPMSlJvrJ8XWbOEN6+A8jcOo+lrEWc8DWomR4xsfjHwL8u
	QkXngVtHRNObhRM72ElCUbLMlctYlh+uj+BdD6TIX91GbgOB7to5mlRajvjqo1HltTWx9pVYwrz
	RC3sbfNrkmaCbqQxD3gbZRI5A214UqN84GTUKOl1apsgSl1+nZV/MPT5uWZiOTSdzn60mNV23dY
	0as8LsCJfuX8OEg2woSeCCD
X-Gm-Gg: ASbGncvMXNZ/ndZiYNApfgEqtZ4en63HBJRrITWJGB/Fq0uTUm50xJzl59sYH2Zzl1U
	Qie4pBvbUffphfNOVqxI1mavzTbVy9W6k7LDxL9OsYEGt2ol1oYqP5nXJUUbUicPSowQOQD3L31
	op7sQ73RMy98k8G77NtgKO4Wmbxs54T5R/YMy5dOvKhzyrrufpu5/TTOl8+YrsXp6Eg+J+K7Gpj
	PB6Qo+trWU5W55hYgeP02XTW8vPt1O2XfiZ9uM+G9cHmo5r0WEVhSgFBa9oBC6ZjfYN8XIgSMWt
	X8XniKUP/0qyQPeP+pwuqwZGQHQVezpZVtvLk7kDhJbD3SxAvjJ9HzV3zqYIR/icv7ENsw3wN0S
	jHgTgss1Mbk/oaCW8RQq2Pc5a7yH8DjL2tozSUWDy5Na09fV8hJ6oZXuyU3c1ueg4X4cdBQyWRc
	+Q/Xfqf5bc/9z5moxV7S9WDrB3bUR1vC6wv1r2nGLgxg==
X-Google-Smtp-Source: AGHT+IFS+5pc6fq3/HBA0ZucNLRiZhfTjzKe6flVH45Ya+o69kyxRF8nM4w3J0Tk0sNDn5D5eNCQGscnO/vw
X-Received: by 2002:a17:903:3846:b0:295:50cd:e759 with SMTP id d9443c01a7336-297e5709b9bmr11355555ad.58.1762562557421;
        Fri, 07 Nov 2025 16:42:37 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-116.dlp.protect.broadcom.com. [144.49.247.116])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2965096e32dsm6287745ad.7.2025.11.07.16.42.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Nov 2025 16:42:37 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7c52a4599abso608712a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 16:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762562556; x=1763167356; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WmsLMwcxvOG9UCoryp3QTB9cVXXakikEBmOQRVaHblg=;
        b=J0tfUFFvemSx2G0HEoIKfArG8XL4PAvIbsUP4mRCzQ2XRWSfSGY91/LM3BfwhuAkZh
         OpI0CWsIs8H+jdmRIyxFnb9V+lB2MJFsJe3S5FubBtZ0TW23DoEgACdgzUgTQAJKYVDg
         G/u1LMpG9Ek0jKW5ECd1mvUrNTgPNv6oVqJrc=
X-Forwarded-Encrypted: i=1; AJvYcCWJbliNreHRrrEtlICL+f8NYDiNNzFG2WbDhGi6+DRP1ATeAzzm7NJjQD1DRmizuFL0dnWi9qYwmAB+Xic=@vger.kernel.org
X-Received: by 2002:a05:6830:6e9e:b0:7c5:3eb9:8b7b with SMTP id 46e09a7af769-7c6fd817408mr884030a34.35.1762562556076;
        Fri, 07 Nov 2025 16:42:36 -0800 (PST)
X-Received: by 2002:a05:6830:6e9e:b0:7c5:3eb9:8b7b with SMTP id 46e09a7af769-7c6fd817408mr884014a34.35.1762562555761;
        Fri, 07 Nov 2025 16:42:35 -0800 (PST)
Received: from [172.16.2.19] (syn-076-080-012-046.biz.spectrum.com. [76.80.12.46])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c6f1132094sm2354138a34.26.2025.11.07.16.42.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 16:42:35 -0800 (PST)
Message-ID: <6bf53848-e8f2-4817-80bb-96da27b55087@broadcom.com>
Date: Fri, 7 Nov 2025 16:42:33 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/8] net: dsa: b53: provide accessors for
 accessing ARL_SRCH_CTL
To: Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251107080749.26936-1-jonas.gorski@gmail.com>
 <20251107080749.26936-5-jonas.gorski@gmail.com>
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
In-Reply-To: <20251107080749.26936-5-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 11/7/2025 12:07 AM, Jonas Gorski wrote:
> In order to more easily support more formats, move accessing
> ARL_SRCH_CTL into helper functions to contain the differences.
> 
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian



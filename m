Return-Path: <linux-kernel+bounces-801472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B208FB4455E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 20:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70E6F169069
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6CB34320B;
	Thu,  4 Sep 2025 18:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="S4S8ysuh"
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD963431F6
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 18:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757010508; cv=none; b=ADFFZgW3FoQMbaWzdW7OeDe7TPnQaHFWh4RWMbJgDZ9AmQGViNq6rttohW8fjPfCil7/wZxCRIiOwxKpmB/i8T13E6pm/q4ZIkWvyD75f5hKI5dz7DJNv1dsMLqGcwkO9fzZn1NfOrAVEnVur5DMSu1peJU5xSeO8dwFDa6FmLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757010508; c=relaxed/simple;
	bh=FIGB+7RU64J1zqu7rqAxJlLVLxSkkOaRHMjXZLDhXT4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mNTzBr58W31j5sMLb9DLO3cXd+ziUW2zKtrUr70OeB+yQ+9QFEmaSLDrNKQyZqwyDEUGR/bCzLpEf0GaUJTohOqRVXEk75g+qCuA4YGIv5+hIsuPAkB/f5r3QorTmsEj2rkRbC/QL0EPxO8ybf0OkBy95bmtXJqFAs32TmItE+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=S4S8ysuh; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-244580523a0so14907215ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 11:28:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757010507; x=1757615307;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zUrqc7BcglwR9vmo4HsZlUa9qx6Ep9oVQMWGk598+u0=;
        b=a9wyJYpkakYcuPt2Xvy519gyzsYZ4njUAatMoH/8kUKiC/VmceIALuaN62CgWJJPZ1
         4zxcii+3EjF1Ip8QXeKyGx8sRoTMj8oAriffpsjDJXDqxDigNABsTpKJ5rQRg5nlCJZY
         0Y8BQH/+DfWBhACuIaPajVsAAj6wWg2cY4VA+K4PjoptshlpIKv+ihHeJx11XN3T80s1
         hE2NEL7FSV+/7E77aF/7TYPbyY4owdhRp/jnZlBYSjFjiOlDPoAOO/KmbL2W/sIp3q7t
         How4WNFlHSa3hvRzXGgzKSHYtOyOTblD+LmYMB/sSSWXsqkBL2muGUVsGo5M43eERMOI
         88wg==
X-Forwarded-Encrypted: i=1; AJvYcCW11PwY/VN7zeFQJSqcQIV1o8YgiHnJrdE/9wA/aa6VMQ5N6c3N2YK+IdJ+j44/3Dm+LSxU3WBjNy9MDeI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx20OaVWC4uuf3rj0CrtsbP0p9UYWCiOBE4h3iplcZds3wYqgUf
	O/U6KJNYbM9ZSqQr01Gx7h5zEyai40Kv2sUptzxLwfOWoGgYMSYueKO6GZtwjfjhU7Y6XEjozHP
	rhaf3TrJm3gFvjOTL5TtE7872r68czfbudWWU20G50ut803IguPi0O2oEJrHus0ZYNWL1N4lQ+x
	xjxIhJXmRm+LfizZRPpmRFJoVpgXLesAxZKDtNXuN04EaAS7C5yJbd2CmxPoHKG4OtAQBzWd/t9
	x2ZVdyrMO+7yR83JTq7JKnk
X-Gm-Gg: ASbGnctoT8q75HLHAhLH3HroNZ0AX67DZtvOhGLq9ZFrdffxwZKPI7ww2KcajNyCvZQ
	ASyn0mTGTdPkF6f4Y8sL6E4IO/ZGR3XlCabuqrFPsE/7GJJWtg5vhwLO8t9YXVdvzKHpaWgR0o5
	oQ07AqXhv+NbARgk/O9kQhPebiooHoAx+jc/rwbg+AIyfKs2StTq760sKvO3nYFEktP7JSg3o9u
	MpKnEil48Zvp0+NOFTSgqylwL6CeiNQcLjCFo/8MRQPUagAP/GEbYI180FX+oILWhZTDqySMsWV
	qLkS2rC+6KVUvNk0lTIpUh9UzBucYN9RATEmNQa0BryK1cbjgwLW2a5/kKnROGAE9eToH629QPq
	6eIOyGOr6xCUBVHBFttV/hYh0sn841Rgrt7jJsjmUQvxcHvEWJISju5dSLHTO/NmdcvrCIz+PS9
	5WSlNw9RU=
X-Google-Smtp-Source: AGHT+IHj0iWTFY0F1l/U5u3ZcCfi07BtVVp1xgXczZ+n0KXoK4ran+BqdBiq256atgfjnwT6sPUehY0QJMWA
X-Received: by 2002:a17:902:e790:b0:248:79d4:93ba with SMTP id d9443c01a7336-24944b2a01amr272595815ad.39.1757010506365;
        Thu, 04 Sep 2025 11:28:26 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-24ccef48633sm1666325ad.45.2025.09.04.11.28.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Sep 2025 11:28:26 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-720408622e2so23182686d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 11:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757010505; x=1757615305; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zUrqc7BcglwR9vmo4HsZlUa9qx6Ep9oVQMWGk598+u0=;
        b=S4S8ysuhus5L4xpxqZyv4HanPBwu592KJ+jRAZii7U52/aheJIMdWCMeqySJOTQtsy
         t0fHef8/d+M8xjZjq9IUpnu3tvMGgMOoN8LyomwHLR+60StrYo9i/qk8XHhVm/Y8aB3j
         Lrl6X90cdPkUW7FkrBz3/jagxSD8MmCJl7fGo=
X-Forwarded-Encrypted: i=1; AJvYcCXEEgGLS1Yg94TGBh96D/37djskDPpY7+49hlpKpA7V02kUoC02h21WBtNNHjwgE10QFGLx/a7D1GuEjFU=@vger.kernel.org
X-Received: by 2002:a05:6214:f2e:b0:721:ecaf:500c with SMTP id 6a1803df08f44-721ecaf6105mr113127056d6.52.1757010505049;
        Thu, 04 Sep 2025 11:28:25 -0700 (PDT)
X-Received: by 2002:a05:6214:f2e:b0:721:ecaf:500c with SMTP id 6a1803df08f44-721ecaf6105mr113126596d6.52.1757010504453;
        Thu, 04 Sep 2025 11:28:24 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720b682faa7sm51543216d6.66.2025.09.04.11.28.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 11:28:21 -0700 (PDT)
Message-ID: <e1af06e4-4583-45a9-8404-34a01103e92d@broadcom.com>
Date: Thu, 4 Sep 2025 11:28:17 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
From: Florian Fainelli <florian.fainelli@broadcom.com>
Subject: Re: [PATCH 4/8] clk: rp1: convert from round_rate() to
 determine_rate()
To: Brian Masney <bmasney@redhat.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Vladimir Zapolskiy <vz@mleia.com>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>,
 Michal Simek <michal.simek@amd.com>, Bjorn Andersson <andersson@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Andrea della Porta
 <andrea.porta@suse.com>, Maxime Ripard <mripard@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, sophgo@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org
References: <20250828-clk-round-rate-v2-v1-0-b97ec8ba6cc4@redhat.com>
 <20250828-clk-round-rate-v2-v1-4-b97ec8ba6cc4@redhat.com>
Content-Language: en-US
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
In-Reply-To: <20250828-clk-round-rate-v2-v1-4-b97ec8ba6cc4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 8/28/25 17:38, Brian Masney wrote:
> The round_rate() clk ops is deprecated, so migrate this driver from
> round_rate() to determine_rate() using the Coccinelle semantic patch
> on the cover letter of this series.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>

Applied to drivers/next, thanks Brian!
-- 
Florian


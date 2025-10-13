Return-Path: <linux-kernel+bounces-851176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A19BD5B0A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A02ED18A6DB6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E4C2D238A;
	Mon, 13 Oct 2025 18:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DdlJIb9w"
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E64026D4D4
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 18:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760379764; cv=none; b=uTNTRnwu907bFRCZUSuMie3myqZpMJeIH54rTdszDlNBUmg8xHvpp2Mx3r2ui7vPE4gsA0sirLDJPqxY8+m8C1dUi+6eiqaP2kT/USnfjGH8MMvTQZteL7r8vF9fpbCAb8D/LZkNK6h3Ok/49x3Yu4xSBA3/tFlP94GvsYBDjTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760379764; c=relaxed/simple;
	bh=HBLI6tnLoPVkcA7kJixCFzJ41wbMqzabPW6Re4kMKHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JK04CEepxwnOKEyTbd3VQtKP0HF94cW3EsvnLMCbom7Uil/oZKoYrd6KGggiHKlPIVIQ5+gzKmEgRIY2nIMOBf2iKk6iwjwhp3coY41vFnR6EgMYekDpXFthF1mH8EmYnmQ/gFPuW5iTeWM9z9iwmsM54ahSkjJE6m1evRt8/ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DdlJIb9w; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-879b99b7ca8so66970976d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 11:22:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760379761; x=1760984561;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C1tY6qZ8mNmYyGrA4pTu8tZZtm4ESQYe5l2QvakWduo=;
        b=bgSWxKXB4o5ZFZb/FlHUaShZpXxRlUz7e3zAE/ujco2ruIHak5FTLrUS+bQ19COsxY
         H1bpYkj17EU7CSDOONgfgR3XiKQX7n5S0lNS9DcrPDof/TOt7qpGZ4KYiYDrcq2HAlxI
         6jtp19c1V0D6RfuAzehKc59xMqqbxQKx1lu774JWeU72mnvomvcvZrLBZh1SXZkMwVfK
         zIuwBtgH2HfbCUfb6O/9vE0zLj+sLlaqoefy9/NQ8/spgAMbu1PuBuKlOw86stiMAVJK
         jLbp3JKdX70P/uW9r9n52qfpHhRvqKWnYyO2neoAQtrd2Q/ImZ0SRE3+6UQRHkE9XhBi
         WMgA==
X-Forwarded-Encrypted: i=1; AJvYcCV2n+l7HP+ob6qZP7eg0aN6yalsKC9xZdOlggLcXPTw4biUyLbRYFFw9Gz+yGnAo8rCWDqKh/PXgUtGu6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIpW1Adj9F1NbOz7a2UR9i0c/+xG4dv6Ehd3kpsKNl7a7eqZW1
	H8xK364zv0qJMmN6MJTDhicF/G6CspIccTLfZwsCqRDzeRrk2959IV00+sSBr6RUZOxyN6H8bq3
	f4PrQouBxACqipQnXRSdErKWu6GL7tqi3ycMLy6GKRqcsuT5vjjPB9P8fUVURmeKtj/AnCO2hEa
	Ux34ym8CridLqOHWPPpn7Letdo41idruE4/aSxR2IP7QVz5QN+/q0oF0MXI6giifGo0FejXqFFp
	8ErDrLAVraRnyv2FaO01zZy
X-Gm-Gg: ASbGncs//ts2bzKv1Jy28nqHirQP39tynPBfL/UKkglGO5jEi+s9HOw3hc54Rn/4tM3
	IBMwRC2K2uhxDqMVfPXuvgQWj8LQveraJG0O2sIUMp2hbm1xdRJ2UoB/pPOTho4kinrFKsOtSSq
	lS7gAzZ8UCEThtg/JI9Xz7xJvpi5OkEN9magfEmk7aV9oQCFW6FEBN+mxegwsG/MMHIadw6srh/
	dsEg8uZZ5EQtHePXCuJrFuy2vkJTBNObUTxriR1zj34dq1apHYgEcgzSistBvXNKdE6n+HrMzdG
	r8UeHKlcN/avG5k+rqFRMf8vsTmSPPQ2Ffil7KAgERldOQMbqIHwT03XT/5ftUGDBonMiZjT2Mh
	v+J3b8/NcPNLwnn8mKKdsHjslHVdB/hb3UkZBC5C5z6jP1tVgDmiGHG4xl0j7d+yKn+UHKOyX3Y
	A/Pc1d1yU=
X-Google-Smtp-Source: AGHT+IFprFkfkjkkTsVdtkKK27OCoIpaDLffvgBfYz48SWSaziSl3ioMDJvYvIOJ20iBCq0oO6iML1EEsKSO
X-Received: by 2002:a05:6214:2583:b0:7d2:f787:1978 with SMTP id 6a1803df08f44-87b2103b6a8mr269847876d6.3.1760379761335;
        Mon, 13 Oct 2025 11:22:41 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-4e706eaf077sm3816441cf.6.2025.10.13.11.22.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Oct 2025 11:22:41 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7811a602576so10830574b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 11:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1760379760; x=1760984560; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C1tY6qZ8mNmYyGrA4pTu8tZZtm4ESQYe5l2QvakWduo=;
        b=DdlJIb9wsyvMbsxlOmchuB1a4yxqYtqL9Hszv1spyu1+DPw9A8iGWxdj2rd6bSc26U
         l/8dpCv+Yl5JnVJ0vHsdpaSSF/ulbFsHiPB76BrfavEvj5jVMmcH4icPAZPwY4cF0PqD
         oU4ECWRsI7VGEHS8LOFrsKieQS0W0Ufkv7k3c=
X-Forwarded-Encrypted: i=1; AJvYcCX54DxV6XHseJg/RcS4XQjuxPLpWSAnfldS47kZZlov2pxDAwSfk+i+eI33DN1O+EMuxCl97lW5Nve5GbE=@vger.kernel.org
X-Received: by 2002:a05:6a00:1748:b0:781:18dd:31de with SMTP id d2e1a72fcca58-793858fb2d1mr26473991b3a.12.1760379760128;
        Mon, 13 Oct 2025 11:22:40 -0700 (PDT)
X-Received: by 2002:a05:6a00:1748:b0:781:18dd:31de with SMTP id d2e1a72fcca58-793858fb2d1mr26473967b3a.12.1760379759722;
        Mon, 13 Oct 2025 11:22:39 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992bc18c96sm12339757b3a.37.2025.10.13.11.22.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 11:22:38 -0700 (PDT)
Message-ID: <1dc04a7b-d17b-4bca-9391-7d06d0c563fd@broadcom.com>
Date: Mon, 13 Oct 2025 11:22:36 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched/deadline: only set free_cpus for online
 runqueues
To: Peter Zijlstra <peterz@infradead.org>, Doug Berger <opendmb@gmail.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20250815012236.4053467-1-opendmb@gmail.com>
 <aKMja4BvgQ5vFaNN@jlelli-thinkpadt14gen4.remote.csb>
 <20250903075436.GN3245006@noisy.programming.kicks-ass.net>
 <5bb8ad3a-9d05-4d07-8d4b-207be28cceb1@gmail.com>
 <88998fa9-b454-45c1-a8e2-164d2e2d94c0@gmail.com>
 <20251006184710.GX3245006@noisy.programming.kicks-ass.net>
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
In-Reply-To: <20251006184710.GX3245006@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/6/25 11:47, Peter Zijlstra wrote:
> On Tue, Sep 23, 2025 at 11:03:18AM -0700, Doug Berger wrote:
> 
>>
>> Is there any way I can help to move this patch forward?
> 
> Let me just apply it before it gets lost again. Sorry; sometimes the
> amount of email is turning me into a goldfish with ADD :/

Should we be able to see that patch in linux-next by now?
-- 
Florian


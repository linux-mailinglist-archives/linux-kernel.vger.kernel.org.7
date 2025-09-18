Return-Path: <linux-kernel+bounces-764380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C93B2224B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A96604225BE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACB12DCF7C;
	Tue, 12 Aug 2025 09:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ss0GfxD3"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDFD4CB5B
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754989256; cv=none; b=Xe761PuSVPV4Dr8GGhGCpmWBhIhFmTWGTm4SszHtJftFU15kGyGq8K6SCFZLI8BP1LHUqWNiuPDEja8roPn/opwWlU5yLWWEMCBACkGfFqV1tn8Y7766QoThvJy3aZx4iDPqG5yq28gsHDTOLdiejC8Y2ncAsEhj4Cgy/NiKGns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754989256; c=relaxed/simple;
	bh=fy78Jp4P1LO4rZbIIu+gNVO4SGVSEz4RbE4x7iWiTBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=adFbcBiNCN7pk5DDBo2/xneFgm/Wqgba/uMfX0tnNL8QviqzdktFQr/H7uggTtcBbfJnn/b77My0udcdSU4HqHGip4k5NqAD77qfmNvD9CpOKNUbqFeVSrKwgJOckh5Lp4V49+8p58WSWw9PGTyz1HEtZ3GhFP0IxIK27YUw9uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ss0GfxD3; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b7823559a5so2471989f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 02:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754989253; x=1755594053; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fy78Jp4P1LO4rZbIIu+gNVO4SGVSEz4RbE4x7iWiTBE=;
        b=ss0GfxD3Sx4ct1z7Rir5420EkNnhdjtF10preYgo/GrIMjy4MONS+jhW8qa7U6YlGu
         m6fAOSKpP6RNvlnSmCutCZ5wbQdXKHIL34kyXQloZl5jutH7/o8Onwn/ciTEbW4oIBr3
         o9PbUPeiiBNMs5xxMkH0jNXahHY5Rj7UsnZj8oJNNPOXbOdMTvQAC9E3Tj1MDU5O8AbK
         MrUbBKwEe9QofoJFGKD7zVKComDgnEO152wZMSMROq+mkzPq62AENkI5zl8Q8+KqbfTV
         je1SCSsrh97BJ1m5XFab+ZqG/Lx+VoVOqD0N9v4Is+hopU+Jh0PmQl5KR5MHVI652JT3
         5xoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754989253; x=1755594053;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fy78Jp4P1LO4rZbIIu+gNVO4SGVSEz4RbE4x7iWiTBE=;
        b=juQSOqcKW5reqQHqdt0pAPzEM/cj9RwVpXdoX01FCJzD1wDC2RzlrvnFJk9DpjITQp
         jgWPXXc08yYg7EDWa8JsQpJJf1v6REZ1AzAnoF5ARUsYGfwEvFuZRVKOh8xLRFvH0c9L
         GRJAE6AmvoOb8BQq+FWg6Orpsl6FMayc82P7DCO6xjievCHfeWDQE63R4jh9MJwCo+3d
         8LfYi+AaI9jUGhG0sV/gU1fXt1dgPXkGtaV3ZwogMlTLx5hiGtI3MMT5Dtdgdq/eFJ1c
         CfmmmwwMQMBkSlFf/pOjZJKpQ/Puh58osz5ropTshGB/hj96De5CJ45Y4XEZkPsrsbkJ
         O7Ag==
X-Forwarded-Encrypted: i=1; AJvYcCXGXPP10q0B6aAvpzBrX+n95QgzWFGuWkI8spQVKwIUQaqy4tLvJLzQVYLDIz2kQ67kTWkromvObj3M/RU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBd1ExmeD9czAcjMhoG1/4NzCco9wvdu7qGlFJ3fmVE9S80Z5i
	r4mj25yEnfk2xNhBOt7x1zyX3cH3a4m7tkHTB5OF12+1MpC3+hyRAiZTSBDI2AD5xDo=
X-Gm-Gg: ASbGncuv4ccKluqOYGT8Hhk2QaEVOhXMD+wBi5aRz0cXoFDpScmCjKTC5wlDbE+hEoI
	7UNZmVWoavBJdCtJfwLfeoTasOSvKQM+orGbFN08YaZG/ICMdtm8IPokw5mvZ1rEgf1Hm2rLJlX
	1Ith0CnZuoX3KCNGpe6LDKC/Dm9hTx5SbwAOOfNktDmsWzagGhKG3ANnQklB83Z2KhsNMiorJZA
	7SBfL7+2Gz8z1jUUFHdMR/1lcNEajTqeV3TjlaHNocTawTee+9o81aNJMoKwHTJbitDZbIdBIOy
	EPTCeM7pnInvaVbkbdA7ODDD2qZsvSzPI3C2h123Oxd99AQ7P9KpKWzcZpy7PCvHpRJ/AefKzca
	rEjSvye9NM+Szn7ibC1fyVNL66RAPWPo/wIBEpp3/qTwLjp33MKrL3W9Cd1FxSSs=
X-Google-Smtp-Source: AGHT+IGgf6IE5QU7F/5cEqMJuSiQxnLhtBPDTGDlyRH9YPXSIH/Jdg+r30fMZEER57XN0t3TVHpcCA==
X-Received: by 2002:a05:6000:144d:b0:3b4:9b82:d432 with SMTP id ffacd0b85a97d-3b910f8cf54mr2290237f8f.0.1754989252722;
        Tue, 12 Aug 2025 02:00:52 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e0e70218sm315924085e9.20.2025.08.12.02.00.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 02:00:52 -0700 (PDT)
Message-ID: <af4cd1f0-9f3a-4eb9-8cd4-ad20506c7a9b@linaro.org>
Date: Tue, 12 Aug 2025 10:00:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: iris: vpu3x: Add MNoC low power handshake during
 hardware power-off
To: Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
References: <20250812-sm8650-power-sequence-fix-v1-1-a51e7f99c56c@quicinc.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20250812-sm8650-power-sequence-fix-v1-1-a51e7f99c56c@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/08/2025 08:48, Dikshita Agarwal wrote:
> Add the missing write to AON_WRAPPER_MVP_NOC_LPI_CONTROL before
> reading the LPI status register. Introduce a handshake loop to ensure
> MNoC enters low power mode reliably during VPU3 hardware power-off with
> timeout handling.

Can you confirm this is the sequence you want for sm8750 also ?

---
bod


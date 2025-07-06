Return-Path: <linux-kernel+bounces-716114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A209AF81F2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 22:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 342ED487C65
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 20:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CD9225A59;
	Thu,  3 Jul 2025 20:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ROXWG759"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19DD291C33
	for <linux-kernel@vger.kernel.org>; Thu,  3 Jul 2025 20:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751574498; cv=none; b=O80VAcVM0cLsAV/Je2m2SKmGmNPvcyUItY/PV2pX3+DIF8a3oOoPQMbAjxwVPKbH9ibjHniSDVy+m+OfPLfcYJjQ1v4/etaJcMnAjyGyewAATuMzOND6mE2dyRhYcZlDhPz7Y7CaSS2S1jWJgHUelQWKbVPJItszDf5ZaRtk2NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751574498; c=relaxed/simple;
	bh=U7AmtgF3IwYm62ypi/7AR530Tbla2xssqfyVoRZWF0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G/3w6nUFTupKGtv0xht6R/NtQXhPm8xrlk5rUxWHti/iVJ1j1RRYez47M3rODTKgsiCSKYaEpSVRmu6AMc32Iz2AmVSuyfHzy8f7siHMGBcJ7d1MXCSL5Z2XmGj7wNp67ZOD+xc/bOUucZipIFKVL8Of04GfLvJuYUP2kuCHisg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ROXWG759; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a582e09144so132127f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jul 2025 13:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751574495; x=1752179295; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e5O8px/YNH1nurLN4WTbK3SKi9r/Z6D8/ENOb+Qojmw=;
        b=ROXWG759KEzAxozseKEVlD5kT/yOw7CH1eGFL6Ovpj2sSThf7Szvuo6NGt8mFblMmG
         om8JZQ2Kl8gdP25bHeXX1iWILPnjmlry7Jga/hv7/igZeAt7xhtxnkFOsVLTNsgZpV/I
         EhIZr9IUftmZhye+VOMGpKvtsDBU86zAeDY18fw/uK5MTLaFftc4Fuj0fjmGJyHB04mp
         Y3quHxZSFfqj9/uPF9sZ4RrAbQTCj4g2o2q5Z3ZTEsDE/HtNSk6hJ860yDlpFoGb9eSH
         OclIoJhS+cktCec7Vp54urAY3xP+ULuW97BHLdnXokLbGOKrnZuG2cwEg7lT5TKkuLBV
         PnUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751574495; x=1752179295;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e5O8px/YNH1nurLN4WTbK3SKi9r/Z6D8/ENOb+Qojmw=;
        b=g0h7pZQu0sNZw6odj9S6oFgZ6Qe5Gc3AOI3Mos/FPYe1hSCPyp1V4WsNJvLzVI4Qka
         zSGjt90BD9bxwzgJQAv2Xl4j/74xmr8nMlDtfYHI9hok4Vq1PV+QPSJ6eVyMJet6XKXI
         mcc3aOkVIcgcTPrCFOQ01B9UTtTI8S6+j3rT7jO5n2vFOEEtHzteIVxSHSZJFRqDb/Tz
         YDMXSC+3pNXsoT/UatERRWGdyymPJzYduaI0cVVif0moxcnqSiclbQFR7GR+g5awJo0z
         oO/10L8Dapwc5YtVGJRLQUEUWgIP7Qu6VLpnd8Yb5cEFyzhJZOQAtJ+P9i3+36IKP9tf
         +J4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWxbbMs3etHp9cxLqdxHtUrm20N1I4muF8WVUrnUIUN601uVcbCG3/owo0/ReniTbvVnDW598T2UibOvP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI1vv87OyaGFoCAUP72N04hKuu01X5W+vb9gN6sloXEbCA4Kwh
	5lG39caOIIdxeGSRh2qmgomVUqKye71x4a4g/JE67SDriIEHItFmpWNh695Zk/7+Bvo=
X-Gm-Gg: ASbGncsiogyZUU8tjWW3Md19UF+1xSw95A+FkZqU+dDOwGate1oU6IX1IBUlVzqs7Ke
	Ay6/Ucx/8cblLn7giXuw61qMi441CRBo5IRhnH3ldTpBHmKTdUusMBfV+N0bLJMMum635jid5ts
	kb9zy+WeH9+enSO6YLGeWKXm+ZgiZ92pKJK4KsNLmi+OIiSTjvRtalH67HtV2Rp2FBiZsQUheS3
	RDproL1Uo01AZZk75tAYU2nASh96aAppDCFFP3H7NoLMA+KyJXjrJM0YYwdRZ7NDqrvRzCZqNst
	12EAaDBYf5Vj6duKw8ZdBN3bxrX7DSTfVk1Uya+gdJKWhoV+07tGAo8Xv8g8n6V1riD/HdqaVtf
	1bLGKOxYBUoHvbUUkWMqHMLSDgRw=
X-Google-Smtp-Source: AGHT+IH4o4ymOoffJrXAfZdAqSKhMIFw7CrgjjaM1GKfgO81ydOA6IKmZrwgR7eOW421JQWOQM5WOg==
X-Received: by 2002:a05:6000:26cd:b0:3a5:3a3b:6a3a with SMTP id ffacd0b85a97d-3b201ba1ebdmr6512564f8f.54.1751574494978;
        Thu, 03 Jul 2025 13:28:14 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47225afd4sm597179f8f.83.2025.07.03.13.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 13:28:14 -0700 (PDT)
Message-ID: <af0da28c-3ca0-41dc-aaa4-572723ea74bf@linaro.org>
Date: Thu, 3 Jul 2025 21:28:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] Introduce "non-pixel" sub node within iris video
 node
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vikash Garodia <quic_vgarodia@quicinc.com>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250627-video_cb-v3-0-51e18c0ffbce@quicinc.com>
 <5f90547d-945a-4e26-b36c-75f2d8a1af97@kernel.org>
 <eab8d79f-7188-9537-9176-3e4d22f0978a@quicinc.com>
 <5ad418d9-8199-43c9-a477-1e3b939c054c@kernel.org>
 <7b6db4fa-2f73-376d-4eb3-64c1c7e6cda3@quicinc.com>
 <f5ebf0d6-2f0b-45cc-b99a-b786e5df9edc@linaro.org>
 <5qsgbqml367yq6g5vb4lotrzulojqhi5zlwwribze373a63qrn@rxi4kwyt66m2>
 <4f38058d-a2f1-4ac5-b234-228cfb2e85ff@kernel.org>
 <1ad2ca1e-1d57-4ad8-a057-ab0d804f1d49@oss.qualcomm.com>
 <7da769b4-88e9-401f-bb21-0ff123818b9c@kernel.org>
 <6840d462-8269-4359-a6e5-d154842b62db@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <6840d462-8269-4359-a6e5-d154842b62db@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/07/2025 16:28, Konrad Dybcio wrote:
> Back to the point, I actually think what this patchset does is
> resonable, especially given the address range and SMMU SID requirements
> that the OS*must* be aware of (or the device will crash after a
> translation fault / security violation).

I still give my RB for the series.

To me the only question is should it be applied to sm8550 or to new SoCs 
from now on, sa8775p, x1e and derivatives.

I take the point on ABI breakage on 8550, so to me it seems fully 
consistent with Krzysztof's statements on ABI maintenance and indeed the 
need to expand the features of this driver to do so from the next 
submission onwards.

That can be as simple as

schema.yaml

if compatible newsoc
     minItems:1
     maxItems:2

8550's ABI is stable and new SoC submissions will support the 
secure/non-pixel method.

---
bod


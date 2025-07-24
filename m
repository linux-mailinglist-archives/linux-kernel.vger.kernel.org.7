Return-Path: <linux-kernel+bounces-744190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3125B1094B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 13:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AD457AD6D0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2764F276027;
	Thu, 24 Jul 2025 11:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KsnNLeKq"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC95274B24
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 11:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753356775; cv=none; b=Htt7n7EudHWX09vJFKaBNlWJYb6tvF6YqZTIWvQTm1SC8ZKqF31NEQiOc+NIyosc+9x2ntkYpmyT/cAArmg0wOsi/OzAswmEjhERKhKzW/u+GlM8Y1AFXkNww/X0PA6xZUwOpqOtganBroaqHLvAvIrcCmU0FbHoqVmoS197c4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753356775; c=relaxed/simple;
	bh=9ldZRzjPyr6R/RppclDLygRd+Xb1MSv4FA3aRAISP2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PvniuFUPWoVgQUSxd3Dc63Bd6ijeUWsLpMPGeZuIt96Qw3QviYumKTClAC/W+xfGxsZDObAOANJbiAH10ahTaItVzYr0IrSqyhzO7spC3fUTPMJMKE0e+2bHf/6zauKeU5ju+NKIkKPKCyCuzL3h+M3y7AwwBENM/Mo0mTmD944=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KsnNLeKq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O9TfwG018038
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 11:32:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Vkdub2D9Ix1D069ciMfnOnAi5gl6FNprDE8EkZawJbc=; b=KsnNLeKqMsS2T7M6
	JOUAt83eNYVCdBQORuxYxBMrmBsGi/hyXdyd9Kr1n4RsMecLu0iq0B/SFjN0eVwK
	KxK/GGgjCfGl4convg1Pz6b2gFTQfS4UgVInOPvJTFFqagB4N45CuoE6Fm7FogtO
	5X9eU3YeI98Pe8xO0OEPizvz++dGhZ+Mrr50079rbsO+CJqPVjFX4eqkQcBX8KlQ
	9gJ1Gmp3WmT8ovM/Od2AFQvG500f3gKKTQ67kt4zXfhp37b2qEL2vOepBMuNjgFW
	/kylU9wvuUcIFTspFzaxpuCTFnFFBn7DLqRoGnhogQnF7B6tvmNLyDEy3mY+ncns
	4IqS8Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481qh6tpdh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 11:32:51 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ab3f1d1571so1198001cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 04:32:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753356771; x=1753961571;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vkdub2D9Ix1D069ciMfnOnAi5gl6FNprDE8EkZawJbc=;
        b=Ubm4OVfLo3VTMuZFyqqW1E+3zsaLF68Gm1Ewr8z8+04Jsfscf2gSheR1JMDs4w8BPZ
         96a4UVf6FaMj9hznqLuL8QW9PoRW5VwstWQ8x9xGnH0HNev0X3RAAAxQDwbWOVPHoh/D
         hLIN6NNfwQpENWOGlbqGfYfQOSoMqW/tdTQaqfKkW2YrYbYsd7icvZlu2bPItJJgTXu2
         f6zLzRbQPupJ5uZRzkWYG6W4BzsN/7OP4pz44Khh7jfunJYFzBEZY7m9YXnWTtKcq6Vq
         6xBwsqsAxHPCQA3FHFEGLrf0KB4dK1+BdY97mexho/Chziy3DW23ifSlLH+IBunDsbj8
         3DTA==
X-Forwarded-Encrypted: i=1; AJvYcCWintV7YaWPsx+DZNTq/HiduPpSRmm9B7IlnviVV0eQrxjXj7DweXJb1RMyFY6UOUTqrBOm3KqPvWWtiYk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4OY8DieDFtquOQx9r0gK3nV53iHHbDsaEj0CzLpaKTwgIilrh
	ag7s1/GizmAx5n8y0hFVXdQZKlg4p8A2ty0/nn0eMBesVmaYm0D3yVqU36kJspdp7haC16UqcSV
	OPg9t0Y4xWufowK6v5e2nsa8buFopc0r3DbnBfOeYIqA8/QIjFUQVnxHQbVNntryaE+Y=
X-Gm-Gg: ASbGncvOMA6YCtTLb9gZyZ/vwVrO+bI/QKoPkrOSmMsbNPqRW1yoInnERl9PQa9yFn6
	O6gD/BMpsHoCY1GcWSN5SvNBYH2cw3xsxnVkLRDLIVLGShhR9auTfYgihnghD6ce2J+NyRqvBws
	TzCs8K+lWPtPrLD+dNCEfMxOiYbJsIDonGWl46hlyz/AZ7erZnvVD+BmZLVsbncipjFLunn1OXN
	0bYeyR6b63eAWrKdm6L/ZrEkN9MAPLYxmIgXjzePYZQD3xD+mHHmtoOi6tVfBjH9emE1mIhq51k
	4FTuJqOIyLHurhINNn04Z8FNp6zMtUAvgtgv9fZM42CCnKobESnRNzKjBK9o+DWVEEwE0mbKKv6
	Uvm5VfZVI2/hEGyEtWw==
X-Received: by 2002:a05:622a:10:b0:4a5:aaeb:dce2 with SMTP id d75a77b69052e-4ae6df468f3mr41507741cf.10.1753356771053;
        Thu, 24 Jul 2025 04:32:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKMYrc1c7gJLpPEnvGZQ+JXFEW97UbToOxYYGdHgUsXZHlT+nAbkoU5dqSLoVTSIkv4LWWHg==
X-Received: by 2002:a05:622a:10:b0:4a5:aaeb:dce2 with SMTP id d75a77b69052e-4ae6df468f3mr41507511cf.10.1753356770583;
        Thu, 24 Jul 2025 04:32:50 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-614cd335fc6sm741550a12.67.2025.07.24.04.32.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 04:32:49 -0700 (PDT)
Message-ID: <4ab97f28-ac2c-44d8-847c-d3a49e4f38a6@oss.qualcomm.com>
Date: Thu, 24 Jul 2025 13:32:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/23] arm64: dts: qcom: x1e80100: move dsp audio nodes to
 dedicated dts
To: srinivas.kandagatla@oss.qualcomm.com, andersson@kernel.org,
        konradybcio@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250723222737.35561-1-srinivas.kandagatla@oss.qualcomm.com>
 <20250723222737.35561-2-srinivas.kandagatla@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250723222737.35561-2-srinivas.kandagatla@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=CZ4I5Krl c=1 sm=1 tr=0 ts=688219e3 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=4r3GGkRPDdsNF_bvXIEA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: EINR8GMRd1TiW97qIbJLFt0OBOI2fM8_
X-Proofpoint-GUID: EINR8GMRd1TiW97qIbJLFt0OBOI2fM8_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA4NyBTYWx0ZWRfX4oqHakQDcJno
 j5qKLM3rRTVfEmJXrrE3dJF1CLxYBM7oDgUGMDPL5OxC0qjNAY/vIND7QSqapHJ2v2kVqPCCDOZ
 cbPrBFntzTfKUTy/52JsOIoggR40aTccKTFBTncApAvUD6t5mSN87pUApghIO6ZZJ7s+rGmv/K5
 A16gysyzLccjUx7QTzeBHtNkEdNgiu1wHmmPFF/GGBRiGGtWQhh4nmiV8Gh36ZlIOUgXhxLpQN5
 apS5jt/lKRNZoZhdewMeoD+ww/I+7mV1W+WlCXlz0EZ3wqEjY9Mmz757IXHvyAE3pmAHI4ER+EK
 gJRr4S46gLOcJrwsx+pDwrAWWKZ21e2Tnxm1WhdwtRmeTh7FbEPRFfaL/ps6MIgmKxLLXwDrD8y
 hFKm3yye/V3/aYAzhl8lZgKLDP8CoWBwljyi6ijLt2QEZ4PodjGygK9Ohl2BdI+XImqAh7SA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_01,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 mlxlogscore=792 impostorscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507240087

On 7/24/25 12:27 AM, srinivas.kandagatla@oss.qualcomm.com wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> 
> All the device tree nodes for audioreach dsp are duplicated across all
> the SoC dtsi files, Move this to a dedicated dtsi file so to remove some
> duplication, make it consistent across all device trees and also make it
> easy for new SoC's to add audio support.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> ---

[...]

> -				gpr {
> -					compatible = "qcom,gpr";
> -					qcom,glink-channels = "adsp_apps";

This seems to never change, maybe we can add some internal bus-like
matching to glink that we could put a cookie in the GPR driver for?

> -					qcom,domain = <GPR_DOMAIN_ID_ADSP>;

Similarly, this never changes (unless call audio would go through
modem and require a similar structure or something, I really don't
know)

> -					qcom,intents = <512 20>;

This is also always the very same

> -					#address-cells = <1>;
> -					#size-cells = <0>;
> -
> -					q6apm: service@1 {
> -						compatible = "qcom,q6apm";
> -						reg = <GPR_APM_MODULE_IID>;
> -						#sound-dai-cells = <0>;
> -						qcom,protection-domain = "avs/audio",
> -									 "msm/adsp/audio_pd";

These never change either

Konrad


Return-Path: <linux-kernel+bounces-833769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B8EBA3026
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 10:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FF781C00219
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 08:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4B629A30D;
	Fri, 26 Sep 2025 08:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KQeg2Vsp"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E1C26FA4E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 08:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758876614; cv=none; b=PJAC50de84jTY+cN9uBo5SHZHU3F6KGMvRdzRle6Z3PTQWZwF8yHfTyx7op7Bs154WAQXAZFDC9+d1CLAALKxj7I9je/u8eeN6A5jUBf4sTTQMzGEbFSTrY6VOXfGrkZmqUemuE1/rh+ZONj9QNUFNNaYskba11MnhAr58nzu9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758876614; c=relaxed/simple;
	bh=DW5PR20rrpRjozhjmQF7SX9wg6GFQc9bhuXeEh/lm7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CopivS6M7n2+idOeVfF4BMAQ2JJjJEELQ/n8Q40/fuDko+ILwaO/NjTLE5SXHm31S6DkAmwIfuq5dVJV0W77Kaz5ru+0zN4ijwBFxv9mdHKrtf+yc86DzyOx2WG7uQ9bksO4GqcmoTFD/obzXTOuZTE7wxFJWJicCg37Hiizdnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KQeg2Vsp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q6q9Vx027585
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 08:50:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hAvJmzrwoSb3evK5QrOHasbm0i6ySDURtAIAeME4WEE=; b=KQeg2Vsp8pY7kAkX
	m6rMUbmJSMEIKwgoIERa7LulLjSLELt8hiu1+IYMv00GPc5ieNf3NAF40MP3wS7w
	dTFRo4CgdmzXsaN/3r68cQKzeMyrViYEqU69TrIrqEfIVUDA2OAk9PvPSV75/YRC
	js4NLs2Wi36DbK7EtFjIBXupnVnxtU8IQYHl38HwRIw7hdltPcaksqAF7ahiRnCi
	EPee4tLw52eu2eNitIONh6+DOvniIs5W/h75KjX5gpG5M48EDuJhD6DgXuOwz9qI
	7emCJKiJNJ7AllZQPh2QgkIEm+OEcpYWj/Mw8OXl9VgTZ2Nf8iDDHcAYpx9M3uXD
	KVLVdg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0q24te-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 08:50:11 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4dd729008d7so186901cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 01:50:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758876606; x=1759481406;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hAvJmzrwoSb3evK5QrOHasbm0i6ySDURtAIAeME4WEE=;
        b=lBzzor+GIlePr5vqqwkuWlsSlFZdBFzvvg9O4KvW4mWqfodVnz0TdovzkDKijmcUjP
         s9eJSeUG8q7t7lKpcvrROOZu6Pz0BNTFc2oFnc37aLjOGt816gOg4h9xIfkMh+uidgUr
         TsJF1Twysc3Q6c/lCjJu0qCwZuYsy8MmN61LsQB/mIyfn55HK+XfDrXVyVTierBSe+ST
         pKlH56Abd+PwLXA4Dohkd9Jpkb7MFeLlRHKK9X0ydHhE2yFPBdZaXCczv0fp2EpjQT5o
         1l1YTbXHpr0vx7tsC7ezn+9goBSM1WPMecLtudZhafvGcyLhv9QjyHeLlSmIhxvVvbh5
         07zg==
X-Forwarded-Encrypted: i=1; AJvYcCWPklEgTsAFUifiEBqrxyJeFOZvyfHo8C7woUYKg0TeEi3d0AKuAb4pHyh/jf/KOKBFOuFzGTDghSTq1jY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU7moWnNi90jcwKWtlo1YLGGbFG3eDg7Iwu05FxpOoqfjAQFuW
	lugHJ1c1dnuxO6vn/UUE8sTUpoMtEKLTqD6zUElOwodu+8CmYskdbySNO2rKC6h4PJbqQPmfQhE
	VVcGTs9h69hkYIlBKfok8JOhAtIAvzOOa4p12vQVDSeituWFWz4Bkkh2nhDn8kbA/f/8=
X-Gm-Gg: ASbGnctgurLkP6NtJ0yZzyDezURk0t9qYD40ML4H+Od+TFTjXarfHa8vsHKoaGjuiel
	/VFHMz4HxaFCYNUajGZgetp3YNeUHEYXoiGSSEiNCoLD0GAMVbwM7Uor+O7gonfimsN9aYfQ6HY
	RWuj0reGTdGTOqS/t/wT/jQePQF53hNEclI7t2Y+hUCxDB+9aAdhImOj+892DfKQoAHbZaXCW+4
	g6i+W+veiX2gmNvKZkuVWMAkeJcAxpTanKSgn012W9C9ozsxzcOkW3zlfYMKbX/BAUA5MPXqQnR
	wRTiw37QRT3rf5QWD2axriRi8DWtWOB2as3533jjeXuYAfvrMQDy3G4/gLQkVYEgdgfTbE7TMrV
	osuvvvzbdet6v73UhEXJ/Mw==
X-Received: by 2002:a05:622a:1101:b0:4dc:fc58:c50c with SMTP id d75a77b69052e-4dcfc58c83bmr20483241cf.5.1758876606296;
        Fri, 26 Sep 2025 01:50:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEiWvsH3XhfOSeK3PolvaeTD1lJD0k/Gm0XDb40I/xEqlYRxnruYGzyeye0H22WTBm31aZrg==
X-Received: by 2002:a05:622a:1101:b0:4dc:fc58:c50c with SMTP id d75a77b69052e-4dcfc58c83bmr20483151cf.5.1758876605736;
        Fri, 26 Sep 2025 01:50:05 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b35446f79besm326034066b.69.2025.09.26.01.50.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 01:50:05 -0700 (PDT)
Message-ID: <e7843f88-71d5-4f7e-9f99-df06630e02fa@oss.qualcomm.com>
Date: Fri, 26 Sep 2025 10:50:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] ASoC: codecs: va-macro: Rework version checking
To: kernel test robot <lkp@intel.com>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rao Mandadapu <quic_srivasam@quicinc.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Prasad Kumpatla <prasad.kumpatla@oss.qualcomm.com>
References: <20250924-knp-audio-v1-1-5afa926b567c@oss.qualcomm.com>
 <202509261315.O9CiiXjb-lkp@intel.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <202509261315.O9CiiXjb-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfXyMYi4PiYUcWy
 cB9SV6t8SrkXBnls4qtVbJF6RlZLemPYn+ZMIJ9HCM9QmycytbaxHf5zZh6WVx6+AgnPtng16FM
 YXGziKRm3EEd3XGnqOHcvirlgy1hxpnP6xFug2DYwCYDy8uozHYM+Dx3ir/3VbFKFOeFQVi8d7n
 r43PZ3Q+WbZzJcX0EuslcCgoc00/jssE/WWdHhLPdl/m+9lP1mC2OQ40qhPg0onV7kIlL29A4Wl
 gajLh5xNEjbIdhZV6Oi/7bZ9dwdxhKaEj0bbDF1/gOsZZibya4muxdctQZjM0ZxQ3h4jQcMh2hV
 JYqp/z4d80+4zIEGX1WDeMJ4fHu8iy/p78a4od8/xDEhWOUhddGzGsuVdg5E6MDfwveMwCs641E
 R6ViGBvlWwEL28yYDRte8Dxh4NO0Dg==
X-Proofpoint-GUID: 1dXz9DDt3RD-ZKRzn6pbES4DEsSZvFqX
X-Proofpoint-ORIG-GUID: 1dXz9DDt3RD-ZKRzn6pbES4DEsSZvFqX
X-Authority-Analysis: v=2.4 cv=JsX8bc4C c=1 sm=1 tr=0 ts=68d653c3 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=i3X5FwGiAAAA:8 a=QyXUC8HyAAAA:8 a=zXO_E9iLSFoZqPovHQIA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=mmqRlSCDY2ywfjPLJ4af:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_02,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

On 9/26/25 7:36 AM, kernel test robot wrote:
> Hi Jingyi,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on ae2d20002576d2893ecaff25db3d7ef9190ac0b6]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Jingyi-Wang/ASoC-codecs-va-macro-Rework-version-checking/20250925-080338
> base:   ae2d20002576d2893ecaff25db3d7ef9190ac0b6
> patch link:    https://lore.kernel.org/r/20250924-knp-audio-v1-1-5afa926b567c%40oss.qualcomm.com
> patch subject: [PATCH 1/5] ASoC: codecs: va-macro: Rework version checking
> config: i386-buildonly-randconfig-001-20250926 (https://download.01.org/0day-ci/archive/20250926/202509261315.O9CiiXjb-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250926/202509261315.O9CiiXjb-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202509261315.O9CiiXjb-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>>> sound/soc/codecs/lpass-va-macro.c:1479:8: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>     1479 |         maj = FIELD_GET(CORE_ID_0_REV_MAJ, val);

Jingyi, could you please add:

#include <linux/bitfield.h>

when resending?

Konrad


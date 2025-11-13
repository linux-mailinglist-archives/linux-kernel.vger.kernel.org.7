Return-Path: <linux-kernel+bounces-899528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F583C5815F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2230E3ADF38
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997A02D47F1;
	Thu, 13 Nov 2025 14:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b/JRKlQa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qu/fMztw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950562D4B57
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 14:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763045242; cv=none; b=pnvWPiK5hCKu5qJ/tUsQK+tqS9rYRgHzp7N553o5E9jtB3WoEHep93D0qadh2pMuqk7VsSJQvQipEjv2TvOzInwjBGUq/IUE2lqG95HLB9TraA40+IDzfawK/y1xnxVoSAdsXGw9GFyZ0LGxuM8eNNZqcVqcEjcFU6pR3ydbeVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763045242; c=relaxed/simple;
	bh=F2kBxpSXrkU6fwfKy+g1N0BGk9Qwugl4Eo5aCFQcm9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HZ2v/O7gUlamZqxv4HhWSYJviiCKvTcD0MMfJDNPNME6hqLW0t0wjebIT6885jXcLuYkcqCjEHvELkXcEcSA5fpF47f453BkUE+TBuJNH+NXmUXzqIUVT2PGSUJuAEVsvKl/zOlKP3JFlpTqHGkzymrgwtYYyCeZAAdYA1c3dy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b/JRKlQa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Qu/fMztw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AD9GFrQ2962626
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 14:47:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c/j8O4OMZ/iO6ANHgdWOttUeORFw+6paoVM6GB+aNhc=; b=b/JRKlQaoXhQbjBg
	7mm9S/5h3Fp/qe27uSlmDQXdKJyVelTPms9TAYlDvBXVpwrx7Y/JPF42qOoJETR1
	cZsoxMoudkiU5Xx0VLidAV4Vf4PHDod433Ykxn74s+LsoMkTrwjARIl3IDm/A+Rr
	grUZjvJu70AF5w6jwH7l4Aq5Be8BuM4nP6pt3KJhqDbJ+xtwdCLznzo3aNk/9SZu
	F6Qj+Ub89gKav1oigAckmv9WKdjgeoUN7Q2qgBe471l3GyeBKiIxCveVSXs/+XGB
	RXI/WhEDsA6qtDMbbTNJWwMSedDbYI2Id5NJthr9QY3IvsFmN+3HmL11WKKwX00L
	cTlHdQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acwbpuxm1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 14:47:19 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-882416e9d9fso2267776d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 06:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763045238; x=1763650038; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c/j8O4OMZ/iO6ANHgdWOttUeORFw+6paoVM6GB+aNhc=;
        b=Qu/fMztwal7IQvrRc8wirJ5mDqqB2Sf5JTrriadms8HMFC5f76zkDWpHitRaLboFfx
         NJl8XcqZAyymHWl3PmV8D9BlTD2jebPa8c/gz1kNTa+yKZw+WYvPecwSsRkfDbkBGUWD
         VdZ3SE8gfCZDVirKgCawIYIe0YVKXOk/bwVSYoKafll1taAYnbzbnlsg58wDY9VCyFsJ
         0FVxD7u9jPK45x153uTUzjKsHP8g9Q11C30iVLXM0xp0Suur9/q6IhEjUYRb1qw2N6QG
         XcNo6dye3nCze0ai1e3vzc5IwuDxWWFwgPU6ldP3IXAb+dAvSv8cu7cGVQ8e2N/UAvSE
         P0kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763045238; x=1763650038;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c/j8O4OMZ/iO6ANHgdWOttUeORFw+6paoVM6GB+aNhc=;
        b=wd5o7cHm0TCMXCRItsMaOJe9lEjBZa9qi2+E82nsKhiYeTRNUnIajAxKzTrBKI0EHU
         V1T47XWXWNUsfk67qyC8Eb5ZIXi588Ko8EEyc21Z7epvzj0zIp3RQQSXbcUCetXufcmk
         hSVJIYu0o7Ia+L3K3TojFMtVGoLz7XXfoUzghDWnKAbIOVH/eU/KceDTrilgzooccPgw
         PXsDMuAvmh6Bz0f/JwM0UDHh+DSJQtNxUQIQ3DTHwKREYL/y4eiAlUCGCPCjfRwwbe3Q
         qvtzueKKYIVHCnXFjGNJVmJl1QA+ENYjvBEAXrLYDbIPZCGJAYDozXpzJ9SKk+vLpZnS
         MApg==
X-Forwarded-Encrypted: i=1; AJvYcCVPcZaJ3pIgK2ObKg1ip7D8RVJRI5wUNq96uxpacsQl+2CoYwC8nGp2VEMgRcNykm4wJThV5uYo7nMHQiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqSSjVYBt1G7ONKsNJESNMkchCzUNE5A3GOs6oM/ifk/UEy+2a
	Dquhl9/8tKNnPbvipcf423rJPJpmfe5vRVeW+RotWmdwjguPIvmvARdBraSGxrfFciL1LtUMA7b
	1t5XmhVP3Vkmk25mY2Ti7VxrUkSoOhCn6C2iCljjHoY46SoUylsJo6SP0dZ4d/ON2ZPY=
X-Gm-Gg: ASbGncuM0GozHEUCS99vs7f3pfOBEecV0E75wbwRFnRrwTZgEbiuDGVvvirM2VDh3cT
	X0ZLWGFTTIRGAhx/zK6an4cvapfIuV0GYNmSJHaNLCJeQnt8qwJmmWXseQQJBCJLFl/PLMlN1W8
	aEF4X5L8i+yeHRo4mD+1rQKXrFippV6yizZGVL4xhZCaxNMmmCpVvpE5LnW3gzVHi6LeRtH4q9L
	9W/3Z1hUw8L836z0SuGvlyhA39A1SQ/5XHaWWV62OzI6EV3eHYpn2MG+5Ra/tQ8vjZyiPMlo3VO
	yfHWd0RJNkZS2HqugmdkAHF2LNr9rJFiYnuYMNELh7s/y602ChW5qxDFy58xIXb2oe8cGQE5ea2
	W9J14rtP+pPsPKSHOmZuR4Yiowsa27de9sQPc9TcozIGJv/NHCVg6jrMh
X-Received: by 2002:ac8:5f10:0:b0:4ed:7ca:5f33 with SMTP id d75a77b69052e-4eddbc9256dmr60354611cf.5.1763045238265;
        Thu, 13 Nov 2025 06:47:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFM7YamsAo7x44iby6/PzuNKLIab4wveVf6S4JQ4cd4mg9yAzxbvu88BKH+RnT7m5FWyF+0JA==
X-Received: by 2002:ac8:5f10:0:b0:4ed:7ca:5f33 with SMTP id d75a77b69052e-4eddbc9256dmr60354251cf.5.1763045237576;
        Thu, 13 Nov 2025 06:47:17 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fdaf6dasm176196266b.63.2025.11.13.06.47.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 06:47:17 -0800 (PST)
Message-ID: <45915f40-caa1-417b-95bb-deb7363a2ffc@oss.qualcomm.com>
Date: Thu, 13 Nov 2025 15:47:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/8] net: stmmac: qcom-ethqos: use generic device
 properties
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Vinod Koul <vkoul@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Jose Abreu <joabreu@synopsys.com>, Chen-Yu Tsai <wens@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Matthew Gerlach <matthew.gerlach@altera.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Jan Petrous <jan.petrous@oss.nxp.com>, s32@nxp.com,
        Romain Gantois <romain.gantois@bootlin.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Heiko Stuebner <heiko@sntech.de>, Chen Wang <unicorn_wang@outlook.com>,
        Inochi Amaoto <inochiama@gmail.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Minda Chen <minda.chen@starfivetech.com>,
        Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shuang Liang <liangshuang@eswincomputing.com>,
        Zhi Li <lizhi2@eswincomputing.com>,
        Shangjuan Wei <weishangjuan@eswincomputing.com>,
        "G. Jaya Kumaran" <vineetha.g.jaya.kumaran@intel.com>,
        Clark Wang <xiaoning.wang@nxp.com>, Linux Team <linux-imx@nxp.com>,
        Frank Li <Frank.Li@nxp.com>, David Wu <david.wu@rock-chips.com>,
        Samin Guo <samin.guo@starfivetech.com>,
        Christophe Roullier <christophe.roullier@foss.st.com>,
        Swathi K S <swathi.ks@samsung.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Drew Fustini
 <dfustini@tenstorrent.com>, linux-sunxi@lists.linux.dev,
        linux-amlogic@lists.infradead.org, linux-mips@vger.kernel.org,
        imx@lists.linux.dev, linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org, sophgo@lists.linux.dev,
        linux-riscv@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20251107-qcom-sa8255p-emac-v5-0-01d3e3aaf388@linaro.org>
 <20251107-qcom-sa8255p-emac-v5-2-01d3e3aaf388@linaro.org>
 <21a3d269-76e6-4da9-aa25-bfd1fb6dfb07@oss.qualcomm.com>
 <CAMRc=MexMn_GSC2EtMek5hDRLjGYA5HKM8ge9vrxw1pYDqPJgw@mail.gmail.com>
 <cd7c0490-a2d6-4885-aa36-ee1492f107b8@oss.qualcomm.com>
 <CAMRc=MeuByh=N_-F2+zPiqnh+Qp9u97kiMheLJ-xxcSZSy+_tw@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAMRc=MeuByh=N_-F2+zPiqnh+Qp9u97kiMheLJ-xxcSZSy+_tw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=NvjcssdJ c=1 sm=1 tr=0 ts=6915ef77 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=IegXRtMujPCPvfbY5ZIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: FRwaH6437hET03LZIniM1YfW5sJ3nFKX
X-Proofpoint-ORIG-GUID: FRwaH6437hET03LZIniM1YfW5sJ3nFKX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDExNCBTYWx0ZWRfXzqplsuwg8mTV
 7Raio3Lthq93Nw5hBXVkMqeXigot0Alq2BY9jwEWVb4cK4C9VnKV6OirxpAldBAgAu18LSv2KPU
 p5iTYTyx3+SE3DEex0/ySt31QyeCrUNVrS7Tyem3ggOR2rETrs54q3zJqYAwKLkXRjVk2x+zubH
 NTWT764tatpEqbJ/hhyy/xQWfY+Ptwf/snCwE02jPQnMrAKvLblFnYhO/ECd3SV8gCLv/7+dGg6
 yZNs2dEOsxqb+aK5CAgc/O0iKXoEx878gkbjG64X6WM3kT1xM4rGJyY9pzk924gHeWlKEEKTUJu
 ZVzzFa3VCIFfQXKiVQXqMRcvHa7684mI+/d2yJAAMOSkDiDuoF3sLeb/r3+D1pNOxVzTbGT4CAJ
 oDliGLO3KWqy/MR+ND8HEcl6IoUOsA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511130114

On 11/13/25 2:41 PM, Bartosz Golaszewski wrote:
> On Thu, Nov 13, 2025 at 2:33 PM Konrad Dybcio
> <konrad.dybcio@oss.qualcomm.com> wrote:
>>
>> On 11/13/25 2:18 PM, Bartosz Golaszewski wrote:
>>> On Fri, Nov 7, 2025 at 11:49 AM Konrad Dybcio
>>> <konrad.dybcio@oss.qualcomm.com> wrote:
>>>>
>>>> On 11/7/25 11:29 AM, Bartosz Golaszewski wrote:
>>>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>>
>>>>> In order to drop the dependency on CONFIG_OF, convert all device property
>>>>> getters from OF-specific to generic device properties and stop pulling
>>>>> in any linux/of.h symbols.
>>>>>
>>>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>> ---
>>>>
>>>> [...]
>>>>
>>>>> -     if (of_property_read_bool(np, "snps,tso"))
>>>>> +     if (device_property_present(dev, "snps,tso"))
>>>>
>>>> This is a change in behavior - "snps,tso = <0>" would have previously
>>>> returned false, it now returns true
>>>>
>>>
>>> This property is a boolean flag, it cannot have a value.
>>
>> Every DT property may have a value, so this is not as obvious as we'd
>> like it to be (IIUC - unless that changed recently)
>>
> 
> That's new to me. I thought that if a property is a
> /schemas/types.yaml#/definitions/flag then only its boolean form is
> allowed. The fact that the dtc can compile it with a value doesn't
> matter as the bindings are the higher authority for DT sources?

You're right, I misrepresented the issue. read_bool() was historically
used for making sure a property is present and this was a problem
when the type was != flag.

Please discard my comment

Konrad


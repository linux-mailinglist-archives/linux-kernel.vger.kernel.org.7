Return-Path: <linux-kernel+bounces-727363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE909B018E6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 11:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D19F51CA77E8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C16727E7E1;
	Fri, 11 Jul 2025 09:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z/9TXDuB"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962B727E7D8
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 09:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752227831; cv=none; b=NJwJzj2kVfMzC0Lzqtdh1tuf6ba+9V8OQBltkvK7A12e3zkQgBFgXVlGclDl6chY/CMAfvi4vQijh0DtK/eOSHKxdgntWsD7Fw/i80SWxNUVW1qlPH2+g+TLenoTn9dfp9YaAMFz3MFg6dsPydkzSdZp5v4GtnFSUh4gcjLjPis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752227831; c=relaxed/simple;
	bh=enbfKkLsSZBEWGR0TQ1aBR/Caf7pFGAF+OXo++3GrIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lz6h9OkcZChys54dpDdLSLkDHOppEpaCRdwpZ1Mel1JUuay09TcPo0+n/IGX+zybsQGbSE6PKQbOT2Q0EftiWEX/98rFRe0LHZ/C3YiIWAzdx4JJ+eZXDsszkUgc3cTd4eB/vDAzRG/+xt6eiFCQRX2tyFHecpbeub/0KBROGx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z/9TXDuB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B1XBEu016817
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 09:57:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V4oAm1F+mw0qWWBJIzHoogPbCCFnCCeogdv2Fm/i06c=; b=Z/9TXDuBX6DLWExy
	amIfnDq2nwAGxAmsKPGGMdV1zGp7rbIEd36Bcke7MdK/kpAls3A8j9AK+sroPED4
	w4Iy1/Pw2QG213/xbqAiXRDZ9WLaukhJc4mOGYo4DILOLcYOgBh0ktLoU61Pm4vr
	cDcI8ngeNVKeOqESAJ8aEWAOjCWNdyzzBpeaWTCsAb9HofRYBDYBjkDxBov5otr9
	boPqlh2/MuAeirb9RSiw2dqsNhc8OM7T7lO3jZPTGrNHHFl8YB0EuD8KLKLjWc7e
	waCZn6tFiQKk93dNh99sR0ScI93DWdOgFI+WEpHFfdPgQig7diPREBRYq+gNU7Rn
	D0tVxQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smap84kf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 09:57:08 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7d3eeb07a05so29811485a.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 02:57:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752227827; x=1752832627;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V4oAm1F+mw0qWWBJIzHoogPbCCFnCCeogdv2Fm/i06c=;
        b=lzxxyfnXTyIC3oQ2ekdJazRofeYddyjeZ9gZg//2pOVHi0z8HrK4uM+Am9p8iW2rjK
         4ffVgm9FDoHz1mJwjWmZCRJJq+Xd7d6rClDeBsdmv7gV25Q4Y2Bj5nN9ddTqj30tlpJ1
         lHQHaVz3S5SH4zSE/wgkdLRfqap8tRIof40+UpHoxHgY9VPzkP9xO8+67nBk2QAzvv95
         N6nbx0A7nGwx+ID5OFiP47Zyez3KMx9Us5lSMny5Q+b0O4koqQ4jTDDP3SfUVcm8jKod
         ihxcEgxcw+a1IRPyJsqHiPFxOJymzEcccKRoTylrIf2N9t9JJyM8dCIymWnjLKOhtk4m
         BwIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHgZ2rd3UVZnPYvLE2nZbHPQS0fN2I33v/yF8w94Wa8RBpR/lnZyQG2JLrjHtMwdGakGafWJ5L/jbPWKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiJkV21b8xf1l6/MMCLlFjvo6PMODNNqT8USluZFNY6gHA6uxW
	ZJObhwr89naYcANdWp4Qxhg5aP6fEKmUgfUM3TPDMuO3FSoGd+zITSHvlLipp4R+2tGw1+yN8Df
	6TAduvW9aY8w70jt6b1Y9zbIBuGzO82ohutSBShLfWMorMbRSp6HNsz0CET8aY0QxYC4=
X-Gm-Gg: ASbGncu90gN2Ig8ptn9TtTmzGSZXe+a6xZfpC0Oux/lxwxJoWei/NXmoCwgcu30BXts
	aVXxPA4ui/Rid1KIEISBEcLHAMshWnkrND+YG1D4euK8Ob9tEFXZuhhk5SP56k7ZX3YHvXfXYyF
	cQzzB96E5zvTmv/8P8iF6ETfIhAavAgGSlO2VYLblBtCo5EcqEfyNLmhXaLWH07PrAWOoURRmjG
	0KkLejERXyB4/Mczf681jXMs2ZhW/M94Hz+/OdA1OtgMxBh0yzA1D+uN0uDd+3Uyyy32nI4wZov
	NS9Cp27ClLfZ98IRQT/iTcwtks9EE6iATKcZY+L2T0GX7u1/07ocxfV8+UwBDCrz4SBWN1QSOx/
	MN1qkt8N6Fkswom4+kq/W
X-Received: by 2002:ac8:58d4:0:b0:4a7:4eed:2582 with SMTP id d75a77b69052e-4aa35db7dcamr13443501cf.4.1752227827438;
        Fri, 11 Jul 2025 02:57:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYKec4bEyWI8YGiR6x1O+xUwfyU3XWv0u55EjX9PHiUbFeje3VltrjTPWAUpQi1AAK/4AayA==
X-Received: by 2002:ac8:58d4:0:b0:4a7:4eed:2582 with SMTP id d75a77b69052e-4aa35db7dcamr13443241cf.4.1752227826920;
        Fri, 11 Jul 2025 02:57:06 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e910f3sm273314866b.31.2025.07.11.02.57.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 02:57:05 -0700 (PDT)
Message-ID: <465f4136-418e-48b8-93f4-e384244cb913@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 11:57:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] dt-bindings: PCI: qcom,pcie-sa8775p: document
 link_down reset
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com,
        mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
        bhelgaas@google.com, johan+linaro@kernel.org, vkoul@kernel.org,
        kishon@kernel.org, neil.armstrong@linaro.org, abel.vesa@linaro.org,
        kw@linux.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
        qiang.yu@oss.qualcomm.com, quic_krichai@quicinc.com,
        quic_vbadigan@quicinc.com
References: <20250625090048.624399-1-quic_ziyuzhan@quicinc.com>
 <20250625090048.624399-3-quic_ziyuzhan@quicinc.com>
 <20250627-flashy-flounder-of-hurricane-d4c8d8@krzk-bin>
 <ff2fb737-a833-474d-b402-120d4ed68d39@quicinc.com>
 <1606591b-5707-48bf-8f60-44063ecf8f1a@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <1606591b-5707-48bf-8f60-44063ecf8f1a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ar7u3P9P c=1 sm=1 tr=0 ts=6870dff4 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=00NdyYYEmPKBbhCvcP8A:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: CieoAbPsR5-Djq_-nv6xYSvHHOeoyyyh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA3MCBTYWx0ZWRfXxmApSB6y4uyY
 30MvXnNCJFP2cWbWS0/6r7aJnca4ii+psaD4jnCfSVi7vyrnF0/scLqsqz/3PjpgDtadyThK3QB
 cDfe8t8roIAXKYAui8C3+hVxrliCpMZ9iS3umzP8A8yZL0ocOH0FCXPGr/xwpjbxy5aG2aGqFsl
 UnJ9hrnQzOmE8LAfY2Mzdbvgzbg3EKCjWD4nRbyIiErB2jfieCOpp215c3IMei+Rz1OtRiXCjT4
 TNjDwxDxq7XTpNbPYrpyHgyj5YtghcmODD141G8mEZmd9y9iBGdHe/1PgG88MikRYqqzYvH1ABb
 Cgr3qijdm6m+UxZquXxzp7QJDcVqmljny4P06qdi32kHEb7rtUTUTJXMYcJPD7051TEsyqr3Vap
 XheACKz3suFFd6R2OrsnDc6Uf58J8I4IWwebTvphkZkUzwcbT2pIBAVWI31JzvrDvSoJJ03N
X-Proofpoint-GUID: CieoAbPsR5-Djq_-nv6xYSvHHOeoyyyh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=514 clxscore=1015 adultscore=0
 phishscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507110070

On 7/11/25 10:44 AM, Krzysztof Kozlowski wrote:
> On 11/07/2025 10:26, Ziyue Zhang wrote:
>>
>> On 6/27/2025 3:08 PM, Krzysztof Kozlowski wrote:
>>> On Wed, Jun 25, 2025 at 05:00:46PM +0800, Ziyue Zhang wrote:
>>>> Each PCIe controller on sa8775p includes 'link_down'reset on hardware,
>>>> document it.
>>> This is an ABI break, so you need to clearly express it and explain the
>>> impact. Following previous Qualcomm feedback we cannot give review to
>>> imperfect commits, because this would be precedent to accept such
>>> imperfectness in the future.
>>>
>>> Therefore follow all standard rules about ABI.
>>>
>>> Best regards,
>>> Krzysztof
>>
>> Hi Krzysztof
>>
>>
>> This does not break the ABI. In the Qualcomm PCIe driver, we use the APIs
>> devm_reset_control_array_get_exclusive, reset_control_assert, and
> 
> I see in the binding requirement of 1 reset before and after your patch:
> requirement of two reset lines.
> 
> This is an ABI change. My entire comment stays valid, so don't just
> deflect it but resolve it.

Ziyue, the change is good, but it needs a better explanation.

Try something like:

SA8775P PCIe RCs include two reset lines: a core one ("pci") used
to reset most of the block, and a "link_down" one, used to ABCDXYZ.

As the latter was omitted with the initial submisison, describe it.
Because ABCDXYZ is not required for most of the block's functionality,
devicetrees lacking it will not see much of a difference - it is
however required to ensure maximum robustness when shutting down the
core.

----

Note that there are physically more reset lines going to/near the RC,
but many of them are either inaccessible to the OS, or very much
should never ever be. This is the case with most hw blocks, so don't
be surprised if you see a list with more than these two. I believe
"pci" and "link_down" are the only ones intended for OS consumption.

You can see some of that bleeding out to Linux on e.g. some IPQ
platforms that don't have a separate MCU (some flavor of RPM) that
would do the bus management.

Konrad


Return-Path: <linux-kernel+bounces-764682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48319B225F1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEB7C3A646F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EBD2EA48A;
	Tue, 12 Aug 2025 11:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g/0OW9j8"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0CF2EA17E
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 11:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754998491; cv=none; b=VF9LmKiGPhTbCMBJklexpIpY8fCjT5mKA+DOLh5TqNOys/+yGtvnnlE8ZeTW5OinI4iwzLDJgVJJ7MV+Hxba/gqu6x6CdzBoXDMl348A/tBlN8iIUqLMyJDB+u0Pj2/OdVg+FfkZrPi8jrxDWHpQebJXUpev/mGTcN913nWzkaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754998491; c=relaxed/simple;
	bh=l6AqCHJZBSuWqDTHRUXKjCevAPLUlPN/JFFEsQsXJQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DwTaZa4Etv5hD1wPPWGJecK8G1sHFjIUXGl79lq3RTjPE4k5iSvcMFemYFdJKDOYWmWwbbkp05OXEzVc++IPi9rX3ROFwPz0NV4iSh513iXG8xEC5MAUhWSNbiCpGSSITQNNWyhOjns/4iR7UWLxokiV/1XMQ/TEKAXNbAhW4c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g/0OW9j8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CAwCkf005179
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 11:34:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z7EwvYjw7Dpgat/rbwEy3MVniY54/bim139PINd6hgo=; b=g/0OW9j8WJ5IumSw
	7QkgsIlkhtHhcPfhmUEOXMrL4kWrwMkjX0nd/FK0HrklOEmqbQJOdjkBncl6YEff
	I2GSZw4nxlCNC7iBtng2mG6iHFhvfTYaScWbU36zyC37L8GB2iXGPz197/YQSoDh
	ABWsHkWpJ4F1kF3DEkz23p/piV9T+4b29XzeSWbxO3VPfJQjZP1Ru8mYVivDspys
	q9tlW1cQJyMzd/T0CJsnsJF4Jv87CDQrmLdM8hFM2E4pHdtde0CsWvEvV5SNNSBt
	vzlGwjzdB25H8Ous0+KsQqMWa1zfQZkqIWv0IMEr+WxhLG469C9aZzkzSfpqdPQ9
	CliSow==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dygmfwq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 11:34:48 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-7092a001573so18449376d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 04:34:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754998487; x=1755603287;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z7EwvYjw7Dpgat/rbwEy3MVniY54/bim139PINd6hgo=;
        b=fwy/gFdoTyVghNNNHlyTPatPKndJZTAZmJYFadTLEhIujRIqVo3st7EHuse5JS8tOu
         JwEiE/7KstGqY0BI+0IWuOFmtFwld1c+nBxsv2VGL2JR6RE4hMRAxjnrm+yhUTQgcJFW
         a1C62TtvvSpjt7VvR8+xiMUa6wrkE306DOOCCvvp2gYjsi3N+8ZUKtVwY8INN9nlC5MH
         bWZH9ze2vVluY0EQOjUM+QYUdq89rl7CYWjGHtLFc4Bw/G7RHgf8tRKH6WD7xm+57/s2
         oIVGTPXu5pn/Tx+cGEvC9XVkM07EwQmosNY92/6eKWYkhsqVln+HLu7lF3gc58inOLd3
         wCgg==
X-Forwarded-Encrypted: i=1; AJvYcCU89j8ThitgjXzcilDoeWHR89ySxQ+3sLat0ioc4OMLtOgNVymzCp+MHMmbwi4oFfh4wuU1udlucpS48WU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxagbEydl5dLkmiicJ21WvQ5qN7RAy8TpPB9heDNU4qN7lXqzg/
	vyxhcA8yI8eAhusE1/ngYhu9h2DIAW+Q6o3L+m3aFE314AJATnKwby5CP3YzxruIh/oOXDdyOFC
	EdklvehYar+1siJfbhW7lm+5eZTtBF92wDnFj6RjWI8frGpxtSmSGPBHVLZe/yP11BiI=
X-Gm-Gg: ASbGncv79Fs3+W96/i08SOmGflj+hyszXS4/gqtayFhl+tSflP2MtNT8/tgdBrTTOj5
	TJGWXAEPfWuCv0bhH1AOvzQ/QXnFu8oE0L5p8aW4nvkQZBjhPuxRkdmBWUnb4VUz7WZl6RDvFDl
	9nWTr91pM/d13XgfFuTYO8GGEck237L43/QoSr/xu0I1O9vRJqEDZBFFpI3s1Zb+/al1JTlypgP
	Oc/OeVwM8jdXx0dZaH7H8efsGfUjjzx3KxJHwYA9z1e0O/vIyMbswD3HsVRfxUwCsjULu+BGqB2
	FivF+eYGkALQzMapL24TC3+ccX4lsin0FaUBLPZ0iZKPZU00zqGZk1N0MtANhoitAxC8LX8jsM3
	CtTleoTCD4LjsmCAE5A==
X-Received: by 2002:a05:6214:20c3:b0:707:78ee:a179 with SMTP id 6a1803df08f44-709e269c1afmr4198866d6.7.1754998487465;
        Tue, 12 Aug 2025 04:34:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzDvAWuO2IQGQEI/z13SjmiVl51pWaN2v/9l3OeXHvu274wGmTIjjFgvx0MxKANWmQJcS/Zw==
X-Received: by 2002:a05:6214:20c3:b0:707:78ee:a179 with SMTP id 6a1803df08f44-709e269c1afmr4198696d6.7.1754998487036;
        Tue, 12 Aug 2025 04:34:47 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8ffa3adsm19991188a12.50.2025.08.12.04.34.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 04:34:46 -0700 (PDT)
Message-ID: <8d5eb27e-e299-4fd9-a591-2d90f4693838@oss.qualcomm.com>
Date: Tue, 12 Aug 2025 13:34:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Describe the first PCIe
 controller and PHY
To: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250811-sc7280-pcie0-v1-1-6093e5b208f9@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250811-sc7280-pcie0-v1-1-6093e5b208f9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzNSBTYWx0ZWRfXwyeeK+5+U9G5
 /YMlN2WG6iDZ4qfaEwL5Cs0W4C1htPqYKfX3iOZO9xxrPOJNWwUewGd5GZwNZgKkB+6aZHwGX6r
 Ybx9jtNsjxrU4Knljv6P/pqlDm5/KlHb8kp8sAvOUUkd9L++DUW7Y94S7zuUOgOB0z3qdFA8h7Z
 sAi2gMoSKs6cEU/pe6Oo+LMkJIjGMe6MR4z2vGw5hZbKy91JPBrqH9kmxV+AtG1yuuLhpbqPb/7
 hu2D1z11KH/dm/LqvB3P1Mt1laB43WdRZRvPC2o3VBRimP82xsf0oLZ1sTNgTotmYEw8s2/7PZb
 paQwyXsha1z0uSDlK7xP9lQHhiIaOxaeTvvzLMs0m3f7fv8DDBPBv/Gaj38/yUDmxNiz4zd5pNS
 ljF2F5TX
X-Authority-Analysis: v=2.4 cv=FvMF/3rq c=1 sm=1 tr=0 ts=689b26d8 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KrzbkVIKgyrcCw90480A:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: BXSEfnYtDZ5daE4ZHoWC-Jiing7DyEju
X-Proofpoint-ORIG-GUID: BXSEfnYtDZ5daE4ZHoWC-Jiing7DyEju
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_06,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090035

On 8/12/25 5:16 AM, Bjorn Andersson wrote:
> Only one PCIe controller has been described so far, but the SC7280 has
> two controllers/phys. Describe the second one as well.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> ---

[...]

> +		pcie0_phy: phy@1c06000 {
> +			compatible = "qcom,sm8250-qmp-gen3x1-pcie-phy";

:(

BTW I noticed that Krishna also tackled the same issue just yesterday
on the internal mailing list.. would you prefer him to take it, or do
you want me to review this patch instead?

Konrad


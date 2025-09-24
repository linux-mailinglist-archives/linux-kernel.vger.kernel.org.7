Return-Path: <linux-kernel+bounces-831068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5CFB9B718
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 20:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01AE23A6179
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 18:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D6531B123;
	Wed, 24 Sep 2025 18:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DMHUu3Ff"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7EC31B105
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 18:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737596; cv=none; b=rcgf4Pbcl9Du2M3q4rRUnEtC7VoN3FMNFWdpOTwRkHtgybRP2ccpYZH0+wcHNEXgA2vzMWyGrYDVLwl3BDgRxltveYlqYRzcQwrUQljt4V9KJ5QdI2uCosS5ejhN0DttfO92Ljn8NPOWSCr8TnIjp9LpwjKvYYiQqmkzhk8RXmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737596; c=relaxed/simple;
	bh=M7ZCsviA12Kq2BLXiMjEzbUy+IfNX0SZv2oZDsAaha0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gZbOzzDbQzb9qznfEd04LIQxhsrWIdiIrV3E2tTYGIL64elcoiUiFFt+WKNKywwQcKboXnzzweflScCJLtlR4sXT9EsFzl9/HVcNxDYdwGcWcpflTWl+Ck/vXRe4hp7zZhe5C4ir+KsjlVNkbPbdI/4gyyRkTDdfz7IIWneVCS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DMHUu3Ff; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OD8w7R002776
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 18:13:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+d/bjG4IKs4GaMkXZIdc3sQ21R7u8h5UijejmydnXp8=; b=DMHUu3FfvOsgGLEk
	uYyB9Q3MR/mNQPMthq90t+mnpZ/tu/itlCpgBR7Cw4sfC7GvrjxwkWWIuXh8WPtC
	ltlWfa33T59Vsx0CourqHd2umhbhyrTOntbFbFqxWPr0Sky6lxpepIn0vhmzkUyj
	8Ef/GBjH0l6PiWxF+zrV8eGN4iNI9bywXiYmr7FycjpqksxTO+8wEBOUE+qhlhae
	hkgKKVYHEzZRGkfUskBzWXKqxoNr3s3NoVHJXbKcAP3R1YYXK3LlIXl7YCDLSRVE
	x/H2lGPcexpV0oz/T6GRgcvzZ09U6R/NdgJOsEKVdjg/Zh9twmfLWNGuKM9QYn6w
	m2c1NA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bajeywyx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 18:13:14 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4d457c316f6so158511cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 11:13:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758737593; x=1759342393;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+d/bjG4IKs4GaMkXZIdc3sQ21R7u8h5UijejmydnXp8=;
        b=aXbctmuNOUmbhr1Kg/06bZaKFy505i3XSZEebKhIpA0WxXxLkqNF97Kr7FgOdnwWXO
         1j2jgAJQyL5AutMoURb+E0nOcst4q/w1gTGIunnByNCy72fJHv51Kntqmv2kqKwq4sQZ
         DacILl/0DyL1pKD09SeOFgDtx1X8/1/V1CI3ViyvDFkgsFC4vRu75dFJ7CV25W1aI5Yw
         0m46JOBllROGVqvRs9NbWPL+VwpfyVocHHCErubZc8YAZkfORjMpqVfegJe4igVYFnKS
         yNs+E2SGLYdMdrK/hVGNM/USu2/ckYa7QbcyJfuQqXChSkimYWow7WtLOEL+Yt8WK/WQ
         bK+w==
X-Forwarded-Encrypted: i=1; AJvYcCUonWMOKxfir+nX/IxUapQvCnn450GNQRyGD3PEN0PpbSZS8KrGlZX4m2cituPMMK2cG3LEvUrBhhi9Zak=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEc9YTEQAy1YDcgOz/+sGLeHp4RmQKPUF5fCb3P6WpOe9QgWvw
	MgsAUkyeNQ/MhfoPR0vfASU/Sxai55HG1IBGGNNvrfx9kUEuIbF+CRDjLH0wIAEQJZvj4ZFTth2
	uLFh3qKHtVM3muUzF1dzXc5X+3TwHvu0dHYATGG9dBlRQDM9rJIYCJgytOq+VXnhoc3Q=
X-Gm-Gg: ASbGncvRtJBHkRzwVstpDs8lT5ing6Y1qTx10z7nUnfMcDqmC0M4+IjMfnBvHDOKO9C
	yg3SEvQ9NQyH1n6LFve9Gbhe87pOX+1TgXjlYMhEHneUcq2+Si16rZ8mZhVz0L6/dDS6xGMwGpK
	s2j2imeE4CR8i7A9gpBs5imFXO34tGNmAGbetSlXtX7jzlOu/KQEF4dfjawgEK/wdNSGdkcpWLs
	slP8b9co5xcRkHZJWztPzKyA1s2Ho+kyLgl7GaMyHVwv2uuqbUR76wng2s6DgouTo4o9vRmekzx
	JwgOueACw3/RipJCKYIgCNwCVqIifvzIxIBXohp3PJmJzXqq1YGdUw1d8/3NcyVRVUcLVulQkQT
	vR4hwIHtxWmiObH5BAmwwFA==
X-Received: by 2002:ac8:5a16:0:b0:4d7:6c8a:4792 with SMTP id d75a77b69052e-4da41e11477mr7368431cf.0.1758737593168;
        Wed, 24 Sep 2025 11:13:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUrYdsVWHPkjY92Tsx8psvdidntggOzOo1g1ABjKRkZScDXnajq+uUIinLMN1uXr7EvDbwDw==
X-Received: by 2002:ac8:5a16:0:b0:4d7:6c8a:4792 with SMTP id d75a77b69052e-4da41e11477mr7368081cf.0.1758737592593;
        Wed, 24 Sep 2025 11:13:12 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b2a1773375esm916182166b.20.2025.09.24.11.13.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 11:13:11 -0700 (PDT)
Message-ID: <a7a41d1f-372e-4e90-9785-fd63212752c2@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 20:13:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] arm64: dts: qcom: add refgen regulators where
 applicable
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250921-refgen-v1-0-9d93e64133ea@oss.qualcomm.com>
 <eec9a046-2742-4b7f-86ac-ef11dae19aee@oss.qualcomm.com>
 <CAO9ioeWJh6fkDYT-Y6O4mJHN3CpVw-D0nygvA0TsgHGqXpLq-w@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAO9ioeWJh6fkDYT-Y6O4mJHN3CpVw-D0nygvA0TsgHGqXpLq-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: fRR_M36582h8TAeGSkfmdJB2fgmF2aM_
X-Authority-Analysis: v=2.4 cv=fY2ty1QF c=1 sm=1 tr=0 ts=68d434ba cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=pnmvfhyxxA4803ucUmIA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDE2OCBTYWx0ZWRfX5GlZfh03dbrj
 YGC43NoLLxWty0jULKub6yxU24RoTKyHPHwDysktsku2MUMa5D1gO6K3onQD1d76AKPIzh1DZKq
 9gqqT2hWsHqL/dfkdWfqJLY5gQclu9Pz6Kdm9KTgOVuZaFTK7ThAD9LbniuQQa8BamVEHDQVZPb
 1SUFW2ypDXNerbtWjvgDZtTyB7LoX4BZOESAnB2H602QY4xjB3vnrsD57AvGRrCfVAZURXyiR2U
 pkwYpObTcHl7gJXhA4EDa9XDtfvdDSZ3fTU8zb5MoznXObztjL0dn+nSdkahlYkQfuVWJ2pxb8G
 qUmiijLqHRJvddjRM5k3VThDheSQuEe7oxtLFv3mrYHvyDTW3X+EfR7DJjBv5xRZC8uOyE/t4lm
 oRQvroZ9
X-Proofpoint-ORIG-GUID: fRR_M36582h8TAeGSkfmdJB2fgmF2aM_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_04,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220168

On 9/24/25 7:32 PM, Dmitry Baryshkov wrote:
> On Wed, 24 Sept 2025 at 13:13, Konrad Dybcio
> <konrad.dybcio@oss.qualcomm.com> wrote:
>>
>> On 9/21/25 9:09 AM, Dmitry Baryshkov wrote:
>>> On several Qualcomm platforms the DSI internally is using the refgen
>>> regulator. Document the regulator for the SDM670, Lemans and QCS8300
>>> platforms. Add corresponding device nodes and link them as a supply to
>>> the DSI node.
>>
>> It's likely that all PHY-ish hardware uses REFGEN, so please make
>> extra sure your patches won't kill DP/USB/camera
> 
> As far as I understand, DP and USB cast their votes directly in HW.
> For camera... I don't know. Do we need an extra vote?

$ rg refgen-supply arch -l

arch/arm64/boot/dts/qcom/lito-camera.dtsi
arch/arm64/boot/dts/qcom/kona-camera.dtsi
arch/arm64/boot/dts/qcom/lagoon-camera.dtsi
arch/arm64/boot/dts/qcom/lahaina-sde.dtsi
arch/arm64/boot/dts/qcom/kona-sde.dtsi

Konrad


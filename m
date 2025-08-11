Return-Path: <linux-kernel+bounces-762475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8822B20737
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F8A33AC8FF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24772BE7AD;
	Mon, 11 Aug 2025 11:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ktTDidAI"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD202BEFE3
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 11:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754910880; cv=none; b=rtBPGdAHTfZT0KMNSkjHJuLJaGwmpFEpHzorrpmGK9jG9fSpPCaRiNdVfLT/7jXVoUEwWKBnrtuyGUt4a3fzaeRsBZapdIHO+YUvOpf1hAgD3ZKCagu2a/AuGgI2R+7l/H43AmKoh42u1K5edepFuXBcc8FYT0LHNckUfahaDSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754910880; c=relaxed/simple;
	bh=e24QJFeYn/rd0qZBMV40BvBKk1/UrSZNtUYQoAsCBHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hu0yPz4IwzpCw/pKDxgTFT74Xj5wcWLtltJcw0fjOFdzvXsWwmbXdEH+DSMW3TVsi39HB16/DWOkb4SjXVxY+pFvBGCSHvI+aGDrBls0QPQBgCvN+T4DH/ufpyUE6wml0+4iiOwRc4vYFurjqHtcDpCyocB8ZK+y3rmf3MjmoxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ktTDidAI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B9dl2X021649
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 11:14:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FMVgCALr0eA8+Us8AyPrgn7ofcaNBLZnHFXRdCHjjtM=; b=ktTDidAItFqOW24t
	S2HZKgTLd608Um1Wjh9VBp6qsSawH55zNd6TIZw11mULKqEatccWJTDo7Mjm5C6n
	DwQlz/d12F0HPP2jPg0x+seP3HZr+XLAINcB7wcGiqNdwY5VQJm9glOX5mxo8/da
	rzrKG9D4mjdzpf6exaer6qjLaWEum3Uq5SgPpNl5ZmEHsJbhvOnURV1ondGMOEnG
	UeBeEHbIybYWKH641vvZNVqfu8TmAhRjb8wgr3S4obhADzh+mpZA9OeQmOOYlKVp
	4WGchkteboag+vIkXj4KcPEYY64Oswak4OkZfCz59BGRPTPLZIOdV9VOXV3whK74
	9LibGA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dxduv5am-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 11:14:37 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b071271e3eso10880761cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 04:14:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754910877; x=1755515677;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FMVgCALr0eA8+Us8AyPrgn7ofcaNBLZnHFXRdCHjjtM=;
        b=rJlJ5ZbmBWDmfkvbG+0AL8FtOcBzjGzYiOnCpjigFB/ObpU7dtySDJ4NTTqRcP+yDb
         d7cUQBv3FXHj8YGEpf0IENKF/aAmBH5bcg2FT2DJb7gwbpogNRmejex/Jqid16bPHuZM
         MXodPKx3ODHZHpbdZmWITEI40igdkzU6FvITXMAW7Mb7JZAJs1GMsuwFT85b2C2U4QKr
         m2l8hL0GnzuQGmBSwFTxwNktW0awYn0sSMK073sLMoJOTBkgDwS1/4KPzmDlJkvC95mk
         I7PMoWI/AL4yXGqipBKPGz7qob5lRgWogvk0U7psCk3bJZfFlsFHdi5H4v4zu2O7xA/F
         lPoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUv75aj7gVdroawrIEKKkn2dZdKybY+Ft9/5PlfL6gvPgF7tZvp7J4Lh2uXuvrzecUHaYNQQ7INFQyDEkk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6HqkM/2i6DOkAcyHYznpbsud8h8bOdw0huADi8mau5KKgfqOu
	m9zN2o9J9djRwjyQbVwV2nReSYhqLsfyPH3+CprgAG1cTSAucyqg1/ppZjG9KsttuLg17hUdJD9
	FVnhH5Rc7WM8wqzRR6L4rvBdsdQGuJyUXzPpRBbLV2JAU3kidk/zQ/aXgvqX8TVOfRIA=
X-Gm-Gg: ASbGncsvPFyQYg+QE4pOxDj2s0iAxV3+Yvz2t5RTgO5SjGhXV2bYphzYN+J2cgMWCXT
	K++K/ZOfkJ9G2pvf+tg3yRHpwrbhxWX4tZZFbSDCMUhP0BXCkxOO0/dU/zl9Tj1YLIYePEhlK1l
	1hllTkLIWsCNiLa8nat8hBq5cNJXnWgFV0s6Otd7PbLbRuUlsJ9939xuYTQW4Y7ytBQPZtL/eYN
	oijp4Y5g8xLVndcfTaMCjMLHKxbgkBNimkL76XSHVa0HJpgSBDyDxBNttGnPGohM9/U25B4B/aI
	PaKyZwJPP1Uu6HUEzbC/DKKkoe85D/FlEAW4ntt7fw5ldzodgm6jo3DTZ/zngWMLRe8Gn8ZTQpR
	L3W8baRHP7YelG58hfQ==
X-Received: by 2002:ac8:7d14:0:b0:4ae:d762:c070 with SMTP id d75a77b69052e-4b0ea60d209mr1240911cf.2.1754910876589;
        Mon, 11 Aug 2025 04:14:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcUfndsz+/5jp0G9OaiDDbR36Irm8Uk+PPCGZvdlMWx0v8ppULBdZLYX9OArLLxW8LKzxvuQ==
X-Received: by 2002:ac8:7d14:0:b0:4ae:d762:c070 with SMTP id d75a77b69052e-4b0ea60d209mr1240671cf.2.1754910876078;
        Mon, 11 Aug 2025 04:14:36 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21ac0asm2000540266b.99.2025.08.11.04.14.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 04:14:35 -0700 (PDT)
Message-ID: <a6dbfe06-00bc-4fb0-9496-fb7ca849f832@oss.qualcomm.com>
Date: Mon, 11 Aug 2025 13:14:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sm8750: Add PCIe PHY and controller
 node
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi
 <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_mrana@quicinc.com
References: <20250809-pakala-v1-0-abf1c416dbaa@oss.qualcomm.com>
 <20250809-pakala-v1-4-abf1c416dbaa@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250809-pakala-v1-4-abf1c416dbaa@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=IuYecK/g c=1 sm=1 tr=0 ts=6899d09d cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=gkRObvzxmN_HJK3DEhcA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: Lt8qTRBJZE6ypWcDzopAQ7CqzfbZKRPW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAyNSBTYWx0ZWRfXwq1JcdqlU+Q2
 5S6IeOUpiu/J6bi0SzyyTihnlNBR4Pqd1BptjpEi7g+9Uc2z9qXTWJ1+AWdhtTIzD4gPTe1mteP
 jpZmmOTL1SGkb0CJRSWqRzJ34UhKuxQ8eZPyREmbT/hJz03w7E5MMhBi0L+nC8yv/ah/GWTnAUg
 GFZEAe/htZp6Ot20fDRrHgn+rAqnM5TWqn0C8VwZetoY5MpyHvAGbwsVP5bjhKDot1tloudC0Fs
 lKBcyOzWgKt9mbqDPyC9rL7Ea9XgArqOJKQ8jnzpLF6bM7DELegNw1GSw4tERmijqyGqjcCrAmw
 LpYSHTWG2lZz+0275pCtXIGxHyQUKnTdbi7q0itqYe6MFTDw6EaUr6lUBRUza4d/IS1hjoFkeX3
 t99fAkC/
X-Proofpoint-GUID: Lt8qTRBJZE6ypWcDzopAQ7CqzfbZKRPW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090025

On 8/9/25 11:59 AM, Krishna Chaitanya Chundru wrote:
> Add PCIe controller and PHY nodes which supports data rates of 8GT/s
> and x2 lane.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---

[...]

> +			phys = <&pcie0_phy>;
> +			phy-names = "pciephy";
> +
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			ranges = <0x01000000 0 0x00000000 0 0x40200000 0 0x100000>,
> +				 <0x02000000 0 0x60300000 0 0x40300000 0 0x3d00000>;

The BAR space is larger (0x2400_0000)

please align the overall node style with x1e80100.dtsi

Konrad


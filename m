Return-Path: <linux-kernel+bounces-899428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DCBC57B69
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0A9413440A3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 13:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68969221FDE;
	Thu, 13 Nov 2025 13:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AoXCpOsh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UdSIUahX"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695F021D3E4
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 13:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763040855; cv=none; b=pc3AwgZssaNCEX1TIUjKpfyXRkp3+AMylMiPjSPDYs2klANhpblKMBdgUUuW2Y3wOHFPI0CLq0KQ7uROSIdR6/wzhq8tdeY6o5XnhdmxeoxBnYzO1zqKWRxmHFKZ+4hNLx75DtgF4T8ERLUelgiBfDmdbxbe70fkuc6jw0H57uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763040855; c=relaxed/simple;
	bh=+IP1XudSJ38VP40JgyddsTiDM+XvNBXWL/m/zF2pMPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ciQnWNDfYd+LA+N6kcIDmkA66x+iJczFk/TWI7CpXKKOTB+L3Rafi6AxmVs9EtUJSpZfVk53ch7mVnjKMDzb/IcDVqqMoq40pEpyo+5CWm88htj6jjvjFg8p+c50wLhbQ8nfD9kOjEl2wiXfnXVxfjUUhsAFR2r9pRwN/mDAozM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AoXCpOsh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UdSIUahX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AD9FNhF3113203
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 13:34:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KlFdoAYM8/VYA6GdFSWsSZk5wCZjObFXEKG3Wx/Bryk=; b=AoXCpOshHgJsGACk
	5F1dN7j2MoHce1jTJtQArpaZPZ4MTlZ6HHWccKnw4gKbc3XLPchPWL07hOce2H1/
	jDiy4M2lRMMZGXZ7sDUvpbBHZOWorVaEXgq/xwLud1IXwYQTOhExf9hOLg4yExyS
	h9Eh4BTTAWfq1PSfzWNp2Lmy78wRc2PyJmMT3UIm7W0kmXTdf33Xaq2A3hTUCwiw
	JV1o2HKgRqp8JMYtG7nXk7wOwO6JROBgBlLvBSZvCux0RvhTE7xWQBFnEW6dSYuY
	M21QQQO/9as1Wp9HjTv/11VgU0cDqqc6RicHCIN07Xnk96gYA2P5WSlMiHxFjfqL
	jTqTEg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acuw4byjx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 13:34:11 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ed83a05863so2160901cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 05:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763040851; x=1763645651; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KlFdoAYM8/VYA6GdFSWsSZk5wCZjObFXEKG3Wx/Bryk=;
        b=UdSIUahXQmmTPPcBFQSFS/H/ng1b7SbyKuNOMbW6/Jcwc2VNzGENqgu9C04r2QPs7b
         Q+tzsPe3eVTgVPxPz+h3kao9DBVkrjFoEFCHbHTZ7ku34GY74yh5gtZR5aTs/xmo6ArH
         pX8AiWoWJEmVJ8k/wQEe8tT0Mrx+WTYdxQHmCdfx4MRboDkpGbn6UoiwYlsi97rKVM8S
         0HQznt8dP06LJ8BbfQA5TQdgSxY44/062pmsma5P858knpnY7/WEcJ2mYrt3s7H9Ezwp
         WykTVJp8Uv6PlqP37DTa0G4zAbqtYD7P30WHcDVNrA+mbPYbTXTVFX3QM1oGBHo4VPcX
         xdQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763040851; x=1763645651;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KlFdoAYM8/VYA6GdFSWsSZk5wCZjObFXEKG3Wx/Bryk=;
        b=vkzzNrD7wKEu4RC8FSx6h9wCcDW1xJ+qGv9573auWST9ucFaKbOlrCeaxHhqFSaBr1
         1bJ27O3OvAxSNsBdwo6pfeBAEu7zBFBsynFfq2tslER/ggbhcO5/y1ziLQi9KG6dxZqR
         mraCfjVLuQaSA+D49d/C3BLniN8QNt+cwh8FnzDVIKjvwfp9Ll4OdqvZTcfF78sLZWJC
         LNgxfMfDtamcfCs7fwLAXTYGZ4Hx3jsb9YpsoPI3eN55iy6DhyKuy/qLldOViGhGUgba
         gxZn6wzoXyhObwnEMBtFl2oER4xo5W4k6muh6iCLhQCu9VVE2ETEaQ38TKDE3wmGp4WJ
         E9DA==
X-Forwarded-Encrypted: i=1; AJvYcCUwR5gBRA8RsaadbyJnpqV2wg/g2g+H60x9zEXkkWfLet8P5WajNmGNYo+JDV2hdy+b+Un0ln0nvPoPXKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG7oLM9ZrUxVrApZqfF/Jkq/poG5ipsE6YzfJVFXcy7LXFjn3c
	PBioi7kQwWiFmw4h9yfz8Fjb1DpdFTp5I6PtBNfauASELM7p5zTAbbomnz2bshb3Bo6ZuAZ7Lh7
	tn3J88IBqrsApoVl5pm32Iq7nMOVyBLDf0kyslueqrdy89yN/8+8JjxIS8/flOZ7B+t0=
X-Gm-Gg: ASbGncvaFjvCr9IVcbloBlfwnOYoqGLuat+tOoo7jWJ8uHuVm7KxKUYALCXVsFR/GEO
	Y/gsgaXVOApd1V2tWk+lLJ2acZq1BtXjVsUhTGoxXeeDyGbHhAqm20PmXS5yWntCzzqQmmBgLJP
	K2Wv2fsikVvnW2VHZ9HfJp3cNM6HL/6H6Htzy23z8GhscUIN7GumXb2LTL0yMC7jtlW05HArp5h
	1fBI9jRSc11kXCL5t5GHv6cncelqU9UYfWgKqNeo5hqXFF3jwbwVgclvjW5MRgN6u6VjfdcwXX3
	ZqGbyXapXoUVDsfcDSih+BBbpy0HPFANthdeZthQuiuKHZi0ZHSFbdzHvEX+FDOVrjFsb/hMUen
	1PoBKpJThtN+iDvL6VfbyPyXpv4T0OjFFDZKHdZ6lHfAkxV+WMtxFCmYC
X-Received: by 2002:a05:622a:148d:b0:4ed:b2b1:18c1 with SMTP id d75a77b69052e-4eddbc9bff9mr56111261cf.6.1763040850791;
        Thu, 13 Nov 2025 05:34:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPE0sRVrglN3s1Wc42f/OsKVhH+8tSWcqanaQmO/9xNP7f5H7iuIa/iIFmPGwOU/XlckjLYg==
X-Received: by 2002:a05:622a:148d:b0:4ed:b2b1:18c1 with SMTP id d75a77b69052e-4eddbc9bff9mr56109611cf.6.1763040846925;
        Thu, 13 Nov 2025 05:34:06 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6433a49806csm1453196a12.18.2025.11.13.05.34.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 05:34:06 -0800 (PST)
Message-ID: <f433a645-5af6-4813-ab76-687d1ce22b0c@oss.qualcomm.com>
Date: Thu, 13 Nov 2025 14:34:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: interconnect: qcom-bwmon: Document Kaanapali
 BWMONs
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        Amir Vajid <amir.vajid@oss.qualcomm.com>
References: <20250924-knp-bwmon-v1-1-56a9cdda7d72@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250924-knp-bwmon-v1-1-56a9cdda7d72@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Hov34olPTi3wG40F7c9_hoCdcJTDDlOu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDEwMyBTYWx0ZWRfX8Qm7xV+cbitB
 Hm88BdcuE/qOZPTRV8ruYLmclefnofJgO1DsjdTWA0yekLBLiMFgdMmQnBKlzV21+wyg747p0zd
 oO63rS/JgEUJ5sdWrgTQPi2oE1HG0uxDwsq7lEW3fY+xQRMZPw4CXcdvCTSDtka+iX8dT+lMzXY
 CHcdrCZNZ1pqGPX42roUVlk+ekvHTN81PZHaE8d4dnGayXE3kleWABau297/J7sAaNTOE/Q2URZ
 xFlI89FF4UG+v6bufTphJloIwEqBY/il4i8434XJk9YiMlYl/SE4NCfZVz5qETVFIwiDMjQTMng
 5dbztIEAmhdO6qK93aPbCbu5QSImiC55TrqEYmLpDUV6CT/mFaLCA1j567PGAvHQu6JhLL5JKPu
 FtfIeIKqjcoXjMUuWQb58s4vanqlsw==
X-Authority-Analysis: v=2.4 cv=F+Bat6hN c=1 sm=1 tr=0 ts=6915de53 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=mygda9kbUFeXYpHWPk8A:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: Hov34olPTi3wG40F7c9_hoCdcJTDDlOu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511130103

On 9/25/25 1:25 AM, Jingyi Wang wrote:
> From: Amir Vajid <amir.vajid@oss.qualcomm.com>
> 
> Document the Kaanapali BWMONs, which have one instance per
> cluster of BWMONv4.
> 
> Signed-off-by: Amir Vajid <amir.vajid@oss.qualcomm.com>
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


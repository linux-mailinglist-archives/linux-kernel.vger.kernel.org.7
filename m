Return-Path: <linux-kernel+bounces-872960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AE9C12B5E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 04:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7148561D52
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 03:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849671DF247;
	Tue, 28 Oct 2025 03:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CVIb7nRP"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7125E1DE8BF
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761620536; cv=none; b=D60F81/JVvycog5lVh/A2nwwZTVmtUvvFtl8TjBsLqRs00YE5XAqGMJzVigj3UN5wgWTcUqp7xXVTPqaDNXZcsWDMaBwMAz1RjBR1REmwwa2i7rQQEhgNR0Ukx5MEzK7LZWMZiG6n8Z3N5+/+qDa2/UdJyd+xLD/uHOIIKaCgMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761620536; c=relaxed/simple;
	bh=J97EGj37o1LYAf64oQGIuCna3MTQqEBoZLlajyaxXGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dZtfixEi7k2cuNlEvo5nQd4H4ktxh4dxBwBHr1+eniwcxwUYWk5Xsy20mwMxCno2//bObN7PBjDzRd/iySh74zQlYu+lx2FDgr8XHPIu8o9yzMRk9dy8TcLdF9xxIAsK1+daMNWBrFW8Tx5Ct23ljGFI3OZrOwBcvmhbbafbdQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CVIb7nRP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59RH8aVB3378617
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:02:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mZT/6+ObGcxpNvzNL3larcNaKCkvBwUwpJYv6W7bOhk=; b=CVIb7nRPeXQ1xUQF
	GSBi0Ve6BZlknIEfrbX2UGzMgJqeCLiOz9nrOyxmMs9+cWdHXsSK5gu5JEcuSaj0
	qj5ZWOTEzszKdFELKzf+W3AeBs7XgIbzl+w1H60i5H1ngjN0JptREGRuG32Ygtku
	B4ClVxo8D1h2gSBvTj0OUkbcXEcT6gBqNDESFgXowrFOGh64jX7Aij6ylxuztoxy
	T2JeMRilZCOS7QKUsIO+9xlN6dSwiRAzyjHIgM1nP/lYlAUYOrczGBQOaCnCwe7Q
	vtBEqd7b2wEGQlmcT8eAJhg7ZxMeHl75dZ06gS+hji7PPN3WOwttsWb2I7ZE9kls
	7Oewzg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a2cvhsd61-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:02:14 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-290cda2bebcso17505565ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 20:02:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761620533; x=1762225333;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mZT/6+ObGcxpNvzNL3larcNaKCkvBwUwpJYv6W7bOhk=;
        b=WVPIA7s1LniiE0qKiC9nSj5eYqffOagCh32xGGXxebrG+cUFqT0DE8Br/qT4aKoIYD
         9vZtEmHmNS9SzkKwx42AnPsaZn7AZShap2KtYJsEQgwatqSJuasMDWWKxPdRzW7HbDw9
         SYFK6rQ+j61rYDU2Ms2Ic04Wx09iERZUP8Z6gpD0i/MWyFPRmFKTXNS8pzDjgCqUO4TW
         TmMNVKyUycgmTzqW8E6W+4k4d+WzOJhqtBKpYF3e8f4k3S9PFQyQv2+fBNk2WpS/GcZ9
         01AnECe2N5cqjfY2QibEWFJzNdKxD2VNAeetfpiGrDg/SJLWqIpBuxTZG5yOHrr+KGWe
         C2+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVdSSViWzvluV0ijThXK9kFkW2aL+HRGFNAIFePCXPrd0qcL+q4s3bBAx6ymGlGWKuL4tWssHJmhOSoONc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXVZNFRP/NK3cVB2zzAYvsH+IhvbukUDLMu5lH006Y2Fmc7MFI
	xnH7Ii0AwdoPdNAUlG/lJ1E/1ICTdOpbFenoO0SUxDo1K+IFVcaJDKEK+Gqh/3s8jerYQM2lP6k
	cv48X58JW0xZIIHNq2x1HCNfwW8dgbP/mNMWVlLk827sLbjUKqevFhm5wgpeqc7EUQx6b7l/z7b
	k=
X-Gm-Gg: ASbGnctZavTtl2Qa+WGkCRAHAiVDnhnufM/rLzjus2u0QyPKgqIP9g8LOoQrYgfeDGp
	B5IV1V5rcyDOk6xDgk0AvxxvDiwLmdL7l3NF52gH2qY6z7CemqK1Flj6gWP4sFB13oQ5VpFzHKm
	0UQBkJQ3nyvGPuSN18JAEtIKhCiQxNTM7VKpQBLM3+QZpVeo2H29nkj9Ye/Sylb7nHVhZPnzZGM
	BpVl9gks1U9dJdo9g7BaC06NhTjsaS1iCn2TMLrZWMuMpKdpi4Q/Frb+Li1xbp5Z0pJzFcgaA3w
	p0c2zvpOWIhAlzyu0NSjWHre1SwBv+LX+NJV9A+QE4cmB0BScKzc5YDQKCOggM+CsZ+9ITKYDHj
	Wm2J2rqybK5T8Y5gMmeDRn6rvTRJAZeXu413ixZys6aSI7Gkyb3yDkQ==
X-Received: by 2002:a17:903:2c7:b0:27e:eb9b:b80f with SMTP id d9443c01a7336-294cb37880bmr12041795ad.2.1761620533203;
        Mon, 27 Oct 2025 20:02:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjH2jcjwExR9ZejktFCScAZsb46EVXd09cixcaCyHqdEG80lz4FVfKGqiyH60DFpO/NfhY8g==
X-Received: by 2002:a17:903:2c7:b0:27e:eb9b:b80f with SMTP id d9443c01a7336-294cb37880bmr12041495ad.2.1761620532610;
        Mon, 27 Oct 2025 20:02:12 -0700 (PDT)
Received: from [10.133.33.249] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e42f5csm96570895ad.104.2025.10.27.20.02.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 20:02:11 -0700 (PDT)
Message-ID: <07c5c404-e2a7-418e-af5f-dc7c4df9f2f6@oss.qualcomm.com>
Date: Tue, 28 Oct 2025 11:02:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: document the RPMh
 Network-On-Chip interconnect in Kaanapali SoC
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251023-knp-interconnect-v1-0-df13182aceac@oss.qualcomm.com>
 <20251023-knp-interconnect-v1-1-df13182aceac@oss.qualcomm.com>
 <57bc950a-a62b-4218-99a0-86c570bba6db@kernel.org>
Content-Language: en-US
From: "Aiqun(Maria) Yu" <aiqun.yu@oss.qualcomm.com>
In-Reply-To: <57bc950a-a62b-4218-99a0-86c570bba6db@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=HZsZjyE8 c=1 sm=1 tr=0 ts=69003236 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=aNDXB-n8nvUMI_014rgA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDAyNiBTYWx0ZWRfX9Z2ri+xM/2ml
 PUIvgFW9nAUEjGfVM1Axv1vcm/PESBP3My3/dElY6lXcicNjzWeBCl8f6TzFGXCZs0oCRlUtp4+
 1cJ0gz6MB0/rTgFr9IKHa7qJi3StIH7dh3nhkchfOIjWjtSvi1GdymjL4QISE/fVVsE9W3MKphm
 qlu9nlZOPizoNXgk5ml52W2Lx2YW+01kyBZ0TTjCZ5DESor+A06RBjK7p/WDoF2KGROJZ4Bqu5y
 DXUtllhiFmNm0e7kw9e+nxw6ZNCe/qNEo3+V5ryLhHOlhLOEbjCRdMu/m8FQ9IXIIZtINQuhLSK
 9JDoj1giHhUjPaiaZfvKvrq+mCuT6WIIxfmYjz19QVKtbZTXYTa5HhN84Jbroi4E/j4GPJiOPjM
 SPCXdKxnNBsUY7TKSLFmlQMePn1bbA==
X-Proofpoint-GUID: 8u4KAH0OV7nX8DKgWlBWDma5L2ZeF49E
X-Proofpoint-ORIG-GUID: 8u4KAH0OV7nX8DKgWlBWDma5L2ZeF49E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510280026

On 10/23/2025 2:23 PM, Krzysztof Kozlowski wrote:
> On 23/10/2025 06:39, Raviteja Laggyshetty wrote:
>> Document the RPMh Network-On-Chip Interconnect of the Kaanapali platform.
>>
>> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> 
> 
> This cannot be tested, so there is little point in doing real review. We
> already provided guidance - and it is documented in your internal
> guideline document - what to do in such case. Please follow internal
> docs to decouple.


To be more specific:
Please drop header "<dt-bindings/clock/qcom,kaanapali-gcc.h>" and use
ephemeral clocks in the devices example like
<&gcc_aggre_ufs_phy_axi_clk> <&gcc_aggre_usb3_prim_axi_clk>
<&rpmhcc_ipa_clk>.


> 
> Best regards,
> Krzysztof

-- 
Thx and BRs,
Aiqun(Maria) Yu


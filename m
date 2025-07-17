Return-Path: <linux-kernel+bounces-735984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E769B09640
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 23:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA8B63A8E57
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 21:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3BE22D793;
	Thu, 17 Jul 2025 21:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CCQ6Zj5t"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD30F222575
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 21:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752786383; cv=none; b=Kzc5sPF2n8AzQ1vHxbcjSDLnKVx37xoP4OTdaq4ZL3Sq1k7+kj1+Evzy3DXQGLS1jqpnGkcIO/tI3rHTEqumfVtLFvrRkW3KzM7PAyLKi8w0YEr1kwM2YEe/5I06ttlmYdrphVcJn5PxAxxsPFwKdiEB4d0Ooc9gXDOu6cZijoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752786383; c=relaxed/simple;
	bh=Fu5f1KYcPNBKXbwBLRZ4Cig1/7uNC4oBZT6MsGsCCXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tTtw/JqvV39WbGxbYNTJOXeE37p4fA5BD/t5A+d3SeshNgjO9noyVjydv1008K3SZ3y4MmC70L5uKxo+hq2bJfwg24RjtI7Y5Mjg2k+IjB+eES5FF66Bty8eUpfB6n+DcjnwM4INVfutisIUASGZQW82PDTJVLRzPrsuNwGkuCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CCQ6Zj5t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HC5nDh021258
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 21:06:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0pHw80GM2tQXK/P5MspgwmNzeXrdomfpLEtnn34M6J0=; b=CCQ6Zj5taIIZgg77
	BjsrbRhNCnxCoHw75tzik23Z5SkOjFbzC3ZWStbyKsGNyAA/8nYux/lu0Gdwf/EW
	F/FadNR3e4hcsj/VB53T+14onJAyrVEondsZBKolYuQGymdKLSABgFCT9rPZ3yez
	0BVC8k3zrT3sMnUxN+05vHZX8BGVDhUZ7MNuObkXxagKVeRUfFHuthRc+Pk2PvO2
	uFEKBcvvsFQevJDztr3weGvJqNWkUsRWnusS7W5tfSf69ECcOrSWR9LiOaRoIe+e
	lfdZ4WWm+mgi0hE9jTKA3ud+aIcxLDy4bgzq0McXapnCbw4I2pd6aVwOABwgVtzb
	hAFFdA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dpm84c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 21:06:20 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6facde431b2so3842396d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:06:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752786379; x=1753391179;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0pHw80GM2tQXK/P5MspgwmNzeXrdomfpLEtnn34M6J0=;
        b=GtxiOeWGIKfK9uXj/ZGVIu+jD7IwoYKALBfki8fmPz14re6WBdxg8mpnG92t8AhLyN
         iGYFTGtiwsgoSRQ0FWCIP8AOxPN4n0sl2AuGlPcktm1xri90mpNLo73AojzK5o0tMQ/8
         NIjmL0fkVGVI1lh7No/qMMHNRKJt2MSIEKNgwpddozJ8eHP1ivzU5t0EeN84y49d/fhx
         VvcAJYf8Vt0J8W1YDzLCe+74MLXj5xAJogjeuISj6Tg9eT9Wfw8hSHa8o94QLyBcv9kw
         2YP3Yesn0gX24OlCqDCzyCptZnVoMqTC0QleViUt7LgddRVHHei9FDxKaG6DXBdUYsjD
         x+5A==
X-Forwarded-Encrypted: i=1; AJvYcCXufB0wUvZtjwd59s2yi3F1OyIHid3fmxaSUzyHtxXDTQbwvc6UT34zLcgCVwHg8kqBicMZWOYX9cuUST0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdyR/sLC0pOU+9mWNuHEOy/b7cQ34sWrgudmgJzCDNVVZt4V1f
	fuIbZuLuevvIKa22ebIrkhSTp6v8xUfEcVpOy6+zNSmaCfvfp3kNTBh6fzcezrHfUeT/EaphkKV
	z9IznkB5DlFBkuTHLeZJ51rlngMcUt5BRuVpe3/OvhfqHhxE1Q4bjpNg8kfUGgoDZBDU=
X-Gm-Gg: ASbGncs1Y2mRBl/afhH9Ei5/1fmajEDmy6f/zUmdv5RThlTlAOU6bdlnkb08x3Z+Zsh
	7daFNthXueiLJUsWcyRuUkKsURQ7U/NwAhIFowydxdMhQWIV4VHwVCw2E2CClYWmClut6nzBz2i
	TrxX0Si8q2LEF5RAcAbS52BrHFhR6DKMLa7YNdIrsBFAlgoFu5RgqsFloA3lq1NVsqUdSdNyPVi
	tiXojACIjfVnRLvNQwV3cQ8wZT+Nx5v+B4Lxx5rmAfoVzm7vYgfw4jqeqqK4EAtGo7Nw4muDpgK
	8jj3vU5WmjMwXoiMSsehrh/16HiWSemY7ewlbmodT0N5H6fCwTiktOUEd7NricNVldZowjEdrU1
	JcTp4JTFoN8J+3eZd6pU1
X-Received: by 2002:a05:620a:28c1:b0:7e3:297d:ec32 with SMTP id af79cd13be357-7e342b37074mr503117985a.10.1752786379387;
        Thu, 17 Jul 2025 14:06:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgsvETj4x558m5O4J1Q3oaDXiBHmdl68wKzu5lszhWnL8Pa+XlDwiszt+zOKmmwEGKjcAMgg==
X-Received: by 2002:a05:620a:28c1:b0:7e3:297d:ec32 with SMTP id af79cd13be357-7e342b37074mr503115285a.10.1752786379004;
        Thu, 17 Jul 2025 14:06:19 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8294bfdsm1408812966b.120.2025.07.17.14.06.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 14:06:18 -0700 (PDT)
Message-ID: <b5a1314e-6733-41e3-9258-c3a88b2c90e7@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 23:06:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/3] arm64: dts: qcom: qcs8300: Add EPSS l3
 interconnect provider node
To: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Sibi Sankar
 <quic_sibis@quicinc.com>,
        Odelu Kukatla <quic_okukatla@quicinc.com>,
        Mike Tipton <mdtipton@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250711102540.143-1-raviteja.laggyshetty@oss.qualcomm.com>
 <20250711102540.143-3-raviteja.laggyshetty@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250711102540.143-3-raviteja.laggyshetty@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE4NiBTYWx0ZWRfX2YVphox5ZfJq
 cuKji6UtaaUQEMI+u60eajHC3Qcq+aekVOT8CDEZQ0LWnJkB+LQOhLQDZ137LrGgT49yhwMEfie
 ZZl/o3apieGHRDZbWKlPMIfkKePlvdoNnGgRhNFsYXamLuw9EU5NfCztAF8cE21Dr7gt3N7l0mp
 2o77hIdHGmvWvgrLblf/OT4k35DKpCT8XfwAPXKviy0+6URe9ty8Mt3k7st9/eTWfAySqufQvLG
 Qz1fgpX6Ca+2spUhyNLi46FXYx8W5p0YLyGUOv3vNDZb3CUEp49fw/SdrXnrlhxzKg9jxJH0TAX
 XLDJj3nZdhu3alZ/Y6/c4i3ZGNiu39eLwSmKg+ZWRh+Mpn4qhQbSfF+xxG885FrRKVbygDn5G2L
 tC9axGk/boT0tPYiYhdAYkhglpDc1B0g+DPAHbGIpb96KWcMKpVI5KM2hx50SgnXg4tLdTsz
X-Proofpoint-GUID: qquqALUjwWgqKD06PDBMnwhDqqEv6e_o
X-Proofpoint-ORIG-GUID: qquqALUjwWgqKD06PDBMnwhDqqEv6e_o
X-Authority-Analysis: v=2.4 cv=Y+r4sgeN c=1 sm=1 tr=0 ts=687965cc cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=yqcj6WI3IahE-w5yY7AA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_04,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170186

On 7/11/25 12:25 PM, Raviteja Laggyshetty wrote:
> Add Epoch Subsystem (EPSS) L3 interconnect provider node for QCS8300 SoC.
> As QCS8300 and SA8775P SoCs have same EPSS hardware, added SA8775P
> compatible as fallback for QCS8300 EPSS device node.
> 
> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> ---

Squash patches 2 & 3 together (because otherwise you'll still be hitting
the issue I described the last time)

With that (modulo me trusting the numbers you put into the OPP table):

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


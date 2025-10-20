Return-Path: <linux-kernel+bounces-860972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BD1BF17D8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA8454F5AAD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9A03128DC;
	Mon, 20 Oct 2025 13:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nWfpXYQ9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B3C2FB0BC
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760966063; cv=none; b=p4woo58yRFDb8QvTJ+ZPYfEYhm6EgBtbB89DXnufIoMLTNpql/6jCcjltnb9IEuxx24JMyHFv0DM5fMizIWeCUuGC4aDu2cFzZSusJEYygUgPbFz+r7FGiNAKmwbCq+SIeRPQHD67gUxbJh8+BCN8DahNqh05pX0+GzEjNc0RIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760966063; c=relaxed/simple;
	bh=K17iZbxErCB7RRdwUDGEfb/50uA3NjulFIzMFcfuHvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TKWKZZ7y/ymDjoLXVKwkCoPcH4Y6+EqKXyXbFDMSKX5ZK1JCFvjKRjbjjlafXPVvaZAAeLP179ElDPJQVr5QwTsHTt1mRrkhjLEFbah/77rO3m7MyRmqj3sdkJCA60Nr2038eOFJOUYlnVYScpY1Oz3658TMtS+RxjPD8qP42MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nWfpXYQ9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KBktIw013109
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:14:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ty6BZbhHGNlaZVw/wohTLndH
	gnCUHm0DYc4+byBpo/M=; b=nWfpXYQ9xcmouPHG1EZo6TIw8VoYILolk9C7y+fw
	WYOIajmfzo07W01QXctM64WaJQOWCnpi4+0n8V2t6V3f49GxZViKtkRq06BIcXtJ
	eML9Z88ORwIN5wo1Zxv4zhUb6YrUMExhHS/F8YhllkWq/qh8HBqSdLGBiS4e5qTX
	5q7M0VUepKsVowEnTmGv0PgegMSpXkw1syvjVYkwb3Y4MYYIXxm5pZmuqWHcc8d2
	fHbNBA5MwwrSpvwvu7fAx2Tz8QNm5JUFAuSJsR5N/K0WhZeZ5DRJ0uQxq16dSKJp
	9EAzYvZi85WnnsxbL98L5VQxZghYrXFm1vik1vzJTbpxRA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v3nfctb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:14:20 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8904a9e94ebso1715272485a.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 06:14:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760966059; x=1761570859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ty6BZbhHGNlaZVw/wohTLndHgnCUHm0DYc4+byBpo/M=;
        b=LliK+KFeA10keaAlm20JUq1UZ3abNT8jQdS8NXmxnRU+AZheZB5hBG/EEBzgCwsO2M
         9m/UPZ8Jjmvk8iBMHbtAad+bgzwhd64WkhVBk9WhMfaHdK6u1mDIEN6PTqYlQX1q2xU8
         4Pl4EdVDBxnme2R84Fqh5A9REbGiWSjNaDLe/RT+lw3tgIadDY6zv8l4VWW2ezvKOK6O
         BRq5xHoP95qwL1FfGbossl7dbYvxQ06F/+gYek6wJJsIYxqjwqRlBlNLu2iXmNCrH89W
         WeNPVR3lxWoguZ1LBmkMMAoB8vKhs/Q1PcKDoyAHsGEezVAvSgfLXluxbH3J8l+wLmNJ
         RHNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfCwwr+md7d7hZ8H4BfOCCyrqiabA+VtfbftM9g2zejgwYS1ZUOSwY7kfKOUbLuOd9dQUL/CF74xV2o6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaFpVSIdN2MKzjV56vSsBXLsRU/XrxuuBrb2HX8iGr9FHVt2P0
	uZpdYjm602oRCu8+0zDZz40JAFtp2uRmx5XVfOg4+OqNLy6piSXRct8E22TFwAtHvvF7UrRDLB6
	NLqrP150mlyv9SweptLEVaa6hRKFVNFK1pYPyIMhbNTJmUkyIN4C1vXN6hHjvKNDfA08=
X-Gm-Gg: ASbGncs42/samx1j5jhk5OqkV+e4vnpt9DtFnjklefiz31w3OIA4haqd1kK3szJ0g/D
	z2nLY4e5vMsuHpEVvBLpoZCuh4Tq50PLra5gesZnmflvIzKUsQYM2THp0cY/eCcN+NI7TvELq/X
	f8WvTd5VkP6DmR7aeEAqdn+eSSs7MIf89IRKvgaOfrn2daZtF6I1yqC4qTqqwjvFEfsU44BE5Cd
	TbwVtk0Arv6Nemo7HN0Sa5Z01YlXS5W1zrUQmE+fHc7QWt2FSgYrPJC1YOP7u99tm06AUTZWPpE
	kC9NSKzHf3drDmiunJchTSk+WWuXNFVX3F+EDA1O/6utALcH4okIhr3zcfLFFm1g0HCqjpYzMq6
	84rie0txF5fdFr9kMibeHYZX4lhgeg7EIV5FzkgALwWXitW55mHzuLtXN3WN3qE+90UfZOrgHPW
	vnkt9QDfqe7AM=
X-Received: by 2002:ac8:5d56:0:b0:4e8:9a7d:90eb with SMTP id d75a77b69052e-4e8c1ab2c39mr47384591cf.38.1760966059141;
        Mon, 20 Oct 2025 06:14:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE22wgdqny0U3010hR/HovVN2cGDutNcfkMuumHOnhrsL6Tx1eruFqbL+4HBBUX3LaGh5Rxtg==
X-Received: by 2002:ac8:5d56:0:b0:4e8:9a7d:90eb with SMTP id d75a77b69052e-4e8c1ab2c39mr47383991cf.38.1760966058521;
        Mon, 20 Oct 2025 06:14:18 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-377a91b7086sm21858881fa.12.2025.10.20.06.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 06:14:17 -0700 (PDT)
Date: Mon, 20 Oct 2025 16:14:15 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nickolay Goppen <setotau@mainlining.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, linux@mainlining.org
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sdm630/660: Add CDSP-related nodes
Message-ID: <5hbc24lihvau7s2opzcxxgxkzugmbqmdtqwy23m45j4po23lnh@jyjlbgfjaddw>
References: <20251019-qcom-sdm660-cdsp-adsp-dts-v1-0-9ab5f2865a6e@mainlining.org>
 <20251019-qcom-sdm660-cdsp-adsp-dts-v1-1-9ab5f2865a6e@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251019-qcom-sdm660-cdsp-adsp-dts-v1-1-9ab5f2865a6e@mainlining.org>
X-Proofpoint-ORIG-GUID: UX6lfD1v0PZEYt1xkmgcH1HEKJRLGWBw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyNyBTYWx0ZWRfX/fNxOpC45HxF
 qO5tuZfv8uGEzW5vym2haxxd4GfV8xSKeZ3g3X7LxMWSLQw5lBV4yTfEyQ+rwhosAzi8y9WgDZn
 /N7Vn+iHQHGsO/zbrFF+CxqWM+NGy8m1BeoqiGDDAAHjfUBptshkFIGuJOTxQLAFc7gODJUnUde
 Twp8n0c9Pjnravz4ULMbDyV5RddlF4lSgCd7iKtTMfPRiTLZUgEgoJ/JLucKISSVdtOsHGcigv9
 zP+rQYysBJhMOFlJTSqTmrk5hiM4JZivmNtUleELW7lahLqGEFRd5yH1rIlNpNGUTGwsE51gY7K
 xp/0Z2LjX7srBGcmuddjPRzGyP/KOVHk8hlgWUGoPOxoBNoOWGKX7jWhtRqbrJfXVvkkSil9iFn
 9oaIzBEBXnP9LiRJ6NI+hyzrgqyXjQ==
X-Proofpoint-GUID: UX6lfD1v0PZEYt1xkmgcH1HEKJRLGWBw
X-Authority-Analysis: v=2.4 cv=EYjFgfmC c=1 sm=1 tr=0 ts=68f635ac cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=OuZLqq7tAAAA:8
 a=GtE7y4fGcSms5GSDMiYA:9 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180027

On Sun, Oct 19, 2025 at 07:27:06PM +0300, Nickolay Goppen wrote:
> In order to enable CDSP support for SDM660 SoC:
>  * add shared memory p2p nodes for CDSP
>  * add CDSP-specific smmu node
>  * add CDSP peripheral image loader node
> 
> Memory region for CDSP in SDM660 occupies the same spot as
> TZ buffer mem defined in sdm630.dtsi (which does not have CDSP).
> In sdm660.dtsi replace buffer_mem inherited from SDM630 with
> cdsp_region, which is also larger in size.
> 
> SDM636 also doesn't have CDSP, so remove inherited from sdm660.dtsi
> related nodes and add buffer_mem back.
> 
> Signed-off-by: Nickolay Goppen <setotau@mainlining.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm630.dtsi |   2 +-
>  arch/arm64/boot/dts/qcom/sdm636.dtsi |  14 ++++
>  arch/arm64/boot/dts/qcom/sdm660.dtsi | 152 +++++++++++++++++++++++++++++++++++
>  3 files changed, 167 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> index 8b1a45a4e56e..a6a1933229b9 100644
> --- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> @@ -563,7 +563,7 @@ modem_smp2p_in: slave-kernel {
>  		};
>  	};
>  
> -	soc@0 {
> +	soc: soc@0 {
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  		ranges = <0 0 0 0xffffffff>;
> diff --git a/arch/arm64/boot/dts/qcom/sdm636.dtsi b/arch/arm64/boot/dts/qcom/sdm636.dtsi
> index ae15d81fa3f9..41e4e97f7747 100644
> --- a/arch/arm64/boot/dts/qcom/sdm636.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm636.dtsi
> @@ -16,6 +16,20 @@
>   * be addressed when the aforementioned
>   * peripherals will be enabled upstream.
>   */
> +/delete-node/ &cdsp_pil;
> +/delete-node/ &cdsp_smmu;
> +/delete-node/ &cdsp_region;
> +
> +/ {
> +	/delete-node/ smp2p-cdsp;
> +
> +	reserved-memory {
> +		buffer_mem: tzbuffer@94a00000 {
> +			reg = <0x00 0x94a00000 0x00 0x100000>;
> +			no-map;
> +		};
> +	};
> +};

This probably means that we need to invert things and make SDM636
inherit SDM630 and SDM660 inherit SDM636. Would you mind doing that as a
part of this patchset?

>  
>  &adreno_gpu {
>  	compatible = "qcom,adreno-509.0", "qcom,adreno";

-- 
With best wishes
Dmitry


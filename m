Return-Path: <linux-kernel+bounces-729854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F694B03C7A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 12:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ED8717EAEF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 10:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FAA25CC6C;
	Mon, 14 Jul 2025 10:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OjgikyEb"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C89C25CC4B
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 10:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752489961; cv=none; b=Jq71A+7UfWuSCdsdg8d/uzqzrOlg6x8Xf9ln284C4AxG6+kA98hrUBHw+RV1hpKK4ZUfTi5HnXOaz8ug+SrUhrL8udkM/HrtJrqQdhuEGEppB/jNSRw0WbDdITd6AP5CEdem0Soey/+5nd9NaV9ZltG7B2dv4rlYa7C+DPj7rcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752489961; c=relaxed/simple;
	bh=GsngcRU9ghE95V5sobt8zThiAoxS3bXWswd84ZP946Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m9ZGEI5a40Nx8n+QhX32jDJzihH0ZC/MKSS51GwE+LX86MdHQDK4Cic6hYA6HcnqW1hyMXskOR+Yp+jqyS4NneE1Ad7gb+FXDGUfXXiFRcjihsrs0KjtLwnR/VFSf3KKnhj5sodKTvtgmzf2/4ZdZ6rDZG2HObWlVE1s9MsUiFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OjgikyEb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9iIxP005981
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 10:45:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NvkMX/SfCrQy1ThgqRjv/mjGrsXTIeTx9QKU6pkfYrU=; b=OjgikyEb1mjfDte1
	wtP/hpabasFr7CEflySVgYGJm5q0nSReES76WtUDsAjuVaGWqBaidYYc+ixjFAyW
	B1c+hS+/h5RiQtj9mbC1P/SNWh13uGAsktQ+25BjHlJO2Yp713g1b5IHML/EBtSm
	7GzjdcMCTjs4eqzESvGMBglzsukbovmXSYVcRUR95hJqGozKR0o4Tq+VKiIzkcFL
	d2fSI2y5SYSoWoqem9sJnwPZTiCFACI19+lhnsk1Jfkwn0Ld6LVvaYjNUlAeoL8U
	XKNcKYWWEsO5Gslfhw/4ku1cVVXMLjTp13cMhyuFWE+l4Q/IgOCH250QMqJZNIJm
	+gON1w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufxavdrd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 10:45:58 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ab7077ad49so1388781cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 03:45:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752489957; x=1753094757;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NvkMX/SfCrQy1ThgqRjv/mjGrsXTIeTx9QKU6pkfYrU=;
        b=eZvESIzbYi/Q+f9CwhHMbYS5W4Y0GxFpVMrN9FfhaiHWXsxCkfTpg4kgewZ7NgAbZy
         9+eWBLc933q1h5zpD2HOqF08flgL6jx6p5dPlTaCDgbx8YT6XASOD3d4DfpkpAK04l1F
         +Z9Gjsv2MdOv+O3/7GVLpWnnFvcTycb9qDJs2CXcJA2IoS3tnq5HBWTGj1t/rYCKVuTP
         ICLK56ZI6OtoN3gsUBFz6D3LmQ6s0uSGj/3/DmEXDoav+Qr6UiZAlQrhSBSYFOOFip9j
         u4rj9Ihm/FpaqefTvCAwgfUizZN+rzIcolw3FgFWxpuQurhR/ddc6RjLa7496DBAT64g
         CiRg==
X-Forwarded-Encrypted: i=1; AJvYcCUiJC+uHY2J9v64RKqxK6jJKeWac4rNkNavobhqLdiI7jfh6m70Uc9+Pm2rX/Ues1Waa13rJxdxBDi4Bf8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi/ZukBLIWP8bZkDYsmqQn3L2K0NvZPsxOGU/FbUUlDvWvCfHa
	DxSXZJzJbePAaPmVhZNtXADo7rMTk8ydfAzr7vLmTVc+4sn9e6MgRhokYRNHeY7IJP06qWm/wey
	LhdQ/4yi8S4Pl4Wf5QCAWj+9SaDUal2V1BLue+scS0gkIZfMJRd3n8Gq3T1xDQ5y8Koo=
X-Gm-Gg: ASbGncv2gxdwfdokOj8Kbqmj464AGWLCydOYJDVpVaN960R1h/Tku+D3S9bnwhmhmrb
	7bymcN8o9NO0/3X6Ek9nVipjDcjat+lmF+tzu1MWSvAF2ogC1XZJtL+LTF/UkrFJfy+9huzqN9u
	RxWG7Ze33Z6P5E4I+rxtYQPj+DO0RMSpuUeo140o7b7bURiik8RHBOeSKU2LRhZXkLyb+oAL67m
	XcWwkj7uFU7asateSeW1UCPtUdXkGmfXIHTSB8QfScnDs0kaH7Z6YTrDEy9xYgjPbxXG8iSWuyk
	zx14YHYG9CDO7QawBcSVyDfCFjlMWA7GCevRJX+ZmMM68a/MJpQrEsX1tnHGiKEmazbnTfy8/XB
	Jq/5BIr+7Wk++X0RzY3T5
X-Received: by 2002:a05:622a:2308:b0:4a9:a2d2:5cd5 with SMTP id d75a77b69052e-4a9fb85981emr61407141cf.6.1752489957159;
        Mon, 14 Jul 2025 03:45:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELfiE1hbm9W21cfQCQReZLaomvmcfube3hO9vSP/hdiOgPjCPkHWjuKc+mXLxmKJJITonrVA==
X-Received: by 2002:a05:622a:2308:b0:4a9:a2d2:5cd5 with SMTP id d75a77b69052e-4a9fb85981emr61406911cf.6.1752489956642;
        Mon, 14 Jul 2025 03:45:56 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8294c15sm803864866b.117.2025.07.14.03.45.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 03:45:56 -0700 (PDT)
Message-ID: <e2b92065-e495-465c-957c-ac10db8fec09@oss.qualcomm.com>
Date: Mon, 14 Jul 2025 12:45:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/15] arm64: dts: qcom: pm8550vs: Disable different
 PMIC SIDs by default
To: Luca Weiss <luca.weiss@fairphone.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        Thomas Gleixner
 <tglx@linutronix.de>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-mmc@vger.kernel.org
References: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
 <20250713-sm7635-fp6-initial-v2-13-e8f9a789505b@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250713-sm7635-fp6-initial-v2-13-e8f9a789505b@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ekOae1ToTGmcp4aSljbD6TCzfPrtmGiy
X-Proofpoint-ORIG-GUID: ekOae1ToTGmcp4aSljbD6TCzfPrtmGiy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA2MyBTYWx0ZWRfX6WcaG5OV8dUq
 Npu5usfR9oFu67q+clMSRiWuZhDO49ljxezTD2WzdynOxqOln9IreqkPcMp5TwI2j/xgaGxEUl4
 3yP5lt2C6dgX700hgOg1trx2PK3bJFyztT69FR1UzTOlBglopFrQYcA0/KvdnL5yciaKcwWOWJ3
 axqMc37M6YVVa/EcinWvv4v83LKGVqzd8RujGdUNVb+zSIMtctNA9u9gEklo1yBLvq1MqDmKy31
 tB+HD5HnudfAGwTc75IC7WJ1Kym5BZyh0lah7k8YHxGJVJANla/SjUW6KrLtYAtgT8lN64gtwpR
 QCi5r4CG9ZHjWp2JTqaXanjV3vvw2Di90e8B+kV1vGwMJIbIICNxr3YiYWaJzPcZK1jgv8vvhfa
 d829qq4aEyHiW1pMNae2qxgPiGTFSh9kf4LaY+oB7jTjUdx6OdKqAMBl+5fMjs+p3ddBxXmQ
X-Authority-Analysis: v=2.4 cv=Xc2JzJ55 c=1 sm=1 tr=0 ts=6874dfe6 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8
 a=yhMgBbtfkmf45w4ReXcA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=696
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140063

On 7/13/25 10:05 AM, Luca Weiss wrote:
> Keep the different PMIC definitions in pm8550vs.dtsi disabled by
> default, and only enable them in boards explicitly.
> 
> This allows to support boards better which only have pm8550vs_c, like
> the Milos/SM7635-based Fairphone (Gen. 6).
> 
> Note: I assume that at least some of these devices with PM8550VS also
> don't have _c, _d, _e and _g, but this patch is keeping the resulting
> devicetree the same as before this change, disabling them on boards that
> don't actually have those is out of scope for this patch.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---

thanks

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


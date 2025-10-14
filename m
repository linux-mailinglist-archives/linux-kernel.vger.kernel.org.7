Return-Path: <linux-kernel+bounces-853123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 675DDBDAB01
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F6C2583E18
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3A4303A0B;
	Tue, 14 Oct 2025 16:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KZiL0agv"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD32A302755
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 16:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760460246; cv=none; b=ml7hgtzHYu0XOCrSvYNQwHokV4tU2iCfqfKNPLPFs+OSRaei1pgesVi8yHuiIQowtz7u3cQYFLfTNmx1ZD84M6zpbAaN0Y6a6xzp+k8Ys1YUBXZSoPn1IPWMuH0Gz86wtOfIcQAckwbqS7iZ7+07IPsLHvpFIvK5XuDpwnrhISk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760460246; c=relaxed/simple;
	bh=Yi4u1cEJ00kNWC8UqUDFz10sCkkjIySTrLVt5NXv2E4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N/w6bJtZ4hEXXrMSRf9iG9hfn5wyXYK+xPVhbzZK3pcTMB36qaeSwSSbZuJTpUt2IbsPWFwQWl1xdAFjyyVWuKIY9g016U10sPAPZCWgThSVO4OavXbWEaV02Y+sHHyzn4AEkfxmbh7KbCFgYMUA637em564AG7VGpf5WNeRPLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KZiL0agv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59EG2eBn017790
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 16:44:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mSFGvCoE5HNUgN3XKXThc+wiZj01432MioxbQ4jjWj4=; b=KZiL0agvuPhc9juH
	2QmEEvpdBJVSDlfbt83hvzNjGKPpC+wBKYPpQXUnJGD3NP0jN+muY6Y5VdlCfnCI
	r8Uupq32CZq8NCjZQvxyyTdcMYG089ooZ8VdZ5dRiF46XUh5IVrwUab6KslI936Q
	fOiJoUm1h2EnaeQaFhZocBCycoRLBbyld0jn6ezPqQ7lTDkbNvFf95AMrD9LEowU
	EEWkV8FLc5xRbDEdQGBaxQg6qC1oNnp0A9xSzeJHvgKUvyvC7bEgXhQ6tkT6To0e
	hsyyjkx71fI8v3JOv+hN8XPExnHpeKCPO0sM+cogUmlw5bt1UqRZ/ReTNSbz0ksN
	JktVog==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rw1adkh1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 16:44:04 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-27eca7298d9so245332415ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760460243; x=1761065043;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mSFGvCoE5HNUgN3XKXThc+wiZj01432MioxbQ4jjWj4=;
        b=Lk31Ofx4w+cbDk4vyOMVGHMFDDoiR9j45bOyPkPlm4V+VkXZMZKucRlLd2Htn5PG63
         XXNNFOVtNy121PnvTQC1J/ICJre0f9nr2nVXOj+7r4rh1TMNO9bZ+JpfimhfYV10JFnM
         rFLhyMA+VaCkZYx/1zGLOHg+tHckBwUSfeQEjOfbbrfSz4TXh2EQPNaC5CiySrk+TsW2
         reNODEYDdBVxojyJAOXeXVuPu5AwmB0+01zuLa0YE1ZxMN19wE9ObXUbD36YKoRnspQP
         BnIsqWgHSfEK4Yj1BHBG8eapJ7WyGVuW9PjbPEG2PDYi2CjI3bhdc1HbLQiAn12owFD2
         +/Pw==
X-Forwarded-Encrypted: i=1; AJvYcCVaTdz3UUDY31cMJrDBPDP9myucsJmbORMgtKMKF8X5CU3+amN79fhxFg4NKfxCS0d6z0OP4YZP3hn0RRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBtDg1/dGK7f32+RliDx2Z3Ds10L9YRw2HY/iQyDsbTnnEBHrq
	/rA0n0JP2CvoeYsZvLI2m/OQw1+V+fpn452/iRnxpt/XcbiVQUWYRRRSN/i6WjZwo8Ts7HI6wTi
	uyjtg2916gw++Vtf0G2flWVDV/Iu3u1Ax2XKtpJ8xTYjCIe6t0jZ9joP51sjWRHb8thE=
X-Gm-Gg: ASbGnctarzP5hFevv6cKRfW3jYx/FKiInV5t+fgZIh8EXJOZ7znh0QUmD9hxWnl98oZ
	ZpVzXTjILC7xtkptjF7gKCgXQciHLlTqghBTwOcupt/YYtJ5+0UBhsy2YSbvBKRsd91twGi/zG4
	t9XBndTGhu+p1NHb/N+eb1wE4HYgE+TUlyQSbQyj1cvVawqSIJutMlbR5gWVVnUtbSwVymYgNkb
	KR8e+NWYmHWYVqN9/KyDmI070IwZD4vq67ku6CmBOVUU1vgFRtCna9q13rLWxpx7YKSkZeBS8kL
	Ni3UDVqUqpr+oF10rKUhLE92yyNeC8r8sLpeEWD4KhrJoRmaflqDCtJ2/mECSh4ROmLM
X-Received: by 2002:a17:903:2c0d:b0:269:b2ff:5c0e with SMTP id d9443c01a7336-290273ffa54mr348765995ad.46.1760460243171;
        Tue, 14 Oct 2025 09:44:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAawkG/6RcfxRfHqkLYsh/KH24AGdBHUvSRtJU/JVoXD0EAwZnl6Htf7BxbBAFTMLZRB1zHA==
X-Received: by 2002:a17:903:2c0d:b0:269:b2ff:5c0e with SMTP id d9443c01a7336-290273ffa54mr348765615ad.46.1760460242701;
        Tue, 14 Oct 2025 09:44:02 -0700 (PDT)
Received: from [192.168.0.195] ([49.204.24.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b5288043fsm11617122a91.0.2025.10.14.09.43.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 09:44:02 -0700 (PDT)
Message-ID: <305fb869-c35d-4de8-bdd8-175fccc26137@oss.qualcomm.com>
Date: Tue, 14 Oct 2025 22:13:56 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/20] arm64: dts: qcom: Introduce Kaanapali SoC
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        Tengfei Fan <tengfei.fan@oss.qualcomm.com>
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
 <20250924-knp-dts-v1-2-3fdbc4b9e1b1@oss.qualcomm.com>
 <oitgxbjkjftsq6an6dbtqrb2vfwrpv7tybmo4zck24hzh7p6gr@4gochzskawnm>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <oitgxbjkjftsq6an6dbtqrb2vfwrpv7tybmo4zck24hzh7p6gr@4gochzskawnm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=K88v3iWI c=1 sm=1 tr=0 ts=68ee7dd4 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ptung1i0Z9Z1TijovGblew==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=J-pUodDuUyh6byEKGFgA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: AYo7lR7ojDTFNNkBzKUWVQq1sPoE13lI
X-Proofpoint-ORIG-GUID: AYo7lR7ojDTFNNkBzKUWVQq1sPoE13lI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAzNSBTYWx0ZWRfX+coFmWxs2oC0
 lpe1bI5ns2c+OUzzWNGT2gZXxdkpv1mXfSaRAdWlaftyPiE9aQpsbM88kvuD1H8P1+Ae9PZu7Px
 mJNAohzEhdGxb2u9u+Z8XfV5gtRlejL3F18M771Ewo0xRoAa7oxoQSknKumR8Wj08i8umuNYRuu
 85z/zWybY1X57S/s1NhVKqDb/yWF5Ko6+31ktA3YhWoKa4hBJbAhraowVr5lIsA6SLueSYJi9zt
 KlRcQYRz7bFhobPuVPuuaImsIKjadVs8Lkttw4q1rZHcdFhYo+gBTSvZ2unP4ahhXFSyezm3HMc
 /PquU7kNmVeGzHLf0sXNmd5kj8fLgX2KifJnOZXOAOcrUfJKx7XbrLInqg/jW6XF/yxU/K3wiiq
 wQNkBJwauG3GWgKaleM7WyHcpFFilw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130035



On 9/25/2025 8:52 AM, Dmitry Baryshkov wrote:
> On Wed, Sep 24, 2025 at 05:17:19PM -0700, Jingyi Wang wrote:
>> Kaanapali is Snapdragon SoC from Qualcomm.
>>
>> Features added in this patch:
>> - CPUs with PSCI idle states and cpufreq
>> - Interrupt-controller with PDC wakeup support
>> - Timers, TCSR Clock Controllers
>> - Reserved Shared memory
>> - GCC and RPMHCC
>> - TLMM
>> - Interconnect with CPU BWMONs
>> - QuP with uart
>> - SMMU
>> - RPMHPD
>> - UFS with Inline Crypto Engine
>> - LLCC
>> - Watchdog
>>
>> Written with help from Raviteja Laggyshetty(added interconnect nodes),
>> Taniya Das(added Clock Controllers and cpufreq), Jishnu Prakash
>> (added rpmhpd), Nitin Rawat(added ufs) and Gaurav Kashyap(added ICE).
>>
>> Co-developed-by: Tengfei Fan <tengfei.fan@oss.qualcomm.com>
>> Signed-off-by: Tengfei Fan <tengfei.fan@oss.qualcomm.com>
>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/kaanapali.dtsi | 1320 +++++++++++++++++++++++++++++++
>>  1 file changed, 1320 insertions(+)
>>
>> +
>> +	soc: soc@0 {
>> +		compatible = "simple-bus";
>> +
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		dma-ranges = <0 0 0 0 0x10 0>;
>> +		ranges = <0 0 0 0 0x10 0>;
>> +
>> +		gcc: clock-controller@100000 {
>> +			compatible = "qcom,kaanapali-gcc";
>> +			reg = <0x0 0x00100000 0x0 0x1f4200>;
>> +
>> +			clocks = <&bi_tcxo_div2>,
>> +				 <0>,
>> +				 <&sleep_clk>,
>> +				 <0>,
>> +				 <0>,
>> +				 <0>,
>> +				 <0>,
>> +				 <0>;
> 
> You have UFS clocks. Why are they <0> here?

Yeah Dmitry, I will update the ufs_mem_phy clocks in the next patch.

> 
>> +
>> +			#clock-cells = <1>;
>> +			#reset-cells = <1>;
>> +			#power-domain-cells = <1>;
>> +		};
>> +
> 

-- 
Thanks,
Taniya Das



Return-Path: <linux-kernel+bounces-835713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A96BA7DE4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 05:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABD8917F9E0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 03:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D995211499;
	Mon, 29 Sep 2025 03:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fKkHpMzk"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D82D20C488
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 03:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759116606; cv=none; b=I2L0wDECmKBwCm8GDUZM9ArGRyfzpSqClrBtzcBlgxXymI2GXcdByiv5Sx3eItgYzGrENmOtZ2VXg9hYm3xpVoEKGqMwoCFlxALyF3hKiiowFeorGSfvszsZM/F0e08dvH13+SOD8nnU+TkEsfcLVBHP8qlm7ZKSKxX1dMaeOao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759116606; c=relaxed/simple;
	bh=qLRQ0j2DuwLbARZJl+YwnBat+DKF9jga3AYZvOGllYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fZykGsjSHrnMGh083lu3uK1MHvTaKrWdFILvkrbs3jgQ+Zx+ql/w5zf/3/oCt/Ggl+XVgdYG1BsRJ1FxqrT86M/gDBbWbyBWEbxhXTvySD28LLAF4oEcCeZ8x7kTxRU79jPUkYOLQBNZD6eZ7DQZKmBwT4aySjeGcqe4kMmBUjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fKkHpMzk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58SKeHfw019276
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 03:30:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DwMIGQZOb0C8oGvFUUhsHbg1t7LLLZPDxwcfrbpHQqs=; b=fKkHpMzkYttv3TvY
	ngN5R38cRfc0J+F0vDWViQ7GrFOK+QU5Mck6EgXcaIex4YzaTkU0OTcVRuF6NdEa
	t2VjQvEaZplcKYRz19fmVjE9/Ledckl1e2ar9ClaDXFXxIvw/mpjeaDq/C3jiWLR
	Tb8fdZApMC9eI3aCxfhHx7kldu+GNapD0dCvQoE66ESQrhLWeR5QLA5+esdl7Zdy
	LREYR+LF5XHgeJxqJYH1Yk8t4i+OcHy+p9wNleIvr98SG0KVSVQ4jD8zkEuiPZSz
	YLr0YNPXyaGKOuG8jvuzOhJ+uDbLLy1zrI53RdXvMNpSSlVatgyo5pbVmN17DlSq
	+xgGYA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e93hbhdk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 03:30:04 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-27ee41e062cso35613415ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 20:30:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759116604; x=1759721404;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DwMIGQZOb0C8oGvFUUhsHbg1t7LLLZPDxwcfrbpHQqs=;
        b=lX5iMCXgLS3gRO6ypWJf9ekSUvPBNH1N3hfw+eEvYP2ikz4j55eCO5uzDYEH9kNurq
         jzrdhMoJT5Y5txKbRVqPGZk9j33Je60NRt6oJG3PE53/Vt8q4pd76XmNqKStFGdqIj5i
         fTG47aio1yp6r8joBNWtqcWnqXkZm5ASqzXHlYoKgmr1RhTLHY3Q86LVYd0kxzsrc8A4
         uPGfezVzfQ/jLAYbTTV3JfNd+pc3ZClX7CT7ZavWZnUJbIM+zSlb0ZYcRei/kDl/8opq
         RJRSZSle6nZ4EiWCKgYyri8aqNYd9qn5Yp+gVAqyQXHqeAH9f/tl9RZ+k8ebIizHWEpC
         juHw==
X-Forwarded-Encrypted: i=1; AJvYcCWNUuIPTLN2ucxnrMWWcY5Vmg/tuFLTYM7zYqQYxO5auFmetlIENckjtDaZ198Ir2+IP3nNFp7MAPMl02A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8+O7b+J2G2+kCkHUO70TCIDi8KScgEaBeB4O9y/5j6oLSsEId
	x3Lugk7GQCyeHtk1QkUm4lK6o22gLIX49G6Faz6v/2/66mrafsDH1wk/gpRtR3SFWzxz4eckuY4
	xossbfKctikyb+G7MOs20+X+RyMGBdhBP9EJ0w2oIs1YuSJEX39aLNg3X0sQnIQz9OHE=
X-Gm-Gg: ASbGnctHDYH5TfJ1yzNk7B8bKr3Tf88nqA7kZmr9MhFSPfty0z+Rp1zrDa6YOPDTvxX
	ZivqUL759cmkS2h+jfJaNRAcAwK3n7GZH6f550NEisu+WFki3TwmXF85bq0FsC/7cCnSMHYl8Ct
	sHOx2y/KS8q3hhgp+Fqf861icny3t1Pbc1FcYHzX2LO0RLmsFSbQmrHoUSc/IG9G3uPWS6Tu0sb
	UYj7gK+pskPrpFMujvay5YVI5DVUcd/oFsFoTX77xIikDPJ/Xj6nxuErmh92CyUFA0p5hHEAzP8
	cGq4n6v8rwkx+cX1qxLE5hVBNwmKal5WJslX4WbOBxtGEf6Nl32dtinTu1oGnMy254F24+Cx3m0
	nKNIWOBIT/WElczKj6jDo7xjyEtBE/809XOQ=
X-Received: by 2002:a17:903:41cf:b0:266:3098:666 with SMTP id d9443c01a7336-27ed4a2d5bamr160999685ad.32.1759116603552;
        Sun, 28 Sep 2025 20:30:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHGdaKSDixy6JXuYqOTMae15yp/beh9c1CmAdFxDaU5isUgkg8wD4QB/+I2hTNtSRulDpihA==
X-Received: by 2002:a17:903:41cf:b0:266:3098:666 with SMTP id d9443c01a7336-27ed4a2d5bamr160999285ad.32.1759116603094;
        Sun, 28 Sep 2025 20:30:03 -0700 (PDT)
Received: from [10.133.33.234] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66cf9desm117154925ad.6.2025.09.28.20.29.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Sep 2025 20:30:02 -0700 (PDT)
Message-ID: <5b3e2a94-1f2f-46f2-a72a-79a66238b180@oss.qualcomm.com>
Date: Mon, 29 Sep 2025 11:29:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/20] arm64: dts: qcom: kaanapali-mtp: Enable modem
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
 <20250924-knp-dts-v1-15-3fdbc4b9e1b1@oss.qualcomm.com>
 <pd5zbxclxtrfaukorad6dyld5foa6tcupqeiraj6uxlio6tmdu@gklwmof7n6sd>
Content-Language: en-US
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
In-Reply-To: <pd5zbxclxtrfaukorad6dyld5foa6tcupqeiraj6uxlio6tmdu@gklwmof7n6sd>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA0MSBTYWx0ZWRfXwnUuF3YjIsv6
 ZOdKyL4M59yODDG0dEIBAFqp+hitKVM7xje2NaCajYkMVviX59KRUMcxzHVxdxumiVOyBL0JCe7
 4krcRvPw3HqsQLzAqB4+v+K2uWXw/GbETKkjZ45WoXpwagSxWxs0AIbVtw91U2rgdcmi9opmXBL
 0nhjTu8HD4zYbhWJiIL9KS4hKFPChHksXV/1lNS0E+PjIXKTC4ncoafLbL0cAsMxC+OT9xRVzFb
 uyamfyL0ajnVls4NKyLla2EnbkftvFUtIC8A8RAKxKMnpzVdV1e9K0XUDDLa5DlpIajoaVDEGPr
 6MdQYL9R6LopF4NtKUnpnpKhZcEM85TUrs2NaIBD1ulGmDBvYvPwvqI2KXQzIafrdflhJIYjA12
 WQMehfDlZ/DlGMAPHa9TGqqtdricYw==
X-Proofpoint-GUID: 9dAS30wVVMxzrN6EJgxF-9XqYeynYfZJ
X-Proofpoint-ORIG-GUID: 9dAS30wVVMxzrN6EJgxF-9XqYeynYfZJ
X-Authority-Analysis: v=2.4 cv=Rfydyltv c=1 sm=1 tr=0 ts=68d9fd3c cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=OM6vnnba09aMTPLxVAcA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_01,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270041



On 9/25/2025 10:06 PM, Bjorn Andersson wrote:
> On Wed, Sep 24, 2025 at 05:17:32PM -0700, Jingyi Wang wrote:
>> Enable the MODEM on Kaanapali MTP board.
>>
> 
> Please omit this until you have gotten it to work, and if that happens
> before resubmitting "arm64: dts: qcom: kaanapali-mtp: Enable more
> features" squash it into that.
> 
> 
> PS. The patch adds a failed node, but the commit message doesn't
> describe that, or mention that it is broken.
> 
> Thanks,
> Bjorn
> 

Well noted.

Thanks,
Jingyi


>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/kaanapali-mtp.dts | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts b/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
>> index 2949579481a9..8d1b3278389e 100644
>> --- a/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
>> +++ b/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
>> @@ -1263,6 +1263,14 @@ &remoteproc_cdsp {
>>  	status = "okay";
>>  };
>>  
>> +&remoteproc_mpss {
>> +	firmware-name = "qcom/kaanapali/modem.mbn",
>> +			"qcom/kaanapali/modem_dtb.mbn";
>> +
>> +	/* Modem crashes after some time for OEMPD load failure */
>> +	status = "fail";
>> +};
>> +
>>  &remoteproc_soccp {
>>  	firmware-name = "qcom/kaanapali/soccp.mbn",
>>  			"qcom/kaanapali/soccp_dtb.mbn";
>>
>> -- 
>> 2.25.1
>>



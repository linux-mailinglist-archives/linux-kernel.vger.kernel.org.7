Return-Path: <linux-kernel+bounces-835719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF342BA7E23
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 05:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E63C61899F59
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 03:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56EE215789;
	Mon, 29 Sep 2025 03:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QRYZC0dV"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A69120B7ED
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 03:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759118077; cv=none; b=u+C/fHAjqsQFinRRTcRNEN7tO2APm3RWQ3g/Z/MeJ1mdIKHPdsQlxFqio54TT4YhGjCEZsc1G8sy6G+E1lyAuyxUTmyPVW2lNn8ZM+UQRHrSgjWyNE3KlLvA13G0Mqy3tJCw6RogXyq6yFCqc7vf1Uyg3R1PWmhuw64Hwp6sZ9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759118077; c=relaxed/simple;
	bh=ZgxPc7jFvUfo8e5NtggRb7C8nqmi6ZL8Hl0RkT2XVZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cSl2vmnbdJrs9aqLNdUlUYjr+4de+AI1ExF2H0B2PpSyDcp1q/8nhElqM7gwIFGEOJsV6ulFdXOUPFb//E6fBE7QWn5BoHHQ7zcN0YWQilHBNs102izSZLLVWpV7mNkMCjh5jnzXV8U6ADWdxiSkoPTiqan14xvwQ7EWvZFOlHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QRYZC0dV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58SLOHT3012624
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 03:54:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4greNtdLmdKbk4oGv4Sp7lDz5yvjNosCueZfHE8CDt0=; b=QRYZC0dVYJPuoLpC
	3oHa2TjGFh3mFhhxs8ugjyBxXLp8EaSudWfSwtKWPYcW2JPXodh4pgr2UPeaMSGe
	hx5V8jzyGC3p/gabZbYyhyAAcXJqW97vkPJu5aJ6r5cTVq9E2Fbw4ex8lsAqCpyr
	1UTUz5wiXJjnOkK9Sro4fEYd5Ov/7eg/xeKBbNFt+SP1M7ksikWrGOflxBpNkQ9Y
	xYc+B5DohC5b2oEYRsUeTvxwlR+lEbDjUPdhTAndle7LIqSCv7gW1zf4IpAxsyuz
	T/XmCGdjx4lNS6ZOYzvOLnwktlyQdqGSYYD4iOaVsya/3+YDcA4f2su8SFy9Gscj
	jN3R4A==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e78fuufn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 03:54:33 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-780f9cc532bso3392433b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 20:54:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759118072; x=1759722872;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4greNtdLmdKbk4oGv4Sp7lDz5yvjNosCueZfHE8CDt0=;
        b=sXkifqgcRYvRT5RFez9/a62tb2aJBCxrRo35HQ1eaUgUZF62FlKR2bUPAujaSVNHX0
         AyVM5mcbTb5UMMeBPSU64/7Yqpql1bwm+jOu+WjlGQ6mksAYXUTkKKTBid2OAKFkpqPc
         2tjipGjvYmcgae1Q0gnwpA2ePhNHZnqlTh0p/3Ze0WLorAKbBEwe/asXKGVD2QfjVUlW
         sKji8T06YHI3tx/yruR94UYdTZWHwt7BzWOxzgHVQsYjlOKF0qq05V9L5yxcxya52MZ7
         oEyLRUop2nCuocO6zajJpMsnNjE+3c4r+RCoMbcE8Za2fJbGk2WErp6YfApBjtpxqR6P
         VRlg==
X-Forwarded-Encrypted: i=1; AJvYcCXX+D6Dair1oQ4w//8M73uu7l+QCSzCz2SBAdfmvWyukQOiHQy0LJOoU3JEi0F8cQ9+oDBawOQdf1KCjf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmdBCT7FclfmG+9J73v04kIr27uavWIUyjghko9tnRfAhk1zOl
	u37UQBKtYZXCX6lKnWTwoVqCUyCslo/gUgYq1GMYOK2mi2bqCpSawJvrQ2QaMxp9HmCILmQGxYJ
	uJHEAxsvXk4AWc+28mZpFM1JMTve1gseaW5FRdoxKV2copHKw24c0ptxDqY0E5fAJc5Q=
X-Gm-Gg: ASbGnct3iK88PPcitFUthm//jQmlQYqVmCFGuqk3lgEBcAHTDTA3plWYRbcR/Wc7pJb
	H/fsg1bFY+l4MrL+TmJOPVKYipJHBBRs5O+sixEMaPukMd52VG6sQtanj4lvDQ0R5s/g5GqUuwR
	YHVEEPgj1eVXC2KxFJkcJIXIM+0twf6chQBEOvJ2qMS64pCjv3nXVAfZ5YjXIFKe6EkCdq01F5K
	df2+vpbKnNNE41tgCg6yZukIi9dDExnhqPDpmIxeY4yWHj95+6x1NnJada87I2Y7e8WrytV2Awg
	MWUf1UZwXGCLAy4MvVGzaEM+0V5xXtsziKksyABLgltGdwiiJCEZD94SiZ010Jjj+II=
X-Received: by 2002:a05:6a00:2395:b0:772:397b:b270 with SMTP id d2e1a72fcca58-78100fcf632mr13590987b3a.10.1759118071845;
        Sun, 28 Sep 2025 20:54:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2r20Nsx0mZ0boHn8hMxT8AW4ANlluUVZDARoW/YbMmCXP9ImTSzIHu1YYxNmhr//RZpnyzw==
X-Received: by 2002:a05:6a00:2395:b0:772:397b:b270 with SMTP id d2e1a72fcca58-78100fcf632mr13590974b3a.10.1759118071380;
        Sun, 28 Sep 2025 20:54:31 -0700 (PDT)
Received: from [192.168.0.195] ([49.204.31.98])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c279f8sm9954388b3a.98.2025.09.28.20.54.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Sep 2025 20:54:31 -0700 (PDT)
Message-ID: <a0a70337-6474-4568-9006-dda66371fe7e@oss.qualcomm.com>
Date: Mon, 29 Sep 2025 09:24:26 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/24] arm64: dts: qcom: glymur: Add display clock
 controller device
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-22-24b601bbecc0@oss.qualcomm.com>
 <3c886104-937f-4d2e-ade0-fd525d56dabc@oss.qualcomm.com>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <3c886104-937f-4d2e-ade0-fd525d56dabc@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=DZAaa/tW c=1 sm=1 tr=0 ts=68da02f9 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=YGGbjFxyX1jBzPa45jwK0A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=kGSp5kWzczO3mCTFYtUA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyMiBTYWx0ZWRfX74/24AaiACpm
 GMeBHeJYIYZ612r6dMWXar4EQ79qcS2eCU0dH3ww2hYJADlEOTJB/M0ZK6aX4IdTZlh3yLoxWS7
 stxee2PQpE2vI2gEz9CW1yqd/2wKDsH5uiuXmG4sZhTVEg0E/wNiTyai3hU1pdXHa56Z+N5naSk
 1UwzoI+dDbaqVavjr6024FGQEiqqPrfHKlQoNd/gsYYzjPmg7cvYYxI9vahIVLlHi6QvdtGzWzK
 w/XGTktdkKvxSe96iQpQiw5ZkojexGY5o3Z/6FqOYT1pqVeXAr/rKa5VAJV1OhWBtV/Cb2RSluo
 UU6gzce85BZmH51kCp+f8qERM0gpVec33Z/3dCNMXogup0j8HvkHAn3v/N/VJ9bM+43Rs+hKX9k
 nrpk8ce6yF1xML8/MVlIJnP2dI2x9Q==
X-Proofpoint-GUID: CJZ4AQTLTvJiXqnVvxIIbpHXQOTjbt-C
X-Proofpoint-ORIG-GUID: CJZ4AQTLTvJiXqnVvxIIbpHXQOTjbt-C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_01,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270022



On 9/25/2025 4:03 PM, Konrad Dybcio wrote:
> On 9/25/25 8:32 AM, Pankaj Patil wrote:
>> From: Taniya Das <taniya.das@oss.qualcomm.com>
>>
>> Support the display clock controller for GLYMUR SoC.
>>
>> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
>> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>> +		dispcc: clock-controller@af00000 {
>> +			compatible = "qcom,glymur-dispcc";
>> +			reg = <0 0x0af00000 0 0x20000>;
>> +			clocks = <&rpmhcc RPMH_CXO_CLK>,
>> +				 <&sleep_clk>,
>> +				 <0>, /* dp0 */
>> +				 <0>,
>> +				 <0>, /* dp1 */
>> +				 <0>,
>> +				 <0>, /* dp2 */
>> +				 <0>,
>> +				 <0>, /* dp3 */
>> +				 <0>,
>> +				 <0>, /* dsi0 */
>> +				 <0>,
>> +				 <0>, /* dsi1 */
>> +				 <0>,
>> +				 <0>,
>> +				 <0>,
>> +				 <0>,
>> +				 <0>;
>> +			power-domains = <&rpmhpd RPMHPD_MMCX>;
>> +			required-opps = <&rpmhpd_opp_turbo>;

The SVS level didn't work when Abel tried out. I will check with Abel again.

> 
> Really odd!
> 
> Konrad

-- 
Thanks,
Taniya Das



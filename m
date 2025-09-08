Return-Path: <linux-kernel+bounces-806224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E5CB493D3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 840A3441E78
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431E530F93E;
	Mon,  8 Sep 2025 15:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fIovl2uI"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54BA30F812
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 15:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346052; cv=none; b=edfymsBpSklTWRVQRPB7GE+8FRHazWYaWwMcoSHuqTBQPcxaKP4JBxfFB958O6k078H2SIadNztgHd8EX4kQ1Fh7z9tMmwlg33mKtJvmUSw7mPHfOJyEn9rD6joVrB1Grd9TZXrgk36NRr+uuT1/j8cMGorlNOjzbjQlb37VLjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346052; c=relaxed/simple;
	bh=XQXO+Tzhlv6Nwt4EWVGJNi5s6zZrQnUFejRGMlJMDwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n+gKDNvcFNW9mnMWjy3RtN92jtdWU4WMj+MqDXnmjgOBiniedPiPZp9wxnet4EdIUqprhSRWmoeMQgmi+75PX9ZI+tp7eWeWWm0zW7agIcJm8gdjvGldTe7pkP/IvMJ9QPgkZnRNBMd186rIEFmW2uC0OBhTyszqKRRB+FYK/Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fIovl2uI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58890jQv028663
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 15:40:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qEL/f0fiN9vSyXycSIa4kThderOPszVm82CtrwmVcn0=; b=fIovl2uI5mDRcrPg
	lVdvcU+/5wOC93/HcguaLdwltpugxYyabIvW2WHRMcm0fpDO7TIRSkJI3eC7gEHV
	9HXHOjq5KTuutnRITjdDRSfqBhcHsQLU9ujIiQ3/HCfKbe/LJ7YHpoqvOOzkmByt
	FJXPovaCzpZgSKZ+ZGuwV0TJu135QuX8gnyMhlmw36oiT/+UZZ5apm6QxNhBSREA
	aHX8fgArVYXXVwRGtsdouDhhuvLdZe5a29vSnccOhWfYr/gkG67lj/gzfbDCIP98
	MXKMm/IPYMvimjpPsWvCcVcKzGVodtBlnrb1c6WHb2s2hX7l0hw8JPWIwufFVZSU
	ReEtmg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490c9j5670-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 15:40:49 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b600d0a59bso10824161cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 08:40:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757346049; x=1757950849;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qEL/f0fiN9vSyXycSIa4kThderOPszVm82CtrwmVcn0=;
        b=S/IR08lQZjdV5fx57caUKSfp4QvVFCAFFzYtE9aI4Ihvb/6IQQX6TOQ6mRWA868e7Q
         V4xrobOkNOO8DkH0rNaiQW4jYbJBw9LpsC88bZ4TNx7s2gon0bsP4iQoTWsGnXgEAPzq
         T9RbKU6OOPMkJRQGSs0A/g9Y36OHta9bFcRjm/+TPBb+QenIO1bDkF+BAlJt7DruDtmg
         0kUYcMLMOZ/s0hZSc8sPj3zxeILr8TTJeJKkPY0+AqWF1Q4TRbdg3eCDt4gEndJJZl0g
         2JlxA8wOQ9AmiydBqUJAPokmedc95GKAcHUFP5Om+AQDUYeefIjdnUSs2luABwudGK3/
         yBnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhjCfpFpnQSsMmo+gSypJ/bikuRc7kopHTiBnZe3lpfpNlWh3UCRfNV/R+rS6yQ1YJ27QB6k9G8GH8K+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVuo8R+PBa0RG2yW4CgBlIDMToprAzowchYZ0JMez7aGH4wmgw
	GR8eqXm02hLLYib503yWrsbM5qIxnqnOSrz9YVCqxU0KJ3lX6j8x8YH6QaC7bgoqaqTqtN0OCwC
	dff4oDniIHohpogglT8Rxx/Og7H7wUtPjVKlKV9ZLenXdfuUHjvsaqCgX0sc0A1AiSKo=
X-Gm-Gg: ASbGncsA6eO/jRZ+ntlvdBHoXZgMhWF0BT9x3gskLq3VjIl7nsnDAXEA8y5Wjw7sD6D
	moIhU3N2ATjx4gqeQl327WuZedeiNlB738GnODW6xnlsOvos3j7cjqxZpF+o+dcW7RO/IX+/dWi
	6jCgOF84kunvzZScVRvws8rKociGWS2G4N2a+YgvFJotbAi5eu+KZqevnNs8dpp7W415lItpi42
	uKM4SlbsSKpmx6Hn6aHaE9rs4vJ7YBj2yJQfs0GUlAUSr7/NOgdGLqBA7SYVMNCeA8nVxaAHe6C
	xygqdC/mND4Bm2aOvmEQ9aJb1AcXyU9dz6q+u5AHdBkBSDa5KcVNvlx7pZ7NjK8KkxB6n55yiJx
	rYQ+Bd7AmQf/0z+ZWumMjiQ==
X-Received: by 2002:a05:622a:58b:b0:4b4:9d38:b93e with SMTP id d75a77b69052e-4b5f83860e2mr57363671cf.4.1757346048715;
        Mon, 08 Sep 2025 08:40:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSQXBBnYcaEbWaiBHeiamyobKP1WAkRxcpeUav1deyl3r76u7Rjk/xxH6krW0KNLxWuUfTog==
X-Received: by 2002:a05:622a:58b:b0:4b4:9d38:b93e with SMTP id d75a77b69052e-4b5f83860e2mr57363431cf.4.1757346048119;
        Mon, 08 Sep 2025 08:40:48 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0438102debsm1819568266b.66.2025.09.08.08.40.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 08:40:47 -0700 (PDT)
Message-ID: <6a00646c-2b25-4193-8db2-157669817d61@oss.qualcomm.com>
Date: Mon, 8 Sep 2025 17:40:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cpuidle: qcom-spm: fix device and OF node leaks at
 probe
To: Johan Hovold <johan@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250908152213.30621-1-johan@kernel.org>
 <20250908152213.30621-2-johan@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250908152213.30621-2-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMiBTYWx0ZWRfX93ddJYctktMS
 LJZ9PmCtVJPYJ0VcaW7RBcTj+yX5fZHscDRlCM8LrlCiXdWr8k3Q+PncA9Gms3Zj9cMx2UmXyVh
 of2JNZXKwV3cneSXNyNje1U6fMiz7EZ/Fc5x0QtQlxLG/+guFwk1Zjl0dANkUSxvuP9uUX89j4E
 G7HE2NnC0yl/K0bpS3LfuUy7viRJGX4PCm2Q+8q8sN5HpUECHW1fwy90/LzC7dQVb5YWup2wG4Q
 CSTtI15fB3uo0PtQeZ/F4VwcBgoVB4UN8nMOQzzw68CC9ZIBAJIAoQUYGMklhstk8zU9PiI6OTC
 zsHnczTFa4pI/KXeimhEcbky4HRvvUasufBEyksdwRYRrGVHihr33NP1HOssA3jKzwxW/4xiJaQ
 u2fhZ0XP
X-Proofpoint-ORIG-GUID: iCFR-O3m18vm9L_bCzhqyuRKb9TR8rQh
X-Authority-Analysis: v=2.4 cv=PpOTbxM3 c=1 sm=1 tr=0 ts=68bef901 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=tVI0ZWmoAAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=LotNk_tcR8CuMVeKJCUA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=dawVfQjAaf238kedN5IG:22 a=-BPWgnxRz2uhmvdm1NTO:22
X-Proofpoint-GUID: iCFR-O3m18vm9L_bCzhqyuRKb9TR8rQh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_05,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060022

On 9/8/25 5:22 PM, Johan Hovold wrote:
> Make sure to drop the reference to the saw device taken by
> of_find_device_by_node() after retrieving its driver data during
> probe().
> 
> Also drop the reference to the CPU node sooner to avoid leaking it in
> case there is no saw node or device.
> 
> Fixes: 60f3692b5f0b ("cpuidle: qcom_spm: Detach state machine from main SPM handling")
> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


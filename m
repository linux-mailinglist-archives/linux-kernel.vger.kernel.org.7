Return-Path: <linux-kernel+bounces-888159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F5FC3A050
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 11:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 73F754FD135
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 10:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9330E30CD83;
	Thu,  6 Nov 2025 10:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ifP91DDZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aNf4coyy"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E71C30C345
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 10:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762423234; cv=none; b=ljhg+5CY7KLhAZOamvzdS13N/fntyYigZkhnoO6EYMY5qbSEmeeK4g5T64mA9Lpx7jQp4Mmp1fULc0QGYMYfUbM4jYZHh6F8+ryj71Az+ryXbqPXB8Le2p2famsMjf3XDfDmtGdQOEwIR0VP8ZoYyrloY4shwRDAHKV3bsQeON8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762423234; c=relaxed/simple;
	bh=wF5SPjX6L9XXVGJFNxEpnsrq3oXW6/HgW/D2cEkYYMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PYsXf63v1cRFtbn9G/R48IH9fP5BnXvZZ49lu/EROsUaHbWeouQrjEs3KeUJ0vVgBO5MObONGRemnh08KcMp2Nc5iCoyRZw5p1cdlO5tBODpC9Z/8X2xAu9jYe86UBDMKZcw4E/tywFJixoqelNM+FAL/+k4hg53gDEe1DnFCuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ifP91DDZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aNf4coyy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A69XXfR2798819
	for <linux-kernel@vger.kernel.org>; Thu, 6 Nov 2025 10:00:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KJ8tFZD23D6pv8VDozl2uS2hfghTxj2rEDZoN/LKKwM=; b=ifP91DDZy6iM3Abk
	cP0JBiKwjDD2eeI4W27adRrP4wcrrtSWDVjITYS5lezn4GN4DkgPbkZVpXlr269Y
	8Pj1a5P66FtMEo9NTHHIGTCUcsA/ZRh5K8FIjSxUn73dnQGQob8PBeRYuDgYQCyt
	5BqyNMWbkL2T/rMT3f1hyrkNY9andSN2wyf0E9gyHwZ3eTmQzMLOfcRAsdM7k39P
	aAGzvKmhxTKcaxjUWJr7IymAdvF/v9viCNyVTvQ9Nl0nmBishHhotMF61nLZYa7R
	bczqwXrHwYisCfFVKAHWW3aHCjnfDl5DAbQxNpli6tCuwagTU6NQnxXsM9xJN360
	dpsjGw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8hytsa7m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 10:00:32 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b196719e0fso21916985a.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 02:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762423231; x=1763028031; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KJ8tFZD23D6pv8VDozl2uS2hfghTxj2rEDZoN/LKKwM=;
        b=aNf4coyyOHtwbdUmh7WvdkeOW+CwphHarwJLmZbgom/+xKC6g5kV1Tg9uSfT4Kn1y9
         Ex4qP2TMeTPrJfPWiHIewoGo3PfTf7kRBtryn+bS7+PaevKxjffVVD2JiTHMSYRaoWaG
         flnGovewhAY3lul5nQs43TWZiQaYtI+rNVGJA+QZ6aRAHjhFSIjXF4sLgL5H07eJuMUb
         dHi/6Ont9RhWEVJ5r68qXMxJoB32TQMkB4CMDNv+FT1FJQhfLkCLF63fgxamKHKolfhT
         w1KuKu3RPp5CqPU12XFYj7kY5pqXCVtGdsVHExHTuK5kSHcL498Asqs9eQ6/y/uk5Gmx
         wxLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762423231; x=1763028031;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KJ8tFZD23D6pv8VDozl2uS2hfghTxj2rEDZoN/LKKwM=;
        b=WNqJlaOUQC6uAUlxLbQvi427wZRdeXXuNkDdsvC81e/oO+oRuQK0VXxBDwvkzwV3p/
         z9Hnx2pusBTpx7jBC18O1pF/rxdJVmV3vC81UWKlLQyuRG5YeV0hPivPiCZfdpCsvELB
         3WnLAz7bJUICLFVXmjZO913dOZSWFH0xfkRa6ctUd4MHcPGQS7cueiRKxmQFaJP3/g47
         UgUASP5uShGHmR+CyEvBU5lrifQrMTDxG6Cj9ZGd3hJoQmuGNXH7IIwgSEtKDkYXyLjy
         222IKTbq9RvPegPgwRmg0a0vxgexMwf2w04lIHjBLFN1W2TyNt6OjrphBH/oLenbwBgO
         44PA==
X-Forwarded-Encrypted: i=1; AJvYcCW8Lh7IoYTVlTSTuBZF4aFjHGrXwKjT7errsKYvnUFCtAoWMq+BQUuIsO2ZeOgQU+M69GhZflM6IgTf9S8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeHmGwX3h++H+L7wD72dkgflbdAWUuaanu59PDwqOVYOd7uxxa
	KVuvdP+H6Hu2OAiwpMNG10ZbutOn/LHMytDaTSmeokZBPgPCEYxC2k6U4VAgvveZ01uhzCRA1Sq
	Dzrb7wSQLn5R6XjzoSVfsmfwILycRf6I0xR2iAWP9tsbZBncqhlcTxa7PN856W3g+QK4=
X-Gm-Gg: ASbGncsRCTBRAgVyuJ8TihC423c6EUJhm+ChhTn46xiz/RqFCR3iao/7AX0Pth4zsxS
	2DkpECQtI57yCsXEgd89OJiYqUCnvG4tGN05cEljh5MNsxi8C1q8GMnknRRF+uOuqfU9oeBkGaE
	NbiFi/XhGNgWTkSeCfON8YRqP5uZwSid944eXuLvwClJjiMahUDukk5tDnqYzIqpD5LzY3gx/WH
	fDL9ijrG83YViqlAfJitvwa8+be/WNg1u8h/gEsKYaIasPDg16U4qX3Mu1ZGFbSwq1o04noYAQ2
	tfaaqkdNQ/CYZa/iXBcCAyNfMUxulgMIPdMZBPQKdZxfTcWIrmfwMklwCm17G9WEXQOheovTpH5
	O0HlI/T/gM5l3mfeYJYoshXeNQoX2eZh7h2BZgG7taU5nSOVhyt7Y/hd/
X-Received: by 2002:a05:620a:4693:b0:8a6:1a5d:7aeb with SMTP id af79cd13be357-8b23748b481mr153973385a.9.1762423231546;
        Thu, 06 Nov 2025 02:00:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4uHm6Ex0yCpTYXqQ/1sUu8JUANR193GdIulgFOc0pBc4KTLDo406B3DhFtvNvYfqaZzJcLw==
X-Received: by 2002:a05:620a:4693:b0:8a6:1a5d:7aeb with SMTP id af79cd13be357-8b23748b481mr153969985a.9.1762423230911;
        Thu, 06 Nov 2025 02:00:30 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f713a68sm1456023a12.2.2025.11.06.02.00.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 02:00:30 -0800 (PST)
Message-ID: <04ef8cb6-8d0e-434b-adee-b7e32a6e0b8c@oss.qualcomm.com>
Date: Thu, 6 Nov 2025 11:00:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: codecs: va-macro: fix resource leak in probe error
 path
To: Haotian Zhang <vulab@iscas.ac.cn>, srinivas.kandagatla@linaro.org,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251106075055.555-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251106075055.555-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: HM5c0XASjpa9y0bvzP2b4EAaHAZm1v2-
X-Proofpoint-ORIG-GUID: HM5c0XASjpa9y0bvzP2b4EAaHAZm1v2-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDA3OCBTYWx0ZWRfXxLotjJ8Ehfx1
 JDaebFgjuLp/oUfB7b5LpR/j2XnrB1up5GhAc9f+1sEC9LvM7Vgu/2svBGLyMd9P9Mp8YNbes1z
 wqkUg55Kp+BMlogY7Kafxcw9B58I8RsiRHQ1+vEF7UV1iEjx7npIsmy/DlcCxGBC06dYts4klC3
 ZkhKx/giuxDiEaxyD7An+315qTJxtT6vVVCir9YPs2CflZW8GvU3HsJx+eMX2mJ/SkHvt8UQs9P
 QuEc2Z64yRJ2S95789LlNx1v6PUbx6V8QP6ONbCJIqCikhoN1bZzH0BcKOArVDNd3ddQ+TURWgb
 /N0IpdThrEl0gMOMw1pJjvErbw4nTMQyRhsFPw3GR3xz+1JhcexkRw1AxBteRwNwI07FH4HubJ1
 e7HDfozkPh0SD90sXbxK4cBg4rN5PA==
X-Authority-Analysis: v=2.4 cv=X+Rf6WTe c=1 sm=1 tr=0 ts=690c71c0 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=_CcdfDJzPmikts8YXegA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511060078

On 11/6/25 8:50 AM, Haotian Zhang wrote:
> In the commit referenced by the Fixes tag, clk_hw_get_clk()
> was added in va_macro_probe() to get the fsgen clock,
> but forgot to add the corresponding clk_put() in va_macro_remove().
> This leads to a clock reference leak when the driver is unloaded.
> 
> Add clk_put() call in va_macro_remove() to properly release the clock
> reference obtained in probe.
> 
> Fixes: 30097967e056 ("ASoC: codecs: va-macro: use fsgen as clock")
> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
> ---

You can switch the clk_hw_get_clk to devm_clk_hw_get_clk() instead

Konrad



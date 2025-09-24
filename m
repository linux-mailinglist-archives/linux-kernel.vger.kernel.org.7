Return-Path: <linux-kernel+bounces-829937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F00ADB98467
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 07:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B19C34C2E69
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 05:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE221E0B9C;
	Wed, 24 Sep 2025 05:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="euPI5jds"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059B7146588
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 05:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758691193; cv=none; b=WEpAhIoBvE1O2JyiAbXalJtjpPt5RfKvbsJcxI21u1afvphsdzDv/bUM+h/tD7aV7n14gMwDTwykjiWrSeMau9uEFlFbJb6Ia+CitAxMAItPGcWCZeM21n/YtWhBRW4LelGXzZ8UX/IlPlFYqCnM2pMqFrvcjrCaGM8waZXZe5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758691193; c=relaxed/simple;
	bh=gDMmbJDin8g4trp63KWsydkj4NL9SFdV1cVqYH2HTik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kpyuI5be9f4xqHvB6IAwYGkWWTs5WzCvTrnQjeZqWXVh/o/Oaz+y4ojWI9QVa2Yn/LvajIGNuv6ZPBLRuSKimjGmYn6heWZPvMe9hhxXB7g9sFX5hwYu3sZ+An/mStUxUCoRZ/yDbBFy6HLiTfwl0lkwT2iwpXbxdc6qV+zYEPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=euPI5jds; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58O4iblJ025572
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 05:19:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bbgjHGvKyAAeJ5oZigyyvCPSQIleZStCFPhpqS2fX3Y=; b=euPI5jds/e2iBiDH
	G3h92CbH51mWz+y5okgR/lg4qA+jGFwCsYZRWpNL/yF8LipuD9Ly9cFwmPzIbCkb
	F1B1OJjaXHivRvf+Vpxiv6Q1KnzFoMUfhmMjllfVwP/yG7rAeycqiyP5P6QjazAE
	W2L2GbE0LtXkhM2VeNVT/X6Gmum/AxXW8euQ8IFKUU7oxSfWeVadbtqljv9RLB+D
	NgbAG06uGhxXtk72YDevENGFsDsjUWLL5ADS4T03h84EJBokKDXpIA/0auTvepD9
	cMRSZ8+lvRM8X+ecFicNaZ8zh/VmiAqnHe/ztSv+17u3E4qHt6dpLMdzuRIqBLaJ
	sOTPuQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hyeudww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 05:19:51 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-77f5e6a324fso1768017b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 22:19:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758691189; x=1759295989;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bbgjHGvKyAAeJ5oZigyyvCPSQIleZStCFPhpqS2fX3Y=;
        b=V+D1ycCsOjydaCQ3U92662Jjb2OzysJ1ieYm7jCsoma72TD2WbyFtT+Xqhxz5UyZT2
         uSxBnYUpRqnvVbYHifKd53X4TIaGgmTbzAMLlJV45kVviV4nbhPIiWJYWO3DTBXSLN+d
         4QS201hvSp2f2BCSuy2TEVDkrxGgsc0FR8sBNB59zvx5h6SRbb1pJtswSCM3W9X07+W8
         D6clqRZrNTjs8O61K3pnNN5FB6kBF58/iZf4y5LFsjzwv1ToH3+197r6ELNEN7zdKVI7
         t2Tdx+QBVjM1aPk2ojeo6LliZGkWM+sllST3QGFh4H+pDamIFUM6b7nyKBr9xRKiPHbY
         N4bg==
X-Forwarded-Encrypted: i=1; AJvYcCUVaOcoPKZfgQhaVZEQ2VSxOZOPoBdHnhHrXYA7J9WmtSP4BhLnuwW/cfqkRr+K0qh44ED14fnBVaLlRrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTJINichnlcF2hpuYFwd7fwN5XL0mGLM0Ysbkw9saN0E9nDjen
	nwjbd1dbDSaSwKmr0qu/2g6hTXQA+5S25SS4KpR0h6H0iEoK65tE7IYvDUHWMjk3AmibPcQwPQp
	7zOHNG3YGYQUqDW71oeTxuNEbk4TtQem8fvJxMe4WRPjPDOxn8ckArnsBCAqD+oWQSyM=
X-Gm-Gg: ASbGnctp3rJr0cqIafHv14mCQ0wiI/3z8lm/NKXeOwpJONnG9wXFeAt9sbxDt0qyV6K
	KMNLpGbLRxJuVsPFwXjlLE3MSmXDEJpj2AwC+S+j423q71M1xPKvWDGinc+UBLFiJqcs5Oa4TcN
	hOCP4q4yVGRU78qTAD00XHmW4v7cmHl/3gh879jW7cob1TGgKgSmYr6oiGccp4pQmTeodICNlfE
	3GNJ8JkP8ym879PycUQ/o2CIaqwxJxxB3+NzBhfDt2d3DoGyzaJxzS0tVaI/Un3ocLSbImWq0HG
	8ge5/xImzD34Hl0ymrUdEHo1vYb76OrrO6ej6u5t8lcbsZ4Z0Z9+CZV0NSJtwhme2Zg=
X-Received: by 2002:a05:6a21:3290:b0:24a:d857:fcab with SMTP id adf61e73a8af0-2cfdaf0bcdemr6339902637.23.1758691189312;
        Tue, 23 Sep 2025 22:19:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKWR4642Yw5maqKFG82ykSWIdzBhL17R+UP3C4cLfdONnTKmSW6HpeHdooGU/0F96sm7uhPA==
X-Received: by 2002:a05:6a21:3290:b0:24a:d857:fcab with SMTP id adf61e73a8af0-2cfdaf0bcdemr6339872637.23.1758691188899;
        Tue, 23 Sep 2025 22:19:48 -0700 (PDT)
Received: from [10.218.33.29] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfec3dadbsm17384435b3a.68.2025.09.23.22.19.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 22:19:48 -0700 (PDT)
Message-ID: <a0a83512-9eeb-444e-ae75-cdb877076a45@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 10:49:32 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: gcc-sm8750: Add a new frequency for sdcc2
 clock
To: Taniya Das <taniya.das@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc: Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250924-sm8750_gcc_sdcc2_frequency-v1-1-541fd321125f@oss.qualcomm.com>
Content-Language: en-US
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
In-Reply-To: <20250924-sm8750_gcc_sdcc2_frequency-v1-1-541fd321125f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: mdyBy-KrVDgoKJ89eJV4XUnfQqM0b0wI
X-Authority-Analysis: v=2.4 cv=YMOfyQGx c=1 sm=1 tr=0 ts=68d37f77 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=aG0I0WmwaBOL6KmX638A:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwNCBTYWx0ZWRfX+mvTYHYM1JE1
 4zOQkPKDEu7678Lm1cVvQmKmsxvwSZduo/+vxzeij8sk9OfE5PukoHoAz5Vxw28pkdvYUNydJ1y
 CcRORoshed0S9ln2ZL0PqOP4xSac5YnzTNC36906Lkb8XoKM7O+OmhTLruObqBowj6ldyDb621+
 8Bo2P7em4RWIStTopC1pRTmpa804pq2/bKPGThhRGqRnvbZJRj5k0EaBOb4OrhRrrpj4oX9Lbvr
 IYu5i5lCh9mGel9fJdBSLWu6xumk7WduYIIQPTG5jYA8ZdUxQybKFu4SEFICHkx0ck8qhiYgmSs
 O+PSQuyypfJW/f5nC9d2lKsNhiU+eRoLzGEhyuwSZ9WP8qOFfyKtCrQxlW7NvAxNp8OzF+1UzGb
 AJ3mWZd7
X-Proofpoint-ORIG-GUID: mdyBy-KrVDgoKJ89eJV4XUnfQqM0b0wI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_08,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200004



On 9/24/2025 12:08 AM, Taniya Das wrote:
> The SD card support requires a 37.5MHz clock; add it to the frequency
> list for the storage SW driver to be able to request for the frequency.
> 
> Fixes: 3267c774f3ff ("clk: qcom: Add support for GCC on SM8750")
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> ---
>  drivers/clk/qcom/gcc-sm8750.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/qcom/gcc-sm8750.c b/drivers/clk/qcom/gcc-sm8750.c
> index 8092dd6b37b56f4fd786e33d4f0e8aabcd6ecdfe..def86b71a3da534f07844f01ecb73b424db3bddc 100644
> --- a/drivers/clk/qcom/gcc-sm8750.c
> +++ b/drivers/clk/qcom/gcc-sm8750.c
> @@ -1012,6 +1012,7 @@ static struct clk_rcg2 gcc_qupv3_wrap2_s7_clk_src = {
>  static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk_src[] = {
>  	F(400000, P_BI_TCXO, 12, 1, 4),
>  	F(25000000, P_GCC_GPLL0_OUT_EVEN, 12, 0, 0),
> +	F(37500000, P_GCC_GPLL0_OUT_EVEN, 8, 0, 0),
>  	F(50000000, P_GCC_GPLL0_OUT_EVEN, 6, 0, 0),
>  	F(100000000, P_GCC_GPLL0_OUT_EVEN, 3, 0, 0),
>  	F(202000000, P_GCC_GPLL9_OUT_MAIN, 4, 0, 0),
> 
> ---
> base-commit: ce7f1a983b074f6cf8609068088ca3182c569ee4
> change-id: 20250923-sm8750_gcc_sdcc2_frequency-debfdbbab8b3
> 
> Best regards,

Reviewed-by: Imran Shaik <imran.shaik@oss.qualcomm.com>

Thanks,
Imran



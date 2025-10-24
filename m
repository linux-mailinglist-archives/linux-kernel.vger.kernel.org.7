Return-Path: <linux-kernel+bounces-868277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 321CCC04C26
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4275134FD52
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE0F2E8DFA;
	Fri, 24 Oct 2025 07:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OzdvsgVc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939F12E8B6C
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291537; cv=none; b=aPoeVWS3D5UQd0vZzMRHqxe6Kk6s1gmffYa6zgIgGFmOupkK2l+1oZXXK1XKNM6dLSyXuP+3OdVh5+1ESvcQmsBPLbR2FowUhQfV2ClDHhYhswsqz/L9oIaoIPCQw3gH89yTtK15AmMllNax3XM3iCCTiNgrQJR8yO6PYUPeYkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291537; c=relaxed/simple;
	bh=tiNmurCsXGm9dhg4Nmmt2OTRfw3heIDQmN8jUvQXTjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P8dVXt51Cr9nxabr4W8pEBe7eYC1efpK5/vzgls7PfLJcFf0vHY2oqSaRZDMjPjmmEmNRtA6V5FqvBfHUqLez0eY+awY8r8S2hMKMRhyr+kOU9SqllJmz1PvOwmrokQrxCOVOaR93+qNPAKfRTSq8BJ5pMAxoZNFeiCEbjZB4oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OzdvsgVc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3FR2X016081
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:38:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	my9U8pjQuu0h+9sW6zK2VocRF7KfxfmwPaDP0afFg+o=; b=OzdvsgVchTe29L02
	nCG2o2z+NqzjZo7AT2grwO7uVBpNicYdIr6JNq0gKWrQ5MN7MYJfZBdmk00NlZGZ
	G/qtOM89jw/J7B3F7/t//ES5D0hmixHqxezUR1Jk3cdt1O5lbjDaflKGK8nkoAuR
	qEc86dMRQ+otEV43KgBx6SUzTSFcjnExTJpJBSyVVeEX9KO52KpFBpCjHW5EguFP
	6GRlrlTYrDb4eEeWG7kognhvc0+D1d5Gge+2jpCM3HqsP0hY0Xjhdsp6TK+E/4FZ
	j0jLQW1D//iriR3Ua85RSaK2KVmbINi0AQ/tgJvejwSw/qZA0U5pSXMcdVs9bio+
	Smft3A==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49xkpsgt1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:38:54 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-87dfd456d01so5178756d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 00:38:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761291533; x=1761896333;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=my9U8pjQuu0h+9sW6zK2VocRF7KfxfmwPaDP0afFg+o=;
        b=W25ixVcculgb8qAvpXtbEH+5KnvzhLwx2ZnhYbxGBDjEza7VzYp3OVZvtXlprcoOyv
         pjGcf853f5X5fbBaIKBwvWXrBlUYmZDDTnNTyHMRERHxEY7x1UzPoSfAKY+H2VJccKpe
         xL+ppfHCgoiZl3jWp5e5MCOMP6Go8vEx3vg/p29sI7qLQPui+XazOJFgg0ya4BG4ItIL
         j1Rbt3hBG2V9AjbmRnxiOogMT2ozfGZDKTTiNBxpKHFTyLDTb7u4EnQevEcH4nivrz+I
         GEOSzNYAeMpFke9h4y5ee2KQoi/7OH+nBqDM8gmhLztKdtYq4DZMaEiJSEr1LeYfrBJ1
         TMqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYNkZr5rL0x0PqsK/gFEbZWPCQoNIvwHGKuNTKuLTQvLAjBDeIsYvJLofqrRc9r95UG+b3XshW18NoKYs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7yWyqVu5bP2A95wON0uWxhP7Z7CelZ7d42g5umSpOA7lwN5xg
	bLsRuFbX+4/4qL75hfN8QrUNAQfdsKXpX1rQvWhccTEgTCb8VniazBkRLkfn/E2DtS3ymPx1RX6
	IWZbceuhy7M1swWhcj6lRWL1e6WpAR1ToiZDqYud1m+ZBqY+QKDSvb+sG03pfgCNiNIlQ2TYuzp
	Y=
X-Gm-Gg: ASbGncsjM+qL6dLari8HFdP5oGRzBp1KYDvzIpBLYuoRB39MHy2Jen9PJ+4szwboSs/
	q8jP0diwawjUrnSgmkMIhDSzp7oYdXvK1XviMiephmubzIWvF2MVSyZhWv527dGS10sw0hNMp9V
	64LlnBvy3CUAropwNfhlWy3O85/pTjsbr+Yq8OYLuAYrWBK3myZMX9cH9JlyUhkqEZHKIO9DfmB
	Zar6nUtzoKbjBtSZeR8JIJ9D/a5JoBfnwGoS8/A4bYXNbCFLsK336vK5AYkzAX0k+VVhjPZxI+M
	I+ahcMBOxkxUxpOwAetJOcm4ckzrPYVWv1VTiZfH5illwk1tOBjwW3EAJsi8T3+vY3t8vvo+Dsq
	vwRWK0uQcxwkQ8NNvGY5mW4G1bR5DLQEenh1lSqjjG0n6bdMvzKYQAgBE
X-Received: by 2002:ac8:5a05:0:b0:4e6:eaff:3a4b with SMTP id d75a77b69052e-4ea116d889bmr116823971cf.4.1761291533350;
        Fri, 24 Oct 2025 00:38:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERlDjQFfq5XQ4d+OpUPfjbFEog9jtTsbbodJUg2QOMqaxjucQIj/Y18kJ9TgRfYF9ST9aSbg==
X-Received: by 2002:ac8:5a05:0:b0:4e6:eaff:3a4b with SMTP id d75a77b69052e-4ea116d889bmr116823831cf.4.1761291532813;
        Fri, 24 Oct 2025 00:38:52 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d727b4338sm105457166b.52.2025.10.24.00.38.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 00:38:52 -0700 (PDT)
Message-ID: <5e8397c3-5bb6-41e6-ac35-4090b7a9fe98@oss.qualcomm.com>
Date: Fri, 24 Oct 2025 09:38:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clk: qcom: gcc: Update the SDCC clock to use
 shared_floor_ops
To: Taniya Das <taniya.das@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>
References: <20251024-sdcc_rcg2_shared_ops-v2-1-8fd5daca9cd2@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251024-sdcc_rcg2_shared_ops-v2-1-8fd5daca9cd2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDE5MCBTYWx0ZWRfX6FAGr81rVEi0
 ldP2mTlVNbVp0HvckAmRR1fH3s9ziyw/YK434GdAtoCwpp1b+R+SPU9V/egLiJOd/OoGAk9HpKh
 nV/GZFN/64hERD+w/gbKBWrG1XT7DZxAtxeuPC+3GkNZXTFoYqpXye3TBRsI+eDhhLLIGUOWPWA
 aOgacLN/7PoWeeZdIcQ0cgMw1Y291awIIzQmcaK5boRdOfevq0jdhq7/XVNA0/kQnwWOlRNDoe5
 D0yz0aVSUIMBBEeL+MvC+5NChvpjco/hRYuZ1tD91Uw6ZU5ZO95CpF1mQabyuxwmt431jja5TQc
 b/YDnBi0YGmorUfcobScbgV2ziCoCvP9ivQfWkMGNhbig45egScbTvDuGS8fXvlUT/lpcDUQ5EG
 9lATxgKQVuYjw7nVHk7xvbnDYfJQPg==
X-Authority-Analysis: v=2.4 cv=FbM6BZ+6 c=1 sm=1 tr=0 ts=68fb2d0e cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=X3gyspzaiBKJvtbIpHsA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: xS_Y7m2YtDdpNn7jHjTmeXKMXrgMTzf9
X-Proofpoint-ORIG-GUID: xS_Y7m2YtDdpNn7jHjTmeXKMXrgMTzf9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510210190

On 10/24/25 7:18 AM, Taniya Das wrote:
> Fix "gcc_sdcc2_apps_clk_src: rcg didn't update its configuration" during
> boot. This happens due to the floor_ops tries to update the rcg
> configuration even if the clock is not enabled.
> The shared_floor_ops ensures that the RCG is safely parked and the new
> parent configuration is cached in the parked_cfg when the clock is off.
> 
> Ensure to use the ops for the other SDCC clock instances as well.
> 
> Fixes: 39d6dcf67fe9 ("clk: qcom: gcc: Add support for QCS615 GCC clocks")
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> ---
> Changes in v2:
> - EDITME: describe what is new in this series revision.
> - EDITME: use bulletpoints and terse descriptions.

:(

The subject also needs to be 'gcc': -> 'gcc-qcs615:'

Konrad



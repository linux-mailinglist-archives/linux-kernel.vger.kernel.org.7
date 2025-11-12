Return-Path: <linux-kernel+bounces-897120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 460B2C520E4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A46C3B6C85
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206973128D4;
	Wed, 12 Nov 2025 11:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XDHa+e9W";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hijW3UH2"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97A13126D1
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762947602; cv=none; b=vFVkkpCuSecLAbTXiFBYORpXadIbKFyWkesucx/4yRoCllGTk4+Lxwe+/H9UBj5/7XKgh0FfqER20jQztNcT2l+kHLp9Ntty8kJJNDJfopKm7/eBR6WcAbdp3yPbgqFwrrnAB9OtA6LUED+yiOdA5AWJ41xhRNZ5RQEswSOEG9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762947602; c=relaxed/simple;
	bh=3L85/oMCuqF+/EzJXAM9zXSxt4N4q9E5oV1hw6Vg3pE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hJ2GG76t9VEKRaJzm/LjKeMuulRabYBjzwM9mY7O6SHDBnhdvwbBf2KUGuQFwapvm0/jyLk1OVRzYD7Se+Wlga4KCD0jxSPmoaYBtU8xgd4zlFQ3XrCpy/g9hlYYuiGqgCNVxH85vafVSyLqnh8mFlPY95uyJa3WvomkHI/8nvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XDHa+e9W; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hijW3UH2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC9CaMe510069
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:40:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/NSRf1wg9ZQmnz06DND1B4gmBm+AKQ6Xrvu5UXUezxQ=; b=XDHa+e9WF6h9NdrY
	641e7zF1UCiDTSJRhxXGY3MFmb0NdOhRiiumYra/EMGOmLcGcUKeZA40BOuYNUJ6
	CYJCTmGRmOYOaDU6tay6ALwahM1s5WoToyhmCk9w0vRNeVFBBCoLD4M8B8hPKTDJ
	CEUOtWPkkhvKJX6teMh0njmm0nMhZ9AblM0yRwsOfdWN+BGxBJWsdfSKCrsmNeyd
	gaxNYg8HRLXLLV76R4fOZ5dPR8JtXKT4rExyhk0lfSpA1e7FUaqWcZ/vWhc3Sg/p
	6zIA9N/Rv1Apb166hj/GwHp394a/wEEy21QJxN+kimfC07og5MG6Um7pkHNbAIEL
	3GlqIQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acqdgggwh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:39:59 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b184fa3ffbso31784985a.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 03:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762947599; x=1763552399; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/NSRf1wg9ZQmnz06DND1B4gmBm+AKQ6Xrvu5UXUezxQ=;
        b=hijW3UH21MqOB4hYXmokqo0gIF9DEYIDIT0KqIY/rcSH4z0w12wlB/pnz6N2ohfdlq
         2PAY2p/czOg1OoBqmP83E2ITpoYPPFCVnLzPF0DGV7/m424lLIKT/8awOs7b1/oV+IPs
         tlnI2X36FdHI3xD+uSUxT7g0b6LObBerYizBQnKVIBQuediycUD2lOcnG15owi4bLSjJ
         BoBkt/Bnt3sYjP1w0FGyQke9d2ir1SM0DBP3XgQQexW0trUg7UEHiqqEW4OvGCLl+IWn
         GhcyDZZazPJkVDlAEczEX2vcx9ueZbG/Bki3mLHosIKixQmKgmf4IuR2+DspIwF667a7
         THYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762947599; x=1763552399;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/NSRf1wg9ZQmnz06DND1B4gmBm+AKQ6Xrvu5UXUezxQ=;
        b=v5/+VAo5WtDXf92n3OP4A1qhywuqnDenPfATXevHu6OAupBpK4Fm5AMq8Vvs9Kr6Az
         pzFGeaKItPUXLK+edl6IUye0/Uf37CSKgDhcC2CjFkhhhn1RzRxN/1VxNVtYA+X9FaF3
         uzMSjA9uBzCT1KPJjSI+KgGxWfQw3JK4LsJNyGGM0WTkHqDkrdxQy1pe7j2awCSJxDSu
         z+UAB8kJlpmhqPZK8rZX6s6PHFGiFSHHbR5jpaxIuGaDpWwakXSL3dzdX2fNSjLcorEr
         967uSn/EKT3wf35eYnAgGMsHFm/+Ylke3+ahwYX0cBxK3bm3xq3MncrSbKV7fJXbDaRQ
         VwQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUldlZ2t6IfMfuL+/+4bmHeyA4SBsTmRUTyEoji98PVdv5875d4tVwodAZl+NVIr5NWrLQ7u/9MveMzuX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfAr/bQGLohuA9SXZb35bODtlSei0gFs0NJ4vLz2AtbcdfK4bK
	B0RNhOrroQi9uNolJV531ESbxRaNsAX0tkdqmBwX9XdhEF6bQmP55rK3M3alpO9eEu08LVM8hfq
	TdkQ2ZFRvC9b2WmLWN4hdZ3XfmXsZTL1VTPX/A2iIyQyOvbw1eM0zBdbAhqr2JXcsnse1M55Fqg
	8=
X-Gm-Gg: ASbGncveZmGHBptDo+Tv77qmssxLZY2TSdAbQ90bgBNh58Ja2kJovyTTLy7QyJgB7T5
	E/vMSou0/oM8XJATDojwzzRsw93iwL8Nn9Ipc83N6rt/z8XI9vvf8HxREw1J5qNM3DXPkeYWNV0
	6rydIPaW5sSDezNVooOg2bY3xFS2hOKOuoVb/5WEJ9aZG5kek8zHxgmBBnmbwGtIdv8U7PHmK2i
	H9lS6iTeWhWwG6KL3LxJ7PkOaMAVPh6xbXkfTkrE36Vu+j85DsVo5a/lY9eMUgWFq1ZlyKYpnHy
	AmmH0onvJvgx1ndvIHMN/IVr5yg/KCKBN8Kg9VyOII1VWQym23Cz1x59h/p0s06x83VzcWSK8Z+
	wC7yBCAgiTrYDKSU+0GLJSZCJ4j72tCuwS0CP+WNLe+OwuITv9I/HiTrp
X-Received: by 2002:ac8:4817:0:b0:4ed:e2dc:dae2 with SMTP id d75a77b69052e-4ede2dceaf3mr3509971cf.0.1762947598588;
        Wed, 12 Nov 2025 03:39:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmVPhiEZGgXJznil6s2OoOPh+wSp2Lp3eALqOk8bHwKQeRv7sm+9a2avLNsIZD5Y5ZW7eULg==
X-Received: by 2002:ac8:4817:0:b0:4ed:e2dc:dae2 with SMTP id d75a77b69052e-4ede2dceaf3mr3509811cf.0.1762947598035;
        Wed, 12 Nov 2025 03:39:58 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72fcde0779sm930551066b.40.2025.11.12.03.39.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 03:39:57 -0800 (PST)
Message-ID: <31c391c7-3e44-43ec-82da-2c612cb5b087@oss.qualcomm.com>
Date: Wed, 12 Nov 2025 12:39:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC RFT] interconnect: qcom: implement get_bw with
 rpmh_read
To: Neil Armstrong <neil.armstrong@linaro.org>,
        Georgi Djakov <djakov@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251106-topic-sm8x50-icc-read-rpmh-v1-1-d03a2e5ca5f7@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251106-topic-sm8x50-icc-read-rpmh-v1-1-d03a2e5ca5f7@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dtrWylg4 c=1 sm=1 tr=0 ts=6914720f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=EylLml8pCTcjifbIhvwA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: ETlIVS6XLMeD415MVXbvvGLOQn4L48ch
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA5MyBTYWx0ZWRfXw4gNJoOr7vRT
 i34KzxaHVor4/VLVzZVENwkzli4B2lXWuMEPGWwVrcjAg1ITzmPaxomv4nY00m/HeCcpnw5mE7N
 95CliLJ06xOtQnQsy9QDE/UJB11C1Zq6DjV6IbPXkLkDQZIm/8e1UVTF5k23jRcnX3930paYCUE
 /IwfdtnVKCkORd/58603sdd+h6K7UYs710/c788FWlpVBZvWjrA7CQWoxsiIbxWOEWGONj+yLry
 XJZ3csw7ZGLjICIVPCvaz938NpVa4HrMbfoT56jUxr6yfn9FF/QE/OgR6lkedDrV/KKnuFeOxl0
 MB4X7H2++wNHQtcpNb+9gdUXgfzCNNaQ3j0ExTb+tdgWx8WonF03EhjqzlxeYL/B6rybzDsqacV
 ijULQZGRnMZfbrH7DJvQRiQFCf4gyg==
X-Proofpoint-ORIG-GUID: ETlIVS6XLMeD415MVXbvvGLOQn4L48ch
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0
 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120093

On 11/6/25 5:46 PM, Neil Armstrong wrote:
> Since we can actually read back the APPS rpmh interconnect
> BCM votes we can actually implement the get_bw() callback
> and provide a coherent average and peak bandwidth at probe time.
> 
> The benefits of that are:
> - keep disabled BCMs disabled
> - avoid voting unused BCMs to INT_MAX
> 
> If the interconnects are correctly described for a platform,
> all the required BCMs would be voted to the maximum bandwidth
> until sync_state is reached.
> 
> Since we only get the BCM vote, we need to redistribute
> the vote values to the associated nodes. The initial BCM
> votes are read back at probe time in order to be ready when
> the get_bw() is called when a node is added.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Depends on:
> https://lore.kernel.org/all/20251022-add-rpmh-read-support-v2-2-5c7a8e4df601@oss.qualcomm.com/
> ---
>  drivers/interconnect/qcom/bcm-voter.c | 36 +++++++++++++++++++++
>  drivers/interconnect/qcom/bcm-voter.h |  2 ++
>  drivers/interconnect/qcom/icc-rpmh.c  | 60 ++++++++++++++++++++++++++++++++++-
>  3 files changed, 97 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/interconnect/qcom/bcm-voter.c b/drivers/interconnect/qcom/bcm-voter.c
> index a2d437a05a11..9014bf20adad 100644
> --- a/drivers/interconnect/qcom/bcm-voter.c
> +++ b/drivers/interconnect/qcom/bcm-voter.c
> @@ -261,6 +261,42 @@ void qcom_icc_bcm_voter_add(struct bcm_voter *voter, struct qcom_icc_bcm *bcm)
>  }
>  EXPORT_SYMBOL_GPL(qcom_icc_bcm_voter_add);
>  
> +/**
> + * qcom_icc_bcm_get_bw - get current bcm vote
> + * @voter: voter used to query bcm
> + * @bcm: bcm to get current vote from
> + */
> +void qcom_icc_bcm_get_bw(struct bcm_voter *voter,
> +			 struct qcom_icc_bcm *bcm)
> +{
> +	struct tcs_cmd cmd = { .addr = bcm->addr };
> +	int ret, i;
> +	u64 x, y;
> +
> +	mutex_lock(&voter->lock);

guard(mutex)(&voter->lock) will let you drop the goto

> +
> +	rpmh_invalidate(voter->dev);
> +
> +	ret = rpmh_read(voter->dev, &cmd);
> +	if (ret) {
> +		pr_err("Error sending AMC RPMH requests (%d)\n", ret);
> +		goto out;
> +	}
> +
> +	x = FIELD_GET(BCM_TCS_CMD_VOTE_X_MASK, cmd.data);
> +	y = FIELD_GET(BCM_TCS_CMD_VOTE_Y_MASK, cmd.data);
> +
> +	/* For boot-up, fill the AMC vote in all buckets */

This isn't a good idea, I think we should be able to get information
from all buckets separately. I asked on the thread that introduced this
API. I'm assuming it was hardcoded to ACTIVE_ONLY because of its use
with the current state of the upstream regulator driver

> +static int qcom_icc_get_bw(struct icc_node *node, u32 *avg, u32 *peak)
> +{
> +	struct qcom_icc_node *qn = node->data;
> +	u32 avg_max = 0;
> +	u32 peak_max = 0;
> +	u64 x, y;
> +	int i;
> +
> +	if (!qn->num_bcms) {
> +		*avg = INT_MAX;
> +		*peak = INT_MAX;

Since this function returns an int, maybe you could alter the core to
check for an error and if -EOPNOTSUPP, fall back to these values (as
it does currently if !provider->get_bw)
> +
> +		return 0;
> +	}
> +
> +	for (i = 0; i < qn->num_bcms; ++i) {

odd pre-increment

> +		struct qcom_icc_bcm *bcm = qn->bcms[i];
> +
> +		/* Use AMC vote for boot-up */
> +		x = bcm->vote_x[QCOM_ICC_BUCKET_AMC];
> +		y = bcm->vote_y[QCOM_ICC_BUCKET_AMC];
> +
> +		/* Consider enable mask and convert to INT_MAX */
> +		if (bcm->enable_mask) {
> +			if (x & bcm->enable_mask)
> +				avg_max = INT_MAX;
> +			if (y & bcm->enable_mask)
> +				peak_max = INT_MAX;
> +		} else {
> +			if (x) {
> +				x *= bcm->aux_data.unit;
> +				do_div(x, bcm->vote_scale);
> +				x *= qn->buswidth * qn->channels;
> +				do_div(x, bcm->aux_data.width);

mult_frac()

Konrad


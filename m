Return-Path: <linux-kernel+bounces-735310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DDCB08D99
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32EB11698D2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 12:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154A72D77E3;
	Thu, 17 Jul 2025 12:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hrMlycHp"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8A928BA81
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 12:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752756864; cv=none; b=JYUenYeRg19EQr9zompFOtn7TSJv9Jur4rXkRR3a9rSGk2l9fBrDqxyKSB82qxX+mSjM/kEOi6ojy1eRRZHiawyxzqVl+EY/bJYO1uuFicSRRUZkQ/1NX+aYzf7Twra4volP1ZU9iWxALbgrqOEZjaNexCi2R8WwbzGb1TdZN4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752756864; c=relaxed/simple;
	bh=z+X8A9P+G8blqjkqdD7ikKkiAkXVI7kyhvLjlBrrHu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CgMYSITUAWGMB9YoWxFMS1Jzp37s2smk1AFrCpSRS+kpwePo1RbfW16HDrY2lnyvR9lqwetwFsMB3RkLp9vLWT9+cz0WVhPzqyVH/JzqZV36BYE4DV8ZWGLL+dOWNbBAs8rt79pZcq2XcmWJ4G+WIC7TVpRes5LZmX9zt48o74s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hrMlycHp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HBl9xD022256
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 12:54:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vY8+U+AdtRViJLGrgNvdoFy3geTUrpbdX4fYqj2cMJg=; b=hrMlycHpVroEaQWv
	kvr7GMs0/d5F2a2bWEpuQjEeAcymkwr8AR7f+kkqFutISuf8c5VOhdsnRDiij3MU
	xv8/AXzwFDEz5wgcKNOcRdr7io0UYfSSN66IhgRHw5aqREFiV4/eTgYhOa+IBuwE
	tHWBE0qnQaZKQYbyuOkiBsaCk97Zx21Mx/6TCTrTmH0kzGFgCbZc1Eq4UlFwXnjx
	RVDECAhnZ7ndwfDBS8a/87WusyGFWL1AFqGT56KzR3lifZ0k1AtBAknaHJ/mQO5H
	sLoEPrFCkGytbPijhTLD3NnnSu7k1YKo9x2Q83p72Evc/4AkyuGuZzq/eM5AZyGC
	R2SApg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wqsy7kuc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 12:54:21 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6fabbaa1937so3132926d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 05:54:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752756860; x=1753361660;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vY8+U+AdtRViJLGrgNvdoFy3geTUrpbdX4fYqj2cMJg=;
        b=LsosH7l33aNOtBFVZe8oHPQ6U+pqSwpP1oYuRg0ZHWMcjclo4K4hYCxKYYNwfb6ShX
         gTerYtMfqhmDsgUzLNbOMpmwjZ5zctm6pA/5MZ3/ZPw/weL2yYJc2RsQcJofmI6yV1Uk
         g3pUzhVV7P27oXizAZ5/W7Dp7TE0E9YA11oqDZRpeNJ2fhEQeqJqfvZwVVJV9nj9aw3w
         CtW4CA6RUgq6Pe1NDz9C8BzzhflqRaUcIxSOIzrWArJMBz3IOXmJNd1f5gHbwGVZ38I0
         7jSIFk3pzaNpY0D/M1kQOaKoVBMK4JC1Cq9yLzzs/Dcjx/ho2caxrpdflB+qW9CNsSs1
         T31Q==
X-Gm-Message-State: AOJu0YxkHn7eAIdSPipHaiH4vgP5VGYZatLiHH+3DRLxXZ43YC8DIvNC
	KGEyNB97vVkymeE9ZIjDLTfpr1Qrt1bZ/6+8s8EQogVMWyezyNRkjgxLpDzZhxfod6jtrFIwY+W
	VJ+O6Cnaf3RBmmFTL7qWyyvsN0j4q3HnHLPt+ESsVmuMdO3Vc/RXwcNaDqWJ49uVu4fE=
X-Gm-Gg: ASbGnct3gLpmemKmDGMKIhCVA+2FM9yk6Z+VkRzo9Z4wi81JoncsmkLWdgemwCpgxCE
	JhhdYEZnlLvOcUweiYHFKy1VNQzcQRr0RHdMgc82J8eLWvgKB595guLWb27W9cOF6A21n5BFgla
	ieNpTl55aXcKHiPCcxIz2/nf0ogRMN8x53AdEniTCStcm0lk1EkIzRM4DuyyMvRMF+QyFZR3nNN
	3QYhnWaP7wdty3Qkdo6n/zfxJgRUidBOZpEhiJG0NYUKeDFIDH71LkcRc6ZXu6Tp7VM53Fp6yFw
	qTeGz4MT+xJ9tJB7nGBjgutKBcg9ewB6CGoRnszkcFExgUdIInvZwRBr3h/H1n7tC6tNf0/mLM3
	sxo26zrH2WLQ2peYrjvfE
X-Received: by 2002:a05:620a:2949:b0:7d5:d01f:602 with SMTP id af79cd13be357-7e342b68dd0mr446381685a.14.1752756860528;
        Thu, 17 Jul 2025 05:54:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIHZdErHUxcQSzMlX3jaAJn024q0jCOwgH+lHrqH9oe6WV/+qWTPGrVNeWc8ZrO5OBCGW2Tg==
X-Received: by 2002:a05:620a:2949:b0:7d5:d01f:602 with SMTP id af79cd13be357-7e342b68dd0mr446379985a.14.1752756860098;
        Thu, 17 Jul 2025 05:54:20 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82dedc0sm1354487066b.160.2025.07.17.05.54.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 05:54:19 -0700 (PDT)
Message-ID: <e1335aff-00b4-4505-bcf5-0eb8f2974a75@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 14:54:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] media: qcom: camss: tpg: Add TPG support for
 SA8775P
To: Wenmeng Liu <quic_wenmliu@quicinc.com>, Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20250717-lemans_tpg-v2-0-a2538659349c@quicinc.com>
 <20250717-lemans_tpg-v2-3-a2538659349c@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250717-lemans_tpg-v2-3-a2538659349c@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDExMyBTYWx0ZWRfX83two4kKmpgF
 4w9/g/mQBBgFAF4W7oLiICJ4dz7jT203pmLGKBcLGMONP1N+cjeyi4OfaqRykvBGI8f+L2RTcmA
 WeJKUdiBhvtqYqFp/AbVjbrhE/eZaRzIQnjLTX2t0R+fQClrmKjkPLzlJweMjhf/YN4J/3k7RiZ
 SwcyO2NFQcyZKCYX0CoG9WTGmGde8G/wKEiP+z92aF6ug44scfjMcMvBgBy4RlqMgAEzl9h25ou
 JjemFGKF633hxDmsvxDkq/GtFhVQFSnnab5nvaKidj57VV1oadpoGlxl0H7+Wy+PUz+j8BtxAb+
 mP1Y+4KvwVH1czmG7wjBplBsWDKr8Iq1EdkdPK2dtITMvbFVXy+6kOXe9sF5KudBYBoLPE2OCjb
 2EfQ+wGPWdjC62Z7x7wTtjzqKrfzPL4pNWAxjHJD7pdQU3zqtYyiUsvESh0LUa6Gj6zZtUXr
X-Proofpoint-GUID: YKJOs2Ktck6jPS0BdTFTzF8-2HrFgScc
X-Proofpoint-ORIG-GUID: YKJOs2Ktck6jPS0BdTFTzF8-2HrFgScc
X-Authority-Analysis: v=2.4 cv=McZsu4/f c=1 sm=1 tr=0 ts=6878f27d cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=pSl5WCw3oxHEiR9bIskA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 mlxscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170113

On 7/17/25 5:20 AM, Wenmeng Liu wrote:
> Add support for TPG found on SA8775P.
> 
> Signed-off-by: Wenmeng Liu <quic_wenmliu@quicinc.com>
> ---

[...]

> +static int tpg_stream_on(struct tpg_device *tpg)
> +{
> +	struct tpg_testgen_config *tg = &tpg->testgen;
> +	struct v4l2_mbus_framefmt *input_format;
> +	const struct tpg_format_info *format;
> +	u8 lane_cnt = tpg->res->lane_cnt;
> +	u8 i;
> +	u8 dt_cnt = 0;
> +	u32 val;
> +
> +	/* Loop through all enabled VCs and configure stream for each */
> +	for (i = 0; i < tpg->res->vc_cnt; i++) {
> +		input_format = &tpg->fmt[MSM_TPG_PAD_SRC + i];
> +		format = tpg_get_fmt_entry(tpg->res->formats->formats,
> +					   tpg->res->formats->nformats,
> +					   input_format->code);
> +
> +		val = (input_format->height & 0xffff) << TPG_VC_m_DT_n_CFG_0_FRAME_HEIGHT;
> +		val |= (input_format->width & 0xffff) << TPG_VC_m_DT_n_CFG_0_FRAME_WIDTH;
> +		writel_relaxed(val, tpg->base + TPG_VC_m_DT_n_CFG_0(i, dt_cnt));
> +
> +		val = format->data_type << TPG_VC_m_DT_n_CFG_1_DATA_TYPE;
> +		writel_relaxed(val, tpg->base + TPG_VC_m_DT_n_CFG_1(i, dt_cnt));
> +
> +		val = (tg->mode - 1) << TPG_VC_m_DT_n_CFG_2_PAYLOAD_MODE;
> +		val |= 0xBE << TPG_VC_m_DT_n_CFG_2_USER_SPECIFIED_PAYLOAD;
> +		val |= format->encode_format << TPG_VC_m_DT_n_CFG_2_ENCODE_FORMAT;
> +		writel_relaxed(val, tpg->base + TPG_VC_m_DT_n_CFG_2(i, dt_cnt));
> +
> +		writel_relaxed(0xA00, tpg->base + TPG_VC_n_COLOR_BARS_CFG(i));
> +
> +		writel_relaxed(0x4701, tpg->base + TPG_VC_n_HBI_CFG(i));
> +		writel_relaxed(0x438, tpg->base + TPG_VC_n_VBI_CFG(i));

Please provide context for the magic numbers> +
> +		writel_relaxed(0x12345678, tpg->base + TPG_VC_n_LSFR_SEED(i));
> +
> +		/* configure one DT, infinite frames */
> +		val = i << TPG_VC_n_CFG0_VC_NUM;
> +		val |= 0 << TPG_VC_n_CFG0_NUM_FRAMES;
> +		writel_relaxed(val, tpg->base + TPG_VC_n_CFG0(i));
> +	}
> +
> +	writel_relaxed(1, tpg->base + TPG_TOP_IRQ_MASK);
> +
> +	val = 1 << TPG_CTRL_TEST_EN;
> +	val |= 0 << TPG_CTRL_PHY_SEL;
> +	val |= (lane_cnt - 1) << TPG_CTRL_NUM_ACTIVE_LANES;
> +	val |= 0 << TPG_CTRL_VC_DT_PATTERN_ID;
> +	val |= (tpg->res->vc_cnt - 1) << TPG_CTRL_NUM_ACTIVE_VC;
> +	writel_relaxed(val, tpg->base + TPG_CTRL);

You want the last writel here (and in _off()) to *not* be relaxed,
so that all the prior accesses would have been sent off to the hw

[...]

> +static u32 tpg_hw_version(struct tpg_device *tpg)
> +{
> +	u32 hw_version;
> +	u32 hw_gen;
> +	u32 hw_rev;
> +	u32 hw_step;
> +
> +	hw_version = readl_relaxed(tpg->base + TPG_HW_VERSION);
> +	hw_gen = (hw_version >> HW_VERSION_GENERATION) & 0xF;
> +	hw_rev = (hw_version >> HW_VERSION_REVISION) & 0xFFF;
> +	hw_step = (hw_version >> HW_VERSION_STEPPING) & 0xFFFF;

FIELD_GET()

> +	dev_dbg(tpg->camss->dev, "tpg HW Version = %u.%u.%u\n",
> +		hw_gen, hw_rev, hw_step);

dev_dbg_once()

[...]

> +static int tpg_reset(struct tpg_device *tpg)
> +{
> +	writel_relaxed(0, tpg->base + TPG_CTRL);
> +	writel_relaxed(0, tpg->base + TPG_TOP_IRQ_MASK);
> +	writel_relaxed(1, tpg->base + TPG_TOP_IRQ_CLEAR);
> +	writel_relaxed(1, tpg->base + TPG_IRQ_CMD);
> +	writel_relaxed(1, tpg->base + TPG_CLEAR);

similar comment as before

Konrad


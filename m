Return-Path: <linux-kernel+bounces-794559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EC0B3E359
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF8AC162122
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEDD30DEC3;
	Mon,  1 Sep 2025 12:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TR+ed2qp"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3924630EF7D
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 12:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729987; cv=none; b=YfRbJ9a8+4SCCHtVOPveE5wYvgxdw9fCMYw7uOScuisbm+GhhiurqKKxaXJ5bhQr6H4zJvLhZ2yfD1yEu+3JU/maGG3KS9eBwEoeOtqB/BIhyl+ZZq7taEV9sy1IyOMW8KIbKi7VdCgfCCrY6sFvKs2ZnkwbFIc5q6hf4Lzo+kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729987; c=relaxed/simple;
	bh=EB7F4mbxiHQX5qGhCQQlDNKpKVWf7VS3kp1B8SPd9Do=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VD4NhuYmQpvW2m1JTYm6yd/GSWXIDBMHQBByvi5J1lRoCtPZZ/IK4GvWkRBVZLBb7xvTP9j6rlS0p2yAgY4GM0iuygGsDoK3f39qPsp3hLgJTlsSiOXrJ4M2Xjcbj0cITGbijk2qKG8piIhHfaiPwjJSmq4EWw00EC7O5XHrWtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TR+ed2qp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 581B43Ir013450
	for <linux-kernel@vger.kernel.org>; Mon, 1 Sep 2025 12:33:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EB7F4mbxiHQX5qGhCQQlDNKpKVWf7VS3kp1B8SPd9Do=; b=TR+ed2qpL1UMcFGf
	c2LYRYswDisk5QfEcmEK8cdrYfIWWWnqNxjAjNGDTHk2kw4pT99AHy2DJpoyH0zw
	0wRIyxAyqebxwYZP5J6xOqCGBAU5sQe6XjgfyDZv4LHM5r6H5gOUN3Fs+LiCc1NC
	FENrX9MDHrVpkemQsZ5dnuNfj5zxS0L00bIg7tU7wsOYDMkwZhbfUahPg9yJrbPM
	uWu2ViZyYUenjHCGXUmIX+Vm1QNDdztFLAUkWDcnuB0V4Z+zg7EUBn0vIb+n1Jr7
	Y+xfLEUpNK6ExbYNoSmtjR/INenarXJg/cDuhRDrVwXKSSXEtWryBytQbVNlkW1G
	dTusaw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura8mrx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 12:33:04 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-245fbdc2546so14613865ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 05:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756729984; x=1757334784;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EB7F4mbxiHQX5qGhCQQlDNKpKVWf7VS3kp1B8SPd9Do=;
        b=XLKBO5E8+zR5h/tP+TWCEYJ2DtjFWH5QVp/jIrZw523iN/mLg8yd5csQ5C9qNmqCqe
         UcGLEqg5e4Ies6cncMjNgiSg5GWhHh+p1yo7aX7ddsLASDcE8uH7bcJ7T2VvfJfBR0gS
         nb9shbvI+aQPETb0Y+uo0GZg3Ig+wQ4wg7uGxobvLUHaWdK9e+j8EapxCNGUmiC5A2NQ
         Kt11dkz3KkuVgZ2uyWRVYRvf4cBlYG6WMq4KLy04bHXnZIR8C7Z2gXqjcuDJsgph3h2z
         uoMI2FqJuHoaIDQHt3yibCE5vXl9VP3B3NC1CF+1NRz5k2NKBOYZ9oDRRII0wm/pE1iN
         3aIw==
X-Forwarded-Encrypted: i=1; AJvYcCVkUso1NuGueyQpEbwy+6z9PXUY1Og9pDZv2IbEALNJmzuh5/9bzKLVUv/urWnGfzuEIM8hP1/lmiA9j60=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdblAGDOmQyeOxYchgIjEAcIoUxDNduZwB442ICWs8f9RJk256
	d0dHOAm8JIPiiOCY8OOhC4BPUYnHLVuE4U8c+KFAPlDL4BYnL9qJLdJRPnIhj1GG3Gm/dvoQNUo
	/jvWo/cMlIMCxhUO82pV2bjb21Z3RMzBVrCg/OrUmPtz5z2kMe3lGnSqAh052PaM6cmY=
X-Gm-Gg: ASbGncvPOF//5Vvjf/BzhiCiI7GQfaAjTXf1faV9lTkXkjdTb1B7Y2UzZ7cWrMUpCM6
	cNIIKxyhE+muovmuWnUseflx3tCL2gAqEJ4kq7hPvg1Bo3s1xDR1w746mNOulLeg7gKd0W5BkVp
	7oWzAqr0QBw7HAt4KOoTiwkASRBz57eZRzuRbkET46M4Ndv1xyawXziMa0N63NfMKjCJZ2UFL1m
	pE0JnfLOPIEyuOplIoSgEYv6ylQ5VznYrhQUWJmMN15BGvHThUUYCCwXWp/nVdSQzqb1OpJVquF
	wTEK9dV6oNIQlisjcJPggZU2jhNHfv/kMgDybkH+IjYTI+bAOKrnwJ8TabRMVvAfe+UqC36sGff
	4axPNVeeOUC54RRouAbmHKeQuVIQlqA==
X-Received: by 2002:a17:902:ea0e:b0:246:a152:2afc with SMTP id d9443c01a7336-2490f6e2a41mr89139375ad.3.1756729983494;
        Mon, 01 Sep 2025 05:33:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvdBSg+GSkVZYutloMzMAPl9JCliwrB8npGb8PaTRixqyTmb5uK1ODr7IHrQZgoOD9FV9l1A==
X-Received: by 2002:a17:902:ea0e:b0:246:a152:2afc with SMTP id d9443c01a7336-2490f6e2a41mr89138865ad.3.1756729982941;
        Mon, 01 Sep 2025 05:33:02 -0700 (PDT)
Received: from [10.133.33.251] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249066e1158sm104253735ad.144.2025.09.01.05.32.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 05:33:02 -0700 (PDT)
Message-ID: <75f8789d-9d97-49d9-97b0-908a5692c325@oss.qualcomm.com>
Date: Mon, 1 Sep 2025 20:32:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/14] dt-bindings: display/msm: dp-controller: Add
 sm6150
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, fange.zhang@oss.qualcomm.com,
        yongxing.mou@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, quic_lliu6@quicinc.com
References: <20250820-add-displayport-support-for-qcs615-platform-v3-0-a43bd25ec39c@oss.qualcomm.com>
 <20250820-add-displayport-support-for-qcs615-platform-v3-1-a43bd25ec39c@oss.qualcomm.com>
 <75ra2ofecqu6tid6kr4hnyuztpl6jjaq2ksyquafyajhq2sa4d@4tkggrdqky7y>
 <8918feef-219e-4e69-8901-367189f5066d@oss.qualcomm.com>
 <28b33851-24eb-428f-b046-b145342fd982@oss.qualcomm.com>
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
In-Reply-To: <28b33851-24eb-428f-b046-b145342fd982@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 2wUvu5mPTUo_zpUSRQec3TufaMLuyRdd
X-Proofpoint-GUID: 2wUvu5mPTUo_zpUSRQec3TufaMLuyRdd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfX4VQwMNOEpMYe
 mplRevf+tI+mb3edRZX+BDrADoQmFCle/IX6YVYwMZqN6h78jURFmHsVzPezIOjC14LAVkftJcv
 5KUWKKOzynRjXNQ0zMSYZXc4RMa+GR0jrqlvpGnuOvJDS5WOM/GCruVzOm/BqGuna0nTBGMrSSv
 mE6DiTu/Kgi9lCZCh5zDjwoJ34SMPYUiKN1NezmNnSLFCcAy6hsVCrKNq1GLZ6JBnGt23FAaec1
 WvG0f1dVz9ZfBNFXVzEkcURpOIFkfJeYc2t4Jk1hiSFZzJZXxyagE1TSfLcfJUiTg5gPw/Dy993
 OOPKrP0kfqB63Y7nA/xHqzVxlgWLCqijxvJcf80paWHd1tdEHkwkxksO3rBdbhmGJHpL9iUYW8R
 lGmo+j2H
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68b59280 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=ZffzQ4fVxSrCOw2gOQ0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_05,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020


On 8/28/2025 7:05 PM, Dmitry Baryshkov wrote:
> On 28/08/2025 07:51, Xiangxu Yin wrote:
>>
>> On 8/20/2025 6:18 PM, Dmitry Baryshkov wrote:
>>> On Wed, Aug 20, 2025 at 05:34:43PM +0800, Xiangxu Yin wrote:
>>>> Add DisplayPort controller for Qualcomm SM6150 SoC.
>>>> While SM6150 currently shares the same configuration as SC7180,
>>>> its hardware capabilities differ. Explicitly listing it ensures clarity
>>>> and avoids potential issues if SC7180 support evolves in the future.
>>> I assume, it has no MST support. Am I right?
>>
>>
>>  From sm6150 ipcat, I found MST-related registers and pixel1 clk definition.
>
> Then please describe MST as the main difference between SM6150 and SC7180 (which doesn't have MST).
>
> Also this needs to be rebased on top of the MST bindings. I've picked up the latest posted revision, but basing on the on-list discussion I might need to drop it and post another iteration. 
>

Would you prefer I keep the current patch and update the description of the
MST capability difference with SC7180 in the commit message, or rebase on
your series and update the dt-binding accordingly?
https://lore.kernel.org/all/20250829-dp_mst_bindings-v7-0-2b268a43917b@oss.qualcomm.com

Since MST support is not yet mainlined in the DP driver, even if I rebase
now, the final implementation may require redefining msm_dp_desc for
SM6150 in both the dt-binding and the driver once MST lands.


>>
>> According to the hardware spec, MST is supported, but due to limitations in clock and pipe resources,
>>
>> the maximum concurrency capability is restricted to 1920x1200@60 + 1280x720@60.
>>
>>
>>>> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>>>> ---
>>>>   Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 1 +
>>>>   1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>>>> index 9923b065323bbab99de5079b674a0317f3074373..996d0132e084d401db85014a1a4e445d00d62ed8 100644
>>>> --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>>>> +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>>>> @@ -27,6 +27,7 @@ properties:
>>>>             - qcom,sc8280xp-dp
>>>>             - qcom,sc8280xp-edp
>>>>             - qcom,sdm845-dp
>>>> +          - qcom,sm6150-dp
>>>>             - qcom,sm8350-dp
>>>>             - qcom,sm8650-dp
>>>>         - items:
>>>>
>>>> -- 
>>>> 2.34.1
>>>>
>
>


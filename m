Return-Path: <linux-kernel+bounces-807541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 474AFB4A5E5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 28E2D4E2402
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657DB274B59;
	Tue,  9 Sep 2025 08:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hsGKWoYF"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7672749F2
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 08:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757407681; cv=none; b=YY9vKGI78cMQGr5WU3MIYlLakALsAhrUwhnpKPGP22r8Bol0M9DyasD+if/8q0SoywgrqPKndhrY7Z3pLQrotqVtVtlnMSYARNeN/NUBGwoxZz5z/Q9DvFTnZotQ72Gq1BFgGqI8+0TTtF+yX8evJ35vFMRCQ7EOu9QvwyO7378=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757407681; c=relaxed/simple;
	bh=Kx/ttkJLLKYRFVmgllThM47tiA9M6uxgKLcDhYmE1p0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B/vMfp6V/PecLog63EFPJgvxedeVGg40CQP82QU7mA3rhWrepF5YVKSOMo2Ep+ulgpVRMwuaFvhb7XB/igLp1hzsfrPQFOGI9Tizmv5kCZWNKZnDCEdCrgOC6Ydmnk6nNLN/3tZNIj6irSISHHu2z/nn3rdruTgQ/3AUIHVpX/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hsGKWoYF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5896SYi4028364
	for <linux-kernel@vger.kernel.org>; Tue, 9 Sep 2025 08:47:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Kb0CUgscggYSZpxpcmC4xv4Mz5gALmhi0zSX0+xuhwU=; b=hsGKWoYFicuyoDCf
	Ti04diUy7hLxVg47PJ/7DkxpbSIECaI2OEtcGzUtb5VrnzOOFWoKoY882YtZuz/6
	4YRLVlQpTk/vS9WSKf6PrGMJfW64Q9nfN0WaMbYIkIxQF/zl+B4j19jSQMAYM1jn
	4s29BNyiQ4LiGJQ4zRK82D4SCcd3ywYN+CxVgH4IPA3F/TYIz3LGT6IhVO23aJny
	tmMKspzb1qCJMF4LphD2nYCni8ipUU9YVn1YmgxRGGz66lrPCIN+9+cEVq0CJufh
	bkAHEcZcRqD72nuvTdIJMvVnZu3RWVebcGhgJWpzFaWYV4CvD9+azc7xAuDmEFcb
	1v3FDQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490aapfv5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 08:47:58 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-74910ab069bso3430466d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 01:47:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757407678; x=1758012478;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kb0CUgscggYSZpxpcmC4xv4Mz5gALmhi0zSX0+xuhwU=;
        b=KhGYFAB41hG2pUP6ms5QBk+dtoRzIOv3KUx+q34DNWFMWEAjNz+74jxf5PCtmd3UEp
         WtlRu+sld2wJrmM7Xe1aszaCz5TtOtQfjWq68LGu4shAshwXMOlXhCPYA+45swuk2cTk
         C7Wc9o+KhTbmFurFb6eOPER8HqmDJAf9Cx1u/mSeXdi2oMfkJ5w6/PG3PO7FgC6ombMo
         kXR4z0e8vqShv+L0/CKlpbdUXGiSMidFvQxtb1zEgHy7hZVkWBlpOHPb/uERUVFMkrbv
         WbXDWy6FDSf3KBHwUAH/c5MP5c2GrhR0NkCTVOoA7br4uF0hJMK/i6CDC+9BbZJeDW4h
         V8iA==
X-Forwarded-Encrypted: i=1; AJvYcCU0Byh6kLc7YcKa+l+w6cEuN1EGFnEg9JAsu3dtyoqsx0xlzP/RliCRykg+NaxkamQR+Ev/wRZxgTzdZow=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDqm9sNLdV34C73H+NFdaircj5uxKpVCZiinR1ap7tnAdC389X
	hG8H9v/CcExxAMomaW1XlaM62BT3KvDEY47tI7Z/isMw9cm4KjTgykHosHHmDg98Iyp66VzGtnz
	052VkVZzHNICthuXNxuiAuULndLxyW8/GDYf1SLnvzW2RO/mTcCXzJUi7/Qr02dZFYAI=
X-Gm-Gg: ASbGncvcp7A4absNS3koyj6+zcKDJqlUwif7XpxHPAk+mhkwEiX4SatWEpafCvjiTz8
	lM30lIIwTbstmIWrkd1YJmPlr7V2sOAjhAzS2qIjRUn3pXMe+m6VBAofllQgNZLWxLrejlwLBlH
	D6BdA/Ms9t7RYwGjssU2uFaB/zBku4ZRlmAV4jvu9mnJVYWyeW213AKk0Gkv2X5OD9xhSmiwUHa
	hXQKXK4qIV9Th1Go1MlG9Tg0vxNJ/hDh+meI8j+sonC9uvxfFLyZ6AwdOkz7gIyZWxWgvrHKIRD
	De7O8XkOIuCC9NhPHjpaXqq3/GXIZBNtkbmFa0wfkYgrMKHuuUYyB9IwUHK56bOE0Xm+HMidkPN
	b/nEFB8rHZyWMrhqAUEb9Xw==
X-Received: by 2002:ac8:574d:0:b0:4b5:e9b6:c96 with SMTP id d75a77b69052e-4b5f8485b15mr71231921cf.7.1757407677911;
        Tue, 09 Sep 2025 01:47:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8NeMee6C0kM9sHZRCMxBaDlxp5DxwY+VBvze0KUdNj9nDNquj32l32DlypXhISIsSj6zokA==
X-Received: by 2002:ac8:574d:0:b0:4b5:e9b6:c96 with SMTP id d75a77b69052e-4b5f8485b15mr71231871cf.7.1757407677406;
        Tue, 09 Sep 2025 01:47:57 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b047a90387esm1308826066b.0.2025.09.09.01.47.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 01:47:56 -0700 (PDT)
Message-ID: <a4f339f1-9490-4ff8-bd92-9b03c8f62ccc@oss.qualcomm.com>
Date: Tue, 9 Sep 2025 10:47:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] phy: qcom: extract common code for DP clocks
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20250907-qcom-dp-phy-v1-0-46634a6a980b@oss.qualcomm.com>
 <20250907-qcom-dp-phy-v1-4-46634a6a980b@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250907-qcom-dp-phy-v1-4-46634a6a980b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=eMETjGp1 c=1 sm=1 tr=0 ts=68bfe9be cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=eeBydtCU-ummJPyDYfAA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: 6AaQOjDwjA6WawHKZ4KOje9d6FyYHfrM
X-Proofpoint-ORIG-GUID: 6AaQOjDwjA6WawHKZ4KOje9d6FyYHfrM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAwMCBTYWx0ZWRfX78i9k295S9bm
 8cShiWoEkx/t30prkbtP/Dse5xL8PGDo++cawliJ8OSBJt4n45EfBUTozwvd5UyyHfqFbEERrcw
 ZURGT0wYJkDfXRCn/SPDWkROVOuAILY5GC4zU2ntATEtcAw2OM9oP2mMPEj6Q8ANm2/FG3DwonB
 s2Exxl5wzI/wxkXtPowl9EVbBK3KRDo0qGH5P3yE5sNZbn0GwyFspcH01TaNv+LIILY/cCQwJ5R
 2cM4agWOH2PAbc8rSBynUMu94bFOk5dHdpJeGT9fxCSXkUnPGA9VUTHH3dpIxv0TfdYWqf8L5XF
 5dDxMjpZiFnWUEz16yXHsJp5OtGuObTHzwqYLn5zL4Gm5UfjTD9Ag+haPuTKIZFKJ4x6BHgnqjC
 yfFlS1ip
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060000

On 9/7/25 4:52 PM, Dmitry Baryshkov wrote:
> The combo QMP PHY and eDP PHY share DP clocks implementation. With the
> USBC PHY gaining DP support it is going to get yet another copy of the
> same code.
> 
> Extract common DP clock implementation to a separate module. In future
> we might want to extract more common functions.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

[...]


> + *      |                     |                 |
> + * +----v---------+  +--------v-----+  +--------v------+
> + * | vco_divided  |  | vco_divided  |  | vco_divided   |
> + * |    _clk_src  |  |    _clk_src  |  |    _clk_src   |
> + * |              |  |              |  |               |
> + * |divsel_six    |  |  divsel_two  |  |  divsel_four  |
> + * +-------+------+  +-----+--------+  +--------+------+

div6 is oddly misaligned

[...]

> +static int qmp_dp_pixel_clk_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
> +{
> +	switch (req->rate) {
> +	case 1620000000UL / 2:
> +	case 2700000000UL / 2:
> +	/* 5.4 and 8.1 GHz are same link rate as 2.7GHz, i.e. div 4 and div 6 */

"(2.7 GHz / 2) == (5.4 GHz / 4) == (8.1 GHz / 6)"?


anyway

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


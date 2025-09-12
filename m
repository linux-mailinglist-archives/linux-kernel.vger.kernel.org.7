Return-Path: <linux-kernel+bounces-813058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB279B54040
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 04:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBB1B1BC45B0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 02:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021BC13B7AE;
	Fri, 12 Sep 2025 02:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZaBtnepj"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF1F2A1BA
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 02:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757643322; cv=none; b=QjxEGkc5MkScg5nZ1/U+BtQ6GMRsj2+UPJcX+GOVeFz62Nnui6AI3CBaRIeNsG+JGfl2CG15UiqUvKuWQA4f0WPc4qykItPDKk+na3C24KCPVheF5xlVT59iBfUbppCdd4ENKNG1i2LlntCoTtKEt8Tit1PPZEW2nLJ2XHvHWcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757643322; c=relaxed/simple;
	bh=nUnsPdoniE+tkUSymkZCpEkvCRw+wyDI01SPNexGmgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EAChiPLzBYVhhnlXNjj/oCA2rgZfVYePtYujLCaRiQoT/fc6Mxeqm9f3LOpwwUkQE9NhhAgECH0VZBwswGvVp/a+skm6uLTvzd9pKvqUjrSuA4U2lRtjL9t8/kcp/VQ84EP3S8Bgi3/gWNJgsNtgjBVnMBbfbP/TWSmEQvdrOIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZaBtnepj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BJJ3gc032588
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 02:15:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Hkf9o+nS9HTVNHq6n76xt6lAi8TAxB+Rb2oCezdkjY4=; b=ZaBtnepjRSjQgZLO
	qPvFGKhjsOTfW8Iv5WaBy3odjk41lZqUqNiiDifSR+/4AgUhKG7CAW7AhLOe4+tG
	5RDt82j0++qNzCrNelzF8VXw5iqx8m38MqOKFGysZCZXl9yw53jCYaDS1Mz+zLYL
	gAbx72dpYZb1Nx/QuUSxqPJbHWrZSL9z0kpk9kDtm+/5KoToUXcbBfQHfdLb+4kb
	znk71yZ7ekCmjUiFF5EXKRO5gPws5UCMVFhZzpVB5dEXZeZfSu6LRAtNfw93uitd
	w40eVQzp5FwMg+Fhv7P72+e7GUPMPofxIGJ+WXR8ziQZ6xa3kFTsxq4HLy3RDNdC
	Hln4tQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490dqg9nyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 02:15:19 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-329be00e966so300126a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 19:15:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757643319; x=1758248119;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Hkf9o+nS9HTVNHq6n76xt6lAi8TAxB+Rb2oCezdkjY4=;
        b=atnKiKLgGok3DyZGNy4sDiQxdqxUx85WcWNM9GEG5Lu4bpvEsjcOP0EWbmvLr46dPG
         7LPJ9kavIgIfgoFixZyhL9Q+/j/qSJAAn1S48KvzJTtSOhM9tj25sOjQpj4iDj+B1xOG
         eENkXX0Vry9ioIKBHr2E4IuqKgcB1KgZezEFCbCLZGzp3hpQsP2Ra7vCWDCoxwmH+Rnn
         AJC2dwu0Jt2ALQ/ZuqOeCuskwORWUzvzoFhYjsQNR6io7i9RqMlDFuofShhDIG6Hai1z
         n8wWblDq112OnNGIjw9ZqcTBBDFTpFm2MsrjOY01OLyM4PPM+7bCyuMaAXZgVUeud5cE
         fA5w==
X-Forwarded-Encrypted: i=1; AJvYcCUXJR6+KZ6vczdyTCEDPEy0b0J7sRdjzs5VZQpQrPPq/vKVesAgeFNkSvRvytY3xUC/uNqVPv7ckNeZ0LI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyohRYyMkmEVNAkCpcRZr6OC+dVLtLzxBaW8mqgA6xibzrBDPwt
	+i54sOzurRgWtoFi7mOuedzvD9IuGE04aPaL/f9wK1ncQwNBKyb8OV+w225QCR0+oAd+bbh/kMg
	Qed34HxZ+9GeTZ80j57edcsQwJbx6xEeKt1fGdl+kKhI+NNY5qGbtX34IOQZTCCXafB0=
X-Gm-Gg: ASbGncv49vSBfK+EDlcdUO4tpHMP5zoyZ3cAKoU3Xw4AzG8j4+xyz/DYs7WUjQGHBUW
	Rwtr7+sAFDJ6VKYjV2Sw5BPFHQlZF/RVZlMfjEUpp4z4bDJgeHLH/Re9n8I/fwVtK/4N4n51TPR
	d+acACILK9shcB6XNu9xHDbWBTppBt7efuWLqwpLUOPkCRlOH7nM4a2uKXDO2X+dlOKoEMsH7Ep
	tT5WCl7ejWStWS8b81a5pE8NgCtIi33KuivM1eoN1Tko67CBHCBm4y27i//Pfnvta4MN2G55woy
	Z5nrt+GEM/hvNullx3rFyS3WIx+kAqX6/XfvvVZQEM/UY0+cdxkotHpR+6q42zeZ9APVPOoaY5n
	TfU0YBVkYV9CkReud/uRXHnkBrc/rDg==
X-Received: by 2002:a17:90b:4f8c:b0:32b:dfd7:e42c with SMTP id 98e67ed59e1d1-32de4f90745mr761544a91.5.1757643318977;
        Thu, 11 Sep 2025 19:15:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFq4qCtfCRzD4DYH+qfi319AoKpVQ/JAo5O1h9fSmiMtLZQuLKN33nsWtedkSONVwq6ENs6Lw==
X-Received: by 2002:a17:90b:4f8c:b0:32b:dfd7:e42c with SMTP id 98e67ed59e1d1-32de4f90745mr761524a91.5.1757643318503;
        Thu, 11 Sep 2025 19:15:18 -0700 (PDT)
Received: from [10.133.33.174] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607b1edc7sm3597818b3a.66.2025.09.11.19.15.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 19:15:17 -0700 (PDT)
Message-ID: <e974ffc4-9bcf-4de3-ac09-76b34b47cf5b@oss.qualcomm.com>
Date: Fri, 12 Sep 2025 10:15:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/13] phy: qcom: qmp-usbc: Add QCS615 DP PHY
 configuration and init data
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        li.liu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
References: <20250911-add-displayport-support-for-qcs615-platform-v4-0-2702bdda14ed@oss.qualcomm.com>
 <20250911-add-displayport-support-for-qcs615-platform-v4-4-2702bdda14ed@oss.qualcomm.com>
 <3ihzpsmf3btzeltxggdnbheji6bdeornravua76adw5dhotztu@e3fca2prl45r>
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
In-Reply-To: <3ihzpsmf3btzeltxggdnbheji6bdeornravua76adw5dhotztu@e3fca2prl45r>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: bCRrc4PNBIuK499kaoKd9_4rEE9DnOZk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzNSBTYWx0ZWRfX/zuzmKFrnpGX
 ukjTSHUHDBSsq0tGQuj8r7shx7L17YxQPLkqMoC9Zd7e+7INMFJVQDcG1L+bRG/MHI/7kW9L3v4
 QZtJov0ajeVsngM82tCQqtXtRq/33LmZfmHGosF5LDRcU30znIRVXnnwKCnUAaeQh/ZuJgM296V
 0HBfXFvl6NDH0r8a9QhxFWnTSU0WElT7iQv8N4dm6M3429qQiyDGQ0FAZlko1wq0WgqPlVciwYh
 j6njr/7SUPIWUTTanopoH3+iPlQgO7G7/IZTu9GlncMQWzHTUmilqvHrW3RmGqSopzjx11RC6PX
 gpT0jIKDBNl+OITV5omj4DTdLnHsia309VWazMxrS+HFhgWkCE9TBdqbX5FXgauMjEWqq1YGVPr
 5FT5oKWZ
X-Proofpoint-GUID: bCRrc4PNBIuK499kaoKd9_4rEE9DnOZk
X-Authority-Analysis: v=2.4 cv=N8UpF39B c=1 sm=1 tr=0 ts=68c38237 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=GWYxvd0U3zBiv3KBAmEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060035


On 9/12/2025 9:24 AM, Dmitry Baryshkov wrote:
> On Thu, Sep 11, 2025 at 10:55:01PM +0800, Xiangxu Yin wrote:
>> Introduce QCS615 hardware-specific configuration for DP PHY mode,
>> including register offsets, initialization tables, voltage swing
>> and pre-emphasis settings.
>>
>> Add qcs615-qmp-usb3-dp-phy compatible string to associate QCS615
>> platform with its USB/DP switchable PHY configuration.
> This should be the last patch in the series: once you add the compatible
> string, it is expected that it works.
>
> The patch LGTM.


In v3[12/14], the compatible string was placed in the last, and you remind me
will trigger unused warnings for the earlier-defined qcs615_usb3dp_phy_cfg.
So I merged them in v4. 

If move this patch to the end, patch v4[07/13] will hit unused warnings due to
missing references. Should I squash patches 04 & 07 and move them to the end?
I'm concerned the resulting patch might be too large.


>> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>> ---
>>  drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 141 +++++++++++++++++++++++++++++++
>>  1 file changed, 141 insertions(+)
>>


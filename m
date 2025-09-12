Return-Path: <linux-kernel+bounces-813908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E78DB54CD9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 888FAAA6F1B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B62D305E00;
	Fri, 12 Sep 2025 12:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Lt+f6//T"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B92C3054E0
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678460; cv=none; b=oyxTIOi8a8Jk+t9hUKHdiyt/cpLnwQKBlaikOH9LQD8wAY96WYRCCNmaKBE3lG6CV4RsvA7q8DG5H5Y38RZJ2FVk7HPidF1JQDOqbtMnd/TxoywHwnZUGI3qH3KPSQcc1V7bMkoztolAq7VxgilXW8qXslWArcu0DSkFFcYCoDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678460; c=relaxed/simple;
	bh=26UCG6mcsHCJYK7t/iVJ83hqO7D3+2hpEfCS2ouqMi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hfioCSTYV1NvO1koxY1QMFvOR5gdBgYt5vDkbyncmbXSMjcfA2B2LKiOcw6pflbZuYiFMkLAlS1Z242MgBJxHhJMqeuvxUYn1BfIz5x81uBjlrqn9pwhIYD9Tg4ugd0iYSoqWhzLXBsR9ieJBgFRToPi3jyDQ6Plc+VwEl55k1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Lt+f6//T; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C9fDo1017418
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:00:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8MdWDU2Uyypxys9C+gGfTrGxJ8Ztl4i13k8tb6lf2HY=; b=Lt+f6//TKAvf+thd
	4RoLaVi38xbabaR0TvVfcaC0kLc9G720+QBnDakbquJ3gwVDgPtZL2dK6bLQYssW
	kBX3Yh0xE1GeFrkJeiaYwLN/bgMSJg1WzzGP++TI98hXn7/omCxCxIK3wyluLgNk
	qtOXTqvCYOd2B69u6zogxXTGldX4SiTHSRQkgCJU0m4Vg3GZGSqL4iQl9sZUF1bc
	Jwc/LmwvppGZkvZbcE1cPrs/k6aSaDTHzzNIGuOVAliYQloikBFzK2bsOtpYWRcb
	ZTNXwzwtevqsW/AqNlTH+c1rIbGW9eaGpvTp+/15L5QeuwxdKuxfO6BxfZ7t4DOr
	U1kC8g==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490db8umda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:00:58 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b521f77d978so365334a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 05:00:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757678457; x=1758283257;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8MdWDU2Uyypxys9C+gGfTrGxJ8Ztl4i13k8tb6lf2HY=;
        b=lwhtn7JMUDyKj5lNGldIpKFfMiWuoYX5mDRzuRl7tEO9bGvqMU6p7P2wWOBI6EFFV+
         MK0rlBrD7NS5OpK/ns4/3ZzbS8Bvpawyl1AuFFVVAQA5bnAGRljkTDQuxbtpwVimq6jA
         5bdwdEzSSE7Mss68Z3pJ7OiB+kxuITCA7CS9bPtpbYKgLOj10mv1lxSfLRfiWVeg9wYm
         DyTudZVL6y9JT5TEWQDpIin/Rggg0ZzaSpymVmTXvyW4pTugWnlQfE5Bw1DOlJp4wGKq
         jtYN4xp2OjqA/swntbOnVxr8LNpHIrRjgbeptoSg05YrxLzi5Qombm3crLWtsumeX31P
         L75A==
X-Forwarded-Encrypted: i=1; AJvYcCUq/8XiA/si6e3Fz0TqNq+BzNQFJVzGAp3xDOJXV6n11ueZODdFr7VQpV9ljbjT3TbeXQKb5owIX4da9js=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQw4flPrP0OZjO/rLaryQUmwoOo6fQoyJ04UhYcCksjc03/0R6
	IUOGfuqRn9PgSrROxzYyFf05itvwH7G02w6UlHG4J2IfwO0SI7m+62vALwSnEwgV8eew5omzbh+
	8OZlIgPP5zYPitMzanEzNe/4slnhK1NsUTn5S+ZOmBdVnsdXBj+9LpGWYDIZNkGyB+tE=
X-Gm-Gg: ASbGncuIbouvzNpTMqC8UKaniO7BzJ5CRwURTQN35rxw5jxUiqzBnk9TCL2kRQpgIk+
	9QvCU2v/r6RE1CoPkQm07J/aODngdGSH4iq8BBXjO1trz4rsbWFVUQRXArKy+OTaant5By0rr0j
	o32NMm6YkcITKjKZOm1lhYMzSULEfTJbocU3wOxsKchRgGGbWvuYvke6QIhv0TSYr+MeAHhwhnb
	/MO37db+v21PcH0CEEnGj/GAZzsjEyJfksnHLYlkiXLb7FjkV3VE+0+F3IY0FvpQqvoJ7IOTIwz
	+gfHFWTHiUFvfK7WAVlg5IQjzzsP7MdiAeMgj/0+lMXpm2De64mAEq70uSfMQCfK7HkcEUFt6Sm
	QDagubJknOPpeMnPPQAp56PnLF9YhzQ==
X-Received: by 2002:a05:6a00:39a9:b0:772:29be:e006 with SMTP id d2e1a72fcca58-77611fc4e71mr1825313b3a.0.1757678456676;
        Fri, 12 Sep 2025 05:00:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyWZ/RCwH5uoedcQ8POSwjS4P2D41yWOMHKovMkWcY5GLr2xHum8zhLBWbP5bd/3+H2e7PZw==
X-Received: by 2002:a05:6a00:39a9:b0:772:29be:e006 with SMTP id d2e1a72fcca58-77611fc4e71mr1825274b3a.0.1757678455923;
        Fri, 12 Sep 2025 05:00:55 -0700 (PDT)
Received: from [10.133.33.174] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607a48c19sm5291497b3a.36.2025.09.12.05.00.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 05:00:55 -0700 (PDT)
Message-ID: <11fd5d7a-e084-4ee5-9f34-2ec0481a1d46@oss.qualcomm.com>
Date: Fri, 12 Sep 2025 20:00:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/13] phy: qcom: qmp-usbc: Add TCSR parsing and PHY
 mode setting
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
 <20250911-add-displayport-support-for-qcs615-platform-v4-9-2702bdda14ed@oss.qualcomm.com>
 <x6p3hgatsauguzxryubkh54mue5adldkem2dh74ugf6jf3ige3@cb3mmigu6sjy>
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
In-Reply-To: <x6p3hgatsauguzxryubkh54mue5adldkem2dh74ugf6jf3ige3@cb3mmigu6sjy>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzMSBTYWx0ZWRfX2QTYfsTQkDOT
 RCf4HjVOxHugxhENQYrqhrJZcNJyj91CT/nQgh8atoGecFBzcW0uSK23SeqdQinQQdaxBiGbbPn
 Q//HXYcuXGiqy//+CadtVkmOHlMZYNvlzPgKYvn++xB3kz1WtnWYJG17KreuFbsOMgRmayrJ9DT
 AwNtkScOhjK3Kxn2VqN6aPMZWiRi9U12uBmQcWl7lseb6BoyLhJlZBB2TABzYKEj35roGL5sJkd
 zJI95ay1MVPy7r05hHWpIHKDYX70HJ1CvvIxrr+/82t8n/qDz3PjmQWxpCeTY9X4dkXueQcwoWT
 kNgTRJFLUxrZMh9L/5cFJfM2xWz7I14U7/pqIfMlzgYasWYwzimeI7GUF9FZjRYRs3AvAmLqA2u
 cdffEmOD
X-Proofpoint-ORIG-GUID: tyXI0fQcSepIjn_Yun489L1SF_7ktq0N
X-Proofpoint-GUID: tyXI0fQcSepIjn_Yun489L1SF_7ktq0N
X-Authority-Analysis: v=2.4 cv=VIDdn8PX c=1 sm=1 tr=0 ts=68c40b7a cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=1bTgUAhQIaiSlqBNWd0A:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060031


On 9/12/2025 6:20 PM, Dmitry Baryshkov wrote:
> On Thu, Sep 11, 2025 at 10:55:06PM +0800, Xiangxu Yin wrote:
>> Parse TCSR registers to support DP mode signaling via dp_phy_mode_reg.
>> Move USB PHY-only register configuration from com_init to
>> qmp_usbc_usb_power_on.
> Two sets of changes. Two commits.


Ok, will split.


>> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>> ---
>>  drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 47 ++++++++++++++++++++------------
>>  1 file changed, 29 insertions(+), 18 deletions(-)
>>


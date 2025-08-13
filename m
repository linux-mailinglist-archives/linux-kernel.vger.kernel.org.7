Return-Path: <linux-kernel+bounces-767386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E3DB253A1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EA8E7B809D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 19:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD0623B63F;
	Wed, 13 Aug 2025 19:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G6uJk+M2"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106A72BD5BC
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 19:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755112069; cv=none; b=IWLiedSfA8O7Uc60TI7QJSUU7ZBWHYE8Qo0apzppLu5A7ZNUR36s+utXeJQv6319o5N6DGLf9ey38ylt/KbT9dZ2ML7HKfqE9U3iHFuoYn9cPA3LraO7AJpVXikUBAAmjHkgjOY7+J+fEy0TsPgjv6COA3P8Kuk3GeLR3KJGjNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755112069; c=relaxed/simple;
	bh=WCbeaj9cuuf/zmyd2iAsdv+J8nh7PcnIVnjEAOvB+Fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qxvQRaVREq/MkZHwKKY8UZvd/T0yxg9YrYVNyg7p1yZAmO0ZNsDQOX6MCaKO+wtJE7jwZcGCQxUSgLxi/rO/4DJ0S3t2Q5GNPdZ85YfXYi1aqg0rG8MgmPLr42BsWVrPEnuQPMIxj9KA5dNSoh8W0CrHOpJ4y2i1Jvha9E8TMxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G6uJk+M2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DBLciw011176
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 19:07:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=lGgb5haUX0R28BdimfN03qfR
	bmNTvI4oS3VC1C2Vmak=; b=G6uJk+M2+jklEiWGmyrHG9f3JHdZAL2475YQTz0A
	4BY4SG/1M4kIhkW7r2TBSyTEgsqCLQY1HrXPp71DlQmaby8irvY0PQPu5Jh18iB6
	mOOjTzw6FaFDtL8Qvvmxnlk+EBtM7JbWmN90egOhu1oE/uGnQoXSCNKEC27Ulg6Z
	9hScyVdM2koCbJ+/X7hBxxrvTEu/zGvpPZY8QlYrENBdt+RnYebpJLc+qdcY0K/n
	s7/6IrViwUTFPI0wNJ3rzj+eFNhvJyNyRbIuEVM55rfud8tHq2yxaKPFhhktXHPK
	48HYH1W6uC/PI2sRDgc06KLnktx14CF8cIhMA6QtcPzuJQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fjxbg5u8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 19:07:47 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70a9f55836dso4740556d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 12:07:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755112066; x=1755716866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lGgb5haUX0R28BdimfN03qfRbmNTvI4oS3VC1C2Vmak=;
        b=cdjP8cMsbuuOZBePDczS6TQjYvkKrapoTJaICg8kxXQaAGZuR9OgTXSAwHhCexllZL
         mnqZzIAl/+Xlc8+7GKxPMY4cVcY4fdmdRHP6wbwU0KK3whVGzsUhg2mAd+WFjKbOR7Bp
         B2jlJLOBvFWOhFAHdcj1myds0FCzdCqiQsXCMEJsg98ZYNGgwS0yknFYIS8tWtGMa2Bb
         xL5D2fE7fLJJ+RW7nZG5SRk8kPxPNbNE/B++7i2PsF0E+D0zLkAApYHNkXVWladVLyqb
         HnLxVdzsECyrI7SDfp6XK7wy0PtTAA++oZYC48AojWnbozS6sn6Xc6ciiJ3C+/TkGX6I
         QNoA==
X-Forwarded-Encrypted: i=1; AJvYcCVseC5LTItcuxBl8cm81QX6UBiAgj18qoy9N7etShfbWtvwwkZyTor1ewETQSwbpraa9Ga+xw7tyrvvIyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUhyX+S0ykaedDST8UhXcGjaospJoBMRfuNBD0f1qLbV7ASy2I
	rFz78bZBhL5sKBZa7rrcv50GA9tcKS9AVvn3GQIbN8V9zqVHASJlUUrN/AERRHQws3RlneyWZVG
	RgUe4AcHq/Xu4A/SqkBnuYGB38ji4nIdICzeYkXMxRm8iwK4kNSs8ga3cYBxUIU7M6Aw=
X-Gm-Gg: ASbGncu8LSn2B7JntiqirAuex4ZsX2cwTIJSOGhwlHz7eZ+9Meup6D96VJoDeLJTp70
	3YvKZrc0UU7osnLti/7Amf7+8Tohuo5H3CAOQ3jD0Ui9VOEw9kc5O5TVOUegTxRBIPSjIfaZOl3
	kxMzRaRAWdDhMG8YdYj2piPSBwWvA66KEoZ29P0nuRYAq3eph2mnufDrp14DAVrYxXVaQmaTTA3
	tEYvmgI0XiQ8XDzfJBTceZyGjIb5cjMOWeOAUSkqbgpEC7u5KTnIwLdUnlNO92Zmu9N/XgN278p
	NX5UCURC7DI5OfAU07RXzHVx5Uu/UdEfhx/bkWi5S1v1BL9XIWE87rpCvRCf9hi4vg777Fe+0Q0
	mTb1T+pFNN9w2voFoEeWnzPbI0NTXxM+bBGnVsGd3r5rY1FNrViu0
X-Received: by 2002:a05:6214:2245:b0:707:6364:792f with SMTP id 6a1803df08f44-70af5b8042amr5890086d6.11.1755112065953;
        Wed, 13 Aug 2025 12:07:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5CH4F+MncTr6A3qh0Qne1j9KUeMdHfJ4BuHh47gTWxWDXbgOj4yyXBcS8NC2bzatyhL9TWg==
X-Received: by 2002:a05:6214:2245:b0:707:6364:792f with SMTP id 6a1803df08f44-70af5b8042amr5889626d6.11.1755112065427;
        Wed, 13 Aug 2025 12:07:45 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b889ad021sm5413158e87.74.2025.08.13.12.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 12:07:44 -0700 (PDT)
Date: Wed, 13 Aug 2025 22:07:42 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] arm64: dts: qcom: sm8750-mtp: Add WiFi and
 Bluetooth
Message-ID: <zwqjinjqzs7cdbsb2yduym6jx77kjqtyjcinvo3mqvavdj2trz@cmwm2nlynqlu>
References: <20250811131055.154233-2-krzysztof.kozlowski@linaro.org>
 <l6u4y3suv3dpylexbiiznhcuyanlc4ouizhzj2cchblaf6o4wg@fe4laxrioaj5>
 <481985cb-fa84-4b09-9b95-948ee70b557a@linaro.org>
 <k7mw7rj7cno3con2t57nps23y7evd3da6gahyl5gnrxss7e3s4@qncnuekxr7lb>
 <f7704cc1-95b4-4860-86ea-96ec18f61c8a@linaro.org>
 <ibitgekdjsktpvr6zmouuhgzcbfjfeuv4l4zsl6vszv4hauug5@one6zo6gdykb>
 <3239685a-97af-4d56-a0cc-984f26db5f76@linaro.org>
 <3jrs5gkxzjgrjmfbd65qr3uzblzzz5ae4apo5qwpxb63jm4i23@jzpaxp3dxais>
 <8fc497df-116e-4df2-a33f-bd71476ce065@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fc497df-116e-4df2-a33f-bd71476ce065@kernel.org>
X-Authority-Analysis: v=2.4 cv=G6EcE8k5 c=1 sm=1 tr=0 ts=689ce283 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=YsNNlNSR1bvWMWsHUq0A:9 a=CjuIK1q_8ugA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA5NyBTYWx0ZWRfXxiSz73FIT6EQ
 UHRNGYZyM/Df7/z5Ax/lKBWp0xdyPmJLuk0f0Ihsb/n1Tyl+w+oDO1WoKTcyjkBqrUFklHaMFha
 Zl6O7+IpJIwogpMFaXEur07M7Tk4T82wjJr+RXmU/QHBJ5QJTAYAL9cJePJOHom9wN3Qk8/hozY
 yNmcG5ymE3DtWjksQAG2/Eu9l/pHT90COrjXKUTQydp5RLUnBHQ7vWSpHXAtxaE+i+CmvTCRIt6
 kC47vMSi0Ug6dW9cm1TTYTjkMYOunjuRCQa24dFzbbgOIqouc4nEwr+/1hd8hT9WfdQdwFOahzM
 h8xEo0ExI/SbP3YjXaLqO2+F5QwPh4T829+f0/jaC8K0NEdb71QsaEsWpFS0oQXUgHwVS1Kv+kQ
 aZZY/AXA
X-Proofpoint-ORIG-GUID: s6--IGf4AG0-FzRQh_uYOHHWpp6DH0Pi
X-Proofpoint-GUID: s6--IGf4AG0-FzRQh_uYOHHWpp6DH0Pi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110097

On Wed, Aug 13, 2025 at 08:49:56PM +0200, Krzysztof Kozlowski wrote:
> On 12/08/2025 14:45, Dmitry Baryshkov wrote:
> > 
> >> Devices will be different, they will have different compatibles, thus
> >> you CANNOT have one DTS for both. What else - not my task, not my
> >> expertise, not relevant to this submission.
> > 
> > Them having different compatibles is exactly my question. It's not
> > obvious if they are compatible or not.
> 
> 
> So we talk about basics now... even if devices are compatible, they will
> have different "compatible" property, so your question about
> compatibility does not matter. They could be compatible or could be not.
> Different DTS in both cases, so this is just bikeschedding this patch.

Yes, we seem to be talking about the basics. Having hardware which is
compatible with another hardware released earlier.

I'll leave this to the maintainer's discretion.

> 
> > 
> > We've discussed this offline and I hope that the next iteration will
> > cover all these details.
> > 
> 
> 
> Best regards,
> Krzysztof

-- 
With best wishes
Dmitry


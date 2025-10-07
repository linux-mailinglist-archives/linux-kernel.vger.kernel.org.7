Return-Path: <linux-kernel+bounces-844081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B232EBC0F3E
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 12:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CE4124F430B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 10:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B81262FD7;
	Tue,  7 Oct 2025 10:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="psgWcGo7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5853C2D6E69
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 10:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759831415; cv=none; b=ZY5EbNDxTQofHCYBRI8RkuteP3O0MexrbJhoqca4uZyhbC5lHQ7FvF09WvwANI6oJF8fsmX+eObYUKwW0LRx5KqPqLevKeqVGosYLYt+BdXkslivgSbAU+Z7HLVB0Id+O0loLjdiHZ69gbc/LBbfVu43rZRjLZPgPwKYPz0GqAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759831415; c=relaxed/simple;
	bh=L8Q2C5/Ub2uJq/QGtFgBbZf6xb9DzU4bjBeSblXm4p0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q8VrG77xqIfgj2qJfQcaY3WXeN+67KMFmosmMdJuSygeMiQCNHbwV0B7goush11E/SVi3D03xal32K4Eki7Xm31nrfZgoq6mDuwGjI+qvq+4BA74EJOgXUjrWtR+3BMRxBA2wVkf3UsGqUmQCGxdvchLTE5MAb25kKHSfQGM6c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=psgWcGo7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59731WEB004323
	for <linux-kernel@vger.kernel.org>; Tue, 7 Oct 2025 10:03:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	llIeV7D3qZ9EMXJGYTsCRVvmxarIGOFyzxq3f1h8DLw=; b=psgWcGo79wVpASXP
	74n0WlpHkbJBz84+WKHWz+uGBu2O8olBlalaS/p1XxgI1WmGdocD7He953nWCP0P
	HvCg0dTv1+W8S19QZ4cq1KO01D2R1kUAYkbHm4RryWf1emoXLBfIXcnITM9zuxtb
	Vb4fDKbKJ+JbK/1hhyLryTh0BljHq7xdtVUTSt6m8KYqhamzLTkmElvSYJvIp4qp
	0tsmnPKELwAZdU7KfBDH+JBaqbXiYk6knrY9qhVClmMBV9a4MXpo8kw5Eeb+WMHj
	uF19CZ4oCJJrZceg4uGmo5dDfak8Pbi+SKObWq+mNA+o84jy0nlHjQ6ErUj76DbW
	shIkBw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jtwgpwaw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 10:03:33 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-819d2492a75so281832685a.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 03:03:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759831412; x=1760436212;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=llIeV7D3qZ9EMXJGYTsCRVvmxarIGOFyzxq3f1h8DLw=;
        b=EloD5KbM09V67v2HEdPuM6nV3Vrvds82O5O0Pe59p2AOGkrAgMVEdv0Qs/XqAQb70b
         OVaTKx7gkfhcXpphm9YYdU9xo5HKbki5MSqD8H1RVQfTFFf/USkFCrMCK90lAYjLhn08
         y1SAtWgriAPTsog4SnLJspGMnBLUc5y1NzKk5UsO4ZH0BH0x/wtOOY2RcgiE8TF9nwu6
         8nbOYmlhtmLOX3AVU5nfXkbq8mc5Wp2EY6pIlMQ1DPpQZ7o9tBOXmtIdFKR7MnSQQExe
         6QV6w7QCaoo19QpT+fLntNb+LMLu6Uu9K1whVpP09GyPwajrwD0vZkNbYdnd9iXPCmyr
         n0Ow==
X-Forwarded-Encrypted: i=1; AJvYcCUu/gMytD1TNWuqmWZ42EavIE2QpEVx0/k/lYSFI6zQE11RfV/QrckJp0XRDB7wDjPCI6KZekpdviPsjR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlsezvPVJs9yTcKObLybg0bUW2n+oG6Av7ZA6ZwdlB+8Gp3taW
	13ZriqhZSXoPRvozFgE640UvaesyELa71o64fFRAyswMLEZrNAZmTr2FgCy6iFE+EYTEhJA/+yY
	2YDgnzqehwzo6pGmy/0kUADht7U7/1G/ubpwJFLezrKKowEtbvszLVQm7Gk3QfA5ark5UnMswFf
	o=
X-Gm-Gg: ASbGnctzWPAFNiz4m7GaKSGpZI8qPKr8t6q+V9rDmdnhsZ+Rvr21/FCBLxyIBNsTkzG
	btFdEvRHB+YHTRREGGcy66nqsbhYaZtVP1a4XFSHeEo3wU3A6M8EAAd+JxYUtKqYNCxpD6wQ/SR
	h/hXAh1h1RHc4OKVYS2HXea71Kz8G3e7iLzbEQa/MQNvtpTKxz8XqnY7sgrv2p4P/N7vt6UDG4S
	K8EU1li815v3PfEelrz49u6myAVxwhqdRzY9LmAv4M8/XWnMbmV6lYxYPqyB0zvkCk+yURE8t4F
	R9mmo8TfOCqC8g8qhbvQ8zWkmwWOy0hljuQ8nTAT5x9mWpZWDzJ6xrx9vjnfQWn5Xt5CwRy8Eio
	tB7WaANfhW9t/Ldv6YNxCK9xklfA=
X-Received: by 2002:ac8:7f87:0:b0:4dd:3948:3380 with SMTP id d75a77b69052e-4e576ac46b6mr120455871cf.11.1759831412026;
        Tue, 07 Oct 2025 03:03:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH595GqzjdhPhPl+ER5dVZJGuod+xlkaWX0Q5/bGA/gl6UrOFg8YE+AYMFgUODCYAkuO8cjhA==
X-Received: by 2002:ac8:7f87:0:b0:4dd:3948:3380 with SMTP id d75a77b69052e-4e576ac46b6mr120455621cf.11.1759831411403;
        Tue, 07 Oct 2025 03:03:31 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4869c4c1f6sm1383798466b.78.2025.10.07.03.03.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 03:03:30 -0700 (PDT)
Message-ID: <6c791f05-70e7-49c9-a3ce-50fb82b0c894@oss.qualcomm.com>
Date: Tue, 7 Oct 2025 12:03:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] ARM: dts: qcom: msm8974pro-htc-m8: add status LEDs
To: alex@me.ssier.org, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: Luca Weiss <luca@lucaweiss.eu>, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251007-m8-dts-additions-v1-0-53d7ab3594e7@me.ssier.org>
 <20251007-m8-dts-additions-v1-1-53d7ab3594e7@me.ssier.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251007-m8-dts-additions-v1-1-53d7ab3594e7@me.ssier.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxOSBTYWx0ZWRfXzoadsZBBHBq8
 aBn4zk1tHJ8s40Q5CS9i4uL/emENAvpevOSMP6oGSdgT4pYycNewq6mK4EGcK8c4QttFskMg2Rp
 0/Zj5tJTEi7Nis00L1dX1cXzf/l25yVOGmGYu2d7IcZAuwJV0+igyoGZINJa4MgJrgpbtbOufk2
 0By6RbLcFR0JwTKEva9fJgJ7DB6GIRD+WeYdHZRlcicJWA1ssAXWXqsu+EoCDPJw3wb+jGt+BD3
 Y2iZPhEeLiuBsBvc+ZBCJZaraaEAuq51i3ocVGjj0QjgzcRpZd9+TbdhtFRzxxviMQIc8dhdKBk
 xH/9YYoYQw65FBKTPvRuzHWztziPISuEZz2Bukx3MUxm2ToKbjJNi6u1mP3AfK4Ihpn1hTBmELx
 iCuvBzEDM+xxKt1Hj5llUO8U/CvfRA==
X-Authority-Analysis: v=2.4 cv=B6O0EetM c=1 sm=1 tr=0 ts=68e4e575 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=8poMKPHdAAAA:8 a=e3cHK1UYxX7VBDkIoy0A:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=fyZPtLC9JlAwSkJ5-iUD:22
X-Proofpoint-GUID: gtCSoRlupWMlcKpu3-OrTzGPtXrmcMq-
X-Proofpoint-ORIG-GUID: gtCSoRlupWMlcKpu3-OrTzGPtXrmcMq-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 impostorscore=0 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2510040019

On 10/7/25 7:55 AM, Alexandre Messier via B4 Relay wrote:
> From: Alexandre Messier <alex@me.ssier.org>
> 
> Add support for the notification LEDs on the HTC One M8.
> 
> Two LEDs are available, one amber and one green.

Do they form a single notification led, or are they supposed
to act separately?

Konrad



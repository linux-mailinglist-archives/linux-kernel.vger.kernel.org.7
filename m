Return-Path: <linux-kernel+bounces-748431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 526CDB14138
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 19:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A71017DA3C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E60275865;
	Mon, 28 Jul 2025 17:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UZASoHc+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638D81E7C27
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 17:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753723808; cv=none; b=qUxnf5fLqlazuimnKAI2Y3/V21bGC9yFQK2SdEJ5gJwregmy1WHKrffmFDWZ3LaftYhA+15t+I06ceGmN8rCQpVprQCbVYU0yxar1AWeKTLuPmBE1nUxHjojLKSLmY9PWP+mh4cZCmLpzfub/R239JNskGBLeOQuSpIlThmvF8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753723808; c=relaxed/simple;
	bh=ap3iX8dO9NwUbqcsYbNIAHLFNJiaq1UkawSUvmYP/N4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cSjJk1uzG2LlU8XFOZW4a8aZVR+FejP3QFw8AkIKAldkNztBVvf+Z84+zgePH3v5dBR3ve1ONtDOrIC34/6G2h4sSPDRBN9u+0LLMp5nKgjYzDOKyPGAiqNRS1yFYWvypJrW/XFZUS5Qp/qhH6bXMbsWzfn9WOAhKTzvPO0qOLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UZASoHc+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SAlMq1017611
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 17:30:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V8baPmk3whsruPHJmlCGf4Ss9uEKzwpKHVAYUt8BpbQ=; b=UZASoHc+SxkRRfo6
	SKKnmKU9pJ6aDRSWmpmvwpPI8ca9lBgz3kd9g8gTvRnCedNho/yWlLxfhXPjdBT5
	Igaxj12C5jKaUAz+HVZZhqrb1m1RSo3G/xzVD3a0m1/c4xlbA/wmf5jSbI70PSfZ
	9kqaUPHbNe+yNLq/frlSUgQsyxbwiM4j/x+9VNPgfETUJvyibfMkwG1H0VxdXn17
	Ob66nB87QLCawt4zMdmxK/u22+G4uwkImp/B6xJ9KnafGsk8nGpcn27aCKcmQWv0
	k6AgUQKZlEeSkSg+sx/J4Qpihf0zJG76E/f+WsCy36BKeiyyVIiIZJOY+P8dk5B6
	OadqmQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484p1add74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 17:30:06 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-748f3613e6aso2830723b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 10:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753723805; x=1754328605;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V8baPmk3whsruPHJmlCGf4Ss9uEKzwpKHVAYUt8BpbQ=;
        b=apwE/ZDAzoYl+2Rr0J7nO50OrN/MjA0xkaxzfxqTTy4NLauMH3P19L8ZyMH3LCrWtI
         dHGKnXop/C9Z+Ivijq8DAvzO+E7/KqImOgBo2egoHOhc6ZJX0opSvVM8tSfmENsqngte
         qC+HnCRUNGAWQbM/Yb9fKvzHHkJrlIygyVOkoXxTdblAWJqoSnZhK7+NuNkuzr4SB/L5
         xoV15FWz6KUwyvNY5QU+Yc1PWcgmsXU3iX1RkykIVbTaArzZ9Jo7uocS1YqYyR1L3LHo
         ffAX7Zox8195PkiTZuDnfzwc9/Taaa0jWsTKkcYbt/w6wsNgfv4bVVSokUTPRnDRBTRb
         wSgA==
X-Forwarded-Encrypted: i=1; AJvYcCVhRbOq0CF3QJF8z6B2Y2Elo+XahYwKd9Cw6qloSXc4ZlrBbMgWQUtwoXTR69dFBKVYL5VHTr2H26nnRdM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw99FEDcuHn+B8pQBo8XA2JV9Hv9dBsFqRVvHj9vta/ateP1WVF
	qvirbyKENWg06p9f3jdzromWBwJHl2ojHe0euOKsaBf9cjx0nEmDPEZCFt+iiBGkuOdx0fDLaJc
	wurZaKwH9Xw6UQCD4ELh7yK09fhvRBf/FFoIVeZW32sKBe80CxTZQCOxffWq5xMKzlpo=
X-Gm-Gg: ASbGnctHXpd5qVRVw42rzQbb5lQD4eMNNbBGvwd8oS5twYxe+4aP6GUSpKhNXhN6wW/
	0lDNVXXSyT818ztsu26+n61IPraYxt9c/nFRvWPTO5SrHytqoesGkP5c9g2/6fFIuPztG95orvV
	1p9CG8Oq63XVdAi7H6rkSuy6XZgUMTQq90oKxIsB73NHgBnDR6XbKpqucm/xfGEPY6SQk8lSZVg
	JHDcm3Z3Ky82/LPsc6ylxJ8STMYroiHgA4qR85ENg1oY+R7rzVVpEcQ6q2yLWgf54ZpJYcaSLyy
	LBfscGSrCt8DcnU98T/+7na0QdbybrCPsd/niydEn757I6VHmA+pSSd54k1CqLE1nCk=
X-Received: by 2002:a05:6a00:234b:b0:748:f854:b765 with SMTP id d2e1a72fcca58-76332282dc2mr19231303b3a.4.1753723804947;
        Mon, 28 Jul 2025 10:30:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE398ctDgkA+lnTPomWvP9p7KjWKywgEOmGumttdGwmmzLB7ZrDMrPxOZ4t5fZII29RkFNGnw==
X-Received: by 2002:a05:6a00:234b:b0:748:f854:b765 with SMTP id d2e1a72fcca58-76332282dc2mr19231256b3a.4.1753723804457;
        Mon, 28 Jul 2025 10:30:04 -0700 (PDT)
Received: from [192.168.0.195] ([49.204.31.18])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76419d84234sm5910216b3a.57.2025.07.28.10.30.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 10:30:03 -0700 (PDT)
Message-ID: <0e160d91-3768-4fd7-b9d9-3c12af329fdf@oss.qualcomm.com>
Date: Mon, 28 Jul 2025 22:59:58 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] dt-bindings: clock: qcom: document the Glymur
 Global Clock Controller
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250724-glymur_clock_controllers-v2-0-ab95c07002b4@oss.qualcomm.com>
 <20250724-glymur_clock_controllers-v2-6-ab95c07002b4@oss.qualcomm.com>
 <20250725-incredible-nippy-sloth-67a31e@kuoka>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <20250725-incredible-nippy-sloth-67a31e@kuoka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 6ZNynpbfM3u_JZR83zkywHiRmNeRRBFl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDEyNyBTYWx0ZWRfXy8VED5kXketq
 mZUTKV9Cv9a6mbZXgTzCoSwfl139JAevEHwZzKev2tEH4UeqDtcvN4C5lEdRrGZ1lBxWEfCuNs4
 EH7ynWBCW2LPzcQTH1mit6T1rBEzV8cVyf8OOSAdA/OOGe+xOERCrlEvnpghPFNOznJGZLfYmdv
 GLruZQNCE9ZKx5cYEF40zyt+yAwrDxeeK8nw0J4GZtgQGEdjqG3wUJaieZ52gIxhSztIB8RC/Z8
 mM3bbO9dN7rPtFocZ7MBw1gNaaBEpbfB7Zfg+GqePYElrpGrusYUg3lOsBJbZZuDjlF1sHzvcJr
 fS1Dbz6UHJQOV6UJIuA768MejvCc3GhpX9mbAWk7eAhRx9vDQJEJRNgtOmrMUfnHnIYgIDf1b7X
 fZig+rKOFij5jHgYcT7TEwm5O/mVl+2cP7JGWsLQBM/JTBA2G5XT03tMUibqbLoq6LWubB4u
X-Proofpoint-GUID: 6ZNynpbfM3u_JZR83zkywHiRmNeRRBFl
X-Authority-Analysis: v=2.4 cv=KtNN2XWN c=1 sm=1 tr=0 ts=6887b39e cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=6kochd2Oe038OFj2Hkel3A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=DXtIfFKq8Z6Mi1RCEtQA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 adultscore=0 mlxlogscore=970 bulkscore=0 spamscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507280127



On 7/25/2025 1:15 PM, Krzysztof Kozlowski wrote:
> On Thu, Jul 24, 2025 at 02:59:14PM +0530, Taniya Das wrote:
>> Add device tree bindings for the Glymur Global Clock Controller to provide
>> a standardized way of describing the clock controller's properties and
>> behavior.
> 
> That's not a correct reason to add bindings. Why would we care about
> standardized way of describing clock controller properties for Glymur?
> 
> No, explain what is the hardware you are here documenting.

Yes, will fix in the next patch.

-- 
Thanks,
Taniya Das



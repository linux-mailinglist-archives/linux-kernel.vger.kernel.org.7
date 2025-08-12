Return-Path: <linux-kernel+bounces-764578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A785B224CD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ED741A28238
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502D82EBDDD;
	Tue, 12 Aug 2025 10:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZNklWb4f"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4604B2D59E8
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754995533; cv=none; b=IxWB32anPfc8OHVcQTJXiP8TLIGYsXDvKnXEhVW63WM3uN9AOWfRwMd09C2XuX+9NwLJpLr4j+yFwK97HX22UL4hD2w/KYtKK9JiJUzjnJwQzMCDncX+GqC6HIJPppBGZ2KQLM5y+2eOU977a+lxHJideeJyRJYIHkNemPYC83M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754995533; c=relaxed/simple;
	bh=ZnLpOEqaKeO0TQYdYLDgBAZVcBBCwqwJgH1A1X28ETQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aSLdiPZfyYlNowENHSfxmfppBl2MUxyNxwbpvBLgJ4Vj8Aj1rJxTJve6nr4mR+qmuCdw00A2n8vl8H4zp73AuQHNGGAtN/tsIogicvsESC9MK8nN/e8C2wnZIg4Q98dtWgpzvYdTZKvsRKurgD1CQYkySFjSlhKqBx6h39r7xi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZNklWb4f; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C5Y0Lu005398
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:45:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3cLzSF3gpHrunTl5F1JZE5JIjZSIBKlPzndpcOzoxZQ=; b=ZNklWb4f3tBGu8Ll
	YwnrRuHaJMNtiGZH6p7l3AlZs3fPAUBUtTg9+7AUFcLYxuHhCd7gT+3EFUDBnw5r
	ACCuA3kkzyc1ATadHot1ES84WE6pJnpvFiKrkzwcoSz9zclR5aNk9EBbFhaGrfSY
	kilz9Oa73vfxbzSJHtIvBMJUenzD/7OnkPop+ThyF3VwT7cHDq5mkUBJZpzoPVHE
	bVjpuCtBW8p+99zGNyzvqy75glA2siQ9WM0n4HHkCWzGHLGJrWjTPBOlciHi5ucp
	ZxKNkF6FDF0HN30Wlxb8Q/zy8Ln08Ny2QlgA5V2qHLHti5X0KdiOVhUzV4VCmVaV
	09eQ8g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48eqhx5ys1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:45:31 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b06c7cf38eso2751111cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 03:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754995530; x=1755600330;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3cLzSF3gpHrunTl5F1JZE5JIjZSIBKlPzndpcOzoxZQ=;
        b=ISxPddbQr0Vtpo+4xjDYZqxIkHoEON6w0UDZ1LLxlPgcbXx3+QTMpf4RA7MZLdncDe
         BHi5jYdJcJoSOsTEYXDMHt7UjKpiSxtjK6/zFcX4jYdJdn/DeT/cPU4L0/9Cwgd9krQc
         OlK6kuoNTrP3DDI4fl04xBwgvzmtpim3m+QHvZHD9CDxLCjJ+uIXixQ+bjgYajXDAEY4
         7WnX4uVaipo/xV6Ty/sUB1KEZMIQ9xKJBXceSHscD6n1Mbo4qugw9BNcGrueCpBQv4V0
         UBofD7C7FgapQP2iB4LHZgTT6QDJ/KLMjex5eJ9ALDsGhTaCJ31qmck4v0ZJibR6UDo8
         RicA==
X-Forwarded-Encrypted: i=1; AJvYcCUfvXdpu817CS3YlOGyFPjtRgYkb5qeGMWK+ilx6XYL1rY+SKhATfJYNM/ZYumsa3DMt2ukxg3iuSO7wQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOel6Gx9jM4oGazrIbDnCs4Y+vwn1L/RzsSPSiTeDsPfYKPxYg
	MRKEgnkjiXj5qkaR5Pq5cdIzPix4PNX2XPbQeUwOaE9+Pv6+mAouf/C4EMaHc8BLVkHgarKqtGa
	wPBgxILeHVlh+6ff90l1T3fWQkc3u1G5lYoSUfET9uSRWH4XMpsARodT8PadCb8QiECc=
X-Gm-Gg: ASbGncsOrttcKPW5JJRm8T2HRndkvZ29hUrA9VkL0yJVIfNMsTWKnGKQ1KDjo9MMcCJ
	wIDOM2GnC6J0l7AirtnxYTt1gRUuzVCOf574vuLf3oyvwcD6+Xy2iJPR/silka/eN4YtKA1wOhk
	LdBQqtLdzxyNPziXCzfj/WXZCxEq+2MS0yu71wABWflNY9g6rd2cBMah6kh1Q6SdLhHDF6XAD9p
	JFymLJ231pqQZQsf8rG8T/GoJ77U/9PRmw6rDNoLrOqFjdoewyzuoavE9I7B0UBodpTPxM1uxq/
	KrrFbnEesGE6xjnshw8VS158QH2TUaBZp5T3hoQnZmoHQ8QnX3xvmefqcUC+A58WvwWuex2wsdf
	ZSxZcAIYtDstGNvuzCA==
X-Received: by 2002:ac8:5f4d:0:b0:4ab:609f:d7d1 with SMTP id d75a77b69052e-4b0f491b39amr4190391cf.4.1754995530123;
        Tue, 12 Aug 2025 03:45:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAB92TKf0KXpgBRFniBKIftqHfFH4cyEtGpbP2vO7IxteDlG0EJNpZMmAQrqtJ1FZt2QwoPw==
X-Received: by 2002:ac8:5f4d:0:b0:4ab:609f:d7d1 with SMTP id d75a77b69052e-4b0f491b39amr4190141cf.4.1754995529451;
        Tue, 12 Aug 2025 03:45:29 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af92b650c8asm2035025266b.65.2025.08.12.03.45.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 03:45:28 -0700 (PDT)
Message-ID: <bd859eaf-9809-4820-958b-dd6cbb3d16e5@oss.qualcomm.com>
Date: Tue, 12 Aug 2025 12:45:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 3/3] arm64: dts: qcom: Add Lenovo ThinkBook 16 G7 QOY
 device tree
To: Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20250810-tb16-dt-v10-0-0bfed6d75c69@oldschoolsolutions.biz>
 <20250810-tb16-dt-v10-3-0bfed6d75c69@oldschoolsolutions.biz>
 <388aed37-03c1-4a5f-a425-5ed8c4f9cb34@oss.qualcomm.com>
 <8672fcd0-cae3-428e-b1e6-cfbdea1ebbb7@oldschoolsolutions.biz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <8672fcd0-cae3-428e-b1e6-cfbdea1ebbb7@oldschoolsolutions.biz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEwMDA1NyBTYWx0ZWRfXyQJdgWBn3LyA
 2wCUbHH3SugiuVao01CLqWpZs6vhA68qVWK6A0i3OVNb95gW2Gc5Qnq/zRtoRInzJw07slJYsyf
 Puz/tjb/Mfh73MR5IOYHM/aH6ZOWasHg1zZz8xc6ls0ekKBx/0L3hNShOzcICwHe60qrpi+YUAt
 je+24UPl1g+UGDzci0FIbUcxV1RzqJUWEwwLGL5Phf1moTPzQKARx6quaXHLAfNEVm9lm/sPSJE
 teK32IP7Z9pfMPTII66IzXFKy3NG5Y+pFfYl6bUQrp4tHbt2DD5ZeJj/m3a9fU9nAeVp13GLFB2
 2OZf3HwJQh9Hb5UEXPHmB2UA5V64BLjVzQ4FxntyjQbCQ9za5c58TKjBn+I4tbxRehaUSGNEfTO
 JVE/h4VQ
X-Proofpoint-GUID: j4Do3M4Haf5o6R4OCS5QsTFOycpvPsB9
X-Authority-Analysis: v=2.4 cv=aYNhnQot c=1 sm=1 tr=0 ts=689b1b4b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=pn5id0YzOMrLbUZRFx4A:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: j4Do3M4Haf5o6R4OCS5QsTFOycpvPsB9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_05,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508100057

On 8/12/25 12:35 PM, Jens Glathe wrote:
> On 12.08.25 12:17, Konrad Dybcio wrote:
>> On 8/10/25 7:37 PM, Jens Glathe via B4 Relay wrote:
>>> diff --git a/arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.dts b/arch/arm64/boot/dts/qcom/x1p42100-lenovo-thinkbook-16.dts
>>> similarity index 77%
>>> copy from arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.dts
>>> copy to arch/arm64/boot/dts/qcom/x1p42100-lenovo-thinkbook-16.dts
>> I understand that git may have gotten confused, but the diff is now
>> impossible to review
> 
> Oh wow. Yes I get that, haven't seen. Needs either a tweak for the similarity index (needs to be really high) or I need to disable --find-copies-harder. [1] How do I go about this: is this a resend or a new version?

The content differs, so preferably a new version so as not to confuse
the tooling

Konrad


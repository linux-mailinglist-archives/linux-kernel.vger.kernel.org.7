Return-Path: <linux-kernel+bounces-844320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D14BC18E7
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 15:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 640084F672F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 13:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E392E11C7;
	Tue,  7 Oct 2025 13:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I9JgE6P4"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27AA1DF982
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 13:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759844794; cv=none; b=QWvSuw50/GUsZHLitZMdH2KqKGSS8Kp2m3vVd2A0ybd9OeAEVS8LIEUXdADW0047fUJ8D7adV8VD9QzGMD58sckp3kOV5KEhqWOqaQEC5f8FttzdSKUlSqG5FfgHc1yjUPFQZIHEHSrS5nb8wpiZrtgwksoQZ5aYSVp2k01e0xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759844794; c=relaxed/simple;
	bh=3lZ6UknrUZZp3tKa2loAmoYm234VuiXYoihS9yGbQBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tvhUQPlIIDWdF4O1s/37AtzWCjJz8L1dAcZZkKYMoPwNNXwXytIKd2kebwMOPWwLvGvVNODUvCYwi+b/1HK1HGOesYob26Tyv6GeyNOWFvnpB8Qadw7k3+lUQ5ozE3X37OypNVBfavwsGk9Klot8Mme3iJ4ns8FSlwDB8/a9w5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I9JgE6P4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 597BaIiG011762
	for <linux-kernel@vger.kernel.org>; Tue, 7 Oct 2025 13:46:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s7CUkY7mH78KwOEvSRjDxBNTwXfK/qejz2A+Lc8hlKo=; b=I9JgE6P4BzU9cS2i
	aYUkLxuo2pVVtSjvX/uBAUJoO3l07Cif096zbdf62t9OiJl805yT8K2KEiLzcB3d
	XVpSTiPDwANk/R5jCW8TRVxQftnWqvtx1PYNxiQCQoF4HnaVBnPCl0m5Qiz1JCfk
	zp8WmBflyOFFUwO4f5OYJya9KMI82++I3Be8ZWeM0GrkCYOKc4plAl3rwAZnMxA6
	MxVde2/LDqxtUpEL4BdEDf2zbJgchtio9PheWNZT48E/jTODUrx877oEEFrgss0G
	sT53XGKGkblwlGvFCKOm9qCBkSyO4VsHF4YLyuYkfVkDLAgucDCBBjANzqReydPo
	+8vPYA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49js9dyh1n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 13:46:31 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e015898547so11702211cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 06:46:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759844791; x=1760449591;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s7CUkY7mH78KwOEvSRjDxBNTwXfK/qejz2A+Lc8hlKo=;
        b=Nmiloje2plDkJURYfAi5b30aInq2Ewgp+tMy5Sn0yYPNjPadJh5eS+LiSbqSukmynd
         LxtCIGdLISia9nFANp55LePkRP31cxLd6Nc/Mpko5eVS/+0aCZqEiy1p0/pRH11qU9Fj
         y+bs/Nf5Z10VMP/f61FFI48SxBbKTL5nA6TqMdnfcDcXuDsurPAORYR3UCEZ1cUWlJi+
         eiyiVaB2JctyKpmwKX2PZil0KkAstEUXAzF/DvkhWOIcS79zZaioXk+IbCRo1TBkomVW
         b94kJnAuO+55QNru0X2aETjLJquuDgeId8Q4EmYYi/I89wBgZlH4LphdJmtKCl03Sjq5
         f3vg==
X-Forwarded-Encrypted: i=1; AJvYcCUWmruJLBws8xyzD7X8JASqXCI2fLhKGCZs43/ND+wI1wpg6QRIH8qqKqdr9osD77oUIFNu+UB0PKCC3do=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvBOLVKAvx/PLF5DFza5UggG0kHuW9j1KgKTrrIOZdJyVz+jfO
	RPG7LWhI+Mm06unrxwr/yG8dXT4lvtu9PolEVB78M0M5oDFDndBJXCkoXCV6ZBVGwd1rPMvpAdv
	QXIope5rPm0ryeFOpZTfZDKYqNXO3BD0WiqUe5SZpQBbCDCTADBa/fFpnPRonVBHLq8Q=
X-Gm-Gg: ASbGnctwaD048Ri9ITPVVydLOvbWF+PRm8jFwzKHHGsmhk/xkGTSpBpDrsXTnhVUSen
	VtHPXjvHOr5oMkcZOZuw8ljzGPfWmYA4FFVympWpF0JXmeuXjJuH9VC9xlFUIlyisNUNco4AmjI
	IMPF8MR8MADVTXJk3+4tP401omCmCfPt/7sPVQQvJwX0pHevCIfnXGvIcPrdvookzpvk9oSnNi8
	AwbSUHc4xcNZVstlP3lm8+Pn6shX3MmMBwdPyLShT3LtSd+vIMJNWVEHr/h+v/VqrFPo1DclnGF
	AS8VOxN7nKirnzbOslmkwHGk3Rw9zlyh6F7GcV3YqB4JxVHwmBfIwzZL6byUkEOBxXDShlSpzAe
	RB8mH+wSbiDEbEhcapxXQXx/FUgA=
X-Received: by 2002:a05:622a:4f8a:b0:4c7:e39a:38a6 with SMTP id d75a77b69052e-4e576a2e65bmr125015731cf.2.1759844790335;
        Tue, 07 Oct 2025 06:46:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMMuzgbdK3DGk8z54m0Z+WLLqxl6a+HKbK9xOp9p+K9sQwGuQ9spnb3O8fDu1XDavgAEg67g==
X-Received: by 2002:a05:622a:4f8a:b0:4c7:e39a:38a6 with SMTP id d75a77b69052e-4e576a2e65bmr125015241cf.2.1759844789676;
        Tue, 07 Oct 2025 06:46:29 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652a9ff0sm1396244066b.5.2025.10.07.06.46.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 06:46:29 -0700 (PDT)
Message-ID: <a349dcce-030b-47f5-9644-047e5b060cfe@oss.qualcomm.com>
Date: Tue, 7 Oct 2025 15:46:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm64: dts: qcom: msm8939: Add camss and cci
To: git@apitzsch.eu, Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vincent Knecht <vincent.knecht@mailoo.org>
References: <20250908-camss-8x39-vbif-v1-0-f198c9fd0d4d@apitzsch.eu>
 <20250908-camss-8x39-vbif-v1-4-f198c9fd0d4d@apitzsch.eu>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250908-camss-8x39-vbif-v1-4-f198c9fd0d4d@apitzsch.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Hrl72kTS c=1 sm=1 tr=0 ts=68e519b8 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=TqukyxIwAAAA:8 a=HDjIzE35AAAA:8
 a=EUspDBNiAAAA:8 a=PM9i-VSbYM6VvaBKnRMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=e_wvXvRcY2B3oMitRgDS:22 a=y3C0EFpLlIT0voqNzzLR:22
X-Proofpoint-GUID: k977GAiwpQyjZ6RHoAugnzWLZZ7MTRkd
X-Proofpoint-ORIG-GUID: k977GAiwpQyjZ6RHoAugnzWLZZ7MTRkd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAwNCBTYWx0ZWRfX+q7RvchBtKyM
 CKgV6RdRHNxiWL7Xn98JKXGkcM6ZCMaR5GDiSoCX+lq4QGMK0HOA75kcXCIY21gmUFhFdPQKCND
 YlXvTEIyQ1vwkgSfDLlnXUHZLTBxnRF6Ug0U6fVVxb4Np5CsVefAZCki9XPByrkYA83LT4h7dro
 zJvTbIO8DQuO0gUaB4GjkF+jRqT+HwE1Z9wJH2WFqPWeQAI2kLeubVUnxlw6JxKmEizqWfl/ChX
 WMoHs7GYYGigKQGw95lbFUJkeXgnL9YUTxlS/VIE3JkAeDzXO2qOZaJs1Pqzbh5L3nCP0asIPU6
 odbjk6huCNaqEWLRP9GrqtP2VMLFGJFatMZ4DLmeYkPb6KabN9qxw8xiw+VFblc7/S4LeDL8OeY
 kRhaUkgJhJVsW5ymDMVl3iutbtkvEQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040004

On 9/8/25 12:04 AM, André Apitzsch via B4 Relay wrote:
> From: Vincent Knecht <vincent.knecht@mailoo.org>
> 
> Add the camera subsystem and CCI used to interface with cameras on the
> Snapdragon 615.
> 
> Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
> [André: Make order of items the same as in 8916]
> Signed-off-by: André Apitzsch <git@apitzsch.eu>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


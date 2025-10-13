Return-Path: <linux-kernel+bounces-850249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEE9BD2588
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39BEF1899FB0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5576C2FE067;
	Mon, 13 Oct 2025 09:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L4O6KkFS"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317052FE041
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760348589; cv=none; b=aID3urNWoialTJNZ1C+4qgbKS1IcDxnsMVCQ5LDxhW4ZU4nZbASNJu0FdSjro56naojQo8WrbysG6lRsgKQm+CWx1A5dLpZU8O859Do1BlumDQJny0UjiL0HwFBMoUTaypvK8qD8A32VNLgWgFwI6qc2eMXUC+hEemUI0i0nhUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760348589; c=relaxed/simple;
	bh=JAorbLSuZiT53x85S0dpzWaGHVqHdTXASc19XDvMYJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J+YWxIJBOrTUMUeJYmpujbB8mpbwoYfwdXmHuCSM3NCSXHeFwlwI/VM7kGM4fayJG5ZwXLVKXX3evn2da+JrS4aWfxZaIqjpn9Bd7BBH57o9z6Qm9aYQEC1qhjUXhBQCajPoGaL9cdWX2c8uy9W1iMz5s9OxEa8/T6fx+Lukwao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L4O6KkFS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D9V6PY000493
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:43:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PRoNub5jA9Gf7w1dXnkXsq7KXaxAcgcIuaL6MaCMdgk=; b=L4O6KkFSUN0UGwxg
	uwbjbdjSLlijcjeNnIYgyP5E5Rk//2L6Ag9bpTUMU5OQyUK8l3YyZjmiUqMIIuf6
	dx676QqUc45cBMCm4fXWd9CqSaiIl+59nvO0b+rFjWWSr1KrA7nSMmv3EkY6Fnh7
	mq64cK035a1tXA3RC1+CpxUPlak+0UJkqeOsAMnB+DN6HEDhKR/r+IhzKqG7UvEp
	XWdlGG/Jz5+DTEKjmN3LhKeQxzNkyNYR9y5yV2qEtNHeP5v0iv1+inSSFwGfbUOg
	4cfMZWbm+oYfG+mLGmhpjS/m+7qdUKp/cblKSoA1boZAWY7/UAfPSN1AeKwfFCIf
	Tb4dEQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qferv43g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:43:07 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-860fe46b4easo248691585a.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 02:43:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760348586; x=1760953386;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PRoNub5jA9Gf7w1dXnkXsq7KXaxAcgcIuaL6MaCMdgk=;
        b=fJGF1A9DxG3Suf+VkKP7Ph5ZLdPWAxDNu1v8dTw0ZOJTqzo26QEAHWbrWA02ulrhlP
         kFLZMZr6CWjd8xJEssdzE59EhWthzMiVDvkPKVNak9nGNRx2STYEcXJsOskM8J3TmcoU
         CFxYRHDnCCvYzLXs6W9fqXA+SY4wH68mjmnwI+K0F6k5qkR+VdYH3plGTB0V/VjqTceZ
         NPQQT5Bz+YmyUeM5uiYlRxzoevl/cAbBH7v51WghcvpfAa6rZF8c93hfZ7tk1jsUc9xy
         EgH3LOCwIKhfhuYyVKJJJcvzEP5NvHtfwgbgdxTp71Bp1lwWYl1FAaOI6eoFahHcGL7W
         KI1A==
X-Forwarded-Encrypted: i=1; AJvYcCXep3fCJ8ECWgxBDwsNtqqS9snYQvZJHJTB1av888Tp4QieN0TONIh/oMrOk40sIEaF6sKyeCp+X04d/1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD71cZUhtv8rtPuUNIZmoop5z19itCpvlbSkoHHuglw0ojpsMR
	lBJgfzVJVA2l8G26/PV0q4y8e29q02bPbPJrwv5q2/5+wZsv3VOwn4l0Y1qIP1yPlKjtDOnERyY
	xG4UdRc66a+sAMQDidue7GJOfvF+/T273LzQqAAWF1DySKdGb64IBSoj0VFYx7YkFuT4=
X-Gm-Gg: ASbGncs7WKM+3n9AKQhrei+Z/jrvYo1nKvw8n+mYfy9ORAVsQjbAXwCpbMhjorXSVJD
	vpvUPvejxq8tER97m3lwTUS9Fk9aYmNb7mnhfJ63WTI/jP6v30nAyU5SrBlH0Ycbf0nhIGSg/+M
	5iKS58tItHe+6vUFT1aYdccqS4jBxp9PZTaQ0Pl9iY0bjc6oqcuYB9z5Jg5YRv5Tvz/9A8sGsef
	cKNsXiQ8ijQWKisVWCz2MafhAFpE+ro796bZTDPVgTlnXOwbteRamlDAy3TaY4CXBz8+KunuRMc
	Egr2LpIFHLFcDpvLabMLnfrBVTrJcMhtvOIUEtCZyR+8PCFac4Yslz78S9RCOM+FbfowjkrYGep
	yDmhDxzdsAnA/mFqXUrP42A==
X-Received: by 2002:a05:620a:40ce:b0:883:3c5c:9077 with SMTP id af79cd13be357-883543faa58mr1929904485a.13.1760348586420;
        Mon, 13 Oct 2025 02:43:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZ37YIa8D275kZUNP9IUttcMgdGMHC6q8jTuYigjOj9p2rv1EtOiRJJX6OXhmRdZGU4PYwjQ==
X-Received: by 2002:a05:620a:40ce:b0:883:3c5c:9077 with SMTP id af79cd13be357-883543faa58mr1929902185a.13.1760348585981;
        Mon, 13 Oct 2025 02:43:05 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d66cc4b8sm894618366b.30.2025.10.13.02.43.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 02:43:05 -0700 (PDT)
Message-ID: <4b4ca560-d8e8-4d89-a02c-02d4245ccc37@oss.qualcomm.com>
Date: Mon, 13 Oct 2025 11:43:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] power: supply: qcom_battmgr: clamp charge control
 thresholds
To: Val Packett <val@packett.cool>, Sebastian Reichel <sre@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251012233333.19144-2-val@packett.cool>
 <20251012233333.19144-3-val@packett.cool>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251012233333.19144-3-val@packett.cool>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=R64O2NRX c=1 sm=1 tr=0 ts=68ecc9ab cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=Wbw6XCnMcsYJmrvhT80A:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: b_3Rx8mKmMp-4Kex8EW8Xjeh7v0Fx2iM
X-Proofpoint-ORIG-GUID: b_3Rx8mKmMp-4Kex8EW8Xjeh7v0Fx2iM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX1oGEWmqHgcYH
 VmGiYEO0QNqyoBfElHEwIJjG4YlWp1YoR7DeFXM8fvKMc1MxK8glPNSU0go9R43yXpJT/2mmDxW
 w+kYyujp7c1d4kfJ777DIdRQl8UHYWS82GHLU2QWAriuInbOTWCtLGnEwB26JUtiy+Hg1vgx9Df
 DFLIKOLDvlVjSn3G8ukUCjqcqhKpchMpEiTWJ8xiHOhNCPwM4/oSedgjq0ZiSz0tBx7SDG7sY6b
 agdtikAL7uGurSW6lYO1adzhMqt1pHJeBZ+up2vJ6Now/6CC9VwqB8tB8kjEKj8IU7teGNoaWbS
 ptfbbyO+wGjNX5lvwAa/CkndcsCTg0zXYs+ygpmjdvNbZCCAHZwKrEi7xIx6bwHyAGRUKPPEjd9
 UCcyvWhqcIu40I5nCA119qcKvTJubQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110018

On 10/13/25 1:32 AM, Val Packett wrote:
> The sysfs API documentation says that drivers "round written values to
> the nearest supported value" for charge_control_end_threshold.
> 
> Let's do this for both thresholds, as userspace (e.g. upower) generally
> does not expect these writes to fail at all.

The documentation says so only for the upper bound. You should
probably submit a patch to amend the lower one as well

Konrad


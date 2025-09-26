Return-Path: <linux-kernel+bounces-833980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E51DBA37C2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 13:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 549A6624743
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 11:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBC62DC346;
	Fri, 26 Sep 2025 11:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Cp1fQwov"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEDB261B6E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 11:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758885776; cv=none; b=LbW1FHhhmnBBXN5OQwSBYnRXCeCjgbqFyC+0K8b/IyZ9NBKNSTBlTRoPP2DNCkKve22wYHYEIU8owTrXVoAEGawTRjO740dBY6OAGDmFHkKYwqZPU//UftjIQqwOrlZzQm+1PnTc6JXoLjsM1ooQ/ebJD1aj4LvmkjWGrwHiGzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758885776; c=relaxed/simple;
	bh=w8UjKz3JmAkLlT8rRIb4rtiF9FozQNv2oVZ++KgEcIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kj2rrrGWRbUfjLInIy+hl2py9Jg/vMAraWPp+kxyLl0ytC2YFbQUaKRKfVYS5odSN7JJOol/zlje5MD4JvY68muVysjVIPVhzGRQBjirBICOhn0D8yYn3Ef0d/lRRW5fAOnGX55WLcnTWn6p636bLznFO3U77ObDXTUun4hJzik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Cp1fQwov; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q8vXnU020676
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 11:22:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tuxtX1890cPtd+MHmOZQ6ujci4mRqE3iVb2IHgC81aM=; b=Cp1fQwovEC++G08l
	rDd2rMDgVWnZfR0Hic/oDBz3427IdZ74vJY7PTGfxmOyOscznIMH4eT+2asXb8cD
	Zk2dh4w72ZgzOHxxHpM+enLpNoDsji4JzqvSyOHlLesrJxNk0xyi469fNFx/xPmU
	FHPAi992rxw0e7zhNiFOe2XjWkKOG6GaKH5lj/pyGN50QmpMRkbiwoHHrJZKVMNh
	9hf/EUxxSvlp7VERvYZnljLBnLOQTZM6Nx4rLEAW+iKTqbjRw/Qz9bQ/mhk89Jda
	woDD4M0WxujdsCyJuyFQdbCNnIiPbUh69QShX/1ZWiKIfURnkxMrNX4TdR7N2peb
	AC0W1A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0qtnkb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 11:22:53 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b77ed74e90so2238731cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 04:22:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758885772; x=1759490572;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tuxtX1890cPtd+MHmOZQ6ujci4mRqE3iVb2IHgC81aM=;
        b=SqwBpYOeSNMsw6tAJlIPqLL37CqOC+TYAtoChlTAgcvExXkga5+/tgMf+dB+n8fQzs
         3W+PCjhNtBfidFtMqZ7AUOK6avqoakkM+yIV54uHZVAHpQoKp9ufHargjddG1jNwsQ1A
         r9BB98vvXYeEaAeGacusUOisGVwTNTqqN8ZBgyAxrsSguZIrpYSHUYjlixr94GNufa2m
         bRCfKpfnD5lBXPt+4sEO+vBDeOGKdKy6Pfvm3VHYmPwrIm8NgsVHxadonRqpUOsmz5EG
         vcOiOkR5ZpCu4VnW/LEM1qVUUZ3t6Ok7ZutnHfk+gqHTtKtKJEOkq9ES3AblgY+ecYAE
         ELwg==
X-Forwarded-Encrypted: i=1; AJvYcCVCd+zUO9e3RDp4WDWc8XkQVtUr7Wil1KhvAVkQ5ZfaWDhSnrxMcZNRpgYFpT/WXuncxBxwDA3ldKrTdW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkIfFtDWZgNp5c6csxxJcKEilZ1g9RzOBy6FNvXu6HBwF8CAKG
	8SeTXb+qUiWx4Gl7rnOAxE/gBkWxdcZQOXPfql5Qgh3F3yTu8tyRae/95UIZc317NJBb0l19ygt
	qiGNAq50g/OY/Po+ELQE3A1lEN6HXMAUfK0uRf2Xwf9k3iVmqiJQ5QeGurnTmZnOx8BW1kqh5l7
	Q=
X-Gm-Gg: ASbGnctR0iuf7MArQIL/HEWYCB3o0Kvqc85oUljDjJelC8oyjecB+ykpw+BU0tqBYyR
	lt4mmX0rApH+EODkSbTej7Tx/FMin5+0W8XeUhmfK7BKs9OyDrlyUYppwMe8h0zLR0ycJ50knJt
	llEfQWACiJllQL1ObdmTdFNKxyHF/XmmJ6JUSreOhLBBDXO3zpwUce7g+HnIh1+84EVhkAQHbk/
	gMEk3I7ANZqEOlCtFgm0mJH3jVXHRaCb4T5pE20s/L5PBr12DIHZ6KzdNqnrq9gZaESex97zkra
	Y/9wplKkdly5vbxVrzPScW4XAgqlLmWe89drq1mMhBBxOeOsGNPLIeMKNwmzQjln+lqb22xwvfj
	ImUsF/d+/8p1F6id0Dr1j5w==
X-Received: by 2002:ac8:5d92:0:b0:4b7:a9cf:91f with SMTP id d75a77b69052e-4da4b0490f1mr56089421cf.8.1758885772214;
        Fri, 26 Sep 2025 04:22:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/1aHo2ihdQlKwwuKZGd5wor5Yh3McpdI62z7YQSSu7aCujq1R5bN0ifT/tMZPZVvYbkZYRA==
X-Received: by 2002:ac8:5d92:0:b0:4b7:a9cf:91f with SMTP id d75a77b69052e-4da4b0490f1mr56089251cf.8.1758885771824;
        Fri, 26 Sep 2025 04:22:51 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b37463f3efbsm177337766b.28.2025.09.26.04.22.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 04:22:51 -0700 (PDT)
Message-ID: <8d0b29f7-6919-4d70-9262-1ebadb149694@oss.qualcomm.com>
Date: Fri, 26 Sep 2025 13:22:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: qcs8300: pmic: Remove 'allow-set-time'
 property
To: Tingguo Cheng <tingguo.cheng@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: kernel@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>,
        Fenglin Wu <fenglin.wu@oss.qualcomm.com>
References: <20250926-remove-rtc-allow-set-time-v1-1-76895a666939@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250926-remove-rtc-allow-set-time-v1-1-76895a666939@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: aMzrkzlWhZKyrdMcmf7JXX4y4owIy5TN
X-Proofpoint-ORIG-GUID: aMzrkzlWhZKyrdMcmf7JXX4y4owIy5TN
X-Authority-Analysis: v=2.4 cv=api/yCZV c=1 sm=1 tr=0 ts=68d6778d cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=gJi3wn3HMf6CnFoazlIA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfXwZrDYb66sr53
 4IggLpIWrNo7E92O2ueFha4OBlBK1uH0U329PsdaN8P1mnXKKU/n4qQ2zO+L5C2kCjp4ddN9YcN
 h7EOYX+xvQL7KkFpeB3eu+B2EtStuTPzXOEn1KBWiTjaYhaZeeKLnL8aDXCgNzUbO4D/YEyA8rp
 mahOh9Z05nUZRPPa3R8snD0tMMWNmVZ63TJwTqEiKLjdpxRWZ+Ksb2ev+cI/GzIypPA9CEiUf1S
 UDPjT/KQ+HOJH1Vtqz9V9KxS/Rfcj1S45yNBS+VX1oXmUmVaNHmnRRVvWCg3m+BEKRNxW4Y09y9
 rFIiFGy478j3UxI18wXN6ZHytpG1dNiTuEV6upvxEeko96TBS7ZuRDvJuwjjLfDi1DENOUGqNL/
 dvbSZGwCUtz6mUNateVSw33OF1XBEw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_03,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

On 9/26/25 6:09 AM, Tingguo Cheng wrote:
> Remove the 'allow-set-time' property from the rtc node because APPS
> is prohibited from setting the hardware RTC time.
> 
> Signed-off-by: Tingguo Cheng <tingguo.cheng@oss.qualcomm.com>
> ---

nit: "qcs8300-pmics:" (like the file name)

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


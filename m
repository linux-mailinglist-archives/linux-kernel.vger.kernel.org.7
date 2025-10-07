Return-Path: <linux-kernel+bounces-844085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA03BC0F62
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 12:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 571D63AB8DD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 10:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117872D7D2E;
	Tue,  7 Oct 2025 10:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fcoTYRP1"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0544B13BC3F
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 10:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759831511; cv=none; b=pvbkBHP9030Q3WXfthz7iqjqSYLJHHvUwGFwYiUFajKQkznJ9f+DKJYF4TXG8wfZLTcjl/K6wtlnK+1Vs+fuykEJA4RWQbkGbSEztUraApWrM8oZZgIugWQmhWFiXVkJjQLF9XkkFGytJIpLKW7TWI4XIV/7hdvewxeFkKAk0OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759831511; c=relaxed/simple;
	bh=Sa9j8HUMO81oEGnNcP2btrssXKd5FBC/u7yBtwhyH2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EKsFsZn64wLVNXxqIYUBNKjGH6fIGEP/gIyUTVl3Brt6KSis04oOJdXXuQxEFYyxpD6q2BhvpqmNWcncEuvSzmj0vlIyjgce/x2zcsHimHH6Cwvyg8fEyPFS0Zz8rxswYA8va8rvlavbdL0M5ZtEIFIf2EDOVz49/uV61YVHhHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fcoTYRP1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5974O0p7026723
	for <linux-kernel@vger.kernel.org>; Tue, 7 Oct 2025 10:05:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	J75ZyhzShJWXkd4whYVjIvNIWKQpo0mAoFePUHF5M0M=; b=fcoTYRP1OK9YZevg
	l1/7RmWvGeVOvMXsSXlPsp/VCJ/JzaYX2irH9DJFfbYJW6gPX9VqiP/3VoTSN9+P
	+f0dO5lkrt+05bGOdOuGCKJ/NCCekI4cnO7zKJkbaXQ8fxwoFSriXhqHaoPkNg+3
	hjwhzHhHgtZwfiadxt8c6Sdu4k9imTBXnLSA0I90IPAj0vAWNCsSamoLJOKuhwK/
	gh5/lfV/3ydQWiDXcjKJnj50ciIL+xVfpC42XHuPaC+EiX0IeMKq1kUF2+u97lp3
	7R+ox+24EUvHwVEqL8C3h7ttiyALkVFVLwQJ/8IoRS9z4Qs7mtwMOKB016tKjAHx
	DxLz4w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49mgd0jk91-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 10:05:08 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4deb3bf6b2dso11255351cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 03:05:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759831508; x=1760436308;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J75ZyhzShJWXkd4whYVjIvNIWKQpo0mAoFePUHF5M0M=;
        b=PpLsSUgMTkN6yT9W5YpWMJeB/hGjgicD55UFWpOtDppkYUflxdEOxlCmjRr6/llTcw
         nrA8K7wUkqzNXsyuQH8Dtm2fUESypFkpVcb7bM4YbCCWUnbyI2kTE9JVScw63I2h6YkM
         Sg1Pieaen28/30t/W8RUTCn/MuGJ4/Olj2VY5X/7zcacmAU3VKK7OXlsmyXYvBv4lARX
         8iBycAibQL45RExhZ7QPFnqMuopS4YP+9XNq1gW8IbGjD/eM7h/cxBJdxc6g75omquxq
         qryxoSe+4RzsE5OwGmdpAwWIQ534KQKt/lWkkrYWY3urEevQ6uKCa1oRWlN2ScWDOd8r
         3BBA==
X-Forwarded-Encrypted: i=1; AJvYcCUeJ5ebd75JqdMUe00KdEJcqM/9p5qMlhHU5Sx6B/32FRTPIZbGt6RbWST1oQXs41fL/YnJbJADB7HBrGo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5yGMj+w/EggWZKGuUYC5WIWGBk+aYBoVOrMIEH5tKfruGC7Wp
	YMwZ5HesprDtK85DW17Pd85zhXX0QS5GFmQIq/sY+XzOEzxkUxtQMaGBLAHMsZRnvvU8RztW/Aq
	8MifjsO+VtbsgE/7H5fMym3yNnuFHy1amjuOTeN3GKfuG2TD63Wj2dhu8tNZhfPmBjvk=
X-Gm-Gg: ASbGncsVLWv0G5VJIkZzM7joXqFoXx9k8+2mTpURrmURE+LxP79vsRNvcuUYvj342ZJ
	uD8tXTGZ3D5tk9oaC2vFrcEu2ZtH5fbiNg57rVWUTp3c3dIt9KH66Gm/z+xCVJy1tm31COJcP7O
	C16w2NT1VI5wKDUUyjS9jtOeU/f6OyrUwos0S1YtCzbgajJsDf7CnZGY+IT3zV06WOOumWE+Kzk
	7XTrfEN6u5AEnWvZOICZWnjNnidqv0KLmjkqpJIdbd+928tLSo1DdCZmWkTC5e9qYXjPigJDbcJ
	peBBhnpE9mgbWPZgRa+DN3Ww5dFDw48z5nmcotAYV1DlcaFChyXBL2W9W5G4DNSMw3AFLj3igGp
	VieBAICT3Gtq0I+ljYU2j9pLmrF0=
X-Received: by 2002:a05:622a:2cf:b0:4b3:4590:ab6d with SMTP id d75a77b69052e-4e576a6337fmr135726321cf.7.1759831507891;
        Tue, 07 Oct 2025 03:05:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEt4FfkRc47pl/KPYAeRhUqt4T2owkGAF15yiRG2vKpb73fM3SZHRYcq5Zqrgq4lOY0C0bgxQ==
X-Received: by 2002:a05:622a:2cf:b0:4b3:4590:ab6d with SMTP id d75a77b69052e-4e576a6337fmr135725961cf.7.1759831507370;
        Tue, 07 Oct 2025 03:05:07 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970a4bdsm1357227866b.49.2025.10.07.03.05.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 03:05:06 -0700 (PDT)
Message-ID: <f915951e-1604-4043-8ac6-49f9b123f478@oss.qualcomm.com>
Date: Tue, 7 Oct 2025 12:05:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] ARM: dts: qcom: msm8974pro-htc-m8: add Bluetooth pins
To: alex@me.ssier.org, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: Luca Weiss <luca@lucaweiss.eu>, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251007-m8-dts-additions-v1-0-53d7ab3594e7@me.ssier.org>
 <20251007-m8-dts-additions-v1-3-53d7ab3594e7@me.ssier.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251007-m8-dts-additions-v1-3-53d7ab3594e7@me.ssier.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: UIXwFJLNfBsEJX8s47GHNB5KeDYuxBl8
X-Authority-Analysis: v=2.4 cv=T8aBjvKQ c=1 sm=1 tr=0 ts=68e4e5d4 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=8poMKPHdAAAA:8 a=EUspDBNiAAAA:8
 a=0uX5jv6YKbm2qIkYBgAA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=fyZPtLC9JlAwSkJ5-iUD:22
X-Proofpoint-ORIG-GUID: UIXwFJLNfBsEJX8s47GHNB5KeDYuxBl8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA2MDEyMyBTYWx0ZWRfXwHaeso0/xVBQ
 zBdR5kvXsYmk4YKZFtnd8ZWeda0RKTIwiXzbr+Ib7Z+smxC42JjYXo0PI+0WpMsp/oOdVZmzkJz
 qkVRWUsvMpF/kA+AloLCfBflxuLAhaSpnmvaNGwTj4PQIvEUx7b/HhsgCQfR0p+rLckf0oFGM74
 jl0NMSRxpp8wn3iZHQj7/5DBEqQ5Fu5BVHAPV3njl/loac/Miq4WLij3yX0bMe2GJDUUaFGnO7f
 biq0rcIs4qAO35oPeEKMUz+BO9f2gMp2/E/xnli+/0yWmrDujCRGSZcaxwie0yMp/zcGPKCrQ2I
 NewaaRuyglf2SeW7Cm7o6Y2cdeVpiG5QrgDWathbE7Ct7RgMtEa1bdQHyn5MAQXn8WrPSI2FCEK
 QBQTC/7lloQIF4UItTtn6x0vgRgufw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510060123

On 10/7/25 7:55 AM, Alexandre Messier via B4 Relay wrote:
> From: Alexandre Messier <alex@me.ssier.org>
> 
> Add the required pin configuration to enable Bluetooth.
> 
> Signed-off-by: Alexandre Messier <alex@me.ssier.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


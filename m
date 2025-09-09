Return-Path: <linux-kernel+bounces-807510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 952F1B4A55F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 653B87A3F5A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AA6244698;
	Tue,  9 Sep 2025 08:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kEGqlLdD"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BEF23ABAF
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 08:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757406851; cv=none; b=NKAoqtytVBw4qRdi6HPErRGBmxIsrmZgc2Nvr3lrjTOIBQTNR4vI6JOEUV+SYlPJuxUT3P6wqGjBNfBzvyRVn3uODC1FoNKRpOh8Lo3i0eSJMrtrCMb3xtig1D0k6HlNgOHLUQknljQE4KXyCtYIfXEd26sCGra/PYNxJbAadbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757406851; c=relaxed/simple;
	bh=upmujvJfvnWBaiiN0ti0rvQTX7eUdmtsYcwo6llGIhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=snqqxV/4BHhSlYv/QVSqmR0yQaj62uXjJRSFYnioscp47vhtJF/C+ar74HVrpdMmGJdROWFmFP+9ol/52imfnP+/22rpCorzL5RJ5c65dGca20pLTvYqW7uDVoDquBAuG4Ypjvmpseugs/1/CmCf6zNuqb1o0h26qufD2oQ5QFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kEGqlLdD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5896T0IS012816
	for <linux-kernel@vger.kernel.org>; Tue, 9 Sep 2025 08:34:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	upmujvJfvnWBaiiN0ti0rvQTX7eUdmtsYcwo6llGIhA=; b=kEGqlLdDFAhiru0H
	ACVzBaGIQxIbrhuhxQvqDUjDKI7LXobCRsLJlvv/eU+ZwKXY7CVCs+gBdB6uDHkj
	qXhF7Lu5bPbwYtrxSZDhqYCDZLiexhxip3pHpbVAZsGVkGFkGdNgrcMAz4+sdMXd
	+/ldYAvtd6esKQu6D/i2/hu7utMp3vnXbC7ngi6PNOqRUXk2fKGIwFXGKanDXLmi
	5j5zsi/XpvIpW5gDA1dXqOvoJmshNVGDwhxJCWa2N7NyomvkRxgkij304lz+Xa0y
	+tduKnMc6pjiRm9Bg7IDvKcdv2QfTFfQRIq6W2JBWPDqVj7P596v5RA68m/ucCbX
	Ax7WzQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e8a7e7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 08:34:08 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3280d0d4d11so9041540a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 01:34:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757406848; x=1758011648;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=upmujvJfvnWBaiiN0ti0rvQTX7eUdmtsYcwo6llGIhA=;
        b=NWSZfHZsXLJOM7YIJwPqXthHMhAdeztgRsqYFVVnjFwGZ5eKNy9CeuAuzDcIa3kbbc
         wJJasBTyTgri+eeiwmj/AtTFJLA4cTDigWFSuLO8SOYgjsIsE135UfQNOYTHrkg22K4t
         +vDUxJFH+N97x2f3aRM3YQrjVe0migSTlyPMbYBZer2sIWnDfkyrwkk9HGrmWW2vhdkD
         rkL/E9QtAvHA7j5pXHbe67K5F8mNFgmjA/0gOi/XU3ITNr4b0Ouxl1ED9lj3KonL0Xl8
         oB32fFhD1cvBePqRqisF0JNWDyArH37KHQMuj+bHqLu65Pcm45bgbVeOf2AqzSYxHgJ/
         LkRw==
X-Forwarded-Encrypted: i=1; AJvYcCWbzFXr+xkWsKyxix9a5DUwtk/YTeXDEY738tqeYGzNzZ3lA9taAkYPHor1qbTdWVCNdhxDIvvIMT4Oc64=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4OOJq5l+FFtW1XeKxb3odVmx4ERpfEyD73HWqUm1d+LFNNdT5
	/gds04coINcImQoHd4OYzyL7KQ+4eUZ3NOYoHBsqrflEhbFNJlweONrEXpNkFqPHqihRSvq7nvh
	5TygYUdDvNUrJbuWMoYarmyQ/wQEV7iKOjbRHp819UzlWTC2U8G/U4pHwTGfkWGzgEFQ=
X-Gm-Gg: ASbGnctDfs9GLr2Cmxznhx6upQW2j+XH8Y9kaZbjNPfDbS2Ql/S3jDpHr3sCmm3sxwU
	eD2VGyxLZPTL9WlfvfjOZLRIJs7/sS8jrJDp64Q8ebIm1sF2RPWoqTCrZqDfrGcPY6uv7m/Fa7C
	5kWw//tuukqZdg0QwtWQAcR7aIu4EzOePxVnreocMnFC21yMVpMEDRr/uaT8mOoomKfTEpnpROg
	XrTQhpuRYrMshL26fHXHb2TCsLIIlY1Mvl2lMSAQ5v6DKyLsz07ZrHQWakYXg+4SypJWIZJ4l4A
	2xKve432vChjkdshAopxNnA2hwSjwL4pfBgK7qfaqGpCZP8DanOpSSJ3SJUGxfka1ts2m/LS8Ee
	gPpXo+sRf
X-Received: by 2002:a17:90b:2f4d:b0:32b:7d2f:2ee5 with SMTP id 98e67ed59e1d1-32d43f53f7fmr15226201a91.16.1757406848001;
        Tue, 09 Sep 2025 01:34:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFVYaSNpwmTtzVm52pLe74SQM+AQgVs52r6EibYNw4s3M1qPfrL9xKm/fTur78uRMs2Z/xFA==
X-Received: by 2002:a17:90b:2f4d:b0:32b:7d2f:2ee5 with SMTP id 98e67ed59e1d1-32d43f53f7fmr15226163a91.16.1757406847633;
        Tue, 09 Sep 2025 01:34:07 -0700 (PDT)
Received: from [10.151.37.217] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4fb15f50d6sm14836433a12.0.2025.09.09.01.34.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 01:34:07 -0700 (PDT)
Message-ID: <1bed21ff-ca0d-4436-9d40-acf26dfda362@oss.qualcomm.com>
Date: Tue, 9 Sep 2025 14:04:02 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] phy: qcom-qmp-usb: fix NULL pointer dereference in PM
 callbacks
To: Vinod Koul <vkoul@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        Poovendhan Selvaraj <quic_poovendh@quicinc.com>,
        stable@vger.kernel.org
References: <20250825-qmp-null-deref-on-pm-v1-0-bbd3ca330849@oss.qualcomm.com>
 <20250825-qmp-null-deref-on-pm-v1-1-bbd3ca330849@oss.qualcomm.com>
 <aLWllyKvag-BAXjn@vaman>
Content-Language: en-US
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <aLWllyKvag-BAXjn@vaman>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=H7Dbw/Yi c=1 sm=1 tr=0 ts=68bfe680 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=zK7o3jtn9Y8dKal1iDgA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 9YZudzBWrIMRCwpXsNoLkXiv_sBBqwoj
X-Proofpoint-ORIG-GUID: 9YZudzBWrIMRCwpXsNoLkXiv_sBBqwoj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOSBTYWx0ZWRfX8GXaR1ukPbKK
 3W0uGecdIGEehPEBFB6MNFExRS9p2kwt6HP/DehHYNkML573v/UmYuQ/Ta4zOrt3HEz7uY6tjvn
 F1ZXPY0l0Zh+zTgWG3V3Qc3dvqzSC0LZMnuvCfKGQMwca69k1FAHYpwWXKbW5AByQkWMe4WuCrV
 vtnMCVa8VGEJMti6HiXWVYmGjjavf0XXgaqkLoErfyCUyelPSrtYhADU/iKuK7UKFy4eQxFnWZg
 hLRrJIVFN0Xa2E+EGME6bdLsMXRtCKPAKghYPGiz4cjXqvF/8dPPvTqwrBM1zGYtPt4JdYurljZ
 BYPaFw9egYO760Zzlq/8nZrh9cdnShvCPZKNbxmTx7doNBY/Gsz9K+0iJLe0MKrbX57Q9f7XouX
 bl5+5dLa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060039


On 9/1/2025 7:24 PM, Vinod Koul wrote:
> On 25-08-25, 17:22, Kathiravan Thirumoorthy wrote:
>> From: Poovendhan Selvaraj<quic_poovendh@quicinc.com>
>>
>> The pm ops are enabled before qmp phy create which causes
>> a NULL pointer dereference when accessing qmp->phy->init_count
>> in the qmp_usb_runtime_suspend.
>>
>> So if qmp->phy is NULL, bail out early in suspend / resume callbacks
>> to avoid the NULL pointer dereference in qmp_usb_runtime_suspend and
>> qmp_usb_runtime_resume.
> That is a band-aid. we should enable pm only when ready...
> Why not do that instead?

Thanks Vinod. Sorry for the delay, I'm just back from my vacation.

Sure, let me check why the PM is getting enabled before its ready.

Thanks,

Kathiravan T.



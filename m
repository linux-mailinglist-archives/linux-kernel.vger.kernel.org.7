Return-Path: <linux-kernel+bounces-829760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 604EAB97C2A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 00:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E92412A54C5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 22:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD2C25F7A7;
	Tue, 23 Sep 2025 22:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WcQai+j0"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124842ECE86
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 22:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758668334; cv=none; b=NvbLKKAvX4qlVnd+Xx+M2E14/teN1wgQ4eZ7VHbpJmLoGB2IyaC67D5gSBBtosWmJEz7cCeG1ubSWm8WgyISDFz84lGsXeLyZi/jK4b18a78H/S+qRqEKyIqwYKqVzUGhB3kYVujvUm0GtsMPmKEmGuO7/N0FVU6vfi8wDgpT4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758668334; c=relaxed/simple;
	bh=jJCqJvo9Wg7KsNH+Nl6zXRZB5rkkcGtreL82+aY3PHI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pObkKctQBPE/J7VzL8A7YDKW1QqGwqb1pY/wTrjL0tFrQb+v9a3wMMh6e9iooTyAfJs9f6zkJjG+PJ0z1ZCRz3t6t43QSdNToxE2rtnSLcvDUDULc41idMIsWS+SVVHyztZQBPRtNh8QU5m5ReUAYmQolRZeUhkPDrQ0HuGrtiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WcQai+j0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58NFNwMd026446
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 22:58:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Lmv3cG7vx0Ui6SQJVFVyi0/fmzwzzBeQW90PDkfU/OA=; b=WcQai+j0BCi8zFxi
	lUVpKNh8+whPNoxfUZKF6x6lfpg19BQSRbU+VGCMcLb9Iec0kDt6x0eIj3ahlrO6
	5OGA4AJ0dlpJ4ej5W3PUBYp+2z88ocBM8qvTuR34paxqWwilZPS/Wp+2La2o3EYT
	xKQ37A9vxiBACXVEazlnCy0+qr2Xh7NtSvk0Y76r2E1YXaQYYSyOmcdfgoDG24HD
	pXho47cy1yEI+m7ZYSERv3BgAb8sWOFD8g4/0qOI4e2t2WmDeAqzEdp+/E68pH+2
	hA80bK8SnWXSniCRgZLx6yi9QE2Cp574dc1yfFk0L5i5inHdQWS4vDKHhlg14XJ5
	YUnHiA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hyetk9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 22:58:52 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-77f29b9e2aaso5362591b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 15:58:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758668331; x=1759273131;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lmv3cG7vx0Ui6SQJVFVyi0/fmzwzzBeQW90PDkfU/OA=;
        b=qDgRE9F84kpQMVDg6YK3wIPcXxJupLycC3C9r6bZaQaevQol5EDgxrargmi2Pr8vFl
         egmu2/S8OQG8JFNHNohDXu6bpZ5yB6KSIwC0vwzpXQMrLNjVnxe9xKHBSFpKNowqEOaf
         xf+4tj7oA9NsV0mfb9jmjAabnUZZiCsvzGSB3YhiU8QsEpF9B31zl3hsyJ80f7sCiYLM
         C2FQ/dP+PUGaFIhVsSaHEmMyl3BK6f47lIMD+jtsBoLEDtsPiIh888cooor3RnCpFDsh
         mKBNXRUi1CjcANQYQp/qnQxOQhJFwjRv7ps8dMp4v1Al/ubbTebyx5l5FbHiEmevYbDr
         NHvg==
X-Forwarded-Encrypted: i=1; AJvYcCXPrFV0W08Y7aKUnetFISK6bmC/uUMEB+c182pHguHLiGsk7gp2/GdNxszYmRFR6XEAVgGH+a5OLr0T5TE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZtSBIZat96cTWCakdLWpFntivhCNj69pTUkKkoxJh2TFXZqDK
	ElnquAupytoYHvNrbLuW6qXSSpfqYI1M5Ke6qIdSJv8rH1TFylf9vZwCEkZXVeQk+HGBNFBSwiQ
	a65Krq52f8bDWRk1vINQYXLid7JIp1HeMlzA75iEb9oeVlqoWMeU6KGF9CmGDFCEN5A==
X-Gm-Gg: ASbGncslroYdBHlM9tR0MFh5kTkKj8/F0fnfi0eMWDojDBUpCtUTi0zmEWmgFzTFoV1
	Otx6TptZriTjwhPpfVktakKK5wagXczXucKlty7fiFp8uccI0trLwgQJv7TQuJKWmD9e4lRj//J
	frhjb4rjQ7uyCYOpnKZa9lUBBRhAkX51NrYLbfQDSkesV/HSbPa9ya2crpAKznSA7ceTFj/E/8A
	zVr0KsbHCzSYSHSZNqJN7GA/UmVmuSay2ZA2y3F1vrSoaphIKqL6CZvqFW45Sy6X6hDuCRaMkzC
	GXacObWbZksIbhNifY4f4Qp9RrJE5KpiSJxWEFzzsCxq+Cc4O3uD5LK/dnPyBbu4BojM4SFuOGP
	Sha/izRm2NEFYR9NFQbHS4FAbSqrCMJx6u0Qo3g==
X-Received: by 2002:a05:6a00:2e1f:b0:77f:2de7:eef3 with SMTP id d2e1a72fcca58-77f53897e35mr4420496b3a.5.1758668331363;
        Tue, 23 Sep 2025 15:58:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjDeSBvGVZUvhY8zB60DnQEjp9FD0V/JdWnCIwcciYRqCGw1BY9RbrvCylUoL7xIUUp1UWmw==
X-Received: by 2002:a05:6a00:2e1f:b0:77f:2de7:eef3 with SMTP id d2e1a72fcca58-77f53897e35mr4420479b3a.5.1758668330964;
        Tue, 23 Sep 2025 15:58:50 -0700 (PDT)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfec40263sm16712568b3a.80.2025.09.23.15.58.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 15:58:50 -0700 (PDT)
Message-ID: <bb776102-310b-4a84-943a-86d4138592d8@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 08:58:45 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] tee: qcom: prevent potential off by one read
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>, linux-arm-msm@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <aMvV4kK386Sni10i@stanley.mountain>
 <adbccfc0-0f9c-4b71-9fb5-5582c8180ac7@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <adbccfc0-0f9c-4b71-9fb5-5582c8180ac7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: S83TS9rMcD00wT-_CIp9XF0XATe3vgDf
X-Authority-Analysis: v=2.4 cv=YMOfyQGx c=1 sm=1 tr=0 ts=68d3262c cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=mbIkYJv0h8CN-5O4jtMA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwNCBTYWx0ZWRfX10V2Aw9BKEml
 s31nStGacUgAWKUyLpWG80YkZt/z++5Tr5ydZkZma7CoSMLh11fVzoUqttrH4oER4f+oI0drPIp
 rwyz7l9AVRMIk51AEFFe4Gfi+8G+OHogtVmm02P82i/sVxKokz2bHwmvmELwFYfEVYQ+b/mK4WR
 k1T6F+ht8mubkHiX1kOLTMJUVM7Rz7ga0uR9gnOKvI/DAt5KPG0+D8NvWlFo7ooSigbb7Q9+I0s
 +8NEf0+TBap1G1j95TovDMc5iETEOv2Vil6rzGbbYhvKqbTPZU+9Rm0ry8INOSvD0282hcbvoAo
 6ihShr6XSHApdPiV86C7X9v9zYCwA6m6b4AFKWeyST5tgmBEhoB4UpWz7CVZD6qh10kFbAjtrVz
 9CYnud3v
X-Proofpoint-ORIG-GUID: S83TS9rMcD00wT-_CIp9XF0XATe3vgDf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_07,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200004



On 9/24/2025 8:48 AM, Amirreza Zarrabi wrote:
> On 9/18/2025 7:50 PM, Dan Carpenter wrote:
>> Re-order these checks to check if "i" is a valid array index before using
>> it.  This prevents a potential off by one read access.
>>
>> Fixes: d6e290837e50 ("tee: add Qualcomm TEE driver")
>> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
>> ---
>>  drivers/tee/qcomtee/call.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
>> index cc17a48d0ab7..ac134452cc9c 100644
>> --- a/drivers/tee/qcomtee/call.c
>> +++ b/drivers/tee/qcomtee/call.c
>> @@ -308,7 +308,7 @@ static int qcomtee_params_from_args(struct tee_param *params,
>>  	}
>>  
>>  	/* Release any IO and OO objects not processed. */
>> -	for (; u[i].type && i < num_params; i++) {
>> +	for (; i < num_params && u[i].type; i++) {
>>  		if (u[i].type == QCOMTEE_ARG_TYPE_OO ||
>>  		    u[i].type == QCOMTEE_ARG_TYPE_IO)
>>  			qcomtee_object_put(u[i].o);
> 
> This is not required, considering the sequence of clean up, this
> would never happen. `i` at least have been accessed once in the
> switch above.
> 
> Regards,
> Amir
> 
>

Also, size of u is always num_params + 1 for the ending 0.
(basically means `i < num_params` can be removed).

Anyway, it does not hurt :).

Regards,
Amir



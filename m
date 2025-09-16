Return-Path: <linux-kernel+bounces-818454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DACB591EB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3A763A75BF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F08028AAF9;
	Tue, 16 Sep 2025 09:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VBF1AMGG"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D4E199939
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758014306; cv=none; b=W4KABoUO2Pm1hDKA0bDa7S7eFzSQGPVzb8OpdEKvNFGbp1OX1mgDQAPygmEGUnkY+HPCRLI+AZanzCUgLz24IbcaUyQk+fI25+RvELVwU/U1MX/s43YcsFtgN7cWlvMxTC98ZAhP8JLV76kV0X7+pOCDvSziUvT/j/1LpDIfseY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758014306; c=relaxed/simple;
	bh=zwsqcK1K8I4g/AxL5eYHfhv+amNKbZVGOpz1wTaG/sc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H5LDPUaD+mg8A3D+b+lxFrnXMJwDcZcjBIZJowIlsiDkaXj6KO3+BN+PvpWVxwswrpnkF6SGg2ddIP2WWjUuDx89tPKRjZVfWc61SQLd/yyQR17qPAqF3nheupPx+Vp7b5zDfaPNY3BiOmcT1XhnFntRhlw/amiirWa2E/HdQSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VBF1AMGG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G3px9U011019
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:18:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5yU38SlnqFnK1dl0OwtvhRawH6vqrbBs2lAUw36iIdE=; b=VBF1AMGG0FRsGwk/
	pu6T9o3wg+JBFYIYurwRbfBzv0GozQATJqDpJ668K1f/FNRpalYYuuhOooOQi7b5
	HHVOE+J7z8FxGOT5DHasut3A6hnjMUbe323x8mht4frVnhYATo+lbSKhdBUzye+4
	rri6KW0Aqb6H8tv/Zwy65NiZomWSwnhTifo84PWC4+wrtnZrm6Pd2fYIEzUAPSk6
	/bgSa0leLh7qK85S3MvqOo9SfCTa8GPlT0Feuaf/EgoMolrlkKRoDOAehlce0Gp1
	arP+S1TFvDAOlyKkE/PCxQTnquF9LyYHQPnsTGLFu5WvM50dgMaRk6MaX79SdXex
	G8PCTg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4951snr3h6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:18:23 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-267a5c98d47so18208545ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 02:18:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758014303; x=1758619103;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5yU38SlnqFnK1dl0OwtvhRawH6vqrbBs2lAUw36iIdE=;
        b=up6KdsuHaPqp76xAAxkCfZ9102zsc6Nq0nW/t9f+UpWiu6fE9oKVaJusLUKBh33rhN
         nbNNeIAlcBBVkUgKRngH22IiKSQDR4ZwFdTo1V7WEQ2tKXfZrkyX5E4DOcjDuZjCVXMS
         CIcYx+IUKpl/3F7Z0aDUR3hq8MzaPJUBFN8nI+pj+L+CkD27SbYIH88rCjUBUis80fnE
         m4waAUIwqQORqsW3EGbepxxI/fhy/0EgK9plGc5pOIj1RPUb9rHbFtS5sP/OS9F6jFxH
         OVe59QsCqyvngmQLJI/TrcJIYOUPYBl0pFb24sxdPADOPoJ37nCb+UZbjH5Y9cMPnezx
         Pcmw==
X-Forwarded-Encrypted: i=1; AJvYcCU2yzM3lrPnQTeaxlrgyGJUFqRsTMtKfWeNJhFjhcgtoVKCAJdN+nIgEOEk1jbr8YzySuXCORjzykFKFEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQUV+Z0tKbrqIcOfBH4xJHEsKmzioSvE80YbeN7X7YpHSWVBc+
	lkRoDfbQWq8s0BtNEzOijzlF3fOlzF1J1IjgrzCYOwOGPhWrCNiII/c7xHYg9Vwn8J6b1Wc6+Ms
	tS0lv+eYYIv9sCHLxktCpX8CbruUfdN/AhNzJE0MPinser24KKAkiJy4nl0zPPuf+RwE=
X-Gm-Gg: ASbGnct4mDV8N55I6/6pDdkIw4mAxdqyPVu4cCx7yQnFZT3xExxoaBQ5VQ1BnC+ECyR
	/J8SoQ+z4bTEGvQX2xxpfA4+Lu0W/Trc5ToAUoPC4V5ep8WLBY23GeMgLdCmK7KgW1lC77XUf1r
	CINVusAanWdYY6vTMBJy3c59MpYjMdpET46CbqFfsLphGGjXFJthvAXpelTwagjGMlNDZCex9Vh
	qsoJ7iryhOyFvtib4VVkSFt/UvRcA3wtuWZZ+u+d08wHaQZw5iZoeRcXPVpCUDG/HMTl5pYmwCM
	ncyy0i849jLwY4/nFJEAzg4cZiyEITyfD8xryH9e8V1CEfeHBJJgJy42GMRAJgvo8YY=
X-Received: by 2002:a17:903:166e:b0:265:44ae:d24 with SMTP id d9443c01a7336-26544ae0f0fmr109025375ad.43.1758014302997;
        Tue, 16 Sep 2025 02:18:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUTp4KmbKb6w4ICddFjxV1wTcHyF4t8EHj7cMp3vuJ2wqlH26j9yp2DgzTArzCXUUfH1i7TA==
X-Received: by 2002:a17:903:166e:b0:265:44ae:d24 with SMTP id d9443c01a7336-26544ae0f0fmr109024895ad.43.1758014302506;
        Tue, 16 Sep 2025 02:18:22 -0700 (PDT)
Received: from [10.218.33.29] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2663f6337b3sm56192015ad.102.2025.09.16.02.18.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 02:18:22 -0700 (PDT)
Message-ID: <0b950a45-21e5-4c8d-bc76-1c801b86e2ef@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 14:47:53 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] bus: mhi: host: mhi_phc: Add support for PHC over MHI
To: Jakub Kicinski <kuba@kernel.org>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, taniya.das@oss.qualcomm.com,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com
References: <20250818-tsc_time_sync-v1-0-2747710693ba@oss.qualcomm.com>
 <20250818-tsc_time_sync-v1-5-2747710693ba@oss.qualcomm.com>
 <20250821180247.29d0f4b3@kernel.org>
Content-Language: en-US
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
In-Reply-To: <20250821180247.29d0f4b3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=JO87s9Kb c=1 sm=1 tr=0 ts=68c92b5f cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=xLYDFgVRoUo0Dj3B0GAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: GAuWgcIyrv6bqgwLOzf9SwyjObqfelE8
X-Proofpoint-GUID: GAuWgcIyrv6bqgwLOzf9SwyjObqfelE8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDA0MCBTYWx0ZWRfX5r3XOqfgsyq8
 NbURaO/RwKSSscxBriuBOjPURksmDzRjPKnpRHvkOjt3s2IliXDEHBdGdvDwfgLNQYWbvBlkWSf
 Bt3lIH7n9dCn2tAfeFQgyLufZIvvVHkwOhIUHl/3L69zX/wwMVmI75N+tD7/Sl8ov6JlUCse/Kl
 /qFsYzK8sL5VbKcQyicQHgrxjHsWD5Y/+XWD/N+u049LemhBkMYMa1Kmo7UWqTsuAB9H7glkld0
 ZyNZaayIod6d1X8bJR/DGamBU38exIVHTEXrC5LYNMc4v2iBIvIBW7+Ahp7RBSet3elmg31YfeE
 q93gCRsfpQRi3a1eigU2yjR421icIatHZQaiOPWjAXI4WhsWSiUBjK/9K7kFxO6pUy3H99fPTI7
 F28RzFiI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130040



On 8/22/2025 6:32 AM, Jakub Kicinski wrote:
> On Mon, 18 Aug 2025 12:25:50 +0530 Krishna Chaitanya Chundru wrote:
>> This patch introduces the MHI PHC (PTP Hardware Clock) driver, which
>> registers a PTP (Precision Time Protocol) clock and communicates with
>> the MHI core to get the device side timestamps. These timestamps are
>> then exposed to the PTP subsystem, enabling precise time synchronization
>> between the host and the device.
> 
>> +static struct ptp_clock_info qcom_ptp_clock_info = {
>> +	.owner    = THIS_MODULE,
>> +	.gettimex64 =  qcom_ptp_gettimex64,
>> +};
> 
> Yet another device to device clock sync driver. Please see the
> discussion here:
> https://lore.kernel.org/all/20250815113814.5e135318@kernel.org/
> I think we have a consensus within the community that we should 
> stop cramming random clocks into the PTP subsystem.
> 
> Exporting read-only clocks from another processor is not what PTP
> is for.

Hi Jakub,
 
Thank you for the review and for sharing the link to the ongoing discussion.

I understand the concerns about using the PTP subsystem for read-only clocks.
The idea behind this patch was to use a standard interface for syncing time
between the host and device, and also to make use of existing tools like
phc2sys from userspace.
 
I have looked into the on going discussion you pointed, and we’re facing
a similar challenge. Based on internal discussion with the PCIe team, we’ve
confirmed that PCIe PTM isn’t applicable for this hardware use case.
 
That said, since it seems the community prefers not to use PTP for such
requirement, could you please suggest any other way to support this time
sync requirement that would be acceptable upstream?

Appreciate your guidance!
 
Thanks,
Imran


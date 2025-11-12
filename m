Return-Path: <linux-kernel+bounces-896917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06402C517EB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B36B1188290D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16682FFDE3;
	Wed, 12 Nov 2025 09:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RPC0Lukz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cEyYM2Fr"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813542FE579
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762941232; cv=none; b=fPYer4AB5uX2ngkQN+MLrLxl5ql8rd4Sf3xfqEIcEhxxZ4bm0iZvnK3MveZbedk3Epy9Ox9X/2FcHl5hwf6szIXRHLOrrhnYMpV+8UDZNYXm1TJ2ekzzoWNjpVJAJY64OJ7AOTHIrRWRGEv5NfDKsPcm3CWLjRIHr2ORaAkxjYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762941232; c=relaxed/simple;
	bh=TgvD0GubU8kF5Dfy3yLeHAPf74ErAVmKpBp9wpxBJv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ozu8hQW330gA4lSzRI5iPaWdFQBiNVJHaL8xS/oTZ4YXbqZ7jgVzWFdnMtT1Pwml+s0h0rqcvCMs/xWlXCDWcNdxy2dKflovKD1jKl2b1qbHBSMqX2hYHywKlOYYTrYk4MuutNaiRoxdUBIbE6HcMsfYOELM55idxWC3b3nbHM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RPC0Lukz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cEyYM2Fr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC6I1vB317874
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:53:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/KzO6isyjPn2hyAKKNSXVgFgpCnyrIGaSRJ+1HYcQtk=; b=RPC0Lukz8Vjp4c5b
	YZxpkhFV9UNCzerc/gqcKh3Blepepc14LZGA3v8ZVzUWggPa2MFnPF2q+jsP5BB0
	VOUfKD+HKGtyedbtiMZQtalRJuBgrO0tBulbx7inwN2FhyybZjqISnoy2WAFn8rC
	ijFSrPM/VGCtfIKUUW6isAfKeQCAarZ4+m0BuWHq/S+ShuAT2MEJTVcL/fGbMSqH
	yt3ibZh6QREEFtw7uDaF48gkqhWeZ1SxfzY1tS3TWFgvl5Gi1F6uaIU1kKbUPlQB
	ljv9pfKpS800leAC7SQDKrVAmc45cVmfkFUOHD8qUddOKlOIXIIM/0G8pf0/z/cP
	VsRsgA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acmumgrg3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:53:49 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4edace8bc76so2180401cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 01:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762941229; x=1763546029; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/KzO6isyjPn2hyAKKNSXVgFgpCnyrIGaSRJ+1HYcQtk=;
        b=cEyYM2FrOQLdhfyAYpU+jh7lyIP4FVOMvw1AejNwyowukFQcS2/QR4v0mFBKj3OvbA
         55kHFbPIY/lYKUKm0Itx/ht5wSt6uwlRsBDZLl6kz+Lw5ghM4DaetPYAYUzNG7EecG9H
         PldpHmwAxFzfA8A9h9m1tWuub3dEtpABJdwU9pEeoT72ik8+TsdFmxTuTW1yoNFtTr3w
         drEQDHaumQ3gmq/C7BR4gsvNWHxhOLaP2LA2wua1IBp/4BNlUANsSv+f8mAEDjWcNQTc
         +4FC6GQNqxiE+haxv+XAWEtIVHXxGmeFOdFXieO83mo4kWYpsWC+oEHUygUBty3s+zsk
         rBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762941229; x=1763546029;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/KzO6isyjPn2hyAKKNSXVgFgpCnyrIGaSRJ+1HYcQtk=;
        b=lDxsbE3w0gvYNlFdOOdURYwVR+fwsrKF2EM5m608zG5w/ZbH8zI897XdZX4WSAEd8k
         CrCIiCq+kdklbAbP7DWGQqgycU3ugV0P36Hb2oXc326hoMVqz71z2tLCPTf6XYdm//cQ
         2U3PZbGQNR7r/H/Vx3YRQTCb7LKCY+VWk1q34LtwXuYZPa3BiZtQ9wDPd9YY5jgJFsKj
         Uu0xB9Ep/6/478/cPjoqhjY4fIzH8Cg97zdiEaWqBpwL9YEKWaE/Zv4WSoPHogi6QUYi
         kYdWrYXC/WrmqkIR8YgIex/+O68ZQOqyfUxtgFvlCo4iwbqrkGNU/KZo7qrwMXc5opN8
         EFrA==
X-Forwarded-Encrypted: i=1; AJvYcCU1zYRXuq9IaSnSqhTRvVewAXbtTXpTglrdRxWLNDBMtlXHiwpnQasBRxHL6HFxvRWdEv7cpQ9N/7hIsuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCPVmfD4cLz02yIrMzdP1pRdC2whwoB9YCwVtqf2vv6ApMxadK
	n6IEzMDpQsVj/NFPLm8/2kYPdhkWrBFqD0cmS3vN2zm5kbEGCDOIfQdv4onBGBZZG2i9XShqz5Q
	NRUExRbmcBxBJvm7saZykWG74mogLppcthEiBnyQz/4O1NEELLyEfSZfbPirP6Al1Ur4=
X-Gm-Gg: ASbGncuWPp1TV0rNh2khcs4T7bUjL7GRcjMfpF2rW2RMlpQKm3KIdxB1PCE285RizCw
	4gyj7wQDZYORQl2g7wp0VSP8a4Euljoo7Taec6P0a6fbFFEZfysBYBVvDkvrx7DuNbxI1mfiGo7
	35Y6uv0EdodZCr/sL0+hJoB7aAEft1F9bClhGMO2kHd6nsxVLn78Nb7na4Q0lVfgnvQB+CpG3K/
	+Dm1fYTDJotmhOmJCTjoduC90cm+PypvxJ2UepMqo9eWysOogpZOqw6OX+elE4fYA/xoS3vgLLX
	WFZ6AHAWHSo5R2zhJU8ISAcvmBOB7UfbDfL8297vBCIaedmaefIyjFK2tZCfPW3wMdRsefFGX44
	DKnk8Uc5jXG0VC6PtU/zwLE+j0oEwiYuORvzXcTRARR4hS/uEGOk6oemK
X-Received: by 2002:a05:622a:14cc:b0:4eb:7dac:7b8d with SMTP id d75a77b69052e-4eddbc942a5mr18534481cf.6.1762941228831;
        Wed, 12 Nov 2025 01:53:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnd1F8QeBMdY8tN7HVPZ+812BJ4TBuAQZwB/mZkcDLFhNBaBtv8CdDSSmrvJaNNTNixuwdWQ==
X-Received: by 2002:a05:622a:14cc:b0:4eb:7dac:7b8d with SMTP id d75a77b69052e-4eddbc942a5mr18534321cf.6.1762941228171;
        Wed, 12 Nov 2025 01:53:48 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64179499189sm8534460a12.8.2025.11.12.01.53.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 01:53:47 -0800 (PST)
Message-ID: <0df692e3-7e39-4a7e-916a-c385015a2821@oss.qualcomm.com>
Date: Wed, 12 Nov 2025 10:53:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: btqca: Add WCN6855 firmware priority
 selection feature
To: Shuai Zhang <quic_shuaz@quicinc.com>, Bartosz Golaszewski
 <brgl@bgdev.pl>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_chejiang@quicinc.com,
        quic_jiaymao@quicinc.com, quic_chezhou@quicinc.com
References: <20251112074638.1592864-1-quic_shuaz@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251112074638.1592864-1-quic_shuaz@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA3OCBTYWx0ZWRfX9KBN2uOKT/xx
 1bFTNdLu5OfvAIpVY5JpEg00hAeY5cvwrNSD0IM4ORGE+dOMDwcb6ScItSNSIp/BK3CY+lDSu75
 JJrZoKTcNmSybXaZMPUdVep1S0Xm4efvDpFgWGtezTicNxYL3KjvziSwyGezr03YOZAQWxzjkLj
 K5Mq55nCu5Xl/HEBM8Itk/66sYsxeF4ffIgOZQ0uYfnbfA6ssYuMOc744czbo5efgQq8J3uu0vG
 KyseGXFcGEQJmgSPHUlKF7gulDW3PuBw0+fQEPPYx/9Yk0h18xoS/xticGkv71/4aVQV81ChqmV
 UcXu4DLHantStXhu5v38xga8f9MssUinmsSFxAys4Dv3QqbQlxhbnziwM6tchEX2+pjeDRDYHAg
 MwctnbzZwgDTlySp+OF8El+7m+ELrQ==
X-Proofpoint-ORIG-GUID: 9Iac0E-zLOCPXcKpFpNdia8bDeTmdF8X
X-Authority-Analysis: v=2.4 cv=dZONHHXe c=1 sm=1 tr=0 ts=6914592d cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8 a=bFTT718uMvuJoUpks6AA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 9Iac0E-zLOCPXcKpFpNdia8bDeTmdF8X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 bulkscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511120078

On 11/12/25 8:46 AM, Shuai Zhang wrote:
> For WCN6855: download wcnhpbtfwxx.tlv and wcnhpnvxx.xxx;
> if they do not exist, download hpbtfwxx.tlv and hpnvxx.xxx instead.
> 
> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
> ---

Would these files be fundamentally any different, or is it a workaround
for someone else being creative with filenames?

Konrad


Return-Path: <linux-kernel+bounces-721894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFD1AFCF2E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DB885620CB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB6D2E0B7A;
	Tue,  8 Jul 2025 15:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f/8PXRlk"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732802E11D1
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 15:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751988408; cv=none; b=E4721vDL11Yv2xhw9Z4Ckze95GzSt5m7a6M3WtVEoM47P2GwFh4543tVLOVBn+kO1KsUrkzVPNvPDwMfnvx7ZhesSNlpTfSQdwVleP5cxTTEQJkoSqlyPIb1Tq4dkVZAxhLQ7k7fS3HVwmxwUZw2dw36LE8sJNDOlkGjVShQfLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751988408; c=relaxed/simple;
	bh=gnFcMWECjh8hfQ1yd2SfwpGlHMixNNs4Ef61UrfZ4Ew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HcGyZyH+4dN7VRi+cbGR3S1Dz0oDcrQlY+eXzNJ6tDN1SgwVmhS/OcSNc4d+zMyWIn34uc9mckcH3dKrRjCVi/1vyFwbHhRCjDp/G4NwtiHupdLIUjJRz+Ti4KDwwRbVSyAZkaab0BmjKAFzvKAdn7Z8eHT+dN9WtGyXRxJyulc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f/8PXRlk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568AAOPK001172
	for <linux-kernel@vger.kernel.org>; Tue, 8 Jul 2025 15:26:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uJ5c4Ex4V45uMVfmn0t7vnp2Sk7utC6FuBuCA5pmFFw=; b=f/8PXRlkFNlBlCHp
	WrOESPyefV136IgZp6GGYZMhFvcuUHSleRcq8k5UVr2eeZvnXNyHTy9kZ+lSV1lL
	ZmwprIZUtHF9f/iRw+bgTdrMkimobRdrkF6PJnmD9LD/KJC1KmkQDWNqYMd1wUhm
	cJB7cz36C/6HxAPNJz1kC9tnLWI3g7Fgu5QJkFJLVE02x9koCMtCkuAZ2RUHULyN
	sxzPlHw45raust6sGM5jBsavnl7KBhFNT5oMjGuJCkHbMaJ10B9x8CprmDzCCmHj
	kRXqDwLQ9/ktVVTYM5DfmTpfDUyuuhMAd+OGh9dJa053cFz2KxmbdEv2mC+6PnDN
	b04qkg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47psdqymsx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 15:26:45 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7d0979c176eso45077485a.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 08:26:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751988404; x=1752593204;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uJ5c4Ex4V45uMVfmn0t7vnp2Sk7utC6FuBuCA5pmFFw=;
        b=YtxM1CmK6SqIIsdQmfnVIpdQQ+l6bvaeO8Ip9GCed7pbBFoXpt8X0LpDWs1aehncd5
         B4A5zd+HkX/K8joBlv25libzVZ/uHNZOXtG01vjNDEIZy7yzV0Lri+b20IRBj7C8ogpq
         whUuOxMPu+vZMW1Fs8nCVaEKsNrXHK8amkAnO6QVaq1n0hE1moWG4dJyu6zE/SsTR0q2
         fPiJF9CrpivMgxyfH7ICPdKE+BfmgoBz7GOR0j47WuA/ajmQSdT0VEJ/hchnKiYdCbHh
         NyKJbqOrN4rfQXKWRlPfxDvDMQpS7qdM5QLKWs4lMf4MqM2VvLDLXYnoJv9h3mdfcpPh
         H0qA==
X-Forwarded-Encrypted: i=1; AJvYcCUtd6in5vnXKWX8SrvlnbZoZDyuEpQTMwd4htZ5P9eUrbRrWi3uLd3yLQi63ihbExXKYgplT0eZ/LqW5SI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjItOSTcnedE18N3RYUVOpDDXqEU3mziuLWjXtT9EMkAPgRfw/
	vVH3BRZEhNnZ20Yw1Ta5iCjgd2zWOM2NvUtmfm1K0j8LBqRn06gcxhMlqAe6VoA9+txxslOfgMI
	9bXjPELxjxSKHUrem2G3fmZzN7yRcf6p/1YCqZo6xSW8z5Xg3tSVRoHk3mPbMW6f6W2U=
X-Gm-Gg: ASbGncu12R3MFfjY5kmJQdas7wZ/vk1KHyZqEeuE+GxtAmoTCbGrrLDIn/FufHltFwo
	bWb494A5HVTh+NWBr2vyk4XuqEtDF6NXmizWSsh/Jn43CECkDZxeLj2F9muTApnMc0lU9FaGn2l
	5OOl7oW4kVCR+z+S2MxzEde8oZ1N+JqseueiBMRUtCOcZKUkvF2LTOE8bO3wuhBAzZCW+RowIXi
	hpkCg8a6HdXnog79L2uUGC0fcZnvR92lLi3Nf2OPeMCE/w7jyXcTHSz7dyP1AtGlpzf1HvQwgWc
	BYjU6T2KIAegiCaxa+GQuMrN7yhQgGE0zz6hqGOVGRf7DEPsmX7udajtj4Eit/XXu/lP4oo4MH8
	pAfU=
X-Received: by 2002:a05:620a:440b:b0:7d4:5cdc:81e2 with SMTP id af79cd13be357-7d5ddc9bdd4mr851143285a.13.1751988404365;
        Tue, 08 Jul 2025 08:26:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHV+dx63so/JwFVhtlOU36hB2+dvDxeO07jXcJX9Do3uuZjKu3CTF/zKenMN3RLFlcDYfZZiA==
X-Received: by 2002:a05:620a:440b:b0:7d4:5cdc:81e2 with SMTP id af79cd13be357-7d5ddc9bdd4mr851141285a.13.1751988403905;
        Tue, 08 Jul 2025 08:26:43 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae40eaef164sm701281166b.136.2025.07.08.08.26.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 08:26:43 -0700 (PDT)
Message-ID: <595c73aa-17e1-4d00-9cbe-abfff813546d@oss.qualcomm.com>
Date: Tue, 8 Jul 2025 17:26:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC/RFT 1/5] ufs: ufs-qcom: Fix UFS base region name in
 MCQ case
To: Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Bart Van Assche
 <bvanassche@acm.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Can Guo <quic_cang@quicinc.com>,
        Nitin Rawat <quic_nitirawa@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250704-topic-qcom_ufs_mcq_cleanup-v1-0-c70d01b3d334@oss.qualcomm.com>
 <20250704-topic-qcom_ufs_mcq_cleanup-v1-1-c70d01b3d334@oss.qualcomm.com>
 <xujhcaw2nj7mzb4cspjsxem75lqfwa7ivnfpzccor7npdu5d7c@xad5hx4b2m4e>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <xujhcaw2nj7mzb4cspjsxem75lqfwa7ivnfpzccor7npdu5d7c@xad5hx4b2m4e>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ffSty1QF c=1 sm=1 tr=0 ts=686d38b5 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=4yQetZYTsztc79A-kMQA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: hs5MD2XxyacThON6wabZ8NpF9-64cfEs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDEzMCBTYWx0ZWRfX11f64nMWRg0U
 WEQRwXDjgscg2yNYx84CRWfTxElaumxCAEYE03dMjuYIuuWEuYLsXa9dAc1vAB6VgZIsgOp/Bn6
 lIBGkQgbuSaVZyNIWDLjDR3dVTZnYu5HIdxn2bRDBiXHqFctyVkDmAobfisZV0Htgu7qJBE9DJu
 Qn2qX3hjMgMHubfEXM/4rxBzP/SBWlopvYAtgA5jmVxlV6j9sH/7E8ux1uZ2WQ7wShxG2PSgv6+
 IgUl6OnoaSfOvvXYaIobN1b7+I5rT4ykZo/XXSHwbIXUaJGyOjcS9odZPkOFJgehJEt8hn95WeN
 DsAIrdyduKQpNKgB4fKoUyEAHExAJcxEVbRBJKz+2ZL/URkAyh6IQOAAs7uhUrfBbeqtVv/eNma
 hMrgXD2L+9LOl8Odw+jNdtyNcqE7whjeeL7rRy2t1K37AKjz5Que2q6bxKpYyVm1jee0wS8Y
X-Proofpoint-GUID: hs5MD2XxyacThON6wabZ8NpF9-64cfEs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_04,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxlogscore=985 mlxscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080130

On 7/8/25 12:34 PM, Manivannan Sadhasivam wrote:
> On Fri, Jul 04, 2025 at 07:36:09PM GMT, Konrad Dybcio wrote:
>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>
>> There is no need to reinvent the wheel. There are no users yet, and the
>> dt-bindings were never updated to accommodate for this, so fix it while
>> we still easily can.
>>
> 
> What are you fixing here? Please be explicit. "std" region is not at all in the
> device memory map? Or it was present in some earlier ones and removed in the
> final tape out version?
> 
> - Mani

I simply failed to describe the issue.

As of today, the MCQ code refers to the region that our bindings call
"std" by the name "ufs_mem" (which this patch fixes).
Totally same thing in hardware, but it would obviously not work without
DT changes (which would be rightfully rejected as there is no reason to
change the name).

Konrad


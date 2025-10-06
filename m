Return-Path: <linux-kernel+bounces-843449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B971BBF399
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 22:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EF0A189AC11
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 20:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5962DC764;
	Mon,  6 Oct 2025 20:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iLLUaDEX"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980C71A0B15
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 20:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759783227; cv=none; b=PpmXx310hlsE20J2pvTTALhVUzc5yYzbnaDb1KVcLA6/YyDJ64cbXHFju//4YUVXsIU1NonUs1wEzO87QwIItmeKjd+fSrP56f5yFO6IcyyGReU/VpJTswz/NIgSYFNq/BPQP8tbSsutvo593H8Ki/+IMJcML7o7rWA8B3IvdQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759783227; c=relaxed/simple;
	bh=bEuaeW0AI3Kf1tc4gTsMq1465/a28GFhLe0G5PTG8DU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LPZgOs/wnukbovXWZjRE1RMWFiIUi6EsR8qbh205RXoNiBL+UuURXIgbzM6RAOedxqFN00DlRQSgx2CllXjRIrmNoSCtWn0wbi+hwi0SytjfYEiAsbzuDO0+2X+ECphlNQOsCGbG1fOfbty7Cp0PLIlf1lo04G08KKGr9WwUPKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iLLUaDEX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 596EpnCN030297
	for <linux-kernel@vger.kernel.org>; Mon, 6 Oct 2025 20:40:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YXNjTVX3iML/A/etm192jSri1pqvVbrOkDWSRs1g34w=; b=iLLUaDEXNrWKQ9PF
	n8vVBzJCySSTFAJI+q8ok31UoilP14t1Vz7UGesIUVUYcjdWNkCgliZCqVRYpR6W
	SVu8T0cF+xVuOB/Ix3gDFeYWwXwh8Z1LH+tR3jux1S2VUPUwnyAqsfVcV2aRcWoA
	NeUWxpiVkoW/30NcAzXFCjeyE3B2XzqeVLzDyBEJ9qGAszzmvcc40dnsgpnD+JLB
	7w4azO2LhkzB1xkPYFSvLuiUmp2hbMjx76Led7zhIItYb1/PZQVY9U3nQYVWgGqp
	E6pubtw/D4f9VNvORXH4TYd6Vd5ihhsVk2sEBh3NiIEyxg212xnahmr7uIgSvzB/
	jbdVkg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49js9dw9u1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 20:40:24 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-332560b7171so5489728a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 13:40:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759783224; x=1760388024;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YXNjTVX3iML/A/etm192jSri1pqvVbrOkDWSRs1g34w=;
        b=S06w84ooPRVgSCZKr9mFUwUE3nNAGBw9R0asN17SpN2FWxYWQvQMdZffx5yrEQDU24
         wsMET35kq06C0RRJfoYg+aXm5Wogda79JTIVlR0m4r6EcQdAOSKngz6cxygzF9vI9xWX
         OHHt/qtOXhAOJo7JtpYoVVUDnHxxV/pUPebSuSC3CmSsQ6F4ZaFY5ma1Tb9Hmfd07rLx
         nWw65CS8nbAdjwzWZp2s6CCAuJdHcrHCGa6tEz14a1z8zBHfMNZ+BHaRlJZocoIkL8Nc
         0JKWnRhXDiPoza4uop+SXL0fQTXSqbEXwbBiS67qgxj16W0ZgDTF2/tJob16LPKbEttw
         7jgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCBoxtjucgwNgkHByQ2YArz7I8WHmran49kPLpJScd8Gz/i3OdF2JOw97zRXsCbRlUO/WsZ3A2pLC4Uxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwczmpMoYmW58gqrJH7hoJ6czUOAQ7zPHHeyRbHlfr1vO6JRxg9
	GB62pTRZdTfU5copfUJdEVC9NShRDvFx+2lGMx1XL8FS6TyrG2B8g6zbBQr+cDdHpao+n5vz4NT
	VCiQYROVz/83dTZ50nJk4hyepLkCl1OlwwoSfcNXV3jC/dIrtwLyjXc9AplEjOVE43x4BQdUzFZ
	M=
X-Gm-Gg: ASbGnctN39NhtuaIR18Kgr6LrzWapx1gnkj08EjcniaoPYvlDSV6pHov0v+fTSyVTPU
	DHpg7BzZvvBPz92gMHUxDtt+di3wbCeRNd64BQZMN6YCUOXjESJ4I6EQsoZbNve11GM78roqZt2
	lTfEldkot5Hg++pl0VOcwv3IMoE/z8m0bZI88HguSbotNb/3f/+3SObwRQ5MY+RhA4hi0jY/HA2
	KvrLw2ltyr+HvCDJTOqWFxZpqjSom1P8BrQjld2nQecXGh6fF2e0RQQLQzaETWU/Dwqv3/tXX6A
	mVjYNxlOecLOhyMituRHOMFSCBx5IoM6YMwTmFBYbkYlxLQNQ4jE7d5TeAljQTxRwV7epWzUMM8
	X1olqEc6l0SKBWMXi9GM=
X-Received: by 2002:a17:90b:1b0b:b0:32e:dcc6:cd3f with SMTP id 98e67ed59e1d1-339edac58bemr1131986a91.14.1759783223712;
        Mon, 06 Oct 2025 13:40:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHj3I/2pz11+BwXv4abtxSlZbMuekd5HZZX3dCh5I99qOPxLV3ZwEMUhPb47ehFB/qsHCnlw==
X-Received: by 2002:a17:90b:1b0b:b0:32e:dcc6:cd3f with SMTP id 98e67ed59e1d1-339edac58bemr1131963a91.14.1759783223238;
        Mon, 06 Oct 2025 13:40:23 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339c4a19fe4sm11968468a91.8.2025.10.06.13.40.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 13:40:22 -0700 (PDT)
Message-ID: <3ba3216d-4dcd-459a-a3ec-2ef0567e75b9@oss.qualcomm.com>
Date: Mon, 6 Oct 2025 14:40:21 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/qaic: Replace snprintf() with sysfs_emit() in sysfs
 show functions
To: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>, ogabbay@kernel.org
Cc: quic_carlv@quicinc.com, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250822112804.1726592-1-chelsyratnawat2001@gmail.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20250822112804.1726592-1-chelsyratnawat2001@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Hrl72kTS c=1 sm=1 tr=0 ts=68e42938 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=NpbQ6Uf7XBcvSWM2wFwA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: 52Jq4gw2Tcqpr7Y1U6-1o3P4f0THTbgZ
X-Proofpoint-ORIG-GUID: 52Jq4gw2Tcqpr7Y1U6-1o3P4f0THTbgZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAwNCBTYWx0ZWRfX1PdKCpzRVBFu
 3hRFNyYwmBRwj+xHR4tOjVMJblN75BdvqDc6XvfRPdJnNx4/UElNDVA6m6K3dUb538LLDBFNkuI
 mznm+P40gs00dlolJC0qS8nAnpksGfFjT84s3rBw7jRe5KOWL9/29lZ1zhc1mCVjpkIKW7wpQJg
 uVvbdqpKE4jFrFgxf1XWWbHNi9+AiAHem0Ye34Mh0GB5RWvFKILNZpZhbg+Qr14arRVI+RTrUfZ
 7FAuTT4qEpcINUl62b+76AF6JMXza3RJbdOxnXI0wP/IYwwc0226fJfzOMx37RWEXwVOzVzQhSs
 JCKLevf/I4uV1d0FOBEkKwAju/NKHb5u02JLV/6MG+02P3cdZAM45/q5t0MJH7NDc74aBFB871E
 fU7d+p7GhcQUTqturQCu1LGlDSPzdg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_06,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040004

On 8/22/2025 5:28 AM, Chelsy Ratnawat wrote:
> Documentation/filesystems/sysfs.rst mentions that show() should only
> use sysfs_emit() or sysfs_emit_at() when formating the value to be
> returned to user space. So replace scnprintf() with sysfs_emit().
> 
> Signed-off-by: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>

Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>

Applied to drm-misc-next.  I fixed two typos in the commit text when 
applying.

-Jeff


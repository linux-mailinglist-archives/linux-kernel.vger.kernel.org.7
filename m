Return-Path: <linux-kernel+bounces-733378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF31EB073CD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36C5B5838D4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 10:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF822F3C24;
	Wed, 16 Jul 2025 10:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QDqMyDRL"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029332F2702
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 10:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752662673; cv=none; b=jWFWF2cLK9QYy8ZPwwwClo1/EMeonWPGOkQQV8UGSWnZ9WJaN5GICmufqhp3V+PNZjlMrcq7N1AnEiBspvFmfeIP4GC1rYVpEky8IOwOR3P+UvUqSRWF+HHTfaD2kExHWDKkr7HAYF0pG+L1pzdGSkU+/2ur4jSrllTKuTQpSx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752662673; c=relaxed/simple;
	bh=Tin8r+U+w/3y+LP84mrbjl934s1RYjdcEk4TcBbna10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bOg1i+7IIJg1MaU3CalCbjdE7ux1OG7Oahu7ZUeP+HrLM+zaA8H5C0/NIkaXcCgRSeSRRaAhDzOnukVDDlQeBw3gYKr2ztCZ9Rk1/eWMxN/pd9Qir24CtGcBJnpxN6Dlw26T54Ot4i30gNDNdBiJBP6fE3avmUi5pLR01JGGH6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QDqMyDRL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56G5tlvE018109
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 10:44:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GwojsqO00L46el7Hbe+U3o4hx2hTDdeThYiZKwFHZxw=; b=QDqMyDRL3w7yoE72
	BEOQUgysZCP0FV8AwWjuS9dyoHCrUtA4l1s4LU7ErFNnPgS5mRpIlVRRt23sBzw+
	vvkY+ZgVylMrGMiw9yI8g7weJO81zikOKoI4buzIx/yQFVj1auteKDEPApKonbC3
	4lPZmhQ453+KgEeXrSBS0g6dGCQdOOUtIKdtn4Xw/CT4zHQrha3lr/x1mF+hZHhb
	oByoe7fRpi4TRLITCxmRj+xj88sWFUAaAvLTsF3mJ/4H89ZbURMIWgZpzPghVFGd
	f8nN+CP44BAEyzTfrNL9ou96L4A89JcH7tf78kH01sd85JnuJN0bPUP6OU7/BSOW
	q8sf4g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ug383q7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 10:44:30 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ab60b83e11so2208421cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 03:44:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752662670; x=1753267470;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GwojsqO00L46el7Hbe+U3o4hx2hTDdeThYiZKwFHZxw=;
        b=R8fyqtLz1ZzC1URUtHiYUNNRmEIGrEdYdcdSkyns+uN3aq67JwPjyq+M2LemE6IY5O
         aX728XzNG7ICXiBpMYYc0L2afVHQn+6qZFPoKDY4TsCirCUAoz/z4ZYryxNgt0syUL6p
         nObAb0iEtnZ2kBxETTsRuBX7mWBI5KQZtS2t0NLSOd1wtwIe+pm5M4LJzvgEllC0BgHL
         kT88vkZYTXMV5J5A2R+N237uH/lCRbmCVzo9E+WnqIntMOd/4601RjNYuiPTG8lEapw6
         joDamm2ir6tRKd/d84t3JyNwxd6Cr4DjBhvAOIncbF6wfMiABdMuEV5BwSjRow9UvFCM
         R2jA==
X-Forwarded-Encrypted: i=1; AJvYcCWOu048OV/dZ8tOqpU+jKCLzP9DOR4fb/MG7yECVXgXGEF6nqMiU9bIZXvNnWfbrC1jtexGO12jg9QhQ7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUPPVrzavp9ij4KyC1/kJlQVwZsNkD0r8/hvek3CbFcyl3DhNq
	Q+pITRExffpCTQj/9+PK7c8wc0BKmxb+HsebsvpIcL+L6FvDbCpJ5ewyxXvJCIoHOjybCn1QoQL
	GkzI1xP2nf8ft1PKLxpQoOOIgoguVyu/HgxXPqF93VsGogRHzOJ7xA0b3MkuHQML2DY4=
X-Gm-Gg: ASbGncsmgud0P1uJpMvuBouollenIxlZIP8iNNBQEKpHO+0flr1J4psvAarwcBVAt01
	OC3sW5awjCqHxuHGv+wEs/fZlvZ05wm+9rCfHTWvbWidlr9zZHFiAxR3n1t8O7GOd497Zfx5I6B
	OJQNmWT+eco+jUpHkOnSTb1uJNmC890RTKIR3KMWF0PXbfSlRrhBKpMuze4Ytd83aRM5bLwnmTW
	ol1OIYP2nK9l0fsmg8l/DBOk86aUkkSi9LwD6kscso3G68vnsjXl0YPqWsu66lrCTEFPZU7PDFs
	JhdUplb0RZURL1Z/2HJJSNXG4L8JIroasTLAxLZVasthR233os1ED/0Uk5WnysQT5D2ymrnD48O
	5V+iYDb4mrZ3GFdmTMJid
X-Received: by 2002:a05:622a:1b20:b0:4ab:806f:e30f with SMTP id d75a77b69052e-4ab90cc3a56mr14294841cf.14.1752662669713;
        Wed, 16 Jul 2025 03:44:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9VYocXZ0PhMt9kgWk1/jx5BjJs0UQSzRLjaw/6hz7Y8Imt/1VQJqU11+DAf4VNiNJClKZrQ==
X-Received: by 2002:a05:622a:1b20:b0:4ab:806f:e30f with SMTP id d75a77b69052e-4ab90cc3a56mr14294601cf.14.1752662668802;
        Wed, 16 Jul 2025 03:44:28 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7ee45ebsm1163531566b.43.2025.07.16.03.44.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 03:44:28 -0700 (PDT)
Message-ID: <697bb6b0-ecca-4392-9e7c-8d4ef75ec96c@oss.qualcomm.com>
Date: Wed, 16 Jul 2025 12:44:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: typec: ucsi: ucsi_glink: Increase buffer size to
 support UCSI v2
To: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
        heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc: lumag@kernel.org, neil.armstrong@linaro.org, johan+linaro@kernel.org,
        quic_bjorande@quicinc.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20250716005224.312155-1-anjelique.melendez@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250716005224.312155-1-anjelique.melendez@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDA5NiBTYWx0ZWRfXxng4npDEWg3T
 ezNMlFZwlVR5NgILpSLe/v7PxIo9gEZe0dl/TwpG8FvKJaBl93BsFM5sHPeBS4EYRvrBgn/0eLO
 PFCA4CA9BDzZUGuleGzHaMzPv7xYBWzZhbsFUjgyREspggRoiCWKQDptNT58oyhKLZe7Ipbo13g
 vfDII6jgS7G7FqKoRSjrb897gbfn5D2liy5NFQCi/H5uOeKc5Ctb/c3h4tEuBAw/KUpV/0ljy9O
 4VsY86WL2sIoaUqTZ7XtQXRd/PtqW5C8Oy/W4qrTsxoVCpur2Bs/FAWbmpDlts8naZ/ILNRR3Qy
 jsaJMSZRKAzE9EexHolwMU+ZIIyf7XCkNUirIkjGCIsLMvXtQU8uFCiiU9Vvld6VXR9afSI9Aih
 kjI76sIr6zX+TlbO1p6GWLQXtJP/BeFmKPFISi5BScX7hm7smASFfUwpHb8imyuab9Iw1G/+
X-Proofpoint-GUID: xtvJmjd1ajHG-G583kPATLrHWiu68TrT
X-Authority-Analysis: v=2.4 cv=SZT3duRu c=1 sm=1 tr=0 ts=6877828e cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=TdU0opj9kUmyj219TpoA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: xtvJmjd1ajHG-G583kPATLrHWiu68TrT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_01,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=386 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507160096

On 7/16/25 2:52 AM, Anjelique Melendez wrote:
> UCSI v2 specification has increased the MSG_IN and MSG_OUT size from
> 16 bytes to 256 bytes each for the message exchange between OPM and PPM
> This makes the total buffer size increase from 48 bytes to 528 bytes.
> Update the buffer size to support this increase.
> 
> Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
> ---
> Changes since v1:
>  - Defined buf size in terms of other UCSI defines
>  - Removed UCSI_BUF_SIZE and used the explicit v1 or v2 buffer size macros
>  - Removed Qualcomm copyright
>  - link: https://lore.kernel.org/all/20250624222922.2010820-1-anjelique.melendez@oss.qualcomm.com/
> ---

[...]

> +	if (!ucsi->ucsi->version || ucsi->ucsi->version >= UCSI_VERSION_2_1) {

You mention V2 everywhere, but then check for V2_1 here - is that
intended?

Konrad


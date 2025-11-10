Return-Path: <linux-kernel+bounces-894199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D55FEC49766
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 22:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5904434BB04
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 21:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2DD331A74;
	Mon, 10 Nov 2025 21:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FSyFxxxQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hWjXIBTM"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793FF32AAD4
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 21:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762811778; cv=none; b=JbNmRelS+3aa37HvG9eEdqrS8y7twivVPrli2Bh1DvdzIIUKhxaKpakgaL4N/NwV1FL2kn+37JPRVGP4oNmFWygXcwX5J+QX0QWIl3tAXHHyBz2T4eMNZFUJZPIkrvPYaVfPxy98R+cvbaD/DSVeny9q0sGAsuZXTKZi6wK7LbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762811778; c=relaxed/simple;
	bh=+gLMHZJ1MVCJEZNzctPQIZyLyMOD5NMDBOGpVXPW/bs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WmQ/mdGzqo8IGWzYSvI/fhgMTcPJ5PjmpdEmhtMVRcLtrYbYbqtAe8Z9Cx/5V+zFIsGbWqsIgcbXScS2xFmjucX5pzndLB4xlyF5FnFYQsSeHNtFmL3F8pmhtuhEBaIblS3csXw22W3mV3UPiijCMsnQXBh+lY6JWDD5ibAT2Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FSyFxxxQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hWjXIBTM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AAFhS9h3985095
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 21:56:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HVzpJnOu8qlzWxb31lw2UdzGclobAcdGiMa8rZnaHHQ=; b=FSyFxxxQfo5UZvu+
	O7AxvEKICwnx1g/06XMJyfT8LqJLC7nDuBBmgBmd1K+aebpnihAAWy3wm37VVvcY
	2Y08fPZUA7OKLnkD5SjX9VZ60Y5Ip4Yhdvv5XXqpBgs10FmLgkzST6GgoUMUZLkC
	GDqNI9nCv6+7skSt7xA9MlZvdusz29Q/gxvHXJFs83107wUt/egJ1o0mHZJvTyhn
	jWp4nIiegh+yU1gGm5LMHOumIublRcA2dP7zvsXAYzJ3dKZoJ5EdgwUPujG0cvAy
	wv4Q+3PCfoFeoGJQsAxJcvI0Eao0zMh1epnC6FiEvI67LLbp1wpKVW6/nonunMeJ
	sOmOJw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abjxqh1vd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 21:56:14 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-298389232c4so7653125ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762811773; x=1763416573; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HVzpJnOu8qlzWxb31lw2UdzGclobAcdGiMa8rZnaHHQ=;
        b=hWjXIBTMiHoaDUvTmwQdG3DYRXZJSfJLf4/4hBYPXPBFJeIKnRXaM7vT+4LaNEfoWT
         lagriod2aOSqXm6DJrF4HBiH8hTwZb0cTF274C3KKHs1NA5mo6U+ypuWOYhv/Uup153e
         515IIqxxdSz+MKs+nFu+DBU9LzOMK96DZBWfApfQrAItk/lC3swl4b5XaCxC53sTg5+F
         O7ix7AQjdEWOaYSDBwCD/JM2fLr168eiJTJZFpkmujYnjH8b4/PUQ+r1FE2AIXdPeQ+F
         k2CiTxnuCdG+/Gm+ujaOICCOilUrVlmuXamWoO6W8ZrLzTLvMtIyuu2BqUgP6YJDWak8
         v0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762811773; x=1763416573;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HVzpJnOu8qlzWxb31lw2UdzGclobAcdGiMa8rZnaHHQ=;
        b=UqjPsH3G6wodB9dBck3u1c9uU56/Sxkke0H/319h540yk+gLKVuUEtY3OQmYjCnNmf
         qyP+wz8wv8H/uZEKpTqGTTak6bPqmz40TKgZURBCDV8iEKuJXv1NESVts4OOPamjBaFa
         mttLixzf2mdMl6sOJAEKGuSPt6Pq+WpbvLBZIh9i/APM7gjI2CxhAbqb8cjZ2dBHASOs
         E29wC9bONyxg8rFdD/f1/DhkPRNLKmAxgf9Cw+3lbrBPbE1BawbSA2n3HTowBnzjcy4/
         l9yBzhn4XnfAyBfGYUfBjCMc2jebSdRDlHh8ACveNBEG+AOo+QmxibW4ItXiCgp0V1GH
         Pa1g==
X-Forwarded-Encrypted: i=1; AJvYcCXqBc4zdla+M0pcoMNCBVemKzzJDFhrMIZclZ8SopZQsGcPWcjmn9rW7YcVVHotuq6+D60AISrW+9Zp77w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPuxpxa8zFyI+pUWwa4qIMRsZjyArkdJJK/FE3SkvhWRGWcgnv
	3CFUbXzHCU41VC5Sy1xKqJrxmBvpnaVYHNEnUl8aoocALIj6M2wSSwZ6CKylT1LyeOYtZXqioH1
	zo6iBBWLTDyVlq9066panT/21mQYH1FGeWsTbXPuqtF8rfBV/DnVvCegfS2myOE5ReJw=
X-Gm-Gg: ASbGnct1IEVNObsATlP++krl5VJMir2rAZBeFyaI0Ij6ETY6aPa34Lt2F3+ebHIN0ZG
	BwSQZlTVnOXOVyKfO1EEI1bneFdrqa639284UEBHvCT/YB985CJHcIi8YFwRIGCLj82Kj4AEL/A
	/dCIxczl44p6fmLeGMbBU8T4IO9zfXaLePzsnZDJTBSnV1mcGEZjhx5CJBYMGz9j/SG2hlgryic
	z28/iZmGv76dvT7gAMmRxoNymMsS7UmfS8QJ8BiILyPfmgZDOYVtI4JkOjYUSbHIU6t69DW1f+1
	I4wGAAyI5Y1Ty4Th5gkpi3GAu0/25DZmEIrAwrQ6qfv86sRy9tu4mR9LmO+wSEEmiG6nI0hpt38
	0IzcdDoBkz+by0Eul370RWeaDEHwKXYOuGxVBBgXJic0avnEksHWE
X-Received: by 2002:a17:902:da4b:b0:27e:f018:d2fb with SMTP id d9443c01a7336-297e540dbf8mr119018685ad.6.1762811773291;
        Mon, 10 Nov 2025 13:56:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJz1FxgkaYCgwsCACY9rd9PpdJD5YgwnReoVj/md8159Dmv3H/XV3LqN2vti//V++K3E5rsA==
X-Received: by 2002:a17:902:da4b:b0:27e:f018:d2fb with SMTP id d9443c01a7336-297e540dbf8mr119018315ad.6.1762811772804;
        Mon, 10 Nov 2025 13:56:12 -0800 (PST)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc866319sm12832672b3a.54.2025.11.10.13.56.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 13:56:12 -0800 (PST)
Message-ID: <e6c4eaf8-1484-41ab-a37b-047ef2484e30@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 14:56:10 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] accel/qaic documentation fixes
To: Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux ARM MSM <linux-arm-msm@vger.kernel.org>,
        Linux DRI Development <dri-devel@lists.freedesktop.org>
Cc: Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
        Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>,
        Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>,
        Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>,
        Aswin Venkatesan <aswivenk@qti.qualcomm.com>
References: <20251110035952.25778-2-bagasdotme@gmail.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20251110035952.25778-2-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE4NiBTYWx0ZWRfX0S5F1H9HngLT
 eXPO67iFg2n8DTIs14m5ubXzTMpQavy9tG3av2O2J4qV0/kT6zQ6yip00e36LyEVDwc89qnPWYj
 uXoY3LsBgiDs1tZ3h8UAneuoV3OpYN1/nmaxuzvVDjQGmmwojCXbSZDfjapceEieFz3sp0ouWZ0
 fFmEcMFnWau/GEJCvcp/MT7YADuNrWeiTfRGpxWt2qiiUJ4RIwHa3S30sAjIxG8prarUFSJ2oW3
 zUNS7fKya7m7jRtwY9mq65hE8nhh+x9x8Bu1EtFWuoqvWlSwTfPdsFo7ahq4bs69F6fr6Bnz37y
 QMtW16T2NsGt4wnXhCCLgSVtQIJVcJJfuVcY4ptxdptBIRwFe0zFhC9d3RJPrujpOCfmQjDOO+f
 7dbPwsb9LP8tNMRNzyU7/S0Rtg1kNw==
X-Authority-Analysis: v=2.4 cv=CsKys34D c=1 sm=1 tr=0 ts=69125f7e cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=rOUgymgbAAAA:8
 a=wQdz1tM6fslYZEmrDPIA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=MP9ZtiD8KjrkvI0BhSjB:22 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-ORIG-GUID: WrYC5sIOv7KrNervaMpIYcvDKCFfFLW3
X-Proofpoint-GUID: WrYC5sIOv7KrNervaMpIYcvDKCFfFLW3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_07,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 bulkscore=0 clxscore=1015 phishscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100186

On 11/9/2025 8:59 PM, Bagas Sanjaya wrote:
> Hi,
> 
> Here are two documentation (indentation) fixes for accel/qaic as reported in
> linux-next ([1], [2]).
> 
> Enjoy!
> 
> [1]: https://lore.kernel.org/linux-next/20251110132401.200d88bd@canb.auug.org.au/
> [2]: https://lore.kernel.org/linux-next/20251110135038.29e96051@canb.auug.org.au/
> 
> Bagas Sanjaya (2):
>    accel/qaic: Separate DBC_STATE_* definition list
>    accel/qaic: Format DBC states table in sysfs ABI documentation
> 
>   Documentation/ABI/stable/sysfs-driver-qaic | 17 ++++++++++-------
>   Documentation/accel/qaic/aic100.rst        |  1 +
>   2 files changed, 11 insertions(+), 7 deletions(-)
> 
> 
> base-commit: a2b0c33e9423cd06133304e2f81c713849059b10

Pushed to drm-misc-next.

-Jeff


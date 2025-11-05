Return-Path: <linux-kernel+bounces-886432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 828A3C35911
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 13:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8E3454E76A4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 12:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE56313520;
	Wed,  5 Nov 2025 12:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EBgt27An";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JuK/1PZa"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEAD31327E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 12:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762344713; cv=none; b=g+IFYVw6HvM2+mgpAE3N/WtUpqfvZ2OBKscepjmy30wNDERRPbrhtvyDIu9lmXfBGjgq5DuRPDOP+iEuIGlFoMZ6x8aMIkgY93YQfeq4580qsoTb3twYDzKTobXGH1sInCpM+htMpQDlfcaVDM6KE3Vt8jqt6trU0Sol9FC6Oqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762344713; c=relaxed/simple;
	bh=wz5ENZt5Ic8O9QlHYo2XewF50GZ2Oa7k4QWZhPiExVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZB720LyP9rl+4KWmOGosjqt/Gg8WqFjHHs3PtSU1E5O2DR6Kexr+87r1YOOZ+3VwkgSc+VvquhruUmld5kNkiDnbH1PkPL4jmYVwiGBWxK+U1EF0UJCSM1/xYMk1r86f8WcOVtduHGoonR4U4EGFmKRGnzvnhTJGH37mMyG1Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EBgt27An; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JuK/1PZa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A58A3A42903465
	for <linux-kernel@vger.kernel.org>; Wed, 5 Nov 2025 12:11:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=snsQD4l2AXcjWmxN/fszbJ7h
	2kOikH95rE3CwRz2zUM=; b=EBgt27AnuOFLD3tZKyOpo6xD83u9A03VmGfBkMds
	lb4PiRYRzac2NJUvXa25gcwayfM/C83TuN60XmLEvyvKWPb2RnxBWFVfmkAJvjc4
	IUzvWYXBTaE5fvYx1WplcRSpt2ajYXpCQtvuGYakjmSqw4Ct7cS9dWTA9iPgrsni
	plxpBkZ+XqA1YbobP4Ez1BIiNFmpwJ5vF84rpnN/Iy6iAlUPD9+Bbqhl57qvKe0t
	Gmf4VZSy+E0KqIwbt8qVP8wFpIksJPSQJStcFGwGqKRUz0NZR3OUohHptKpVtxmD
	MGYVGPJIzmsEgR5KIPmxdDujDOY4D2mmAbF0gW2bKlU9JQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7mbbu6rf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 12:11:51 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-340c07119bfso9832816a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 04:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762344711; x=1762949511; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=snsQD4l2AXcjWmxN/fszbJ7h2kOikH95rE3CwRz2zUM=;
        b=JuK/1PZaEeaFxAxhp4ULGwfAuw30sVqZx9YrQL80IrRkw30XLqPk5uZjyWBxLjF2Ku
         pRoHmhk7bbWZmDGyDwHuvdkqLon4dF0DvBQPuFWXBx8TZ0WpAkIdoaOS2LV+im3BXEkw
         YsavRANfyCgr4vcHCguCw5xQEJCHRVRwlf5FLFz3NVR0QH2SjR7YZLHZ4trIIkeBzy24
         bYeJxwaleM2iRpsFpwvKQyw85Ir5+zstwL/jt7q2qt1WAcM1UchSEm7GvZ9LTtPRUMal
         FUZSM2hiKp0B2fcugI0riFu/aBqpFv/C54F8EVHdvPavAj/InjWxt+033HGL1D9UufPW
         nn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762344711; x=1762949511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=snsQD4l2AXcjWmxN/fszbJ7h2kOikH95rE3CwRz2zUM=;
        b=FB/+nL5Yo9Qf3UBvclgtGs4d97zaMgK1RIj7uEYzXVWJyskbPR3Y/QgoG11HoPgZwH
         lFYKA851J0QzRgXXifGnTrRPtF5cEYRcCoZ0lPJoP8e5tHp/WMN8P/+CXtLc1TBunRbb
         3AKTamcHgwlo3cMhK7OrHd+JbM49qWII6K5d6kjvxN96z//WveYtpuXoTcPu+ti/rj8X
         nxoXCfC7B1FEqy9kJf0w1+pO8ASJLznqvi+iwK5nZFTLIzTHb90bLgEopYavzOV8dftH
         igCVOi7gk3RA26LDV9Um+SXucs0ZQ3pAPNBSFfkD87vNq4xoDQFPkBuu3m6a8GV5S89h
         k8ZA==
X-Forwarded-Encrypted: i=1; AJvYcCXq3yA84lSsexk5kqDa1mA0+t3KnabcXdtdhoLU/S9bDueoBBjvcKRfFyHMkwAme69DC32TkifeiEYGBMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKLbKQULxyJ/JOyQRVYykxR6Vu5BIa+uJSNzrvN99M45hX0qLy
	6k6rDI06hlGlXQM+yCCZwQW5OmH/1rk3aOr4AQd6zhdQvY/gHJxxTsIqWZME7bP5QxAof/iMnum
	r2Sb7iDGF+uizo69dl9gXA0z1aIQ9u/DMak0PtVehkDY3dzy4NVrE70z+HJhxCapRrR0=
X-Gm-Gg: ASbGncsXnSyOJ6STzGYRsNIprR1zKYLLMLlyo4m+NGI1lsPpdHZW4HQ7zUk/f/d04pt
	FtRYLeqcRQPXkmIsr7EkEcOMvA2eY5MIOLANAVlOZ0609PzbMfZr0AJVoM0o6RamDZfWtDWG9Ix
	eux+dQO+EbyFvDI0x37pWjncUfSY3rrgymLXS2arTKlI/F+h8T37QKxxJjEWXXqBhKAh85Tmd/r
	QAJJC3Y2puAbpAzNUVpZd2xpcLBdntFG83PnYZo2DmNm+fUDFCCftxpFEZpd76rNp3KD7WLX5KT
	RzEbEmGHlbtE1gHGWntSOpOR/SzXHaPNrStuswdMT+WRoGUL3LJ9IQWk4jCZe40oc9qhq3dNl8U
	1PAblkbZMYHhpML9TviLQ+SAY/HBVzQoI
X-Received: by 2002:a17:903:244d:b0:296:3f23:b939 with SMTP id d9443c01a7336-2963f23bebbmr12373235ad.42.1762344710486;
        Wed, 05 Nov 2025 04:11:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHiEWa0ffKN5nZV90leH7AWVaVvhnOx2CMq8Af0ffJqTrfJblGjM9mAfQcc/g0CeJMjYVL/Ig==
X-Received: by 2002:a17:903:244d:b0:296:3f23:b939 with SMTP id d9443c01a7336-2963f23bebbmr12372795ad.42.1762344709954;
        Wed, 05 Nov 2025 04:11:49 -0800 (PST)
Received: from hu-pkondeti-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a60ef0sm59997125ad.83.2025.11.05.04.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 04:11:49 -0800 (PST)
Date: Wed, 5 Nov 2025 17:41:43 +0530
From: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>
To: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Hrishabh Rajput <hrishabh.rajput@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v4 1/2] soc: qcom: smem: Register gunyah watchdog device
Message-ID: <729d0806-0f92-45a3-ae36-307513f8b808@quicinc.com>
References: <20251031-gunyah_watchdog-v4-0-7abb1ee11315@oss.qualcomm.com>
 <20251031-gunyah_watchdog-v4-1-7abb1ee11315@oss.qualcomm.com>
 <nnq34bfbbi3satxiqzaouy5pgi3obyqp76avh2ipyqxx6w67td@e7eqehjq7iww>
 <40a6395e-26f6-4bad-88af-d89479b6fc28@oss.qualcomm.com>
 <abicharluq6bm7gbngkbdc2hobcfifcmazh7oukcoufsrpcpse@ml2wccwe6s7i>
 <599188b5-cd2e-4667-a91d-04cbdd62cecb@quicinc.com>
 <ykg7mwgncmvdap6xzyhmgxu6ur62zzfk5nd3tqrkivugn4w474@rkazrlhwbhtj>
 <2ef1d795-5cdd-4465-9333-16a02207a806@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ef1d795-5cdd-4465-9333-16a02207a806@quicinc.com>
X-Proofpoint-ORIG-GUID: VY7UkwC7DLoZaaW5-2hLffxKQfNK-smY
X-Proofpoint-GUID: VY7UkwC7DLoZaaW5-2hLffxKQfNK-smY
X-Authority-Analysis: v=2.4 cv=MK1tWcZl c=1 sm=1 tr=0 ts=690b3f07 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=v0qggLAlYnFivbKH520A:9 a=CjuIK1q_8ugA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDA5MiBTYWx0ZWRfX2J9rMc5P2m/w
 BHEDI7bXYl9XnK5S5SET1eWeTajddsj8Qjsb3f/GHpeLX5AgbLDsLD3jszr4M2P4w/lkJHjbBBo
 rq1UZr/AAGAhaT5I1WNpxvbO5OJDx7TEl/BM/Og9LexwM3YBHXewuVZTulOxEi/g3+OpNptoN+u
 h7eMk3znla3ASxGm7GmsDpTK3CU9FIsLLhLL5h79qxaQNTmV+uIpldJ5SpYNm4lJtE/hOx2pmBR
 fR6GZkfwGI/ISSzdQlDCa6kf+HbBUftj/Tra5Jxv2zfhLVPUqSy1I1NUihOzkcrrmGmMfkx6xcC
 QgrR5Rj++6mddNot/UKf6GtvCo70sTDjVrs11ImGtsT/3Mt2YpbifSgx5AnpbVM45T/hDOPvUQ3
 B+0eBdOdwglg5ECoh4E8Hv8xOTkOkQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_04,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511050092

On Tue, Nov 04, 2025 at 10:33:52AM +0530, Pavan Kondeti wrote:
> 
> > I presume if we determine that Gunyah is present, and we haven't put
> > sbsa wdt in place (e.g. during bringup) Gunyah and Gunyah WDT will
> > handle the outcome gracefully...
> > 
> Yes, we are told Gunyah support SMCC based WDT even if it emulates
> SBSA. Most importantly, we have STATUS SMC in gunyah-wdt probe before
> registering the watchdog device.
> 

Thanks Bjorn for asking this question. I have tested this scenario on
Kaanapali. Since the initial platform support patches have added
watchdog device, I don't see gunyah-wdt platform device created. When I
removed the node, I see gunyah-wdt platform device is created and the
driver is probed successfully.

Since this patch checks the device node presence via
of_find_compatible_node(), it does not cover the case where the node is
present but marked as disabled/reserved etc. I think it would be good
to add of_device_is_available() check as well to cover this case.

Thanks,
Pavan


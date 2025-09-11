Return-Path: <linux-kernel+bounces-811877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D13B52F05
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 12:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F299567EB9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29E730F54A;
	Thu, 11 Sep 2025 10:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bkGXXzC7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897AD30F559
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 10:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757588253; cv=none; b=TIdNOkJVzipdMkWqbeBJ7wOoyjeIgXx4Y2BTF+wn+1v47MJTkpWjucxs+pXCko5mRkBDwo1C8sQhfZVMXK3QXDNgM3ZRCt8i30VEZyuRrBL+vcfjttURivZvHVQL/4+/E6OSdsJferlIgBCDZdaQNjM4LsRynMTv9M85a++YDcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757588253; c=relaxed/simple;
	bh=w20I3Or4zRoNyF774X/Fgv8TN+IVZ+rO/jEo5fzcVzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XgWcWAp0lPSNetUa3RNSOB7ohqrMCta6dcVEjt1PMfWAEgpxfiF9goKMEIagoLn+/JcqStxWIYMhnqPeyxefNqFGOeuF4QkP1C3TqJlH7tYvo56Ugzz8RykG7oUwJuTfzYidzS7XvkQglCf4YWpxuuW93uGgE+KPoU189O1Ttz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bkGXXzC7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BAsUZ0005468
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 10:57:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	w20I3Or4zRoNyF774X/Fgv8TN+IVZ+rO/jEo5fzcVzU=; b=bkGXXzC7osxLiUED
	rB7nmC2VILhkx5rMILzT06IFeDLGM8styZehSnsAEhQ0urhJRLxKP2a+dEyYfdKc
	oVrVKpQgGD+GI7ckTMLUlDNCnN33bjnuL50qmHkFyohR0gnJabd1q+3dvePDaSGS
	CslxrWLJWb/yYwtyhmmyxW23RCTvlADxoikmfvTMrLxt++ZdmKGiR6dlBhGsO3Io
	i1OYxuo45I6A3hAWOwuZ3BeaNi2E2FIblLnaGo2SctKE557YQiAIQG0nAW6+jiJi
	NPFlnPisTYU1Sej6jGNq5wmGpCubSS+8Pw/LBDVg00ZXIMmBBHgaiztikwG2fhkR
	hpAt+A==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491vc2bcra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 10:57:30 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2490768ee5fso5033025ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 03:57:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757588249; x=1758193049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w20I3Or4zRoNyF774X/Fgv8TN+IVZ+rO/jEo5fzcVzU=;
        b=edbXF14E4QCRhXLIA067xEgc1HQXpAvCczLkC2oMda9RUyCRF69Zq8W+TQdOdaRvW3
         vb0yTQEpLuE9R3N5XR7x6ccXLIlF9TXY5SaQjwdiBNycwiBVMkVVU3bnR7ks4LjvHD0S
         fzDw217D51+hYMlH5xlsANbRqXjFQhA1d1k8B9qo0kKMLOOt3HahvHgtvlA6wQZJMUv6
         3cmsGEBlJybUreqfhHkXFLJTv6Z0ODMTNOOdM6GB80zyDW97Sv3jJpatSD5r2OK3/drM
         8Q2rBLKA6+LNWuzsvreSgErAVVcYo68nnvmojXgxzhiBFXmYz44ctUaPS74Rz4FKWDUR
         ivAA==
X-Forwarded-Encrypted: i=1; AJvYcCVW3celxh+N6Snvvbg9oC2CwGM4WpOvB2Bojina+MYc13W6BF7r/xjuWh3lEyKNz90Vb46Qd3G/0c5vj94=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzzL/a3dM4IoOpFHpUUBrl+3Qn9Pk2Hz1IutlsVOIvbNRnHmAj
	cW5y6j44jgXUVIir2BoMJbuhH3A95J2Xc5qr2A7d33Gk0tSAfCUQ1qzBB+BuDOTO7xjDd51b862
	STRze9fIaGK4As/FqLH8jmaIWGvld8zVe3f7a9/z8wuaiwaJ7B7q3rpL6Axy34eJgNfcpuuz2/U
	OYCrx6rfIdIrWw9Cx9J8hOzSCKDJ1hMDIZS0h/y+M1nQ==
X-Gm-Gg: ASbGncv7WKtsiM0hYsiaYjqInp/EIBIh6R7R5qgyerjt9y9xTSAsTEKo7It0mf9sn4b
	s6wmXHtJ+Kie5hBGuwIo2Cn8dduAaHQozlJE6AE+xgsKKFxmWSJaswNRSe4cmAoae40xsBYXVhd
	QRy+FpKeN/mQsrT2uxdoPX5wGuKS+c2yTDqYA=
X-Received: by 2002:a17:902:f606:b0:25c:8005:3efb with SMTP id d9443c01a7336-25c800540b9mr9214915ad.54.1757588248920;
        Thu, 11 Sep 2025 03:57:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAH11JD2Q0IWOglR3V4QiPu9OVEC1C5tZSFPqr+NcxPJGuPbUCJ+dsuSyVMVCW06uEy6k6eSWe+gjk2lD+b2U=
X-Received: by 2002:a17:902:f606:b0:25c:8005:3efb with SMTP id
 d9443c01a7336-25c800540b9mr9214575ad.54.1757588248467; Thu, 11 Sep 2025
 03:57:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909114241.840842-1-quic_vikramsa@quicinc.com>
 <20250909114241.840842-4-quic_vikramsa@quicinc.com> <w54mpkzk7irjb7m5jiouxhj77czj4ex72oqioaph4o5qhcsay2@qjolctktsu4s>
 <8104bb41-e827-4daa-bc96-9b6678a9d345@quicinc.com>
In-Reply-To: <8104bb41-e827-4daa-bc96-9b6678a9d345@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 11 Sep 2025 13:57:17 +0300
X-Gm-Features: AS18NWDL5Sq7WXLmyGnLpCSE5BXnWmdKo1qJbjlndUcI-PeO2ah0x-l-T_QEjBQ
Message-ID: <CAO9ioeWLrYAFG2cN6w0uOqQE7K83EAyN7om6+QEPUWRZoZ3-Nw@mail.gmail.com>
Subject: Re: [PATCH 3/4] arm64: dts: qcom: monaco-evk-camera: Add DT overlay
To: Vikram Sharma <quic_vikramsa@quicinc.com>
Cc: bryan.odonoghue@linaro.org, mchehab@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
        konradybcio@kernel.org, hverkuil-cisco@xs4all.nl,
        cros-qcom-dts-watchers@chromium.org, catalin.marinas@arm.com,
        will@kernel.org, linux-arm-kernel@lists.infradead.org,
        quic_svankada@quicinc.com, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ravi Shankar <quic_rshankar@quicinc.com>,
        Vishal Verma <quic_vishverm@quicinc.com>, quic_nihalkum@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=FN4bx/os c=1 sm=1 tr=0 ts=68c2ab1a cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10
 a=COk6AnOGAAAA:8 a=OL7WMRyR3eFSKxD7jRQA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: bbSOABbJQIxO6tXKzgJBQ5VosGI7u0A-
X-Proofpoint-GUID: bbSOABbJQIxO6tXKzgJBQ5VosGI7u0A-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA5NCBTYWx0ZWRfX/7iJl2O5rBO9
 Ug1WXhrFWRGjeLf74pnRo7FqtU3diD/XDyB47ziKKzTLfIWko8Og2M3i0YGPd5c8mF0u4IAxt+j
 2xzqp4BNMB4QD+8maoekDSvmvO/T1TUA7cEgDNIhWuMdZSTQ5DM1XCr7T7i7aVP/Rt7/KVSk/5U
 5pRXdciv1cUCAutAZwhSrlISr2BoFYSfE1tyob261RDKchwQSFJtTUMfEg6IPq8r+lPFY01luH/
 IXtslS+6J+7S20DoMf6ZToAq0Q33C/h+bmnFDeTZLO4vBPc1CHaCpuE7T2lymV82LqzU8LDhdZ2
 GvZusS4eWEA+aoqvHdow8Hkp/ZWOF6x4ii0FtUd7qMYp7v+cXA8d/yQVLvl10N+L4zLJisnZJAW
 DkC46tBh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080094

On Wed, 10 Sept 2025 at 10:03, Vikram Sharma <quic_vikramsa@quicinc.com> wr=
ote:
>
> On 9/9/2025 7:31 PM, Dmitry Baryshkov wrote:
>
> On Tue, Sep 09, 2025 at 05:12:40PM +0530, Vikram Sharma wrote:
>
> From: Nihal Kumar Gupta <quic_nihalkum@quicinc.com>
>
> Enable IMX577 sensor using the CCI1 interface on Monaco EVK.
> Camera reset is controlled through an I2C expander,
> and power supply is managed via tlmm GPIO74.
>
> Why is done as an overlay? Is it a seprate mezzanine?
>
> It=E2=80=99s not a separate mezzanine; monaco-evk does not come with an a=
ttached camera sensor by default.
> The overlay simply reflects an optional camera sensor attachment (e.g., I=
MX577 on CSIPHY1)
> That is why camera sensor is configured in monaco-evk-camera.dtso instead=
 of modifying the base monaco-evk.dts.
> Please suggest and alternative approach if you feel this is not correct

Okay, I found this email. Please fix your email client settings and
never send HTML emails to kernel-related mailing lists.

--=20
With best wishes
Dmitry


Return-Path: <linux-kernel+bounces-877448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB0EC1E23A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 03:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C0BB1889824
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 02:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98335329C67;
	Thu, 30 Oct 2025 02:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KqLa576G";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cg3GdP8l"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3F332AAB6
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 02:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761791611; cv=none; b=IB6dDrm7pEDeYmfvxkZXzT618Qm74Hd0Q7AcX3WkvyXQPEKa8eK9sGL0IzcaQhB2zHePIvLJQRkue1hhUroRQmsZydfVqS+ouG5S0QstfAQ9sndEB5fMi4zlO+Mkrvb8w6kKCMj71HFKKIdO+Bbis8+7wkfwviXhJBHvKNK9tc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761791611; c=relaxed/simple;
	bh=fXw7zBhHIr5vfTBHJdVciK57oiNhDP1bmyB8vN6GywI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYs7MXRqd9PydrfLsRkav6l0iCpuBJN5zYmaocGey6Cw2MkVtgIe4oDgi7ZToTR3pYpniA/oGBb5Suw1WQRVzDg50mrBXo4NvKZNePQ4tMJMY9/SRWceHWAoQmJtey79pIZQVu7iFUXkbTp3e6Jdrnz3dhzHLngpKomAehmejFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KqLa576G; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cg3GdP8l; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59TIrds61324798
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 02:33:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ntHK9vxhminoglXJfxZX7o01
	Uc8LpengHLNaWyUigT0=; b=KqLa576GQs2Sl92ylUs7z3iLC7DxRQ83BJQ3wO5T
	CMRGAlL/E5pXBXJdFvDZ61vloRvIKLWoOomhGALMgT4ibA/PZP43eStYj9YqYmct
	cqpesaP4pBoc574NM8I/JNjaSbFm/DTRTWJjCpcM9ZkGVyEN2+H5EpV6CAuVJSHT
	kfDI+XI7Fh5iqsP8AVgRuZKoCJr84QjeI1YPWqTPCeHvjcDCCtkmoYE8H4zWFsKS
	U4vIEB3hqq6TUgP3pyXnigJ8NyJPfV+wvMO42Jj3gkAgAG3i/pkj8EPue2KKwKxv
	aK5e6s2znwbo0VsbvyarSvbk7BYiRK9H4KDCtpFr7Xrc0g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3rkus5vg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 02:33:26 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e884663b25so14673681cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 19:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761791606; x=1762396406; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ntHK9vxhminoglXJfxZX7o01Uc8LpengHLNaWyUigT0=;
        b=cg3GdP8lA3nf7cYguD4YII3FV1NoxtoiXAjpD/oN1KF+u2iU9ofe5qY4P0DzBdppDW
         UsUbykfgX6/hxzssJJpypQjz8Po5TYN4T0i77+c6RJoJKQHLo4Na81XtcIG0tF0sqRTl
         3cbSGLrRg4IGm5nXVoe5C3fuv39+FCvLO3I3EEItdJzjJyB5X0orIl7d9hhISE7WyY9T
         QadIpIuva2cYZtCkHTsn3WEUYjSZPAj+7hsF1nS6uoQuELQMg56hZxx/E24Zo2wiZoSP
         QRBUCNCXu9nn/hOshiAgX/GIxwCehhzwhiORRDrMxFlIaphzXn7l1sWTJsAWdjDHui65
         2xYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761791606; x=1762396406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ntHK9vxhminoglXJfxZX7o01Uc8LpengHLNaWyUigT0=;
        b=jI96Q2jJ7T1j5FYGmJAT+K0AllC3bXaXBnAPDPvkyvIEngmfpsiyatBdlz/HOEi7N3
         MNhlJpxkm5AfO67pn16bXCtEnYEt16O/6irtH3m1KiFrCdBeG1vpOpdDMT0bQbusxxtk
         edZHpGoA6xVCJbzzGhGTcr3mQsXW+9FvccedddmmgKGgBDTXUK+qYYiZwAm74hIdp4Kl
         2s5yfw5ALREzMWr6xHz3OPb1XudKiTlhY2yt+yw6r1SGVXmAxsRFOxVmocrXHLKTHxm8
         1NHjHkWx3Xe6sVIZPOEOY5EZcMa//sd9LXJz1E6TKzp2GTbbBp4opIHblj43TN76byHX
         bXZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfkOAwaqlkjJ2NDWctdEzH7PlNnI6riLM+0I5as4kfJ6FKRe4ZrXenmuhaHGzJDU9YeSBGrbLfd+MSq/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO98hu2mRJJoWv2bZ3E5H9nNbS5Zudnf7bKvvINec3udnHJ6af
	Dt3qRCu8H5zspsuHA7uNzN8smzimCU6qL89nhCjs0LvribhhBBxf2AEhdChjuCbDyQfDkdJ+ebU
	exu+Mt8Cxgte8DIM7pUkuuXfVGedFhuHD6VeQ2qP/hseTKfoHb128IezaLArzoY5bLjA=
X-Gm-Gg: ASbGncsKPHZq5/lAMhoIQMJKnictMUQtHrFGwjsDrWZqsrVOlf4Jeoqz/e59gPoP0Qc
	tv8jxueXqT1hFru6HvVAFEC62RLTCa5J8fuejOyBfbhP/B3/UXSOZ5Nj9tCPCWZtRLG4B5flGxV
	AwcaohWuerFBvF1gMYQy6nmDxEIy5uwXkt/zfFVZSkqqGqE6da3rbxCPFaeR/pYjVCs8OFJj2Tl
	44IbiHv/I19wmZVYKk5iqeWti/j6o8+LTYuTK3ucsVe729XtygSI0K6jyo9OnxTYBh0k02Kl6L5
	mHus7vV/bIoCdHKZ54RRDyAZKmFg1OxF7LAH70mj9tnksB1ff0+QbHaeuCcdSOl8P3dNl5Mm7ON
	B6rMkn9j7gisvS0S+Codnrol+g1TURqyyrVD1veiFg+cLXIO2hsne8QsL2c+u
X-Received: by 2002:ac8:5acc:0:b0:4ec:f9a1:17bc with SMTP id d75a77b69052e-4ed15bb1f61mr53768031cf.5.1761791605749;
        Wed, 29 Oct 2025 19:33:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH62Xw8UczlTHR5mIibSKtnyEtT1gApL84hMtZ++sQ4IY5il5n+hfMOijT0cJsyTI5gYuh+Ew==
X-Received: by 2002:ac8:5acc:0:b0:4ec:f9a1:17bc with SMTP id d75a77b69052e-4ed15bb1f61mr53767891cf.5.1761791605240;
        Wed, 29 Oct 2025 19:33:25 -0700 (PDT)
Received: from yuanjiey.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eba37b51c6sm103962621cf.5.2025.10.29.19.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 19:33:24 -0700 (PDT)
Date: Thu, 30 Oct 2025 10:33:12 +0800
From: yuanjiey <yuanjie.yang@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, robin.clark@oss.qualcomm.com,
        lumag@kernel.org, abhinav.kumar@linux.dev, sean@poorly.run,
        marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_mkrishn@quicinc.com, jonathan@marek.ca,
        quic_khsieh@quicinc.com, neil.armstrong@linaro.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, tingwei.zhang@oss.qualcomm.com,
        aiqun.yu@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com
Subject: Re: [PATCH 08/12] arm64: defconfig: Enable NT37801 DSI panel driver
Message-ID: <aQLOaI3ngjswi7kd@yuanjiey.ap.qualcomm.com>
References: <20251023075401.1148-1-yuanjie.yang@oss.qualcomm.com>
 <20251023080609.1212-1-yuanjie.yang@oss.qualcomm.com>
 <20251023080609.1212-3-yuanjie.yang@oss.qualcomm.com>
 <wuh7agcgg6spghilnx4amqukaaydj25u7kbdiod7fl6pu2ulvm@pmosyuo43cyw>
 <aQF98RvLuOlJZlFi@yuanjiey.ap.qualcomm.com>
 <38c8e26c-08a4-42d9-8f6d-93969af90d50@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38c8e26c-08a4-42d9-8f6d-93969af90d50@kernel.org>
X-Proofpoint-ORIG-GUID: Qm9zXGuy-6QmW2_TWMP0K_5Jx3jAlrs2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDAxOSBTYWx0ZWRfXzmNZLrbDkAST
 vkwHkSdNL2iNY8kNbWa/us/cBR6j7VdbA4j/1QQOy+5cEYEr2eUNPLyfMwT4kGasgUscnyd5s9m
 VQ5bg5J/rE3ltyAK99Pe7m6tPx2xG1tsthI+xHYD9k2jxTBLlWyWkLanuYM+L14oEb5jMMUkByw
 amCRciafYML6gXH7O86/KNdiESN317YsOwAIaPCeh/fFcATfBddoL+Bw4vn29FiAUy7t8RozCsk
 SyNPlve3YIcY3MOQFmjMdfPmkADt/2ws1VwkP/GyGBTEovQrcaNFNyQE0Prod9tkMX17XbZUWYb
 pKQGBz57c+SYxaOpPAK4zAP1M9PWxl94Krctigffgzb1kxPGCPdZUaPsbQy+GIhK7b6K7j0TF+z
 dC6pLKhLiRXY3H5mz721SjmBMOXlNQ==
X-Proofpoint-GUID: Qm9zXGuy-6QmW2_TWMP0K_5Jx3jAlrs2
X-Authority-Analysis: v=2.4 cv=adZsXBot c=1 sm=1 tr=0 ts=6902ce76 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=n00Os9SHjSpe-nC2C8wA:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300019

On Wed, Oct 29, 2025 at 02:05:20PM +0100, Krzysztof Kozlowski wrote:
> On 29/10/2025 03:37, yuanjiey wrote:
> > On Mon, Oct 27, 2025 at 10:51:23PM -0500, Bjorn Andersson wrote:
> >> On Thu, Oct 23, 2025 at 04:06:05PM +0800, yuanjie yang wrote:
> >>> From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> >>>
> >>> Build the NT37801 DSI panel driver as module.
> >>>
> >>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> >>> Signed-off-by: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> >>
> >> You (Yuanjie) authored the patch, but forgot to sign-off, then Yongxing
> >> provided certificate of origin, then you provide certificate of origin
> >> and send it to list?
> >>
> >> Please correct.
> > 
> > All the display patches were jointly developed by Yongxing and me.
> > So every patch 
> 
> 
> So two people were working on this absolutely trivial defconfig change?
> I have troubles believing this.
I want to say these patches I am first author and yongxing give me support, so
I think yongxing is second author.

I want to express my gratitude for Yongxing's support in every patch, so I included
both our names in the sign-off for each one.

However, if my intention causes any trouble for maintainer, I can remove Yongxing's
sign-off from this patch.
 
Thanks,
Yuanjie

> Best regards,
> Krzysztof


Return-Path: <linux-kernel+bounces-859759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DA639BEE7DC
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 16:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5E810349DD1
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 14:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A20E2EDD63;
	Sun, 19 Oct 2025 14:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eVrfCPYb"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC16E2EBBAC
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 14:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760885623; cv=none; b=c6JfwB7PDwtH7Oj3o7znggweu/UzrVV6hUfFpiz99DHRB1SbRckYHo8oVykn2qASLo04mBAY3qpSUJ5OMyKOyxJrzDEchdJenEsBwMMV5lC6WPjSWx6KJ0Prj9xAydHKIHo7o3PtkUkiFMIRhqZNx7d3rCgese3bqr+VpoOGQQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760885623; c=relaxed/simple;
	bh=v+DNIJKC7LVTEFir6s+qL5nG6oYv9UZBgPlGapUsziw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J7kVaD8NrY78EaxBQUlKsbQJOMb7Ko2hfydlTJhtcSVM8bppxLs6MfkH9XFHIsheVrWMM+6nCSJPHJ8vWYm4veB6kFgGJorQCLoiKRpxzRPM+4GD5+E5ais5RgCS7i27CJ1Rgf8JA/Nykc7webWu4mvNJxSPdDyPsZMd35J01bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eVrfCPYb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59JBd3BM013566
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 14:53:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=A24maVFATESsTlySoqTQhxy7
	kngNIH/LwnVSqaac+uw=; b=eVrfCPYbRz/fMbWC1ppsBPH4Sgwf2vftsGKpSwmO
	R4loZ0N2FOSYWhCh7NTUmxYRXVc8Z9G36vfEe7TOSSCU/1L17yGoQK5e3TEgt+o0
	AZisXhWb1r94l1v5nMqv7PhgjQxU0bIQ/S00TfIFD+KSYZscHV2sIACHOJkxQKh+
	JWkEbrC2hyDDrGGCxBB+W/uNwwQ31lhNr+al72GgxRxnSPRB/pNCe1/GlfVcui74
	CWdIdCIy7RNztMGx38Puib7dGhw4q/uv2AROR/SmpLSBrAjGUyCOFyRy5V6Q5niB
	kZxgOzViuCge83M9615W6VISstmn7wyaMd5IvgLxHiM+QQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v0kfasfr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 14:53:40 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-84a3a7ac082so1260676185a.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 07:53:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760885620; x=1761490420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A24maVFATESsTlySoqTQhxy7kngNIH/LwnVSqaac+uw=;
        b=Ph6BomrkUZSsjqnfYdcGbdC7kGP0sbdWQjAYk9I5ZnkiMVDJgY7efkXbtnmgMDdQeo
         zMhYLnD7u5OYUovcFti137oSd6dHroERDcQq5cs73gOAAqq66GH5MHMopioMbt1MPKcF
         UQ95ttg4bSToUa5ge84QSscRWngijVEslVKDvrXdb/Hqa8heopwAOJ6Y40XRV0FX0aUP
         27/UHEMpuZzGTkzRlvLLsgzkNE7gd2vLwkYr2AapLqi4DcFYZX2lguy0aYPvFh/k6yCj
         kqU1sBT6tmudCC0EMchrvYHzAeAJhTcxgQP2lzsDyllSs7B0fPx6XvhNI/OeKgUr6CCK
         Dv6A==
X-Forwarded-Encrypted: i=1; AJvYcCWhLj2+gbCX/wBnQwFQjXJYrSuCQ5p3K4c+zaHehm8nFUdv/HPO0oMKFhc7sW5XSYSYT4Alj7CPyAY3/WM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz3mCUv31VHZCiUg7MlpoHtovjXskxrnyijj9cYR5kRYbciaSU
	EnT+0K/b7iMb94rpszO7qN+IUfPM5pnCENfRtqPZxOgVhwZ7bORy37sMY+n040+MKYhIG7Kv33l
	oDT//Zq4guYgBPeZQLQGd/ZUymlhcwh+GYvSb8sdcp5sw84z9T/1JC116oH/GkE8uMwI=
X-Gm-Gg: ASbGncsH2RAWp3bJo66RfD/vBwq45aBDw1RcWSWCtbhBVqVryn8Knew5tAn5rYBT0PM
	wRAZDlx4y9gB8bEyZHQiOKopldvnyI/2QvbERyEQzFBKr/GU7v2hPYZWTXny6KywC20WQkSi25F
	iWiVCBRYJalCUxVTxu4zwZz/3LrcCCo3+UM934i3kypAkaqOrNUYoIq/VrQIZ4bgO3jWRrJyXMS
	YIvwdQl3weHvFbK74pUIIrFXFAYR3b3Lmzt5JlTJGPKUoY2I1zlRDrWzqG4ESjHp0dhgz6GUnjl
	DY0tLylh39yPOXQvZHMcE8ADb6nSu7j2eXMbHOSdifa1+zwGt2reQ7gxmzpmbdlWOSgAfciFiDo
	+lk22XTfpdAoKiOusitSgujlLUZymk9dSlHKJGtnwHq6lGT0/7floqze4rae8m39IGXNcSj2IGQ
	k0xYoAueg+O0I=
X-Received: by 2002:ac8:5710:0:b0:4e0:24c5:5137 with SMTP id d75a77b69052e-4e89d3627e4mr138238631cf.51.1760885619630;
        Sun, 19 Oct 2025 07:53:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHly3/EfmiSEOivc1I/hknQKtS52LSHutywrccRSqCRSmyWqUn16HN5RNyUGYetTlLKDXSZhA==
X-Received: by 2002:ac8:5710:0:b0:4e0:24c5:5137 with SMTP id d75a77b69052e-4e89d3627e4mr138238361cf.51.1760885619115;
        Sun, 19 Oct 2025 07:53:39 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-377a95789f1sm13418781fa.41.2025.10.19.07.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 07:53:38 -0700 (PDT)
Date: Sun, 19 Oct 2025 17:53:36 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: David Heidelberg <david@ixit.cz>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Pundir <amit.pundir@linaro.org>,
        Casey Connolly <casey@connolly.tech>,
        Joel Selvaraj <foss@joelselvaraj.com>,
        Sumit Semwal <sumit.semwal@linaro.org>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: Add support for Pixel 3 and Pixel
 3 XL
Message-ID: <r6icx36qpns6sf6btjtjssmjsmkmcvtgq4jyo5yeiect5j6tlu@pe6kfmdaxlbh>
References: <20251005-pixel-3-v1-0-ab8b85f6133f@ixit.cz>
 <20251005-pixel-3-v1-2-ab8b85f6133f@ixit.cz>
 <n4xims4y5sssqxkchg2tikc7idkzds5ru7ayidcgxdfx77je2d@qo34qucbebnn>
 <a5da8d40-f194-4fed-9118-037bd39ebe2e@ixit.cz>
 <st7oizyyih3fnsi7jgcp47pl7s6n3gz2rdcv7iryftol3bqvxk@buam77hiqnl6>
 <1eff5dd7-5229-4ee3-9856-ae61b4c82f9d@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1eff5dd7-5229-4ee3-9856-ae61b4c82f9d@ixit.cz>
X-Authority-Analysis: v=2.4 cv=E6LAZKdl c=1 sm=1 tr=0 ts=68f4fb75 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=hOZ6dJPvPovaWAsPY_MA:9 a=CjuIK1q_8ugA:10 a=dK5gKXOJidcA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: NzyJfd_BZnFqxxHOx8rYv5hGr5KZlBpW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAwMiBTYWx0ZWRfX6GdkhTSncbTI
 qqBfOAmt24bFSgO7lXXsDTqknYU6hDN18ZDFd8tSm0OdK9EJl9ncLy7WDSEShQH/PsAQ8acPf71
 7cIcLVoQlxC1ToEetovJH6fttAGOrlo4qagGJv89TjVIgupakNU9ZBHnKLW/BOTOtUpUVX/V2AU
 Ae/74wjCZHOai4VMRHnXuPzT//zW4OtBzdMlG/P5EugfkcqiECtOEa3aH/8xbsaHo6hv3ZWNJwj
 BH0O8wuMXOZOu8dESM8RiSp2jMjt07lbdJt51BYdXvEqF+3haG1CRvNtV0QNdmOIp07SQqX6052
 ZDMlBFpIwFFip5U0uRw1J7c4AMxeGyIRUrsaVutDfL/fcYgmxBHvOC/qUH5Cy4W+mSZjOxe8UcJ
 uUGzTAVfl1JWrgJjI62isVxUzKTsBA==
X-Proofpoint-GUID: NzyJfd_BZnFqxxHOx8rYv5hGr5KZlBpW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-19_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 phishscore=0 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180002

On Sun, Oct 19, 2025 at 03:02:36PM +0200, David Heidelberg wrote:
> On 19/10/2025 13:51, Dmitry Baryshkov wrote:
> > On Fri, Oct 17, 2025 at 06:59:14PM +0200, David Heidelberg wrote:
> > > On 06/10/2025 00:03, Dmitry Baryshkov wrote:
> > > > On Sun, Oct 05, 2025 at 03:16:29PM +0200, David Heidelberg via B4 Relay wrote:
> > > > > From: David Heidelberg <david@ixit.cz>
> > > > > 
> > > > > This adds initial device tree support for the following phones:
> > > > > 
> > > > >    - Google Pixel 3 (blueline)
> > > > >    - Google Pixel 3 XL (crosshatch)
> > > > 
> > > > Great to finally see it being submitted!
> > > > 
> > > > > 
> > > > > Both phone boards use the same identifiers and differ only slightly
> > > > > in their connected peripherals.
> > > > > 
> > > > > Supported functionality includes:
> > > > >    - Debug UART
> > > > >    - UFS
> > > > >    - Charger
> > > > >    - USB-C (peripheral mode)
> > > > >    - Display (Pixel 3 only)
> > > > 
> > > > No remoteprocs / IPA / GPU / Venus / WiFi / BT? The firmware is
> > > > accessible to download from Google and it can be further repackaged (but
> > > > not redistributed). See [1], [2].
> > > > 
> > > > The phones share all firmware except for the bdwlan, so hopefully you
> > > > can add 'Google/blueline/foo.mbn' to the common file.
> > > 
> > > Would it be acceptable to use path format qcom/sdm845/$codename/ e.g.
> > > qcom/sdm845/blueline as it's used elsewhere?
> > 
> > We have settled on qcom/SoC/Vendor/device/ long ago. Could you please
> > follow? All upstream Qualcomm devices follow this approach.
> 
> Sure, in next version it's done! Would you be open if I sent changes to the
> existing firmware paths for sdm845 firmwares?

Yes, please.

> 
> Thank you
> 
> > 
> > bdwlan should be sent to ath10k ML:
> > https://wireless.docs.kernel.org/en/latest/en/users/drivers/ath10k/boardfiles.html
> > 
> > > As I'm looking at the Google scripts, I assume both blueline/crosshatch use
> > > same firmware (which makes sense, as only the battery and display is
> > > different).
> > > 
> > > David
> > > 
> > 
> 
> -- 
> David Heidelberg
> 

-- 
With best wishes
Dmitry


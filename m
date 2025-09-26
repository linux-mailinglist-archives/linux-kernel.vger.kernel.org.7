Return-Path: <linux-kernel+bounces-834714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56568BA5584
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 00:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED7B64C77E9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 22:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBA028E5F3;
	Fri, 26 Sep 2025 22:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oa4ImZYn"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2926D27EFEB
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 22:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758926161; cv=none; b=mwXgmgO5QdPMzYcqR2h82Yc+H8+4tWtodeafBKgN3Ix9TymT6qfDNXFkZ4ZXWu0XlbWRZxNY/D4FtYNVEDzm1Hp9tFSrU5FYxubVAGkV6fVybZfOnuEGKiImc9qdxdrxMC+Gwtaljto8RbFqgnpYk2OcbhNAUgd+9wmLeZglYK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758926161; c=relaxed/simple;
	bh=9purHNX1lS082Hyqiy1U7KvnoSCetzFJVKiqA+89V8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYU1NQ9O44jHK+pjC/7HHLlJLe/IIXv/J4VZl8jWR44weT0kIUbF/uQ+CVnr1YcWjuO7PMtEOq37EiscLMduPbkkuCQRGB97ddpifIxraFpX3Kr6kUDyXlWyl4Jd+kVSfkDzimrSVANbRb42EmsanVygjrkWnALFyLeXn23rYz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oa4ImZYn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58QEWqbC016059
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 22:35:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=SoeY4l6ebsrYr5pagnV48aNI
	rgnvCjkETPIfrORiaFw=; b=oa4ImZYnM2V3WAMBIsyzs7kAnuckDrb/EzjN8BlA
	CodXqF6dZFTwu74QKBC4wl0XM0onTUVfpBpcmHpfiODxqL12Hjh56fs5QlqY+u9j
	/3K2UIQKxdmAd4SrLs6VpaB+iAJ9Zp6baHDpFL1oXt/5GfxIAgne46tyz5RKaSXa
	CFaA3AWi6O3OUtSL6Q3K4wlCZBwLQC0VwnEsdUCfFy8NE48Ma7K0NimyL/TYQQG0
	3U6zVHpvRD92zoVlV5B532RFk8DbbqpjOwZoHKig2EWoLnscWqarSEE7BAankOPD
	OC3mMibYKu5Bu6IFP5pN6vQXV+a+O4e3oO1LNU/zN8BgOw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0tvasa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 22:35:58 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b5ee6cd9a3so59490671cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 15:35:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758926158; x=1759530958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SoeY4l6ebsrYr5pagnV48aNIrgnvCjkETPIfrORiaFw=;
        b=n4SFI9u8tVJpXnGAushWYCht7LVRODyUAV9XDnckzYYQiuz4GUbGvzePSRWqgumIuA
         ZPoo1ja1BjX+GSWjTRfSwluH6BClcTciFKabUYrI9/rj7Bg840HhzF6nhSiu/DWJvSax
         WlDfbt/6K2lUjgtvFW1Hrr3Irx+UK+is08x07qwAYNTS1Am8v7J+wzrKwyxa/IkA6y3L
         t8Xods8yHWghusU+CW0ldh20zj9k1+cDMEdDeN3UCbkqJS5+4Bl4pqHa54Xf/gyTi7/O
         R3fffjC5V4KxRxY7L46j8nVJ+pId3L5njZYl2ABD5GzHBdmKaCDU3XbDuJVxh54jfMTK
         YyEQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3e93pLwogeG7rVZYJ1PXWosmjDyaXthszh8z10j1k8M9xV5Aa+2Q9JRXd5rQVkXSXuNzV/Nf7TnfCh5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzasjB+sKffgrj2cGVCAaabYSK9cfv9vYO6iE5R0pRXhVrOe8lb
	A8aTtdhojQCBqp7BR8sOKl1L3SSNq+oNWjG3bqtl4crv52aoqIT0EvKniua5uW7MsUaMcMzCi2A
	V5eBzitaXvJ0TccWuvchWafVoYYNgYtLDvEypL8Nxr654DVzg7c42Y1YMxjRENYmg2XuyO58Zoi
	4=
X-Gm-Gg: ASbGncs+HHtWdRjPjvy1D3eiNsaMns33zXSgXBfmfj1/RXvUJW7y0zhnEApc/pj/3FU
	C5SPEgq/gWH1n2M9subFLrpIRXLS0+fv55p6n3ns7EHshuPyTcnGJW89ICL68Vgq5DOUEnxD00S
	K85sgR6bwoCUHZtWu5sqUE/LoVgUeBZbejB+a5Df0j2CpOGTcrOkQxWguN15ki1wdSsRzHpk5x1
	a6mmYCrpVpsEG7Ub5WAC/wD8pwkXfz72/b2ruYnqQGdjcLiFNXUpF+y0Wf7z/OgB/9B77fE7T6X
	EGnrCiMZewdSUBfMrKKwitHmSyvCCEUtUlHdKyf3JS2mGHY+Pi3riWIWcM1ZVRdbkLkEkqUpD66
	zQ/3qDLgA5mP/9d4b7vCFWtcyhnpQjlrxoUEo1GaGZsXcYmsHgTIS
X-Received: by 2002:a05:622a:1a0f:b0:4b0:da90:d7d with SMTP id d75a77b69052e-4da47a1a220mr115923191cf.3.1758926157807;
        Fri, 26 Sep 2025 15:35:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/mVxWB3lmLAFeQC9Fvkdijqlfs9w38uYfGjjdvBN7+TJwGSvqr+pkIUIo3hPrxbde64DYZg==
X-Received: by 2002:a05:622a:1a0f:b0:4b0:da90:d7d with SMTP id d75a77b69052e-4da47a1a220mr115922721cf.3.1758926157253;
        Fri, 26 Sep 2025 15:35:57 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58313430a7dsm2147362e87.22.2025.09.26.15.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 15:35:55 -0700 (PDT)
Date: Sat, 27 Sep 2025 01:35:53 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>,
        Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
        Viken Dadhaniya <quic_vdadhani@quicinc.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, quic_vtanuku@quicinc.com
Subject: Re: [PATCH v8 1/2] dmaengine: qcom: gpi: Add GPI Block event
 interrupt support
Message-ID: <vdd33houteml2inilry6vkqdpdm7vykcqb5vf66sdhq5knlfhr@mzlrb5babocx>
References: <20250925120035.2844283-1-jyothi.seerapu@oss.qualcomm.com>
 <20250925120035.2844283-2-jyothi.seerapu@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925120035.2844283-2-jyothi.seerapu@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=I9Vohdgg c=1 sm=1 tr=0 ts=68d7154e cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=UZ83mHg5h350vH40qggA:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: CNJY64-ot2E233oYvYIUuKH0r668xJGM
X-Proofpoint-ORIG-GUID: CNJY64-ot2E233oYvYIUuKH0r668xJGM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfXyHPYHFRfUwSj
 zFjhJKPturz7PV1WG/B4dzUBddXzWPGIlIccDfqEfFK/TYkAyfo/89tk6+tWZKuxcnnWpUm76cU
 Sk+koxjw96wujQ4So3HVQ0rsiKJUOxcUYrKBR6+kC9Sk0LmsIbpdVPd+kjd/ewxOIiCLPUtH7Gg
 235S4M0JTlkgJ09xyqOM8f/ZyeAqDbFZD11XCTFKB/GF87iJ35dwp492OTX8UNqT5uoeoy7TG6a
 TKyn6+9hzVq74cgp2fLiGtdnxDo6WITwTOzuQuxv44cX7DoEi6quPyHOY2YJy8YUroLxl0EDGJB
 2y3NqsBic+ulreT8RUHvab6dotJNRpKC6TlhXX0WLsfWNauJgHVonOnusI3L+4alVOIMqcyw+tr
 lrW+U+4x/B00ERP50QMgNfuRG4CvHg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_08,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

On Thu, Sep 25, 2025 at 05:30:34PM +0530, Jyothi Kumar Seerapu wrote:
> From: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
> 
> GSI hardware generates an interrupt for each transfer completion.
> For multiple messages within a single transfer, this results in
> N interrupts for N messages, leading to significant software
> interrupt latency.
> 
> To mitigate this latency, utilize Block Event Interrupt (BEI) mechanism.
> Enabling BEI instructs the GSI hardware to prevent interrupt generation
> and BEI is disabled when an interrupt is necessary.
> 
> Large I2C transfer can be divided into chunks of messages internally.
> Interrupts are not expected for the messages for which BEI bit set,
> only the last message triggers an interrupt, indicating the completion of
> N messages. This BEI mechanism enhances overall transfer efficiency.
> 
> Signed-off-by: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
> ---
> 
> v7 -> v8:
>    - Removed duplicate sentence in commit description
> 
> v6 -> v7:
>    - The design has been modified to configure BEI for interrupt
>      generation either:
>      After the last I2C message, if sufficient TREs are available, or
>      After a specific I2C message, when no further TREs are available.
>    - In the GPI driver, passed the flags argumnetr to the gpi_create_i2c_tre function
>      and so avoided using external variables for DMA_PREP_INTERRUPT status.
> 
> v5 ->v6:
>   - For updating the block event interrupt bit, instead of relying on
>     bei_flag, decision check is moved with DMA_PREP_INTERRUPT flag.
> 
> v4 -> v5:
>   - BEI flag naming changed from flags to bei_flag.
>   - QCOM_GPI_BLOCK_EVENT_IRQ macro is removed from qcom-gpi-dma.h
>     file, and Block event interrupt support is checked with bei_flag.
> 
> v3 -> v4:
>   - API's added for Block event interrupt with multi descriptor support for
>     I2C is moved from qcom-gpi-dma.h file to I2C geni qcom driver file.
>   - gpi_multi_xfer_timeout_handler function is moved from GPI driver to
>     I2C driver.
> 
> v2-> v3:
>    - Renamed gpi_multi_desc_process to gpi_multi_xfer_timeout_handler
>    - MIN_NUM_OF_MSGS_MULTI_DESC changed from 4 to 2
>    - Added documentation for newly added changes in "qcom-gpi-dma.h" file
>    - Updated commit description.
> 
> v1 -> v2:
>    - Changed dma_addr type from array of pointers to array.
>    - To support BEI functionality with the TRE size of 64 defined in GPI driver,
>      updated QCOM_GPI_MAX_NUM_MSGS to 16 and NUM_MSGS_PER_IRQ to 4.
> 
>  drivers/dma/qcom/gpi.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry


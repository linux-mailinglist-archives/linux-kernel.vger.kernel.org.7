Return-Path: <linux-kernel+bounces-693438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8159ADFEE5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 09:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BB12189B4F6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 07:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816F8257AD3;
	Thu, 19 Jun 2025 07:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C0tykLMp"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1B525229E
	for <linux-kernel@vger.kernel.org>; Thu, 19 Jun 2025 07:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750318961; cv=none; b=V0Q6knVATtzVSKSxhddRQoZBphvoYh+i5En3Afh86mNOBt4an6eU5QvqdlepQ17WTSEeN97qo7P6d4wNnQxVq+NML0K9foqfUfueIrMxS3xRgRQqHcwDcH6DjJXeTZLWA4AOBH/Gbwx44N+kzKyXPviJ3FucejcRDFz9nMT78VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750318961; c=relaxed/simple;
	bh=s2OolJwIz9awxR2iz/43VMdB6EucvrqWeFm1XgBiIFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZB+ki8+bOmtfYT4v359nwJA1H1OOgQHqIdGS5jAa5daiD0YVtUZUdMkKXvBV1fPvQbfN9L+txwYvF27KckD2u/Q/ifoQz7h+EZxs8j1KTqAbVisF+JHdzB/n7dTLH1tHqKJ1elZc7KkGOQbau1fiTfig697ZCh1mCCjW9G/3Ujs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C0tykLMp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55J2FUBa008353
	for <linux-kernel@vger.kernel.org>; Thu, 19 Jun 2025 07:42:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8bK9StFic/Lakke1sCoMHiU5FEA33sLFtfn5W9fGOiA=; b=C0tykLMpxgecwn3B
	rM1LOimHab64qUEI9q17fhye2dcs2/A3fRVQtcKasDTXdMtM1y4V8W5xWKvgppMx
	d5qfSHq0Iq6P7+sHTAOqbNqnXEJ3iX8GDHaEme2KYcKwj0isr1yxKmzOSyDZ/AGg
	4p9BNtD0q7o0aKauSQP+VGM1zSe1df1QWWUBo6ZCErrj8JzyCdFbnrDrxYpsHYSY
	tN2iHVIgcq1/PHdwHguErK9d7bREa/cpu2arR3fDb2Atw8nzJQLAMz7rmTOY6p7v
	ohMt8tCmYwINKZKrdOlq2N9Bm4N8dySQsJFwA/Majvhotg5MV4BBum464kkzqbN9
	pd/RWQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47c9krrv1h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 19 Jun 2025 07:42:38 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2356ce66d7cso7678605ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jun 2025 00:42:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750318957; x=1750923757;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8bK9StFic/Lakke1sCoMHiU5FEA33sLFtfn5W9fGOiA=;
        b=v94dgVp7OSzPrsGZFn0dlN7ITrm6NOQH09ESxguiGHBmlxRmxjFlSNY32o1fGaUXjo
         IdpsXgCPaJxGAfpgp8cclPV+MctZNywR14nINgKyQQ7iK2aod7hkPTbn/Yjzi/FQJHA9
         tZCj6rFPVP5op+co2TolffSnorJw3I84R6m6W2a+arEBoM9I+galRBwvzSq0V7wsXvTg
         RPRIJ1SA5TaSkZhAyLmvFQ/kXTlgv13z1fGyHQpmRVTLHVBhSwhzcV9tKsLATtW2IQEm
         QsFDq7bkb7+UbGtitGaeIEFJXqIqQu/8O9tRH1byOWi+kIvE4i+RpVYNB4Z8tmDmz4Cn
         bXjw==
X-Forwarded-Encrypted: i=1; AJvYcCUGLsLFcwWDqXrbY159sdK4sTAmiETQnVkGXo5CNpW+GplrT6Q1jK0P19G4Ka3Rly3nePIVkJpmBgx1fm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoayNqtPDO2UOgpmeWlcBdm7LmQmyG9Mc3Umi36O3wZgzfeFBB
	B1TtKRWwVYZghrR+sdmXZDIjslGIWzs1rCXRPO7eQA2POvErInIHfY4ZvRmWfpwg/fDn7umgcW0
	6jN3QUYJDvdnQfuJA9zsQ/muEuGaiI9wJ7cpAzjmVeQV4qfZ207O2sHwOhlBx9LWsecY=
X-Gm-Gg: ASbGncsKQLNpHsgomqRP1Bgn7QjecGBxghUKlGfJSetY+bNTRI6jjdajdtDeZ8r5QWu
	MMBVetxzVmwDMXQJ8LijWV9a5U6e2gMdgwI5zeR+8TI1iPrwvT67Te+y/Xz5Xuug8qM4WaZDmYC
	X4w9gGbvLYPpe1CVjkfhO8ZX43ENOHWM6UlDfUEmB6iRxY5EC1dzLkiiVXssz+TJaa/SRdK9lLD
	RhImuIsjlj0Svu7k5amYKXcFfwoE9qTSZ0+C2LC38qkd4qoH1Mr/71GNVBmp2F/Dfvnsydgx32R
	BkbZSHDeHDW8aOGPJOgX0r2hO5CTUj0p1FwqDd2dIuEINy73uKf8msqnhCY83dH1W2xGIw==
X-Received: by 2002:a17:903:124a:b0:235:f3e6:467f with SMTP id d9443c01a7336-2366b3138e6mr328987515ad.2.1750318957472;
        Thu, 19 Jun 2025 00:42:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1K+tjlLOlBKZW+h28YggU3a33tgf21Wr5iYIUaMwfntpyd+JHMLZw4bqejg0TjXcSB6QJHA==
X-Received: by 2002:a17:903:124a:b0:235:f3e6:467f with SMTP id d9443c01a7336-2366b3138e6mr328987155ad.2.1750318957019;
        Thu, 19 Jun 2025 00:42:37 -0700 (PDT)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a2f4c23sm1431417a91.29.2025.06.19.00.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 00:42:36 -0700 (PDT)
Date: Thu, 19 Jun 2025 00:42:34 -0700
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        jeff.hugo@oss.qualcomm.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        can.guo@oss.qualcomm.com, Mayank Rana <mayank.rana@oss.qualcomm.com>
Subject: Re: [PATCH v2] mhi: host: Add standard elf image download
 functionality
Message-ID: <aFO/ahs3LwUvKpAB@hu-qianyu-lv.qualcomm.com>
References: <20250603-standard_elf_image_load_support-v2-1-cce97644e99e@oss.qualcomm.com>
 <sdhop6vyvt4y63tbbtorqfd5xa4ckbiwxdad5g6zzwlljqvd6q@eoaqmairdeey>
 <9ab8e8f8-e176-44ab-b8e5-0c27e5eff30b@quicinc.com>
 <q3uxu5cki7c3nkv65kozibiz7ofjcm3clelog3oaqcya32kph4@ntvsqbshmeuw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <q3uxu5cki7c3nkv65kozibiz7ofjcm3clelog3oaqcya32kph4@ntvsqbshmeuw>
X-Proofpoint-GUID: RtBCA1otGSE8bZjkBRjzI7tds5PfeM7U
X-Authority-Analysis: v=2.4 cv=UPTdHDfy c=1 sm=1 tr=0 ts=6853bf6e cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=z0rqCJazpnJsISlW-HgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDA2NCBTYWx0ZWRfXyb7cPaGAPedm
 Wu+J9pVY+f5Blkpk3DjphcdoDFuc89VzQWThA5rBDcDfwtNA8WDREHCeLDuasZt+GB9m0pi2wtG
 NvjG9j2u0x4n9g5y8SYEJshVEDSFXAxEXp1q27gKEfYLEjfMnKshYXQH6SsR1H6CvFE5NrEfjur
 qaoyLPgmYNIj3rZTmxIrRro+kI85wXQC3tGQzdUXtmctEPfs80cyS5RNyo4ZvIFjcTNXOpU0gmN
 k+dXu6qD3RYxTsYdilbP/WTDio/ONhk97eJvCRRV0Acz0tBQ7pq/764hXZLYI4VkrW6Vmf62Hlu
 fJgMVNPUrEVDPgg4sxK2UsZJtLcSArC1PYAAaVKq+IY1T3Jt3rK3HDCpKLFRIMlbaM9W2q+COyc
 MSpNQ9DAQ+tLuZnD4UwZvK/MObgiJkDn+inW65I3ZYXcy8OtzRKNdzukWhrsS3IDyPxsbpU2
X-Proofpoint-ORIG-GUID: RtBCA1otGSE8bZjkBRjzI7tds5PfeM7U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_03,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501 suspectscore=0
 adultscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506190064

On Tue, Jun 17, 2025 at 02:53:02PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Jun 06, 2025 at 09:58:06AM +0800, Baochen Qiang wrote:
> > 
> > 
> > On 6/6/2025 1:04 AM, Manivannan Sadhasivam wrote:
> > > On Tue, Jun 03, 2025 at 02:05:44AM -0700, Qiang Yu wrote:
> > >> From: Mayank Rana <mayank.rana@oss.qualcomm.com>
> > >>
> > >> Currently, the FBC image is a non-standard ELF file that contains a single
> > >> ELF header, followed by segments for SBL, RDDM, and AMSS. Some devices are
> > >> unable to process this non-standard ELF format and therefore require
> > >> special handling during image loading.
> > >>
> > > 
> > > What are those "some devices"? Why are they not able to process this format
> > > which is used across the rest of the Qcom devices?
> > > 
> > >> Add standard_elf_image flag to determine whether the device can process
> > >> the non-standard ELF format. If this flag is set, a standard ELF image
> > >> must be loaded, meaning the first 512 KB of the FBC image should be
> > >> skipped when loading the AMSS image over the BHIe interface.
> > > 
> > > Please explain what is present in the first 512KiB and why skipping that is
> > > required.
> > > 
> > >> Note that
> > >> this flag does not affect the SBL image download process.
> > >>
> > >> Signed-off-by: Mayank Rana <mayank.rana@oss.qualcomm.com>
> > >> Co-developed-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> > >> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> > >> ---
> > >> Changes in v2:
> > >> - V1 patch is paused because of no user. WLAN team plan to add support for
> > >>   new WLAN chip that requires this patch, so send v2.
> > >> - Change author and SOB with new mail address.
> > >> - Reword commit message.
> > >> - Place standard_elf_image flag after wake_set in struct mhi_controller
> > >> - Link to v1: https://lore.kernel.org/mhi/1689907189-21844-1-git-send-email-quic_qianyu@quicinc.com/
> > >> ---
> > >>  drivers/bus/mhi/host/boot.c | 7 +++++++
> > >>  include/linux/mhi.h         | 4 ++++
> > >>  2 files changed, 11 insertions(+)
> > >>
> > >> diff --git a/drivers/bus/mhi/host/boot.c b/drivers/bus/mhi/host/boot.c
> > >> index efa3b6dddf4d2f937535243bd8e8ed32109150a4..f1686a8e0681d49f778838820b44f4c845ddbd1f 100644
> > >> --- a/drivers/bus/mhi/host/boot.c
> > >> +++ b/drivers/bus/mhi/host/boot.c
> > >> @@ -584,6 +584,13 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
> > >>  	 * device transitioning into MHI READY state
> > >>  	 */
> > >>  	if (fw_load_type == MHI_FW_LOAD_FBC) {
> > >> +		dev_dbg(dev, "standard_elf_image:%s\n",
> > >> +			(mhi_cntrl->standard_elf_image ? "True" : "False"));
> > > 
> > > This print is just a noise even for debug.
> > > 
> > >> +		if (mhi_cntrl->standard_elf_image) {
> > >> +			fw_data += mhi_cntrl->sbl_size;
> > >> +			fw_sz -= mhi_cntrl->sbl_size;
> > > 
> > > Is it possible to detect the image type during runtime instead of using a flag?
> > > Also, the flag is currently unused. So it should come along an user.
> > 
> > The flag would be used when a new WLAN device getting upstream. So either we merge this
> > patch alone, or we get it grouped within the WLAN patches. Kindly share your thoughts?
> > 
> 
> For the reason I mentioned in my previous reply, I don't think we should rely on
> the flag unless the WLAN device is shipped with *only* the new FW. If that is
> the case, then please send this patch when the ath driver support shows up. I
> do not want to merge a patch with an unused interface.
>

I discussed with Wlan FW team. For a specific model of wlan chip, only one
format image will be released.

- Qiang Yu

> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்


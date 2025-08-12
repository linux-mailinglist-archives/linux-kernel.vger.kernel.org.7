Return-Path: <linux-kernel+bounces-764650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C76CAB22591
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBBC45007C4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20F02ECE8D;
	Tue, 12 Aug 2025 11:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n5pxNwKp"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70642E7BDB
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 11:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754997029; cv=none; b=amlvhf9MmcU74yqwuA8yfy+i4fFTzb3wFmBW0N2NwKrwhhTjSHFpm/IE3TTeiD1QlH3FghYsecCxnA5xZFm344lU0EckF5LYJZyYU6qgFtlVO7F79FbcpAuv31fQFfduTOAvHgoQyTZ/v4gu3pwpgRgNIj1sCxISC/HQGYl8RcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754997029; c=relaxed/simple;
	bh=b2TMQWBh7y1oBAOxogCINQJzZqxbSCtudjrCa8/Oa/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQb731FplXfqFJbprX+dUuVgQ9aJhUx0w6d0cG/+gKeb+ftWcuzVi8CC12Y7DvP1U/49gUz1CVPB/VtTB14wEeDkzfef1mxcOXCv+bnrTOolg4L6KoTI6Mn1dSOgstscZPn03zlmQ4W8y9Wi1vzmC0cIfD+U8jkCaVG0LqCHcH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n5pxNwKp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CAwAQJ000973
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 11:10:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=fg2cXq0+LHp1tS75Bds4h5YT
	/Nl2i4rXnv8H99ZQYDg=; b=n5pxNwKp733bh0oXx0cvqagqOBXtH4MKlkMAvDWi
	N/HIS+wplZEmMmsB22L53bu6+TX8Zqo/K5/yEGiLSRirIQU7Xc44p0oC86upiVCv
	MfAzhwCjHJN+OEH5yTdDe3h3IPquVrRfzXpnnVjyFxlBl1+DaUTOg0DcSZFi4oZc
	Xw5wqLIR75fbRwSu/KEe7bEegetgmlZDc6GX8CSGRWn0ybv/5dqP3ooQvZ2u7pNJ
	vCnZ8NAqV+aUldTucl9nUjT53BzGZmfLH2r9kFIQSbJk0T0xNcWLA6TAI8gKparL
	NOHqaDcuv5nG+9Z0XiI6dUaJjw36/4FTUC2UL4Ax+lpGwA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fm3vjrm2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 11:10:26 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-7073b4fb53eso109594946d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 04:10:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754997026; x=1755601826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fg2cXq0+LHp1tS75Bds4h5YT/Nl2i4rXnv8H99ZQYDg=;
        b=qnQcOngH/EtQWRpNO5XlGye1vzDhQO3o3EEGSuaStRkLxvmlve+dwpqtBL0MOSUEZc
         Lf1aayZhyY9WUmo11vF1cu/M5g7DgemeKTLv5oPYgFgpkSOzSZONblt1nWiLxkX33y9A
         2EyS4/fb9EJs59gX8QMd9vBi70v/9SbwPYoCkBR/lq0EsC2zErFsVEIeBFQrujYdFnuO
         cJor1dCRaBNbza0Fu43ON3m2F9mUASCs/lHzEeogvBzMLobhvuLl7xr+8d9fSjVa4LMM
         1UEFr4nRySA+3IAymlwkABBVigFvt40bDlO/MpTTLdFeZgsuKSnQUPOZbi21jRCpnMA9
         wqfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsKvW2fkGfC7Qo5qT1eWUEU34QGtoc00v76QsatnJpqc+7Jyv5x0IFeXDHE3IQ0lO33E27ug4B85HzFpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrUxWnyTvYRZHsu0mBI7XUCaFWFOXFyUquQMfwxRZkeLP8hZD9
	PjhZMV05BPjnYPs5LyLTUomLnqcU6Nb17uN6lzFR74GQQ1sgesamZfvxZEUWaioIWQc84Do2KOm
	TAZEwAQzrNW/9fXXAWkZ54CFJcxPGA0JPjVGSpATRVnGURSUXTILw98Vt78UARfXmCsg=
X-Gm-Gg: ASbGncuBr8sSHs7JDlZ3r5KUZjMltRmiwFod3i4kFJQTBbvChNmaPW5afdVGw9z4rhy
	HpNi9s8eBeav/t8Qv6kDNXp49SAbZiN5nmX7ZlW6oWNfO3XIPSJjJOSMRQyjIdNSsclF/MUxqwh
	lV5xC2EjHtYfrHes94XsXAzHhzDVeVXARriYv9TaPDzlwFiGurHgs3PZeKb1w8yOGv/fL5DzdU/
	oZcfIiD7EzW0uskRolkZjDAdiE6GN8NFqdbl9cg6htboUmrSo/jIGGO031xQbhVpZVtG0sdoCCq
	mwho8dLndeLRBpvU0fnJJcPIBzilL6qwX3awHlomwJudWorTzTiem78RfQaKQfBBXUZ/ZkzbDyE
	zARGk5BXPMVcI01YJymt+m2VdkXwuJKsgxpieg+1yoTQa9WhDbIan
X-Received: by 2002:a05:6214:598f:b0:709:dc78:2a21 with SMTP id 6a1803df08f44-709dc78373amr22684796d6.22.1754997025743;
        Tue, 12 Aug 2025 04:10:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSeRppSxdlv09HnC97Ds7Vzo7OqvtpXu/hio/m1YMZFz6eg3vDZhl/DWjzwvDFOMKea1RAqA==
X-Received: by 2002:a05:6214:598f:b0:709:dc78:2a21 with SMTP id 6a1803df08f44-709dc78373amr22684336d6.22.1754997025282;
        Tue, 12 Aug 2025 04:10:25 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88c99057sm4740938e87.91.2025.08.12.04.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 04:10:24 -0700 (PDT)
Date: Tue, 12 Aug 2025 14:10:22 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Luca Weiss <luca.weiss@fairphone.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: ubwc: Add missing UBWC config for SM7225
Message-ID: <55xazajnwigd744shnkk3acba7fozsaciybjexvrp2rdvs2bhm@35lglwjsazdf>
References: <20250723-ubwc-sm7225-v1-1-d688caff70f1@fairphone.com>
 <blibzpqgbjbbwvnsx3cu3fzjxk776lamnmd4erokc5jx7qkubh@7da6ihmb6xxj>
 <xsrkh75xb6klntc4mc564iq4wipe6iaqjiugk2r743n2y2h5dt@s33t7fckn5gq>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xsrkh75xb6klntc4mc564iq4wipe6iaqjiugk2r743n2y2h5dt@s33t7fckn5gq>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDEwNyBTYWx0ZWRfX5HnVAwVYYbot
 XIVdMIhe2VpiC8uQzPJ2boJJpb9lsShRiYlaBTgraio1CmpOYnPFTqP4CrJlBgENeMLFtw8lwc6
 NTK8I/LVBkBtHYEEnNF3HGnz9b4+IaCM24GbNXvCiSd7uk0eNEc4jNs1D/5nlDEitwqa56FZiAG
 0wyFN1ZITw3EX3llnXPGU9lSaUEs+DtBuBZIBNy9XpdR/PjfaxDESEcbNFNsFrZ+CGIaRFsinLR
 IvmFSC71ASvZHeWPd5FDrZSi3Qdx/UX6+nnNVaQ3Rdp1+RwNDzq4tiWQgZFnTCVbu5zXDyaqgmH
 CFxIqDAvEH8IWQ9lEKr7A+wOOY96QeZyMWG5vP8GHgLDWrU91PKBpG7q+HXSnBIAIAhNJEUqKdE
 DPA31+dh
X-Proofpoint-GUID: BtNvioWHA9U4EFsEVR4rotzuhMz9bxRG
X-Authority-Analysis: v=2.4 cv=A+1sP7WG c=1 sm=1 tr=0 ts=689b2122 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=zlSGU54Dfj_POJwjaQMA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-ORIG-GUID: BtNvioWHA9U4EFsEVR4rotzuhMz9bxRG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_06,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110107

On Mon, Aug 11, 2025 at 01:32:00PM -0500, Bjorn Andersson wrote:
> On Wed, Jul 23, 2025 at 10:03:15PM +0300, Dmitry Baryshkov wrote:
> > On Wed, Jul 23, 2025 at 04:19:22PM +0200, Luca Weiss wrote:
> > > SM7225 is a variation of SM6350, and also needs an entry in the table.
> > > 
> > > Fixes: 1924272b9ce1 ("soc: qcom: Add UBWC config provider")
> > > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > > ---
> > > Note, due to other bugs on next-20250723 I couldn't fully test that
> > > DPU/GPU are working, but this seems to be required in any case...
> > > ---
> > >  drivers/soc/qcom/ubwc_config.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > 
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > 
> 
> @Dmitry will you pick this as well through your tree, so we avoid (the
> trivial) conflict.

Yes

> 
> Acked-by: Bjorn Andersson <andersson@kernel.org>
> 
> Regards,
> Bjorn
> 
> > 
> > -- 
> > With best wishes
> > Dmitry

-- 
With best wishes
Dmitry


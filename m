Return-Path: <linux-kernel+bounces-815936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBF9B56D30
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 02:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2808E16E1EE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 00:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5ED822F01;
	Mon, 15 Sep 2025 00:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K3LJOp5j"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683AB18E3F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757895113; cv=none; b=KfREnTk1dXgJHOSlvGkNvF/VqPtYJKV2VSM7rkqn9ftTfvNYSLXPjGi0WCFhED0KtaAchX04sOwhXJ4eAXEcQDoa8K//ydpWJB5hNnBIdttV2fkFgWF56GHk8ej2Tj6OJYLgYE0eCiXMt3y/fqFk9mCNpd86rn/z1yNdg9+j7j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757895113; c=relaxed/simple;
	bh=iSoyahLZuzvJW/LLpw2WRZ8dNqvwIYHpD2wjF+DRt5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fFJ3tb9Vh7WCff2vFCsy8dCMkbjvhvNE3tSlleANxevmbGUFsS5b7vK98EFEzw960Ha08MZ5IfXzRUAubQZQ1WvnDYNZgjH7/eYkTUUgrl+Ngfy9L/g6zRAB40WWpIBEJ5NpB8+xSBmGuiqxrojqQbdZAOVgW/P5HUuk1WMwErM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K3LJOp5j; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58EITRWN021292
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:11:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=jgubuXIBHxl1EspmzGxmpMOu
	9GhsFOhOkdvbf4oIGsk=; b=K3LJOp5jN8EpntH0qMi19Cg/3wIT314oQaaADRAy
	rABW2HFKk9jWNvs6cuIoPd1HXB70rcUC2QIZrD/csiva7OdE14at9QD4/EoV8i3O
	K9x4thQTv4L+8L6RY8Y2wdrSDl2VCOIz9N8zVttL+Uw49aedXmhAjS921FBTK/3J
	zy+pqE4koEApxj71kUnSOw4dbq4xz+kBKbcr+AAjbtt2lkYAqI6/oaK9aNh1h4cx
	eJJTyF/Dnqn48hipTflX8HfAdbklVoNlTLFwzI+hLoZl4/ZQI0X81qNohoEPyuKl
	BdSSi0JKEibRuzhtBjiQvl/idmFg21vUP1XQXiThFrvBbg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4950u52wqx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:11:51 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b5fb61d80dso105750871cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 17:11:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757895110; x=1758499910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jgubuXIBHxl1EspmzGxmpMOu9GhsFOhOkdvbf4oIGsk=;
        b=GN3ctbrff63YPM/NAtW998iBZXg9t78idG3tSnl/n3YNXEo4n/nqe2/tk1mKwjHeLH
         wh2IlBQO+xW8btgB1nZyVtMKOQM72OOfui682gGHM7o9ELYu0oPNylJ8fSHbEOO5ngqs
         s8T5ghqeu56riQA+CxnUSbiVaPyaoCWXsXiWZuGjmMgKOA5O5s3IWej8PWvwZJB41Ezh
         3Q/AQ/LYjjQs7Rm73UevWkWKCUm4jF7o7b6o8Ve/lfKrGFKAXPDmM2evQEC+PMauNOWd
         Qtv7w8HuWDm2d2kod0EA8moyLLsIXmHYk21yXEhQp5zZPt4Zx5S9G5X2ql3cEksSyw9F
         5TKA==
X-Forwarded-Encrypted: i=1; AJvYcCUrc643EYMYgDzTcnqrPasgbdS8v5CsjQj/55dfKdUcNlmnugRVWcrkATaM9Ra3SDX+PtTdNCYCMr8Q/rg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+C3ygSLLveFJi9un0UFO7EBHI145d3CWelikihloo9sFbalo0
	/jOGetwXAfsZEBVgCu1k6lczBxKUTJyL+PjeHgLVzkAj8wAshrNmum9WzbKst0N6kTcF/O+Cq1O
	e1EFOEe/JNhr2yIIiNuO+gNWh0mf2cvaIs/cbxIZ5W4lutqdrtaOaHa9sJgAuqvRaMg0=
X-Gm-Gg: ASbGncsxe1fHh16WHXuppLApb/gdMSHZTr26iXfOifBR31v7q8Yev7lot0gswriHGw4
	LrfF7l79bIl5B6vGSU1MnqDsvSfBI0/41oF45AmovEya+dx7epTQKusKZ9MrFMl8K4tUfCEoww8
	QWUeCQ7grp+WrMouEPEqkW/4dNk4S93y0Zw6Lvnv94tK9vZYM4U/zkNaGCuDoQHWVIvhrmJ6z3a
	mXZ95JAT3sLYrbvdYqbAvP+syvk4ORamf/Hxy9MCwj6YS0Kzx2dBvHxGFkPDyQ2xLqQEABIQ4Jw
	WILsL6e60DymPjzK2xEl98YFd0oBCMN6FJ9QchTJihNPcnu6IxMPZltCiL/C0tYRJxsongSekr2
	1euJNlwM3DUHp6MRLW1wdho5TFkTx54BdjoMpVIwPgmZBWJde8MBK
X-Received: by 2002:a05:622a:1dc5:b0:4b3:ce3:9615 with SMTP id d75a77b69052e-4b77d0e734emr103191751cf.80.1757895110177;
        Sun, 14 Sep 2025 17:11:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEr8fMcGTWpoT3vdfr5rMRLD+sgOyLchYdmKd5WBs6kKIgs17duY0sHaa7iwCY30pATrgGWFg==
X-Received: by 2002:a05:622a:1dc5:b0:4b3:ce3:9615 with SMTP id d75a77b69052e-4b77d0e734emr103191611cf.80.1757895109746;
        Sun, 14 Sep 2025 17:11:49 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e5c3b622fsm3227252e87.2.2025.09.14.17.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 17:11:48 -0700 (PDT)
Date: Mon, 15 Sep 2025 03:11:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Prasad Kumpatla <quic_pkumpatl@quicinc.com>,
        linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com,
        prasad.kumpatla@oss.qualcomm.com, ajay.nandam@oss.qualcomm.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v1] ASoC: qcom: sc8280xp: Fix sound card driver name
 match data for QCS8275
Message-ID: <ocevx3x6rniczf2sjhd2yie5i7obhwrohim44sqiev2cdngivc@lapwpkqbq6o2>
References: <20250914131549.1198740-1-mohammad.rafi.shaik@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250914131549.1198740-1-mohammad.rafi.shaik@oss.qualcomm.com>
X-Proofpoint-GUID: 0QdajBGJay9Hq661KZWa1AblV0kDWnl3
X-Proofpoint-ORIG-GUID: 0QdajBGJay9Hq661KZWa1AblV0kDWnl3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAzMSBTYWx0ZWRfX5gxMhxSBOaxk
 7s2EyetoMMEAVS/7U2BXE0UOI04vxLyDVn6UhRjc6IZIzKZdmRz7ONR1J0jXirLruTAzd+MdkSU
 uJlJ7++s2o/BYHAMbmDetC3dgO89OgugYQ9K9MVf9Cy3ovIqCOyq6konJVXPPSoWgZui0jdgrHn
 vIMfEpMPS/5yBrlHEQhkkhRH0ol+V+dde/o3/pgjYcZLEMYqNmNuGN3d+W4Tw6EtxSRc2fNjrJb
 dL3phkQVgzbl0fJrH1VuJgryUTDggWd9UGarLHHeJ2HZ8zJ3NN49JNDr88GfMeswSHCxCDFkdtj
 +ksP8Q1tHdn7a3IoK6JXW1lr7NOkmF5WSSvwqfLyFT7iyGXvuroZV8zTFg6qzJXn1VgITPSPVgF
 wMTVUjSU
X-Authority-Analysis: v=2.4 cv=JvzxrN4C c=1 sm=1 tr=0 ts=68c759c7 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=b8Ncz4iFJ-U_pff5yioA:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-14_08,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130031

On Sun, Sep 14, 2025 at 06:45:49PM +0530, Mohammad Rafi Shaik wrote:
> The QCS8275 board is based on Qualcomm's QCS8300 SoC family, and all
> supported firmware files are located in the qcs8300 directory. The
> sound topology and ALSA UCM configuration files have also been migrated
> from the qcs8275 directory to the actual SoC qcs8300 directory in
> linux-firmware. With the current setup, the sound topology fails
> to load, resulting in sound card registration failure.
> 
> This patch updates the driver match data to use the correct driver name
> qcs8300 for the qcs8275-sndcard, ensuring that the sound card driver
> correctly loads the sound topology and ALSA UCM configuration files
> from the qcs8300 directory.
> 
> Fixes: 34d340d48e595 ("ASoC: qcom: sc8280xp: Add support for QCS8275")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
> ---
>  sound/soc/qcom/sc8280xp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Thanks!

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry


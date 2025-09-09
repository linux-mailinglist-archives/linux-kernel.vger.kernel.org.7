Return-Path: <linux-kernel+bounces-808492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7804AB5007D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2376F17828E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86838302759;
	Tue,  9 Sep 2025 15:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ujc/zzZD"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450D819047A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 15:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757430059; cv=none; b=SGQpcrzvFJryE8hk/Df81XwRx5EGdTQefkCRtWuc3o5g8ZWns3/p2J9PEYm/IekkH7f7HZCq94ATF/4txZFe4qa9mzfp7TitBDCXrURFR6yRihqN4QDRS8OqTzZeufErO4ImUIozQEtakB96EK98Jn3gYUGgq24DBuRsVuTDxHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757430059; c=relaxed/simple;
	bh=R96/ZgIb8udYyannyAPIOIbTWhbXdhgJI0PZcq7B6IQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGbYSWz7pUVu8MCPJG0NLjXIgfPmhNIkZxaYh9yISgV+RWKfHp/SL7uQynHjeukzH07XECvnn8X9GdzNa8hRTlY47pVO/t0nJ0k+pWrE9HcTiHLwYrEN5LxyBUbwRkTpatMFBlbnZS6bgd27m36Yu3FVpMAtG40GdkwA3cMowKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ujc/zzZD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5899LSAj003613
	for <linux-kernel@vger.kernel.org>; Tue, 9 Sep 2025 15:00:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=XqTohBj1qLgWoq9uplvti4/t
	OBT3VUOGqeH3HMHa23Q=; b=Ujc/zzZDfrz66ycCfRDwoKgyozPtCQtDLcQUJy7h
	GpeY6fTqjvPJo3xF2Q1/l9j88dxXLHsirSC1imZ1REETNpdB3FRYkgtckOPoJn6N
	edK04EejMtI64A+tZE5+DHp6PmcgXP7Xeo4/tRtX6dpVuSQx8Tzn1qdBOxO+a1F0
	h3VyMlyqnBljcgisvUlEmP+d90KXSex9RkxWaEsrhNyPBtXhTQwrHFpdiTmyRAhY
	4cTYJIqnsh1P0ZxJwsxztPm10FE4eEPaBdMoYyeXy0n3xoMF1mTQpGdWDZwuBiB2
	08ah60erE2GtkElTqkt2dQ9nAzLNEgBdp3V4b3SrIOGQaA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490aapgw74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 15:00:56 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70d7c7e972eso124013106d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 08:00:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757430055; x=1758034855;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqTohBj1qLgWoq9uplvti4/tOBT3VUOGqeH3HMHa23Q=;
        b=pzffZVicUSNDe3D6QnBxBLWkPre0JWsIWfJ1GScfSUC8hkSZiJZ0ER/WVqNCvdEPo3
         cWw2D1LirSkRnugf5X5qIki9tj9xwShRL137b4bvxgeDoNwc97vCd7DM4xsNSVFfhtLi
         UBw8sp4+SnbL9HdYG+rjFbnl6ePZU7tdw+75D+JIILtMzPguvoMa+jL8LRfKBhwvqSvZ
         yLcqQTxI92a7ERjrubgMuA/GlgKXS0IpFqz+m64OQtO1DdAd0kr55lziQRRYNtvl/7Wo
         Hkh5mDzQI1Iq0Fbe7DQeZZDd45HKz//CxVUdKRFv6qPpDo2XnmngDnvzHfWTFtkBiANF
         jYJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXThCnwCeoKvzaDamPbh7P0mThCL9YnALoEkFXQUVpeRLAev4QhOQqz6MqryuTaqf4aQoJkQjICqMsuopY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUPLaiYDcH6qB2n1IAI3GQdq7oW/LFNgiEVaKm9BZJ8CQ6piP+
	CnFt43k9OtHTMmiBrQeyfXAJ5Zg3tdfPazayULQjRLofGdeaPNsTHjT+9e+/defbfNhm4qCirZ/
	XIGT2eZlAVCR+vj8VXD02Z31L7fhLBargZFb1AxaEyHq2XLVNt3XTtv8rvLSxHRxVjIarpYSc9N
	Q=
X-Gm-Gg: ASbGncuPNITU0AkKI/Bp1iGbYBNmE5x4IYokt8VDsSqan7YUB7IgHFYvBLpfBeNbfJY
	LXTWEAOJQnRjQdY3LweJaZTAMD/p4LCFLwXyq4rLcCcj1XzSwZbanjdFbQHhZpAAGigIejDlNkL
	lmKNjeUacgN6oKkk9yciLj2VTWQ+oFAW5kLe6B7LmeI6yAtjU0MgLmROb6d+99E+Zdj2bYSEFgj
	lvmOOJo1kK99MqDefI7VmFNw1AIv+jheGxM58PkqZowC6kEZxBYb+cButAxleb2NiWgAYedeR4c
	c8S1Tfqm4jeQmLdHDo880sObdzffjAe7EeNyFan/FvO4TcpACdJg1eJlVUuSCk5/lS47NaAYhq1
	uSjctU+IHcPZDL/QZO2cqHwBls/RLxMVPg5o/1peUJFIDDfxGjc26
X-Received: by 2002:a05:6214:528f:b0:70e:86:af36 with SMTP id 6a1803df08f44-73924e25c29mr143249246d6.19.1757430048881;
        Tue, 09 Sep 2025 08:00:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFtK5sa4xm8mOsPdJfOo7fiBsFLFw85/oBAA2VqPWFp39gtDPu1XOXGBLAKw5O4Aqb0iu2zQ==
X-Received: by 2002:a05:6214:528f:b0:70e:86:af36 with SMTP id 6a1803df08f44-73924e25c29mr143238896d6.19.1757430041379;
        Tue, 09 Sep 2025 08:00:41 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f50d3662sm39087341fa.69.2025.09.09.08.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 08:00:40 -0700 (PDT)
Date: Tue, 9 Sep 2025 18:00:38 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] drm/msm/registers: Remove license/etc from generated
 headers
Message-ID: <o25axq4soxjluqnxjad2f3blhezuglsvex6k3aav5v65ynn7qd@5i3wm2lryr7q>
References: <20250908193021.605012-1-robin.clark@oss.qualcomm.com>
 <20250908193021.605012-2-robin.clark@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908193021.605012-2-robin.clark@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=eMETjGp1 c=1 sm=1 tr=0 ts=68c04128 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=e5mUnYsNAAAA:8 a=EUspDBNiAAAA:8 a=q_i8wjiaOVoz8fm2smAA:9
 a=CjuIK1q_8ugA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: J7pV0jqEYCoE-tmvc4Olm_r7X7z-hDFC
X-Proofpoint-ORIG-GUID: J7pV0jqEYCoE-tmvc4Olm_r7X7z-hDFC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAwMCBTYWx0ZWRfX9XGLaqCdFyKD
 ytA4QnhpJIj1/t7sXgd5BXkCsn1u5gfhCRWl9f1N65VjJ/P7dLf243sBbkgwfEG6dHggEVHHL9x
 VAw1FnVmOeYgXLPUPq9ked/Dut5ZHegxzeKzEy4/6jQJoL1yldDzqDpgJ9i7UAeBk7Bt6gswF2E
 GLEsBBeX6eRbA7d0ZUiYAKYE1pDOvBPjpYzsk4zl8dQssS86Ccq3r5HeVFSC7bOA/ozoPar08cV
 8I0J9ZfDTJt+gHC9aBvwA8iFILtSFpGMkClVVW3eLvQhG5BAfM1QXLZE/3UrIe7H79NRSitlFjY
 SpOGzpxAvDXJAS5QToUO4uoVIch/gEk4MhKzL+N2t8dCIRBYJdagnsIwKi3EKFjgWs3t7ZFwTo/
 ocI/lX57
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_02,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060000

On Mon, Sep 08, 2025 at 12:30:04PM -0700, Rob Clark wrote:
> Since these generated files are no longer checked in, either in mesa or
> in the linux kernel, simplify things by dropping the verbose generated
> comment.
> 
> These were semi-nerf'd on the kernel side, in the name of build
> reproducibility, by commit ba64c6737f86 ("drivers: gpu: drm: msm:
> registers: improve reproducibility"), but in a way that was semi-
> kernel specific.  We can just reduce the divergence between kernel
> and mesa by just dropping all of this.
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/registers/gen_header.py | 37 +--------------------
>  1 file changed, 1 insertion(+), 36 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/registers/gen_header.py b/drivers/gpu/drm/msm/registers/gen_header.py
> index a409404627c7..56273a810c1d 100644
> --- a/drivers/gpu/drm/msm/registers/gen_header.py
> +++ b/drivers/gpu/drm/msm/registers/gen_header.py
> @@ -444,9 +444,6 @@ class Parser(object):
>  		self.variants = set()
>  		self.file = []
>  		self.xml_files = []
> -		self.copyright_year = None
> -		self.authors = []
> -		self.license = None
>  
>  	def error(self, message):
>  		parser, filename = self.stack[-1]
> @@ -686,10 +683,6 @@ class Parser(object):
>  			self.parse_field(attrs["name"], attrs)
>  		elif name == "database":
>  			self.do_validate(attrs["xsi:schemaLocation"])
> -		elif name == "copyright":
> -			self.copyright_year = attrs["year"]
> -		elif name == "author":
> -			self.authors.append(attrs["name"] + " <" + attrs["email"] + "> " + attrs["name"])
>  
>  	def end_element(self, name):
>  		if name == "domain":
> @@ -706,8 +699,6 @@ class Parser(object):
>  			self.current_array = self.current_array.parent
>  		elif name == "enum":
>  			self.current_enum = None
> -		elif name == "license":
> -			self.license = self.cdata
>  
>  	def character_data(self, data):
>  		self.cdata += data
> @@ -868,33 +859,7 @@ def dump_c(args, guard, func):
>  
>  	print("#ifndef %s\n#define %s\n" % (guard, guard))
>  
> -	print("""/* Autogenerated file, DO NOT EDIT manually!
> -
> -This file was generated by the rules-ng-ng gen_header.py tool in this git repository:
> -http://gitlab.freedesktop.org/mesa/mesa/
> -git clone https://gitlab.freedesktop.org/mesa/mesa.git
> -
> -The rules-ng-ng source files this header was generated from are:
> -""")
> -	maxlen = 0
> -	for filepath in p.xml_files:
> -		new_filepath = re.sub("^.+drivers","drivers",filepath)
> -		maxlen = max(maxlen, len(new_filepath))
> -	for filepath in p.xml_files:
> -		pad = " " * (maxlen - len(new_filepath))
> -		filesize = str(os.path.getsize(filepath))
> -		filesize = " " * (7 - len(filesize)) + filesize
> -		filetime = time.ctime(os.path.getmtime(filepath))
> -		print("- " + new_filepath + pad + " (" + filesize + " bytes, from <stripped>)")
> -	if p.copyright_year:
> -		current_year = str(datetime.date.today().year)
> -		print()
> -		print("Copyright (C) %s-%s by the following authors:" % (p.copyright_year, current_year))
> -		for author in p.authors:
> -			print("- " + author)
> -	if p.license:
> -		print(p.license)

IANAL, but I as the generated files contain C/C++ functions, I think we
need to have a corresponding licence in the file.

> -	print("*/")
> +	print("/* Autogenerated file, DO NOT EDIT manually! */")
>  
>  	print()
>  	print("#ifdef __KERNEL__")
> -- 
> 2.51.0
> 

-- 
With best wishes
Dmitry


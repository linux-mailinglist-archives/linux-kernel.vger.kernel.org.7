Return-Path: <linux-kernel+bounces-856883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFF5BE5536
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 22:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 05801357998
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15F72DE1E0;
	Thu, 16 Oct 2025 20:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DWVAUeTX"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8496C2DA779
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 20:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760645373; cv=none; b=mIlBrrHWy7p/JSkMC0rEcnKyCAfAJz0sD2aiqng0EE0vOiBbPyFrlIXEnHuwnrZkMSkcq7iFBlBY9uI1iT8fm9ICuHQdUsH4W1eV+M14IZsB1hnAiJ9WoIeyFebuLaMsatc+KGaNChHLj2RtZsVlA33dfyNYlwwttaDly4IorZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760645373; c=relaxed/simple;
	bh=yUXxrGfZgFXeOKbwMfDAKVw4I5W2VcFWZQ3AiBq7Fio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bv7Hzn8cyMY6o1ARp9RQ0l2Y4tPxxF3ILAENMzRmMHV0IqDXdnV0CVCnxxOUBa+SFTO/kEYUWXtILo6n2Nd6KhrKtkqkzbykyuwxr/wQY4FuTi/IcBBiIlp+6yBaSoCPXTuO9hGdGdBbZeLq32R9eDSW0JT2NTpUK2AzUb/wN84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DWVAUeTX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GEsOPx002591
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 20:09:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=2NnAT7GWs/EBXvb1WM+DOP4O
	7PmA83tdp8NxNf9Dzlo=; b=DWVAUeTXtA6xisChkPA3hZBUqlRaW8phfwhLioCS
	YEGTPw8kUQU+rCrlHir5p4lbIMl3W6xXKhp1QfSMSrHDhfBJ60YB52yM38UDnHGW
	tpsWChlYBouu+qlLWdP/w2t1QG3zZqohh7pnyHX10AxJrTZiWJEjFCnc1vGbVy9h
	7T3DC39FbkHnGO55QUMDG0SaEwM0NUMAL0kJO04Zc0y1Pyi9B2s54Cenn+KMgsIz
	8bfMgy5DzX32wpX+HedENZqKhXEOqyoAlRdcIZP2v33L/XdexOGa5zFwrsOpg6sC
	Ai2OfS8i5HPyogmuc6JgG/zKrWpZF/ePLLeEcFWSEnf64A==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfa8hntx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 20:09:31 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-87c08308d26so40644146d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 13:09:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760645370; x=1761250170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NnAT7GWs/EBXvb1WM+DOP4O7PmA83tdp8NxNf9Dzlo=;
        b=YSD0BrfiRNOEKyzzgdcI55E+DUxY+QIYzd9prRu894GN+fOaCGsNahSTPxIry1CO68
         InqTBO/7a4XGP338QcuPc+zj9NPLCtSCKeG1PxS6kqskTCCHKx49gFMjQp0A1YDToGWo
         X5oCG2jdm6uToq82L26H8xx6F1LDjO4jREXIDPm5kiCLU8YhC3xQ0QhrmVqEj2D0p101
         BcbdiI5owk1r1ueMBGC1sG9KyAOkeGdWUS9lhWS7W7yBDDDIakZnAT8VgkrS/3XuBnZo
         ptb3qjIg2UwOM9qHciRsp7RVjSV5T0K63FisLiTEZ+OMdfuxmqCWeJbXv+2aIE3CZgl/
         z9uQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdbOxhoqyZWaRBUYQzumP11658JVvMWKHnTnZnwxqh64eipc10Lw0Q0g+jfYwdbDIlF1EdCCVK81n5FJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFkoHVLDiUWMcB8tK+2UK7z/sznWYYrUpU80dKGeNWz6V171Lh
	jhh0YYOC5gdlOGNn7jqdUO68fZZbyG6Vv1QevrhnnQ9mrm2/dfoXjv2maWJFjfOjUJPUKW7FK2J
	+79thzolVe5for8vRKqtR7HurH1nfD495j1kdoT5fKmaD7UVIdf9YCqjpWmp0s9Iz10A=
X-Gm-Gg: ASbGnct1ZVpLMRivCsfEgHqQRCeBYTyyahoIklfumVjnxd80FNk9vpwDZ7+ZnxfklOd
	fc/RUmxp80R1SiY9GQf9Uarhcl//zmdd6oL8aiGFSZd1k51gpP9Esu2XMAAPpoGWT+/8Z15gw2Y
	evY3B9Mam1usyZWVaB7JT0UbiX2ZnvPellv8w1o4rm5bNNvSIB1Azvfl8466gIFQIEEX42sRacT
	lgdUx3e1mh6VM4QijHMb46FLE0NyYczv2P7QIwcRSd4ZCvVgHvQshPQpOA3+xSCxaNRS7orbDIU
	7kRcMTrG9nJfhbka856Xh1eyU76Bom4pAInVGl86IIjrRfbj5gnBl7h9S3i5CoQt6bQZc9laHH6
	aSYaMQECrp9OCk0tXWiUzTMVaITtUA1V2m6l9X06UzQ4IL+PV/AO7SxPCvUlP807fA4TfaCKj81
	6lQow6/HWnxtE=
X-Received: by 2002:a05:622a:1a0b:b0:4b9:6bbf:7073 with SMTP id d75a77b69052e-4e89d35ad07mr19782561cf.53.1760645369992;
        Thu, 16 Oct 2025 13:09:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2Mk36Krk90BdLrHtrtotYSVU1GazaMBECY7mZhgRjNDVhbGp7eXIDACXM51k42VjlHR9fwQ==
X-Received: by 2002:a05:622a:1a0b:b0:4b9:6bbf:7073 with SMTP id d75a77b69052e-4e89d35ad07mr19782251cf.53.1760645369580;
        Thu, 16 Oct 2025 13:09:29 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881f91aasm7364503e87.38.2025.10.16.13.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 13:09:28 -0700 (PDT)
Date: Thu, 16 Oct 2025 23:09:27 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: david@ixit.cz
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Casey Connolly <casey.connolly@linaro.org>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH v3 3/8] arm64: dts: qcom: sdm845-oneplus-fajita:
 Compatible describing both DDIC and panel
Message-ID: <o4oe3bjrnzthgwomy4y6r6swtzkylerimtgir55fgpvhjbrlgb@4hvemz3q4ho4>
References: <20251016-s6e3fc2x01-v3-0-ce0f3566b903@ixit.cz>
 <20251016-s6e3fc2x01-v3-3-ce0f3566b903@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016-s6e3fc2x01-v3-3-ce0f3566b903@ixit.cz>
X-Proofpoint-GUID: J_W1ftYXSyFEbtKNJ86UpWeAJCAreFTF
X-Proofpoint-ORIG-GUID: J_W1ftYXSyFEbtKNJ86UpWeAJCAreFTF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNyBTYWx0ZWRfX2x6WSisMe+Pi
 5tRUYc8bgMyV+RDkczyJQba8PBytqKpvx+YaYucHXc9RQVNN00LJT+fX6JZTMRB8XwUoM0dW0Gn
 Qoq3caQgeCGcaO8epzo5F5omUi/uq5z7ZpcjwuFQJsAFFit+W6FFCgvKb2QTDQ+QkDz2OI5KCEr
 t8OdFRNU3qWUNW3iu2zERTwn2J2/RHuvfuRp0NUiGYYL4N8AJTYWZDMq41yNAazDeDQSRDgFLBd
 al6bi9etTDjqEQGBwRs8oP+uSV4H5S1UDtg5wKvKyIZ9/qRBRcE31DcED6wGfvBdzzoLuCQXIa5
 900yiRM/o8sb7v1qnMwm4Co4tNApoHJrYb27d/eAcv0WE5VXz0St9ZMPsP8CMCHaJJHqpKYQ+dW
 DEECYf2Htw1lrsiXdbtWKOhTPuDDmg==
X-Authority-Analysis: v=2.4 cv=JLw2csKb c=1 sm=1 tr=0 ts=68f150fb cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=J8i-PDvN9eMQhD4ShqMA:9
 a=CjuIK1q_8ugA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110017

On Thu, Oct 16, 2025 at 06:16:58PM +0200, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> Compatible should precisely describe the hardware used.
> Original compatible describing only the DDIC used, but omit describing
> the panel used (Samsung AMS641RW), which we have no way to detect.

I think this should be squashed into the previous commit.

> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dts b/arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dts
> index 7e75decfda052..d6cd873aef0de 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dts
> @@ -32,7 +32,7 @@ battery: battery {
>  &display_panel {
>  	status = "okay";
>  
> -	compatible = "samsung,s6e3fc2x01";
> +	compatible = "samsung,s6e3fc2x01-ams641rw", "samsung,s6e3fc2x01";
>  };
>  
>  &i2c4 {
> 
> -- 
> 2.51.0
> 
> 

-- 
With best wishes
Dmitry


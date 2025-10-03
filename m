Return-Path: <linux-kernel+bounces-841682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E83BB7FCA
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 21:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A2CB34EEDF5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 19:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CEF222596;
	Fri,  3 Oct 2025 19:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F4xBIHQO"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67188175BF
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 19:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759520213; cv=none; b=L8bxuvcG7yoTC2pLKq5bFPm2Rws6xvG6xr1BLEQfJyqE+zfMtQATpiYFueU0/oTF0oXajrlPXP5dcmqEqYpedt+LPEL5qOuaVoLihqNckcIuXEHFsF3WAAn0g+zeLrrQ1MJwSYNMa2lVURze4jTMULwxnt9ddG5SbtNCzZDEjoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759520213; c=relaxed/simple;
	bh=2xkx+Gqn++j+/JEZH+TJfIUQdtEldaU/S5mCCrdtJU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TD4WWJ/DdOvUK6rVeVMnEJS6X1gqIbCDDdGQH+iy3OElw+FkOgP6gj1i+aZgd1oM3u0J0X1Eus1cuBrmGJs6CVIhjUKmuL9J2zbYs2S9TjSrqa2wzHHCB6ECZtOjmEwS0jU20gezJGLNg1xJIFYAqTmFACuy41Lb4ak5DWY51vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F4xBIHQO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 593AgkiM012318
	for <linux-kernel@vger.kernel.org>; Fri, 3 Oct 2025 19:36:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hW5BPFSrgags4e9rk980QW7r
	yzTUgv64kGyaZ19aEoM=; b=F4xBIHQOo3P4jhJ66VWyHrnk7jnCiyGDv9Uy3Ne6
	XK/f8CFGbS4iwbBZnfnTo6JXq/Q4ukfsGcNBGG94TjsRrhJlr/XiJoDGS5brlf+j
	cN3Ff6Dlxnbmay8rrJW4JJ4YiZdp4p0kZarQEfHeU9tFEmTYYRtJo9MLw8SO1SvF
	Zgf/5NXE1us+wPNn+qfIeF4OeEPuUxFZJUN2Pe8z/wkXIvQ4hqta2NpNgVSkLDHK
	LfxL8u5V6bbF0srxCb49ti91RNjtaFMghLMhEK7hOd5fLlUGuktdqjraNtruRQRK
	tTA7PC42FIeT6jfXNfhtbkMq1dAQkoPAfGro2qOxYUcZSg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e80u3yk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 19:36:51 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e002f413e4so28869471cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 12:36:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759520210; x=1760125010;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hW5BPFSrgags4e9rk980QW7ryzTUgv64kGyaZ19aEoM=;
        b=WHJUVS6L02JNhlJ64IAS1bZi6QyJCNOkhOY4BlyvrtsvUE7KnCYlxVVIp1sNuWdgYr
         tJUOfqK1jK6RsvMenojcAxtA1CSUKIbClcaPynBdftll4fSX9H9X+Vev9sz771oXlWm+
         wh7Z3pLEM5pnqUgxy3UyqenMoEUQb/I7PXTmGYXT9TeeTrWfQSB6sq/zday+xJJcrMRx
         5M7V/HSFqhGMN1Wwe7bWGISSYtuTPDHWmEPJe9AX1qtkOsxrH7PhkIegH1JYmWvf160P
         nP53vGmQnK80A9p/SshKmuRPiJMKYUleiCZnpwSbSGex87Vw02dEz1g8c8DiaDpcUhC8
         jUdA==
X-Forwarded-Encrypted: i=1; AJvYcCVX3bXeVKEt0aOWtYSzGz3QXnEjZhcDGdZ2w91vvJLNP5LDYZy+MrYE3TnHgVAXfMv5Qh8JE1elYbwGaNg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzab9GtEKVN8BXIpzKJfcHVcaNHx4WfIE3mKlXNxDPiDn9juGCd
	Hj8IaYisfEe3Lqd3Oz6GF7/2MDzglFCcSwz/VqX5EH0166irqq6ITDdtiIUyInhUwsCOPQR2yeD
	8+x8BPakpPTqyYzA0Zos1I3yI/6Bl0P6hO+N00fS66PFRc625ijAp0xTUd7hn6N+4zfY=
X-Gm-Gg: ASbGnct4VE+SUef1q6edAAq5kvUj9NTxEM1+w1fNEvVz9Qu96AtZJqw/GRL8pUh5th4
	Up3Ml4NYtxkPrxjeZtB1bUA9HEfY3W9BtX7xEpPxW1aV7xeHPkg97jxgBo3Nti8OyL/n9OYmTUZ
	70Y3buSWFnDzTPa2HmnV3ZDiRpU1O/sXXiOeQXvofIJhFoYUCaEJ54NMCLhjHxHYAYNhYUw3QB9
	pB/C+KQ1WX+Ig/e2W2WGaaIOiLA6YjVK+zTkl4ZowuB7EbEytnDqrRTBqYjb4GM/4DB+jnHomPj
	Bc7vJ+W736XTHpCwqbNp2ulR3qopn+3gkENgAwTUqsAt9uVL3JAHhfZU4DQ3YXtpU2+lXcgAmrm
	dFB17F2j22ykrpZBddv+AbbL+iMhJK3OfXFhoE0LpNVJqercMRdlkLa43JA==
X-Received: by 2002:a05:622a:411b:b0:4b7:9c98:aed6 with SMTP id d75a77b69052e-4e576ada47bmr63471411cf.41.1759520210233;
        Fri, 03 Oct 2025 12:36:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHzYqAtz79UldeuWXluxUDIsWKIiRIS16dQs1C6L6K3uum8zW0I06HKp+YKgRVXueXdfeNRQ==
X-Received: by 2002:a05:622a:411b:b0:4b7:9c98:aed6 with SMTP id d75a77b69052e-4e576ada47bmr63470831cf.41.1759520209476;
        Fri, 03 Oct 2025 12:36:49 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0113b437sm2110367e87.43.2025.10.03.12.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 12:36:48 -0700 (PDT)
Date: Fri, 3 Oct 2025 22:36:46 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Paul Sajna <sajattack@postmarketos.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        Amir Dahan <system64fumo@protonmail.com>,
        Christopher Brown <crispybrown@gmail.com>
Subject: Re: [PATCH v3 07/11] arm64: dts: qcom: sdm845-lg-{common, judyln}:
 Add wifi node
Message-ID: <budxy3xza3ieykmrp2anpiz3gktq6mc3pqohkf6ew23jun3po3@jv2em5mmhjts>
References: <20250928-judyln-dts-v3-0-b14cf9e9a928@postmarketos.org>
 <20250928-judyln-dts-v3-7-b14cf9e9a928@postmarketos.org>
 <f58493a9-6def-4610-9c3e-d6a877dc23d3@oss.qualcomm.com>
 <d38801bc77ad00442b1669ea252ae30a5c6af5b4@postmarketos.org>
 <7661d9d9-eca3-4708-8162-960df0d7f6c7@oss.qualcomm.com>
 <ad721948b83a54eaa34f367e12564fe6acc222a1@postmarketos.org>
 <gfbvgsen75w5h7afyo454pvdfslkeprqyuycuok6syinbza7vx@crapzdo33re7>
 <b9285a2e81ca992b9fc560c78ae03921000e388e@postmarketos.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9285a2e81ca992b9fc560c78ae03921000e388e@postmarketos.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyOSBTYWx0ZWRfX5avjVgLjrIFh
 GfGEAbEQRe2EKsHXffMiDSakjf/5K9ebuYz7OGlM9Qcihbxt4Ses7tgyC6zbmO2QkUGZM+G8rxx
 of8UlqhEUy+kr1qVSOujqdUcGDfKvO7SXQYuKkfFixt9pS96mkuS8H5nIym/RF0iC/+hF6SjW10
 Eq2MqaiEqRM0IQNxyBAccc1YrPq4IL75IXMvvEDMQ66O+uOu1ywftp/GkvIVvNnhl+JG9YiTAnW
 N7DOE/KGYKDFFbjYf2Vxwt/EzfvsR7qVR+DLmlGmvmHADJJ+uSOtgxM4zHLCA8mYKmZXKK7YX5e
 YNGMYvEgbaLMsEfT8uSLcqQwRHdeOfUuGLslm+D5oqll0By0TnQMjK8Jaf8QhEs2fnHsRUmdAGF
 ALQMm0PbVAQhvyrNDmkQDgeGOCfj8Q==
X-Proofpoint-GUID: -Xsv8DZmDTKJuvZmgxnSCkMLi6IIK-iT
X-Authority-Analysis: v=2.4 cv=OMkqHCaB c=1 sm=1 tr=0 ts=68e025d3 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=RrlILGEu0WOW5ijQb6sA:9 a=lqcHg5cX4UMA:10
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: -Xsv8DZmDTKJuvZmgxnSCkMLi6IIK-iT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_06,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270029

On Fri, Oct 03, 2025 at 06:52:03PM +0000, Paul Sajna wrote:
> October 3, 2025 at 5:13 PM, "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com mailto:dmitry.baryshkov@oss.qualcomm.com?to=%22Dmitry%20Baryshkov%22%20%3Cdmitry.baryshkov%40oss.qualcomm.com%3E > wrote:
> 
> 
> 
> > Regarding the MDSS. Is it being solved by adding reset to the MDSS node?
> > Or are there any other issues?
> 
> Yes I'm referring to the reset / pmdomain issue. Joel Selvaraj is looking into it in the sdm845 tree. He said he tried doing what other SOCs did and it just got stuck in a reboot loop. More investigation required. Currently he's reverted the pmdomain commits in our tree.

Which pmdomain commits?

-- 
With best wishes
Dmitry


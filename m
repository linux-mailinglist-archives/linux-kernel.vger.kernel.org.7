Return-Path: <linux-kernel+bounces-841790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1AEBB83CB
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 23:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD0434E4684
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 21:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEF127280C;
	Fri,  3 Oct 2025 21:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b69CqWUC"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A5B264F8A
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 21:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759528189; cv=none; b=Zyg717Z57JxipjrW1BBfcWbkR7ks4b19zf3n260+oWxXjRr/vGR1tky6d9kASXlKLe/qUsbxMmkQn7mtZGYDhfg2L/cowmmfz1sbrLfuoYWxrDQpnTKYAbW+bPPI1AwwNn3PKnxJkcqJLs6giHs6sFzbBH9xx8K4B5lxT7BX4ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759528189; c=relaxed/simple;
	bh=V2Wkyjp61eE2yNsrEBIrnO48rBvAdczr/Veo5IHkEoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YwoxVrP0UBVbinOiDrgFAfPKFAABhAB1uK+dWQkdrIYSoF2Ndt4BX0Or6JOSkdSt3puKcD8kArJkDu7KjC45hXnVr75iMaBuL7WTDt4ifY9SbfOWGPwXPeF8kJ4ve/xmwe51Atb+tjPmQtjOOGmVGaXIHS0vecXNAkR89lBDH7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b69CqWUC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 593CDeuA022969
	for <linux-kernel@vger.kernel.org>; Fri, 3 Oct 2025 21:49:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=CXTO/NJSy1u0WPzx3mtYRDh4
	ZwyImi0h9HK1EEN2E90=; b=b69CqWUCPXNQx+XR9KGvjrsELBSn1i0u8Y/CZX3g
	Ub4gODHQGEfvPZ81Kd1tem2N4sxj+E/KQbDSL4XOPc54KECL7eM+g4jvn259jwSB
	1bEcEYAQRnvnYAdLYupuU4n5gwymNGc0lHuu1npmw6qgYyMfaIdYknzr2p/zZUXf
	46bA5giMFN+BdF59vk51EXdJcIXVXmGWAOpv+2BuLrnEhPhWZNiqasJzkWzjZXoh
	uUz2F1hWNB82zsw6qGkiAl7y0odTvr0utvruHJaRHD+0MM1pO9o/ePn4wZdaf6nP
	BiODUX28TJNYZKkzzX2J6c0WP6y5AK640XYne8NlBaYxPA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e59ncdas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 21:49:47 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e576157d54so35479361cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 14:49:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759528186; x=1760132986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CXTO/NJSy1u0WPzx3mtYRDh4ZwyImi0h9HK1EEN2E90=;
        b=HzL9/oTTFfzpmzmwliDbBJXG+TdubsFz7uTVMiGLQydYik1s+8QFvD3WgOtGNfKueY
         mbw5rj3ImCEIDNJG5gY++ASIZ8eS164GOEJZD8KQBCwRRp1BQrBHzHJFItC+8QHC0Vxs
         ddInQhucJZQA3l55HXIjwXYj6BVZ5HxUsIrELLzB3jTBuK4VpUATm43DekNtjxNR/yP9
         ITeEoXkxMKprqZlH0tYRN7zYiTnR/KNZz2M8YjYIeBmTivvy1sw6lDPNlQwDyz2bnkun
         OEyKVwwsvRzfhOkm5xTGJkE14kyCQc0Jb/aQSQBAzScy26CvRgdsf2lYDSMHpCdYd82A
         PRrA==
X-Forwarded-Encrypted: i=1; AJvYcCVXujks11N54Q2u7kQHvAtrJb2KyC1IEqc/p4j09bSBMzXPZGYi3sqcNgih+3sJnx7KuqEoM/9KGLBEQEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmDdlkAIrzGJrFKjHEGhLdm+EWd/oQGTLSux4qP6JjVE7hPRg4
	IXsvxhdiNasfYmrX8NB8kQAKC9W82WG3uniPWH6kaY0yIDQlLkft82+XVTNRAatqrkqEonGHa46
	7aWp4+NMMROngS/sxJSxA0/p00usSli0Up2IFrsc8MXjx4gR959RWfYaUoKO5fZ4P8hE=
X-Gm-Gg: ASbGncuCyCSAgebtJwPZX7pdu4AXZDyDw8sSp/wcRg5yOKj09vmC3wJQupV0lhfD4U4
	jOZqXIezkN4ooc5r9tFqssc/cg3hJHztBM1bMx9n5XOkQMyV535/oUqNjFiSiRMCyxcnUUDjfCZ
	cQw5FWpLg8ghh1I0ItzE+154Bo9EjrgHjyirbILKoFrnYPzx0oBq+2nxQTuGQERGnmxKrthF/jK
	SCudWZvN3G92o1TzIQSJrr7sxdXQDSfIuSZCpmDRbFuOoDxmO9pclEzHtGG7YPOnY80Pb69f2Df
	hE5RBfoGxe5+voeqCm2ZXWUfEQyETa/B0NFN8gGb24EDgwdhhfgq/KD+vco7hxTgbeTVqcfKFMq
	MOVas66W8ad3HzijVzsdHxJ1a9LtCguU0cu1FT0x8wj7TIk4EB9Lt7mufeg==
X-Received: by 2002:a05:622a:8d:b0:4dd:3948:3377 with SMTP id d75a77b69052e-4e576ad86dfmr68919531cf.58.1759528186408;
        Fri, 03 Oct 2025 14:49:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqQ5JrGSaAju5feGXkIeOACPcymH0FWHYpUhlOk5LHmhvDelT1A+t3RRJ22rsbo+36OHGoLQ==
X-Received: by 2002:a05:622a:8d:b0:4dd:3948:3377 with SMTP id d75a77b69052e-4e576ad86dfmr68919091cf.58.1759528185860;
        Fri, 03 Oct 2025 14:49:45 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0118d6dbsm2208525e87.82.2025.10.03.14.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 14:49:44 -0700 (PDT)
Date: Sat, 4 Oct 2025 00:49:42 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Paul Sajna <sajattack@postmarketos.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        Amir Dahan <system64fumo@protonmail.com>,
        Christopher Brown <crispybrown@gmail.com>
Subject: Re: [PATCH v3 08/11] arm64: dts: qcom: sdm845-lg-common: Add
 chassis-type
Message-ID: <xeu4vsmkfws74qxnzwmsbvdr76taapa5bvao6notfttu74yztf@fq4ap7hid3yf>
References: <20250928-judyln-dts-v3-0-b14cf9e9a928@postmarketos.org>
 <20250928-judyln-dts-v3-8-b14cf9e9a928@postmarketos.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250928-judyln-dts-v3-8-b14cf9e9a928@postmarketos.org>
X-Proofpoint-GUID: PwpGNk3FL25H_hssR_qmVlt4-t5ECRr_
X-Authority-Analysis: v=2.4 cv=O4g0fR9W c=1 sm=1 tr=0 ts=68e044fb cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=Gbw9aFdXAAAA:8 a=EUspDBNiAAAA:8 a=xpcYJZ5K4HInNErYrfIA:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22 a=9vIz8raoGPyDa4jBFAYH:22
X-Proofpoint-ORIG-GUID: PwpGNk3FL25H_hssR_qmVlt4-t5ECRr_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAwMSBTYWx0ZWRfX1RUdfNLFt0fF
 jk00k6Yp1BKtqQ4MPYu9YIB3VrV3fdMgGrtUJVfBF4YS6iQNmEtubRzfsCkBMNcGnS2CQsmlvQ7
 ikeg9V5nApzwL67ytI77G77L/04N/C7umdJrXswK1EGAYurALWAKk0BehTOQVWOsQPDo9yAPO7k
 1rAEM7z+PZmNcycDpt7kv+YmCXjtsRtVufM4qmjFOCLn0X2B0HyBL2FCczL/WefpQlC++paNEo8
 nMm1PKYQGMKcloeRrMn4VNj7UVVupAbxAqKUCXTPtYS3AGMtnd7p3imb1e4HFECXYFzrYTC8mW5
 Tvz0eL5CqARQlOeAn+3t+tW55KPsyzTuCr9pPZIBGna84+PGbPdYFxNtpVPycT8FUl9HNQV6hSQ
 xRt5abadc/VpeV/oLrK5sX54r5Kp5A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_07,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270001

On Sun, Sep 28, 2025 at 10:05:31PM -0700, Paul Sajna wrote:
> The sdm845-lg devices are all phones, therefore handset chassis
> 
> Signed-off-by: Paul Sajna <sajattack@postmarketos.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry


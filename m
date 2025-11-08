Return-Path: <linux-kernel+bounces-891625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A80C431CF
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 18:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 318C93A4FA9
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 17:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE95253F12;
	Sat,  8 Nov 2025 17:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EA51gMXP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hcffhh3/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018572561D1
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 17:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762622813; cv=none; b=aSWexF7esfSjtBxhSwp+YFlIu9PQ11CsRMV2x89lhjBTvBsU4m3EHf01qDooI7MVWAhOPbXi6Jyd11tAlJT6BXR3h1EcKsr+UQNRJmvwbl70jUCXr7Vaemsuoho1vDKtVJXKoXB5bQK8krdzKGwiM4YlMm0vhz5nZHeT+Bxl8TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762622813; c=relaxed/simple;
	bh=Hvpw+pRntckNWq+r2W3D6IoCt2L6QAauNS44X9epUro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rt7fmH+nyZ9vv6gpg569o4uSb5rQdQhgpM/zXC7x4rQdEGatFHPQ7yX6DXLX0QF6/AaKZQRcFH35WF9TII1ld+aean9CYzh5kqT6DEbE7+4AQWQHqi7IsvZ+2fv/+mTsizB1bJ8uuHhuKtwwMXLv9Kljtx7qyYdTyg5QBCnmmGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EA51gMXP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Hcffhh3/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A88Pr1v1247216
	for <linux-kernel@vger.kernel.org>; Sat, 8 Nov 2025 17:26:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=2umMsr4S5HW5lXJ3fQAZdAbM
	0Mw1K+JPW/3AzeFNEq0=; b=EA51gMXPovcwpq9qK8cYNwZLshlbBjwspo/7m3Ll
	uANgeVw/VlXUqn2ydVieNhIqD7MKH7kI1EHrIt8conl34UFFZtkZfWC8vmE46ekt
	uWz8HfcPwz4ys3sb/oRKIrtL4yi8IdAskRLQl/KI6pTQDHeByOrwfa5GIKK8rVQE
	tikjktwBN65v194ZI1r2oilp3Yi9TrLg9NQGa/hJJMpnsf6SnQ6L/TeB29H+TNSv
	Sdm0EEr3LoYPQkm1BoNqnWTGEmJnPwNygNtSpTzMOkIxiDbWC/l/a54ImqV6q1A1
	lHz8xKisS79LScPkMYf/DEitkDmcE6qURChTdHJhjTUUyA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9y56rvtu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 17:26:50 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4eda627f784so9783851cf.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 09:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762622809; x=1763227609; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2umMsr4S5HW5lXJ3fQAZdAbM0Mw1K+JPW/3AzeFNEq0=;
        b=Hcffhh3/QkRYaaiZJUckhbclbt6olvYA68YEo6T8I/LJ5WDcbtdw4pOzNckKPm9OUI
         bzJ/cRYHu92L6iW0P/kb/nm3bR/hP4vmhhUwjehGKHC5wSmAtADMy3Wl8LtQEd2qqd97
         Zux2v9c4XUdMY876JpEjtaO5XpAHS7+N0fyJ1QY0lDqPv60FfFQa/ODDyNoLEn5hQ9Zd
         tmznVBWhxRoDxI+Eh04eLhM6nkV0Orr2Ve5hnSXo8zhQrRjZi2qjsEFcIbX9en0K0Ux3
         qLK11j95HUOqI73nuBEoasQQ/MaIrC8KsrWKtj5saRoKo6DcvBKqsupc55x64ojDpFgo
         O3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762622809; x=1763227609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2umMsr4S5HW5lXJ3fQAZdAbM0Mw1K+JPW/3AzeFNEq0=;
        b=E2AeX8OohaeTwO/HgQ6RwExUGIFfJ8b34V+/vIQZmBt+xk5JqUS08b22wjvH4ij5DM
         4wYKIcc17FRCJE4E5+zFH3XvOLUxTiQNTmZKEXe5ZQgWn6QoWa0bzxzG1/k3Du7vBDUy
         PXqtXjDQFsw9jrX1VpRcJ/GHpROkeajQ54XYRjs4up5atNpkutbxUXPXmws02x+/7gzx
         LS4HHT5Vi8Uj54Vcr4AKzaa9rVzNLi/wajlgpwvJtmjOztApwRhwX6SQLPzHhXhRYzOK
         tN6VvNyp2N20YXTif1EtKfudROB0y7mEylQUj+g/N17NeEbAphrQcW/Iz0iQmtyiBa5a
         gPow==
X-Forwarded-Encrypted: i=1; AJvYcCV2fKgNV4iQDnRGrEPN+EAVZQv+j/t7JVe9HdGj42Kbpk2TmCnYo9APrQNnX3qHalmqzww/qXE6K21xBos=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvw0Z44VSo4I9h05/+WnGL/Dh+1GZyj6tvUrFXKlRSoqEbOFhI
	Zl+e3MjKaDlo6vSoeT4eAogVz9tGlcx5zEuxwG3RW//UX29PHpn19RZGmaj6hYfjQNKpFhJQZeo
	lz4kyFd9MpcVUGP+GtqpggYsI+tZ0UFUATrUzcwsXNgIoSLR33ZLk9rjPA3XXX8HrJzM=
X-Gm-Gg: ASbGncvGOCjaEA64fg5YkxeYQYvQMcvkY1oZpbYwME30eYqLi6yZLDo2FzRaHbIQAYi
	MRLJMCYOa7Z6j8X7wLjqOX8ewhl7iF1JRDHU38d5drg2UhMvQtXAxtZ03UOIcOX7lLBDLZn2wr7
	zs0fTT8XV9S4zqyKoQ9oWgSk+UapUeTyjjoXBI+n2bLJy9ZumdSyQm7hrnXBeVUtvEL+Cpyhw2T
	bsosQbu4BjaGUaatqrtt5IPGTaDEspjoI5iWVFRkUnPTDKBLr79A5I92pzQlrWdom01kFjOsJrZ
	aSD1gRbUQQIOauraYV6seBvKgeWD3Ww3Xwt4apPqUJr0jtjMpuH2ocS3uyVb5UuQ1WJrqfGsNWS
	1f/eIo2lVKGPNp1BrBR+AV5QL+3YG8udyz0dVjkGtvr0NYwYfejZzFl+iZ1EiUu7LrFp5AhtQCc
	wVTfRujsu3RLHX
X-Received: by 2002:a05:622a:198e:b0:4ec:f2e9:493e with SMTP id d75a77b69052e-4ed998115a0mr78969141cf.34.1762622809641;
        Sat, 08 Nov 2025 09:26:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwezJQcmvFQWoTFXSG44miuWH+tCs9KRjF2cifamxToL082Jokif4YFw4V81sX3jhDzcu6dw==
X-Received: by 2002:a05:622a:198e:b0:4ec:f2e9:493e with SMTP id d75a77b69052e-4ed998115a0mr78968951cf.34.1762622809169;
        Sat, 08 Nov 2025 09:26:49 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a024f09sm2345136e87.41.2025.11.08.09.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 09:26:48 -0800 (PST)
Date: Sat, 8 Nov 2025 19:26:46 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: hrishabh.rajput@oss.qualcomm.com
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v5 1/2] firmware: qcom: scm: Register gunyah watchdog
 device
Message-ID: <hbxtbaoavlsw7pbmg3cfkbyx4nacjfiikckhqgpvlggbh6hu5b@jyporqecfzni>
References: <20251107-gunyah_watchdog-v5-0-4c6e3fb6eb17@oss.qualcomm.com>
 <20251107-gunyah_watchdog-v5-1-4c6e3fb6eb17@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107-gunyah_watchdog-v5-1-4c6e3fb6eb17@oss.qualcomm.com>
X-Proofpoint-GUID: sI087KbcB69GWx5hF3p2xrDRwtdbksjF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDE0MSBTYWx0ZWRfX4Wo2YKm11RYS
 hz+pO96L+gUJZilcEYFCFJNlLrhHbpaYSfdkhIMlRPtMt9gWEqYZqEkqoZT+S3ZBjOxp9jxXbaP
 690A2U8XfkzQ75f+mupfOgDZ8USjBD7ZXPFT91f0aSFrtpXiF6jWa8Fc6ZUHWOGh0NW/JdqDkVf
 37g7ekMiAvlrnWS7Q/EKwu3nOQ5nzFcapQMMwWDRLGwpzVZL5cvR9VT+VhehhPOoGtZUWom7P6W
 Fe6O91HGMogFUKviUueAgWXWG8U11vh5gcIOgEdlMumztJtoEOBe3YLousyeSaNe58n4YAOoCQa
 2dYBpMcTd1MqfjIM246MGwMdkcAEzLWWTnYHRtSdpjX/7NtgnWUXsEjfPOr9RrHKpdFZq/ee/zL
 NIEkwa+wVLZ3YBy53hTIQl7LClFRwA==
X-Authority-Analysis: v=2.4 cv=V8xwEOni c=1 sm=1 tr=0 ts=690f7d5b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=YueeOpoQ0xcX2KNfXj8A:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: sI087KbcB69GWx5hF3p2xrDRwtdbksjF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-08_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 impostorscore=0 spamscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511080141

On Fri, Nov 07, 2025 at 05:53:08PM +0000, Hrishabh Rajput via B4 Relay wrote:
> From: Hrishabh Rajput <hrishabh.rajput@oss.qualcomm.com>
> 
> To restrict Gunyah watchdog initialization to Qualcomm platforms running
> under the Gunyah Hypervisor, register the watchdog device in the QCOM
> SCM driver.
> 
> When Gunyah is not present or Gunyah emulates MMIO-based watchdog, we
> expect Qualcomm watchdog or ARM SBSA watchdog device to be present in
> the devicetree. First, we make sure we're running under the Gunyah
> Hypervisor. Then we move to check if any of the above mentioned
> watchdog device nodes are present, if not then we proceed to register
> the SMC-based Gunyah watchdog device.
> 
> Signed-off-by: Hrishabh Rajput <hrishabh.rajput@oss.qualcomm.com>
> ---
>  drivers/firmware/qcom/qcom_scm.c | 51 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> index e777b7cb9b12..71b79c0229da 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -2182,6 +2182,54 @@ int qcom_scm_qtee_callback_response(phys_addr_t buf, size_t buf_size,
>  }
>  EXPORT_SYMBOL(qcom_scm_qtee_callback_response);
>  
> +static void qcom_scm_gunyah_wdt_free(void *data)
> +{
> +	struct platform_device *gunyah_wdt_dev = data;
> +
> +	platform_device_unregister(gunyah_wdt_dev);
> +}
> +
> +static void qcom_scm_gunyah_wdt_init(struct qcom_scm *scm)
> +{
> +	struct platform_device *gunyah_wdt_dev;
> +	struct device_node *np;
> +	bool of_wdt_available;
> +	int i;
> +	uuid_t gunyah_uuid = UUID_INIT(0xc1d58fcd, 0xa453, 0x5fdb, 0x92, 0x65,

static const?

> +				       0xce, 0x36, 0x67, 0x3d, 0x5f, 0x14);
> +	static const char * const of_wdt_compatible[] = {
> +		"qcom,kpss-wdt",
> +		"arm,sbsa-gwdt",
> +	};
> +
> +	/* Bail out if we are not running under Gunyah */
> +	if (!arm_smccc_hypervisor_has_uuid(&gunyah_uuid))
> +		return;

This rquires 'select HAVE_ARM_SMCCC_DISCOVERY'

> +

-- 
With best wishes
Dmitry


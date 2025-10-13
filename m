Return-Path: <linux-kernel+bounces-850132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 481BABD1F9D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F3F2D4EDC83
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 08:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6458D2F068C;
	Mon, 13 Oct 2025 08:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XR+o92d6"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0A62EFD95
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760343377; cv=none; b=FIfvh5W9X8uzm3Jcc5XtQ0JZ5+XdBsLgVxlrfTuhw4Oo0hFR1biZvK3V2iSXvYdS3vEDoJepwi82YSD5vN8ve+V6GgbsItWD6ZaxHPA80+7FCWKqqx20mTUikqubaxgc7BdGyXf6Ovl+kwxv6XvLqbGwC20V8WoUMfeOo4kWgx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760343377; c=relaxed/simple;
	bh=OJlBTsvSxOkcP4IulZUo7W/MD7FWB0v5P1QHZlWLCWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eh4HRUIiu01LBNv54byy1DoSe0okjM7BuawM51AXHqIClUzDxgE3FVA/6KWXiPWT8R1hUOTeccjrOI0EtYsV8iPz3N+xz5p6s203TAd5lETksm1D3tfzB7JdocTkUhySkgRuTk8iuhMi4SgKKGiXggNp1JERgHibQ0RfX+2TRJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XR+o92d6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D2n44M000534
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:16:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dtZY/OAN7u0qy7UYIqN06nPgBQTWNhTlY/8haez5SFI=; b=XR+o92d6O2c5jooo
	Z0uAfvPh5+/D7nD43WK8uAyuhQ1zPFHFD5MrBs9+Ino75mhwE2Q5xYFp2DwXhqaf
	0vmYIi7qsUb4XF4WmR8LjfXfd6L+aG/Of0JPB6QNvREf4KqUwjbfI1sFB1SJL38s
	tv2jMN0PxrxNlVXNuZI8I4iDE2B4TfuVcPJR1cJVicKJqVrTkPrC44t0wMZR0x69
	blIeqgKoMuvu6cZ4L6vrFut0XgvHtQf0ShP5+siWpS8UmuvRCfyNMmfOmGNyvYo7
	qPGDOCRFsntFubsrg0fvIGuBdcP4kGrsAaIZ1gGHDUnmzFE0LVbRZTqzEomX4FUM
	nlu/Yw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfd8ut2h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:16:14 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8572f379832so202491985a.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:16:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760343373; x=1760948173;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dtZY/OAN7u0qy7UYIqN06nPgBQTWNhTlY/8haez5SFI=;
        b=TJdtiNO3aRM07JVn85IDxs9Gxhcpv8Ct9C2wY43WFOwEzJLIK9O2bZUpReRw0r1JLH
         qwgjxt+QTKkNgqfLrQ6TxYYwffmKrXn1Na74x0XJy2W/RSRPd1dq/KNYrn2FCxVln6dh
         O9BLcY3l6GYcTI0nbY1S3HyJpbYc4FKGB+26JzxwvjqupmFqdracE4hkTvIPk2shKlqp
         dM6ww1FvNRnRuWV1iy6pOcJr55/e4LI6AqugejxuWT0I64WMJT81HZA/APh+8OlwDffR
         9C+Cesd01lbKprVV+v697ZmcseOV+RPyRzaxw9MJNC0keMR2TbFq/ByZ+c1bUfJNKv4S
         zKGA==
X-Forwarded-Encrypted: i=1; AJvYcCWnNsh3F6uZMQIa5kZNN+Sf7dGO9a3mtd0zJ+qt/DpWHFD4f0klvk8LelSRlOHLNI1NBgJFSgBPetHkm98=@vger.kernel.org
X-Gm-Message-State: AOJu0YznEL1W+9olR2H8KeaeO+SVOlX1Iofus6ngKrGK7VwcC4j477k6
	6U1UZlfovBKq+XEf/ciEjXEcF/TnS3Ouc1tNfgmLlRZXXgz9HaFCcC+1f4tjOBWuB0U234SQ7V0
	uE7YsOez3YRR0z758vrXQdPY/fMYpCgcD5nbIfwNnsbnOabQhpq9p8/QiaLRmzauyBsY=
X-Gm-Gg: ASbGnctzg4cvnavfIoEXI6r69e8/h/4XB5FE+XEXOQGfaR02skVtHvgZsrC/Pr8aUMG
	buF9ToMll6wYa/xTHuX4TVrVdBeYVg0Wem0awMw6YlXESMq8jD6cldY9YjiSsV5/iMdh/hTORGQ
	JHYAeH9XFhSMFE9P9ncJaoNOSiYVIoFaeGuisnS/660maspJkaA+k9MUz78OoKyCn9XwmANfUa5
	aUUNWwq/92ArpQk3MN5DlXdpsSSQJ2SUn+EGjFd/TDEQL0lylpJv4YQnFNNYfqqo3Q4EAgnweRP
	7CLM2NL6QSomJRoLdV4gnh03rL2bKZEeFsbKYIDcPhlTqk1Zt73PA8A7/GAlX2TmI5UZWRSzA2y
	CTWfAQ8pb1qpalU3H+EIjag==
X-Received: by 2002:a05:620a:f05:b0:864:1d18:499b with SMTP id af79cd13be357-883527b50e5mr1874644285a.5.1760343372872;
        Mon, 13 Oct 2025 01:16:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOrHcqxp2/qm6jjWC7xwfUjcVZZpvm7/3rrvDLAl8BX/cMX7CbtLqrEuXtw/C2eVcHparQDA==
X-Received: by 2002:a05:620a:f05:b0:864:1d18:499b with SMTP id af79cd13be357-883527b50e5mr1874643185a.5.1760343372405;
        Mon, 13 Oct 2025 01:16:12 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d61ccb09sm843421266b.19.2025.10.13.01.16.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 01:16:11 -0700 (PDT)
Message-ID: <d7d8bee0-db62-4ed3-a418-506887d54810@oss.qualcomm.com>
Date: Mon, 13 Oct 2025 10:16:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: qcom: x1-dell-thena: remove dp data-lanes
To: Val Packett <val@packett.cool>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Laurentiu Tudor <laurentiu.tudor1@dell.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251012224909.14988-1-val@packett.cool>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251012224909.14988-1-val@packett.cool>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: v9S_bt8lwq_v3XwjnLGnSKRZViD5wBmo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX1xLVuR+OnOaK
 x2J8JB+/i9xWbdY8exJy3z/+saB5/Y6sLHp+Nud7DC/3RiFC88vZgJMXy/re8Jx8rfKouvOO+Jh
 0E23v9m7gsvStBkyoTwuWDL9+LDlIk5g8JehsFlEa8rEbazEQn6Fouh+ssOrAzOFcUeDe/QIPXj
 pEZVdWZKFRw8IrR0BwgfXShn7Xb0S5EMO+wut09k4+PHZteqmNUAzzwXV4jT7IAmrhhy7u3Q41R
 uF1kNZsEFtSU1TEbvHhaZWA6UfVkLWQL7qSueT4AWCZQ/MDtF+IpDxcdGv536gofkWUokceCo/M
 zgW0H5tc5IxQqAzfsqvEvrdNSdVkb3rWj42mS5vMwERGHGoth61Wj3jLIh/yoZINvFwYuL/iML9
 co031U1QSUPtBzR2i3/w7d0jPRK/3A==
X-Proofpoint-GUID: v9S_bt8lwq_v3XwjnLGnSKRZViD5wBmo
X-Authority-Analysis: v=2.4 cv=PdTyRyhd c=1 sm=1 tr=0 ts=68ecb54e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=vs_YNVWh7-Gz6y0r928A:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

On 10/13/25 12:48 AM, Val Packett wrote:
> The commit 458de584248a ("arm64: dts: qcom: x1e80100: move dp0/1/2
> data-lanes to SoC dtsi") has landed before this file was added, so
> the data-lanes lines here remained.
> 
> Remove them to enable 4-lane DP on the X1E Dell Inspiron/Latitude.
> 
> Fixes: e7733b42111c ("arm64: dts: qcom: Add support for Dell Inspiron 7441 / Latitude 7455")
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Val Packett <val@packett.cool>
> ---

The commit message could say "enable 4-lane DP" instead, but
it's okay

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


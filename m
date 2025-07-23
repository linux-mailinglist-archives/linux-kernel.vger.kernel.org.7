Return-Path: <linux-kernel+bounces-742868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB74B0F78C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 17:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB8911C808D6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D67C1EB19B;
	Wed, 23 Jul 2025 15:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OVCYvSH8"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258731E3787
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 15:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753286272; cv=none; b=mIn16DLaoEoRvzvJ1rVcv0AiSX5HAKNFXdt0XZ7jTzrRr7ApdN3MLSND6G8TezxaFjA0synjIykwqbsv664ANp9zZ6i+0VRS2wEXTKlMIQszQGt4CsQNFIO8I8FY3MbdIyHIj2nfNrkYCr8Jwx61BFnErsr/SoLgYSIyC9Chri4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753286272; c=relaxed/simple;
	bh=2Lu4l+b66ZqRwcHiTle46y1MR/xDZsH3kzwngLbEfnQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rKYC2vMKIj3+vzjZIALeTk0BEHYASAlohDX86k20cs3VxfkrlgRyibjqYpAfAavvaVr5V6hdly4CoB0ni1pIufVt8SZ6Yob3IJZpk3tx+bSgzTjowSNWUXw+T72rYWeMU2cAdgM+GVJGBJyFjE40+GVVXCWfE62b2iqDpzt+aR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OVCYvSH8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N9F4kq010846
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 15:57:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YtkieUEHX0j7NOkthBC+xkyEn4NoDmNOetl5nOn3gOo=; b=OVCYvSH8JEgtNcW/
	Hvr2RshnKt96aXumsRwK3VvezPHpxY/onja3yBGT/IIGtR4nCEtkaMEiF9WPjedY
	RxXqoKh/FUtVddKCdpSrLF4y9RJZB01MLgZ/rRAe2ly5cMVB2Z8fnLGPYCOBNqTP
	XpV1ECegQvR6l9sXSKPVXdLEe1kXrJurmsK0Qm5i8pWu0F0VxkFOkz1b43Kzes/o
	0FcHb6qpslb9VTVWj6+vI3yrnAJ0D/+owCPz1JLCMn1Oo1d9/MaoE0fU2gr0Tad8
	2owIPQUk1tZMp8dVnpgVvP4XWUisK/n8k85PzPvDWSt/y+jZ7hgIpSLoXinwjCOY
	Brvz2A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4804na471m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 15:57:50 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ab76d22670so799881cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 08:57:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753286252; x=1753891052;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YtkieUEHX0j7NOkthBC+xkyEn4NoDmNOetl5nOn3gOo=;
        b=CvnKRHeLolgCUHrwfA74nJcpGxRgYNsq0q5ENhvvHuzNZUlONtRZgT/ah6Nsz8JqKn
         nqKmZMwZyOMXvXay2mKmNCkh3GQGalXp5ilhLOVVyGmB6tbx+FSQRt3CckZLfePfEBS5
         VggpeXkzoeQtMheLmQCE82nITWQ4HHq/auZQS43IQtHkyYzABwqP+9wBrUtW79w8o7bJ
         S0z7gww9DCAUTON2hOD8gChOF+XzmnFieaYxUtMX4tTmEg5pBTwPMuoasDQLo2cKv8Un
         BH12JbuIO+BKN63QvNgQGEY+0UavgH0vl+A7u+s/3JhFZVbdSBp40VxWlxr2gigUFI35
         rJpA==
X-Forwarded-Encrypted: i=1; AJvYcCUa5uEH/vY//z5vh/zzZCST9KMHUh4mQ+Km7uT2D2VFtt1ibvzgd6Obt2HaE6q1CppI2Yztz7sqdUsLp8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YygvrcI6RXnkBr9vSM/cD/mXFGs/kgp85v/OWj8Jtv3BMYwnRgt
	IuvGfBaELy1L3yUSRGdxag8YgWhN01zZjDy6uRhfhgF1j2VIO5SynfLikVoh2z+TA6gOM2l8e8c
	7ZBbW/sGHkxmpAc7/9BvFUs9pc1/PgBLLHTjXS9VFc4iDScI3xdt4gu4bExxpQSDbUbpSNf9bNI
	Q=
X-Gm-Gg: ASbGncuAN1yDIozxFtUK5oiTFh5ZUaJlxJ0daCX6ZjiOHb52jaaql/jbuwgGmlXWUBv
	I1Cdn5BAv08fECfZbbclUXUyzC9/1nk0/1RK2j0twSmbtuV9zZEpKWz7Gd7/C3YIDhV7pylSS4d
	oCbXyizNhLk5+xRS99n5DW7Do0Vno5ORvinmSVBuI97cETMbhUhZNHEaqA87T77NyduA0nQp+l7
	UwpHQZJqBdbGpXfPQrvuGokJoIzUEs83OWsszQ2cdni2vNoxShkd3T+ocC5PhhJN0bW3xg7XsVp
	rbKQmZm9232TtJZqaIzixcjPMjBFlSzOE9A=
X-Received: by 2002:a05:622a:1482:b0:4ab:5d1a:93bd with SMTP id d75a77b69052e-4ae6de8785emr46129091cf.23.1753286251745;
        Wed, 23 Jul 2025 08:57:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENrtc6QBbO0UPOgNoyMOBayciVcsK2EoG0Ya9QJi7FVg7P5WTjyM0W0swWYhkBXSIiTPi+sQ==
X-Received: by 2002:a05:622a:1482:b0:4ab:5d1a:93bd with SMTP id d75a77b69052e-4ae6de8785emr46128651cf.23.1753286251322;
        Wed, 23 Jul 2025 08:57:31 -0700 (PDT)
Received: from [192.168.1.17] ([61.2.112.87])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ae5c52c3d0sm24709271cf.26.2025.07.23.08.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 08:57:30 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
        kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        imx@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20250709033722.2924372-1-hongxing.zhu@nxp.com>
References: <20250709033722.2924372-1-hongxing.zhu@nxp.com>
Subject: Re: [PATCH v4 0/2] PCI: imx6: Refine apps_reset and EP link
 behavior
Message-Id: <175328624589.28758.7232251472383556230.b4-ty@kernel.org>
Date: Wed, 23 Jul 2025 21:27:25 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: _AgL6wBWAZctme5dbNCIJyO70a6rGflL
X-Proofpoint-ORIG-GUID: _AgL6wBWAZctme5dbNCIJyO70a6rGflL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDEzOCBTYWx0ZWRfX4xLDH8duPIYL
 riWaTPEyGqJSEScgLcfZb+lvMeGtllUfHF7s+OxlY8n3BxesP/m4vYyENJ+7yarmpmyGhK5Gxp/
 XXLaHF46qKxFGp6pjc6q+3wblVZevP4p7w9R3f19hD55oTA0iJiDGcFdZVjXYXeCM72fuFZldfv
 YPis8DOJAbhq6eGXVrxOnmzTwyfoRPbv4E4lGtDU/eD20IuRpA1E0fPCojecK77RRskzrp4h9LQ
 2s2DUb66rJMpgqi1QTs47a9E1YgCg22aIkW2H0r0AEeV8tzOquSJkuECKs2e52ttDnUMJcKCJkj
 DSzrlzq1SWr5DkuTOxaPYsEWmboI/U8jF0+G2HDUNTxvb2RAwa5QBMwp8AcsxjPb0ZcIoIRC+op
 RAaWgPeDP92OpPb/s2Du7YuaLIMyfJkn7rrgamveot9q9HKJE7RQA+OMVW8y47wETn7OY762
X-Authority-Analysis: v=2.4 cv=DoFW+H/+ c=1 sm=1 tr=0 ts=6881067e cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=L2vWZV9GmkZVUxua0bORKQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=L_pc-btOT9_bO7MH69IA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 mlxscore=0 mlxlogscore=545
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230138


On Wed, 09 Jul 2025 11:37:20 +0800, Richard Zhu wrote:
> apps_reset is LTSSM_EN on i.MX7, i.MX8MQ, i.MX8MM and i.MX8MP platforms.
> Since the assertion/de-assertion of apps_reset(LTSSM_EN bit) had been
> wrappered in imx_pcie_ltssm_enable() and imx_pcie_ltssm_disable();
> 
> Remove apps_reset toggle in imx_pcie_assert_core_reset() and
> imx_pcie_deassert_core_reset() functions. Use imx_pcie_ltssm_enable()
> and imx_pcie_ltssm_disable() to configure apps_reset directly.
> 
> [...]

Applied, thanks!

[1/2] PCI: imx6: Remove apps_reset toggle in _core_reset functions
      commit: 315b747ae6b07ffabb27ed8ca584e6e6df8050a5
[2/2] PCI: imx6: Align EP link start behavior with documentation
      commit: a43b68bc510aa61a5b7618c79784dbc83074e504

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>



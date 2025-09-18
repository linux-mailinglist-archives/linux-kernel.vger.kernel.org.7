Return-Path: <linux-kernel+bounces-823770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C700B8768B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 01:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0231D7E228B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968FF2FE047;
	Thu, 18 Sep 2025 23:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cdoEWxOe"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B66C2F7AC7
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 23:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758239250; cv=none; b=F3rARhk93zjkeo0JAQUFHM1wcBKbF0W82NP/gpeXscaufBOjNKex4gqgTzSOFobAikalkqBd9MiRBIz7T+iv+JsGXZzceq6H7859rhKWYb2SlshCUX1fZ/YZqO+fKl93AfsKzotdbN5BQW3fKjuwLJPIvmDn5lH8uLz9UPMlzvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758239250; c=relaxed/simple;
	bh=Zl5SdpafoIGUs8BYSH4+VgG2ye/0GMp4SRZoJCZVwDw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uQsmls0Ve/dYh62mSAhoDcW2TJiScUhQuglFbZWLtGyR4pbk2T5kZ6xTRSP+Cx9YFNBkIVINAn4JYmPTK3wPLFIGMv7/4Hspl3Ai/guBJP3w77HRK4Y1aozNBEuxqhC81KBFhcpNH43nHxvv2Z66KpbebA7YQIqEogYgodqpZic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cdoEWxOe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IFKak3007100
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 23:47:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nAdnGft0CDmvsgciSrd1Q2OfW5SxaJi36vRRvFm88Ec=; b=cdoEWxOevFYldDZ1
	7shFqLJcVR7S2J+1BMaQp7OlvYeakOfIyJPZOvLm9wGWhgyPpKhpho1Msr033Ysu
	r+3R5rxVcRC2kJmIBIftrpLerlAWuUq8bKl0MsD5cZ2FpepLI7M8+3dsdodM6W67
	GUXb3GiyLb6nx/mTqSbErtC4fUA08H8/dXU7eaMx+lsvvTetoz8Cv21JntI62ogL
	RPlOKJGNpHNhFmT7+8KUavB7b1UhP2N+9xpeJRrMqyA7D2BosuaPv478uZWJx/En
	8J/AucA4AUhZ4xXJficUVjBKTmF2lBoU9RlUP0p1y2i9ZF0tH1lad4OShjcBM9HM
	5x//Tg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 498ebetwff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 23:47:28 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24458345f5dso18818675ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 16:47:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758239248; x=1758844048;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nAdnGft0CDmvsgciSrd1Q2OfW5SxaJi36vRRvFm88Ec=;
        b=e6shd+ZopfUY9eno+nTEb58fZY+sWhvo0tbS8vTpSBIwkyrTzYxTlItsVeKxg40+lr
         vYTVRhrNV2XlYyvgr+rcLpQu1vG2XUjMlBGdFFCjef3ZMpsxBHe/Z/eGXX4xJJ8/kAK9
         aHqAT4o7HLpYsckaNBXp6WeWWHAFG/h29y01QlNyFZunhnytz4tsq66am7L5MA1CiSiH
         ijSQpRhwaOpuSJQPfoRdeccw6/jzYrcysGxUnaUWX0sFOs6t3mFJOxOLNI+JYJ4XbP0E
         uJo9MwAq5HMSZezAvduVZqUBLumC93F/KNrVt62QRrCex1Cj+M6Ulh7Y4xlqc1Puz3hT
         KcXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfPo0OrGe60HFY4xxmhiCZSymWF4tkJtQlR+uPZOLq8vTfNpvW91qseXUX9jgkI8ZtsPcLHmj0jSoMsV4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Mf/j95D5kIGAWP9fmdkFevyJy91VrgrV1xUcVSZIXm7e74oa
	V4GGracuKLsemF9ZyQfP0ckx1/VDyHTpjoa3fsj4xAGY4tQFku0NuqVkoRr3tm49/Lw3wd4LLv7
	Fd7TNhFkVRynIF13JtnL8tS5JykburkWOynw8+SsGZBY5pOkdi8feHrnR3Ioi4T6eE1w=
X-Gm-Gg: ASbGncsVwSh1/NsCk020tubNr83P8qPgplLbZJ387XIf3GbBgd27S15oEfF2dHTzOa8
	MaK4bWn7SGjJZP96FwSlMYAxP7+I45NCRnG3VQWeQcbIaXo0r4zXYA91XK5QqqQAO5GCrfGnWgX
	yc9dfhp/e20iQ7pNk8vDQJeU4qwyscw5CDiJOAGuJuDJyuxG+yPQL/YlVm3SUCQ5jZ9VUJl24eq
	9l2mbSibWgvKiBLxoMBShwnDVcdEvUz7t2W05PXfAf7Cl717Z/bQyMH1FpmxnQgkAmvsSvjDPqB
	pa9X30+dUouUdY5gGm2/Q3s5TL4yImNjjODL6zcGR9iNfxyXXRYrUYADdWMUKLaU4N0lRy5btMN
	y
X-Received: by 2002:a17:903:19e7:b0:264:f714:8dce with SMTP id d9443c01a7336-269ba5081d8mr19591795ad.36.1758239247944;
        Thu, 18 Sep 2025 16:47:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6pdrrG/kT5DYHOezNz5h9+nn4BGxvAI5GesrnV6WPlcXl4zeyxLYLeOFQ2LPNRUv0K8Q2vg==
X-Received: by 2002:a17:903:19e7:b0:264:f714:8dce with SMTP id d9443c01a7336-269ba5081d8mr19591485ad.36.1758239247501;
        Thu, 18 Sep 2025 16:47:27 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269aa71c928sm16474705ad.107.2025.09.18.16.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 16:47:27 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>, "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org, ath11k@lists.infradead.org
In-Reply-To: <20250813214933.897486-1-robh@kernel.org>
References: <20250813214933.897486-1-robh@kernel.org>
Subject: Re: [PATCH v3] wifi: ath: Use of_reserved_mem_region_to_resource()
 for "memory-region"
Message-Id: <175823924668.3217488.3526211732380687793.b4-ty@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 16:47:26 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: XrW0zBhkd2D_XAqKqoV6cBerOBVQSVWT
X-Authority-Analysis: v=2.4 cv=H6/bw/Yi c=1 sm=1 tr=0 ts=68cc9a10 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=VjuCZWrZiTeoWwOd-AYA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: XrW0zBhkd2D_XAqKqoV6cBerOBVQSVWT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE4MDA3NCBTYWx0ZWRfX1hhvoKTW66Yu
 itpxNAByHt0NNzI7IfqpnlQgJpUoVLPZKiHi1Ct/ekhgPxxHaLGuwkqwUr2YJ8d9B5SXlxDeBtT
 6yVrnj3bAFjinPGn/34yp5TmoXb3Ct+DR5maKxNJoV/iBTBEPlTX5BNYRQuywKVhf2C9+IUHBoU
 /Prkb5qZwsVAdt45hPQAyB6L+nqBJgolAkR8XQUZYdE+6iWzruLg5i0N/RnlQYVuyqesem2lGDx
 CPfxeDClqPWTev/vB5Ui1s6ArBZecLu62O6WRwsJ6aktWtsDfji3bSvTd/AnGN+n2/MFcHCnO42
 mhwiyflQIheJDH9WxU5jtv2BgxSFTrMhD7E3woxO6oFHwkc/KcOIhb8JlwwIl6f5AEHuQC1rQEL
 rugBN20f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_03,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509180074


On Wed, 13 Aug 2025 16:49:32 -0500, Rob Herring (Arm) wrote:
> Use the newly added of_reserved_mem_region_to_resource() function to
> handle "memory-region" properties.
> 
> The error handling is a bit different for ath10k. "memory-region" is
> optional, so failed lookup is not an error. But then an error in
> of_address_to_resource() is treated as an error. However, that
> distinction is not really important. Either the region is available
> and usable or it is not. So now, it is just
> of_reserved_mem_region_to_resource() which is checked for an error.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath: Use of_reserved_mem_region_to_resource() for "memory-region"
      commit: 900730dc4705dc78f9bf69c4c513ec018bffee37

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>



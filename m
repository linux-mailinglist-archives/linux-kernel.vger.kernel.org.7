Return-Path: <linux-kernel+bounces-823772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFD6B87697
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 01:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFE6D7E235F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DE527A456;
	Thu, 18 Sep 2025 23:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SqeSWjpk"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747302FDC56
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 23:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758239252; cv=none; b=SwhMnV6cgv1Fd9d/4u0KqgxDI4Su0NDM3MQeyStG1w29Qdf4CJ4cfDKprQMazSRt9h1JVlYZ95TxxD0NkCzFk5gDhpCMCoAAnyEUVQHf3whnvbN0uTQvf5FrDT4xcIkpdSXDzbHcYVlTzcskDlaSYE540i4T+21eXmMifiisdS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758239252; c=relaxed/simple;
	bh=Nv+MCiokCy3M+8CTX4vl9JVzgPKppQSAEpsutTt/bIg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iRKpgifoqBd63OiPf8hIWhZOOZXSJ0ePvrQdOIU1MfRPAZPMsEvUjENFobRCYCFIC0QHO0pleiFIwgJpC9gRzXpml0CjkI07N6FKreqDzV63JIdpnn5EtPNB7rJQpwBSXAHEH1ZqOCxrdHt+vCKnEbc1r8vWPuQadZRqFdm3pbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SqeSWjpk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58II1Jvb027149
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 23:47:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	znVREtlVg2TbngpLdOZn/WWH07iDbQ9DOMHKMLM8FN4=; b=SqeSWjpkMm3Gy5sW
	na6Q8e99ogR7PHx9shr3VMU4aXdJZHZQEWxc8nhY4myOHh0BLC4SV4sbQWtoipUC
	q7SRer7yY4cZy6JcpFbfkFc7jLfTlJ+JKCHBRVN2/g94hqDRHXc1Hxw8ya578vGG
	K5h4uVCFG8HDwC3ps5c/0qT8MreqykYOGsZZ9aXoft99kJDWqwogZFQwA3XsOwn0
	wUakVxGSuJx3qomhM04vyVttkgVMbewHH70s5fchTj5M3796PBtQEqmoH083TXEe
	ZQ7Yx14m2h6O/rDvYyuZylnSpQZyMCygmAhTKxb2x/wycotNCZnaGN6UzcMvxxPB
	BtMlIQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxt8eb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 23:47:30 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24ced7cfa07so14219325ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 16:47:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758239250; x=1758844050;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=znVREtlVg2TbngpLdOZn/WWH07iDbQ9DOMHKMLM8FN4=;
        b=qg/PVi29GO32ECHkwB/+dzXFczofHTJ/+tqzz6mpoBN0owKjsGaXUe9lyn3HCWDrTa
         ymtH6GhtnpbS7l6jT9Q/TFgtaSmbswH0Em22JUVl94Qnwhr35ZPSivxf5AOlAbQrYnHS
         QsY9DaZRZmvNjayNeCKY9rHFse4bv2ZNG99jEP44Y06TDHGUm6tAETBSy5q5di4VVFDA
         D+PMsjouXctmvGBPPj6hOapamRv/mCRYd7xGiOpK9EdS7XN9l/DxBGM1ZC2I4nUCOGB9
         oPB7xzqWlmXPMVYV+GFDSAeGhwDTeoeuE8plguDMSgIV3eEdlP8uf0LaKV3njEeoKht7
         xfKA==
X-Forwarded-Encrypted: i=1; AJvYcCVxbQMTlQwAgDQuAAm8dXGInn4tRpp0evXiYvYmYwxETzvCXqHeMPOAsaIIk+SGw3ei8XQd1pfQUinOOI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTPejjEZFV4e4psHzE0N+4S7NHzPNjTsp8pEWCy3FzNKGKjTCZ
	WninDKMBB19705C291NiFiIT/UyN2ccz/B/ZqwVFFQRONPxp6YdUDp+lOEtHGNirENuE29fn7Gc
	Cvziuk2E2H78kt1Gevl7eDqlQPp5eBij0OiJcVD0xLn2KbmyJcECFz92fjdO6vE5R6H0=
X-Gm-Gg: ASbGnctY7fkzt/FVuqijOX5MhSpmz8M1UvKsmNf3pSDgmmJVme51SKyIlvKUyldhww8
	euAzdBGJABdTCfHbvIttPoKwkD+dw+JlFmuzSvI+ppeMYOlRxktIGIChi81k3FaXnRcqye8HMnl
	ZxJHJPc8Q6zJMRKKL2ckj6cPwyCQQ1Dfu2jh4EIj1nRbvxMAjLTvhI/RD7E8cuygxNavxK/pYR1
	lGJ+FP7V29z1dWjvxYXEhX7cU0c2MceCGhrPasvcnx3yc2m/7BILfel0lMsgapNQfKrYDbZQhLb
	+D71EEnxDyfi/J+X3bkW/PTbPPA99RTgyKTjxpTeqlIAuEokTLuZ3pzcQWwIbzRycL4ZYk5dq02
	y
X-Received: by 2002:a17:903:1108:b0:267:b1d6:9605 with SMTP id d9443c01a7336-269ba3f9e56mr16342965ad.10.1758239249714;
        Thu, 18 Sep 2025 16:47:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERbqV3wCkjXG3PjyKuXLu4cfZTg5E/48OfLH/KV9hBuTRpyKhpYzz7BhKJc9/AhEvCPV/Yqg==
X-Received: by 2002:a17:903:1108:b0:267:b1d6:9605 with SMTP id d9443c01a7336-269ba3f9e56mr16342815ad.10.1758239249282;
        Thu, 18 Sep 2025 16:47:29 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269aa71c928sm16474705ad.107.2025.09.18.16.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 16:47:28 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>, Kalle Valo <kvalo@kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250811-ath10k-avoid-unnecessary-wait-v1-1-db2deb87c39b@oss.qualcomm.com>
References: <20250811-ath10k-avoid-unnecessary-wait-v1-1-db2deb87c39b@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath10k: avoid unnecessary wait for
 service ready message
Message-Id: <175823924851.3217488.17742065327824732992.b4-ty@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 16:47:28 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: qEIRGh33gwCSI4ioqG0lPomOSFjkpq1d
X-Authority-Analysis: v=2.4 cv=bIMWIO+Z c=1 sm=1 tr=0 ts=68cc9a12 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=JOwH9nCdIS4rS6tIlecA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX1fH6mtWfoy7K
 grW4kS+m/ArRU/3GHaqztOOOwBX2Q3bb6Qt6K3eQZF2k0obxLoV4cRQtULU22ovMTCgYiZh7syz
 T6M3h2BuTWuYeAn/Slr0CV1PQtq0IV94NMzf6A9fBV75KRMbYJPVvnaynj7GYOCcCBGHBWpMCOm
 mlDHyiFFDVhf9thEX6+ZjH2P9xxt5YkvdcKkd57hiU1kB2aRDlTQWTuP41Yu4Qkgrf7XsZBsebR
 McifrYicgvPUp57j99HpMpRR98i9bs5TwhBPbKoSaEaHU0YhWz8//1/9oaCFFXS+GESLHjOMtkT
 8iLkaR5Ue9Nl/dmmvc5UCx2ABJ4k1ccO+o8RPrhcRyBmj3RGw5npB+wIoNoB8ZEcIZXLOVa94zT
 55sbcKcT
X-Proofpoint-ORIG-GUID: qEIRGh33gwCSI4ioqG0lPomOSFjkpq1d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_03,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202


On Mon, 11 Aug 2025 17:26:45 +0800, Baochen Qiang wrote:
> Commit e57b7d62a1b2 ("wifi: ath10k: poll service ready message before
> failing") works around the failure in waiting for the service ready
> message by active polling. Note the polling is triggered after initial
> wait timeout, which means that the wait-till-timeout can not be avoided
> even the message is ready.
> 
> A possible fix is to do polling once before wait as well, however this
> can not handle the race that the message arrives right after polling.
> So the solution is to do periodic polling until timeout.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath10k: avoid unnecessary wait for service ready message
      commit: 51a73f1b2e56b0324b4a3bb8cebc4221b5be4c7a

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>



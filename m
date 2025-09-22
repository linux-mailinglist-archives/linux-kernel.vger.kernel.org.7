Return-Path: <linux-kernel+bounces-827288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 734F4B915A8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39E021665B9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F262FFFA9;
	Mon, 22 Sep 2025 13:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MkiYJgVR"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5227D3D544
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758547062; cv=none; b=o31MrVvVkWzssmBQ9r3aqyKylaV6peh3eoIP9sHqzpR0SKjaAHBY8meWRIEwkYyxacNBXWldIcecImz0waw7P16Z237z//PIAxmz8JTWnIZHSWQ+LnuEQQwiWY9LKdHXdGH5rrusKDmGYg+5AcpS/GEmDqwub9UhqroRG/vrQ7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758547062; c=relaxed/simple;
	bh=cd/+b49O1n7SbTNaNWcrWFsVrS7EIcr5G7uqfnlT5jM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OfDs58tH/GmnWbdOdewrwJLuSLBwzGFKzyvCtkUel5rn8NyaHRqSLVZo3M4pCbC5uh30aPfpBqUOowj9Ye6QAUVf0/DHqPnpCLs5OCO55xCbNiiF08Ii++amVv16UY0uiquZJeJPjGUhNmsWNkgJ+L8aTnq6KwYaWV3rq6Xl/5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MkiYJgVR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M904oq028468;
	Mon, 22 Sep 2025 13:17:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cd/+b49O1n7SbTNaNWcrWFsVrS7EIcr5G7uqfnlT5jM=; b=MkiYJgVRF4Q9lw6k
	3sZ8cKDLwOld3cBEvIvMIqCDFd74QxTra91ciLVwz6by7TWbSgnE7xTipJfuq3nW
	ciZef3tQGB/4XbUPj3p752mkytFU8ZcizmN6ENPCQr+hUh3Jw7GSG76DluAujsUG
	r3RT6JtYrEi3JL650/kO/cW0BuRvkzTMkGBgROag0DI9o08et2jMHnBn0jjAbYDS
	u9BMLbHNtT411zCp8FB6eCcLrSvYstrYbRxP1c7ZH9InfjeEtfLL7xvBkt2pN/7s
	AG/TUfEe1kA5kxbQDbKTNANNU5QvrZvpJ5L75fvbcIei/05MAQz5TFezkG1TmyTF
	QjG5WQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499mn7cudu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 13:17:35 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58MDHZNk021149
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 13:17:35 GMT
Received: from hu-ckantibh-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Mon, 22 Sep 2025 06:17:33 -0700
From: Sanjay Chitroda <quic_ckantibh@quicinc.com>
To: <linux-kernel@vger.kernel.org>, <andrii@kernel.org>
CC: <quic_ckantibh@quicinc.com>, <sanjayembeddese@gmail.com>
Subject: Re: [PATCH] libbpf: increase probe_name buffer size to avoid format-truncation
Date: Mon, 22 Sep 2025 18:47:25 +0530
Message-ID: <20250922131725.378691-1-quic_ckantibh@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAEf4BzbM+mG5EYQKdp1r4mntP2bXTb-KgJWg4ir6zzrSRrQURA () mail ! gmail ! com>
References: <CAEf4BzbM+mG5EYQKdp1r4mntP2bXTb-KgJWg4ir6zzrSRrQURA () mail ! gmail ! com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzMyBTYWx0ZWRfX5y/anbEbg44C
 AD8BuUTZ/epSLLFU6GxqGhLuM6YaUFYjUiVxVI4/wh5wCdGxolkfASFFiw1yMHseSip1frQ0eDY
 /Ma1vgWeeM0eHSAT1CfIp4FwsDJkevqmif5cnUttSbAf028YaOIDcIrZ3N7p/LUdf3r4LR3V4mU
 2wDlDhcYcXWg7iNJozlqy46+0BcCO6deHHAl5HTwl7Fc+Q39UHWwfxS+jsObNJWiIbqMTWTm7hn
 4aaWISXgdprUiGB8u98b7rM2fm9VosYFJj1h+VDGoIkSdZtKJvTkPQVlRE/QM6LqVTDuMhtX63B
 mkMBSLMyc/5gr0X1CxQMV8d6l/bbhZxk5e3xSdeatsi/SL8mYOxvXIRHMMA3yfBW69CXHcl6Lwz
 wA+RgHFb
X-Proofpoint-GUID: CMq1puTU7p9PH4mn3vA7hHG_-jlTGKss
X-Proofpoint-ORIG-GUID: CMq1puTU7p9PH4mn3vA7hHG_-jlTGKss
X-Authority-Analysis: v=2.4 cv=EZrIQOmC c=1 sm=1 tr=0 ts=68d14c70 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=yJojWOMRYYMA:10 a=NEAV23lmAAAA:8 a=LeRpRGh6yfgUX0Gnmp8A:9
 a=TfFxjrhefX8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200033

Yes, This is due to GCC being overly aggressive with its warning.
Also, Here is regression commit:
https://github.com/torvalds/linux/commit/4dde20b1aa85d69c4281eaac9a7cf



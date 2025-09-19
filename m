Return-Path: <linux-kernel+bounces-824560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D70CEB898C8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3A9D1C83CD7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 12:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D261E222580;
	Fri, 19 Sep 2025 12:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Qvq4w+58"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E6E1E47A3
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 12:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758286440; cv=none; b=T2SPOiVKrr/kWQJ7bM7aav5ARiAlxP2qcKhX80CT71P07l/5SgOfuvQkYbfmgog9Izrpw+EOF9RDKJmu66ZG6v1gEB7Hv/aV3jVZLsmHmxZE5PuE5Vn5CkMU55vXTAGgVkmG97wXZ8QtkCC/gZNcixZ38w+c7AAdoohUH0D+yqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758286440; c=relaxed/simple;
	bh=cd/+b49O1n7SbTNaNWcrWFsVrS7EIcr5G7uqfnlT5jM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LecO979hubuqBJ6Og3WXpbRPq31NVnws0HUCX68Gox83SQ3YyMrE82o4Kd8RkTyuO36Cdk73EHdLfIyKccorYnKEuL1BaLRqshgPoxTEqslxYukjn9hBV/Ogwo6ZdvIFaAwgTuAR6mkpZL/Y2pennTniXMG6JqbcAxb6tLSJbUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Qvq4w+58; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58J9i4TZ007556
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 12:53:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cd/+b49O1n7SbTNaNWcrWFsVrS7EIcr5G7uqfnlT5jM=; b=Qvq4w+58TTDFyu4k
	fS/FNA92Ff6RSioAbCFg5crhyjzsq1PAm7q63oK/hcMZwt21oTP7oRp/raAI+SqV
	nRs9qIqgrKjFmw0qjSv1KkJmC4q1KjAVw3/5qwKBA/54Tn+dtGhIhQJK3CYNEUOd
	smfHH+huKXBuJrmYjPmTDeml9z+iBb7U7OIv9XD7x4aMngVgZL/qxw/f0WWUQlWB
	CDOrkDCUlwQP16HHBqUoddQ7C+nGXvKLMqWVTgBj1UfxyWgwirv0IhwwWg4WsjJF
	+Jv+cYNLJHDM0c2MEKxbRqklH6/jPirnzWzY90UxoXY/20ox/QvA9Gne8NIVYZqk
	TJValQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 498ebevy3b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 12:53:57 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58JCruoR013586
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 12:53:57 GMT
Received: from hu-ckantibh-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Fri, 19 Sep 2025 05:53:55 -0700
From: Sanjay Chitroda <quic_ckantibh@quicinc.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] libbpf: increase probe_name buffer size to avoid format-truncation
Date: Fri, 19 Sep 2025 18:23:47 +0530
Message-ID: <20250919125347.2607229-1-quic_ckantibh@quicinc.com>
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
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UhhnyHBIvxnmf2ChJ3qNIOZdqGJ9r0FQ
X-Authority-Analysis: v=2.4 cv=H6/bw/Yi c=1 sm=1 tr=0 ts=68cd5265 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=yJojWOMRYYMA:10 a=NEAV23lmAAAA:8 a=LeRpRGh6yfgUX0Gnmp8A:9
 a=TfFxjrhefX8A:10
X-Proofpoint-GUID: UhhnyHBIvxnmf2ChJ3qNIOZdqGJ9r0FQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE4MDA3NCBTYWx0ZWRfX9Vd68Aka3mnX
 HSn1PPmClekst0R6ypzfG/zQrhEeP92rLx+6/Tr4LhDL1i0tcfFcsm+W/zTJ1BfTtPBZ7ogjsny
 LZl+cDaJzlOAofHEFLK2t5kuXsVEiKhU2Vrq9kIfPTt+LpWMRAcL/oj3uDoZwf49AYfaGAZt4oB
 Mc2cnrl+Yr8KZ0bTPdBEIdTc4N3Byo7AQufRx5SV7q5ZMCok/bGqybT+KsGpvo4qCq4JUES+F9u
 FYaFcgPkyh1/IPVZUMaUtbW0CdjTTOkYs0xL/E6hkwV3J99NBcxQ6tq6BOGHvl2fiemNJlb3JWm
 RQJDjUNnPio2zuBngGcV5EeJ/kX5TevF11Z87KgSOQbAvUubeDppC6clFRerDQDf1NRbHHIDl7X
 6Ck8JM+5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509180074

Yes, This is due to GCC being overly aggressive with its warning.
Also, Here is regression commit:
https://github.com/torvalds/linux/commit/4dde20b1aa85d69c4281eaac9a7cf



Return-Path: <linux-kernel+bounces-827845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 854F7B9340D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 22:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 227483AD035
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 20:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DE0279334;
	Mon, 22 Sep 2025 20:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dg6HGniu"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C9826560A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 20:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758573788; cv=none; b=q57iUQJeuwSCU+jjYr1EL1ZFY4xj62RehP7sLPpD0a72WOgBb59Au7UQp067WnaCBWPctkrp/X88g4VdZKrSmzD/pr/VUUBdxzaoRYxBw/x6f0Seno2FDjrAcsjk/xh4lZM/RloFZ2lsGpVR/Zf+VGJqjXDTbwEowRwPzJnflf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758573788; c=relaxed/simple;
	bh=ibSnc5EcRPBlcLr5NtFCqj2PtCG3lWg+ziU5Fbo7dXg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Lt6nW+Z3QZhT5sudSawpxQx/sv7kFr/pKm330TLi3asodBx5bAnkGqJZjIIcXqjTs2AS1LcNirg+L5vsgkO6EHLGGBDqZoG83vgYkbHJfmkVntZekOIHbIt8OtUkWYiPSYLzqo7UdUlJ7U7BUGZWgOG1u9EYm9insO8EDA0Dwnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Dg6HGniu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58MHZTjO008218
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 20:43:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PiEv48j5rWcaAqxNJGzE/96rwguoW5QgNkq7JH6PInI=; b=Dg6HGniuAFPpZpd0
	9Opv2Xsco/IP+PSOQoRyjkrQ3jXbUGBE0TK4VlJ4HrijiPil0Qy9Elj8iStERSYR
	t3BLB0IQXOMuvbLGXUNo9yotAGvYZFxCLYwoBF82pbTcbSjeFcSfFGaU4CRfuvaZ
	+jHToQqG3azzwC5hu620B9CltYjqOvDs9vn789nmrTq1L67r7Yaucudn4/0Vz0Iu
	Ovn8fFd7m6bUBFmqpZMOtsZ0cuQFdEVHK+eSDZPmARkpKM4Ec88uQdMrNuWdf4uc
	ZDbeR1eibvln+0i8LmY7wVudm9oDGmv7fxSlwnj8x6R4iCpf9XSmdTbuQlSidAc4
	f0F7EA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bb07gggb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 20:43:06 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3307af9b595so3307169a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:43:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758573785; x=1759178585;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PiEv48j5rWcaAqxNJGzE/96rwguoW5QgNkq7JH6PInI=;
        b=NSpBAkQ8uhxiaTGwo6sU55RWP+lLFJJym/h9eyI8PPBzigNz1ra4eumPrcNy87QLvb
         K5qGTQ5mGR8Xq6EnpaDWfXvfuD6M7XSUZnVsC5lSyalVd0i9SYm8VsTnMTRYIJUxd7mp
         yTxt1DaI0aiP8u6rH3fsGxBxFBau2fcznhYjRFEgsvuUub8QxygRqMtIcwTrof+MGK9s
         AcMQWhPEy3GHNXfEr+urEHsujHVsfnCIEi1YUJT5CzgrGi4CYkwdnm9htsxKuUczq7f4
         qz32EG7ykVk3YcWohzl7L573IGQxGhonV0wL3VYQwdrj7/sl69wHv4TD8S5xQmp8kc3u
         pnlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWB9fvyWsmVt0B/LFQd3N33OvETQTMWJ0VaFVfIwwSwIv36ILSjvcF/bnvivLr2FWBKR8VrhM1rgY/Nu84=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBLuEjtlyP/sDUvkFDNWXkd7vhq8A7yNIAxko8wBh5AMzuClob
	IiYFLuAJ1MKVkVxqfZ95tOpKnGwTddnjqhVqlWuS6ZHsZ+H9X4WJOWULLrHN02gflktEsQKnUyq
	vjh3UzeIXKZkZpDKuXJC+qZVCtpAIQ80ulJ0HTIWw7H7c3WY+DsRVk2cauCdn1to+vsQWUWEdtZ
	Q=
X-Gm-Gg: ASbGncvKK50LzIf8UAfXA5j3NH3qqTcYnlk1GI64IezvgehMtz7xCIDcZg1B62Ykx6f
	KUmKeXrxUQn+yzc2canWrGfLUjwYoAad/mhxQQpvwAbgcDc5Gd+eWj9XpbVjG/MOiAM9K5WEPgA
	MPUQJzcDh5gOULufxQ7eVMXCGgyHnMciZIdd2da0ojTHf/nzNgWQB73wy+wyqrBRkJsbZifPhtf
	zOoRewodhXyx70+4Gbc4bR6sJXkoXLk6ElQLtfX9a2Yf3QEoryeRa07vttD8ioKyaBIfu0teJBM
	5lnfxoVQtK4/shnODq0un4812LBc5CWxAGAjmkvErf45vSj/XzNeJWRKwW0q58nh01gGidvr+L2
	v
X-Received: by 2002:a17:902:e84d:b0:263:ac60:fc41 with SMTP id d9443c01a7336-27cc76e2007mr1508935ad.48.1758573785333;
        Mon, 22 Sep 2025 13:43:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDg5SUvDYpoOi4QrqEmsVu3tSJHlXvWSpdSXO07XSYwVXcsF4lRFp4zQ4axpAHjLd9A8W2DA==
X-Received: by 2002:a17:902:e84d:b0:263:ac60:fc41 with SMTP id d9443c01a7336-27cc76e2007mr1508765ad.48.1758573784942;
        Mon, 22 Sep 2025 13:43:04 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27cc8b251f7sm817935ad.8.2025.09.22.13.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 13:43:04 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Alexander Wilhelm <alexander.wilhelm@westermo.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20250922061607.11543-1-alexander.wilhelm@westermo.com>
References: <20250922061607.11543-1-alexander.wilhelm@westermo.com>
Subject: Re: [PATCH] wifi: ath12k: enforce CPU endian format for all QMI
 data
Message-Id: <175857378428.47334.188951936542723567.b4-ty@oss.qualcomm.com>
Date: Mon, 22 Sep 2025 13:43:04 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=HJnDFptv c=1 sm=1 tr=0 ts=68d1b4da cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=141ELwY65cG9oRu6GBAA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: BPiqDynxmXp9T8Xha8qJn40Lv7RCIsYD
X-Proofpoint-GUID: BPiqDynxmXp9T8Xha8qJn40Lv7RCIsYD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDE3MiBTYWx0ZWRfX2U+5mQqTmXmq
 aNONxZzs2g49CD5sIRaaRfyt+e7XE5q7L9xuERITFSNeLfY1WeFN80gN0Moxf+OCyPh10sY1EZu
 Y/eWaq4vxEMF5a9O9v3AWVLyS7zPPc2EaSvK1ImRtNagpsH3IZImUMe/BeF7IZWW0qLKVZLqWF7
 +vt4aHOepaM6wnfAdC4CbEr7XcKGvYItoFmDGxkrvJFX8sip812zLWcL8PtPsCrQqIjLKdSDYs4
 fMhyAYnR0RwhCEjahOSNo7bhzG3k2RQi4DiQglqJ1m8npMt41nBYix8hzPalVddGW+Ys9QNI4st
 7hLIVnWv7MdYzMefC1uY+ni5/+Fjk2VQ717R+3BvBCqzMydARFIr5vOwvzyN6FVj2oqKm8APPiB
 PSfq9MFm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_04,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 adultscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220172


On Mon, 22 Sep 2025 08:16:06 +0200, Alexander Wilhelm wrote:
> Currently, the QMI interface only works on little endian systems due to how
> it encodes and decodes data. Most QMI related data structures do not use
> endian specific types and are already defined in CPU native order. The
> ath12k specific QMI structs are an exception: they use partially endian
> specific types, which prevents the QMI interface from being extended to
> support big endian systems.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: enforce CPU endian format for all QMI data
      commit: 9eb6f553026e1268a62aa352af38f70fe7d42a46

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>



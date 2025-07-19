Return-Path: <linux-kernel+bounces-737592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72393B0AE23
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 07:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F363E1C40BDE
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 05:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01445221FC9;
	Sat, 19 Jul 2025 05:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="S/TxsSbq"
Received: from outbound.mr.icloud.com (p-west2-cluster1-host5-snip4-10.eps.apple.com [57.103.68.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6C7176AC8
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 05:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.68.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752904226; cv=none; b=T8XY+uyth5bbewBbbHBLhM68z9vLI+cIsUYXBAwp4ltWkTOTkKWTjewTI+Mjlgn5FOGroHNvOGLFka/rzNV9KdGmS92kQlG/5K8U7f3b2c6Ycn34mwO9Vxt0VKJcSNhywJr87+AJXV9UUk78E81LRDvz5dicd2y9TRt1bxMMaFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752904226; c=relaxed/simple;
	bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:Cc:To; b=o0Z9AKIRKgVE6eLp0nOJJB2j5EfMrN1R5jAgYUMrUX5/XYXViDa/Uva9K/GN1kmiCqAsJ9iibLXaDC8LtDg11H7BpDljWueryJVT4HVqhnDqEF+Yp3F6DTzRih029AKwV61nLM4n/1SsFrhmx4JRb8TxbMR/UZ2Q/z3uRlLdlc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=S/TxsSbq; arc=none smtp.client-ip=57.103.68.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-2a-60-percent-1 (Postfix) with ESMTPS id AE7E718000AC;
	Sat, 19 Jul 2025 05:50:22 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=; h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To:x-icloud-hme; b=S/TxsSbqeGSJf9flHaAPnIpX97SAKndQLyNbCyCO7WdJ9ZsOkH94mbR8L61wZ3LnSm+gWWL3uaaOIbAVhAhg9+OU13BmMVw4qonk/MNYPX3KU1N4c123OC8LPuw7NL6zuVGt70rccJjOpHbfEM/u5s2WtAoqiGMAyiXy/TpDMEIxTIydzukgU6lsiLKBwQPLQB8Hf3JDZ0qf7kC9+QB+tOAZODuzq6FDQdZ6SwaZHtEhztlNVq6TjozYnVdLRsURgrddjZM0Kh15PocJQyXfeuZ9RQqhSMNcZ+jHIwKTb1jgCmFkkO1PGbK88fuxBddJ+3zevzqzH7U8e59ELmlnjg==
Received: from smtpclient.apple (mr-asmtp-me-k8s.p00.prod.me.com [17.57.152.38])
	by p00-icloudmta-asmtp-us-west-2a-60-percent-1 (Postfix) with ESMTPSA id 7EDE9180018E;
	Sat, 19 Jul 2025 05:50:21 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Logan Matthews <matthews_logan@icloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Sat, 19 Jul 2025 15:50:07 +1000
Subject: Re: [tip: x86/urgent] cacheinfo: Allocate memory during CPU hotplug if not done from the primary CPU
Message-Id: <9793089C-DC0B-45C8-8E2A-51A1AB89D486@icloud.com>
Cc: #@tip-bot2.tec.linutronix.de, 6.3+@tip-bot2.tec.linutronix.de,
 aherrmann@suse.de, bp@alien8.de, linux-kernel@vger.kernel.org,
 linux-tip-commits@vger.kernel.org, nik.borisov@suse.com,
 ricardo.neri-calderon@linux.intel.com, rrendec@redhat.com,
 stable@vger.kernel.org, sudeep.holla@arm.com, x86@kernel.org
To: tip-bot2@linutronix.de
X-Mailer: iPhone Mail (22F76)
X-Proofpoint-ORIG-GUID: l9VyhONhGYzhs8Wyjb5icWg2FVHGtFKd
X-Proofpoint-GUID: l9VyhONhGYzhs8Wyjb5icWg2FVHGtFKd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE5MDA1NSBTYWx0ZWRfXxEbN+IAhz12s
 eIZZCooizB8n75AozvXdkVqdWMCH9ewsJsQxGjpmScNbcJJJr06Gpj9nUSoDdh6sJyx/owdVFdq
 2FLlDELSI3PnTp34XU2xkbylZViTtieJ+XzyXngHOOvmk1yCXxwZ5Ev9jehfUGSPS1yTpaZ8VMt
 vHRE8coRqOe7in8Zq3f3sggQDcGdB0N2Aas7hmF07jvWfVWDXdlKpzI55rFTiOuLPBfDrYM805e
 FYlaaULSA0X4wpeJ5BwnvWg4aqGm7qJRFo5mhEJXcUum1gw2ZXSVTNlKkGUxf7HDU8sjZ2SYU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-19_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=993 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2507190055


Sent from my iPhone


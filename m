Return-Path: <linux-kernel+bounces-813157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C02FB5414B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 05:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E431AA0B82
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 03:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006C826B95B;
	Fri, 12 Sep 2025 03:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TF7xVJPl"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF113398B
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757649414; cv=none; b=pBKey56VLo6McAp4chKe5p0h0F/EeB4I68StKxqm0XgqD9ZGzXBZjPEswPr4cE4+7DdgRUO6KVmXdJeKjlnYOOnVGkbcaKWmvuQ1Hg9jbmyjzSLRyyOjbh+xfSlKHULWjQuvc35fbzYOUQ/XvxRjL7lZOqePYPDS6VXszJdJchA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757649414; c=relaxed/simple;
	bh=5lhh0x+oSCtKy78BQ7SPZwtdIG85NmhLf67+BBHezk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oN5XJzJ/9JGxPWZN28XrrhGFja6vtc9z43D/POc2Q23eIPFcncVuoAqBa7QV7j7iT4lUTJ1CRwLXxJsKBHoezMSYWm2yIAAcmhjJwlGYWYO/vG9y4bXfejPPd0HTYlq0YwT6/lKuDG0LoImDCcgLl6dtyFdLv8dKCCb92v7K81k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TF7xVJPl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BKDKol028671;
	Fri, 12 Sep 2025 03:56:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vrrVEH
	8tAjFNV3upvm/jC7WnGRQXBkPj0N1pG029RZU=; b=TF7xVJPl8gH9vJ4D5E7RZy
	+J4SUEnmPOFZtFMKGTNZ8ZmCGa7Hg5Hqk1kngguLOYw5bwDGx/Q4jZnuENgs1avX
	QR9nw5fbdJu9g0Ksw4QwKMAnvdjbazZZHQ2cIGQje893Eru1T2DiOpfshB2fg03G
	vRgTerj+HPAf9uZVndcnTJbuBNuFe6TJpACRyDNjEVu9E3wRd4ijVAzlZ94kl51B
	kJdoh/fRqmnj377NwpaqFqOn8cvi6EfRnl0qc4SuAeMTkPvtwuwe58F4O2jmQkXS
	MSKxIaK40C7apzvHjjQVQB/YYN7ckL8PH0mUQPCJ6qVGeJuoixxZRsbGlHtA/IVg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490xyddtqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 03:56:27 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58C3uRaF019098;
	Fri, 12 Sep 2025 03:56:27 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490xyddtqf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 03:56:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58C1LvD8007912;
	Fri, 12 Sep 2025 03:56:25 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49109q11e7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 03:56:25 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58C3uN4H39649644
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 03:56:24 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C9BA52004B;
	Fri, 12 Sep 2025 03:56:23 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A0C0A2004D;
	Fri, 12 Sep 2025 03:56:21 +0000 (GMT)
Received: from li-c439904c-24ed-11b2-a85c-b284a6847472.in.ibm.com (unknown [9.98.111.108])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Sep 2025 03:56:21 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Geoff Levand <geoff@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thorsten Blum <thorsten.blum@linux.dev>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/ps3: Use str_write_read() in ps3stor_read_write_sectors()
Date: Fri, 12 Sep 2025 09:26:20 +0530
Message-ID: <175764920912.610338.11006366512834680585.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250819165829.714344-2-thorsten.blum@linux.dev>
References: <20250819165829.714344-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CcvW4kbXSzDPVuoHyqqRjJzI-R7--lWL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDIzNSBTYWx0ZWRfX+rpKQNEpkmw5
 Ttpvx5SDDmADyJooRUJVENpesLoFBJ5qlozqjJevfSKge+xVFsM/r9RzomJuqt+JVqXYY0CnNkQ
 eTXIrQVzvs6sr5b2aiyuJPKsHMe9Z/5ZlrLHYvuCQNhWfOtxy/cD25qWbQd+RCIBi6zJlTtCosw
 hJtptjlBjbqi79IJFAonx7E3v9IyNG1YkVQwUgZtRoDmBJEiXtldTLWcEX5A6keob6PtVvd6fm/
 JRbfBoOBZTRS6FedbAnfjdqssVeAbfv276TmwkDgvHPlV8b0WYaNuwp+yXrLinkvMriyd580/Lv
 JArGlnSRfNBrbVF+APeRcPC7QV+27Twynb89tHxefquGnNVhfRb7AeEkczx93A9oDQXFxPstkFC
 tfG8RwtL
X-Proofpoint-GUID: -ZSTadxp-uBK_BYyzehJEhm3LmdZs_0V
X-Authority-Analysis: v=2.4 cv=F59XdrhN c=1 sm=1 tr=0 ts=68c399eb cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=CSAOVHq4OqcpjwAznNoA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1011
 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060235

On Tue, 19 Aug 2025 18:58:29 +0200, Thorsten Blum wrote:
> Remove hard-coded strings by using the str_write_read() helper function
> and silence the following Coccinelle/coccicheck warning reported by
> string_choices.cocci:
> 
>   opportunity for str_write_read(write)
> 
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/ps3: Use str_write_read() in ps3stor_read_write_sectors()
      https://git.kernel.org/powerpc/c/6dc5d0770dc99d6bf9b786fa3c8fc04be2091648

Thanks


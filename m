Return-Path: <linux-kernel+bounces-813155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A59B54148
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 05:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0D807B8B42
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 03:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EEF26A1CC;
	Fri, 12 Sep 2025 03:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ApPEAEm5"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B441267F58
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757649386; cv=none; b=oNiype+UkMktvxsu/MKFbEw9yc+IJ1g9bsLi+ArCLDm8amKvrXKLnd0EJeCcQq63QW7ganjdBB5wyHaKKMaCadOhc3Rj+IuheD2Ejkqiu7QGMvjXoTzKUAwrn5bLNC4CoJzjCD6Yh0SpCcwutVenQ/pM2Oq3/z4MMPo/g+qk3hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757649386; c=relaxed/simple;
	bh=WpZX2LTLCMceSennRQb7MB2lKtp3qvBdDiH6BiZGoBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ANz6yN8ieXkDZWcOxrKgPOuIfAYhcyD+LWoHP0AEEtuFxHdhbl2jbU5VsXUEuixaAJ6tT96gPtvF5Qw3CSAY0cZdS0LtItVpqa1SVuSRElBlf8yLD2i6sQlDya49FqNJQDSvZ5cluLMAQYCYqBjgxqLKkbsJeqxs6swipg+O0o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ApPEAEm5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BMeoHp018908;
	Fri, 12 Sep 2025 03:56:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=iYt45r
	imt6jxKj1XBawMJJWpGpQDXdhAnHOcZ+vKLNI=; b=ApPEAEm5bZB0qH550eujsN
	Bvv1F9YjtfEGrLu7YQ3K4bmHAOKjQ1V/Um4pM6DOit6STUhQiKmkrHAKxi3GmZp1
	tH4lR+llaZRQVrGv/jlXUhATVHHBS/sOSYvxlTNGqt9Ee4hSuSs1E5d9qqACtleo
	lvSg1GDLYTG+TAaN6FkZBRVB12v39PuH9xsObc9MQ52JFBB7Uf4avoBamRP9U4ja
	y0daOBo3Vw0tzeJfimLZ5yV5cfXiyrpRtleb2q1LQ9qLCXFpkS3IyFPwHEQ41F3u
	n2GZahNayJFzjNwx+pgNaHj4v5T/HPmgE4R423epU2PflZO/w8HeXQQF5Qw9qMww
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490acrfwg2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 03:56:11 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58C3uBDw021477;
	Fri, 12 Sep 2025 03:56:11 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490acrfwg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 03:56:11 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58C2gJxW017181;
	Fri, 12 Sep 2025 03:56:10 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4911gmru4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 03:56:10 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58C3u82b47710466
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 03:56:08 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91A7320043;
	Fri, 12 Sep 2025 03:56:08 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C9C4920040;
	Fri, 12 Sep 2025 03:56:06 +0000 (GMT)
Received: from li-c439904c-24ed-11b2-a85c-b284a6847472.in.ibm.com (unknown [9.98.111.108])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Sep 2025 03:56:06 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        Gautam Menghani <gautam@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: Remove duplicate definition for ppc_msgsnd_sync()
Date: Fri, 12 Sep 2025 09:26:05 +0530
Message-ID: <175764920913.610338.11505927926333703885.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250813122319.62278-1-gautam@linux.ibm.com>
References: <20250813122319.62278-1-gautam@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yvWXTBQ_eBcfBLNY07ZcF0htEa8MZV-y
X-Authority-Analysis: v=2.4 cv=Mp1S63ae c=1 sm=1 tr=0 ts=68c399db cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=oY5UqJ9XbCPhir_Of8QA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: oyHKm9i5Jz2c7X0QRtUeMnecVx3t_6Bm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAwMCBTYWx0ZWRfX3LmXBJ+y9bab
 eJuEe5VeyYu/XQHhL4ZflDGcNgMrU2cRKqkTODJgZWzgogJfVfgRLeORbsXqxXgpykqJVh/8bmA
 Rin6PiH7GvdQDYYuYkjvH3SCvZK8hGjdVdF5zWkeeioQtTi18hrrd5XdGMIEbuuNBhPj4lm/nNI
 Y8DwceQ5/5ZknvxubKImvBBgv7NEQyEXKqNo88CSvE9nOU0DgbIwDtW7CMsc/gsAhOYA/jvLf9c
 AIb3EIS5MXT0KytIvpqimxTdqkL7zVJIa6S7SqFKevHU06m5atVMuc2Sg1pwgGXyemrHTnzjnC1
 HMC7iWAP7mHqiBAMaIZ6iH/lh86puEjC2yypo9RqqoPLlIUCw26WiD2fwSoE/PJ0NNNgrJeM4PQ
 WYkinLDM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060000

On Wed, 13 Aug 2025 17:53:18 +0530, Gautam Menghani wrote:
> Remove duplicate definition of ppc_msgsnd_sync() introduced in commit
> b87ac0218355 ('powerpc: Introduce msgsnd/doorbell barrier primitives').
> 
> No functional change intended.
> 
> 

Applied to powerpc/next.

[1/1] powerpc: Remove duplicate definition for ppc_msgsnd_sync()
      https://git.kernel.org/powerpc/c/b034baff11d050dd314d5f2645eb52988a93e4a1

Thanks


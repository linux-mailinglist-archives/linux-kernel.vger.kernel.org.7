Return-Path: <linux-kernel+bounces-643600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2209CAB2F34
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 07:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5E621895847
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 05:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B028725523D;
	Mon, 12 May 2025 05:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cYZHNKPR"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9973B3D76
	for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 05:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747029383; cv=none; b=R0A4OsSNBGlTlZ7pLPm7n2iRAniLdHzEQsOEL9D2wq+WX7tM1sDvZX/kHtqCLsQpxOc7480BS9iAHznsI/tFRrjjIZ5of3PNRhcl6yrjWJAS1vcRcasPHmvqmjA7/5+KkbpCrfmIcvI1VD+50LzyaFGUghR8p2vDuyDgcDyW/i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747029383; c=relaxed/simple;
	bh=Ne/RJyqB+WZ/oZKbI1ydKl8xRpgv3LqrMv+pDtRXe/M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pM0QLlRygCTfgsAgYB1N1dhTzE30cFncS3n7HQqt8VLJ1JPjiY3+PrTL4qfdmasW0hJsY3vviEBc6FD8srSuLiMIuyxeS2WIk19GbZbfZzHrlQSPT4ZXbm1C1TgefW6uQr/l9yT5lSDD0QQdT766poZTwgC12uJwWUpQ0lR9dcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cYZHNKPR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54BIsxvG017744;
	Mon, 12 May 2025 05:55:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/HZBne
	Fh885hFHtK+mIFsmXRT5LG1VxJtuXyYUQ6Rvg=; b=cYZHNKPRQY/5iOvCivKtb2
	dd/VMS1tCZKuOeFJHecJQv/vZU+28Z5p02TtRxWLFQWfgGGcPsDXlnUCEcfcm+vs
	2aSdTYhZOdN/Ih84tmYodBA/joVpfKFRgISh8kKi6G+ke60huL0NnWbCkTmGpdpN
	oGN9MOgiylneV3APiC5UYhNhKkxcnpljNhuEEdzqrJjzWYG7YYHxMJ6srPMI30yd
	SNKWHdZhMkQt+TG0nMtVoij9A025EDcyZX8LmzhfMASCQsAp3ilumrgovw0Dua0U
	sY5ztlhnYSC6vcRAoDfLWWWuu993jRukJBUk5Ri0XvEn/1L4CtlPHsMkjtPn96PA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46k1k6hjt1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 05:55:40 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54C1YAjE011591;
	Mon, 12 May 2025 05:55:40 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46jku24867-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 05:55:40 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54C5tbcg54133184
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 May 2025 05:55:38 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6368E20175;
	Mon, 12 May 2025 05:05:12 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF62520171;
	Mon, 12 May 2025 05:05:11 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.63.197.14])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 May 2025 05:05:11 +0000 (GMT)
Received: from jarvis.ozlabs.ibm.com (haven.au.ibm.com [9.63.198.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 4DBF06057F;
	Mon, 12 May 2025 15:05:08 +1000 (AEST)
Message-ID: <7f40b03a926145e79c060f5a0cfdab829b2a5f1c.camel@linux.ibm.com>
Subject: Re: [PATCH v14 00/11] Support page table check on PowerPC
From: Andrew Donnellan <ajd@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org,
        maddy@linux.ibm.com
Cc: x86@kernel.org, linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        pasha.tatashin@soleen.com, sweettea-kernel@dorminy.me,
        christophe.leroy@csgroup.eu
Date: Mon, 12 May 2025 15:04:55 +1000
In-Reply-To: <20250411054354.511145-1-ajd@linux.ibm.com>
References: <20250411054354.511145-1-ajd@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=dNSmmPZb c=1 sm=1 tr=0 ts=68218d5c cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=VlGTkuFJ5WdtLxIKyCAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: BEhtyqcew9NhysJzzJPiJH-Y-nhqpckr
X-Proofpoint-ORIG-GUID: BEhtyqcew9NhysJzzJPiJH-Y-nhqpckr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDA1MiBTYWx0ZWRfXxkgdbtEmf1nz dwd7yYAc5Bva+GTN20ZcaaRJI8dRBGYqlLgSgKVPxDqPaR6nHfb8HftYw/MUT5Pccf9AOHh+lXm Q2he+N8skgs1knm9yr1SAniMXxWCEQptEdIyRFgofwnKH7Nr65r5FhKvJ5t+WWz0934l5Z0tSXx
 tBO9kzHyy+03JWmDebEltQ0cA1lYhj6PZ+L8R4UBJsehl3Zmloz92oOZ/OBmyEFjB2OUUFpK5Rl g1bOX8IeClFPgllsfpqzZToIVTmXeFfH3VYdhTg8VnVAUuJ6hmP2ygvjHKgKEtqVg1as+SRjpS/ 2bL0qEl5fFyE5HechMx2LuOeZwKveA98APYPOmYvGo9/L36yZEqLjdx2r8tmKXFdxVisOTxvYgw
 Wsrx2E6M6AW3YRzLDj4mxn8pJsIydIwqWdGM+L7EnvZyMDNVB1iB4wq/1SVLvacjZ6dPiz1/
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_01,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 mlxlogscore=953 malwarescore=0
 suspectscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505120052

On Fri, 2025-04-11 at 15:43 +1000, Andrew Donnellan wrote:
> Support page table check on all PowerPC platforms. This works by
> serialising assignments, reassignments and clears of page table
> entries at each level in order to ensure that anonymous mappings
> have at most one writable consumer, and likewise that file-backed
> mappings are not simultaneously also anonymous mappings.
>=20
> In order to support this infrastructure, a number of stubs must be
> defined for all powerpc platforms. Additionally, separate
> set_pte_at()
> and set_pte_at_unchecked(), to allow for internal, uninstrumented
> mappings.
>=20
> (This series was written by Rohan McLure, who has left IBM and is no
> longer
> working on powerpc.)

Anything more we need to get this merged?

Thanks,
--=20
Andrew Donnellan    OzLabs, ADL Canberra
ajd@linux.ibm.com   IBM Australia Limited


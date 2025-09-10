Return-Path: <linux-kernel+bounces-809776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBBBB511EB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B39EB1C81994
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9641A312831;
	Wed, 10 Sep 2025 08:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GgvWlbTH"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA0731196A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 08:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757494650; cv=none; b=XUGbSc4W97NhJCzPaX+N14bVtIZQw0zd6dhc13GYNDLA8ig0T5AtEeLxbrIeG23le1N499NCSJ9zkCK8mKOmBKrjwwvYQoJkqyiz8Lt7tDNvIRT7CQiGiX8+qUKaRpNmYu1X2MMD9xi7VQw7T84UnNzHCnxS50JkgDSPFQapu6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757494650; c=relaxed/simple;
	bh=K6CuNbXh/6H/Gh2D9iJwoMepH5zA9BF1H1uH/YfbI+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cFFIxhZqG3gBs4r9TnTCWz/9mc9ZZZN9pEnH7YYAREQaLrqnu97f07x2tK5NDsZ1v0C/h65e5U86PfjoTNlQFPPs/66hzLWcmlPEbENcmRfz3NCWlHtQsKupN2wQaKFMICDavavCIkDYN6HFhZhvB8Mn24O0AvY9bIjl8adWVqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GgvWlbTH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58A7fFJm010489;
	Wed, 10 Sep 2025 08:57:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ECIEW0
	PGugRg9d1uFzxZma7AlkWVruV3XIpKDi5wbKI=; b=GgvWlbTHQyQCC8P6Ohpq2O
	S3OW2SDO6MaEYqLta7SEoLxvbqlpsCazMmN2BQjAhYkCb4BAB+TbaG2yJEfRoEte
	dKbd0T7+v7TlsJjOKLRQ3CdqqetzWTQkAJOLmu4Sz3WByC59354Gw9sC9QdPhxub
	FVcjChd3VZDj6Q+SQzJl3cnc7f+cfR/ZuQT5pNZfqyDWfAYhogkwqHJLtEkj2u1T
	EqHVMCDcNO85DudY7OzGFG6FsamMm/l67KJ/bS9V1mOKP7l91aETXfaGNgfgpD9I
	XTTe3xjk5JLa8NMyrlbWSxq5lfYBWjyMbt2mvl6752clEnoRRI+L/IwOzHoTCIbQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cffd0hj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 08:57:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58A70fSo017187;
	Wed, 10 Sep 2025 08:57:18 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4911gmfcrv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 08:57:18 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58A8vHPC32637644
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 08:57:17 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 230A32004B;
	Wed, 10 Sep 2025 08:57:17 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5EFD20049;
	Wed, 10 Sep 2025 08:57:16 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.66])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Sep 2025 08:57:16 +0000 (GMT)
Date: Wed, 10 Sep 2025 10:57:15 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton
 <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard
 <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>,
        Christian Borntraeger
 <borntraeger@de.ibm.com>
Subject: Re: [PATCH v1] mm/gup: fix handling of errors from
 arch_make_folio_accessible() in follow_page_pte()
Message-ID: <20250910105715.7f4f8495@p-imbrenda>
In-Reply-To: <1228a0a7-660e-4993-887d-66bc2c37b8f4@redhat.com>
References: <20250908094517.303409-1-david@redhat.com>
	<20250909180757.1114d727@p-imbrenda>
	<1228a0a7-660e-4993-887d-66bc2c37b8f4@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QRrBKBaZ89nXHwCvmJ9dEt-qtRQn2gBd
X-Proofpoint-GUID: QRrBKBaZ89nXHwCvmJ9dEt-qtRQn2gBd
X-Authority-Analysis: v=2.4 cv=EYDIQOmC c=1 sm=1 tr=0 ts=68c13d6f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=20KFwNOVAAAA:8 a=nCIUJmz4GBJYDfQ3j3gA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMCBTYWx0ZWRfX9b9+jsRX4zrI
 BlQMWMK5YlVzA97p2eodgwolIMp/eLO+pHH+HHJZS2VYUKORt2Ibt2r5yYE22ESNd9VYYFb7FVu
 M6NGrV9M1/QFyyLXD0NWhT5pjOBZ23FjYyPdm38n3dRL3kBXTVAudv64vdHWj3oRnksHzKOMo8S
 uz9H8dzH++wQVXvMZIhZjPfwdlaPS5pVFqKHpvj2xRQXwPiQEHcIjkBWU7fROQ9CxtAP386FQwW
 uzXDD8uCqL+PkiySP9tURCz/+cskJ8HKyPmB1bIPsYgnIgZCD6l+OLi2F/5IiFAz2oSafHbgTpI
 PEpIZLQcom1SQlttAtnQBIEEpErwvTxrpBTHSxmJxqsH52PwXW6XUhsP1qcj9xKWUGlF47VqWuJ
 eq6TWflf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060020

On Tue, 9 Sep 2025 18:15:17 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 09.09.25 18:07, Claudio Imbrenda wrote:
> > On Mon,  8 Sep 2025 11:45:17 +0200
> > David Hildenbrand <david@redhat.com> wrote:
> >   
> >> In case we call arch_make_folio_accessible() and it fails, we would
> >> incorrectly return a value that is "!= 0" to the caller, indicating that
> >> we pinned all requested pages and that the caller can keep going.
> >>
> >> follow_page_pte() is not supposed to return error values, but instead
> >> "0" on failure and "1" on success -- we'll clean that up separately.
> >>
> >> In case we return "!= 0", the caller will just keep going pinning
> >> more pages. If we happen to pin a page afterwards, we're in trouble,
> >> because we essentially skipped some pages in the requested range.
> >>
> >> Staring at the arch_make_folio_accessible() implementation on s390x, I
> >> assume it should actually never really fail unless something unexpected
> >> happens (BUG?). So let's not CC stable and just fix common code to do
> >> the right thing.
> >>
> >> Clean up the code a bit now that there is no reason to store the
> >> return value of arch_make_folio_accessible().
> >>
> >> Fixes: f28d43636d6f ("mm/gup/writeback: add callbacks for inaccessible pages")  
> > 
> > Ooops!
> > 
> > thanks for finding and fixing this  
> 
> Thanks! Is my assumption correct that this is not stable material?
> 

your assessment looks correct, an error return value can only be caused
by a bug


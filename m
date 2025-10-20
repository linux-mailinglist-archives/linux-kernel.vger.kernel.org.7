Return-Path: <linux-kernel+bounces-860257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DF2BEFB21
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF3034EDE81
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 07:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3222DECB0;
	Mon, 20 Oct 2025 07:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="f7TXLyY8"
Received: from outbound.pv.icloud.com (p-west1-cluster6-host12-snip4-10.eps.apple.com [57.103.67.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991AC2DCC04
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.67.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760945895; cv=none; b=LhSvgTlG0NDko8Lj9+LzG2Qmu7y+/s6ypBmX1Iua/K373wz13Biimxi2///Sm4ZkgTl1A7amwQfaklWiKFrKnRDs1zqsQIRWnIwIqevLFu9JT+OpFJf0pOcOPnW1rkRMrza1dHPqI9DyvKi0cQf5GSN2Ho59WRSoUT+fhcYFrck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760945895; c=relaxed/simple;
	bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To; b=rDxSjDGJYetFenq15IGhjLm7HQF5UnvueW84wp83L3Fvsbl39+vJyO7Fne9AA8t2MbVSCyuvVoJeP3fmrvQVK2BuiY9O5IC/Zbt8VMg2GsiEvffI5p9tWFUxJJnnq1+awthnvznum7uxTUvwRPqs9AZB1hpdJxq+FFuqFpMRQJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=f7TXLyY8; arc=none smtp.client-ip=57.103.67.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-1a-100-percent-11 (Postfix) with ESMTPS id CAD1F1800127
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:38:11 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=; h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To:x-icloud-hme; b=f7TXLyY8XLx03uwM4GQ6QaTlGJU7iLzXiWBTo7/3riWTFx/3ouRWV8HVbDDiuEe7bdkxHrXlh0Dkn8Y0IzDxIBhkz2mWhV/tYvD5BS8FNc7HTZu1ICc0BjPfFs/dU3DO6rSwtgt+FA6XkvoDjO7YWYMULb4zETHxcsGWhO6N5ZmgMaQcnEk0DQTzgm7r4QnekK8GXt3fEVFvjLWGKEVE2mEe1B75Cqdbi1WjDMTAW4vraWWQCloeHv+2/ebbSdYSVoWyqp/4sih/RrytmYlARxC5qLmEh+/rZsTTrYAwam3InTgcVKweZiwHpHphsEjXyR2iXXWSYjl+Wb/MctvTTg==
Received: from smtpclient.apple (unknown [17.56.9.36])
	by p00-icloudmta-asmtp-us-west-1a-100-percent-11 (Postfix) with ESMTPSA id 3023C18000AA
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:38:11 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Isaac Johnny <ijohnny2025@icloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Mon, 20 Oct 2025 00:38:10 -0700
Subject: Stacks
Message-Id: <AB84F8F2-B8EF-4B6F-B52E-7A81B838EC21@icloud.com>
To: linux-kernel@vger.kernel.org
X-Mailer: iPhone Mail (23B5044l)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIwMDA2MCBTYWx0ZWRfXyj/ggCHk36j9
 I/xSEl68fFhcTuVBwh2+h1s8jOi2VWFdqUtFlIuUWPZIgH5Dew3zbl+UhHbOjn0DKrEfcNTMI7u
 J8zkVoFL2UX3NfAFnfhXFydWsLa8wOaklok1sjqX0VuU3l9s3LCpjJBsW3Zl2FCGlL5/J+I+OeX
 D10H95v1QUpOjGZ3TT7iPyVagRgxnhh7Svhb4w0tP52b9BNCK4CLFF2L/bAf7ucHXf6kL0b1xWW
 PYqbndpg/zhDudzay0/I6ZZrK7ufmBlS92fRsOzY4Qk2MdeO/hCylT/gv+pshr/T8KDncbK8Q=
X-Proofpoint-GUID: BAwN-EgN9nymfPz0mubL-diZoKrAMZJa
X-Proofpoint-ORIG-GUID: BAwN-EgN9nymfPz0mubL-diZoKrAMZJa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0 clxscore=1011
 mlxlogscore=548 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510200060
X-JNJ: AAAAAAABEeyFhItMAg/H/jLUGiFOUEyYHF6jUR8ipAKcdTR4kDFxeUfJ8E7EjVoXwU3buWFFD6ttLfd2ASUX0ALuz5BT1Qc7v3slmQC8SQ7SxgP9PTnSi/AWT6gUnax58sQ2dlJtGX71Fn+qW6n9M6dPe+JpLVarPJbFIIPpn01xXDsFRxUMSVCvz2V5j5ZCvBSfgnJq27tz9K/Mqm5pjetkQ8EJXwcHJaCWMl6Yal+8ZNz1VTkdCoJFCr0GZFeF1CnRstRw2qBs2CG6/9UMxYw19J6xPpmAfwBMT7gtBWwugr/WUZpTeTscV58GovGkPEg/QOnomPo3PGx0E/jVK9aQeGClf3sMQXYnbyYTIKf4mwx6VK2SDHOEpISL71ynClAcIWPILnTO50hRSbyEzGFLLyLUFjnYZWo2aLVq1/BzBBATZuOThTSweP65+xxOMqPJqOelbrOEboL0kAtkEdcumFQGK6OQWjVZDkmXEHVUfBNqt6ChMKGkquW3G2oAMrLUappcxcm7LXQDkKxAepR5PkWv9FD3F+tqfAuwMV73UvQhnXaGh4phOfOqIvKdraVeR1+J+GSd+RwyPjI9DAlO5t9bJEsZ6kPI4azeww==


Sent from my iPhone


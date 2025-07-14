Return-Path: <linux-kernel+bounces-730744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BD5B0492D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 23:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D35904A2B2E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 21:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3701265CD0;
	Mon, 14 Jul 2025 21:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="ZZknCz4K"
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754C72586EF
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 21:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752527433; cv=pass; b=jbfHNsPnrQos4NVOUKBs25oGBFP/2vMZK1eylkDFylE9pjgzBIN/hQ80YwGKw2kTYx+Ml4QUZHwpc0+m+kb33Yu8YqnFpWnAanLHZ4nzWxsHdqu1znAPk985uejhY5xZtPwgMmv3u6E+90GSYAImsDHCOzzYg3SgZnmVI3PceR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752527433; c=relaxed/simple;
	bh=FlPCGOXpDgtPiW4lPj2TA6PQUAwi8mdbVRjjpTBPuR0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Poutwc1eVhb1g5uq8DNVTKC4oPXUhbUY2jR2Wm3hmTfrzhG2Y4lbcjZQu/eMOulLuP6VqU6fco9485acrWYHVEYJ2qxPvtr6CRo8M9q+A6hmj/Ed3bIi59MoG8WEnx0Oq6kXqJNPMJ7JySr137LA/sFqBqMfL4SuB7ygcVodZUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=ZZknCz4K; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1752527391; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Lfsp2zxvrrkMRPzBeWnau+KtdyRIwkVcw5I9vH8NHoCti31rcUTpKy9/MFfSrKKvvfp5iG/P5aoZULhK4veApeEAmV4yoIAZj/Halhn6sWZumz52kc4Z9KphEYItT+Kgv2HaZ4O9bhvDUZmIGDVmqSm1ELi3LaUK0eAaBYPmOkk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752527391; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=FlPCGOXpDgtPiW4lPj2TA6PQUAwi8mdbVRjjpTBPuR0=; 
	b=APBKDacOYmAkjyc2iw0tga3M64NMerrFfpTe4qeK8e28hpgaXaZ57DDD52n/HZBAQvFJzdxQ0d7mVF99rrzjqqblribYwgVacCQ7gX5qdv5fylWTki4Lr6roOZwkmJngWe3bPdU3TnFV9aENlnkSRy1QJNANoo2oCOL4Jgsxxkc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752527391;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=FlPCGOXpDgtPiW4lPj2TA6PQUAwi8mdbVRjjpTBPuR0=;
	b=ZZknCz4KiQpc8hbniMaDG76VNBaUbaPHKXIiY2OzDH4Mjz8fKEUkfYaT/5cZ6eIn
	4vCa54EnW5s2bvOVmn1KGIQ9eSXeJhw6yMSrRJQ9BtHxxXtklBiqumUJH5NdffMLUmH
	Y4oiy68ZoS13gl/FcwcQlzjbxNMm4iZYEymGnfZo=
Received: by mx.zohomail.com with SMTPS id 1752527388118484.9712765408949;
	Mon, 14 Jul 2025 14:09:48 -0700 (PDT)
From: Askar Safin <safinaskar@zohomail.com>
To: feng.tang@linux.alibaba.com
Cc: akpm@linux-foundation.org,
	corbet@lwn.net,
	john.ogness@linutronix.de,
	lance.yang@linux.dev,
	linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	pmladek@suse.com,
	rostedt@goodmis.org
Subject: Re: [PATCH v3 1/5] panic: clean up code for console replay
Date: Tue, 15 Jul 2025 00:09:40 +0300
Message-Id: <20250714210940.12-1-safinaskar@zohomail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250703021004.42328-2-feng.tang@linux.alibaba.com>
References: <20250703021004.42328-2-feng.tang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227006371dcbbbb3d5f4e1e37cf00008e02e526925b0a71a4f431a9cd00c1f28750395002804032f4:zu080112273eac45b97978e99fd0cc3e3a0000757785328aac1237a524ce1d85788e80bdae90810d824298cf:rf0801122cc6dcb225ce6c9b96a2f27584000045616c30fceb3cee9b394da560e8908c99e972711b317417e9935f8f2921:ZohoMail
X-ZohoMailClient: External

I just tested bit 5. It doesn't replay all console messages (i. e. everything printed to /dev/console ).
Instead it merely replays kernel messages (i. e. printk/kmsg).
So, please, rename PANIC_CONSOLE_REPLAY back to PANIC_PRINT_ALL_PRINTK_MSG or possibly to PANIC_KMSG_REPLAY.
And update admin-guide/sysctl/kernel.rst

--
Askar Safin


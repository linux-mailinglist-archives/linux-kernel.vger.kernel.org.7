Return-Path: <linux-kernel+bounces-730990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D29B04D42
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 03:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABD5E4A5D62
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 01:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6091A0BD6;
	Tue, 15 Jul 2025 01:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="RDmqhB6z"
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A8B1990D9
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 01:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752542313; cv=pass; b=ax6cfD5aw2B+wF3z0Y3TkZ5lk8t0uvswKV/W3x3kOswMRVy/CoBVzocTxkDarUknG4MBVvDC0+6fzlE1n1Rcfh1X1S7tIBqK/OD9krncZGpBdlIcuf2N47bF5hPaAW5t5iQYz5YRxs5pexC43dYUkZLVm8GO+ptjsbjox6CkZ88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752542313; c=relaxed/simple;
	bh=src164VYlfYZebs3/5T8qVuVAZeKR2byVQxqAmQ4cDQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=ZUOG5BkWpNmOti8M/pQeOotCtdBYsC/TVV7mxypsG+fO5/lO3uPsckMkwlYO2Ut1nxAb8bQC0SlKQNa8bUvvZGbRadXzeSo2oRzyhp+ozfMRt/WGTrMg3yd0+muDArwShKB+RZoM+YaysK5rxI/bgkU5V6DDmxSEeC9/7cw18qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=RDmqhB6z; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1752542291; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jR0roymRwHJBFgLX8HfW1V9tZyq6RLgTZ++pCPesVHW1woJyMjncw8i5DwD1Cux3AMb+xNnVJ98N1H7+fj5JBIocFK1LWj0lW5K/jfQWk1gu0lsGJAzGTfaUOUrhfluNftbtn1hnXjz952vgQUxfcboUR4jXL5aU+920NhRlt5E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752542291; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=V9cx3wTyHRwcaLJQ/ZzBpjs8YiVrMyghv3hRxD0e5ME=; 
	b=SSslRQXL/Iw6a2Y6XJhxSsq2OQux6I8+k7cXv1C8iss+3QwafubCG8QjKXTQVvpPaElfVozzJsPizUnCCrrDJd6jZWfu5gqYBZbq2XgpIjZyD0TIToqsMSFwS43ERxCsGpuukzGHA9Vcwo0qQi0KmaywA77yJkoLosA72zoMmfs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752542291;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=V9cx3wTyHRwcaLJQ/ZzBpjs8YiVrMyghv3hRxD0e5ME=;
	b=RDmqhB6zzGTsixfxhA5+UXdkRGmeMbwdvPp/15aPJS0lHGCSPhFJRgqANjbmEzD+
	v9jbl/AjA22a3QE3Yu+F3QbISbNgSFFQXuORJ5rBxcUkGNwumTjI/m+18KxaiJTjaNw
	Ombs6/+QBOPd5lbWDuWzPFmK1s738y3/Uszy/3lY=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 17525422905231014.6625550727482; Mon, 14 Jul 2025 18:18:10 -0700 (PDT)
Received: from  [212.73.77.104] by mail.zoho.com
	with HTTP;Mon, 14 Jul 2025 18:18:10 -0700 (PDT)
Date: Tue, 15 Jul 2025 05:18:10 +0400
From: Askar Safin <safinaskar@zohomail.com>
To: "Feng Tang" <feng.tang@linux.alibaba.com>
Cc: "akpm" <akpm@linux-foundation.org>, "corbet" <corbet@lwn.net>,
	"john.ogness" <john.ogness@linutronix.de>,
	"lance.yang" <lance.yang@linux.dev>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"paulmck" <paulmck@kernel.org>, "pmladek" <pmladek@suse.com>,
	"rostedt" <rostedt@goodmis.org>
Message-ID: <1980ba9224c.11f5e5a9635585.8635674808464045994@zohomail.com>
In-Reply-To: <aHWliJhyIZnq97Mm@U-2FWC9VHC-2323.local>
References: <20250703021004.42328-2-feng.tang@linux.alibaba.com>
 <20250714210940.12-1-safinaskar@zohomail.com> <aHWliJhyIZnq97Mm@U-2FWC9VHC-2323.local>
Subject: Re: [PATCH v3 1/5] panic: clean up code for console replay
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Feedback-ID: rr08011227f6076652216946c6b417b32c000065c0bd2fe0297555db1cadbf7ed9b85abc1eeeb24a0174f26c:zu080112278cfe327cb342503e0081607100000a08fcb48951c24d329e22df21e05c4676660b7e4500ba87df:rf0801122b70b6a8d2504f8739f1651d740000932c182295745679464a1a763de074c6f1bc18c3fe116291e93da43ff7:ZohoMail

 ---- On Tue, 15 Jul 2025 04:49:12 +0400  Feng Tang <feng.tang@linux.alibaba.com> wrote --- 
 > Thanks for trying the patch! 
I didn't try it. :) I merely run normal mainline or distro kernel in qemu.

 > My understanding is, 'console' have kind of different meaning in kernel
 > space than just /dev/console. In printk.c, you can see 'console' is
 > used everywhere,  which are mostly bound to kernel message.like
 > console_try_replay_all(), console_flush_all(), console_flush_on_panic(),
 > which are consistent with the new name suggested by Petr.
Okay, I agree.

But I still kindly ask you to revert changes to Documentation/admin-guide/kernel-parameters.txt .
Previous documentation is better.
admin-guide is written for admins, not for kernel developers. And they understand "console" as /dev/console .

I run kernel with panic_print=32 in hope that this will flush console (i. e. /dev/console), because this is how I interpreted
your patched documentation. And I got different effect.

--
Askar Safin
https://types.pl/@safinaskar



Return-Path: <linux-kernel+bounces-731054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B47E9B04DFB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 04:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 023D41AA4844
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 02:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361DF2D0281;
	Tue, 15 Jul 2025 02:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="Y0ne9vgn"
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316CE18C008
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 02:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752547762; cv=pass; b=RlzSwR6RvEPpmTKpdyMAO2xgxISa+MPfC0Capu8uZ2ZicfKSurnnv/QQayLapGw0etzQFcCP4+iDq95WZiO9onMmRVPrexRiNgvFzSFlTiQCdoYbliM5+ZXY5gl4PK+laG/8on1h0VR3+YoqwbRMiti59qODyOiLuCR2za52O18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752547762; c=relaxed/simple;
	bh=oYc1X0zpP3iCx3Ysoc32BzZsufvumAgaFAwXY1GqbMQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=lnQOzNJr3piPoUu1yg5DVuHJhZE1yYEFTcEOcYVWSihEQHFvtoNMglkBFqDAyTyeg12bKrA2yLD4EnRhLbcwo7AOG/FZRV4Yu4/8JUeI3m09pF9Jlg0SJgbULo0XNPWQ6L/tDkibg2mBv12dbKhJ1+ek55mrWT0vD0QKk00MnXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=Y0ne9vgn; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1752547728; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jIMzXuJMRZ+1KghrMBC1Cb0tt9UQC1QUDnFC2bO5D4GDG3J/P2uuycgYPLEk8jdiRDZrgo2hNYNhSLbV6GkhjAALlUSFLKLzMHnTtC/aweqyoHmw/koJxLmJquQmll7VP0WO3jm5FmIxsnNj3Mq6LgOvIPzA1jfxQarF2MdDbKo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752547728; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+MgDqwqQwBOoR7bK8vOjG7Euu2X7RqGSoU+BG4Eb53o=; 
	b=Hmuz+OWenzPQAVzb+x/bLNvTjfJmTOpkUSBwJt5wSfeVsGqTJdz2+5GRqSnhRBp9Qh1/J34mhXLZovEEiSysLxmfVoW8KinQwEvNXynf7R8mdiRTYfAqyIL0dl6oOik95oiNPZqVqGyDhHbwKQfl+Sbzsi6Q2FN7W1tP7w87O30=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752547728;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=+MgDqwqQwBOoR7bK8vOjG7Euu2X7RqGSoU+BG4Eb53o=;
	b=Y0ne9vgnMb5MsMuTYNdBYWnJyNo9h8uhhyppp+LP2rKnsLnSkZF6ktwY9GZwbmei
	+0QGVQVgNCdxPwJgw+2U/8sMQFbflnmre75rQviRMv3AxyOv60ndM0CyWPNsKp1oA8h
	DqHFBim/O6uNvBhKtWabbtUQyZH4UIli6VMM6ICc=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1752547727358849.2634328225116; Mon, 14 Jul 2025 19:48:47 -0700 (PDT)
Received: from  [212.73.77.104] by mail.zoho.com
	with HTTP;Mon, 14 Jul 2025 19:48:47 -0700 (PDT)
Date: Tue, 15 Jul 2025 06:48:47 +0400
From: Askar Safin <safinaskar@zohomail.com>
To: "Feng Tang" <feng.tang@linux.alibaba.com>
Cc: "akpm" <akpm@linux-foundation.org>, "corbet" <corbet@lwn.net>,
	"john.ogness" <john.ogness@linutronix.de>,
	"lance.yang" <lance.yang@linux.dev>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"paulmck" <paulmck@kernel.org>, "pmladek" <pmladek@suse.com>,
	"rostedt" <rostedt@goodmis.org>
Message-ID: <1980bfc17f1.122b80ffe36544.5266293070616137570@zohomail.com>
In-Reply-To: <aHWwL7TdabnGna3D@U-2FWC9VHC-2323.local>
References: <20250703021004.42328-2-feng.tang@linux.alibaba.com>
 <20250714210940.12-1-safinaskar@zohomail.com>
 <aHWliJhyIZnq97Mm@U-2FWC9VHC-2323.local>
 <1980ba9224c.11f5e5a9635585.8635674808464045994@zohomail.com> <aHWwL7TdabnGna3D@U-2FWC9VHC-2323.local>
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
Feedback-ID: rr08011227bd8c9109aa455c9f1b3f9597000003b665c105d8ef2941bd84fb88f2fc99af22b3c3bf00b494be:zu08011227b31be5f31691515d02de013400000536c14eae528b2dc0c7356559cb0ebe2308fe20df0a1f3876:rf0801122bfdbab67235d367eb76eb8dff0000bcd10bf5c8c60368c0a8e9c0c71b63833409e6d78ec8cecfe194b79930:ZohoMail


 ---- On Tue, 15 Jul 2025 05:34:39 +0400  Feng Tang <feng.tang@linux.alibaba.com> wrote --- 
 > I see. How about changing the patch to: 
 > 
 > -            bit 5: print all printk messages in buffer
 > +            bit 5: replay all kernel messages on consoles at the end of panic

Yes, I agree!
--
Askar Safin
https://types.pl/@safinaskar



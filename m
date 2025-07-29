Return-Path: <linux-kernel+bounces-749014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39722B148E5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 09:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CB1A189C9C8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 07:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2C9256C9B;
	Tue, 29 Jul 2025 07:04:45 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E9520D4F9
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 07:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753772684; cv=none; b=tHg9jzAX73CpBR5FXvxxLqjcA5pX+E3nXRbkDvhuzlxBzeqJo7DKkZADJGiGvk8/RyCi+jGpGy8r5gE9WL+W5U7IJZCNSUUYZVXZ9TADEZIk6bVEPSZ1/z0CJNMpPSBUD9o1w0O0intDlH83fdcy2D6hGfvo6/6IV2V9Hgr+4SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753772684; c=relaxed/simple;
	bh=ypACYFIF73oBKhDXdQaMe8VK4thjQwn8/GK8q8L3gEQ=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=i5aXfbuySjkIfF853IrZtr5Vlw7wAHCLXZ7lZjtTOM9UZ8tcxBWeADUbYHIDo7tXPmsBedFry4DJ+5T/mWmkFDVehNxW1oRtaS7wg8KLNquKFoBJuzheSkwQJSPGW+3QEPx+63mromUzaUBMLas1achovvArs1nJP8m9n/aPhQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4brmYV170Qz8Xs7F;
	Tue, 29 Jul 2025 15:04:30 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 56T743HW064439;
	Tue, 29 Jul 2025 15:04:03 +0800 (+08)
	(envelope-from fan.yu9@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 29 Jul 2025 15:04:05 +0800 (CST)
Date: Tue, 29 Jul 2025 15:04:05 +0800 (CST)
X-Zmail-TransId: 2afb68887265479-72614
X-Mailer: Zmail v1.0
Message-ID: <20250729150405008DO4Sb1P2U3KuRwnVi6ep7@zte.com.cn>
In-Reply-To: <878qk8pdkd.ffs@tglx>
References: 202507281624542763Kn377WvUMXlKHVJUdNjA@zte.com.cn,878qk8pdkd.ffs@tglx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <fan.yu9@zte.com.cn>
To: <tglx@linutronix.de>
Cc: <frederic@kernel.org>, <peterz@infradead.org>, <oleg@redhat.com>,
        <brauner@kernel.org>, <iro@zeniv.linux.org.uk>,
        <joel.granados@kernel.org>, <lorenzo.stoakes@oracle.com>,
        <linux-kernel@vger.kernel.org>, <xu.xin16@zte.com.cn>,
        <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBsaW51eC1uZXh0XSBzaWduYWw6IFJlbW92ZSBvdXRkYXRlZCBfX3NlbmRfc2lnbmFsIHJlZmVyZW5jZXMgaW4gIGRvX25vdGlmeV9wYXJlbnQ=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 56T743HW064439
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: fan.yu9@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Tue, 29 Jul 2025 15:04:30 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6888727E.000/4brmYV170Qz8Xs7F

> > From: Fan Yu <fan.yu9@zte.com.cn>
> >
> > The function __send_signal was renamed to __send_signal_locked in
> 
> Just use __send_signal() and __send_signal_locked() which makes it
> entirely clear that this is about functions, so you can spare 'The
> function'. Same for the subject.

I'll use __send_signal() and __send_signal_locked() directly (removing “The function”).

> > commit 157cc18122b4 ("signal: Rename send_signal send_signal_locked"),
> > making the existing comments in do_notify_parent obsolete.
> >
> > This patch removes these outdated references to maintain code clarity
> 
> # git grep 'This patch' Documentation/process/

I'll fix it to avoid “This patch”.

> > -   /*
> > -    * Send with __send_signal as si_pid and si_uid are in the
> > -    * parent's namespaces.
> > -    */
> > +
> 
> Why are you removing the complete comment instead of just renaming the
> stale reference? 
> 
> commit 61e713bdca36 ("signal: Avoid corrupting si_pid and si_uid in
> do_notify_parent") put that comment there for a reason.

Hi tglx,

Thanks for the feedback! I agree that the patch description could be
clearer, and simply removing the comment without updating it was not
the best approach.

The comment exists for a reason, I'll clarify why __send_signal_locked
must be used and improve the description to be more precise.

Best regards,
Fan Yu


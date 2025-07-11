Return-Path: <linux-kernel+bounces-726834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC005B011BA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 05:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 845734807DD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 03:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2345619F121;
	Fri, 11 Jul 2025 03:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="uXYmJqft"
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464DC72624;
	Fri, 11 Jul 2025 03:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752205640; cv=none; b=M48SovoT+Qn1b/3tql8zccwKTVnEdr1UW3d1xo0LLqi4APbfbzcmMGoGvbJWzPxjoj+va3wVcHBzQkNw9W1YhLyWPJeaFbYqmeiOmqrhB9stHizMzcfzqzX7UHAxctu+QlRgsYqt5W6QlUyn9BHaN87XGmrbH3b4M7L8WYw9U0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752205640; c=relaxed/simple;
	bh=Y6oFKZoPOQ2bGJApnJ1Bap8JVv1ttDvRZ05OZN8hiNY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=YVCAEo20i7WGePJbcI/enV4NvxgjxuWLfT0SM1i6b9xHbbuidXb7iaiP02qEKE2puYfMsIAAEn/57f8m1RBEEhYIPdxU/A4gNc319Y1gpIeGi+pZ44jQvfeIyOGnwAUd4M6WbD4dkmzTWAdhBiTkQuVrtf8hp/euL1Up2uB3vhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=uXYmJqft; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1752205602; bh=s7Dbt4pfsqy/SPhJnAXDCha4RAALW+oIC1PJfdRhBTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=uXYmJqftJyFQz/ng4hRNayfjhXCzQsOSIn8TKo/cqhQfgFR3ucfXEXCXonBWDwW8O
	 dOg4p8hoYnKecVxpa7yHTrytJzkB6i+Be0fzAn6CZppBI2P0PsAeBRL0H/kUZT2hC7
	 QOTN4Y/PpDE3SlL0IajtpujZNYmM8PUK2Qt+GDY8=
Received: from VM-222-126-tencentos.localdomain ([14.116.239.37])
	by newxmesmtplogicsvrszc13-1.qq.com (NewEsmtp) with SMTP
	id BA904E56; Fri, 11 Jul 2025 11:46:41 +0800
X-QQ-mid: xmsmtpt1752205601tl8mdbuzy
Message-ID: <tencent_19AE390D05232D1C97E336C05F35A9F1BD05@qq.com>
X-QQ-XMAILINFO: MR/iVh5QLeieMtsBwB1FhwpuHNLvSLjowgQUiVdZ9Vh2W5UefhDYqW5zGpKXbq
	 XmJp4h6FNzkAP+VmWah61YM444QVeGt0b+Vb+2MLZS/V4Bdl5Pz95lNM7k9rIZ+0fjkDCmy6ff79
	 sKMQGGvj9HdAzUbSHp+YWEZmvwlZioRfVIafJ0vN6dElzWksXH0Swy9EmarSGysGW4vQor7gx+dr
	 SoM1kcHFsJr3NtI5cC5XnzVVeatJEW3CtjSwNTEOtsAJLdZ0e8mf6ikPe8S7e/m3TIdeMWG9y4QZ
	 /LTrANDaH/eTzNp4fIDlS7RtxsQUCEzwJ0b8HMTU2SqQEMfOb4pfX/pRhF2SI12HNWPK3W0AqAjF
	 l5u6jPSs4UZTjnp2wkWgF5ma6ItuR3H8ARKvGUKfFdqvztV74PJ0EnBAyd60SVEP/rn4yh9umf0T
	 ba6PhktJzeshLTgDo4QcrX7+bXIEQLDEQB5Uw6V8xrd1l/7hExyKo4IP9eDAhTjuR7PprqwbMlb9
	 YxVx7HPfG6zVAHHLyhihxhKlTm7xmuB1Kd07LNN6JQMLd3oL3tafcM1joJFlK4qkCBwDr9LaQesi
	 AKPmHVwXNSuLb6NDhx2MBqIwuEJXXq2hvbW7ERkmJxXNMf1iX77DRJBvW3Xm2FnLqAlcq7pxWhMA
	 lo1nV/02houjy0d+E0USlo5hSaRZtAW+1KrspBlRZfnMafnWVJnGpRvkJa2VSq0VTgrg9jrJ55zG
	 0K3BJnUxUUKmYx00xR5DM2Cz6PrX8/Q+ZIXbcGxI07jvOVTO+21T7GRgoL600MgAWH5xmpUcEksi
	 7vQC6ngmEzx0fuuMPt9xZm1OxQmEbp7/7j4ykbQdyfdHYYaGToAymMa86oxxqcgRXPHcUMtOmSFj
	 f3lBR/0pQGB2ihKlWl1RxfmqZeoH8aPPxW/LPpaf7MYGsaoEqVAFr3XvSIuV1OBZP2fhtHnjqua/
	 5WK+ix4njdJnC46MuNtaY5g6vuj8X2j87ai28PhcxDBaCrjps2dGaCi2zIDGUtPTG6vFf8g8/+J8
	 LtP/3ojJm4JOq50R3E1c0+3+nU+mT4HAWw6a+nwE6k/xaK44kTLXjm/6+4pFw=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: jackysliu <1972843537@qq.com>
To: gregkh@linuxfoundation.org
Cc: 1972843537@qq.com,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2] usb: gadget: functioni: Fix a oob problem in rndis
Date: Fri, 11 Jul 2025 11:46:35 +0800
X-OQ-MSGID: <20250711034635.3097961-1-1972843537@qq.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <2025071010-outlet-stencil-663d@gregkh>
References: <2025071010-outlet-stencil-663d@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 10 Jul 2025 14:19:47 +0200, greg k-h wrote

>In digging in this further, I don't see how this actually changes
>anything.  BufLength is used for nothing that I can determine, except in
>some debugging code that is always compiled out (i.e. you can NOT enable
>it unless you modify the kernel source.)
>
>So what exactly is this check checking?
>
>I can see that we really should be checking if the buffer is too small,
>but that's not what you are doing here at all.
>
>And all this buffer is used for is to read a 32bit value out of, so
>verifying that the buffer really is big enough to hold that value SHOULD
>be what we do here, not check to see if the buffer is too big.
>
>Also, you can't trust that BufLength is even correct as it comes from
>the other side, right?  Because of that, we should just be ignoring it
>entirely and verifying that the message size really is as big as the
>structure is supposed to be.  But that means passing down the message
>size to the lower layers here, which gets into the issues that I have
>raised before many years ago about this protocol, and this
>implementation of this protocol.  I.e, it is COMPLETELY INSECURE and
>should ONLY be used on systems where you trust both sides of the wire.
>
>Again, how was this change tested?  And what exactly does it fix?  I'm
>missing how this change is going to actually catch anything, can you
>spell it out in detail for me?

BufOffset + BufLength can exceed buffer size even if each is < RNDIS_MAX_TOTAL_SIZE
oob is triggered by a function call to gen_ndis_set_resp.
I supposed to add an additional boundry check to avoid this issue.But That 
doesn't seem to be enough to fix the bug.I'll try to figure it out.

Thanks

Siyang Liu



Return-Path: <linux-kernel+bounces-733478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C77DB0752E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 13:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 646C33A2D74
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 11:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344592F4A14;
	Wed, 16 Jul 2025 11:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="Rp0tARzF"
Received: from mail3-163.sinamail.sina.com.cn (mail3-163.sinamail.sina.com.cn [202.108.3.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652AE2BE647
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 11:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752666963; cv=none; b=Zt1Y8Wch2xC8Qwi5d+gxqAJwIKo3P6JhQG9LV9QTqb5tAc9DnJnFAOkEQlUw2BKN1K4CHGhz7DNArNDFHxcYLLdPU9rYXKFZnPuHvXGcmCFYrgb+0dNw8VAqllO5P7/tI8zlCz0HqPw0gmA64tOZ+rDnqIm+mL+mCe2Iet+yukU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752666963; c=relaxed/simple;
	bh=OgsvFMXRn2zZp50k7sbQGQYkdfixjsmzZn/vsvELM7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nT+6s6OI/H4vst7innqtz+GVEwxiQpxvRvtWurlYDaWIvPpuCefpYw7txOreIRtgHfigT5glHSwsl8UYP1Rm6g8wdX0BpE+NlhjZObb/fIHci6IhoktXVYejGjQVblKK2+8dmmELVrEND11CIZOyiQV3vK1aq5n5Or208EsmB44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=Rp0tARzF; arc=none smtp.client-ip=202.108.3.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1752666958;
	bh=ScUq0qxBv9+lwXrh7usT/F4ApTrXMfYTA/RM1sJnWv8=;
	h=From:Subject:Date:Message-ID;
	b=Rp0tARzFgWmsd/zKeZXADr5cO98Gjaw67sbrGxNsAMHFlI21KYh4H6iFudLo0WVaD
	 DsIbJqtDJd4ScfMZ3MC9D8MVdgdhDR48Ri2v4lqtyDBbbgUuN9/TOxuvsu3GNPMwNQ
	 6qhmdkTyWIzBwv+0Z+g6ehyeQLr+jfyvjBOh+IxE=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 6877934400001D59; Wed, 16 Jul 2025 19:55:49 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6259636291973
X-SMAIL-UIID: 4C57464769F042CBA700BEB9672EFBF0-20250716-195549-1
From: Hillf Danton <hdanton@sina.com>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Sean Young <sean@mess.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	syzbot+592e2ab8775dbe0bf09a@syzkaller.appspotmail.com,
	LKML <linux-kernel@vger.kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH] media: imon: make send_packet() more robust
Date: Wed, 16 Jul 2025 19:55:37 +0800
Message-ID: <20250716115538.2206-1-hdanton@sina.com>
In-Reply-To: <a44d5568-48d6-44f7-af93-e1b966489a84@I-love.SAKURA.ne.jp>
References: <53c07aa0-9f83-4c83-8ab5-6d8663f51b91@I-love.SAKURA.ne.jp> <8be733a4-2232-4bb9-942d-f13f8766a6de@I-love.SAKURA.ne.jp> <40417f2a-e0d8-4f3c-9a37-a0068b6f268a@I-love.SAKURA.ne.jp> <0ad3effe-efed-4304-862f-4c8f901e79e9@I-love.SAKURA.ne.jp> <2ac5d313-c754-4fb9-acd3-21f3b948d653@I-love.SAKURA.ne.jp> <282345b9-9aff-43ed-b66d-76cf51cc0deb@I-love.SAKURA.ne.jp> <20250713081148.3880-1-hdanton@sina.com> <d6da6709-d799-4be3-a695-850bddd6eb24@rowland.harvard.edu> <aHa3xpKfGNqAocIO@gofer.mess.org> <c4e88c28-28ee-4e37-9822-8e2999d0f0ee@rowland.harvard.edu> <aHdzD7EowAKT4AhQ@gofer.mess.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 16 Jul 2025 19:09:51 +0900 Tetsuo Handa wrote:
>On 2025/07/16 18:38, Sean Young wrote:
>> On Tue, Jul 15, 2025 at 09:30:02PM -0400, Alan Stern wrote:
>>> On Tue, Jul 15, 2025 at 09:19:18PM +0100, Sean Young wrote:
>>>> Hi Alan,
>>>>
>>>> On Sun, Jul 13, 2025 at 11:21:24AM -0400, Alan Stern wrote:
>>>>> On Sun, Jul 13, 2025 at 04:11:47PM +0800, Hillf Danton wrote:
>>>>>> [loop Alan in]
>>>>>
>>>>> I assume you're interested in the question of when to avoid resubmitting 
>>>>> URBs.
> 
> I think that what Hillf wanted to know (and I wanted maintainers of this
> driver to respond) is whether timeout of 10 seconds is reasonable
> 
Yes. In product environments like car cockpit I have option like change
to BOM if urb 10s timedout in general could be reliably reproduced twice
a month for example.

> -		/* Wait for transmission to complete (or abort) */
> -		retval = wait_for_completion_interruptible(
> -				&ictx->tx.finished);
> -		if (retval) {
> +		/* Wait for transmission to complete (or abort or timeout) */
> +		retval = wait_for_completion_interruptible_timeout(&ictx->tx.finished, 10 * HZ);
> 
> because the reproducer for this problem sometimes prevents
> usb_rx_callback_intf0() from being called. Unless we somehow
> handle such situation, the hung task reports won't go away.
> 


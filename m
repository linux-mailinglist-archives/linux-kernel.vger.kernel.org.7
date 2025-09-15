Return-Path: <linux-kernel+bounces-817271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1E7B58000
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9B5E3AC37E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF3532F75C;
	Mon, 15 Sep 2025 15:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SFhgguNR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q1OAPwhy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DB2327A1C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757948827; cv=none; b=nziZKL0Ziem+S8gWAmk+99wNBivAIsv1KvjiK9xAhZ0FVPnGUsl4H+oszSN+/I0VUco6C0G+8evEco+LognCvBaq1nuEjRtm7PuxWTaSrk20rrq2zy7eh2a+DCIumbTFgnhAYxIc8DoJsmQr6BFpLpVRJXe/wvNMJ/ZVL3wwdxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757948827; c=relaxed/simple;
	bh=P8A8Nbg1DIlkkFU/+Rz/cYbyzCSH5YcVYBvdFb/vcmA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qoDvmH9u5vHIpENkRlXiVlFitWnExOlro7fkxKGBJI10wmUMOol0TGRA88QPKAkytvUYvEFHNJCiPnM0FrVrM1N7mvDKufJri6x4nkoQEaZnnSyF4OIGEHorqoC4zAos5zqKUU4TD3OsqGsvRqbNdVIhvxjHegEQgSRTg7OmWgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SFhgguNR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q1OAPwhy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757948823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fsKeXzZOxOoXAczNFv98wiCAgcLvFR22fz6shI2rCB4=;
	b=SFhgguNRnt+RKyWQu7g1PXpk5mIk4WxHWiuvCYxj/PHoUVlRLRu5w0OhXv1NbD1zSlcA0b
	sh5bD+0TaY7LeUhl0B6U0lEAMhfT04HxlpMFha2b5lDcE7oyOGdg/QkYfeT1Owas2JRfWW
	/iTHL+FSNrDFQe4XY2TwXfKY9ntM6Tbdw19UJ3IvqBU+iQgCV/FWe61VpE8bTFmG2J7LPq
	ZSei25RgAkHWteVQN8u6SxrWZcGs9QFb+cqO3XKYFMK9+phuiEQ8heOhZiBt9XmUVOggTj
	X4kP7qjLVyPWPWy7vuE04OtLVxvI2F0EfqLv/G1ZkEULwbEgn9uNElrSm/JDQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757948823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fsKeXzZOxOoXAczNFv98wiCAgcLvFR22fz6shI2rCB4=;
	b=Q1OAPwhykwkFDYJaXlTsbzAbZhVgfcUi349lcP7C0JhIaqG4f2hFpwL5IKA67+kdwLA/E/
	LXyeYDPg7yCQLKBQ==
To: Daniil Tatianin <d-tatianin@yandex-team.ru>, Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v2 0/2] printk_ringbuffer: don't needlessly wrap data
 blocks around
In-Reply-To: <fece29ff-070e-4074-85be-4093a3000e5d@yandex-team.ru>
References: <20250905144152.9137-1-d-tatianin@yandex-team.ru>
 <aMLrGCQSyC8odlFZ@pathway.suse.cz> <aMLxt5k5U1vpmaQ3@pathway.suse.cz>
 <84bjnhx91r.fsf@jogness.linutronix.de> <aMPm8ter0KYBpyoW@pathway.suse.cz>
 <aMPt8y-8Wazh6ZmO@pathway.suse.cz> <aMQzD9CLP1F01Rry@pathway.suse.cz>
 <84a52zy0iu.fsf@jogness.linutronix.de>
 <20cbb02b-762f-4a3f-ba40-aae018388b3b@yandex-team.ru>
 <84348pqtej.fsf@jogness.linutronix.de>
 <fece29ff-070e-4074-85be-4093a3000e5d@yandex-team.ru>
Date: Mon, 15 Sep 2025 17:13:03 +0206
Message-ID: <84wm5z7o14.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-09-14, Daniil Tatianin <d-tatianin@yandex-team.ru> wrote:
>> After applying your patch, can you provide an example where a maximum
>> size of exactly half causes the tail to be pushed beyond the head? Keep
>> in mind that data_check_size() accounts for the meta-data. It only
>> doesn't account for the extra ID on wrapping data blocks.
>
> Sorry, I think exactly half is fine, basically we can keep it half, but 
> only remove the tailing id check with my patch.

I have been investigating this further. Even _without_ your patches, I
cannot find (either by using my brain or through testing) a problem with
limiting it to exactly half:

diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index bc811de18316b..9d47c1b94b71f 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -398,8 +398,6 @@ static unsigned int to_blk_size(unsigned int size)
  */
 static bool data_check_size(struct prb_data_ring *data_ring, unsigned int size)
 {
-	struct prb_data_block *db = NULL;
-
 	if (size == 0)
 		return true;
 
@@ -408,11 +406,7 @@ static bool data_check_size(struct prb_data_ring *data_ring, unsigned int size)
 	 * array. The largest possible data block must still leave room for
 	 * at least the ID of the next block.
 	 */
-	size = to_blk_size(size);
-	if (size > DATA_SIZE(data_ring) - sizeof(db->id))
-		return false;
-
-	return true;
+	return (to_blk_size(size) <= (DATA_SIZE(data_ring) / 2));
 }
 
 /* Query the state of a descriptor. */

When invalidating a data block (pushing the tail) it only must be
certain that the newly created space is large enough to fit the new data
block.

With a maximum of half, a new non-wrapping data block will always
fit. If it is a wrapping data block the worst case is if it is maximally
sized and ends exactly at the end of the array. In the case, it is
placed at index 0. But there it will only free up until the head
value. (If the head value was less, the data block would not have
wrapped.)

Your series handles the "ends exactly at the end of the array" case by
avoiding the need to wrap and thus invalidate up to half the
ringbuffer. But your series does not affect the maximum record size.

I will submit an official patch that also improves the comments to
clarify exactly why the limit exists.

@Petr: I am fine with you keeping our 1/4 limit in printk.c. But I would
like the ringbuffer code to be exactly proper here.

John


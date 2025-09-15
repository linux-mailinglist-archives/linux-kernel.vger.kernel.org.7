Return-Path: <linux-kernel+bounces-817388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6044B5819D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 353B6188BF6F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7288B248F40;
	Mon, 15 Sep 2025 16:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="yXEIBjis"
Received: from forwardcorp1d.mail.yandex.net (forwardcorp1d.mail.yandex.net [178.154.239.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF33121CC44
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 16:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757952483; cv=none; b=Rh+XjVOz2E8ZEMEcv9YLtqswQZCPEEPS5mNGZrCLen7niIok+3erdWRmPZqlt+KjtckxP2lLcxy6dRcyZnrgukgpRj3snx/K71NiXqt5X+F14eyaPXK+ja3Bg6W2ZI/tp534eufVfB/1/RmCc4afcGHVESJCO6Zcs4oiUVuilVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757952483; c=relaxed/simple;
	bh=8y5dEoNz50uZgAm+YvoOGseE/GoqPwL+ASF5KsXnbgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QgpBRFyroEexo8Oz37xpz7bV1ruZ6JY8o7awSwNrnnjubBzM/dPDDBOFavVyBFeIHgvjZbzKJQ2Tartstp207LwtWTTxcmXx1nA5C4R5RvmgmDrI5dU9tKPFHwdILTsS42MqGXE9PAoAvgDffyVGJszStk99TqYMStxyLT0eRuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=yXEIBjis; arc=none smtp.client-ip=178.154.239.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
	by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id C105480974;
	Mon, 15 Sep 2025 19:07:48 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:c71::1:21] (unknown [2a02:6bf:8080:c71::1:21])
	by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id k7SMwi1FoeA0-zghivO12;
	Mon, 15 Sep 2025 19:07:48 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1757952468;
	bh=lGCRACttmCTN5Oi05rkiDmsynTL0QDVW9+5tG3omKnA=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=yXEIBjislWRCQjdX1d3Eym6KG4j7KXDyWlGEU4jRX6pBUXcByoYqGSQUoaguOJzeb
	 vcbnwtpGcVVW14iU1pHkjCZky/dEVGnIa4APFABFeoFY6Z3zdMTSpQGEZosH3eiuCs
	 EWmNXHxUPF6GPSfk5TlWvW7vUUdAfB0I0C38aQbQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Message-ID: <ca90223f-ca25-466c-a8c1-94f4f39b26cf@yandex-team.ru>
Date: Mon, 15 Sep 2025 19:07:46 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] printk_ringbuffer: don't needlessly wrap data
 blocks around
To: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>
References: <20250905144152.9137-1-d-tatianin@yandex-team.ru>
 <aMLrGCQSyC8odlFZ@pathway.suse.cz> <aMLxt5k5U1vpmaQ3@pathway.suse.cz>
 <84bjnhx91r.fsf@jogness.linutronix.de> <aMPm8ter0KYBpyoW@pathway.suse.cz>
 <aMPt8y-8Wazh6ZmO@pathway.suse.cz> <aMQzD9CLP1F01Rry@pathway.suse.cz>
 <84a52zy0iu.fsf@jogness.linutronix.de>
 <20cbb02b-762f-4a3f-ba40-aae018388b3b@yandex-team.ru>
 <84348pqtej.fsf@jogness.linutronix.de>
 <fece29ff-070e-4074-85be-4093a3000e5d@yandex-team.ru>
 <84wm5z7o14.fsf@jogness.linutronix.de>
Content-Language: en-US
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
In-Reply-To: <84wm5z7o14.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/15/25 6:07 PM, John Ogness wrote:
> On 2025-09-14, Daniil Tatianin <d-tatianin@yandex-team.ru> wrote:
>>> After applying your patch, can you provide an example where a maximum
>>> size of exactly half causes the tail to be pushed beyond the head? Keep
>>> in mind that data_check_size() accounts for the meta-data. It only
>>> doesn't account for the extra ID on wrapping data blocks.
>> Sorry, I think exactly half is fine, basically we can keep it half, but
>> only remove the tailing id check with my patch.
> I have been investigating this further. Even _without_ your patches, I
> cannot find (either by using my brain or through testing) a problem with
> limiting it to exactly half:
>
> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
> index bc811de18316b..9d47c1b94b71f 100644
> --- a/kernel/printk/printk_ringbuffer.c
> +++ b/kernel/printk/printk_ringbuffer.c
> @@ -398,8 +398,6 @@ static unsigned int to_blk_size(unsigned int size)
>    */
>   static bool data_check_size(struct prb_data_ring *data_ring, unsigned int size)
>   {
> -	struct prb_data_block *db = NULL;
> -
>   	if (size == 0)
>   		return true;
>   
> @@ -408,11 +406,7 @@ static bool data_check_size(struct prb_data_ring *data_ring, unsigned int size)
>   	 * array. The largest possible data block must still leave room for
>   	 * at least the ID of the next block.
>   	 */
> -	size = to_blk_size(size);
> -	if (size > DATA_SIZE(data_ring) - sizeof(db->id))
> -		return false;
> -
> -	return true;
> +	return (to_blk_size(size) <= (DATA_SIZE(data_ring) / 2));
>   }
>   
>   /* Query the state of a descriptor. */
>
> When invalidating a data block (pushing the tail) it only must be
> certain that the newly created space is large enough to fit the new data
> block.
>
> With a maximum of half, a new non-wrapping data block will always
> fit. If it is a wrapping data block the worst case is if it is maximally
> sized and ends exactly at the end of the array. In the case, it is
> placed at index 0. But there it will only free up until the head
> value. (If the head value was less, the data block would not have
> wrapped.)
>
> Your series handles the "ends exactly at the end of the array" case by
> avoiding the need to wrap and thus invalidate up to half the
> ringbuffer. But your series does not affect the maximum record size.

Yeah, I think you're right. I guess the second patch can be dropped now, 
which is even better.

>
> I will submit an official patch that also improves the comments to
> clarify exactly why the limit exists.
>
> @Petr: I am fine with you keeping our 1/4 limit in printk.c. But I would
> like the ringbuffer code to be exactly proper here.
>
> John


Return-Path: <linux-kernel+bounces-834244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20593BA440D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21A621890228
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75EA1F5834;
	Fri, 26 Sep 2025 14:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="GLRrSDRc"
Received: from forwardcorp1d.mail.yandex.net (forwardcorp1d.mail.yandex.net [178.154.239.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BD11E5701
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 14:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758897371; cv=none; b=ZfaMTMxBFx9jq4Mcn7AaslcOBC7kYDeJGHPMyyOIUA21US6ASqPydsgU8zxWSKjcxf6wSlmpxFcnYxI74WDgnAsObfDtELnYoWUyJ7o70TzYo4Qw1ReGziZ90WLkmzAcO7LdhJ7/D44YOa+n/SfdsrUdEzvqKPuGvRHPhM4cE9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758897371; c=relaxed/simple;
	bh=Sr2fU/vS6MLV71ofJRUzv3IMUQhJYVZX5sbGyDMUEM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qn7Nmy8BwkKaBXecyS6b0TSOckFr1TxFZaqae3gT5WPk0GOzCba9B27WfpXXiI7JmuN+1blP5aax1oxRA79XiQ+7+02YgU9lxiijyCcSB5/66kUzovgsYp6+ZbeFIHHDHSLi9ZlfYbMhCrq/v3QYFupuWbFVdnn0bdLP4V8CyOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=GLRrSDRc; arc=none smtp.client-ip=178.154.239.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:cf2d:0:640:140f:0])
	by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 442DC80F01;
	Fri, 26 Sep 2025 17:35:55 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:c29::1:22] (unknown [2a02:6bf:8080:c29::1:22])
	by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id rZbf8P1FmiE0-sX5adq2X;
	Fri, 26 Sep 2025 17:35:54 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1758897354;
	bh=0YTs0g+67oYZ+X55Q+GwXbOVGScp9zVgAXrFRHB4Emo=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=GLRrSDRcQeyPW1jFwVfHiydv4o2yBqdjz8Ntoi0As7t/3mSCfWR7w8da8O7on/B2l
	 4m7Ni0sSdYtnMK+N106mmluJHT3VgJWUhH8b5BYfLJ2A0R1zzwZ9ho2nsuiW+qXtB0
	 +pmFQaGNterDdzGvN1eXhIDmaRzTZS9nQZwLGG8g=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Message-ID: <0ffb6fad-20cb-4e87-bfa6-a2e6124c03ad@yandex-team.ru>
Date: Fri, 26 Sep 2025 17:35:53 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] printk_ringbuffer: don't needlessly wrap data
 blocks around
To: Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 John Ogness <john.ogness@linutronix.de>,
 Sergey Senozhatsky <senozhatsky@chromium.org>
References: <20250905144152.9137-1-d-tatianin@yandex-team.ru>
 <20250905144152.9137-2-d-tatianin@yandex-team.ru>
Content-Language: en-US
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
In-Reply-To: <20250905144152.9137-2-d-tatianin@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all!

Now that the fix for large messages is committed, I think this patch 
should be good to take,
and the second one we can just drop since it's no longer relevant.

Thanks,
Daniil

On 9/5/25 5:41 PM, Daniil Tatianin wrote:
> Previously, data blocks that perfectly fit the data ring buffer would
> get wrapped around to the beginning for no reason since the calculated
> offset of the next data block would belong to the next wrap. Since this
> offset is not actually part of the data block, but rather the offset of
> where the next data block is going to start, there is no reason to
> include it when deciding whether the current block fits the buffer.
>
> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
> ---
>   kernel/printk/printk_ringbuffer.c | 27 +++++++++++++++++++--------
>   1 file changed, 19 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
> index d9fb053cff67..99989a9ce4b4 100644
> --- a/kernel/printk/printk_ringbuffer.c
> +++ b/kernel/printk/printk_ringbuffer.c
> @@ -1002,6 +1002,17 @@ static bool desc_reserve(struct printk_ringbuffer *rb, unsigned long *id_out)
>   	return true;
>   }
>   
> +static bool is_blk_wrapped(struct prb_data_ring *data_ring,
> +			    unsigned long begin_lpos, unsigned long next_lpos)
> +{
> +	/*
> +	 * Subtract one from next_lpos since it's not actually part of this data
> +	 * block. This allows perfectly fitting records to not wrap.
> +	 */
> +	return DATA_WRAPS(data_ring, begin_lpos) !=
> +	       DATA_WRAPS(data_ring, next_lpos - 1);
> +}
> +
>   /* Determine the end of a data block. */
>   static unsigned long get_next_lpos(struct prb_data_ring *data_ring,
>   				   unsigned long lpos, unsigned int size)
> @@ -1013,7 +1024,7 @@ static unsigned long get_next_lpos(struct prb_data_ring *data_ring,
>   	next_lpos = lpos + size;
>   
>   	/* First check if the data block does not wrap. */
> -	if (DATA_WRAPS(data_ring, begin_lpos) == DATA_WRAPS(data_ring, next_lpos))
> +	if (!is_blk_wrapped(data_ring, begin_lpos, next_lpos))
>   		return next_lpos;
>   
>   	/* Wrapping data blocks store their data at the beginning. */
> @@ -1081,7 +1092,7 @@ static char *data_alloc(struct printk_ringbuffer *rb, unsigned int size,
>   	blk = to_block(data_ring, begin_lpos);
>   	blk->id = id; /* LMM(data_alloc:B) */
>   
> -	if (DATA_WRAPS(data_ring, begin_lpos) != DATA_WRAPS(data_ring, next_lpos)) {
> +	if (is_blk_wrapped(data_ring, begin_lpos, next_lpos)) {
>   		/* Wrapping data blocks store their data at the beginning. */
>   		blk = to_block(data_ring, 0);
>   
> @@ -1125,7 +1136,7 @@ static char *data_realloc(struct printk_ringbuffer *rb, unsigned int size,
>   		return NULL;
>   
>   	/* Keep track if @blk_lpos was a wrapping data block. */
> -	wrapped = (DATA_WRAPS(data_ring, blk_lpos->begin) != DATA_WRAPS(data_ring, blk_lpos->next));
> +	wrapped = is_blk_wrapped(data_ring, blk_lpos->begin, blk_lpos->next);
>   
>   	size = to_blk_size(size);
>   
> @@ -1151,7 +1162,7 @@ static char *data_realloc(struct printk_ringbuffer *rb, unsigned int size,
>   
>   	blk = to_block(data_ring, blk_lpos->begin);
>   
> -	if (DATA_WRAPS(data_ring, blk_lpos->begin) != DATA_WRAPS(data_ring, next_lpos)) {
> +	if (is_blk_wrapped(data_ring, blk_lpos->begin, next_lpos)) {
>   		struct prb_data_block *old_blk = blk;
>   
>   		/* Wrapping data blocks store their data at the beginning. */
> @@ -1187,7 +1198,7 @@ static unsigned int space_used(struct prb_data_ring *data_ring,
>   	if (BLK_DATALESS(blk_lpos))
>   		return 0;
>   
> -	if (DATA_WRAPS(data_ring, blk_lpos->begin) == DATA_WRAPS(data_ring, blk_lpos->next)) {
> +	if (!is_blk_wrapped(data_ring, blk_lpos->begin, blk_lpos->next)) {
>   		/* Data block does not wrap. */
>   		return (DATA_INDEX(data_ring, blk_lpos->next) -
>   			DATA_INDEX(data_ring, blk_lpos->begin));
> @@ -1234,14 +1245,14 @@ static const char *get_data(struct prb_data_ring *data_ring,
>   	}
>   
>   	/* Regular data block: @begin less than @next and in same wrap. */
> -	if (DATA_WRAPS(data_ring, blk_lpos->begin) == DATA_WRAPS(data_ring, blk_lpos->next) &&
> +	if (!is_blk_wrapped(data_ring, blk_lpos->begin, blk_lpos->next) &&
>   	    blk_lpos->begin < blk_lpos->next) {
>   		db = to_block(data_ring, blk_lpos->begin);
>   		*data_size = blk_lpos->next - blk_lpos->begin;
>   
>   	/* Wrapping data block: @begin is one wrap behind @next. */
> -	} else if (DATA_WRAPS(data_ring, blk_lpos->begin + DATA_SIZE(data_ring)) ==
> -		   DATA_WRAPS(data_ring, blk_lpos->next)) {
> +	} else if (!is_blk_wrapped(data_ring,
> +		   blk_lpos->begin + DATA_SIZE(data_ring), blk_lpos->next)) {
>   		db = to_block(data_ring, 0);
>   		*data_size = DATA_INDEX(data_ring, blk_lpos->next);
>   


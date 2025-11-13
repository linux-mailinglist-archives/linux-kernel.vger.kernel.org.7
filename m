Return-Path: <linux-kernel+bounces-899958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9CBC5939E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5110A4F2475
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A963653363;
	Thu, 13 Nov 2025 17:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mfqlk8dw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD1B2F83AE
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 17:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763054145; cv=none; b=mN83BhUCixLJTQCAvvUJe1N4gYMilEZWFc/a2Vuz3VAFUx8yu9zw/VuvfXEsabyMJtzwanSqMGn0Ftbs4Sp0M9JEC/I5UA+eXiwfMPYPLslnmB714P1UciU5gyk3uZV9eMf0Te0ZvN7WLm6z2LqLgex9/AXbQ2cWVZEVt6MPgbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763054145; c=relaxed/simple;
	bh=1TS3baP+fdvegLmnN/DVIgIEP/uRDB762lIq3Wk6cZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=huK31RWi3A9AbBiVnzSOKx621EhJf3tpn9gWrG5VXZ6iCVU42tkyaPLV8o5YixTO4WlwjgQzCyBVb24/eL7cNhd0ZaD30EajTLk7CkncVRpJuW/B/73oZ1xMFxL5WDQqNsSkwK9VEMUGBURRCFKjLHQL2+8HC2Jr0a5PFeBfIy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mfqlk8dw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A9BC4CEF5;
	Thu, 13 Nov 2025 17:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763054144;
	bh=1TS3baP+fdvegLmnN/DVIgIEP/uRDB762lIq3Wk6cZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mfqlk8dw/NEQnnsQta+kzLvw8G3X/BmDZlRipO8E/glYns2JtEnQMZUIAN2r2hic3
	 B5Ka51VhvVXkwQxrREOYa/LHsKseb8ZUh8foBcpBBfIjcB49sS4lU+CvIGvegg8pmc
	 Wp8N78pBuKQPkuDZ36NlLT30itEaaoRu+dE6T65LoGtCeo6vG9m+j/7GDbtB9jgb9z
	 gqWmDKOCEBKvXpyNo7qt6tSs+tM1seuOC8dV28n/6tb2AyqmX9wwgnGxkq+yx4pqwp
	 eUOILpIluZaEIIJM5hHcKkOE9/W3ecrddvbNUQKGZZGc1pfNP1IP2dgiLH5BvcGZlq
	 jlfbI2PrP721Q==
Date: Thu, 13 Nov 2025 07:15:43 -1000
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	ying chen <yc1082463@gmail.com>
Subject: Re: [PATCH] workqueue: Process rescuer work items one-by-one using a
 positional marker
Message-ID: <aRYSPyIp2LYzUkf-@slm.duckdns.org>
References: <20251113163426.2950-1-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113163426.2950-1-jiangshanlai@gmail.com>

Hello, Lai.

On Fri, Nov 14, 2025 at 12:34:26AM +0800, Lai Jiangshan wrote:
> +static void insert_mayday_pos(struct pool_workqueue *pwq, struct work_struct *next)
> +{
> +	unsigned int work_flags;
> +	unsigned int work_color;
> +
> +	__set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(&pwq->mayday_pos_work));

Maybe use test_and_set_bit() here like normal work item?

> +static void remove_mayday_pos(struct pool_workqueue *pwq)
> +{
> +	list_del_init(&pwq->mayday_pos_work.entry);
> +	pwq_dec_nr_in_flight(pwq, *work_data_bits(&pwq->mayday_pos_work));
> +	INIT_WORK(&pwq->mayday_pos_work, mayday_pos_func);

and maybe we can init the work item once and

>  static void send_mayday(struct work_struct *work)
>  {
>  	struct pool_workqueue *pwq = get_work_pwq(work);
> @@ -2992,6 +3037,9 @@ static void send_mayday(struct work_struct *work)
>  	if (!wq->rescuer)
>  		return;
>  
> +	if (!work_pending(&pwq->mayday_pos_work))

drop this conditional too?

Also, I wonder whether it'd be simpler to think about if we just exclude the
work item from flush color management. e.g. we can just flag the work item
and then make work scanning skip them, so that they really are just markers;
then, we don't have to worry about colors or othre states at all. We just
insert the marker and use it purely as iteration marker.

> +				/* reset the position and handle the assigned work */
> +				if (list_next_entry(&pwq->mayday_pos_work, entry) != n) {
> +					remove_mayday_pos(pwq);
> +					insert_mayday_pos(pwq, n);

and this would become simple list_move_tail().

Thanks.

-- 
tejun


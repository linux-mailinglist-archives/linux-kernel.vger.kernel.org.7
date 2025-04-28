Return-Path: <linux-kernel+bounces-623220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3453EA9F28C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 15:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55E4D1A822D3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 13:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18D826AAA7;
	Mon, 28 Apr 2025 13:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b="NxQikjTa"
Received: from mx.manguebit.com (mx.manguebit.com [167.235.159.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA82126AA83
	for <linux-kernel@vger.kernel.org>; Mon, 28 Apr 2025 13:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.235.159.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745847527; cv=none; b=hleiwrrRk7BALAs6MtqQTFjaLfYMxUhotsE/nFH/jiCbxHLoerE7xvSsVm7QYroYlQl36UqgTxCuBbgEnFKoyTZ1vUAKMOC8KmRR4NUFkJHShnkgfAjGPYLlJN0a7q+KQi1chZL18H0h3N4oVIcMdBjJhDLQWv25ayEzh+2Ods8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745847527; c=relaxed/simple;
	bh=qQFyVti48/QNS9uXHnqXQI3AgYrjAJyezqJWtH1sdzk=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=SVPmUiN4392xvwYxx24K5kMxit9WxzmFtySbSWdgamAbZfuqP8N+mO7JeTP7tXg4xI760OyMARETr/SMWjxC1nknCEAhu1F+T9snSvRYdrKutatDphQa4V9MW91xrcu4gcnnHl9xeJGjzeGwYjxmdJNLTU3vfPjP3hiGyI81Huk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com; spf=pass smtp.mailfrom=manguebit.com; dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b=NxQikjTa; arc=none smtp.client-ip=167.235.159.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.com
Message-ID: <a83bf0565fccbe448ab1a350def86f91@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1745847523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Nnb2PBo8ZO1TcHVs62W9HZZ+CzPyOuSJ0EVp+DituY=;
	b=NxQikjTaSsKUWIKOEI/u6ALDGyv3qhLQD2G/jdMvJhR9RjnJFYIXfMeDgMyc1DqdPRSkmE
	hoRYVNUuEIjVJm4lVTq6UHjcy5TRJ9FkW+zrQ2lFJha9gHowgKSvJ/88m52gEn20bEpcQo
	plXUNqjJVJUKNIjRpksEYd9I3TzD9JJ6Q2l49W7DsjEtdfbTyRa4n4BqsKFw9BSSqKdpIa
	GFl+EA0TDkG+/OgyYDWXHk2h3c+a3spH4BslhUtVzhuBALu6IjQ57TC+/+ym91E3U8K7hd
	cWsHkN1/Uk6J8z+7QMGp7o1c2ZkG6hNHGIDGdPa9gun8TkrtMv8jb95mF4vDpg==
From: Paulo Alcantara <pc@manguebit.com>
To: Max Kellermann <max.kellermann@ionos.com>, dhowells@redhat.com,
 netfs@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: Re: [PATCH] fs/netfs/read_collect: remove duplicate line
In-Reply-To: <notmuch-sha1-fe1ebcd5fc23eab1dc1cf15f4369d4b0ea567ded>
References: <20250428114842.3180169-1-max.kellermann@ionos.com>
Date: Mon, 28 Apr 2025 10:38:39 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Paulo Alcantara <pc@manguebit.com> writes:

> Max Kellermann <max.kellermann@ionos.com> writes:
>
>> @@ -653,7 +653,6 @@ ssize_t netfs_wait_for_read(struct netfs_io_request *rreq)
>>  		switch (rreq->origin) {
>>  		case NETFS_DIO_READ:
>>  		case NETFS_READ_SINGLE:
>> -			ret = rreq->transferred;
>>  			break;
>>  		default:
>>  			if (rreq->submitted < rreq->len) {
>
> This is wrong.  @ret is expected to have the amount of bytes
> successfully read if no error.

Err, sorry.  I just saw the assignment right after if (ret == 0) check.

Looks good,

Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>


Return-Path: <linux-kernel+bounces-766478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4CAB24703
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 12:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EB5D1649BF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CCF2D3EDA;
	Wed, 13 Aug 2025 10:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oliG3B5M"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1AF2777E8
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 10:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755080269; cv=none; b=BRe2FostbUNjHxI48r8/EwTfkWdBki+DyEHU9Ew2MtHNtRhGCjN22iTcKZxvlZmPfKWlC7lVjlV5nPah/twno01he15hLvT+0nne01UCZNA0JwTV8ljUT1TTlXFHFaWKQ9UU03mGs76prRhS1+zZUqQYrBIq0vHQlXolQ+OrbVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755080269; c=relaxed/simple;
	bh=eBogFjsAW/CzbqvTDnhDBJE6o6dXCGpP/yXDyp5i38Q=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=EdI3MYwA8aTtNU21c3cjUNPUeSysax/V/gCC6TKxMT+69QDHwkLbrg7V+ApUgtVzxtYmOT6THbfbnqgCJ58FEdGORF3osOjH9OK/jYJbczCfrVWjyojUTbEG8tdeh5oB/Uu14PeRpaM7ypf3nAgvAX5SfSRN6HyuDo9SYfpMurM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oliG3B5M; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755080255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eBogFjsAW/CzbqvTDnhDBJE6o6dXCGpP/yXDyp5i38Q=;
	b=oliG3B5Mbwsp5QN7u/Xy/XuxdjCtDBxbM7+ZC1Y5fbGyG4HgqUmfn2C3+f+9+PQe62nCPl
	nVL1VupPFOlCdiglVdm6a/QUgNgPYLVq49CKYN4BM25Xw33SfxGccIr+0eK0oTEfLbU3Wi
	94w5CvvmA1q3A0SAAHeeko1nXBxuKME=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [usb-storage] [PATCH] usb: storage: realtek_cr: Simplify
 rts51x_bulk_transport()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <49559415-4493-4b90-a9bc-c6b9074a61f6@rowland.harvard.edu>
Date: Wed, 13 Aug 2025 12:17:21 +0200
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org,
 usb-storage@lists.one-eyed-alien.net,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <8AD61006-EA99-48A3-879A-49A575081F15@linux.dev>
References: <20250812144358.122154-1-thorsten.blum@linux.dev>
 <b11a19b6-9fb3-4fdc-b94e-33ff01a634b3@rowland.harvard.edu>
 <19E72C72-AFD3-4D13-8F14-9A1F96B971D3@linux.dev>
 <49559415-4493-4b90-a9bc-c6b9074a61f6@rowland.harvard.edu>
To: Alan Stern <stern@rowland.harvard.edu>
X-Migadu-Flow: FLOW_OUT

On 13. Aug 2025, at 03:38, Alan Stern wrote:
> If you would like to submit three new patches, please do.

I just submitted this as three separate patches:

https://lore.kernel.org/lkml/20250813101249.158270-2-thorsten.blum@linux.dev/

Thanks,
Thorsten



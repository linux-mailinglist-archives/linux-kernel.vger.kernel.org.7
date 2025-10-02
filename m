Return-Path: <linux-kernel+bounces-840836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E96BB5882
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 00:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51C481922A76
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 22:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F1C255F28;
	Thu,  2 Oct 2025 22:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="DDEbkf3S"
Received: from mail3-164.sinamail.sina.com.cn (mail3-164.sinamail.sina.com.cn [202.108.3.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0D64501A
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 22:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759443127; cv=none; b=AmDmiMh88LJv1zvIowpM5NUBxrN2f6Cs0JhJMJHsXSJI3busdwXwIH/0JbMHmyKQC0Wr6duLZANOIyTVdk/pOkaWcmgwHZfhL+Po+gMSgt+g3sLF7erxLBXD46JMgINGL1jaGd/9wH4MIyGwN/URR7H8ucAd3IouiIbuEXEo8e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759443127; c=relaxed/simple;
	bh=mNmobdb33i/NRk6yWwtyJH6TQHGscdRbr0fXcdQ/rOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a51saXbrwbI+kY5WB+5OqckJwFsWnBhDnyV+5fOFCpMS5ISlr4zGhIW6+BCQ4c2ASdN6r1XftlEeYKLVXbYVSzC0WHV7YAtRVXin1i0cXcIPGx+W1haggUMiwkeZpy8AoU3kgXN82ae6+0SpbtYvMq8ngDp0i6qEc9RrevTEp68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=DDEbkf3S; arc=none smtp.client-ip=202.108.3.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1759443122;
	bh=VtJew5ZCdvV97iI5B/3Arl4KX8tS6megboe+TBYge0M=;
	h=From:Subject:Date:Message-ID;
	b=DDEbkf3S8eaWQkqTZNByw64JGIxKxe5vjBJTbIUpxgb/O4w6nvogi9GAy0UOw5Ny2
	 zMTEaQFUFbYQc4bjVJnuafxss9LINGP6tXVNACGscOJQ4YNXszzvWWn5RPUGAS0O1T
	 hGMngIkm5h7H2xe/hx+pzbOLpbkHZ83Ud2XnOG/k=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 68DEF66D000023A6; Thu, 3 Oct 2025 06:02:23 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 181394456620
X-SMAIL-UIID: 2201C5466FD8454B870603BEF434F690-20251003-060223-1
From: Hillf Danton <hdanton@sina.com>
To: David Hildenbrand <david@redhat.com>
Cc: Byungchul Park <byungchul@sk.com>,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC] mm/migrate: make sure folio_unlock() before folio_wait_writeback()
Date: Fri,  3 Oct 2025 06:02:10 +0800
Message-ID: <20251002220211.8009-1-hdanton@sina.com>
In-Reply-To: <9a586b5b-c47f-45eb-83c8-1e86431fc83d@redhat.com>
References: <20251002081612.53281-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2 Oct 2025 13:38:59 +0200 David Hildenbrand wrote:
> 
> If it's a real issue, I wonder if a trylock on the writeback path could 
> be an option.
> 
Given Thanks to Yunseong for reporting the issue, testing, and confirming if
this patch can resolve the issue, could you share your reproducer with
reviewers Byungchul?


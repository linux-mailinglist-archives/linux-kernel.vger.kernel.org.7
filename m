Return-Path: <linux-kernel+bounces-837787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 265D9BAD2F3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 16:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D48CC322212
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72AF21CC4B;
	Tue, 30 Sep 2025 14:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="dXpj7gOA"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E201A0BE0
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 14:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759242756; cv=none; b=qVBnpEdek15NK0y5NnQodVK6TReht4ujbGlmazVTqJj/Szoe+et2gkd6xibKAatVQPW2NXIuyaozTZH3IjS5jwrsHGwGpZ6UEU8XUVy3BXUdxP6npVU1qc70+qrdc/rJlJrUEjkCcyZjdXLOvonGTIodkHvmbGXGMmtcqxlD/2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759242756; c=relaxed/simple;
	bh=FJ2vNfPXMdxXLsXvGSg8IRBqANEbBI2yKMLhdtQ37CY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=d/7O4VFtvQZXX0A2vwO0ls5gLVtfCv8CuRq7ThAvOS1P/j/5Zdj28gimY5k65vW/g8PO0JUrHC649Cc4CjfjCOndNIIdwxMIwP1d1NW+AIuB5O200Jk4Xly7IlpHkIPtzgwOrZ71ro/u83OGgLjKvau+AOoUEQT7aeqJSsFlZWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=dXpj7gOA; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:Message-ID:References:
	In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Na77R11NbjgWMZhuIVj8AYAJI1CDT3+izYFOG1w9JTo=; b=dXpj7gOA3v9harDKKH/oW0XcbY
	+h/uyc6a2+u9EZS9K6NxCe2Prjf7rmfpx1lWPNemsWwepTtZ0iYvKyM7kW4qQQysPLnSUpWCamWh+
	pWLpvwhnL1Hw4YM2+moKz8uxFkJgryPd56GjsTTVWruSda4BQrYwUV7dmu20vJAzDi7yzi/O3qQSA
	uJ88naDRF6KE+VI7qOrlFil2SHAZKueUiTjJRvC2JUy6VEf1Tkae4MQhhk2u+cwV85hftXAvmnHQu
	u5XsZTI1XwTDmMkZMqeu/LRCxfzqgYPkSwzITiU69rN5U3Nmo5F5C/DXH9gZBBX8QtUmdDrQxwlZ4
	plLvqeKw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine2.igalia.com with esmtps 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1v3bOo-002JKb-8u; Tue, 30 Sep 2025 16:32:14 +0200
Received: from webmail.service.igalia.com ([192.168.21.45])
	by mail.igalia.com with esmtp (Exim)
	id 1v3bOm-001fwV-8f; Tue, 30 Sep 2025 16:32:14 +0200
Received: from localhost ([127.0.0.1] helo=webmail.igalia.com)
	by webmail with esmtp (Exim 4.96)
	(envelope-from <mfo@igalia.com>)
	id 1v3bOl-00Chfy-2C;
	Tue, 30 Sep 2025 16:32:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 30 Sep 2025 11:32:12 -0300
From: Mauricio Faria de Oliveira <mfo@igalia.com>
To: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka
 <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>, Suren Baghdasaryan
 <surenb@google.com>, Brendan Jackman <jackmanb@google.com>, Johannes Weiner
 <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com
Subject: Re: [PATCH 0/3] mm/page_owner: add options 'print_handle' and
 'print_stack' for 'show_stacks'
In-Reply-To: <aNvjDsBuw3hqwy31@tiehlicka>
References: <20250924174023.261125-1-mfo@igalia.com>
 <aNVpFn9W0jYYr9vs@tiehlicka> <4c2a467113efd085530eb055e4a4e1fe@igalia.com>
 <aNY49sdoFVe03m_Y@tiehlicka> <d9af42d5cb9d427632087c5f51e50501@igalia.com>
 <aNvjDsBuw3hqwy31@tiehlicka>
Message-ID: <2a1efa8ba183e866ab5c71b3526f64ab@igalia.com>
X-Sender: mfo@igalia.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Report: NO, Score=-4.9, Tests=ALL_TRUSTED=-3,AWL=-2.663,BAYES_50=0.8
X-Spam-Score: -48
X-Spam-Bar: ----

On 2025-09-30 11:02, Michal Hocko wrote:
> Sure, I see. The main problem with the option file is that it is
> inherently suited for a single consumer which is a hard assumption to
> make at this stage. So I think it is worth having a separate 2 files
> which provide the missing functionality.

Ack; I'll submit v2 addressing your suggestions. Thanks!

-- 
Mauricio


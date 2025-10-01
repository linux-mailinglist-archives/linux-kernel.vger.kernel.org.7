Return-Path: <linux-kernel+bounces-839216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B529BB1130
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 17:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB5092A1494
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 15:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC93D2475C7;
	Wed,  1 Oct 2025 15:31:06 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924D17263B
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 15:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759332666; cv=none; b=iC9K0EAEXHZjtH7PBOZlWs29bAgUNM3fV5ZlZHowvPE57WXBtSGM39r31vNTGKeAB5MVdx2KUEYFV2X6kQhy/DISESIyGtwKChWOW4vaHce00eWT+PC7ZoD8MJjoKOy9eU9gvgHDHNqgYM1oPH9Zxud2qSRgKvcdEKSrw0UCoQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759332666; c=relaxed/simple;
	bh=3xzeUKjhxNrSFAmICdfEe2GD9a/cAXfvsPkBDsPUjY0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=orxZVOgXK76QbhdvAc5zuJeq4oVb8wNd32B51obvzw71UZ/K9hI97q0qT9ssLGiP1YKSc0YhITLig5YI2pd6+utx3+H11bjUQySmNl9kredAwVIqZTPs3DpjtrUVmXyqGcK1WfqZNG1E1un4BnJI9CUa7WBI6eOhjwp/pNk9KoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 486761384CC;
	Wed,  1 Oct 2025 15:31:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 9A7C52E;
	Wed,  1 Oct 2025 15:31:01 +0000 (UTC)
Date: Wed, 1 Oct 2025 11:32:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: jpoimboe@kernel.org, rostedt@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/12] unwind: Add required include files
Message-ID: <20251001113239.5f964d8b@gandalf.local.home>
In-Reply-To: <20250924080118.665787071@infradead.org>
References: <20250924075948.579302904@infradead.org>
	<20250924080118.665787071@infradead.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9A7C52E
X-Stat-Signature: 5rkshzhm55mk4wmx3o7dgh7gazun5pxz
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18R3il62tPK/tNKpA01kemTHPIjlcMmZG8=
X-HE-Tag: 1759332661-661024
X-HE-Meta: U2FsdGVkX18kIq/M5bLxo622ag12Pm6om3NPULHAEIgc684CwEquWkWor9IsJMZYtcUHR5zSqdh1/cwi2AC9XM0VGNBn0A+EOsY3/WWBuZOLZpo1opVrZleqNPi1kaFMhvYRsIOFBlMtHUixU6OtvujHkBavQQYNLw/oa6fh8xu9Lt7rRaw8bnI0fPVeFFmuRCan4f3vQrmNBoQEL5iWja4zoulj2Rnxb48QSpYEDKkJILW5TD9MEbundtE+NCv8NmD4ROcEZJS5X0JfCpCNx1Nn0EfPsvWBB5Vs3zT06G16d8HAauhKCpg20o3CRbC+sAhdtThAZeNs7+gewlSIWuRPQzOrssUNCTitME0fsjWIM5mTSBuHd88JqdlUPcdkSKk3vxaCBqgUYmpFYSOGFAsvNFa5nqRMubzL/s1qEMNCekBDFK0SZFMVbX5/Gpyr

On Wed, 24 Sep 2025 09:59:51 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> To be self sufficient, the file needs to include linux/types.h. This
> provides things like u32/u64 and struct callback_head.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve


Return-Path: <linux-kernel+bounces-741287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A99B0E26F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 19:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94C6DAC1D99
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494E127FB03;
	Tue, 22 Jul 2025 17:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HLGG0YQM"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CFA27E060
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 17:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753204562; cv=none; b=dOTqMJsZRMgxqeJK1zVTg3gWkKtrkweEBRceoecUROrdGIMw6w96YtYYrB+5gGyRn5P7CQjlFa1DLvNY4UCMeAj9r82ZR6IGoZt24H1v1zwfdO+TweGZk+PXBgHtcbIyGCRul84r387wPOFV1jS7ERQlngxHWMC193ThWbDQSSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753204562; c=relaxed/simple;
	bh=tPSrDa6p0FO1dYwsbA6ef87U7IdtAuvc2hqHTQkFuTM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Oxoi1vzVCtBivB8qjfD6dh+Cu8RQACNW+egJsiiANwiXOGyXNhAhaTLFC9xTHFTvJQM+7tG0hYCJKScbA8d1QYPX+hT1o0e5ZL4RoPejrGylhGppGNeMYhILjO2uy/MBh0Ek00chvHUFH4sU6nQqtdaGycPEkmT7Pvprtg8hhbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HLGG0YQM; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 22 Jul 2025 13:15:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753204557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=tPSrDa6p0FO1dYwsbA6ef87U7IdtAuvc2hqHTQkFuTM=;
	b=HLGG0YQML8yfzwdgPIDUKCHod+aa0roMQ7d/pCUk/Ig8QfNNc8z+sDpuOeSqRPkkeVl/6q
	q79C8uwkqwOxTRZ4uSAEcc2DW7Qlt1CC63Fz4gTbMtg8WmZueK7QzmAMAd5XwBjDuUYyd3
	5ofD9Wskovu/1Kf1YVwioFt67SF5xts=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Parav Pandit <parav@nvidia.com>, Petr Mladek <pmladek@suse.com>
Cc: syzbot+622acb507894a48b2ce9@syzkaller.appspotmail.com, 
	linux-kernel@vger.kernel.org
Subject: syzbot -  possible deadlock in console_lock_spinning_enable
Message-ID: <6v5z7ckfff46tbrjmeupaiwm2pm23yuvbrmy6kbe6tq2vl5e42@3cew7z6fgpye>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Someone set this to bcachefs, and it's not mine...

https://syzkaller.appspot.com/bug?extid=622acb507894a48b2ce9


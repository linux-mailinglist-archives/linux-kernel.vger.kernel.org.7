Return-Path: <linux-kernel+bounces-870932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C600C0C024
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 07:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23CD33BB43A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 06:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E082BE7D2;
	Mon, 27 Oct 2025 06:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PxEdLEri"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899CD27E06C
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 06:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761548131; cv=none; b=YmeOXHqilnRGojfg48//MHYlMNaKz22Z8C9gJC/YnkJ9CFsTTtSLUVmo+g8rFI5fiGvme7T9vR4MJq+ITltV6fzfkAktbSVIl1G/xqCIoO9Z7Yhax6dGYHyP3cM3vyWQhxJ+XND6Bd7ELmOeJgxrfqlX5Fxl72uxhXXq9G7+sGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761548131; c=relaxed/simple;
	bh=qC9d4NWaL9FhwC8yAhu7hrLw63vbVbx8IYfSo9pcv20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMa6RxuGrUyd4vIC8A4bLo9wKKhmbluJo/i+ZxuNtRVlNK6onBJXdWAMPB5d0ClRoYRbtEBU1HDL76b33l1z6+yQKlbVxp1XagWPTONw55xijlZozk/oPi6TsdPC+pfHJn17L2QK29zQK/XYR4c8cU2JNPw19u1Wi6aH4PvCQgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PxEdLEri; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qC9d4NWaL9FhwC8yAhu7hrLw63vbVbx8IYfSo9pcv20=; b=PxEdLEri4oIGmpbIfVCfoFPsSV
	9xOQmEW0928WbM41TLDZeC8xO3DtP9iWVAfhTr6lr0k80zozQwHwuL3uilGKo/ewJQ34mXB5f5qJG
	FYDPza0CxNE4MjlIqBTu2x/BWUJtGcd+H778ol7D/9dPFn9agDL8G71Hq3F7z7gA+EH9yD54AKuhP
	xFgUUbWcFzdZ2ZPYoJ6wwaZPTdEyocsZtJw1nb6H6DRLUS5dj5PjQSVkPlI6uFg5a/TlvsYw38DsY
	1SJOXofXyb60qpyOGBqKHhtrrzPWqeuaxRGtlVUD5gKVrbkBp47hO8HmMiyIFgJYq1JU4EI3z9vws
	6/lC9wmQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDH8b-0000000DEUt-0PMp;
	Mon, 27 Oct 2025 06:55:29 +0000
Date: Sun, 26 Oct 2025 23:55:29 -0700
From: Christoph Hellwig <hch@infradead.org>
To: linux@treblig.org
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/xxhash: remove more unused xxh functions
Message-ID: <aP8XYQZIZW2uB2_N@infradead.org>
References: <20251024205120.454508-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024205120.454508-1-linux@treblig.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

(just sending patches to one of my email addresses if preferred, I don't
care which one).



Return-Path: <linux-kernel+bounces-888340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 88605C3A8DA
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 12:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0564C4FEEEF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 11:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9522030DD1B;
	Thu,  6 Nov 2025 11:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="YBjhiNdi"
Received: from relay-us1.mymailcheap.com (relay-us1.mymailcheap.com [51.81.35.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071D02E0916
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 11:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.81.35.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762428074; cv=none; b=gGE7CcngMWaHaSsy76IUPo7TstIHOaRj01vP3Nxn/LwJoBIdMWrHkVeOOyd9wr8Cv891wJ3EMIQ+GYkWpY3rpY0fIVPGj24tFGo7uaP/WHtqemDhI5b3DxxnqAV2QJSpjXmUpHKnvn1qcl400rsyUt8VN4zIW1tPOT2npR+ZeHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762428074; c=relaxed/simple;
	bh=xGnMUKs+a16xWoar+O1Exr6sx95PE8I4R712yC0kWhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ejOfS0SB8G/9kFu4/J8meexwj+j5+Y8qExmZNK07/2/zvpUsZTZaTs4ojFX/QKe1n2RkyOiGDWM7uMlY4Twl7yj2ADAIW1otbfI9BP+lljn68oL6ic2I3BmALzHEKyx5QD6nQvGIXPslgFYRUnN6ftlo+Nfv48tFaWhtzV78ssE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=YBjhiNdi; arc=none smtp.client-ip=51.81.35.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.248.207])
	by relay-us1.mymailcheap.com (Postfix) with ESMTPS id 4CD30224A3
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 11:14:09 +0000 (UTC)
Received: from relay3.mymailcheap.com (relay3.mymailcheap.com [217.182.66.161])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id 81DA126344
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 11:14:00 +0000 (UTC)
Received: from nf2.mymailcheap.com (nf2.mymailcheap.com [54.39.180.165])
	by relay3.mymailcheap.com (Postfix) with ESMTPS id 36D643E917;
	Thu,  6 Nov 2025 11:13:53 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf2.mymailcheap.com (Postfix) with ESMTPSA id 531B140178;
	Thu,  6 Nov 2025 11:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1762427631; bh=xGnMUKs+a16xWoar+O1Exr6sx95PE8I4R712yC0kWhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YBjhiNdiuVLW2CQXTAinJ1VIejMNqxROO8nnng8nb2eFTT7OvGtBqq2CPSMkt0kDC
	 VrgTyCiWBgo1acsmGfAX+EaovZYHF2U2/rj2matPu0yUQRTeJVP5SAZHjTBVdkfB0o
	 0IZdJWf+HGX2X0GFjy+iTW8JyLu7NyCWS1K7CBJQ=
Received: from avenger-ThinkPad-T14-Gen-4 (unknown [114.247.186.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 64CED40594;
	Thu,  6 Nov 2025 11:13:47 +0000 (UTC)
From: WangYuli <wangyuli@aosc.io>
To: guanwentao@uniontech.com
Cc: Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	niecheng1@uniontech.com,
	vbabka@suse.cz,
	zhanjun@uniontech.com,
	WangYuli <wangyuli@aosc.io>
Subject: Re: [PATCH] mm: cleanup vma_iter_bulk_alloc
Date: Thu,  6 Nov 2025 19:13:32 +0800
Message-ID: <20251106111332.809322-1-wangyuli@aosc.io>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251106063424.3381872-1-guanwentao@uniontech.com>
References: <20251106063424.3381872-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 531B140178
X-Rspamd-Server: nf2.mymailcheap.com
X-Spamd-Result: default: False [1.40 / 10.00];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	SINGLE_SHORT_PART(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	SPFBL_URIBL_EMAIL_FAIL(0.00)[wangyuli.aosc.io:server fail];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Rspamd-Action: no action

Reviewed-by: WangYuli <wangyuli@aosc.io>



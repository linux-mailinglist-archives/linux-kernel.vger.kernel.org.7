Return-Path: <linux-kernel+bounces-808869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5130AB505A6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBF7E1B2418D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 18:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67D8340D90;
	Tue,  9 Sep 2025 18:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="AVg4RGjn"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784EF3054F0;
	Tue,  9 Sep 2025 18:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757444181; cv=none; b=g6h3DlGLtQsllHqHKOWL88H+0HtIbS5h3x0u/hOEFfvnJE6vB9I9u/Q8YRK8UCcgmpHqnZAXqbs+60yI6Mb9/vNVE1rmGsAfbrWGeOdx7jrjBbjY9z5tDkC0IZsNeoGq/JUvZbEOKQ76s0S034qHCngnMV5gu8QpEPE2DWQfK7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757444181; c=relaxed/simple;
	bh=bAAacRTwBvWHbThT5dskMzgCZyjQ3m5UWQ9AiPes6xQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AoFtBy4QsS2xbW3Rq6NK9I0akLo5izAqeWMwgGNVnpw9ObQGGbzqa7jbAQb1V93YvwX20rIeD/exlmR8F/QUTrYk6IO8lRvYzhUdQcxQ1FLKsr0Cwu1PDnqxMlvXI6Zks6mXL22Q4324EQfufWefXrtPqQ0N5HxhNwzlWPeT/Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=AVg4RGjn; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6C14D40AF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1757444178; bh=/Ai2lGZUTpRw+R7WvDqNiYrO2zQdMsjjZca0cQdGh1E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=AVg4RGjn62ceUBV+3muvLzqUFtXbqeApMY+PIg+AElShltL0z0V5ZQnpJl7F3jSRI
	 cLXdgZsSr4CfOfBcV1auTWiYgQk91mVZN7oG0/255ACCZqeeW6F/QR18us/vH3NMH4
	 jwe0WOtQoNktk5QpuIG4z3n8ho9Pv+xhlK+IgIExsXvXcTLWGcyzcjZCjYk1XOcqEb
	 ItqqhObC7PgNVSU3jghDmPZNNITxbUKJEmxatD27h2tS3nxnOhzIFFkBdp31DZd9Ub
	 658v96a3lLbPKbmrgbBV/vx7nMSO166vXuWem/+e4pv/1K+unW/xgzsInm0linCjv3
	 2krcxXnByMz3A==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 6C14D40AF9;
	Tue,  9 Sep 2025 18:56:18 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, Alice
 Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
 <gary@garyguo.net>, Trevor Gross <tmgross@umich.edu>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v4 08/19] tools/docs: sphinx-build-wrapper: add a
 wrapper for sphinx-build
In-Reply-To: <7tk2mkydbcblodhipoddued5smsc3ifnmeqen5wv7eu3mbmvgi@nwxqo5366umj>
References: <cover.1756969623.git.mchehab+huawei@kernel.org>
 <e019f951190a732f9ac0b21bcda7e49af3bd5cbd.1756969623.git.mchehab+huawei@kernel.org>
 <87plbzwubl.fsf@trenco.lwn.net>
 <7tk2mkydbcblodhipoddued5smsc3ifnmeqen5wv7eu3mbmvgi@nwxqo5366umj>
Date: Tue, 09 Sep 2025 12:56:17 -0600
Message-ID: <87y0qnv4j2.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Basically, what happens is that the number of jobs can be on
> different places:

There is a lot of complexity there, and spread out between __init__(),
run_sphinx(), and handle_pdf().  Is there any way to create a single
figure_out_how_many_damn_jobs() and coalesce that logic there?  That
would help make that part of the system a bit more comprehensible.

That said, I've been unable to make this change break in my testing.  I
guess I'm not seeing a lot of impediments to applying the next version
at this point.

Thanks,

jon


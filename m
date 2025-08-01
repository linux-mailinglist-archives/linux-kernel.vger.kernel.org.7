Return-Path: <linux-kernel+bounces-752747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EB3B17A71
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 02:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C6671C2859A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 00:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B809117E4;
	Fri,  1 Aug 2025 00:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="d7tHrDPW"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A963D76;
	Fri,  1 Aug 2025 00:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754007223; cv=none; b=QeA3ph6B0SehaGdMWwY9n9xbE6Do59LMWucrSxqsIRw22aSPVWZEcnvFBjt4nthOXrlcQff4PVkErEWFmErwwaswuMJ2iJcnkTVAFx9lBdLmM3kyd1+vCxT2coONHjs5QXqojMMlcYDR1DUTARggcOK6bNRJKvd6sUOFUfg+TL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754007223; c=relaxed/simple;
	bh=r9JQz6KgZpMeeYe0MUfwwe88eKPBaHMM6AMkqvbGN0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zwjy5icULyorCLnUTM+Rf5HBuhfzK3QYsiob4AEEtH7J+0CnGIExSJT0ZWXZHlXRQnv5G6bxn0DUH+STZFyHQRSqlSxv2cyMKX+vWAfSWvXI5k3oGiacCKUKwAwcjyDHdC8kXAn5IEQGMVoUdugVWvD3+M32cF1yCwi1GCIuLbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=d7tHrDPW; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A209D40AB3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1754007215; bh=tFsTB4oVMA9wlKjVgWdbkvCK3Cu+4U56OGCJ/3fj7Qw=;
	h=From:To:Cc:Subject:Date:From;
	b=d7tHrDPWyCbZEZAYXa3JTZE7eN3h+RopIU2FoFqF3WIlmooDdEbKA2sMtelpW7zBi
	 7W0/L99OQnL7+k1hhBGqGH8ooa1SMDhfPaGkba89G7MCXC247KSdNTBqLe686h1kza
	 +tCyBWSnrMzp7fLaizkkn1TDZt8JxWmLDdBTN+J57g9fiN4z5dCyMirRFnhKzoVmmB
	 Dr/c3PaEpUg6oLW0+c27WiP5GpxjNhx0zbEFhmcBxmBCDsVHoyQD3jVoLLJ9Lm6gZe
	 q5hURBazRjBDA1eM7iNtMuaTgaDGs2qx3Bq/kCVVibEYJypTtqXep8JAEMVBayhDLt
	 BvXXqIJ1baSIw==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id A209D40AB3;
	Fri,  1 Aug 2025 00:13:34 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 00/12] docs: kdoc: thrash up dump_struct()
Date: Thu, 31 Jul 2025 18:13:14 -0600
Message-ID: <20250801001326.924276-1-corbet@lwn.net>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In my ongoing effort to truly understand our new kernel-doc, I continue to
make changes to improve the code, and to try to make the understanding task
easier for the next person.  These patches focus on dump_struct() in
particular, which starts out at nearly 300 lines long - to much to fit into
my little brain anyway.  Hopefully the result is easier to manage.

There are no changes in the rendered docs.

(At some point I think this code could benefit from a deeper rework.  We
are essentially making three parsing passes over these declarations -
dump_struct(), create_parameter_list(), and push_parameter() for structs -
and it seems like we ought to be able to do better.  But that's for another
day.)

(This is post-merge-window material, obviously).

Jonathan Corbet (12):
  docs: kdoc: consolidate the stripping of private struct/union members
  docs: kdoc: Move a regex line in dump_struct()
  docs: kdoc: backslashectomy in kdoc_parser
  docs: kdoc: move the prefix transforms out of dump_struct()
  docs: kdoc: split top-level prototype parsing out of dump_struct()
  docs: kdoc: split struct-member rewriting out of dump_struct()
  docs: kdoc: rework the rewrite_struct_members() main loop
  docs: kdoc: remove an extraneous strip() call
  docs: kdoc: Some rewrite_struct_members() commenting
  docs: kdoc: further rewrite_struct_members() cleanup
  docs: kdoc: extract output formatting from dump_struct()
  docs: kdoc: a few final dump_struct() touches

 scripts/lib/kdoc/kdoc_parser.py | 516 +++++++++++++++++---------------
 1 file changed, 267 insertions(+), 249 deletions(-)

-- 
2.50.1



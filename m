Return-Path: <linux-kernel+bounces-832511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F02FB9F8C8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DAA51C21D3B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953A11E9B2D;
	Thu, 25 Sep 2025 13:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnAvMvQB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13E5238C19
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758806437; cv=none; b=VRM7+QEZiXYcEli3puSHffsnCYxoC8IUa261vLjI1AyN3Omqatw4ol8mWqPTu+IFDMyQ86m6VD2G8QgwWGruXwUG4C+U3tJD70i3dOJhYZEspLOqnBtp48dXqGgi5E0WrMQkoZ7OIuO7Ldlm7vYe/tKouXaKD88dm7fI1zwviTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758806437; c=relaxed/simple;
	bh=m8NK71M0rwQz7Nz6INMiWs0mMXRnSUTOI/W1NgnYV2g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Bz+0nTO/+hQZlVlihq+yDS9rGRDEebz6MsLvXxhbFmvGXfGGXoscf19XSEbjwmEXmZ2PE2ajQBNDt9RTgYeSjrq4336yN543uOOy0QWg6hJwaFwtIPxmhwo9qRggklcwa21uCWyj0TkiPAVr1mN7WAQOmf87Q3M7ab4Rbuoept8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnAvMvQB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE57C4CEF0;
	Thu, 25 Sep 2025 13:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758806436;
	bh=m8NK71M0rwQz7Nz6INMiWs0mMXRnSUTOI/W1NgnYV2g=;
	h=Date:From:To:Cc:Subject:From;
	b=fnAvMvQBqKjZtroWtD7Nsotliw+SDWSoAOUPCnSDaB1t6JrKhbTRQ5YtU6bzytSTj
	 vRqwbtIs9RJBeo8SYpL3jc79EnnJJPcA4WDfo/2XneaTTvURwzMjL2KP8OyBtIP150
	 LV/o0Mpcv/+8D2D8lg/cl8pYJraVF0k5TTpz0rUZsKqbQRKwm1BIWhXdO5ThSPuPBY
	 Egvyb9XTJsxSGQj3K/bugLCEyvRiy3kqnt5bet165SKEQSEJzoDigUXWbuEXlBfs7G
	 xbBxGOzbQt/XgT5pLO6qFXfm9eE5El7i4ThA44ajH3YCQFlNzdiyZkxi24N7ORwKJa
	 oB7I45kBpEiww==
Date: Thu, 25 Sep 2025 15:20:28 +0200
From: Alejandro Colomar <alx@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, Kees Cook <kees@kernel.org>, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Marco Elver <elver@google.com>, Michal Hocko <mhocko@suse.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Jann Horn <jannh@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1 0/3] Add ENDOF(), and use it to fix off-by-one bugs
Message-ID: <cover.1758806023.git.alx@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi!

I've split some of the patches from the string patch set, as these are
obvious bug fixes that are trivial to accept.

I've reset the version number of the patch set to 1, to not conflict
with the version numbering of the string series.


Have a lovely day!
Alex

Alejandro Colomar (3):
  array_size.h: Add ENDOF()
  mm: Fix benign off-by-one bugs
  kernel: Fix off-by-one benign bugs

 include/linux/array_size.h | 6 ++++++
 kernel/kcsan/kcsan_test.c  | 4 ++--
 mm/kfence/kfence_test.c    | 4 ++--
 mm/kmsan/kmsan_test.c      | 2 +-
 4 files changed, 11 insertions(+), 5 deletions(-)

-- 
2.51.0



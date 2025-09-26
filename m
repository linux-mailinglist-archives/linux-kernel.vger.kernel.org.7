Return-Path: <linux-kernel+bounces-834676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 874EDBA53FA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 23:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7D09560929
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 21:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9DC1A2C11;
	Fri, 26 Sep 2025 21:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="kxixSHYF"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287FE287253
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 21:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758923284; cv=none; b=X2VfiUcwDTEYDT4dAoIkE1IVmTd3TjdS1VxrCYN9h4J2vw3X+g4yI6K88Q7kO5FVcNQUUaAqVPe0V+yB31ssBuSz1CctMa8/zDD8x1szscunL6N5v2H+Nx6b2CzYJSET7ViNXQuRUuQR6CUr43unq0FoSIfRaBzyA8F1burL624=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758923284; c=relaxed/simple;
	bh=9NNO5o373SqWmt6lRk8DvxTwe9onkIyB00giMfN4AYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z1VNWD4U8bGLnwBMMrOXzu79IMRrd6DVpP7AjxvtzApO8DkLvoTk0qGivqMKcFatkVgifdl78JAdlLV86JMrthGdjAnbngovzZLitHiGRTwcFt36bet8MXoEWwkFpGLu7IIhJtUcxYHLYYrRp7+3QVtsZN4w8OW35FcjWJyXa5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=kxixSHYF; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-115-162.bstnma.fios.verizon.net [173.48.115.162])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 58QLlslu014684
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 17:47:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1758923276; bh=5zfWWRMDmJQ6sgyIHjdjHF2ZrLrX84iVpbUGQfi3jjs=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=kxixSHYF6P1m94PzYyxOuBt82NAYLUHFK9vEdlDALwwVYgr8QsYmUOyLpV6RBIJ4f
	 G6DAvXllMeLqUdcUjDBGllNpwmcMCqV+nDBbFqn/vjLrdnQ8jF5/Qbaq1bolxWW3o3
	 eZ1RXymYlJpeGh1/jz9FSKiXRCdK3OBBnBn9IlxMPpfesKd6NnUA6aXRfFEyNIKoGy
	 sWHbbTS2EPT2iqzQcKDbGfaAllg/n048smGwJwl0ZTTKrF+/7ltJYHgMhEKmIrzbyY
	 0bFP+dl653KnehjvZe/ymzfUYUTG+iLp9LuZ2Xf2szztiw+5knoh4YxaO+Yn4VOxIQ
	 58KC8iLSx5eVg==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id D31B82E00D5; Fri, 26 Sep 2025 17:47:53 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: adilger.kernel@dilger.ca, Ahmet Eray Karadag <eraykrdg1@gmail.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+0be4f339a8218d2a5bb1@syzkaller.appspotmail.com,
        Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Subject: Re: [PATCH v2] Fix: ext4: guard against EA inode refcount underflow in xattr update
Date: Fri, 26 Sep 2025 17:47:35 -0400
Message-ID: <175892300646.128029.18166257596583769324.b4-ty@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920021342.45575-1-eraykrdg1@gmail.com>
References: <20250918175545.48297-1-eraykrdg1@gmail.com> <20250920021342.45575-1-eraykrdg1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 20 Sep 2025 05:13:43 +0300, Ahmet Eray Karadag wrote:
> syzkaller found a path where ext4_xattr_inode_update_ref() reads an EA
> inode refcount that is already <= 0 and then applies ref_change (often
> -1). That lets the refcount underflow and we proceed with a bogus value,
> triggering errors like:
> 
>   EXT4-fs error: EA inode <n> ref underflow: ref_count=-1 ref_change=-1
>   EXT4-fs warning: ea_inode dec ref err=-117
> 
> [...]

Applied, thanks!

[1/1] Fix: ext4: guard against EA inode refcount underflow in xattr update
      commit: 57295e835408d8d425bef58da5253465db3d6888

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


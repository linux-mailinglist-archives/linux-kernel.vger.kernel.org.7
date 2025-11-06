Return-Path: <linux-kernel+bounces-888877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEA9C3C262
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 16:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4938635191B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 15:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091E6302179;
	Thu,  6 Nov 2025 15:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Tc7XGnmP"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48AC2571C5
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 15:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762443981; cv=none; b=bHcFqrvcqkaVlMDCq6D0ZXyzOFXnjWokPyuTj/X4gq3GUPoKix9p8/EMZkWmiyp14N38ANfLVRlIw7dRuErjk7AgxMvAYiCx1xPLuaiX2y9M7HInappiOqxswu5NDQ9oC5iZc9srVMH1ZlxtGa2HlhtGhdQI+tUCiXQjmzz+UvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762443981; c=relaxed/simple;
	bh=B+UGheMgEsNyZTFyDezsqey+Ye9J3I4uGlRqQyERUsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FsT2N4jEeHdvMoR9sdP+yxKCKj2WWeIHSKoNwN8n4zt4uyPC4CZxHOmYIWABPtz6EDPGOTBdGfUxvLayJmWWI0TJ+yZrIZ8COFHtjlNq+1vUZaL0QqRyDAIjcy3rtD0xk4GnjzAtMkfsu5gut9XC47kTsS5X9DtbJTLLvc/LM68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Tc7XGnmP; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-124-240.bstnma.fios.verizon.net [173.48.124.240])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5A6FjqdX005527
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 6 Nov 2025 10:45:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1762443955; bh=UGc7IAsi5k7X/ZNrBvqTxtQUxRzMNJ5fSoiXPuhWQeE=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=Tc7XGnmPOTd2pENZGABKEyHXvav3+xcqdR7Y4czpVqe5O/MbTDCBAHUUHXiMTTpTg
	 lb2z1ELCH8GLouAxuw3YbpDAWEPbusMy4eHqtSGNimS4ef+J1xVj7lMKrJyEmMhGxI
	 LlWL/MtT33L9iD9NoT4UyyaPrQCTMzO1HzcImGSFzW430DGSJkCXyTLUVvqzvr/UNB
	 OLWT8k0tlk+LBYsH7daEighqbrUov87nLsBuVjSYUD+H3vqw9hX+1M4cJMNZG3gbHJ
	 YkytcCwkGpvjZJPZREjdI2uHvvVfiyZU/hRzW3fu4QvKykhs3xPIA9zh+IZZwfyyS/
	 eoVhjfG57LkKQ==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 7029F2E00D7; Thu, 06 Nov 2025 10:45:52 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: lkp@intel.com, Ranganath V N <vnranganath.20@gmail.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        david.hunter.linux@gmail.com, khalid@kernel.org,
        linux-ext4@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
        skhan@linuxfoundation.org
Subject: Re: [PATCH v2] fs: ext4: fix uninitialized symbols
Date: Thu,  6 Nov 2025 10:45:47 -0500
Message-ID: <176244393634.3131189.2721696855170413272.b4-ty@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251011063830.47485-1-vnranganath.20@gmail.com>
References: <202510110207.yBvUMr5Z-lkp@intel.com> <20251011063830.47485-1-vnranganath.20@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 11 Oct 2025 12:08:29 +0530, Ranganath V N wrote:
> Fix the issue detected by the smatch tool.
> 
> fs/ext4/inode.c:3583 ext4_map_blocks_atomic_write_slow() error: uninitialized symbol 'next_pblk'.
> fs/ext4/namei.c:1776 ext4_lookup() error: uninitialized symbol 'de'.
> fs/ext4/namei.c:1829 ext4_get_parent() error: uninitialized symbol 'de'.
> fs/ext4/namei.c:3162 ext4_rmdir() error: uninitialized symbol 'de'.
> fs/ext4/namei.c:3242 __ext4_unlink() error: uninitialized symbol 'de'.
> fs/ext4/namei.c:3697 ext4_find_delete_entry() error: uninitialized symbol 'de'.
> 
> [...]

Applied, thanks!

[1/1] fs: ext4: fix uninitialized symbols
      commit: 6640d552185f7c11235c64a832004db9af119b2d

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


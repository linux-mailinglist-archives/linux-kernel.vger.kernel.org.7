Return-Path: <linux-kernel+bounces-655816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F2AABDD6F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 16:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91B527AAC88
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 14:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D49724A057;
	Tue, 20 May 2025 14:40:35 +0000 (UTC)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BAB24BBF4
	for <linux-kernel@vger.kernel.org>; Tue, 20 May 2025 14:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747752034; cv=none; b=tgRPTpIafpy/QXeUePf6mJZ0dnNpin1XFOQNOIigiGElGS/Yol+0tR10nN8VthB6RRgfrAVSK9NHxwg+3G32aijVLcVIdxi6HwRYa0D/6jdSrbd95NqrbHcJBB/be6Xfq+CpvdtuW1ymB+8v1MAzeaheFEd28j8/G8E5aixYA40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747752034; c=relaxed/simple;
	bh=royVGE6Euv9YlUy2WwSPwxyOnR2o8jIl68zgzWacsqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u07emCyvKrPwz6WRgRH8z+Ewl7bqfmONXfGlglGA2aI3r/ha10FrQVjErC8oyiX+lp8RdtOjm7LS123y2zM5zcn+bvcxe07+Oxi65TmVK1pMmphvpEXgDgua0R5v00ocraMWqhfY2lh5B5DPbjdrCINULHVBCZxYbxO0Dgawmxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-173.bstnma.fios.verizon.net [173.48.111.173])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 54KEeO6x013130
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 10:40:25 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id B25F42E00DD; Tue, 20 May 2025 10:40:24 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: jack@suse.cz, Jeongjun Park <aha310510@gmail.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+de24c3fe3c4091051710@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] jbd2: fix data-race and null-ptr-deref in jbd2_journal_dirty_metadata()
Date: Tue, 20 May 2025 10:40:09 -0400
Message-ID: <174775151765.432196.16616898847416276522.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250514130855.99010-1-aha310510@gmail.com>
References: <20250514130855.99010-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 14 May 2025 22:08:55 +0900, Jeongjun Park wrote:
> Since handle->h_transaction may be a NULL pointer, so we should change it
> to call is_handle_aborted(handle) first before dereferencing it.
> 
> And the following data-race was reported in my fuzzer:
> 
> ==================================================================
> BUG: KCSAN: data-race in jbd2_journal_dirty_metadata / jbd2_journal_dirty_metadata
> 
> [...]

Applied, thanks!

[1/1] jbd2: fix data-race and null-ptr-deref in jbd2_journal_dirty_metadata()
      commit: af98b0157adf6504fade79b3e6cb260c4ff68e37

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


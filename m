Return-Path: <linux-kernel+bounces-769102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8C7B269FF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53A9B7BA9CC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA9A218AA3;
	Thu, 14 Aug 2025 14:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="DxLbOwF2"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFAA21A459
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 14:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755182978; cv=none; b=L+JDhpUJMjylfzI+RkrwujXNNrdMfJCWlE2MUFq7LxPj4Ff0C1Vl51bTbMSMsrGjKRrcb0bQwtEPmKv/XA90KgAKXqEXXY+2muklwkrovyxvOXC8tsuJZJWy8z1MsWnzFiBNP7+qXAL9jAZ6gy7r4msPqFzC/gwj9P3Mf8coKac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755182978; c=relaxed/simple;
	bh=65Qlw9mCW05HC8nqjf7hl/PAv94A3ewrr0LGuyxTuWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sVXCEJ+pynlk3sHtivRh0JTNYGTHVAWTvBxpF+Wxe5oMsIipmYa4XNzgD5MbFSWXWsmdXmYeOguQtVnmfVIYb3VwKshnjNSLcPCb5AzzZhuVzDwJNIQcKFFSmiitp3uJAI/1Z7gV+hZ55AstgcCmET0mjjqbLeVIoIfJDMSUOLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=DxLbOwF2; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-113-254.bstnma.fios.verizon.net [173.48.113.254])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 57EEmpOT028598
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 10:48:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1755182937; bh=X/u7DAPn1uapDj6cV4WX9wukkt3WAmbf0bAmypGYwn4=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=DxLbOwF2wOAIgSdNMjLPzoCrm1YWIoDJHscecnFT++52pfsyzVZP0zrWAGMjLnQSe
	 WoZQ5u7w+vYbN9ZKOwtaANDvjg4i1VU0INNxwXd86oBXawBBRfD3hNukhttLyAVCEE
	 IH3A6wlIAlq8uMxLstBEfE8b/wL21H1ZpBW4Hq3q2DbwYjvLLYfmfuoBBMZub4dUEK
	 n5nrstD1rRLwR89coaGflmoFe7CDxf31whUEviOdzu39mbxOwNzBm1IT/i0tw77ABx
	 zdB6m+xyEJaGQjFTttKVayFhP35NMXZxFxfnnNcQz0+gYehsv2mNf4payN80Duaei7
	 iH5jasYMiRy7w==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id D7AB72E00DE; Thu, 14 Aug 2025 10:48:48 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Eric Biggers <ebiggers@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Qianfeng Rong <rongqianfeng@vivo.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, willy@infradead.org
Subject: Re: [PATCH 0/4] fs: Remove redundant __GFP_NOWARN
Date: Thu, 14 Aug 2025 10:48:46 -0400
Message-ID: <175518289076.1126827.2391485209969195669.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250803102243.623705-1-rongqianfeng@vivo.com>
References: <20250803102243.623705-1-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 03 Aug 2025 18:22:38 +0800, Qianfeng Rong wrote:
> Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT")
> made GFP_NOWAIT implicitly include __GFP_NOWARN.
> 
> Therefore, explicit __GFP_NOWARN combined with GFP_NOWAIT
> (e.g., `GFP_NOWAIT | __GFP_NOWARN`) is now redundant. Let's clean
> up these redundant flags across subsystems.
> 
> [...]

Applied, thanks!

[3/4] ext4: Remove redundant __GFP_NOWARN
      commit: 4ba97589ed19210ff808929052696f5636139823

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


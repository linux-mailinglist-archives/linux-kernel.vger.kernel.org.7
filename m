Return-Path: <linux-kernel+bounces-834683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4094CBA5430
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 23:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F09CF625F81
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 21:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3A730F928;
	Fri, 26 Sep 2025 21:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="noAULKeq"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E83530F808
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 21:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758923313; cv=none; b=ol5naqpn0/1n7DCM40neWAmjQAxo9qZihnybaC+rWIy8qZqVzAwHJe59QZuWFob7Tf7NAPpjAuRs5GNIcK1QjzwhBGRnsuqt7mTCtcF/kgL/AagONfOHksnnNiy8FvVdfaV7U38j0rIK8UYltVES91zmLIBagUKjUtCaQTpqGeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758923313; c=relaxed/simple;
	bh=lxiRKOPjNBCLYP3Ujf6wO7spHZA6f5jBkt47JWpquLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zm6dcKXL0OZX3dT3u/QUhoBYQe0B1LAREJSzOvXWLW9r9Spp4Ude9Fx1G3GjQsNkz3Gk9hapZXxdb8LADd3/BA+fgz5x16w9ICUqqQUGy4xbHfxxd9wYd88xs6OzfGLnLYdLQx//1fxrL2WsduECBgRO40evh2+utXMIKiWZZ+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=noAULKeq; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-115-162.bstnma.fios.verizon.net [173.48.115.162])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 58QLls72014699
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 17:47:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1758923276; bh=b0n4CKQmMvBflrA5RwASZQlbaLxfJAPAjhaY01zc4ss=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=noAULKeqqDfqnmLGreY3DN958Z1BeM+Ifs4m4MLThAm2J2cROngHMOfxMAGc3HMBb
	 AEH+2dPJdVZ4+ZsG5/diepBY9m/O+YYs5JtUEmvPMcwQkGLGpEnsKl96A/MWpGywtW
	 w/jnWQxcJKxSqvMVQvnFjUCGbbrD/SLhKm7vmpp68OK9OLGjIfyDPCaPKmRbAq9qR4
	 TOaw4ovRg3ua7qhRfowliUCiG+Qqq4YcpbtVIZLz0dQzRZ6DJyafqU9y7UFfK4hbmB
	 dABvwLuJn+3OE+2yUc/Yqt+QstlYkPTloX8+UZrU9QFpxoiL7Su3Iqs/cj8DwTPJuM
	 2Kd9Z2tWD4j/Q==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id D18332E00D9; Fri, 26 Sep 2025 17:47:53 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: adilger.kernel@dilger.ca, chuguangqing <chuguangqing@inspur.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] fs: ext4: change GFP_KERNEL to GFP_NOFS to avoid deadlock
Date: Fri, 26 Sep 2025 17:47:34 -0400
Message-ID: <175892300639.128029.10746757557072943307.b4-ty@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250806022849.1415-2-chuguangqing@inspur.com>
References: <20250806022849.1415-1-chuguangqing@inspur.com> <20250806022849.1415-2-chuguangqing@inspur.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 06 Aug 2025 10:28:49 +0800, chuguangqing wrote:
> The parent function ext4_xattr_inode_lookup_create already uses GFP_NOFS for memory alloction, so the function ext4_xattr_inode_cache_find should use same gfp_flag.
> 
> 

Applied, thanks!

[1/1] fs: ext4: change GFP_KERNEL to GFP_NOFS to avoid deadlock
      commit: 1534f72dc2a11ded38b0e0268fbcc0ca24e9fd4a

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


Return-Path: <linux-kernel+bounces-731827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E898B05A57
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 414771780B4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 12:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D692E0403;
	Tue, 15 Jul 2025 12:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="JIovepZd"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4985D2E03F5
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 12:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752582922; cv=none; b=lY4mACbg7blKXWuob5e1TCOdh+7V23E16V1ak0Y70+9xgqZMc07vxO4/jQ28k8abH5K4/7SmZfjC1DMagS5D23kgErfFVeDQAWrPe5vLHknqIM1BcaHuX+2RWGlhUcxmnVBRkKCjzRFB6vXk/6ZlPsvJKucBSr+tHcBHeHuR2hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752582922; c=relaxed/simple;
	bh=QLo89csj3kq3EH40mhgTDCdEVSZgVt+rpcBpJXUGG/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V8vA+B+ZtXVzKOLmxnwKlQ9I+4saWHRckyy1TNOOcQlOUOclZuW4fwzl4GVH/3+YVR8PFMX8hlh4Ks9WT96ZcKUVyNOPq8UMfNH4GDH2B1L7EIdw06MzcOBh3Z5JSsiKWY1brzqGtOp5cfB7XlWI1zchJUu4Z9dqusNHO6P1DKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=JIovepZd; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-108-26-156-131.bstnma.fios.verizon.net [108.26.156.131])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 56FCYsKf005184
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 08:34:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1752582898; bh=JEmCrzAwkf+pL0BE8Ts9Gq27U59HE+yr1Fpegkv0wnE=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=JIovepZdZp+sq9wxOa24YaAKQWfwpYH1SYaeUwfRXHpK8nJQkO+8vCn3RYRiEtTH3
	 81C2l7YkvrB2um8E9Ww1eKXO09w9gg2VjLHpt7VOP/tf3Fnyo7y8wakIpKjiXoqmE3
	 ny4+aiCsgMFiPiAnlQ7HD+BttBiuKBFqUv6ImjvFWlOFEIAVXu43o6Uyg+98AxaAWB
	 IwSyazeqUSQA7u9akobfmwYqAD4I6hFXQiju5tH2AXKgGYMBBckwqIFtkdo1YmhaS7
	 cpwMV5SoyXWzxLnyFnBQe+ELxfkaK7HRwGiaSAQeHTArXiox4HFBTccDNCrWOzIIpY
	 ate9EOnTdKBzQ==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 98FA12E00D5; Tue, 15 Jul 2025 08:34:54 -0400 (EDT)
Date: Tue, 15 Jul 2025 08:34:54 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: chuguangqing <chuguangqing@inspur.com>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] ext4: add FALLOC_FL_ALLOCATE_RANGE to supported
 flags mask
Message-ID: <20250715123454.GD74698@mit.edu>
References: <20250715043808.5808-2-chuguangqing@inspur.com>
 <20250715064536.12053-1-chuguangqing@inspur.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715064536.12053-1-chuguangqing@inspur.com>

On Tue, Jul 15, 2025 at 02:45:18PM +0800, chuguangqing wrote:
> Note that since FALLOC_FL_ALLOCATE_RANGE is defined as 0x00, this addition
> has no functional modifications.
> 
> Signed-off-by: chuguangqing <chuguangqing@inspur.com>

I'll note that this isn't something which any of the other file
systems (btrfs, xfs, etc.) is doing.

				- Ted
				


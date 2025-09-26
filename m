Return-Path: <linux-kernel+bounces-834679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F3DBA540F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 23:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA1661C05E7F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 21:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28539290DBB;
	Fri, 26 Sep 2025 21:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="iAzK5mR1"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1135930CDA6
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 21:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758923289; cv=none; b=dWFS4vwSkV2tkD+vvkT0Fh6i0V+thw5ZU+9n2kgLE86xuUIY4XqAd6mZ0dsh61s4hbGUc2yYb6Ead2czsj+ZSQZxhZOr0oYs67/0xhAvd5rNxbl+9HunsmvmzJcZugnIRwWHYJ3TPuDPzE22w1HxUat5dwpskHbt86UPExy7vbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758923289; c=relaxed/simple;
	bh=zSwZ7JZePYVEUs0auOYAEaE96tXsE0OuSSS2cNbn/Mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dXfoSjsrzWAHSrPB2N5l6iSoi1zLgX9SheMQ4OnLsc6ZMa/1OoYN9qja7AJ6kQnUfcdDBziXs/gkgbxcro5sP5VNpoyeuztVtoNgMjD0KGchrgyxwRSGx+59YbLPQXXyl15oJUZbrRy2yBRvBZvZ5WgHCYd9b559RU14TtsU4Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=iAzK5mR1; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-115-162.bstnma.fios.verizon.net [173.48.115.162])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 58QLltSb014727
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 17:47:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1758923277; bh=cU1CY2pBQPsGcZIdQlXQ4KkeBnnjD02usQK4qOh+RuI=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=iAzK5mR1ZT19nODXATG8oFxUqDGMIyR2antni0Q9tWDaET9gIIVAfTs+O+7mdq8NU
	 YM9LElQnWcaZ4+IlqGrb8Ng+o61t6RE74CJyEQ/+Nd37a19q/EuMZWE6mAWvjyWXbC
	 IYd/Skk0iRM/adrunkrgAtsLTrGSb43ZnrVuUeH6ZAAMRG76nz8qi40pt32sYKW939
	 mHtWhKzDXsXPCbN3BuRdWVFeUSJehPKuEs4HLWmOPkmJfJFeH+TW3P57MObLZ2lFwt
	 JZODjwpdzdHLsjy72kAxwnayE4ZcQlJj2vm8Q+avA8ETUTpblMtKUm7MCBRagNMQgM
	 V3TcIJlgLiirQ==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id E02C42E00DF; Fri, 26 Sep 2025 17:47:53 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org,
        Lukas Bulwahn <lbulwahn@redhat.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] ext4: remove obsolete EXT3 config options
Date: Fri, 26 Sep 2025 17:47:40 -0400
Message-ID: <175892300642.128029.13958443987269217396.b4-ty@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250827090808.80287-1-lukas.bulwahn@redhat.com>
References: <20250827090808.80287-1-lukas.bulwahn@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 27 Aug 2025 11:08:08 +0200, Lukas Bulwahn wrote:
> In June 2015, commit c290ea01abb7 ("fs: Remove ext3 filesystem driver")
> removed the historic ext3 filesystem support as ext3 partitions are fully
> supported with the ext4 filesystem support. To simplify updating the kernel
> build configuration, which had only EXT3 support but not EXT4 support
> enabled, the three config options EXT3_{FS,FS_POSIX_ACL,FS_SECURITY} were
> kept, instead of immediately removing them. The three options just enable
> the corresponding EXT4 counterparts when configs from older kernel versions
> are used to build on later kernel versions. This ensures that the kernels
> from those kernel build configurations would then continue to have EXT4
> enabled for supporting booting from ext3 and ext4 file systems, to avoid
> potential unexpected surprises.
> 
> [...]

Applied, thanks!

[1/1] ext4: remove obsolete EXT3 config options
      commit: d6ace46c82fd2d3bdb58c35e3dd5cb9e83e136bf

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


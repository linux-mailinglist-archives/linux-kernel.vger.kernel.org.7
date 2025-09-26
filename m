Return-Path: <linux-kernel+bounces-834684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D66CBA5439
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 23:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD76B1C0420E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 21:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E056311958;
	Fri, 26 Sep 2025 21:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="NdEQD4LV"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DB830BBB3
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 21:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758923314; cv=none; b=mlSI6AfQa9rdw/iTZpQ1VEpijUQYAUZj5iizJqMa7f4sifuR54wBvZEmBzUguxEe31cZm9l2WUCQeo9IasHn0NM140rcIDoj21BUcxkpBCc22u24IdCFvafOhDvEt+XRf3ysjcWX+OEnl1HCNlXIxq260nazwBjKwlV8L58W5HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758923314; c=relaxed/simple;
	bh=h9ZcKZS5M9zCK+skcKcB0yIMzN962ADmlrNbEYIP4X8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H5od02PsNOFHLCxOFEqDCnsQwI6cSTbFMQgxK7QUEzbGjEcJGW9v/uX7KsH6f6gHGyQC+y/36yS1cLeKddSMJYp3wA8De0gcjTwFCChosBOfyc6eHMtA41shqK3UtxQdmsYS68l2orejV/jvgw9v1zc6bGsUf9/XVXPtrw6a5qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=NdEQD4LV; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-115-162.bstnma.fios.verizon.net [173.48.115.162])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 58QLlu5i014779
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 17:47:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1758923278; bh=Qr8CzW6IjDYctl+RNiSLbPfoyupXuW/LerzCekhinhI=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=NdEQD4LVme/lM7VkQKiXvt2v8NgwMbuc3aA5yDXiSGJNWUHKJlAkkURtemFOHCUx7
	 l51yyuY3AgtymNw+4eRaXErzIxQ7uU4hMgF4nv3kWejyqt6pA1jRzhTgKh4FXGtYjg
	 Jm6OisEoe3/H4V94lLywyH3lukI9CTMhfMtc3/kW8X+TYMYgJmibUOnmS/D9Dwltwp
	 m8p7Q6b27E/dDJ0UM452ruSBtY7S9EZMmLs8yzq7Euc7HB0D0u6F110ZMs56tWSXu2
	 gNqbDxn/FVRAQNs/o4PhOzqRKPhyEUA0MySTC8YMofFAXo2KN/AqF92daeC4wwNIcA
	 6+i/28rfotiUw==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 01A392E00E7; Fri, 26 Sep 2025 17:47:54 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Zhang Yi <yi.zhang@huaweicloud.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com,
        yangerkun@huawei.com
Subject: Re: [PATCH] ext4: fix an off-by-one issue during moving extents
Date: Fri, 26 Sep 2025 17:47:48 -0400
Message-ID: <175892300645.128029.17482024233805029291.b4-ty@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250912105841.1886799-1-yi.zhang@huaweicloud.com>
References: <20250912105841.1886799-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 12 Sep 2025 18:58:41 +0800, Zhang Yi wrote:
> During the movement of a written extent, mext_page_mkuptodate() is
> called to read data in the range [from, to) into the page cache and to
> update the corresponding buffers. Therefore, we should not wait on any
> buffer whose start offset is >= 'to'. Otherwise, it will return -EIO and
> fail the extents movement.
> 
>  $ for i in `seq 3 -1 0`; \
>    do xfs_io -fs -c "pwrite -b 1024 $((i * 1024)) 1024" /mnt/foo; \
>    done
>  $ umount /mnt && mount /dev/pmem1s /mnt  # drop cache
>  $ e4defrag /mnt/foo
>    e4defrag 1.47.0 (5-Feb-2023)
>    ext4 defragmentation for /mnt/foo
>    [1/1]/mnt/foo:    0%    [ NG ]
>    Success:                       [0/1]
> 
> [...]

Applied, thanks!

[1/1] ext4: fix an off-by-one issue during moving extents
      commit: 12e803c8827d049ae8f2c743ef66ab87ae898375

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


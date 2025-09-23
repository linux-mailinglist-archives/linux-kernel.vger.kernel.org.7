Return-Path: <linux-kernel+bounces-828986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC1EB95FC7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 858FD2E41F9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8E9327797;
	Tue, 23 Sep 2025 13:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="yGwEv5jd"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652C032341D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 13:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758633427; cv=none; b=s5GcS+GOlqe6o0reZQR1uZExo0vJNkbpE2Y9R3kPu9jhuu5fVMxqNVYqXNp6l/aDQtv0LCBzLxh37QDlcU/uNZxiAbu5LHxwZm4JrgRnC82eIRbN3wzUkKiC6J3A47lxPus3lF1x0FQzXbbXo9GB1moz91sevMAKDPGS5lwJ92I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758633427; c=relaxed/simple;
	bh=MjdyuQrqVvsTBegSnd3yU00JR+DMJq7p6mLUJWTlZdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WcX86kEUGY8n+DqS9bzY4soDm4zBERuTCWZGcAQ09uy4aBqVqFE+QEAc/EaDbyWz35tJGcQEF0BtCEsx8l9v3gMddXhxsakYUTucwUlAA4n9Ip7/3oDK99m+4sl/RQQtamhuohwI3kVx8DBZ86jZSQ12P5UGD17oVABr6x76P2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=yGwEv5jd; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b54a74f9150so4103754a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 06:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1758633424; x=1759238224; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DGZ8DWqCix+BtHtElOYwM96MkEfMXUBhKMzH5BSjHrU=;
        b=yGwEv5jdMt4Rgfi0m0bN3rxya9s2FAbia8xtqcTwhc19IK5r4PXmdK+C7UWreg1NfH
         4sk+1SJaFqWoZk8UMTPHgcndklOJpzScvLF5bjkG6gqoUSKB2k3ZVGlgvwgMKVkiX9tQ
         HMMHDCD3TrzFuqxXTV9HAJcgYYX2He2h5yQzLxkZURdzd28u2rXo3M/TKNd/GoKCTF5R
         SSJHzKnVcZ1kR/S8ehZjuwzeAqAlS4edQgRc1y0V8xkXIINs5b4r82gsRo8F8hz5liGg
         WFWMrwFtm4OO2twE/EkvNGL9ESDPBnyP6iVe3AlnhcR6cmuUPbA6c7z1EUU5XrhnwxMP
         WISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758633424; x=1759238224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGZ8DWqCix+BtHtElOYwM96MkEfMXUBhKMzH5BSjHrU=;
        b=s50dMnuns7jXtBRUCKKP4nmJR3vsjwruoNLK0EzukZVtF9vdSBRT3rbHX8M8Gi3lHO
         9wfYdYKx5AqQBw4IsD92svShndfJc++yAWVSrxnyf62WI++myFvLCP/zyyzmRWf4Sse0
         jI28/hL0PNbA6kjPbsg3SCaPWflPqduF99A6JMsZSlXT/6gJI1H31M6fis/lJ2bd4JN4
         rnZS3Oi9uwsJ4a/tuumKfRUgJDOyBlAxsLMu3/B5+lveknp6/SWbcSWKNHkY7s+4Sz7l
         QufQ2XCVEsFbneb+xxFdWOncqEsFYNRv25RHbwglg95togsk+RolBi0CzpaIMS9oxtgt
         xpRQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8a/E+86lyf17pEHV6ljm5poQUn9TjCXZEYHUUGMq8aqOiJmqoK/A9wBJ02s+xE9THnEO+Joq+dKzYaPY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9yw/PjhQLIV58pNWL5S5ScTQ33byDwtiypa0B+Ub4HfJRe5QU
	0hncarCsNX+D5/Xmd2pBUcnateCQFzzC3daqj+ov6x4SiErwSFrCv2srxJgPeTIaGYM=
X-Gm-Gg: ASbGncsKCUNI3vIxcMB2cMVj42/JOp1Fyxgc82opLIEzyfvZxpisU4TigPQBpAK9h++
	J9hgxDx95O2PsyLEVZUG8wXZvHJOF+FeIg8rYS9cLXIGUIHCNDf/n3eK3HJwhCr+vfDZ5kGvej+
	lz+wPzuJzDIeScqKpX7m+igvNdgFDMnG7Ry542CyhhV15dysNZ89d8WsCVHQL44ssyYbY2+eZDA
	ATPiHzDcfbeCHFPZJ6ZzYwhdrnssisuQpJpn/fxco1PMR9nNcpEWKioUc5N2x5V1UNvaJLTn1Jw
	plwK/EPbjZW711PIK+wfG8kEZpB8ORSOa9NHSuqDYBmy/IpTCV8dQLZULHrpya5+1V6e5fAVEKw
	M8DXO3NjHC5KnRWRSTkyk8f/4+AedLJrsjrx5K33lsvcyySg5ZrlFEOPwAMC1XFt3G0LNZQkYM0
	4bSsnIjZh4
X-Google-Smtp-Source: AGHT+IEK7PfWxNFc7fb1bUErPP+++ZIWocUE2B9M31SxyszIkGAjugG30aXgLbzSTbCpFRJZYYXACg==
X-Received: by 2002:a17:90b:17cc:b0:32b:9750:10e4 with SMTP id 98e67ed59e1d1-332a95e0514mr2945365a91.27.1758633423462;
        Tue, 23 Sep 2025 06:17:03 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-91-142.pa.nsw.optusnet.com.au. [49.180.91.142])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b551705bd02sm12047994a12.41.2025.09.23.06.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 06:17:02 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1v12t9-00000005h4t-0IOy;
	Tue, 23 Sep 2025 23:16:59 +1000
Date: Tue, 23 Sep 2025 23:16:59 +1000
From: Dave Chinner <david@fromorbit.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	josef@toxicpanda.com, kernel-team@fb.com, amir73il@gmail.com,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v6 0/4] hide ->i_state behind accessors
Message-ID: <aNKdy1vYsWoMvU3c@dread.disaster.area>
References: <20250923104710.2973493-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923104710.2973493-1-mjguzik@gmail.com>

On Tue, Sep 23, 2025 at 12:47:06PM +0200, Mateusz Guzik wrote:
> First commit message quoted verbatim with rationable + API:
> 
> [quote]
> Open-coded accesses prevent asserting they are done correctly. One
> obvious aspect is locking, but significantly more can checked. For
> example it can be detected when the code is clearing flags which are
> already missing, or is setting flags when it is illegal (e.g., I_FREEING
> when ->i_count > 0).
> 
> Given the late stage of the release cycle this patchset only aims to
> hide access, it does not provide any of the checks.
> 
> Consumers can be trivially converted. Suppose flags I_A and I_B are to
> be handled, then:
> 
> state = inode->i_state          => state = inode_state_read(inode)
> inode->i_state |= (I_A | I_B)   => inode_state_set(inode, I_A | I_B)
> inode->i_state &= ~(I_A | I_B)  => inode_state_clear(inode, I_A | I_B)
> inode->i_state = I_A | I_B      => inode_state_assign(inode, I_A | I_B)
> [/quote]
> 
> Right now this is one big NOP, except for READ_ONCE/WRITE_ONCE for every access.
> 
> Given this, I decided to not submit any per-fs patches. Instead, the
> conversion is done in 2 parts: coccinelle and whatever which was missed.
> 
> Generated against:
> https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=vfs-6.18.inode.refcount.preliminaries

Much simpler and nicer than the earlier versions. Looks good.

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com


Return-Path: <linux-kernel+bounces-875371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22577C18CEE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F0DB407309
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FBD3101AD;
	Wed, 29 Oct 2025 07:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V014Fm/0"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B303E30DD33
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761724434; cv=none; b=Q8rC672cFTZ0JK3l8owwUjcvSA6oCRnU0hgzUHSIb7swjhEfCAdD1zScoHreIKwtnGNDnayJLjNiKVuhgQK8qmQGKvuoa9eNN3mg4HfRhVHmiR6+snE2Ev5QruzcBVKZ6ClFg9su4iexbFVCtMZR46vI/r4DKoRVtNWEKabNS08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761724434; c=relaxed/simple;
	bh=9sBqHtMzkgHNQvGNmaU6cyr7BjLPfntGjyHDzqjj1q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVx5GmeIQ3FnOXRS96FR+ElDjiiYgTvx8Wqp7Uva1ckI7jbjgAkN31IUOqL25Gi4HitCU/pZIaGMi4ERNEwJWIJ6qj1sm7FaPZoy2DuWren0QADYr6BLRHv7XDXnDT0xKNQFZVeGk1z8B0ReFfA9F6DVyX4ozZSsTcpNwmwRGrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=V014Fm/0; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3f99ac9acc4so6513335f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 00:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761724431; x=1762329231; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=swQK60xfML17J80u6tuXniIURK0iR+v6N89D6/+kOL8=;
        b=V014Fm/08zxPpn2lnh71iGn9yRnXk3VNrVPUMNjoZwlY/YWv+3rA6vLTv607oEFt40
         KQNqS+sAGlIfOLG8PTJGxb/NFgP2XKPR7VRVFvBI9Lk4JXlxcQVNRlOAiUxC4ua3YoGc
         w/TZuTN++48ehToSjt5EUhpTMG6uUg9xnatQBkpWpI0OqTdESilNfwJu5lGl2bcT+HGr
         NlgbE3F2t0N+I1K7XKpcmkyz5lOaQWwxs7Qu9SIx1JBVhcyP+LnG0vKcUY592yMG59Do
         hK7OtxeQiDDe8/hhMw+e1gb3Cn4yRS8ghcrGorvxn4TmS7P7isQ6lChD8grIp6N9qsDB
         7fwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761724431; x=1762329231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=swQK60xfML17J80u6tuXniIURK0iR+v6N89D6/+kOL8=;
        b=bkOEbf0Pe8SgYOTytY3enXAkVsFH+CkV+2fmLJ8QtqlbzaVSPWpwXKuncUHi8oWZb/
         vOM0lbP5Mbs42F6qBGMAPY1OEwvIoJYjvTGbcYsOttI+2zzGL9ZIrjcsHwwvkT3g8Xye
         N12HbDKf2Xd29jm/YNbd44gt7IMXO/qsnw2DwA47/Qzr+w9Gww9SmrIrNSAj5Z6hX02x
         c5AsDskGCNdjilOKwKbaEruqQ6EJj8+Z8PWwZIo6tDS/tn9DPgiQAzNgw759eOUd3vDY
         MMFej0CS6RogZXQ4SFGqysHgha6DQNUVqgZeL06tKH5ZNdATlECpmxCM/jLD9XnuWRyu
         a4+g==
X-Forwarded-Encrypted: i=1; AJvYcCVNaeFSCr3SVVrvLDJCSgL7H/ynTKHp9HA6giQSEc93386lORazyvWlHC0r4w527fATHI62EcU4k11HqNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvI2ds+yk/CKi2NsigEa4PfrzTCzqI6Wv0pNI8aM3iSprKm84Q
	m4h8RuJhIuhveCJVDA3Uuwt8u2imBMeLR2wYQU8eLSsnmwopGQVbDz1nfMzJk5HNeAM=
X-Gm-Gg: ASbGnctjogqBaLV/e3V/1HTEFySERRMhPb2xuO4Jny3+gkx+G7BQjCw/No6AAL/8koT
	3YUnzhq4MNoaMfzcBqfXIIP+GMp3z2QByFBL4L+egUlNTOi6I0bcuns373v3fyb+R+KKs0viYnt
	kIt/Nln0S0t/qTnFQ/9hHimQBuEarnRUtRW63o4jYv+Pii7fdFH6u3Jj8NpEIYRvI/V3o8RQdSh
	XwrBV/BzqPn6S80PUTcNYASbErOXFwO61YlI9mk+9ZAGl7IR7S3JwEVAlBO+HqWwSp1XJPHppFU
	3R4+LdQO2StKkAkxuyUm3von64qzHe7Dal8RU4zG9XpMWtOo6lWC6S0Hl9/az86WSzhmJkiyuus
	dNOiqioArMEw121MdzyaTDciPF6s+a6tx0n6C5n+edbmYxeH0Hxn1Kb9/XGLEWqj4eRniWWwCmY
	qJZqYTMT3Icpz2SQ==
X-Google-Smtp-Source: AGHT+IHZNv776MNAkq85ErWoiCefggPtR3LZHBTitBCxq6kWhcvpDiu2NWRGcgIae8q/Y/YRXY63yQ==
X-Received: by 2002:a05:6000:288f:b0:429:8d46:fc58 with SMTP id ffacd0b85a97d-429aefd2c2cmr1389158f8f.60.1761724431036;
        Wed, 29 Oct 2025 00:53:51 -0700 (PDT)
Received: from localhost (109-81-31-109.rct.o2.cz. [109.81.31.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b7b2dsm24452114f8f.2.2025.10.29.00.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 00:53:50 -0700 (PDT)
Date: Wed, 29 Oct 2025 08:53:49 +0100
From: Michal Hocko <mhocko@suse.com>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev, david@redhat.com,
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com,
	imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v1 00/26] Eliminate Dying Memory Cgroup
Message-ID: <aQHIDWDx3puT5XZd@tiehlicka>
References: <cover.1761658310.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1761658310.git.zhengqi.arch@bytedance.com>

On Tue 28-10-25 21:58:13, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> Hi all,
> 
> This series aims to eliminate the problem of dying memory cgroup. It completes
> the adaptation to the MGLRU scenarios based on the Muchun Song's patchset[1].

I high level summary and main design decisions should be describe in the
cover letter.

Thanks!
-- 
Michal Hocko
SUSE Labs


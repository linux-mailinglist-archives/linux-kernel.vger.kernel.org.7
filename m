Return-Path: <linux-kernel+bounces-884491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD54C30411
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 10:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C056F188F3D8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 09:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2E02C3254;
	Tue,  4 Nov 2025 09:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PASA8VN6"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984F628D84F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 09:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762248100; cv=none; b=L5bCgAtGXoJVfrvUvfICNtOl/RV+l+abl3vraOsPfyvHTW6p8HQcxmXuJL2kAnmSG2iMTyvcjZFMnDPYh3GtZxmsK5WAKcCB8gcvea+EdEnddxNYUNS8Odgyp2LiZ819ihnhtD5fE+dWhVA8tIXzWPczg0fN4JfUJ6zEPI/9oao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762248100; c=relaxed/simple;
	bh=qWUGGQt5BOBYCU7cJdvg7HLtAGyl1naRvP7koMC91kY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUBX/YXhU9x0v0iXscJnORrOIBxTcFLkhbQKojv00KLS7oH54Qjownj+LAzr+91O1noYrPcmQtdL0gAyYYKSVpbGb4AubNnjSbWKi1H0ke1QJBZzpZy48WEC9L9TrztGKLJ5Vz0EXnJ/mu30ta3T2b+q1q96Mx9hfn6jWJAaCQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PASA8VN6; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-429c8632fcbso2203632f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 01:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762248097; x=1762852897; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N3yPk3l2QmZ5sg7FNMBQuG7a498LlywoxhRJU9RTRgg=;
        b=PASA8VN60LWvBEA+Zf5lTNSO1D4/omSdR/JPG2Jme2M+HEmg5I9cj55UsEqRJkmUSA
         Kwq1JpCDqNGtrqlPfU3s4Z5WhmxUK4bA4gY1KT0MK1avaeYdLZmK2oDMNtW2zpVPJl1O
         pbuRhriTmljFDbNJxgdsxxLhZhH6V/cLud2yfAdjEjgH9Bn/edGdd512g4IJPQZEQN5R
         Hc5Trnw6CkRQTDcCqyCrVggi+0cbD8MJi0IwXmE6EZm3UzACEsm28o+nWyMXSR2W2pwL
         lquiRe1hqQgnZ2+zn2D0gVt5C8vtP6GlLMBU6lFtL007nrGBO/X06cLP5AX/7EOUN/0s
         NTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762248097; x=1762852897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N3yPk3l2QmZ5sg7FNMBQuG7a498LlywoxhRJU9RTRgg=;
        b=bMIGVJvEDSgKC+vbdlr/IChCDbB0Ct00JppSRwblb04GaiDKNxUtk34MP0DKB1IEkI
         3LxgrmnDgrq41Hkxwxjf6HIrKpAtHcFL1xOz9HcePMYoqbg+eTbHUulvyQrdMbG51VAa
         2MEbNt9HMcXHJBKLQvhYt3/wAEE6wf0KhwC/QN7Mtk3/mMksg/5Sr/UPBsUjncdW3bzB
         9sefOc1JkrOzEW7mYlCp4uMv0N4uPQRMmlV43BBE+2FZGw0BXx+CkmOlYOutYcDM2J/j
         kvKxevg75MkOVB4DqVTJG2CZYOGkNowumHgazW6s2Tu4XXuZ5u4FKYrVU9a1ObSGlI51
         /OzA==
X-Forwarded-Encrypted: i=1; AJvYcCXiI4vZKICthpSzk1qltQ5aNtZNCqqwhNyXKO3KBsIQMt6Ez5yV4xD8ywmf0YTo2ejzHEMtSptoPLNeSDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC6F2+nPs7tYoSz3gB2j2k38DDq+Ge0blvIsBNRZ3rXnAgaTy/
	iqnN4Qo9o9u4+EmvI97jxPqbCI9L9VyPpSWxN3EOfTL0f1qu2p1PwvNeYSr9J5Wn17Q=
X-Gm-Gg: ASbGncsWo+yzamKoG6dvnG5/JKIqZ4VjTwsqOIyrhR5vXwEKHSFwu2Un3YszKI7oEPG
	dQ351Y0DapS3aA5WJdNd/3WfGqOWbKHWZuX8V7FGXlVvaA854I1x/aftKIC8JMWVktZCiTT3g8E
	1tHgotHxkpGh0DRY0h/zSh3zCTLSm0W9xBXc2NcFqSTbVM2hPPF1YxUDxDKvW5Jv7sUHl6NZTyM
	5RejFG/cQz3kuTRHv+CsdJ2Qz8HBlAsXg3NneR3mpUQUj8ot+ztmKymKOIftnCwEvVc7CR80XHa
	dnICPOmQk254OvS1Z4l9E4KQ0noeywXod8UNc45Sa9W0WUnAwDmfh2QrlL2sg0Xj3Vp3bLozhW5
	J5/MMLqYv3Ohg9gRBD35ezTK8UkNLMfyyuOW3gDIx3Wj3GQxADQUvGiCCbNKKKffxDAYMvd8AN2
	bYmySzzVnL
X-Google-Smtp-Source: AGHT+IF4ZP/JaUkTNJYjSED1IManQD1UidWfm51jaGkLr6fndksIOYSs9Z4q0DYHoyvlN+ZlPJfjhQ==
X-Received: by 2002:a05:6000:1acc:b0:429:d40e:fa40 with SMTP id ffacd0b85a97d-429d40efbe6mr5041355f8f.45.1762248096882;
        Tue, 04 Nov 2025 01:21:36 -0800 (PST)
Received: from localhost (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1f9d33sm3569518f8f.36.2025.11.04.01.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 01:21:36 -0800 (PST)
Date: Tue, 4 Nov 2025 10:21:35 +0100
From: Michal Hocko <mhocko@suse.com>
To: Leon Huang Fu <leon.huangfu@shopee.com>
Cc: linux-mm@kvack.org, hannes@cmpxchg.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev,
	akpm@linux-foundation.org, joel.granados@kernel.org, jack@suse.cz,
	laoar.shao@gmail.com, mclapinski@google.com, kyle.meyer@hpe.com,
	corbet@lwn.net, lance.yang@linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH mm-new] mm/memcontrol: Introduce sysctl
 vm.memcg_stats_flush_threshold
Message-ID: <aQnFn6vPQ5D6STGw@tiehlicka>
References: <20251104031908.77313-1-leon.huangfu@shopee.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104031908.77313-1-leon.huangfu@shopee.com>

On Tue 04-11-25 11:19:08, Leon Huang Fu wrote:
> The current implementation uses a flush threshold calculated as
> MEMCG_CHARGE_BATCH * num_online_cpus() for determining when to
> aggregate per-CPU memory cgroup statistics. On systems with high core
> counts, this threshold can become very large (e.g., 64 * 256 = 16,384
> on a 256-core system), leading to stale statistics when userspace reads
> memory.stat files.
> 
> This is particularly problematic for monitoring and management tools
> that rely on reasonably fresh statistics, as they may observe data that
> is thousands of updates out of date.
> 
> Introduce a new sysctl, vm.memcg_stats_flush_threshold, that allows
> administrators to override the flush threshold specifically for
> userspace reads of memory.stat. When set to 0 (default), the behavior
> remains unchanged, using the automatic calculation. When set to a
> non-zero value, userspace reads will use the custom threshold for more
> frequent flushing.

How are admins supposed to know how to tune this? Wouldn't it make more
sense to allow explicit flushing on write to the file? That would allow
admins to implement their preferred accuracy tuning by writing to the file
when the precision is required.

-- 
Michal Hocko
SUSE Labs


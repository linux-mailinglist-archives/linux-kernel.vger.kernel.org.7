Return-Path: <linux-kernel+bounces-831338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8421DB9C649
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 00:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44CFC4A0C14
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 22:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB26288537;
	Wed, 24 Sep 2025 22:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="il2GGEWM"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38DB28488A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 22:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758754433; cv=none; b=TUbtV7kjs2nzEwrk4DStcwdqpyM2lXay6MmpbQiEOhG/PayRxa9f24MJ9JLdT9tZ1DVimRnDAL2+Z2aT0N81OUnANWxGpKqFXst/1dgtzlbj+EQkC+SBfcg1xnUssIAYY7YRXVoKgtP7gaXDVLdVFsunhSncMDDjgxFW9IAfhrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758754433; c=relaxed/simple;
	bh=qHDaN4fxq+33TeuPxLHXVx+PAknon7egB4iDvCqkcNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RqpSSXXziUzt84v2fKy5nWUPlA8cru91m3xU2OsxQe6wFgsfdLfrcdTXrvhREAP2G8eL1qO4sFeow52jV1nv2Etx/bDRmSQ5otD+/WaPKMyUAS43sqVmlUWcDfA4kMQmAekU9N+MkL+yj0egjM5Iry6Jq7itwladKizQxqgJSeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=il2GGEWM; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4d9f7a34daaso3206391cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758754429; x=1759359229; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OMv6M4S9k49MdsUE0Vs8ZejZ+912P5gb20KbIpJokts=;
        b=il2GGEWMHExJSWERcxGMQFs3J5CUXvievwD8Cz0y4QDOZyok72+0aSux/LrgEKzYEA
         ePi/HUCVeD3PIRd8z+GB057rGt6BOpBFSwra7H4hQVVoF3iFDubLtUJuFrJ82hZPnSLX
         4ttXiC1TzuLnk/l9jMmpUotIbVMiXrvq+qedGU7YVum2H9IZ8Z3JwQy74qKMbw9AGOd1
         nlv0qNyyWTpvLcyfDwMC3vZsSblz66vTYrK54igubNX5FBw6WOp9bNJIsty7vsy/cmkq
         c6cZ1eDy/WdJpJmE8r/TsqALlotOsZllcxqD5rYeZ1ctzyt7NZLUrwvxhvsbwh5m7LwC
         65VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758754429; x=1759359229;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OMv6M4S9k49MdsUE0Vs8ZejZ+912P5gb20KbIpJokts=;
        b=UizQ4f6dh8TMlcg/qmxFDNMzaBVcIM04CB2NVFmopx+OP4yEkqoDhW3SZWWjH+XtiO
         aaaq/bTT8IhKkq5D/1UNNs02fRpAFnXPR1Ea3qPt3TR2WaNamvk2FbShSXtLaeAxXczK
         HRIOop/PGecu7QV4M2JSlDfdLLvv62y3W+tni7qpfd0IazhJDGlZnc5M13mawjtiAKtH
         RZp5SHevGz78lAb9C3NePvuCV+cg0OokV0CCh4nYceAvCOfVLPe2IZ2uXAXxZ/WE/O+0
         wLdD4Ib5w0dMnrEWP9NleRlzE3nzVlor0o3J/yPamZFC6WuItM5+0BMt3E6ApmiUNukg
         hvFA==
X-Forwarded-Encrypted: i=1; AJvYcCXmELiv6sygB/Er1GiQkKAJqbo+JwXCBNUnwDRM6R2/glaGP2SGOs07CwRVLXUdezF33vR8mK2iMoIrjrc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz8IC2JHQDRAkSXf6AMN/szbCesiIG8FZAH27Gz4nBARQpugZR
	2RreuEeMtuiq2HC26kAwW1PXTe7mRkigqLzgUa0gYLUzDuQEz7wnWM5x
X-Gm-Gg: ASbGncteApr4RrW7VOrztTeMcmPzi599CR0LjWAEjt3Qa2TFwWg5R3M3iistYx1mdPt
	0eKb10a7z2rPGYYB2FdXDQp7YV9/Nj/wXiPOhABD54hzENrjjuq84WzyfBoYKvVtA3KA4WPY7q8
	2EvgunEvmfnz7Z8uZdPSlSOvsuPeNhtATR3mmm5jCv2ptiit6fxdE5hJYtamxveWB97kk6qtnr8
	tBqAYkb+J+oaZ7sN0wd75SFuQLHK2xAmMNLwR81qAvI1adE6Er1ym/OpGuRCj+6PcoWUa6zMSlK
	VjIMkAOpgwm1JaKyUf0chXuAj0olk72j7ERgPeV+GUj14lQZ1EAdjILj9RI5rpjxj1y0jQEyYq7
	jVmazNogg8k08gt1kxw==
X-Google-Smtp-Source: AGHT+IEBC+joViliP/PQ25auOrWeoPG1kaQmBfu5QNRWbNYA+rQQb3vtViLCUnZuYqfGk3yWHCfqXg==
X-Received: by 2002:a05:622a:610b:b0:4d4:7311:3cd2 with SMTP id d75a77b69052e-4da4cd4cc5cmr19410541cf.74.1758754428694;
        Wed, 24 Sep 2025 15:53:48 -0700 (PDT)
Received: from arch-box ([2607:fea8:54de:2200::dd5f])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db0b94599esm772621cf.16.2025.09.24.15.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 15:53:48 -0700 (PDT)
Date: Wed, 24 Sep 2025 18:53:46 -0400
From: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Ahmet Eray Karadag <eraykrdg1@gmail.com>, tytso@mit.edu,
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+0be4f339a8218d2a5bb1@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] Fix: ext4: guard against EA inode refcount underflow
 in xattr update
Message-ID: <aNR2erc6QYubynYK@arch-box>
References: <20250918175545.48297-1-eraykrdg1@gmail.com>
 <20250920021342.45575-1-eraykrdg1@gmail.com>
 <20250923233934.GJ8084@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250923233934.GJ8084@frogsfrogsfrogs>

Hi Darrick, Ted,

Thanks a lot for taking the time to review this patch and for the helpful
suggestions. 

> /me wonders if you could use check_add_overflow for this, but otherwise
> everthing looks fine to me...
We looked at check_add_overflow() and check_sub_overflow(), but our
understanding is that they are mainly useful if ref_change can vary beyond the
current ±1. Since the call site appear to only pass increments or decrements
of one, would you prefer we still use the helpers for defensive hardening, or
is it acceptable to rely on explicit 0 / U64_MAX boundary checks in this case?

> ...though while you're modifying the precondition checking here, I think
> these i_nlink preconditions should also be hoisted to the top and cause
> an EFSCORRUPTED return on bad inputs.
Thanks for pointing this out. We will include this in V3.

Cheers,
	Albin


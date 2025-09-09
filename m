Return-Path: <linux-kernel+bounces-807906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A17B4AAF1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31FC31BC5153
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A69331CA66;
	Tue,  9 Sep 2025 10:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BcRes0yl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDC631CA45
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 10:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757415261; cv=none; b=RC7BSMsGOdjMXn9tVyvzebLmcQGE6/XQ4ydmnC65enmtpD4jxsTYuJpvHqlAo2PoZcu3LFkTuhRms+uh7CEl1nyTHrqrSMwo5459NOsTL6oa9koc/w22cxgb5dsHA8+a4XlgFEoHhMrCrZboGLlAKuM34wfthg71QUzUxn3wD9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757415261; c=relaxed/simple;
	bh=HM2NMJxMcYEfNGGq/oJ04HVM1ReMtP0pTKiI9lNtLO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NqOwM3bUUVgeQobuIvGCqkxR6IUd+z5hJsDH2mJU2Lj9p5Jm1jiWNHn4xXggOusGwzRwu+rnz0d+/vNFCUXt2MpGrxy8+mDEYyecbYwczpLbVd7a4NfpQWOof6Zbsli3gy1Pbkzg2mCf4EeaG8hmVZi9QYjO3gxEnxHZBhxPzqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BcRes0yl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757415258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S2SErD9VoCde/QEnC3d+sTghHLcsV0IuUj/e7Q9rJMM=;
	b=BcRes0yl1sEsk6gNBEk73KaX6oTAXjgZvryAyx11tNKxrmI2X1D7SW3lAFoKBu417BCuvR
	MNVWg0GFCrS8MSwI3t6XMbDrUtvaFfELazOlesJZJApOEW0qmiXegVr46hvVl3gYLx71zF
	QEMVko7HYozTMiGRYotpwyt/CYziNHY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-VnVLJLHQMAqJzPedlYzqkA-1; Tue, 09 Sep 2025 06:54:15 -0400
X-MC-Unique: VnVLJLHQMAqJzPedlYzqkA-1
X-Mimecast-MFC-AGG-ID: VnVLJLHQMAqJzPedlYzqkA_1757415254
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45ddbfd44aaso27547425e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 03:54:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757415254; x=1758020054;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S2SErD9VoCde/QEnC3d+sTghHLcsV0IuUj/e7Q9rJMM=;
        b=IYAPP0x5Pb4lAhxXhMKEvhxK+Euozr8z5O4QBmjj8MwLhGvhvwD0tuCER5mT625Z/A
         masu0d7bsC91IXPbePoz6hb95WYcYUBXaorsq0bMoVrfR5dFULbBb1LkCtY+pT0d4i31
         Fffv7pix2At7zAjasRnYG7KfggHWDfVxv2Q6sVS4Y95xbXlu8dw5koHA80LpcAMNdL2x
         uBxKuRIxPu0TdnM5T6mGecAcUw2uMow3TycNwMCtN1PLb3Sh5wOAmZDIRQOefNN/eeKv
         Q/TqWqRdl8uXumIGpeLh4WEIjA8rLambWvurhKhyOMlB+legW+/JnymE/KWvBX49/p09
         Sl8Q==
X-Forwarded-Encrypted: i=1; AJvYcCV1Y/mDVUyeRT5y8gyUxx9Rtwat4Q7CSPBeJVFaxhfGh75odZOe0HAvGnhOFnxYUFdtw7hrmXHw5pxEwk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWKRwYwV6kX008vgAgW67IknnS7l+0ZTW6QofN9g3GjYlrylw0
	dPNclM7bfdUxgAysQwjeLpeGfv+tR5TEy/bC+EQKFCCYzEGrkU7niq8LAfEJ8yhOTrOWCIyGkpx
	FnmlQ5cWHO5rSEF0QifgySePj4p8dmDmNdpDOOj14Ra5QDg4eMhBCKzkiHvOWBgB++A==
X-Gm-Gg: ASbGncumMx/xuRo1H5UibpdMTo5PMFF4bvDOAydDa6IkI1EffNfJ/wDs9R9zFfv+HiW
	bIlkgycXYq9tEZ3S5nawRP3PgkAfd7p2gyPYeLPJdrbVNNVs8WVDCP11gqvPzkiGr/Kh45BwYnm
	mXvBvs4RA5cZobjroZgL3DvSMjh66NnkohL2EduTACHwH3t7asKJQtjDisi9eTctTYqyCTlGhOP
	VQJ6qU1zcUrG3cZzMwb1gyM8oE8taGmhfJDHnwr12c73IgIghxvUZMbdYfdqTAs8OulZLb5NKZ5
	8L2Oc0hiJU1st0YWJvoaZeOJFCWQ6yNfY+0TEQ152rQk8ywpELYeWGA7PDqiG42aU6bJMiRyzYC
	yzVpEFQUHeTc=
X-Received: by 2002:a05:6000:40cc:b0:3cd:edee:c7f8 with SMTP id ffacd0b85a97d-3e646257898mr10576943f8f.29.1757415254078;
        Tue, 09 Sep 2025 03:54:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaDykjIB4jgP7Ave7E3MW1xUfG9vBdncrD27nwwsMpPlkFkaSDsK+O0VNW6P6FuPNrXfZBbA==
X-Received: by 2002:a05:6000:40cc:b0:3cd:edee:c7f8 with SMTP id ffacd0b85a97d-3e646257898mr10576920f8f.29.1757415253634;
        Tue, 09 Sep 2025 03:54:13 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521ca22esm2336206f8f.18.2025.09.09.03.54.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 03:54:13 -0700 (PDT)
Message-ID: <d918e832-c2ef-4fc8-864f-407bbcf06073@redhat.com>
Date: Tue, 9 Sep 2025 12:54:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] rds: ib: Increment i_fastreg_wrs before bailing
 out
To: =?UTF-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>,
 Allison Henderson <allison.henderson@oracle.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Cc: stable@vger.kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
 linux-kernel@vger.kernel.org
References: <20250903163140.3864215-1-haakon.bugge@oracle.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250903163140.3864215-1-haakon.bugge@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/3/25 6:31 PM, Håkon Bugge wrote:
> We need to increment i_fastreg_wrs before we bail out from
> rds_ib_post_reg_frmr().

Elaborating a bit more on the `why` could help the review.

> 
> Fixes: 1659185fb4d0 ("RDS: IB: Support Fastreg MR (FRMR) memory registration mode")
> Fixes: 3a2886cca703 ("net/rds: Keep track of and wait for FRWR segments in use upon shutdown")
> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>

[...]
@@ -178,9 +181,11 @@ static int rds_ib_post_reg_frmr(struct rds_ib_mr *ibmr)
>  	 * being accessed while registration is still pending.
>  	 */
>  	wait_event(frmr->fr_reg_done, !frmr->fr_reg);
> -
>  out:
> +	return ret;
>  
> +out_inc:
> +	atomic_inc(&ibmr->ic->i_fastreg_wrs);

The existing error path on ib_post_send() is left untouched. I think it
would be cleaner and less error prone to let it use the above label, too.

/P



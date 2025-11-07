Return-Path: <linux-kernel+bounces-890668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DAFC409FF
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 16:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1EE3E3481C2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 15:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BF12F83BC;
	Fri,  7 Nov 2025 15:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="RGSqIHxf"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDB2328B71
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 15:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762529858; cv=none; b=V3dpgy5X5fJI6/zIGQkqU2tBeMuXOKa7W8xhKQIQ967L0poNurjBPv+hvQ/BCLIT2aCgHsGCC3RyEfnHidzfi7OvSZQCXD/jhpaRk/hdpfRmYaUHZ+Z8rBaW6q3tpoySz6nCrRiFRiBt9RLxkrMG+Pk+PQkd0u4yPNgIIDp5z1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762529858; c=relaxed/simple;
	bh=U73VfZVPei+sXAyCbJ8QNNU/cCw1JIKNZKQiNsX1rQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5P0Gc5pZ0KVtGRfdeCTVyyOREeVN7II9nq79d0SYSgH/hyD+HustymBqm2OvnI+0tdB2dLHARjHEZOi9G5H7vz98AdtVtstZqf5wLZHq/V/ZakR27OlYKtvCf8q0wmsQv4eFII26QKS4bBLk+NJ/f4iIs6wh31k+HghHsCv+j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=RGSqIHxf; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8b22624bcdaso113357185a.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 07:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1762529855; x=1763134655; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TTtDSJx1x/PVy7VsksX52GulTROdwKgJamdYGcKgBXk=;
        b=RGSqIHxfSgipTrrfG0dKEK69eM4fAqA+DqWcvcvXdXxAjuEZHehAHEgdRvp6fROIjY
         HUu1i+HIb7u+c/pufXn+KMKGbUgGGAIvb+0xaFqROPRhQVAW5hGC3O58K4tdRvHhehHp
         L4/wZYE6l2H0tTyK61SMsiDvaWeGAx/8DsOkaKxwIYFa0cyUbhfkxRWAxYNyRw4DsOD7
         K1NiWv5pOZGd5y3k1aKxV4P8tgcVxfC6zO8C72mSe0VlvQMYRN2zQ5j5kk8tY97O/nj4
         Tz3k/Qf4dY/J3O0j1gNxsoLvpwHDUVdVibaom9fXmKcLEsMwKf/oRsCQh3t78N1pWn+i
         PTwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762529855; x=1763134655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TTtDSJx1x/PVy7VsksX52GulTROdwKgJamdYGcKgBXk=;
        b=p5WwVCohxuhi1K3IWV94QAkBdqfUdqqCmHASTeAl6aEu9J1Zv9dE6Y+U8rL31oT68H
         ueT5kEUpO0I5J95IlCcq+QiS8xJ6Sv9uzANLWD2LkeGVIc4BI6Buoz9ZYzX6SXEY1EQO
         EqTLkxvSMqVKJJ33L5BSXiHVa7u1jMnhXmPAeiLbh2kUPrA1TLI4WnUx9vMcTU74yI++
         oarmODI7DMPFqDNpgwU2Dbpx+WeuhqQqOfMwJThzuhmSpdol088+o++305JFvJNGwHtP
         7zBanva+orGcPnagspJTwbfsO4eci7oqH8s1Flr0UZcJZdiRjZabA2MXCPfi9TElnYZD
         eKfg==
X-Forwarded-Encrypted: i=1; AJvYcCVjjjv0Iwln8f17qxyBVht1F954zyX/IYSRup97rnkGwwVallx1Wy22o2GrKpVR75STAOblL9JZVdm/Kgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCZzpiybjQ0xH9G5F0kvV6g/jU0gcX7WspPmkFzL2sKWMhvkNG
	vsqDJmYXTCCKT7IkWeWTJOyWa+9LyeF2WWsN6jw2LngG0LnFa+jA5Yd79KWg0hsF0uo=
X-Gm-Gg: ASbGncth6UFkGuOozpNPaAVOmirtydMEc2aqItZfE4Yty67ORbpzfomvEgMWHCClkbe
	F8RUo8hn4ch3Le6z7UraDfLeFbop+ITFmMxc7pte/vCPjEO+S78gmTd5SeVqIh5+LV0y+I8DAdX
	vYCX5jwmEWgvtIR6cd7SqsIBB7PNBQPqI9P+uWw7a73qYs/yYRV7dA9+ULQU8K0+gODCJB6Szif
	lSA/ls7LUok0xUGdahqTmuZopKTQu2Go4NcoGcTJQreN97rtEui8ozSVYG2/djzpI+0kxvTraQf
	NvE1Ym9YNRJy3F9VCllEfRnk3G05b17Tw3CQeVqkkewPZtxzQPyDPHI40JiOb6eJrA7kQeZc0PV
	q6/76zIYcpowi1acnUdNf3Ny1cxalkBs95cj4V0kIT2QwwjyJ4jBivL4aJZaxkb2hXa2Z79kcJ8
	XBhaoZrjpSTU5PPVqNF18nZtYpLdxUWPrTEAHOIlEM1yL5eA==
X-Google-Smtp-Source: AGHT+IEPJ6hN+mVZfnke7tAQY25fK3ncGeAOvxPOwHZta5yIVQiKNYC3Ws0X4V3lyEKu5T3+tHR1ew==
X-Received: by 2002:a05:620a:4088:b0:8b1:8082:aec5 with SMTP id af79cd13be357-8b2453235e5mr449121985a.58.1762529854796;
        Fri, 07 Nov 2025 07:37:34 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2357dbc51sm427542085a.29.2025.11.07.07.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 07:37:34 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vHOWr-00000007nqz-3GJt;
	Fri, 07 Nov 2025 11:37:33 -0400
Date: Fri, 7 Nov 2025 11:37:33 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Kriish Sharma <kriish.sharma2006@gmail.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	Parav Pandit <parav@nvidia.com>, Edward Srouji <edwards@nvidia.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+938fcd548c303fe33c1a@syzkaller.appspotmail.com
Subject: Re: [PATCH] RDMA/core: Fix uninitialized gid in
 ib_nl_process_good_ip_rsep()
Message-ID: <20251107153733.GA1859178@ziepe.ca>
References: <20251107041002.2091584-1-kriish.sharma2006@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107041002.2091584-1-kriish.sharma2006@gmail.com>

On Fri, Nov 07, 2025 at 04:10:02AM +0000, Kriish Sharma wrote:
> KMSAN reported a use of uninitialized memory in hex_byte_pack()
> via ip6_string() when printing %pI6 from ib_nl_handle_ip_res_resp().
> If the LS_NLA_TYPE_DGID attribute is missing, 'gid' remains
> uninitialized before being used in pr_info(), leading to a
> KMSAN uninit-value report.
> 
> Reported-by: syzbot+938fcd548c303fe33c1a@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=938fcd548c303fe33c1a
> Fixes: ae43f8286730 ("IB/core: Add IP to GID netlink offload")
> Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
> ---
>  drivers/infiniband/core/addr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
> index 61596cda2b65..4c602fcae12f 100644
> --- a/drivers/infiniband/core/addr.c
> +++ b/drivers/infiniband/core/addr.c
> @@ -99,7 +99,7 @@ static inline bool ib_nl_is_good_ip_resp(const struct nlmsghdr *nlh)
>  static void ib_nl_process_good_ip_rsep(const struct nlmsghdr *nlh)
>  {
>  	const struct nlattr *head, *curr;
> -	union ib_gid gid;
> +	union ib_gid gid = {};
>  	struct addr_req *req;
>  	int len, rem;
>  	int found = 0;

This doesn't seem right.

We have this as the only caller:

	if (ib_nl_is_good_ip_resp(nlh))
		ib_nl_process_good_ip_rsep(nlh);

And ib_nl_is_good_ip_resp() does:

	ret = nla_parse_deprecated(tb, LS_NLA_TYPE_MAX - 1, nlmsg_data(nlh),
				   nlmsg_len(nlh), ib_nl_addr_policy,
				   NULL);

static const struct nla_policy ib_nl_addr_policy[LS_NLA_TYPE_MAX] = {
	[LS_NLA_TYPE_DGID] = {.type = NLA_BINARY,
		.len = sizeof(struct rdma_nla_ls_gid),
		.validation_type = NLA_VALIDATE_MIN,
		.min = sizeof(struct rdma_nla_ls_gid)},
};

So I expect the nla_parse_deprecated() to fail if this:

	nla_for_each_attr(curr, head, len, rem) {
		if (curr->nla_type == LS_NLA_TYPE_DGID)
			memcpy(&gid, nla_data(curr), nla_len(curr));
	}

Doesn't find a DGID.

So how can gid be uninitialized?

The fix to whatever this is should be in ib_nl_is_good_ip_resp().

Jason


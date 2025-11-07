Return-Path: <linux-kernel+bounces-890939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E5CC416C5
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 20:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 915394F5E03
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 19:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CEF24E4BD;
	Fri,  7 Nov 2025 19:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="A+/37SaD"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C2F2E54D3
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 19:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762543072; cv=none; b=Rqp+CaNU7BEChwwHVQpebWofIAV2SuCiiTnWUGgIC52nkDyzgeCprvIXG1b+sssOiLGWf9CckEGiP6D4warvH20TgId2FWdJEQx4WYNBjNqrgxThjpThKjRGDxNqwq0rEJrf6d51T+0Aqff0iS9XDty3XXwX47EF6xQrupT1dtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762543072; c=relaxed/simple;
	bh=kqQePQXMwvwZBckBBeg2xvqfNdu+QHLHTTyd85vE6ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/9zQU3n7CeBBWQQ0UBN8y1RV24ArTdRNy9MCD+e7OY8XFHTC8m95IPY+PQ7/O/bd0tc+MTEucrDJpS9hzgmTgnbEBWdwqN/FBFvAkJIW2uTgjhofiXmv+hFCHZFe++BwyezeG+xtrvYDmJJJKawSmxa2pm2nGm9ahh1v99Z6Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=A+/37SaD; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ed83ad277fso6144081cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 11:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1762543058; x=1763147858; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J7IeMTE39/0sPdj0LGfZb2pj+ljiHr2LudKfvtkV0AQ=;
        b=A+/37SaD2WdxDy1F/jENqnvvKWKwstpxa7KrPTS5rQIlS28JRLYE1L9F4oGIBIF+Mx
         GIzpDDjEpEMK/ckZVzMxSUp2xCcHihqncI/BmLu92arn7SILDAzfYIeVf99foPkSRKTQ
         H4tJ7MNEIKEt6YPMmmG0fzDVxE0zgDVG1lC4GpHBFFPQpwYKC6Mv0Ys3LsZNv2xl0zEb
         k6uwAUv+QNxEaOOSJ881HJ+Kpy1e7JtqgEjRWgKqDRiwXULTuq1mnZ+3OyzB7BfuAlXO
         C9aMS4oIs7RojjtQdwWwZyKhJKjw63d0Pjy5N6V+6XkxNosXkT6uUmnqyjgMAlGdAHjQ
         8Wdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762543058; x=1763147858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J7IeMTE39/0sPdj0LGfZb2pj+ljiHr2LudKfvtkV0AQ=;
        b=PhpUgBd9GzU45ijxy/nkoUNc+ssHZcHrUTigZj11hdLN95o/tGN5NhqeHxflmZ67A/
         Qyc15mUv6X50+iGs6TGi+ANg4T1Nn967rT6Aw56bH+N/nb72Fvo5XyBd2V42NvtxjK71
         GSz0g7wrDnnIAt+RsqFtpbl/gipEzR2G4CzTMFLiGmapT3L2J/B4tHzKv1BX5DwXrCbn
         Lq9NSXz7VRKyPZD8KcHU7H5uLUm/UbUwQZ8B046SRuJTu1msxYMYW077KG+a9EN2KbTG
         96fU+ffJRwLuktaLaUrQxOmwok+PXrNmwzEHKhLrh6Fdth9PM8BIadX7Up15PnMsxPe4
         KJXw==
X-Forwarded-Encrypted: i=1; AJvYcCUjaKWHmVDLHIjgdIRjb3xAfCYs2VBz3Q3FhcRGruT/4zXwlj49owLonNCoqxQix41quOhQ9uiBrHbYJ+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHzQjEt6ISMk7bbmS+gnQ18znlvRvtvbfivHwQdsOWSZjzG++9
	WW5hv3FXkADGZ0K/hgX06BELQopDqFws7vhSV/skRBXTebOCV/AIU2HXP7ib4aTAKHU=
X-Gm-Gg: ASbGncto8noMK8IwbQTattzLlDm7sNYD9d+X0yEQO4h3RC1SHqVZ4CDRO2jvMywMUEO
	d8jU+Y6tMrZpMXiZjfUlbEMSIlR2yz3IGQs3j+FL4+Di+TPawC3KUn8BNM+bAONIRZRbNyRIcqL
	eAGXvo3kzxbI9dVqIdvWGcd6C9FkVGxeJ+bSTgknBLbeKgN6EvZVQcl4vrUgQPCYX98ctu51s0N
	T3I5cRpmn3k+PRnuV27BfCgwRPeb9XpgfttMfqs4XMm8NqzMkxfz8P5GhzF1I632BvvFj9Oxzwz
	stLUhMshP3FfH0sCwI90j8vjNBOA8DrC4rKxPv+g4sDEuBGMP1bJvSzorbEHa+XaP9OIPRVnAS4
	oGhMG5WmCE4I2TxH7aA0LNjAWByAp8+HohIKIHZhGZWqAgKsye5XhJzxUBPAdx0xHS+KVsrCr6V
	/CnLx0gbW7xGvym1Y1GvIFfSuG46idGV6YVjEi1nFdVs/MQw==
X-Google-Smtp-Source: AGHT+IFnYi9VbOBN0jRzWxp4PFJXSJ0IGLgqXdTaco6sUWpHKooODG97tKga7Flr7a24rBW8jpPYAw==
X-Received: by 2002:a05:622a:446:b0:4e8:a73c:87d8 with SMTP id d75a77b69052e-4eda4fd4c16mr2409081cf.71.1762543057925;
        Fri, 07 Nov 2025 11:17:37 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2355c206fsm456371985a.5.2025.11.07.11.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 11:17:37 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vHRxo-00000008Lr2-49qA;
	Fri, 07 Nov 2025 15:17:36 -0400
Date: Fri, 7 Nov 2025 15:17:36 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vlad Dumitrescu <vdumitrescu@nvidia.com>
Cc: Kriish Sharma <kriish.sharma2006@gmail.com>,
	Leon Romanovsky <leon@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Edward Srouji <edwards@nvidia.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+938fcd548c303fe33c1a@syzkaller.appspotmail.com
Subject: Re: [PATCH] RDMA/core: Fix uninitialized gid in
 ib_nl_process_good_ip_rsep()
Message-ID: <20251107191736.GC1859178@ziepe.ca>
References: <20251107041002.2091584-1-kriish.sharma2006@gmail.com>
 <20251107153733.GA1859178@ziepe.ca>
 <c9c8b90f-4edb-47da-8ad0-94f9e58d71e0@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9c8b90f-4edb-47da-8ad0-94f9e58d71e0@nvidia.com>

On Fri, Nov 07, 2025 at 11:11:40AM -0800, Vlad Dumitrescu wrote:
> On 11/7/25 07:37, Jason Gunthorpe wrote: 
> > The fix to whatever this is should be in ib_nl_is_good_ip_resp().
> 
> nla_parse_deprecated returns success if attrs are missing?
> 
> Other callers also check for their expected attrs to be present in tb,
> after checking nla_parse_deprecated()'s return code.

That sounds like the trouble then, the check for tb presence should be
added to the ib_nl_is_good_ip_resp..

Jason


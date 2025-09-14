Return-Path: <linux-kernel+bounces-815560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE6DB56829
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 13:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CADC916D662
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 11:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A2C248F40;
	Sun, 14 Sep 2025 11:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gWHy8Oyt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E125213E898
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 11:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757850987; cv=none; b=INuLDM2Jpey+0SA4ffz5tAOznJnHXVvOGbk+EZUS8NvU1HE/tUYdom1SQ7vEijKyv3sTeNEIKtCM/kwxGhK1oi++t4zTbsFL1uCJQexmt0Ax43wV7LjLpziii8NkCgL3+rUw5s/73gSAJACEx2b6TIUIfGfF6NfQn+EF5IOg9Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757850987; c=relaxed/simple;
	bh=Q/faH92x8o1ZYl58qCPToM/QxD4OzW0eaDhoowRD1nY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlVMAdV0RgexiEymCyKjCv1UFa8Gf0+NOiZbbWxauKbh1exxv3kh0w5+DNU2+ws2i+NFzfC8fql640x+OyHA894WX8W1kUQ1QxDXyLklrfgOTDUP565/GZwTY9Iw2ibdZ2+AkRxu9g0AfjFY5gsLYbpIt1PijSlyKsvrgzKas70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gWHy8Oyt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757850984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V7EEVogNqm3h2fGQuXoQvzBFJfVHtUlo6y8LaBgKxgU=;
	b=gWHy8OytRbrr+hxTPoJtG9xDbnqKkDF74kKE8rxEGti4rFBrSue7Q/T4bQt5boZbVlihiW
	eIUELjWG0tcyHnRXETW5s9mQejxFaMLvCqJC2OM30PyUyON4DxHiA7QixgFcdssc4lLH2w
	/UKidZzfZ5yjwuZTv9i8NkFOGZmIrl8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-j0OFLGfuNn-bJWhQlpUL3A-1; Sun, 14 Sep 2025 07:56:23 -0400
X-MC-Unique: j0OFLGfuNn-bJWhQlpUL3A-1
X-Mimecast-MFC-AGG-ID: j0OFLGfuNn-bJWhQlpUL3A_1757850983
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7ff94e5c251so910564885a.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 04:56:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757850983; x=1758455783;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V7EEVogNqm3h2fGQuXoQvzBFJfVHtUlo6y8LaBgKxgU=;
        b=s21uziWKmucmp1vcn30S5fnsUlbLLpXV/5P0zgm5ZLDTPibRFU7Fgs2cZx1KCHyqjS
         eTA/3HHa0Tkxs1GoRqNQGwiLGauwvEQo5pn6DaMznzPArlBXVq2M9C+UwR4QnH5dg42T
         oyE9fzRnJa6W0K1+jQc1hQNyDmcK66Jd6+uoSa5Hv41kg9Q94Ng1elC9j8QUqO4q09Hh
         9WrHCtqZ/Cd6bKT40EGGovakHizCZa+6oruGg0og3cua3YWpSZYXn63MsZpQLGBwOrRW
         KkSp8yW4DhwrMh67B7vvcNxgSRLfX49qHiIHqmQDWcmTHT2bsEGgITjHoqS8dhip6XMD
         AnDA==
X-Forwarded-Encrypted: i=1; AJvYcCVNADt4DsOeApWeZqwppUXVdeLAYVv+YVUu/C5VNHM8HgFLf7BI2XGzPl2qZRCL19Q2DbNH9IO2fR3pEaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIKbGmpf5VmCVpu/7IjXKa4a8lOONQ7RcDazbxa5x9MKpzhtzI
	2Ak4Ag5eXebRJ3BoCrge9CH3GShG2MXRPOdbfQWPxqHWptNRpz+GYzTjpSL4k+TnBBL2BOwexwq
	atzgPBdD5jkYKl583o6Etf4yDpRqjqbdP6vQ1Ti0ujvQfR2wQfvMhnCAx3G0sTPRomg==
X-Gm-Gg: ASbGncsh8sH/JRgXADNrnpbGvy9C7MJStAAxr5UWdp9Tw8WjpuigGMg0HszNkGVrJKh
	NvGYmAIZebqNa0D5fAqgykIo7espEx80z1wHMRpGndYA0kFSSaKYNbRI+p8AW04LOqrDLlcktYa
	7RSPFoj5frLDUchpbfkpmztpkMKVUw8Ri/zqKdZqITZIM3PxUx6JLGyp0icjOCAmZGEAfiAjCwg
	ojMT+dTzLEx4LWkZc84mHDBMiaZ9YKFVCBGmuw1Ze9zITZfU8jE0wprJ23zqqoXdAuVxyXbW8mW
	W89Ly0wqcQmbVN7/Rg9WTlx1Rjk+Qwr+DKvnBKZmlUDidyRUwucXcYZWix6ywArjHPrn7QfLSAU
	ZNHBFd+WDNGEIEfRlQHPuYTQhAWoZDU8=
X-Received: by 2002:a05:620a:414f:b0:7e8:8f35:1d2b with SMTP id af79cd13be357-81ff181374emr1624999985a.2.1757850982921;
        Sun, 14 Sep 2025 04:56:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjgXFxjwySPCU3ek1M0DJbAsGYTyjXrUec8xKOuYaZ+ALRKNikNG6Y3NJHY97G0hh6czoOhA==
X-Received: by 2002:a05:620a:414f:b0:7e8:8f35:1d2b with SMTP id af79cd13be357-81ff181374emr1624998885a.2.1757850982589;
        Sun, 14 Sep 2025 04:56:22 -0700 (PDT)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-820c974c848sm587652085a.23.2025.09.14.04.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 04:56:22 -0700 (PDT)
Date: Sun, 14 Sep 2025 07:56:20 -0400
From: Brian Masney <bmasney@redhat.com>
To: Iwona Winiarska <iwona.winiarska@intel.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
	openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] peci: controller: peci-aspeed: convert from round_rate()
 to determine_rate()
Message-ID: <aMatZAX6eFI1RmDH@redhat.com>
References: <20250810-peci-round-rate-v1-1-ec96d216a455@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250810-peci-round-rate-v1-1-ec96d216a455@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)

Hi Iwona, Joel, and Andrew,

On Sun, Aug 10, 2025 at 06:21:51PM -0400, Brian Masney wrote:
> The round_rate() clk ops is deprecated, so migrate this driver from
> round_rate() to determine_rate() using the Coccinelle semantic patch
> appended to the "under-the-cut" portion of the patch.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>

Would it be possible to get this picked up for v6.18? I'd like to remove
this API from drivers/clk in v6.19.

Thanks,

Brian


